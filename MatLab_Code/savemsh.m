function savemsh(x,y,z,dx,dy,dz,nx,ny,nz,outfile)
fp=fopen(outfile,'wt');
fprintf(fp,'%d\t%d\t%d\n',nx,ny,nz);
fprintf(fp,'%f\t%f\t%f\n',min(x(:))-dx/2,min(y(:))-dy/2,min(z(:))+dz/2);
fprintf(fp,'%d*%g\n',nx,dx);
fprintf(fp,'%d*%g\n',ny,dy);
fprintf(fp,'%d*%g\n',nz,dz);
fclose(fp);