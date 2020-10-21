% script to operate potential temperature

clc;close all;clear all

% theta = T + 300
% ptot = PB + P (total pressure = base pressure PB + perturbation pressure P)
% temp = theta*(ptot/1000)^(2/7)

longi=200;

XLONG=ncread('output_FERMAT_test2_d01.nc','XLONG');
XLAT=ncread('output_FERMAT_test2_d01.nc','XLAT');

T=ncread('outfiled1.nc','T');
theta=T+300;

P=ncread('outfileP_D1.nc','P');
PB=ncread('outfileP_D1.nc','PB');

ptot=(P+PB)*0.01;  % Pascales to mbar


temp = theta.*(ptot./1000).^(2/7);


alt=(41:1);
lon=XLONG(longi,1);

subplot(1,2,1)
imagesc(XLAT(1,:),alt,(squeeze(temp(longi,:,:,10))-273)');
colorbar
axis xy
colormap(jet)
%caxis([-20 5])
title(sprintf('T assimilated D1 longitude(°)=%f',lon))


