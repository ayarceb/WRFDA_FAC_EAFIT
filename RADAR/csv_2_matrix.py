#!/usr/bin/env python
# coding: utf-8

# In[1]:



import pandas as pd
import numpy as np
import xarray as xr
from netCDF4 import Dataset
from wrf import getvar, interpline, CoordPair, xy_to_ll, ll_to_xy, ALL_TIMES
import matplotlib.pyplot as plt


# In[2]:


empty_arr = np.empty((13, 41, 660, 531))


# In[3]:


empty_arr[:] = -999


# In[4]:


from netCDF4 import Dataset

test = Dataset('/Volumes/Seagate Backup Plus Drive/Datos WRF/20200818-00/20200818-00asimilando_d2', format="NETCDF4")


# In[5]:



ncfile = Dataset("/Users/thanatos/wrfmodel2/Build_WRF/WRF4.1.1/test/em_real/wrfout_d02_2019-01-07_00:00:00")


x_y = ll_to_xy(ncfile, 0.5086561476791331, -69.2636651202)

print (x_y)

lat_lon = xy_to_ll(ncfile, x_y[0], x_y[1])

print(lat_lon)


# In[6]:


z = getvar(ncfile, "z")


# In[7]:


slp = getvar(ncfile, "P", timeidx=ALL_TIMES)


# In[8]:


slp['XLONG']
lon = slp['XLONG']
lat = slp['XLAT']
time = slp['XTIME']
reference_time = pd.Timestamp("2014-09-05")


# In[9]:


radianza = xr.DataArray(
    data=empty_arr,
    dims=["Time","level","x", "y"],
    coords=dict(
        lon=(["x", "y"], lon),
        lat=(["x", "y"], lat),
        level=range(0,41),
        Time=time,
        reference_time=reference_time,
    ),
    attrs=dict(
        description="Radianza.",
        units="degC",
    ),
)
reflectividad = xr.DataArray(
    data=empty_arr,
    dims=["Time","level","x", "y"],
    coords=dict(
        lon=(["x", "y"], lon),
        lat=(["x", "y"], lat),
        level=range(0,41),
        Time=time,
        reference_time=reference_time,
    ),
    attrs=dict(
        description="Reflectividad.",
        units="",
    ),
)


# In[10]:


df = pd.read_csv('/Volumes/Seagate Backup Plus Drive/Datos WRF/EAFIT_scripts/RADAR/little R/radar.csv')


# In[15]:


z.shape


# In[17]:


reflectividad.shape


# In[22]:


for index, row in df.iterrows():
    
    x_y = ll_to_xy(ncfile, row['Latitud'], row['Longitud'])
    test = (row['Latitud'], row['Longitud'])
    if x_y[1] >= 660 or x_y[1] >= 531:
        continue
    
    array_alturas = z[:,x_y[1],x_y[0]].values
    val_alt_cercana = min(array_alturas, key = lambda array_alturas:abs(array_alturas-row['altura']))

    index_alt_cercana = np.where(array_alturas == val_alt_cercana)[0][0]
    
    radianza[0,index_alt_cercana,x_y[1],x_y[0]] = row['V_radial']
    reflectividad[0,index_alt_cercana,x_y[1],x_y[0]] = row['Reflectividad']
    

radianza.to_netcdf('/Volumes/Seagate Backup Plus Drive/Datos WRF/EAFIT_scripts/RADAR/radianza.nc')
reflectividad.to_netcdf('/Volumes/Seagate Backup Plus Drive/Datos WRF/EAFIT_scripts/RADAR/radianza.nc')





