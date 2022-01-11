function pex = extend_copy2d(p,nx,ny,nz,npts)
if length(size(p))==3
    pex=zeros(npts,npts,nz);
    ydiff=floor((npts-ny)/2);
    xdiff=floor((npts-nx)/2);
    pex((ydiff+1):(ydiff+ny),(xdiff+1):(xdiff+nx),:)=p;
    for i=1:ydiff
        pex(i,:,:)=pex(1+ydiff,:,:);
    end
    for i=(ydiff+ny+1):npts
        pex(i,:,:)=pex(ny+ydiff,:,:);
    end
    for i=1:xdiff
        pex(:,i,:)=pex(:,1+xdiff,:);
    end
    for i=(xdiff+nx+1):npts
        pex(:,i,:)=pex(:,xdiff+nx,:);
    end
end
if length(size(p))==2
    pex=zeros(npts,npts);
    ydiff=floor((npts-ny)/2);
    xdiff=floor((npts-nx)/2);
    pex((ydiff+1):(ydiff+ny),(xdiff+1):(xdiff+nx))=p;
    for i=1:ydiff
        pex(i,:,:)=pex(1+ydiff,:,:);
    end
    for i=(ydiff+ny+1):npts
        pex(i,:,:)=pex(ny+ydiff,:,:);
    end
    for i=1:xdiff
        pex(:,i,:)=pex(:,1+xdiff,:);
    end
    for i=(xdiff+nx+1):npts
        pex(:,i,:)=pex(:,xdiff+nx,:);
    end
end
