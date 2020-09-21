% This code plot three statistics from analize WRF assimilated and not 

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

t=16;  % 10 am
t=28;  % 10 pm

for dom=1:2
    
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
    

for id=1:2

TRVC_075=eval(variables_assim{id});
TRVC_054=eval(variables{id});

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
axis xy
 
xlim([-79.5 -66.5])
ylim([-4.5 12.5])
h=colorbar;
ylabel(h,'unit')
colormap(summer)

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
 
xlim([-79.5 -66.5])
ylim([-4.5 12.5])
h=colorbar;
ylabel(h,'MFB')
colormap(redblue)
caxis([-1 1])
title(sprintf(strcat(Domain{dom},variables{id},' Mean Factorial Bias hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °')
ylabel('latitude °')


saveas(fig,strcat(Domain{dom},variables{id},'_MFB'),'jpg')

%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

fig=figure


imagesc(XLONG(:,1),XLAT(1,:),RMSE')

 hold on
 S1=shaperead('/run/media/dirac/Datos/Reciente_Dropbox/2018/SIG/MAUI.LatinAmerica.EPSG4326/MAUI.LatinAmerica.EPSG4326.shp')
 mapshow(S1,'facealpha',0, 'LineWidth',2)
 hold on
%  S2=shaperead('/home/dirac/Dropbox/2020/pan_adm_2020_shp/pan_admbnda_adm0_2020.shp')
%  mapshow(S2,'facealpha',0)
%  
axis xy
 
xlim([-79.5 -66.5])
ylim([-4.5 12.5])
h=colorbar;
ylabel(h,'RMSE')
colormap(flipud(hot))
title(sprintf(strcat(Domain{dom},variables{id},' Root Mean Square hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °')
ylabel('latitude °')


saveas(fig,strcat(Domain{dom},variables{id},'_RMSE'),'jpg')

%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


fig=figure


imagesc(XLONG(:,1),XLAT(1,:),CF')

 hold on
 S1=shaperead('/run/media/dirac/Datos/Reciente_Dropbox/2018/SIG/MAUI.LatinAmerica.EPSG4326/MAUI.LatinAmerica.EPSG4326.shp')
 mapshow(S1,'facealpha',0, 'LineWidth',2)
 hold on
%  S2=shaperead('/home/dirac/Dropbox/2020/pan_adm_2020_shp/pan_admbnda_adm0_2020.shp')
%  mapshow(S2,'facealpha',0)
 
axis xy
 
xlim([-79.5 -66.5])
ylim([-4.5 12.5])
h=colorbar;
ylabel(h,'CF')
colormap(jet)
title(sprintf(strcat(Domain{dom},variables{id},' Correlation factor hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °')
ylabel('latitude °')


saveas(fig,strcat(Domain{dom},variables{id},'_CF'),'jpg')

end


% figure
% 
% t1 = datetime(2020,08,18,0,0,0); t2 = datetime(2020,8,21,0,0,0);
% tt = t1:hours(1):t2;
% ti=tt';
% 
% % Put coordinates
% nx= 200;
% ny=150;
% 
% 
% if dom==1
% nx=118
% ny=182
% end
% 
% if dom==2
% nx=169
% ny=413
% end
% 
% 
% subplot(2,5,1)
% plot(ti,squeeze(Q2(nx,ny,:)))
% hold on
% plot(ti,squeeze(Q2_assim(nx,ny,:)))
% title(variables{1})
% 
% subplot(2,5,2)
% plot(ti,squeeze(T2(nx,ny,:)))
% hold on
% plot(ti,squeeze(T2_assim(nx,ny,:)))
% title(variables{2})
% 
% 
% subplot(2,5,3)
% plot(ti,squeeze(PSFC(nx,ny,:)))
% hold on
% plot(ti,squeeze(PSFC_assim(nx,ny,:)))
% title(variables{3})
% 
% subplot(2,5,4)
% plot(ti,squeeze(V10(nx,ny,:)))
% hold on
% plot(ti,squeeze(V10_assim(nx,ny,:)))
% title(variables{4})
% 
% subplot(2,5,5)
% plot(ti,squeeze(U10(nx,ny,:)))
% hold on
% plot(ti,squeeze(U10_assim(nx,ny,:)))
% title(variables{5})
% 
% % nx= 150;
% % ny=110;
% % 
% % subplot(2,5,6)
% % plot(ti,squeeze(Q2(nx,ny,:)))
% % hold on
% % plot(ti,squeeze(Q2_assim(nx,ny,:)))
% % title(variables{1})
% % 
% % subplot(2,5,7)
% % plot(ti,squeeze(T2(nx,ny,:)))
% % hold on
% % plot(ti,squeeze(T2_assim(nx,ny,:)))
% % title(variables{2})
% % 
% % 
% % subplot(2,5,8)
% % plot(ti,squeeze(PSFC(nx,ny,:)))
% % hold on
% % plot(ti,squeeze(PSFC_assim(nx,ny,:)))
% % title(variables{3})
% % 
% % subplot(2,5,9)
% % plot(ti,squeeze(V10(nx,ny,:)))
% % hold on
% % plot(ti,squeeze(V10_assim(nx,ny,:)))
% % title(variables{4})
% % 
% % subplot(2,5,10)
% % plot(ti,squeeze(U10(nx,ny,:)))
% % hold on
% % plot(ti,squeeze(U10_assim(nx,ny,:)))
% % title(variables{5})


end




%%  Time series plot part
close all

mydir='/run/media/dirac/Datos/Reciente_Dropbox/users/arjo/lotos-euros/Repositorio_Personal_Slopez/Personal/Metar/datos';
cd(mydir)


fig=figure
%datetime.setDefaultFormats('default','yyyy-MM-dd hh:mm:ss')
t1 = datetime(2020,08,17,19,0,0); t2 = datetime(2020,8,20,19,0,0);
t = t1:hours(1):t2;
t=t';

datos={'datos_Barranquilla.csv','datos_barrancabermeja.csv','datos_Bogota.csv','datos_cali.csv','datos_cartagena.csv','datos_Medellin.csv','datos_monteria.csv','datos_rioacha.csv','datos_SANTA_MARTA.csv','datos_valledupar.csv'};

T=readtable(datos{2});



% % Put coordinates
% nx= 200;
% ny=150;
% 
% subplot(2,5,1)
% plot(t,squeeze(Q2(nx,ny,:)))
% hold on
% plot(t,squeeze(Q2_assim(nx,ny,:)))
% title(variables{1})
% 
% subplot(2,5,2)
% plot(t,squeeze(T2(nx,ny,:))-273.5)
% hold on
% plot(t,squeeze(T2_assim(nx,ny,:)))
% title(variables{2})
% 
% 
% subplot(2,5,3)
% plot(t,squeeze(PSFC(nx,ny,:)))
% hold on
% plot(t,squeeze(PSFC_assim(nx,ny,:)))
% title(variables{3})
% 
% subplot(2,5,4)
% plot(t,squeeze(V10(nx,ny,:)))
% hold on
% plot(t,squeeze(V10_assim(nx,ny,:)))
% title(variables{4})
% 
% subplot(2,5,5)
% plot(t,squeeze(U10(nx,ny,:)))
% hold on
% plot(t,squeeze(U10_assim(nx,ny,:)))
% title(variables{5})
% 
% nx= 150;
% ny=110;
% 
% subplot(2,5,6)
% plot(t,squeeze(Q2(nx,ny,:)))
% hold on
% plot(t,squeeze(Q2_assim(nx,ny,:)))
% title(variables{1})
% 
% subplot(2,5,7)
% plot(t,squeeze(T2(nx,ny,:)))
% hold on
% plot(t,squeeze(T2_assim(nx,ny,:)))
% title(variables{2})
% 
% 
% subplot(2,5,8)
% plot(t,squeeze(PSFC(nx,ny,:)))
% hold on
% plot(t,squeeze(PSFC_assim(nx,ny,:)))
% title(variables{3})
% 
% subplot(2,5,9)
% plot(t,squeeze(V10(nx,ny,:)))
% hold on
% plot(t,squeeze(V10_assim(nx,ny,:)))
% title(variables{4})
% 
% subplot(2,5,10)
% plot(t,squeeze(U10(nx,ny,:)))
% hold on
% plot(t,squeeze(U10_assim(nx,ny,:)))
% title(variables{5})
% 
% 
% saveas(fig,'D2_time_series','jpg')







for i =1:5
    
    
    
     % Put coordinates
nx= i*50;
ny=500-i*60;

subplot(5,5,5*(i-1)+1)
plot(t,squeeze(Q2(nx,ny,:)))
hold on
plot(t,squeeze(Q2_assim(nx,ny,:)))
title(variables{1})

subplot(5,5,5*(i-1)+2)
plot(t,squeeze(T2(nx,ny,:))-273.5)
hold on
plot(t,squeeze(T2_assim(nx,ny,:))-273.5)
title(variables{2})


subplot(5,5,5*(i-1)+3)
plot(t,squeeze(PSFC(nx,ny,:)))
hold on
plot(t,squeeze(PSFC_assim(nx,ny,:)))
title(variables{3})

subplot(5,5,5*(i-1)+4)
plot(t,squeeze(V10(nx,ny,:)))
hold on
plot(t,squeeze(V10_assim(nx,ny,:)))
title(variables{4})

subplot(5,5,5*(i-1)+5)
plot(t,squeeze(U10(nx,ny,:)))
hold on
plot(t,squeeze(U10_assim(nx,ny,:)))
title(variables{5})

end