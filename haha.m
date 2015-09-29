function ret=haha(fn)

img = imresize(double(imread2(fn)),[8 8]);
if(size(size(img),2)==2)
    img(:,:,1)=img(:,:);
    img(:,:,2)=img(:,:,1);
    img(:,:,3)=img(:,:,1);
end
ret=reshape(img,1,192);

end