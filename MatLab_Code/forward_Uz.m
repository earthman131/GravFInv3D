function Uz = forward_Uz(p,G,nx,ny,nz,dz,z,npts,k,kx,ky)
pf=zeros(npts,npts,nz);anof=zeros(npts,npts,nz);
anoex=zeros(npts,npts);ano=zeros(ny,nx,nz);Uz=zeros(ny,nx);
ydiff=floor((npts-ny)/2); xdiff=floor((npts-nx)/2); 
pex=extend_copy2d(p,nx,ny,nz,npts);
for i = 1:nz
    pf(:,:,i)=fftshift(fft2(pex(:,:,i)));
end
for K=1:nz
    h1=z(K); 
    h2=z(K)+dz;
    anof(:,:,K)=pf(:,:,K).*((2*pi*G+eps)./(k+eps)).*(exp(-k*h1)-exp(-k*h2)); 
end
for K=1:nz
    anoex(:,:,K)=ifft2(ifftshift(anof(:,:,K)));
    ano(:,:,K)=real(anoex((ydiff+1):(ydiff+ny),(xdiff+1):(xdiff+nx),K))*1e5;
    Uz(:,:)=Uz(:,:)+(ano(:,:,K));
end