% this code generates the hipercube for august and september window time
% for the experiment between FAC and EAFIT
% plot sound from 4 locations (Curazao,Barranquilla,Palonegro,Bogotá) for the 1 september


clc;clear all;close all

variable={'PRES','HGHT','TEMP','DWPT','RELH','MIXR','DRCT','SKNT','THTA','THTE','THTV'};

name={'Atmospheric Pressure ','Geopotential Height','Temperature','Dewpoint Temperature','Relative Humidity','Mixing Ratio',...
    'Wind Direction','Wind Speed','Potential Temperature','Equivalent Potential Temperature','Virtual Potential Temperature'};

unit={'[hPa]','[meter]','[celsius]','[celsius]','[%]','[gram/kilogram]','[degrees true]','[knot]','[kelvin]','[kelvin]','[kelvin]'};

%%

hour_simul=73;
%Extracción de latitudes y longitudes de salidas de WRF
XLONG = ncread('/media/fermat/DD_JOE/FAC/corridas_validacion/Test_case_FAC_01_09_04_09/wrfout_d02_2020-09-04_00:00:00','XLONG');
XLAT  = ncread('/media/fermat/DD_JOE/FAC/corridas_validacion/Test_case_FAC_01_09_04_09/wrfout_d02_2020-09-04_00:00:00','XLAT');
%
% Cubos para los datos segun numero de celdas del dominio, numero de
% niveles y numero de horas de simulacion.
Sound_cube_T=nan(531,660,41,hour_simul);%sound Hipercube  Domain 2,dim_d02: 531,660,levels=41;time=73;


%% day August 18
mydir='/home/dirac/Dropbox/2020/WRFDA_FAC_EAFIT/Sondas/Descarga_Sondas/Agosto_2020/18_Agosto';
cd(mydir)

%Curazao=readtable('78988.txt');  % para el dia 18 de agosto no aparece Curazao
Barranquilla=readtable('80028.txt');
Palonegro=readtable('80094.txt');
Bogota=readtable('80222.txt');

%Curazao1=Curazao{:,:};
Barranquilla1=Barranquilla{:,:};
Palonegro1=Palonegro{:,:};
Bogota1=Bogota{:,:};


% Barranquilla

for i=1:11
if(i~=2)
    if(i<2)
    
    
subplot(2,5,i)
    plot(Barranquilla1(:,i),Barranquilla1(:,2))
hold on
grid on
ylabel({'Altitude',unit{2}});
xlabel(unit{i});
    title({name{i},''});

    end
     if(i>2)
        
subplot(2,5,i-1)
    plot(Palonegro1(:,i),Palonegro1(:,2))
hold on
grid on
ylabel({'Altitude',unit{2}});
    xlabel(unit{i});
  title({name{i},''});
    end
end
sgtitle('Barranquilla 2020')
end

figure

% extraer la velocidad y direccin para
% Bogotá
wind_dir_Bog=Barranquilla1(:,7);
wind_speed_Bog=Barranquilla1(:,8);

delta_t=100;

xx(1)=0;
yy(1)=0;
for i=1:50

vx(i)=wind_speed_Bog(i,1)*sin(wind_dir_Bog(i,1)*pi/180)*delta_t;   
vy(i)=wind_speed_Bog(i,1)*cos(wind_dir_Bog(i,1)*pi/180)*delta_t;   


% la primera se realiza con respecto a la condición inicial, en este caso
% (i=0) --> (0,0)
if(i==1)
plot([0 vy(i)],[0 vx(i)])
hold on
end
if(i>1)
plot([vy(i-1) vy(i)],[vx(i-1) vx(i)])
hold on

% los límites se deben ajustar dependiendo del delta_t que seleccionemos
xlim([-5000,5000])
ylim([-5000,5000])
end
end

axis xy




%day 2
clear all

variable={'PRES','HGHT','TEMP','DWPT','RELH','MIXR','DRCT','SKNT','THTA','THTE','THTV'};



name={'Atmospheric Pressure ','Geopotential Height','Temperature','Dewpoint Temperature','Relative Humidity','Mixing Ratio',...
    'Wind Direction','Wind Speed','Potential Temperature','Equivalent Potential Temperature','Virtual Potential Temperature'};



unit={'[hPa]','[meter]','[celsius]','[celsius]','[%]','[gram/kilogram]','[degrees true]','[knot]','[kelvin]','[kelvin]','[kelvin]'};


mydir='/home/dirac/Dropbox/2020/WRFDA_FAC_EAFIT/Sondas/Descarga_Sondas/new_download/raw/2_sept';
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
    plot(Palonegro1(:,i),Palonegro1(:,2))
hold on
grid on
ylabel({'Altitude',unit{2}});
xlabel(unit{i});
    title({name{i},''});

    end
     if(i>2)
        
subplot(2,5,i-1)
    plot(Palonegro1(:,i),Palonegro1(:,2))
hold on
grid on
ylabel({'Altitude',unit{2}});
    xlabel(unit{i});
  title({name{i},''});
    end
end
sgtitle('Palonegro 2020')
end


%day 3
clear all

variable={'PRES','HGHT','TEMP','DWPT','RELH','MIXR','DRCT','SKNT','THTA','THTE','THTV'};



name={'Atmospheric Pressure ','Geopotential Height','Temperature','Dewpoint Temperature','Relative Humidity','Mixing Ratio',...
    'Wind Direction','Wind Speed','Potential Temperature','Equivalent Potential Temperature','Virtual Potential Temperature'};



unit={'[hPa]','[meter]','[celsius]','[celsius]','[%]','[gram/kilogram]','[degrees true]','[knot]','[kelvin]','[kelvin]','[kelvin]'};


mydir='/home/dirac/Dropbox/2020/WRFDA_FAC_EAFIT/Sondas/Descarga_Sondas/new_download/raw/3_sept';
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
    plot(Palonegro1(:,i),Palonegro1(:,2))
hold on
grid on
ylabel({'Altitude',unit{2}});
xlabel(unit{i});
    title({name{i},''});

    end
     if(i>2)
        
subplot(2,5,i-1)
    plot(Palonegro1(:,i),Palonegro1(:,2))
hold on
grid on
ylabel({'Altitude',unit{2}});
    xlabel(unit{i});
  title({name{i},''});
    end
end
sgtitle('Palonegro 2020')
end



subplot(2,5,1);
legend('September 1 12Z','September 2 12Z','September 3 12Z')
subplot(2,5,2);
legend('September 1 12Z','September 2 12Z','September 3 12Z')
subplot(2,5,3);
legend('September 1 12Z','September 2 12Z','September 3 12Z')
subplot(2,5,4);
legend('September 1 12Z','September 2 12Z','September 3 12Z')
subplot(2,5,5);
legend('September 1 12Z','September 2 12Z','September 3 12Z')
subplot(2,5,6);
legend('September 1 12Z','September 2 12Z','September 3 12Z')
subplot(2,5,7);
legend('September 1 12Z','September 2 12Z','September 3 12Z')
subplot(2,5,8);
legend('September 1 12Z','September 2 12Z','September 3 12Z')
subplot(2,5,9);
legend('September 1 12Z','September 2 12Z','September 3 12Z')
subplot(2,5,10);
legend('September 1 12Z','September 2 12Z','September 3 12Z')




    