function [gobs,x,y,nx,ny,dx,dy] = readgrd( infile )
fp=fopen(infile,'rt');
fscanf(fp,'%s',1);
nx=fscanf(fp,'%d',1);
ny=fscanf(fp,'%d',1);
xmin=fscanf(fp,'%g',1);
xmax=fscanf(fp,'%g',1);
ymin=fscanf(fp,'%g',1);
ymax=fscanf(fp,'%g',1);
fscanf(fp,'%g',2);
gobs=zeros(ny,nx);
for i=1:ny
    for j=1:nx
        gobs(i,j)=fscanf(fp,'%g',1);
    end
end
fclose(fp);
dx=((xmax-xmin)/(nx-1));
dy=((ymax-ymin)/(ny-1));
x=xmin:dx:xmax;
y=ymin:dy:ymax;
end

