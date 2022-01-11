function [k,kx,ky] = wave2d(npts,dx,dy) 
k=zeros(npts,npts);kx=zeros(npts,npts);
ky=zeros(npts,npts);
wnx=(2*pi)/(dx*(npts-1)); wny=(2*pi)/(dy*(npts-1));
cx=npts/2+1; cy=npts/2+1; 
for I=1:npts
    for J= 1:npts
        ky(I,J)=(I-cy)*wny;
        kx(I,J)=(J-cx)*wnx;
        k(I,J)=sqrt(kx(I,J)*kx(I,J)+ky(I,J)*ky(I,J));
    end
end