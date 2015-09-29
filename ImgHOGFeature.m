function HOGFeature = ImgHOGFeature( imgPathName, cell_size, nblock,...,
    overlap, angle, bin_num)
% 计算输入图像的特征描述子
% imgPathName：图片路径
% cell_size: cell的长宽
% nblock: block的width、height包括的cell的个数
% overlap: block重叠的比例
% angle: 180\360
% bin_num: 方向bin的数目
 
if nargin<2
    % default parameter
    cell_size=16;
    nblock=2;
    overlap=0.5;
    angle=180;
    bin_num=9;
elseif nargin<6
    error('Input parameters are not enough.');
end
 
Img = imread2(imgPathName);
if size(Img,3) == 3
    % 简化计算，直接转换成灰度图像
    G = rgb2gray(Img);
else
    G = Img;
end

G = imresize(G,[64,64]);
 
[height, width] = size(G);
 
% 计算x、y方向的梯度
hx = [-1,0,1];
hy = -hx';
grad_x = imfilter(double(G),hx);
grad_y = imfilter(double(G),hy);
 
% 计算梯度的模长
grad_mag=sqrt(grad_x.^2+grad_y.^2);
 
% 计算梯度的方向
index= grad_x==0;
grad_x(index)=1e-5;
YX=grad_y./grad_x;
if angle==180
    grad_angle= ((atan(YX)+(pi/2))*180)./pi; 
elseif angle==360
    grad_angle= ((atan2(grad_y,grad_x)+pi).*180)./pi;
end
 
% orient bin
bin_angle=angle/bin_num;
grad_orient=ceil(grad_angle./bin_angle);
 
% 计算block的个数
block_size=cell_size*nblock;
skip_step=block_size*overlap;
x_step_num=floor((width-block_size)/skip_step+1);
y_step_num=floor((height-block_size)/skip_step+1);
 
% 初始化hog特征描述子
feat_dim=bin_num*nblock^2;
HOGFeature=zeros(feat_dim,x_step_num*y_step_num);
 
for k=1:y_step_num
    for j=1:x_step_num
        % block的左上角坐标
        x_off = (j-1)*skip_step+1;
        y_off = (k-1)*skip_step+1;
 
        % 取得block的梯度大小和方向
        b_mag=grad_mag(y_off:y_off+block_size-1,x_off:x_off+block_size-1);
        b_orient=grad_orient(y_off:y_off+block_size-1,x_off:x_off+block_size-1);
 
        % 当前block的hog直方图
        currFeat = BinHOGFeature(b_mag, b_orient, cell_size,nblock, bin_num, false);
        HOGFeature(:, (k-1)*x_step_num+j) = currFeat;
 
    end
end
 
end

function blockfeat = BinHOGFeature( b_mag,b_orient,cell_size,nblock,...
    bin_num, weight_vote)
% 计算1个block的hog
% weight_vote: 是否进行高斯加权投票
 
% block的HOG直方图
blockfeat=zeros(bin_num*nblock^2,1);
 
% 高斯权重
gaussian_weight=fspecial('gaussian',cell_size*nblock,0.5*cell_size*nblock);
 
% 分割block
for n=1:nblock
    for m=1:nblock
        % cell的左上角坐标
        x_off = (m-1)*cell_size+1;
        y_off = (n-1)*cell_size+1;
 
        % cell的梯度大小和方向
        c_mag=b_mag(y_off:y_off+cell_size-1,x_off:x_off+cell_size-1);
        c_orient=b_orient(y_off:y_off+cell_size-1,x_off:x_off+cell_size-1);
 
        % cell的hog直方图
        c_feat=zeros(bin_num,1);
        for i=1:bin_num
            % 是否进行高斯加权 投票
            if weight_vote==false
                c_feat(i)=sum(c_mag(c_orient==i));
            else
                c_feat(i)=sum(c_mag(c_orient==i).*gaussian_weight(c_orient==i));
            end
        end
 
        % 合并到block的HOG直方图中
        count=(n-1)*nblock+m;
        blockfeat((count-1)*bin_num+1:count*bin_num,1)=c_feat;
    end
end
 
% 归一化 L2-norm
sump=sum(blockfeat.^2);
blockfeat = blockfeat./sqrt(sump+eps^2);

end