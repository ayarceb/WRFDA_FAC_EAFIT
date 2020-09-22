import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import math
from datetime import *
import metpy.calc as mpcalc #pip install metpy
from metpy.plots import add_metpy_logo, skewt
from metpy.units import units
from siphon.simplewebservice.wyoming import WyomingUpperAir #pip install siphon
date = datetime(2018,1,1,12)
num_days = 730

data = pd.DataFrame()

for i in range(0, num_days):
    station = '80222'
    try:
        data = WyomingUpperAir.request_data(date,station)
        print(data)
    except:
        print("No existen datos")

    data.to_csv(f'/Users/thanatos/Downloads/{station}{date}.csv', index = True) 
    date = date + timedelta(days=1)



