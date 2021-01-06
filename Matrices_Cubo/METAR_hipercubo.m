% create metar hipercube solicitado
% Dimensiones Dom_2    531 X 660   (nx,ny)
% Simulation between August-18-2020_00:00:00 to
% August-21-2020_00:00:00 WRF time.
clc;close;clear all


%carpeta donde estan los resultados de modelo asimilado y no asimilado

%Andres
%mydir1='/disk/kalman/WRFDA_semanas/1_Septiembre/Asimilando'; % Ubicacion de los archivos 
%cd(mydir1)
%XLONG=ncread('20200901-00asimilando_d2.nc','XLONG'); %Andres
%XLAT=ncread('20200901-00asimilando_d2.nc','XLAT');% Andres

%path de los productos del codigo que decodifica el Metar
%mydir='/home/kalman/Andres/FAC_REPO/WRFDA_FAC_EAFIT/Metar/datos';
%cd(mydir)

% Jhon 
XLONG = ncread('/media/fermat/DD_JOE/FAC/corridas_validacion/Test_case_FAC_01_09_04_09/wrfout_d02_2020-09-04_00:00:00','XLONG');
XLAT  = ncread('/media/fermat/DD_JOE/FAC/corridas_validacion/Test_case_FAC_01_09_04_09/wrfout_d02_2020-09-04_00:00:00','XLAT');
%
%Datos metar.
mydir='/media/fermat/HomeDisk/fermat/FAC/repositorio_WRFDA_FAC/WRFDA_FAC_EAFIT/Metar/datos';
cd(mydir)
% date for the simulation
year        = 2020;
start_month = 8;
end_month   = 8;
start_day   = 18;
end_day     = 21;
start_hour  = 00;
end_hour    = 00;
format_time ='yyyy-MM-dd HH:mm:ss';
t1 = datetime(year,start_month,start_day,start_hour,0,0,'Format',format_time); 
t2 = datetime(year,end_month,end_day,start_hour,0,0,'Format',format_time);
date_hour = t1:hours(1):t2; date_hour=date_hour'; 

%d = yyyymmddhhss(date_hour);
%Creación de la matriz del cubo para T y para P

Metar_cube_T=nan(531,660,41,73);%Temperature Metar Hipercube  Domain 2,dim_d02: 531,660,levels=41;time=73;
Metar_cube_P=nan(531,660,41,73);%Pressure Metar Hipercube

%latitudes and longitudes ciudades in colombia
lati=[10.46314,3.42158,11.233,11.533,8.75,6.217,10.4,4.60971,7.0652800,10.96854];
longi=[-73.25322,-76.5205,-74.2,-72.9,-75.883,-75.567,-75.5,-74.08175,-73.8547200,-74.78132];
datos={'datos_valledupar.csv','datos_cali.csv','datos_SANTA_MARTA.csv','datos_rioacha.csv','datos_monteria.csv',...
    'datos_Medellin.csv','datos_cartagena.csv','datos_Bogota.csv','datos_barrancabermeja.csv','datos_Barranquilla.csv'};
nombres_ciudades={'Valledupar','Cali','Santa Marta','Riohacha','Monteria','Medellin','Cartagena','Bogotá','Barrancabermeja'...
    'Barranquilla'};

%%%% 5-01-2021
num_city=length(datos);
for i=1:num_city 
T=readtable(datos{i});
[num_data,num_var]=size(T);


end

for i=13:20 % datos dentro del archivo a leer
ind=1; % archivo ciudad, indice en lati longi
 
% Valledupar Dom_2    10.46314, -73.25322      
% Cali Dom_2	3.42158, -76.5205
% Santa Marta Dom_2  	Latitud: 11.233, Longitud: -74.2
% San Andrés Dom_2  	Latitud: 6.817, Longitud: -72.85
% Riohacha Dom_2	Latitud: 11.533, Longitud: -72.9
% Providencia Dom_2 Latitud: 3.088, Longitud: -73.25
% Montería Dom_2	Latitud: 8.75, Longitud: -75.883
% Medellín Dom_2	Latitud: 6.217, Longitud: -75.567
% Cartagena de Indias Dom_2	Latitud: 10.4, Longitud: -75.5
% Bogotá Dom_2 Latitud: 4.60971, Longitud: -74.08175
% Barrancabermeja: Dom_2  Latitud: 7.0652800, Longitud: -73.8547200
% Barranquilla Dom_2  Latitud:10.96854, Longitud: -74.78132
%
%   if dom==1
% nx(ind,1)=find(and(XLONG(:,1)>longi(ind)-0.041,XLONG(:,1)<longi(ind)+0.041 ));
% ny(ind,1)=find(and(XLAT(1,:)>lati(ind)-0.041,XLAT(1,:)<lati(ind)+0.041 ));      
%     end
% ubica latitud y longitud en los WRFout
nx(ind,1)=find(and(XLONG(:,1)>longi(ind)-0.014,XLONG(:,1)<longi(ind)+0.014 ));
ny(ind,1)=find(and(XLAT(1,:)>lati(ind)-0.014,XLAT(1,:)<lati(ind)+0.014 ));
%
%
T=readtable(datos{ind});
[num_data,num_var]=size(T);
%
Metar_cube_T(nx(ind,1),ny(ind,1),1,i)=T.T(i-12);

Metar_cube_P(nx(ind,1),ny(ind,1),1,1)=T.P(i-12);
end
