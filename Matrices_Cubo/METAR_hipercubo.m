% create metar hipercube

clc;close;clear all

Metar_cube_T=nan(531,660,41,73);%Temperature Metar Hipercube
Metar_cube_P=nan(531,660,41,73);%Pressure Metar Hipercube


%latitudes and longitudes ciudades in colombia



% Dimensiones Dom_1    299 x 325   (nx ny)
% Dimensiones Dom_2    531 X 660   (nx,ny)

% Valledupar Dom_1    10.46314, -73.25322     
% Valledupar Dom_2    10.46314, -73.25322      

% Cali Dom_1	3.42158, -76.5205  nx , ny
% Cali Dom_2	3.42158, -76.5205

% Santa Marta Dom_1  	Latitud: 11.233, Longitud: -74.2
% Santa Marta Dom_2  	Latitud: 11.233, Longitud: -74.2

% San Andrés Dom_1  	Latitud: 6.817, Longitud: -72.85
% San Andrés Dom_2  	Latitud: 6.817, Longitud: -72.85
 
% Riohacha Dom_1	Latitud: 11.533, Longitud: -72.9
% Riohacha Dom_2	Latitud: 11.533, Longitud: -72.9

% Providencia Dom_1 Latitud: 3.088, Longitud: -73.25
% Providencia Dom_2 Latitud: 3.088, Longitud: -73.25

% Montería Dom_1	Latitud: 8.75, Longitud: -75.883
% Montería Dom_2	Latitud: 8.75, Longitud: -75.883

% Medellín Dom_1	Latitud: 6.217, Longitud: -75.567
% Medellín Dom_2	Latitud: 6.217, Longitud: -75.567

% Cartagena de Indias Dom_1	Latitud: 10.4, Longitud: -75.5
% Cartagena de Indias Dom_2	Latitud: 10.4, Longitud: -75.5

% Bogotá Dom_1 Latitud: 4.60971, Longitud: -74.08175
% Bogotá Dom_2 Latitud: 4.60971, Longitud: -74.08175

% Barrancabermeja: Dom_1  Latitud: 7.0652800, Longitud: -73.8547200
% Barrancabermeja: Dom_2  Latitud: 7.0652800, Longitud: -73.8547200

% Barranquilla Dom_1  Latitud:10.96854, Longitud: -74.78132
% Barranquilla Dom_2  Latitud:10.96854, Longitud: -74.78132

  if dom==1
nx(ind,1)=find(and(XLONG(:,1)>longi(ind)-0.041,XLONG(:,1)<longi(ind)+0.041 ));
ny(ind,1)=find(and(XLAT(1,:)>lati(ind)-0.041,XLAT(1,:)<lati(ind)+0.041 ));      
    end
  if dom==2
nx(ind,1)=find(and(XLONG(:,1)>longi(ind)-0.014,XLONG(:,1)<longi(ind)+0.014 ));
ny(ind,1)=find(and(XLAT(1,:)>lati(ind)-0.014,XLAT(1,:)<lati(ind)+0.014 ));
    end



%%  Time series plot part

%ciudad Medellin  px_m=,py_m=

%ciudad Medellin  px=,py=


%ciudad Bogota  px=,py=


