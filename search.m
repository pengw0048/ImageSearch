function [outn gpm]=search(fn,vzft,v88,vhog,vlbp,listing)
mapping=getmapping(8,'u2'); 
pwr=1;

n=size(vzft,1);
gpm=zeros(n,4);
szft=zft(fn);
s88=haha(fn);
shog=reshape(ImgHOGFeature(fn),1,36*9);
slbp=LBP(fn,1,8,mapping,'nh');
pzft=[1:n;zeros(1,n)]';
p88=[1:n;zeros(1,n)]';
phog=[1:n;zeros(1,n)]';
plbp=[1:n;zeros(1,n)]';

% Ia=imread(fn);
% Ia = imresize(Ia,[128,128]);
% Imga=single(rgb2gray(Ia));
% [fa, da] = vl_sift(Imga) ;

for i=1:n
    pzft(i,2)=nthroot(sum(abs(vzft(i,:)-szft).^pwr),pwr);
    p88(i,2)=nthroot(sum(abs(v88(i,:)-s88).^pwr),pwr);
    phog(i,2)=nthroot(sum(abs(vhog(i,:)-shog).^pwr),pwr);
    plbp(i,2)=nthroot(sum(abs(vlbp(i,:)-slbp).^pwr),pwr);
end

pzft=sortrows(pzft,2);
p88=sortrows(p88,2);
phog=sortrows(phog,2);
plbp=sortrows(plbp,2);

for i=1:n
    gpm(pzft(i,1),1)=i;
    gpm(p88(i,1),2)=i;
    gpm(phog(i,1),3)=i;
    gpm(plbp(i,1),4)=i;
end

count=[1:n;zeros(1,n)]';
for i=1:100
    count(pzft(i,1),2)=count(pzft(i,1),2)+1-0.01*i;
    count(p88(i,1),2)=count(p88(i,1),2)+1-0.01*i;
    count(phog(i,1),2)=count(phog(i,1),2)+1-0.01*i;
    count(plbp(i,1),2)=count(plbp(i,1),2)+1-0.01*i;
end
count(:,2)=-count(:,2);
count=sortrows(count,2);

outn=count(:,1);

end