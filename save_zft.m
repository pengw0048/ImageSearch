ttl=512;
listing=dir('images\');
listing=listing(3:length(listing));
n=length(listing);
vzft=zeros(n,ttl);
for i=1:n
    fprintf('%g of %g\n',i,n)
    vzft(i,:)=zft(['images\' listing(i).name]);
end
save 'vzft.mat' vzft;
