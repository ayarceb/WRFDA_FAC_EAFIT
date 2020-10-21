%  Script time series variables RAINN
%  fechas 1 septiembre 00:00 - 4   WRF vs Precipitación IDEAM  



clc;close all;clear all

% coordinates El Dorado  4.7055833330,-74.15066667  longi=163 lati=136;

load Precipitacion.mat 

% coordinates J.M Cordova   6.17,-75.43     longi=120  lati=181

load PrecipitacionJMC.mat

% coordinates Palmira   3.5329916670,-76.3825     longi=109  lati=149

load Precipitacion_Palmira.mat

%coordinates Puerto nariño   -3.7803055560,-70.36263889    longi=59 lati=183

load ptonarino.mat

%coordinates Riohacha   11.52961111,-72.91766667    longi=151  lati=248

load Riohacha.mat





t1 = datetime(2020,09,1,0,0,0);
t2 = datetime(2020,09,4,0,0,0);
t = t1:hours(1):t2


% Assim D1

Rainn_D1_as=ncread('outfiled1.nc','RAINNC');
Rainn_D1_as_RAINC=ncread('outfiled1.nc','RAINC');
XLONG=ncread('outfiled1.nc','XLONG');
XLAT=ncread('outfiled1.nc','XLAT');

% No assim D1

Rainn_D1_na=ncread('output_FERMAT_test2_d01.nc','RAINNC');
Rainn_D1_na_RAINC=ncread('output_FERMAT_test2_d01.nc','RAINC');
% plot compare

figure

subplot(1,5,1)


longi=163;
lati=136;

plot(t,squeeze(Rainn_D1_as(longi,lati,:)+Rainn_D1_as_RAINC(longi,lati,:)))
hold on
plot(t,squeeze(Rainn_D1_na(longi,lati,:)+Rainn_D1_na_RAINC(longi,lati,:)))
hold on

subplot(1,5,2)

longi=120;
lati=181;

plot(t,squeeze(Rainn_D1_as(longi,lati,:)+Rainn_D1_as_RAINC(longi,lati,:)))
hold on
plot(t,squeeze(Rainn_D1_na(longi,lati,:)+Rainn_D1_na_RAINC(longi,lati,:)))
hold on



subplot(1,5,3)

longi=109;
lati=149;

plot(t,squeeze(Rainn_D1_as(longi,lati,:)+Rainn_D1_as_RAINC(longi,lati,:)))
hold on
plot(t,squeeze(Rainn_D1_na(longi,lati,:)+Rainn_D1_na_RAINC(longi,lati,:)))
hold on


subplot(1,5,4)

longi=59;
lati=183;

plot(t,squeeze(Rainn_D1_as(longi,lati,:)+Rainn_D1_as_RAINC(longi,lati,:)))
hold on
plot(t,squeeze(Rainn_D1_na(longi,lati,:)+Rainn_D1_na_RAINC(longi,lati,:)))
hold on



subplot(1,5,5)

longi=151;
lati=248;

plot(t,squeeze(Rainn_D1_as(longi,lati,:)+Rainn_D1_as_RAINC(longi,lati,:)))
hold on
plot(t,squeeze(Rainn_D1_na(longi,lati,:)+Rainn_D1_na_RAINC(longi,lati,:)))
hold on




% El Dorado
aux=zeros(1,96); 
aux(1,1)=0;
aux(1,2)=0;

% J.M Cordova

aux_J_M=zeros(1,96); 
aux_J_M(1,1)=0;
aux_J_M(1,2)=0;


% Palmira

aux_P=zeros(1,96); 
aux_P(1,1)=0;
aux_P(1,2)=0;

% Pto Nariño

aux_Pn=zeros(1,96); 
aux_Pn(1,1)=0;
aux_Pn(1,2)=0;



% Riohacha

aux_R=zeros(1,96); 
aux_R(1,1)=0;
aux_R(1,2)=0;

for i=2:73

    aux(1,i)=aux(1,i)+Precipitacion_1hora(i);
    aux(1,i+1)=aux(1,i);
    
    
      aux_J_M(1,i)=aux_J_M(1,i)+Precipitacion_J_M_C(i);
    aux_J_M(1,i+1)=aux_J_M(1,i);
    
    
      aux_P(1,i)=aux_P(1,i)+Valor(i);
    aux_P(1,i+1)=aux_P(1,i);
    
    aux_Pn(1,i)=aux_Pn(1,i)+Ptonarino(i);
    aux_Pn(1,i+1)=aux_Pn(1,i);
    
    
    aux_R(1,i)=aux_R(1,i)+Ptonarino(i);
    aux_R(1,i+1)=aux_R(1,i);
    
end
subplot(1,5,1)
plot(t,aux(1:73))
legend('Assimilating','No assimilating')
title('El DORADO')
grid on
ylim([1 20])

subplot(1,5,2)
plot(t,aux_J_M(1:73))
legend('Assimilating','No assimilating')
title('Jose Maria Cordova')
grid on
ylim([1 20])

subplot(1,5,3)
plot(t,aux_P(1:73))
legend('Assimilating','No assimilating')
title('Palmira')
grid on

subplot(1,5,4)
plot(t,aux_Pn(1:73))
legend('Assimilating','No assimilating')
title('Puerto Nariño')
grid on


subplot(1,5,5)
plot(t,aux_R(1:73))
legend('Assimilating','No assimilating')
title('Riohacha')
grid on


