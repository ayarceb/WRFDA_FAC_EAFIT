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




