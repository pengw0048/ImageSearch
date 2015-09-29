ttl=59;
listing=dir('images\');
listing=listing(3:length(listing));
n=length(listing);
vlbp=zeros(n,ttl);
mapping=getmapping(8,'u2'); 
for i=1:n
    fprintf('%g of %g\n',i,n)
    vlbp(i,:)= LBP(['images\' listing(i).name],1,8,mapping,'nh');
end
save vlbp.mat vlbp;
