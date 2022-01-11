function pcal = property(pcal,nx,ny,nz,p1,p2)
for k=1:nz
    for i=1:ny
        for j=1:nx
            if pcal(i,j,k)<p1
                pcal(i,j,k)=p1;
            elseif pcal(i,j,k)>p2
                pcal(i,j,k)=p2;
            end
        end
    end
end

