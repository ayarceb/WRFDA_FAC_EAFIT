
import sys, os
import wget
import re
from datetime import datetime
date = datetime(2020,9,3,12)
path='/home/dirac/Dropbox/2020/WRFDA_FAC_EAFIT/Sondas/Descarga_Sondas/new_download'

def download_sounds(date, path):
    """
    organizar url para descargar todos los radiosondeos
    http://weather.uwyo.edu/cgi-bin/sounding?region=naconf&TYPE=TEXT%3ALIST&YEAR=2016&MONTH=08&FROM=1112&TO=1112&STNM=76644
    """
    date_str = datetime.strftime(date,'%Y%m%d%H')
    if not os.path.isdir(f'{path}/raw/sound'):
        os.makedirs(f'{path}/raw/sound')
    os.chdir(f'{path}/raw/sound')

    sound_omm_ids = [78988,78807,80028,80094,80222,80259]
    d_url = "http://weather.uwyo.edu/cgi-bin/sounding?region=naconf&TYPE=TEXT%3ALIST"   
    d_url += "&YEAR="+date_str[:4]
    d_url += "&MONTH=" +date_str[4:6]
    d_url += "&FROM=" + date_str[-4:]
    d_url += "&TO=" + date_str[-4:]
    d_url += "&STNM="
    for id_sound in sound_omm_ids:
        url = d_url + str(id_sound)
        try:
            print("descargando ",url)
            wget.download(url, out=str(id_sound))
        except:
            print('archivo no encontrado')
    files = os.listdir()
    for file in files:
        text_file = open(file, "r")
        mensaje = text_file.read()
        print(type(mensaje))
        mensaje = strip_tags(mensaje)
        print(type(mensaje))
        text_file.close()
        text_file = open(file, "w")
        n = text_file.write(mensaje)
        text_file.close


def strip_tags(value):
    return re.sub(r'<[^>]*?>', '', value)

download_sounds(date, path)
