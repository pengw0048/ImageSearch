ttl=8*8*3;
listing=dir('images\');
listing=listing(3:length(listing));
n=length(listing);
v88=zeros(n,ttl);
for i=1:n
    fprintf('%g of %g\n',i,n)
    v88(i,:)=haha(['images\' listing(i).name]);
end
save v88.mat v88;
save listing.mat listing;
