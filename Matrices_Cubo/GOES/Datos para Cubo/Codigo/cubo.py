import matplotlib.pyplot as plt # Import the Matplotlib package
from netCDF4 import Dataset # Import the NetCDF Python interface
from mpl_toolkits.basemap import Basemap # Import the Basemap toolkit
import numpy as np # Import the Numpy package
from matplotlib.colors import LinearSegmentedColormap # Linear interpolation for color maps
from osgeo import osr
from osgeo import gdal
import time as t
import os

def getGeoT(extent, nlines, ncols):
    # Compute resolution based on data dimension
    resx = (extent[2] - extent[0]) / ncols
    resy = (extent[3] - extent[1]) / nlines
    return [extent[0], resx, 0, extent[3] , 0, -resy]
 
def getScaleOffset(path, variable):
    nc = Dataset(path, mode='r')
    scale = nc.variables[variable].scale_factor
    offset = nc.variables[variable].add_offset
    nc.close()
    return scale, offset
     
def remap(path, variable, extent, resolution, x1, y1, x2, y2):
    # GOES-16 Spatial Reference System
    sourcePrj = osr.SpatialReference()
    sourcePrj.ImportFromProj4('+proj=geos +h=35786000 +a=6378140 +b=6356750 +lon_0=-75 +sweep=x')
    
    # Lat/lon WSG84 Spatial Reference System
    targetPrj = osr.SpatialReference()
    targetPrj.ImportFromProj4('+proj=latlong +datum=WGS84')
     
    GOES16_EXTENT = [x1, y1, x2, y2]
     
    # Setup NetCDF driver
    gdal.SetConfigOption('GDAL_NETCDF_BOTTOMUP', 'NO')
    scale = 1
    offset = 0
    scale, offset = getScaleOffset(path, variable) 
       
    connectionInfo = 'HDF5:\"' + path + '\"://' + variable
    raw = gdal.Open(connectionInfo)

    # Setup projection and geo-transformation
    raw.SetProjection(sourcePrj.ExportToWkt())
    raw.SetGeoTransform(getGeoT(GOES16_EXTENT, raw.RasterYSize, raw.RasterXSize))  
   
    # Compute grid dimension
    sizex = int(((extent[2] - extent[0]) * 111.32) / resolution)
    sizey = int(((extent[3] - extent[1]) * 111.32) / resolution)

    # Get memory driver
    memDriver = gdal.GetDriverByName('MEM')
    
    # Create grid
    grid = memDriver.Create('grid', sizex, sizey, 1, gdal.GDT_Float32)
         
    # Setup projection and geo-transformation
    grid.SetProjection(targetPrj.ExportToWkt())
    grid.SetGeoTransform(getGeoT(extent, grid.RasterYSize, grid.RasterXSize))
         
    start = t.time()
    gdal.ReprojectImage(raw, grid, sourcePrj.ExportToWkt(), targetPrj.ExportToWkt(), gdal.GRA_NearestNeighbour, options=['NUM_THREADS=ALL_CPUS']) 
     
    # Close file
    raw = None
             
    # Read grid data
    array = grid.ReadAsArray()
     
    # Mask fill values (i.e. invalid values)
    np.ma.masked_where(array, array == -2, False)
    array = array.astype(np.uint16)  
        
    # Apply scale and offset
    array = array * scale + offset
    grid.GetRasterBand(1).WriteArray(array)
 
    return grid

  
#path = '/home/sivam/Descargas/Rad20200819_13/OR_ABI-L1b-RadF-M6C13_G16_s20202320000209_e20202320009529_c20202320009584.nc'
#nc = Dataset(path)

#variables = nc.variables.keys()
#print (variables)

canal = '07'
fecha = '20200901'
contenido = os.listdir('/home/sivam/Descargas/Rad%s_%s' %(fecha, canal))
print(contenido)
for i in contenido:

    print(i)
    print(i[34:36])
    
    path = '/home/sivam/Descargas/Rad%s_%s/'%(fecha,canal) + i
    nc = Dataset(path)

    variable = 'Rad'
    H = nc.variables['goes_imager_projection'].perspective_point_height
    x1 = nc.variables['x_image_bounds'][0] * H 
    x2 = nc.variables['x_image_bounds'][1] * H 
    y1 = nc.variables['y_image_bounds'][1] * H 
    y2 = nc.variables['y_image_bounds'][0] * H

    extent = [-80.0936, -4.90034, -65.7439, 12.8275] 
    resolution = 2.985

    grid = remap(path, variable, extent, resolution, x1, y1, x2, y2)
    data = grid.ReadAsArray()
    data[data == max(data[0])] = 0
    data[data == min(data[0])] = 0


    print(data.shape)


    bmap = Basemap(llcrnrlon=extent[0], llcrnrlat=extent[1], urcrnrlon=extent[2], urcrnrlat=extent[3], epsg=4326)
    #bmap.readshapefile('/home/sivam/Escritorio/ne_10m_admin_0_countries/ne_10m_admin_0_countries','ne_10m_admin_0_countries',linewidth=0.30,color='yellow')
    bmap.imshow(data, origin='upper', cmap='Greys')

    plt.gca().set_axis_off()
    plt.subplots_adjust(top = 1, bottom = 0, right = 1, left = 0, hspace = 0, wspace = 0)
    plt.margins(0,0)
    plt.gca().xaxis.set_major_locator(plt.NullLocator())
    plt.gca().yaxis.set_major_locator(plt.NullLocator())
    print('/home/sivam/Escritorio/%s_%s_new/%s%s_%s.png' %(fecha, canal, fecha, str(i[34:36]), canal))
    plt.savefig('/home/sivam/Escritorio/%s_%s_new/%s%s_%s.png' %(fecha, canal, fecha, str(i[34:36]), canal), bbox_inches = 'tight', pad_inches = 0)
    
    #Redimensionar
    from PIL import Image
    img = Image.open('/home/sivam/Escritorio/%s_%s_new/%s%s_%s.png' %(fecha, canal, fecha, str(i[34:36]), canal))
    new_img = img.resize(((532, 661)))
    new_img.save('/home/sivam/Escritorio/%s_%s_new/%s%s_%s.png' %(fecha, canal, fecha, str(i[34:36]), canal),'png')
    #plt.show()
