import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import math
from datetime import *
import metpy.calc as mpcalc #pip install metpy
from metpy.plots import add_metpy_logo, skewt
from metpy.units import units
from siphon.si mlewebservice.wyoming import WyomingUpperAir #pip install siphon
date# = datetime(2018,8,18,12)
num_d#ays = 730#
download_sounds(date, path

    sound_omm_ids = [80001,80222,80371,80398]


download_sounds(date, path)
)
data = pd.DataFrame()

for i in range(0, num_days):
    station = '76644'
    try:
        data = WyomingUpperAir.request_data(date,station)
        print(data)
    except:
        print("No existen datos")

    data.to_csv(f'/home/dirac/Dropbox/2020/WRFDA_FAC_EAFIT/{station}{date}.csv', index = True) 
    date = date + timedelta(days=1)




