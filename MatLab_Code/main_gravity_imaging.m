%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A wavenumber-domain iterative approach for rapid 3-D imaging of gravity anomalies and gradients.
% Author: Lianghui Guo (guolh@cugb.edu.cn), Yatong Cui
% Organization: China University of Geosciences (Beijing), School of Geophysics and Information Technology
% Compiled version: MATLAB R2017b
% Reference:
%       Cui Y T, Guo L H. A wavenumber-domain iterative approach for rapid 3-D imaging
%       of gravity anomalies and gradients. IEEE Access, 2019, 7: 34179-34188.
% Description of the input parameters: 
%       infile_ano: observed anomaly, unit: mGal
%       n: power of vertical derivative, n¡Ê[1,10]
%       N: depth scaling factor£¬N¡Ý1
%       zmin, zmax: range of imaging depth direction
%       dz: spacing of depth direction
%       iter: number of iterations
%       p1, p2: physical property range constraint, unit: g/cm^3
% Description of the output parameters: 
%       outfile_msh: imaging model mesh file
%       outfile_mod: imaging model property file, unit: g/cm^3
%       outfile_rms: root mean square file, unit: mGal
%       outfile_res: residual anomaly file, unit: mGal
%       outfile_for: calculated anomaly file, unit: mGal
% Description of primary identifiers£º
%       x, y: x, y verctor
%       nx, ny: number of points in x and y directions
%       dx, dy: spacing in x and y directions
%       npts: extension points
%       G: gravitational constant, unit: m^3/kg¡¤s^2
%       kx, ky, k: wavenumber
%       obs: observed anomaly
%       cal: calculated anomaly
%       pcal: imaging model
%       dp: density disturbance
%       res: residual anomaly
%       error: root mean square
% Description of subroutine function: 
%       readgrd.m: read surfer text grd file
%       wave2d.m: calculate wavenumber
%       imaging_Uz.m: imaging
%       forward_Uz.m: forward
%       extend_copy2d.m: copy edge extension
%       property.m: physical property range constraint
%       savebln.m: save rms file
%       savegrd.m: save surfer text grd file
%       savemod.m: save model file
%       savemsh.m: save mesh file      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;
%%%%%%%%%%%% I/O parameters %%%%%%%%%%%%%
infile_ano = 'Uz_2D.grd'; 
n = 4;
N = 2.5; 
zmin = 0; zmax = 2000; 
dz = 50; 
iter = 5;
p1 = 0; p2 = 1; 
outfile_msh = 'img_model.msh';
outfile_mod = 'img_model.mod'; 
outfile_rms = 'img_model_rms.bln'; 
outfile_res = 'img_model_res.grd'; 
outfile_for = 'img_model_for.grd'; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[obs,x,y,nx,ny,dx,dy] = readgrd(infile_ano);
nz = floor((zmax-zmin)/dz+1); z = zmin:dz:zmax;
nmax = max([nx ny]);
npts = 2^nextpow2(nmax);
G = 6.67e-11; error = zeros(iter,1);
p1 = p1*1000; p2 = p2*1000;
% imaging
[k,kx,ky] = wave2d(npts,dx,dy);
pcal = imaging_Uz(obs,G,n,N,nx,ny,nz,dz,z,npts,k,kx,ky); 
pcal = property(pcal,nx,ny,nz,p1,p2); 
cal = forward_Uz(pcal,G,nx,ny,nz,dz,z,npts,k,kx,ky); 
res = obs-cal;
for i = 1:iter
    dp = imaging_Uz(res,G,n,N,nx,ny,nz,dz,z,npts,k,kx,ky);
    pcal = pcal+dp;
    pcal = property(pcal,nx,ny,nz,p1,p2);
    cal = forward_Uz(pcal,G,nx,ny,nz,dz,z,npts,k,kx,ky); 
    res = obs-cal; 
    error(i) = rms(res(:));
 end
pcal = pcal/1000;
% save
savemsh(x,y,z,dx,dy,dz,nx,ny,nz,outfile_msh)
savemod(pcal,nx,ny,nz,outfile_mod);
savebln(error,outfile_rms);  
savegrd(res,x,y,nx,ny,outfile_res);
savegrd(cal,x,y,nx,ny,outfile_for);