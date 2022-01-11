function savegrd(ano,x,y,nx,ny,outfile)
fp=fopen(outfile,'wt');
fprintf(fp,'DSAA\n');
fprintf(fp,'%d %d\n',nx,ny);
fprintf(fp,'%g %g\n',min(x(:)),max(x(:)));
fprintf(fp,'%g %g\n',min(y(:)),max(y(:)));
fprintf(fp,'%g %g\n',min(ano(:)),max(ano(:)));
for i=1:ny
    for j=1:nx
        fprintf(fp,'%g ',ano(i,j));
    end
    fprintf(fp,'\n');
end
fclose(fp);
end

