% plot sound from 4 location for the 1 september


clc;clear all;close all


variable={'PRES','HGHT','TEMP','DWPT','RELH','MIXR','DRCT','SKNT','THTA','THTE','THTV'};


name={'Atmospheric Pressure ','Geopotential Height','Temperature','Dewpoint Temperature','Relative Humidity','Mixing Ratio',...
    'Wind Direction','Wind Speed','Potential Temperature','Equivalent Potential Temperature','Virtual Potential Temperature'};


unit={'[hPa]','[meter]','[celsius]','[celsius]','[%]','[gram/kilogram]','[degrees true]','[knot]','[kelvin]','[kelvin]','[kelvin]'};


%day 1
mydir='/home/dirac/Dropbox/2020/WRFDA_FAC_EAFIT/Sondas/Descarga_Sondas/new_download/raw/1_sept';
cd(mydir)

Curazao=readtable('78988.txt');
Barranquilla=readtable('80028.txt');
Palonegro=readtable('80094.txt');
Bogota=readtable('80222.txt');

Curazao1=Curazao{:,:};
Barranquilla1=Barranquilla{:,:};
Palonegro1=Palonegro{:,:};
Bogota1=Bogota{:,:};


for i=1:11
if(i~=2)
    if(i<2)
    
    
subplot(2,5,i)
    plot(Bogota1(:,i),Bogota1(:,2))
hold on
grid on
ylabel({'Altitude',unit{2}});
xlabel(unit{i});
    title({name{i},''});

    end
     if(i>2)
        
subplot(2,5,i-1)
    plot(Bogota1(:,i),Bogota1(:,2))
hold on
grid on
ylabel({'Altitude',unit{2}});
    xlabel(unit{i});
  title({name{i},''});
    end
end
sgtitle('Bogotá 2020')
end

mydir='/run/media/dirac/Datos/WRF_FAC/WRF_FAC/Comparacion Alturas/septiembre';
cd(mydir)

%lat 162  lon 130 Bogota

lati=162;
longi=130;
t=18;


HGT=ncread('20200901-00asimilando_d1.nc','HGT');
XLONG=ncread('output_FERMAT_test2_altura_d01.nc','XLONG_U');
XLAT=ncread('output_FERMAT_test2_altura_d01.nc','XLAT_U');
XTIME=ncread('output_FERMAT_test2_altura_d01.nc','XTIME');

U_na_d01=ncread('output_FERMAT_test2_altura_d01.nc','P');
U_a_d01=ncread('20200901-00asimilando_d1.nc','P');
l=1:1:41;

figure
subplot(1,4,1)
plot(squeeze(U_na_d01(longi,lati,:,t))',l)
hold on
plot(squeeze(U_a_d01(longi,lati,:,t))',l)
hold on
ylabel('levels')
title('P')
xlabel('Pa')
grid on
legend('no assim','assim')
axis xy

U_na_d01=ncread('output_FERMAT_test2_altura_d01.nc','T');
U_a_d01=ncread('20200901-00asimilando_d1.nc','T');

subplot(1,4,2)
plot(squeeze(U_na_d01(longi,lati,:,t))',l)
hold on
plot(squeeze(U_a_d01(longi,lati,:,t))',l)
hold on
ylabel('levels')
title('T')
xlabel('K')
grid on
legend('no assim','assim')
axis xy


U_na_d01=ncread('output_FERMAT_test2_altura_d01.nc','V');
U_a_d01=ncread('20200901-00asimilando_d1.nc','V');

subplot(1,4,3)
plot(squeeze(U_na_d01(longi,lati,:,t))',l)
hold on
plot(squeeze(U_a_d01(longi,lati,:,t))',l)
hold on
ylabel('levels')
xlabel('m/s')
title('V')
grid on
legend('no assim','assim')
axis xy


U_na_d01=ncread('output_FERMAT_test2_altura_d01.nc','U');
U_a_d01=ncread('20200901-00asimilando_d1.nc','U');

subplot(1,4,4)
plot(squeeze(U_na_d01(longi,lati,:,t))',l)
hold on
plot(squeeze(U_a_d01(longi,lati,:,t))',l)
hold on
ylabel('levels')
xlabel('m/s')
title('u')
grid on
legend('no assim','assim')
axis xy

