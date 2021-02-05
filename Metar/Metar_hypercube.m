% create metar hipercube solicitado
% Dimensiones Dom_2    531 X 660   (nx,ny)
% Simulation between 1. August-18-2020_00:00:00 to
% August-21-2020_00:00:00 WRF time.
% Simulation 2. Between september-1-2020_00:00:00 to september-4-2020_00:00:00
clear
clc

%
%Extracción de latitudes y longitudes de salidas de WRF
XLONG = ncread('/media/fermat/DD_JOE/FAC/corridas_validacion/Test_case_FAC_01_09_04_09/wrfout_d02_2020-09-04_00:00:00','XLONG');
XLAT  = ncread('/media/fermat/DD_JOE/FAC/corridas_validacion/Test_case_FAC_01_09_04_09/wrfout_d02_2020-09-04_00:00:00','XLAT');
%
% seleccionar experimento: experimento=1; primer periodo, experimento=2; segundo periodo,
experimento=2

if experimento==1
    % simulation date
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
    day_simul = start_day:end_day-1;
    hour_simul=length(date_hour)-1; % Number of hour of the simulation.
    % Data directory. % Directorio con los datos METAR
    mydir='/media/fermat/HomeDisk/fermat/FAC/repositorio_WRFDA_FAC/WRFDA_FAC_EAFIT/Metar/datos/1';
else
    % simulation date
    year        = 2020;
    start_month = 9; %8
    end_month   = 9; %8
    start_day   = 1; %18;
    end_day     = 4; %21;
    start_hour  = 00;
    end_hour    = 00;
    format_time ='yyyy-MM-dd HH:mm:ss';
    t1 = datetime(year,start_month,start_day,start_hour,0,0,'Format',format_time); 
    t2 = datetime(year,end_month,end_day,start_hour,0,0,'Format',format_time);
    date_hour = t1:hours(1):t2; date_hour=date_hour'; 
    day_simul = start_day:end_day-1;
    hour_simul=length(date_hour)-1; % Number of hour of the simulation.
    % Data directory. % Directorio con los datos METAR
    mydir='/media/fermat/HomeDisk/fermat/FAC/repositorio_WRFDA_FAC/WRFDA_FAC_EAFIT/Metar/datos/2';
end

% Cubos para los datos segun numero de celdas del dominio, numero de
% niveles y numero de horas de simulacion.
Metar_cube_T=nan(531,660,41,hour_simul);%Temperature Metar Hipercube  Domain 2,dim_d02: 531,660,levels=41;time=73;
Metar_cube_P=nan(531,660,41,hour_simul);%Pressure Metar Hipercube

cd(mydir)
% Ciudades con Datos usados.
datos={'datos_valledupar.csv','datos_cali.csv','datos_santa_marta.csv','datos_riohacha.csv','datos_monteria.csv',...
    'datos_medellin.csv','datos_cartagena.csv','datos_Bogota.csv','datos_barrancabermeja.csv','datos_Barranquilla.csv'};
%
num_city=length(datos);
%
%latitudes y longitudes de ciudades usadas.
lati=[10.46314,3.42158,11.233,11.533,8.75,6.217,10.4,4.60971,7.0652800,10.96854];
longi=[-73.25322,-76.5205,-74.2,-72.9,-75.883,-75.567,-75.5,-74.08175,-73.8547200,-74.78132];
%
for ind=1:num_city % ind:indice de ciudad según el orden dado a los datos. 
    T=readtable(datos{ind}); % Lectura de informacion desde archivo
    [horas,~,~]=hms(T.D); % obtengo horas con información disponible
    [~,~,dias]=ymd(T.D); % obtengo dias con información disponible
    %
    horas=horas+1; % mapping of hours to matlab indexing. 00-->01, ... 23-->24
    num_horas=length(horas);
    temp=nan(1,hour_simul);
    pres=nan(1,hour_simul);
    for i=1:num_horas
        if dias(i)==day_simul(1)
            temp(horas(i))=T.T(i);
            pres(horas(i))=T.P(i);
        elseif dias(i)==day_simul(2)
            temp(horas(i)+24)=T.T(i);
            pres(horas(i)+24)=T.P(i);
        else % dias(i)==20
            temp(horas(i)+2*24)=T.T(i);
            pres(horas(i)+2*24)=T.P(i);
        end
    end
    % Encontrar celdas corresondientes a la latitud y longitud de salidas de WRF
    nx(ind,1)=find(and(XLONG(:,1)>longi(ind)-0.014,XLONG(:,1)<longi(ind)+0.014 ));
    ny(ind,1)=find(and(XLAT(1,:)>lati(ind)-0.014,XLAT(1,:)<lati(ind)+0.014 ));
    %
end
    Metar_cube_T(nx(ind,1),ny(ind,1),1,:)=temp; % Almacenar informacion en el cubo. Temperatura
    Metar_cube_P(nx(ind,1),ny(ind,1),1,:)=pres; % Almacenar informacion en el cubo. Presión

    %save ('Metar_cube_simul_1','Metar_cube_T','Metar_cube_P')
    %plot(squeeze( Metar_cube_T(nx(ind,1),ny(ind,1),1,:)))