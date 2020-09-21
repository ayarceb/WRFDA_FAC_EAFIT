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
    plot(eval(variable{i}),eval(variable{3}))
hold on
grid on
ylabel({'Altitude',unit{3}});
xlabel(unit{i});
    title({name{i},''});

    end
     if(i>3)
        
subplot(2,5,i-1)
    plot(eval(variable{i}),eval(variable{3}))
hold on
grid on
ylabel({'Altitude',unit{3}});
    xlabel(unit{i});
  title({name{i},''});
    end
end
sgtitle('Hernesto cortizos 7 pm 18 august 2020')
end


