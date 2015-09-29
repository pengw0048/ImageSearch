fn='Z:\images\pudding5.jpg';
outn=search(fn,vzft,v88,vhog,vlbp,listing);
for i=1:9
    subplot(3,3,i);
    imshow(imread(['images\' listing(outn(i)).name]));
end