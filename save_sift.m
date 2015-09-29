ttl=128*10;
listing=dir('Z:\images\');
listing=listing(3:length(listing));
n=length(listing);
vsift=zeros(n,ttl+2);
vsift(:,ttl+2)=1:n;
for i=1:n
    fprintf('%g of %g\n',i,n)
        Ib=imread(['Z:\images\' listing(i).name]);
        Ib = imresize(Ib,[128,128]);
        if(size(size(Ib),2)==2)
            Ib(:,:,1)=Ib(:,:);
            Ib(:,:,2)=Ib(:,:,1);
            Ib(:,:,3)=Ib(:,:,1);
        end
        Imgb=single(rgb2gray(Ib));
    [~,db]=vl_sift(Imgb);
    if(size(db,2)>=10)
        db=db(:,1:10);
    else
        db=zeros(128,10);
    end
    vsift(i,1:ttl)=reshape(db,1,ttl);
end
save vsift.mat vsift;
