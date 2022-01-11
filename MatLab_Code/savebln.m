function savebln(error,outfile) 
n = length(error);
fp=fopen(outfile,'wt');
fprintf(fp,'%d\t',n);
fprintf(fp,'%d\n',0);
for i=1:n
    fprintf(fp,'%d\t%f\n',i,error(i));
end
fclose(fp);