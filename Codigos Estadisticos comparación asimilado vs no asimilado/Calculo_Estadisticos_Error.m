load no2_column_perturbed.mat
load no2_column_model.mat
load lon
load lat


for i=1:size(no2_column_model,1)
    for j=1:size(no2_column_model,2)        
        %===MFB===
        FB(i,j)=2*((mean(squeeze(no2_column_model(i,j,:)))-mean(no2_column(i,j,:)))/(mean(no2_column_model(i,j,:))+mean(no2_column(i,j,:))));
        %===RMSE===
        RMSE(i,j)=sqrt(immse(no2_column_model(i,j,:),cast(no2_column(i,j,:),'like',no2_column_model(i,j,:))));
        %===Correlation Factor===
        Ycf=corrcoef(no2_column_model(i,j,:),no2_column(i,j,:));
        CF(i,j)=Ycf(1,2);

    end
end
Colorbar_CF=[255 255 255;255 255 159; 255 252 0; 255 149 0; 255 73 0; 255 0 0;159 0 0; 111 0 0; 61 0 0;3 0 0]/255;
Colorbar_MFB=[0 0  200;0 0 255; 0 147 255; 0 200 255; 0 255 255; 255 255 0;255 116 0; 200 0 0; 130 0 0;80 0 0]/255;
S=shaperead('America.shp');


fig=figure;
imagesc(lon,lat,FB')
hold on 
mapshow(S,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.1, 'LineWidth',2)
axis ij
set(gca,'YDir','normal')
xlim([-79.8 -65.91])
ylim([-3.91 12.91])
colormap(Colorbar_MFB)
colorbar
title('Mean Fractional Bias','FontSize',14)
saveas(fig,'MFB','jpg')



fig=figure;
imagesc(lon,lat,RMSE')
hold on 
mapshow(S,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.1, 'LineWidth',2)
axis ij
set(gca,'YDir','normal')
xlim([-79.8 -65.91])
ylim([-3.91 12.91])
colormap(Colorbar_CF)
colorbar
title('Root Mean Square Error','FontSize',14)
saveas(fig,'RMSE','jpg')


fig=figure;
imagesc(lon,lat,CF')
hold on 
mapshow(S,'FaceColor',[0.9 0.9 0.9],'FaceAlpha',0.1, 'LineWidth',2)
axis ij
set(gca,'YDir','normal')
xlim([-79.8 -65.91])
ylim([-3.91 12.91])
colormap(Colorbar_CF)
colorbar
title('Correlation Factor','FontSize',14)
saveas(fig,'CF','jpg')