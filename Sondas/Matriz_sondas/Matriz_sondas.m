% code to create matrix sounding data

clc;close all; clear all


% load sounding data


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

% extraer la velocidad y direccin para
% Bogotá
wind_dir_Bog=Bogota1(:,7);
wind_speed_Bog=Bogota1(:,8);

delta_t=100;

xx(1)=0;
yy(1)=0;
for i=1:50

vx(i)=wind_speed_Bog(i,1)*cos(wind_dir_Bog(i,1)*pi/180)*delta_t;   
vy(i)=wind_speed_Bog(i,1)*sin(wind_dir_Bog(i,1)*pi/180)*delta_t;   


% la primera se realiza con respecto a la condición inicial, en este caso
% (i=0) --> (0,0)
if(i==1)
plot([0 vx(i)],[0 vy(i)])
hold on
end
if(i>1)
plot([vx(i-1) vx(i)],[vy(i-1) vy(i)])
hold on

% los límites se deben ajustar dependiendo del delta_t que seleccionemos
xlim([-5000,5000])
ylim([-5000,5000])
end
end
