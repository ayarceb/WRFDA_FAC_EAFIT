% Script to create a matriz (nx,ny,nz,t) for the IDEAM data 

clc;close all;clear all

T=readtable('df_all_prec.csv');
lati=T.Latitud;
longi=T.Longitud;
Fecha=T.Fecha;
hour_simul=73;
Valor=T.Valor;
CodigoEstacion=T.CodigoEstacion;

% Cubos para los datos segun numero de celdas del dominio, numero de
% niveles y numero de horas de simulacion.
Metar_cube_IDEAM=nan(531,660,41,hour_simul);%Temperature Metar Hipercube  Domain 2,dim_d02: 531,660,levels=41;time=73;

XLONG=ncread('archivo referencia domain longitude 2');
XLAT=ncread('archivo referencia domain latitude 2');

tiempo=1;

for ind=2:7560
 
 nx(ind,1)=find(and(XLONG(:,1)>longi(ind)-0.014,XLONG(:,1)<longi(ind)+0.014 ));
 ny(ind,1)=find(and(XLAT(1,:)>lati(ind)-0.014,XLAT(1,:)<lati(ind)+0.014 ));
     
 if(CodigoEstacion(ind)==CodigoEstacion(ind-1))
      Metar_cube_IDEAM(nx(ind,1),ny(ind,1),1,tiempo)=Valor(ind);
 end
 
  if(CodigoEstacion(ind)~=CodigoEstacion(ind-1))
      tiempo=1;
   Metar_cube_IDEAM(nx(ind,1),ny(ind,1),1,tiempo)=Valor(ind);
   end
 tiempo=tiempo+1;
end