%  PLOT variables sondas for the interest time
% data from http://weather.uwyo.edu/upperair/sounding.html
% Andrés Yarce

clear all;close all;clc

load Ernesto_cortizos_18_agosto.mat

variable={'DRCT','DWPT','HGHT','MIXR','PRES','RELH','SKNT','TEMP','THTA','THTE','THTV'};



name={'Wind Direction','Dewpoint Temperature','Geopotential Height','Mixing Ratio','Atmospheric Pressure ',...
    'Relative Humidity','Wind Speed','Temperature','Potential Temperature','Equivalent Potential Temperature','Virtual Potential Temperature'};

unit={'[degrees true]','[celsius]','[meter]','[gram/kilogram]','[hPa]','[%]','[knot]','[celsius]','[kelvin]','[kelvin]','[kelvin]'};


for i=1:11
if(i~=3)
    if(i<3)
    
    
subplot(2,5,i)
    plot(eval(variable{i}),eval(variable{5}))
hold on
grid on
ylabel({'Pressure',unit{5}});
xlabel(unit{i});
    title({name{i},''});

    end
     if(i>3)
        
subplot(2,5,i-1)
    plot(eval(variable{i}),eval(variable{5}))
hold on
grid on
ylabel({'Pressure',unit{5}});
    xlabel(unit{i});
  title({name{i},''});
    end
end
sgtitle('Hernesto cortizos 7 pm 18 august 2020')
end


% part to get U and V from wind direction and wind speed

% wind direction variable 1
% wind speed variable 7



variable{7}*cos(variable{i})




