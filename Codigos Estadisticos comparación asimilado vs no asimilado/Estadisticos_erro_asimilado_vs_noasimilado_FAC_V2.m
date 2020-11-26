%  This code plot three statistics from analize WRF assimilated and not 
%  First part produce the statistic for the 2D map
%  Second part generate the time plot

clear all;close all;clc

% dom=1;
% XLONG_assim=ncread('outfileD1_asimilando.nc','XLONG');
% XLAT_assim=ncread('outfileD1_asimilando.nc','XLAT');
% Q2_assim=ncread('outfileD1_asimilando.nc','Q2');
% T2_assim=ncread('outfileD1_asimilando.nc','T2');
% PSFC_assim=ncread('outfileD1_asimilando.nc','PSFC');
% V10_assim=ncread('outfileD1_asimilando.nc','V10');
% U10_assim=ncread('outfileD1_asimilando.nc','U10');
% XTIME=ncread('outfileD1_asimilando.nc','XTIME');
% 
% XLONG=ncread('output_WRF_test_case_d01.nc','XLONG');
% XLAT=ncread('output_WRF_test_case_d01.nc','XLAT');
% Q2=ncread('output_WRF_test_case_d01.nc','Q2');
% T2=ncread('output_WRF_test_case_d01.nc','T2');
% PSFC=ncread('output_WRF_test_case_d01.nc','PSFC');
% V10=ncread('output_WRF_test_case_d01.nc','V10');
% U10=ncread('output_WRF_test_case_d01.nc','U10');


% dom=2;
% XLONG_assim=ncread('outfileD2_asimilando.nc','XLONG');
% XLAT_assim=ncread('outfileD2_asimilando.nc','XLAT');
% Q2_assim=ncread('outfileD2_asimilando.nc','Q2');
% T2_assim=ncread('outfileD2_asimilando.nc','T2');
% PSFC_assim=ncread('outfileD2_asimilando.nc','PSFC');
% V10_assim=ncread('outfileD2_asimilando.nc','V10');
% U10_assim=ncread('outfileD2_asimilando.nc','U10');
% XTIME=ncread('outfileD2_asimilando.nc','XTIME');
% 
% XLONG=ncread('output_WRF_test_case_d02.nc','XLONG');
% XLAT=ncread('output_WRF_test_case_d02.nc','XLAT');
% Q2=ncread('output_WRF_test_case_d02.nc','Q2');
% T2=ncread('output_WRF_test_case_d02.nc','T2');
% PSFC=ncread('output_WRF_test_case_d02.nc','PSFC');
% V10=ncread('output_WRF_test_case_d02.nc','V10');
% U10=ncread('output_WRF_test_case_d02.nc','U10');

% colormaps
MAUI_10level=[1.0000    1.0000    1.0000;0.8392    0.8863    1.0000;0.4980    0.5882    1.0000;0.3882    0.4392    0.9686;0    0.3882    1.0000;1.0000    0.7765         0;1.0000    0.6275         0; 1.0000    0.4860    0.0000;1.0000    0.1115    0.0025];
Colorbar_CF=[255 255 255;255 255 159; 255 252 0; 255 149 0; 255 73 0; 255 0 0;159 0 0; 111 0 0; 61 0 0;3 0 0]/255;
Colorbar_MFB=[0 0  200;0 0 255; 0 147 255; 0 200 255; 0 255 255; 255 255 0;255 116 0; 200 0 0; 130 0 0;80 0 0]/255;

% Load nc results  id=1,2,3,4,5,
variables_assim={'Q2_assim','T2_assim','PSFC_assim','V10_assim','U10_assim'}
variables={' Q2',' T2',' PSFC',' V10',' U10'}
Domain={'D1 ',' D2 '}

% Calculate statistics

% La selección de t depende de UTC
%t=16;  % 10 am
t=28;  % 10 pm

% id selecciona entre {' Q2',' T2',' PSFC',' V10',' U10'}
id=2;


for dom=1:2
    mydir='/home/dirac/Dropbox/Andrés Yarce Botero/2020/WRF_FAC/1er Experimento';
cd(mydir)

    if dom==1
    XLONG_assim=ncread('outfileD1_asimilando.nc','XLONG');
XLAT_assim=ncread('outfileD1_asimilando.nc','XLAT');
Q2_assim=ncread('outfileD1_asimilando.nc','Q2');
T2_assim=ncread('outfileD1_asimilando.nc','T2');
PSFC_assim=ncread('outfileD1_asimilando.nc','PSFC');
V10_assim=ncread('outfileD1_asimilando.nc','V10');
U10_assim=ncread('outfileD1_asimilando.nc','U10');
XTIME=ncread('outfileD1_asimilando.nc','XTIME');

XLONG=ncread('output_WRF_test_case_d01.nc','XLONG');
XLAT=ncread('output_WRF_test_case_d01.nc','XLAT');
Q2=ncread('output_WRF_test_case_d01.nc','Q2');
T2=ncread('output_WRF_test_case_d01.nc','T2');
PSFC=ncread('output_WRF_test_case_d01.nc','PSFC');
V10=ncread('output_WRF_test_case_d01.nc','V10');
U10=ncread('output_WRF_test_case_d01.nc','U10');
    
    end
    if dom==2
        XLONG_assim=ncread('outfileD2_asimilando.nc','XLONG');
XLAT_assim=ncread('outfileD2_asimilando.nc','XLAT');
Q2_assim=ncread('outfileD2_asimilando.nc','Q2');
T2_assim=ncread('outfileD2_asimilando.nc','T2');
PSFC_assim=ncread('outfileD2_asimilando.nc','PSFC');
V10_assim=ncread('outfileD2_asimilando.nc','V10');
U10_assim=ncread('outfileD2_asimilando.nc','U10');
XTIME=ncread('outfileD2_asimilando.nc','XTIME');

XLONG=ncread('output_WRF_test_case_d02.nc','XLONG');
XLAT=ncread('output_WRF_test_case_d02.nc','XLAT');
Q2=ncread('output_WRF_test_case_d02.nc','Q2');
T2=ncread('output_WRF_test_case_d02.nc','T2');
PSFC=ncread('output_WRF_test_case_d02.nc','PSFC');
V10=ncread('output_WRF_test_case_d02.nc','V10');
U10=ncread('output_WRF_test_case_d02.nc','U10');
    end
   
   
    
% id puede ir hasta 5 esta variable se refiere a las variables disponibles
for l=id:id

TRVC_075=eval(variables_assim{l});   % variables asimiladas
TRVC_054=eval(variables{l});         % variables no asimiladas

for i=1:size(XLONG(:,1),1)
    for j=1: size(XLAT(1,:),2)       
        %===MFB===
        FB(i,j,1)=2*((((squeeze(TRVC_075(i,j,t))))-(squeeze(TRVC_054(i,j,t))))/((squeeze(TRVC_075(i,j,t))+(squeeze(TRVC_054(i,j,t))))));
%         %===RMSE===
           RMSE(i,j)=sqrt(immse(TRVC_054(i,j,t),cast(TRVC_075(i,j,t),'like',TRVC_054(i,j,t))));
% % %         %===Correlation Factor===
         Ycf=corrcoef(TRVC_054(i,j,:),TRVC_075(i,j,:));
         CF(i,j)=Ycf(1,2);
    end
end
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fig=figure
imagesc(XLONG(:,1),XLAT(1,:),squeeze(TRVC_075(:,:,t))')
 hold on
 S1=shaperead('/run/media/dirac/Datos/Reciente_Dropbox/2018/SIG/MAUI.LatinAmerica.EPSG4326/MAUI.LatinAmerica.EPSG4326.shp')
 mapshow(S1,'facealpha',0, 'LineWidth',2)
%  hold on
%  S2=shaperead('/home/dirac/Dropbox/2020/pan_adm_2020_shp/pan_admbnda_adm0_2020.shp')
%  mapshow(S2,'facealpha',0, 'LineWidth',1)
% %  
axis xy; xlim([-79.5 -66.5]);ylim([-4.5 12.5])
h=colorbar; ylabel(h,'unit'); colormap(summer)

title(sprintf(strcat(Domain{dom},variables{id},' assim hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °')
ylabel('latitude °')

saveas(fig,strcat(Domain{dom},variables_assim{id}),'jpg')

%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

fig=figure


imagesc(XLONG(:,1),XLAT(1,:),TRVC_054(:,:,t)')

 hold on
 S1=shaperead('/run/media/dirac/Datos/Reciente_Dropbox/2018/SIG/MAUI.LatinAmerica.EPSG4326/MAUI.LatinAmerica.EPSG4326.shp')
 mapshow(S1,'facealpha',0, 'LineWidth',2)
 hold on
%  S2=shaperead('/home/dirac/Dropbox/2020/pan_adm_2020_shp/pan_admbnda_adm0_2020.shp')
%  mapshow(S2,'facealpha',0, 'LineWidth',1)
% %  
axis xy
 
xlim([-79.5 -66.5])
ylim([-4.5 12.5])
h=colorbar;
ylabel(h,'unit')
colormap(summer)

title(sprintf(strcat(Domain{dom},variables{id},' hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °')
ylabel('latitude °')

saveas(fig,strcat(Domain{dom},variables{id}),'jpg')

%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

fig=figure

imagesc(XLONG(:,1),XLAT(1,:),FB')

hold on
S1=shaperead('/run/media/dirac/Datos/Reciente_Dropbox/2018/SIG/MAUI.LatinAmerica.EPSG4326/MAUI.LatinAmerica.EPSG4326.shp')
mapshow(S1,'facealpha',0, 'LineWidth',2)
hold on
%  S2=shaperead('/home/dirac/Dropbox/2020/pan_adm_2020_shp/pan_admbnda_adm0_2020.shp')
%  mapshow(S2,'facealpha',0, 'LineWidth',1)
% % %  
axis xy
 
xlim([-79.5 -66.5]);ylim([-4.5 12.5]);h=colorbar;ylabel(h,'MFB');colormap(redblue);caxis([-1 1]);
title(sprintf(strcat(Domain{dom},variables{id},' Mean Factorial Bias hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °');ylabel('latitude °');

saveas(fig,strcat(Domain{dom},variables{id},'_MFB'),'jpg')

%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

fig=figure

imagesc(XLONG(:,1),XLAT(1,:),RMSE')

hold on
S1=shaperead('/run/media/dirac/Datos/Reciente_Dropbox/2018/SIG/MAUI.LatinAmerica.EPSG4326/MAUI.LatinAmerica.EPSG4326.shp')
mapshow(S1,'facealpha',0, 'LineWidth',2);hold on
%  S2=shaperead('/home/dirac/Dropbox/2020/pan_adm_2020_shp/pan_admbnda_adm0_2020.shp')
%  mapshow(S2,'facealpha',0)

axis xy

xlim([-79.5 -66.5]);ylim([-4.5 12.5]);
h=colorbar;ylabel(h,'RMSE');colormap(flipud(hot))
title(sprintf(strcat(Domain{dom},variables{id},' Root Mean Square hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °');ylabel('latitude °')

saveas(fig,strcat(Domain{dom},variables{id},'_RMSE'),'jpg')
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fig=figure

imagesc(XLONG(:,1),XLAT(1,:),CF')

hold on
S1=shaperead('/run/media/dirac/Datos/Reciente_Dropbox/2018/SIG/MAUI.LatinAmerica.EPSG4326/MAUI.LatinAmerica.EPSG4326.shp')
mapshow(S1,'facealpha',0, 'LineWidth',2);hold on
%  S2=shaperead('/home/dirac/Dropbox/2020/pan_adm_2020_shp/pan_admbnda_adm0_2020.shp')
%  mapshow(S2,'facealpha',0)
 
axis xy
 
xlim([-79.5 -66.5]);ylim([-4.5 12.5])
h=colorbar;ylabel(h,'CF');colormap(jet)
title(sprintf(strcat(Domain{dom},variables{id},' Correlation factor hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °');ylabel('latitude °')

saveas(fig,strcat(Domain{dom},variables{id},'_CF'),'jpg')

end

%% Time line graphics vs METAR

% coordinates cities with 12 METAR with WRF assimilated and not
% assimilated


lati=[10.46314,3.42158,11.233,11.533,8.75,6.217,10.4,4.60971,7.0652800,10.96854];
longi=[-73.25322,-76.5205,-74.2,-72.9,-75.883,-75.567,-75.5,-74.08175,-73.8547200,-74.78132];
datos={'datos_valledupar.csv','datos_cali.csv','datos_SANTA_MARTA.csv','datos_rioacha.csv','datos_monteria.csv',...
    'datos_Medellin.csv','datos_cartagena.csv','datos_Bogota.csv','datos_barrancabermeja.csv','datos_Barranquilla.csv'};
nombres_ciudades={'Valledupar','Cali','Santa Marta','Riohacha','Monteria','Medellin','Cartagena','Bogotá','Barrancabermeja'...
    'Barranquilla'};
nx=zeros(length(lati),1);ny=zeros(length(longi),1);
fig=figure;
for ind =1:10


    x/users/arjo/lotos-euros/Repositorio_Personal_Slopez/Personal/Metar/Segunda_Fecha/SIATA/Temperature';
    cd(mydir)
    
    TT=readtable('estacion_data_temperatura_1019__20200801_20200831.csv');
    TT.Temperatura(TT.Temperatura<0)=nan;
    plot(TT.fecha_hora(24481+300:28801+300),TT.Temperatura(24481:28801),'go', 'MarkerFaceColor', 'g','MarkerSize', 2);
    legend("No asimilado","Asimilado","Temperatura METAR","SIATA")
    mydir='/run/media/dirac/Datos/Reciente_Dropbox/users/arjo/lotos-euros/Repositorio_Personal_Slopez/Personal/Metar/datos';
    cd(mydir)
end

title(sprintf(strcat(Domain{dom},' ',variables{id},'  -  ',nombres_ciudades{ind})));
xlabel('Time')
ylabel('Celsius °')

saveas(fig,strcat(Domain{dom},' ',nombres_ciudades{ind}),'jpg')
grid on
end

if id==3
NA=plot(tt,squeeze(PSFC(nx(ind,1),ny(ind,1),:)));
hold on
A=plot(tt,squeeze(PSFC_assim(nx(ind,1),ny(ind,1),:)));
title(variables{2})
hold on
plot(T.D,T.P*3386.39,'o', 'MarkerFaceColor', 'b','MarkerSize', 4)     
title(sprintf(strcat(Domain{dom},' ',variables{id},'  -  ',nombres_ciudades{ind})));
xlabel('Time')
ylabel('Pa')
legend("No asimilado","Asimilado","Presion superficie METAR")
saveas(fig,strcat(Domain{dom},' ',nombres_ciudades{ind}),'jpg')
grid on
end

end

end