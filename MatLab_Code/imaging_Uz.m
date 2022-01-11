function pcal = imaging_Uz(Uz,G,n,N,nx,ny,nz,dz,z,npts,k,kx,ky,pressfilter)
Uz=Uz*1e-5; 
ydiff=floor((npts-ny)/2); xdiff=floor((npts-nx)/2); 
Uzex=extend_copy2d(Uz,nx,ny,nz,npts);
Uzf=fftshift(fft2(Uzex));
pf=zeros(npts,npts,nz);
pcal=zeros(ny,nx,nz);
for K=1:nz
    zo=z(K)+dz/2;
    imgf=(1/(2*pi*G)).*((n+1)^(n+1)/(factorial(n))).*(zo/N)^n*k.^(n+1).*exp(-k*n*zo/N);
    pf(:,:,K)=Uzf.*imgf;
end
for K=1:nz
    pf(:,:,K)=ifft2(ifftshift(pf(:,:,K)));
    pcal(:,:,K)=real(pf((ydiff+1):(ydiff+ny),(xdiff+1):(xdiff+nx),K));
end