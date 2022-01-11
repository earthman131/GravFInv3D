function savemod(p,nx,ny,nz,outfile)
fp=fopen(outfile,'wt');
for i=1:ny
    for j=1:nx
        for k=1:nz
            fprintf(fp,'%f\n',p(i,j,k));
        end
    end
end
fclose(fp);
