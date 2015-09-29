ttl=36*9;
listing=dir('images\');
listing=listing(3:length(listing));
n=length(listing);
vhog=zeros(n,ttl);
for i=1:n
    fprintf('%g of %g\n',i,n)
    vhog(i,:)=reshape(ImgHOGFeature(['images\' listing(i).name]),1,ttl);
end
save vhog.mat vhog;
