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



contenido = os.listdir('/home/sivam/Descargas/Rad20200819_07')

for i in contenido:
    
    print(i)
    print(i[34:36])
    
    path = '/home/sivam/Descargas/Rad20200819_07/' + i
    nc = Dataset(path)

    #variables = nc.variables.keys()
    #print (variables)

    var =nc.variables['Rad'][:]
    #print(var.units)

    variable = 'Rad'
    H = nc.variables['goes_imager_projection'].perspective_point_height
    x1 = nc.variables['x_image_bounds'][0] * H 
    x2 = nc.variables['x_image_bounds'][1] * H 
    y1 = nc.variables['y_image_bounds'][1] * H 
    y2 = nc.variables['y_image_bounds'][0] * H

    planck_fk1 = nc.variables['planck_fk1'][:]
    planck_fk2 = nc.variables['planck_fk2'][:]
    planck_bc1 = nc.variables['planck_bc1'][:]
    planck_bc2 = nc.variables['planck_bc2'][:]

    extent = [-85.1025, -8.42264, -60.8975, 17.5811] 
    resolution = 2.0

    grid = remap(path, variable, extent, resolution, x1, y1, x2, y2)
    data = grid.ReadAsArray()
    bt = ((planck_fk2 / (np.log( (planck_fk1/data)+1 ))) - planck_bc1)/planck_bc2
    bt = bt - 273.15

    red = []
    green = []
    blue = []
    valmin=-110.
    valmax=55.
    red.append( [0.0, 0.0, 0.0] )
    green.append( [0.0, 0.0, 0.0] )
    blue.append( [0.0, 0.0, 0.0] )
    red.append( [ (-50.0-valmin)/(valmax-valmin), 0.0, 0.0 ] )
    green.append( [ (-50.0-valmin)/(valmax-valmin), 1.0, 1.0 ] )
    blue.append( [ (-50.0-valmin)/(valmax-valmin), 0.0, 0.0 ] )
    red.append( [ (-40.0-valmin)/(valmax-valmin), 0.0, 0.0 ] )
    green.append( [ (-40.0-valmin)/(valmax-valmin), 0.0, 0.0 ] )
    blue.append( [ (-40.0-valmin)/(valmax-valmin), 0.4, 0.4 ] )
    red.append( [ (-30.0-valmin)/(valmax-valmin), 0.0, 0.8 ] )
    green.append( [ (-30.0-valmin)/(valmax-valmin), 1.0, 0.8 ] )
    blue.append( [ (-30.0-valmin)/(valmax-valmin), 1.0, 0.8 ] )
    red.append( [ 1.0, 0.0, 0.0 ] )
    green.append( [ 1.0, 0.0, 0.0 ] )
    blue.append( [ 1.0, 0.0, 0.0 ] )
    cdict = {'red': red, 'green': green, 'blue': blue}
    ctbl = LinearSegmentedColormap('custom', cdict)


    bmap = Basemap(llcrnrlon=extent[0], llcrnrlat=extent[1], urcrnrlon=extent[2], urcrnrlat=extent[3], epsg=4326)
    # Draw parallels and meridians
    bmap.drawparallels(np.arange(-90.0, 90.0, 5.0), linewidth=0.2, color='white', labels=[True,True,True,True], fmt='%g', xoffset=0.80, size=7)
    bmap.drawmeridians(np.arange(0.0, 360.0, 5.0), linewidth=0.2, color='white', labels=[True,True,True,True], fmt='%g', xoffset=-0.80, size=7)

    bmap.readshapefile('/home/sivam/Escritorio/ne_10m_admin_0_countries/ne_10m_admin_0_countries','ne_10m_admin_0_countries',linewidth=0.30,color='yellow')
    

    #Band 13
    #bmap.imshow(data,origin='upper', cmap='Greys')
    #bmap.colorbar(label='Radiances [mW m-2 sr-1 (cm-1)-1]', location='bottom', size = '2%', pad = '4.0%')
    #plt.suptitle('2020/08/19 %s:00 GOES-16 Band 13' %(str(i[34:36])), fontsize=14, fontweight='bold' )
    #plt.savefig('/home/sivam/Escritorio/20200819_13/20200819%s_13.png' %(str(i[34:36])))

    #Band 07
    bmap.imshow(bt,origin='upper', cmap=ctbl, vmin=valmin, vmax=valmax)
    bmap.colorbar(label='Brightness Temperature [°C]', location='bottom', size = '2%', pad = '4.0%')
    plt.suptitle('2020/08/19 %s:00 GOES-16 Band 07' %(str(i[34:36])), fontsize=14, fontweight='bold' )
    plt.savefig('/home/sivam/Escritorio/20200819_07/20200819%s_07.png' %(str(i[34:36])))


    plt.close()
    
