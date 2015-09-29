function hsv=zft(fn)

im = double(imread2(fn));
im=imresize(im,[128 128]);
if(size(size(im),2)==2)
    im(:,:,1)=im(:,:);
    im(:,:,2)=im(:,:,1);
    im(:,:,3)=im(:,:,1);
end
h0=im(:,:,1);
s0=im(:,:,2);
v0=im(:,:,3);

h1=fix(h0/32);
s1=fix(s0/32);
v1=fix(v0/32);

h1=h1-(h1==32);
s1=s1-(s1==32);
v1=v1-(v1==32);

hsv=zeros(1,512);
temp=h1*64+s1*8+v1;
for   i=0:511
    hsv(i+1)=length(find(temp==i));%计算每个区域中的符合颜色分量的像素的个数
end

end