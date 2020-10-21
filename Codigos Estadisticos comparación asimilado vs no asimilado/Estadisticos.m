% Function to calculate statisticals MFB, CF, RMSE for two pair of matrix (n x m)

function Estad=Estadisticos(V_assim,V_nassim,XLONG,XLAT,t,levels,dom,XTIME)

variables_assim={'Q2_assim','T2_assim','PSFC_assim','V10_assim','U10_assim'}
variables={' Q2',' T2',' PSFC',' V10',' U10'}
Domain={'D1 ',' D2 '}


% id puede ir hasta 5 esta variable se refiere a las variables disponibles

id=1;
for l=1:id

% V_assim=eval(variables_assim{l});   % variables asimiladas
% V_nassim=eval(variables{l});         % variables no asimiladas
size(V_assim)

for i=1:size(XLONG(:,1),1)
    for j=1:size(levels')       
        %===MFB===
        FB(i,j,1)=2*((((squeeze(V_assim(i,j,t))))-(squeeze(V_nassim(i,j,t))))/((squeeze(V_assim(i,j,t))+(squeeze(V_nassim(i,j,t))))));
%         %===RMSE===
           RMSE(i,j)=sqrt(immse(V_nassim(i,j,t),cast(V_assim(i,j,t),'like',V_nassim(i,j,t))));
% % %         %===Correlation Factor===
         Ycf=corrcoef(V_nassim(i,j,:),V_assim(i,j,:));
         CF(i,j)=Ycf(1,2);
    end
end
size(FB)
%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
fig=figure
subplot(1,3,1)
imagesc(squeeze(V_assim(:,:,t))')
 hold on
%  S1=shaperead('/run/media/dirac/Datos/Reciente_Dropbox/2018/SIG/MAUI.LatinAmerica.EPSG4326/MAUI.LatinAmerica.EPSG4326.shp')
%  mapshow(S1,'facealpha',0, 'LineWidth',2)
%  hold on
%  S2=shaperead('/home/dirac/Dropbox/2020/pan_adm_2020_shp/pan_admbnda_adm0_2020.shp')
%  mapshow(S2,'facealpha',0, 'LineWidth',1)
%  
axis xy; 
% xlim([-79.5 -66.5]);ylim([-4.5 12.5])
h=colorbar; ylabel(h,'unit'); colormap(redblue);caxis([-10 5]);

title(sprintf(strcat(Domain{dom},variables{l},' assim hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °')
ylabel('latitude °')

saveas(fig,strcat(Domain{dom},variables_assim{l}),'jpg')

%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



subplot(1,3,2)
imagesc(V_nassim(:,:,t)')

%  hold on
%  S1=shaperead('/run/media/dirac/Datos/Reciente_Dropbox/2018/SIG/MAUI.LatinAmerica.EPSG4326/MAUI.LatinAmerica.EPSG4326.shp')
%  mapshow(S1,'facealpha',0, 'LineWidth',2)
%  hold on
%  S2=shaperead('/home/dirac/Dropbox/2020/pan_adm_2020_shp/pan_admbnda_adm0_2020.shp')
%  mapshow(S2,'facealpha',0, 'LineWidth',1)
% %  
axis xy
%  
% xlim([-79.5 -66.5])
% ylim([-4.5 12.5])
h=colorbar;
ylabel(h,'unit')
colormap(summer);caxis([-10 5]);

title(sprintf(strcat(Domain{dom},variables{l},' hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °')
ylabel('latitude °')



%---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

subplot(1,3,3)

imagesc(FB')

hold on
% S1=shaperead('/run/media/dirac/Datos/Reciente_Dropbox/2018/SIG/MAUI.LatinAmerica.EPSG4326/MAUI.LatinAmerica.EPSG4326.shp')
% mapshow(S1,'facealpha',0, 'LineWidth',2)
% hold on
%  S2=shaperead('/home/dirac/Dropbox/2020/pan_adm_2020_shp/pan_admbnda_adm0_2020.shp')
%  mapshow(S2,'facealpha',0, 'LineWidth',1)
% % %  
axis xy
 
% xlim([-79.5 -66.5]);ylim([-4.5 12.5]);
h=colorbar;ylabel(h,'MFB');colormap(redblue);caxis([-2 2]);
title(sprintf(strcat(Domain{dom},variables{id},' Mean Factorial Bias hour=%i'),(XTIME(t)/60)-5));
% xlabel('longitude °');ylabel('latitude °');

saveas(fig,strcat(Domain{dom},variables{l},'_MFB'),'jpg')

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
h=colorbar;ylabel(h,'RMSE');colormap(flipud(hot)),caxis([-10 5])
title(sprintf(strcat(Domain{dom},variables{id},' Root Mean Square hour=%i'),(XTIME(t)/60)-5));
xlabel('longitude °');ylabel('latitude °')

saveas(fig,strcat(Domain{dom},variables{l},'_RMSE'),'jpg')
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

saveas(fig,strcat(Domain{dom},variables{l},'_CF'),'jpg')
end
end