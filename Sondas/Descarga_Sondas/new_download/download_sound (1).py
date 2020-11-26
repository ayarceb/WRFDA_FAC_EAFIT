import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import math
from datetime import *
import metpy.calc as mpcalc #pip install metpy
from metpy.plots import add_metpy_logo, skewt
from metpy.units import units
from siphon.simplewebservice.wyoming import WyomingUpperAir #pip install siphon
date = datetime(2020,9,1,06)
num_days = 4

data = pd.DataFrame()

for i in range(0, num_days):
    station = '78988'
    try:
        data = WyomingUpperAir.request_data(date,station)
        print(data)
    except:
        print("No existen datos")

    data.to_csv(f'/home/dirac/Dropbox/2020/WRFDA_FAC_EAFIT/Sondas/Descarga_Sondas/new_download/{station}{date}.csv', index = True) 
    date = date + timedelta(days=1)



