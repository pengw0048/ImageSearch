function ret=imread2(fn)
im=imread(fn);
if(size(size(im),2)==2)
    ret=im(ceil(size(im,1)*0.2):floor(size(im,1)*0.8),ceil(size(im,2)*0.2):floor(size(im,2)*0.8));
else
    ret=im(ceil(size(im,1)*0.2):floor(size(im,1)*0.8),ceil(size(im,2)*0.2):floor(size(im,2)*0.8),:);
end
end