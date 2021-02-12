import os
import pandas as pd

files = os.listdir('/Volumes/Seagate Backup Plus Drive/Datos WRF/EAFIT_scripts/RADAR/little R')

df = pd.DataFrame(columns=['Fecha','Latitud','Longitud','altura',"V_radial","Reflectividad"])
for file_name in files:
    
    f = open(f'/Volumes/Seagate Backup Plus Drive/Datos WRF/EAFIT_scripts/RADAR/little R/{file_name}')
    file_str = f.read()
    
    for radar_data in file_str.split('#-------------------------------------------------------------------------------#'):
        if 'FM-128' in radar_data:
            data_str = " ".join(radar_data.split())
            for medicion in data_str.split('FM-128')[1:]:
                arr_medicion = medicion.split()
                if arr_medicion[5] == '1':
                    df = df.append({'Fecha': arr_medicion[1],
                    'Latitud': arr_medicion[2],
                    'Longitud': arr_medicion[3],
                    'altura': arr_medicion[6],
                    "V_radial" : arr_medicion[7],
                    "Reflectividad": arr_medicion[10]}, ignore_index=True)
                else:
                    for i in range(int(arr_medicion[5])):
                        df = df.append({'Fecha': arr_medicion[1],
                    'Latitud': arr_medicion[2],
                    'Longitud': arr_medicion[3],
                    'altura': arr_medicion[6+(7*i)],
                    "V_radial" : arr_medicion[7+(7*i)],
                    "Reflectividad": arr_medicion[10+(7*i)]}, ignore_index=True)

df.to_csv('/Volumes/Seagate Backup Plus Drive/Datos WRF/EAFIT_scripts/RADAR/little R/radar.csv')