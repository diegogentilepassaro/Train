from qgis.core import *
from qgis.utils import iface
import os
import processing
from osgeo import gdal
from qgis.analysis import QgsZonalStatistics
import os
from qgis.core import QgsRasterLayer, QgsCoordinateReferenceSystem
import datetime


print(datetime.datetime.now())
print('Estimated duration: 50 min')

path=r"C:\Users\Cote\Dropbox\Documents\Economia\__Brown\Research\Trains\Train\derived\code"
#path=r"C:\Users\diegog\Desktop\Diego\Train\derived\code"
os.chdir(path)

pathInput=r"../../raw_data"
pathOutput=r"../output"
pathTemp=r"../temp"

#fix geometry of main shapefile
input=pathInput+r"\\IPUMS\\geo2_ar1970_2010\\geo2_ar1970_2010.shp"
output=pathTemp+r"\geo2_ar1970_2010_fix.shp"
parameters={'INPUT':input,'OUTPUT':output}
processing.run("native:fixgeometries", parameters)

print('Caloric Suit Pre')
#CALORIC SUIT - PRE1500

window='-107.45489677055934,4.444164213895654,-83.9458172385535,-16.078893168426397 [EPSG:4326]'
input = pathInput+r"\geo_controls\pre1500AverageCalories.tif"
output = pathTemp+r"\preCal_clipped.tif"
parameters={'INPUT':input,'PROJWIN':window,'NODATA':None,'OPTIONS':'','DATA_TYPE':0,'OUTPUT':output}
processing.run("gdal:cliprasterbyextent", parameters)

input=pathTemp+r"\preCal_clipped.tif"
output=pathTemp+r"\preCal.shp"
parameters={'INPUT_RASTER':input,'RASTER_BAND':1,'FIELD_NAME':'VALUE','OUTPUT':output}
processing.run("native:pixelstopolygons", parameters)

input=output
over=pathTemp+r"\geo2_ar1970_2010_fix.shp"
output=pathTemp+r"\preCal_"+r"inter.shp"
parameters={'INPUT':input,'OVERLAY':over,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OUTPUT':output}
processing.run("native:intersection", parameters)

input=output
output=pathTemp+r'\use_preCal'+r'_d.shp'
fieldname='weightA'
parameters={'INPUT': input,'FIELD_NAME': fieldname,'FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':'$area','OUTPUT': output}
processing.run("qgis:fieldcalculator", parameters)

#CALORIC SUIT - POST1500
print('Caloric Suit Post')

window='-107.45489677055934,4.444164213895654,-83.9458172385535,-16.078893168426397 [EPSG:4326]'
input = pathInput+r"\geo_controls\post1500AverageCalories.tif"
output = pathTemp+r"\postCal_clipped.tif"
parameters={'INPUT':input,'PROJWIN':window,'NODATA':None,'OPTIONS':'','DATA_TYPE':0,'OUTPUT':output}
processing.run("gdal:cliprasterbyextent", parameters)

input=pathTemp+r"\postCal_clipped.tif"
output=pathTemp+r"\postCal.shp"
parameters={'INPUT_RASTER':input,'RASTER_BAND':1,'FIELD_NAME':'VALUE','OUTPUT':output}
processing.run("native:pixelstopolygons", parameters)

input=output
over=pathTemp+r"\geo2_ar1970_2010_fix.shp"
output=pathTemp+r"\postCal_"+r"inter.shp"
parameters={'INPUT':input,'OVERLAY':over,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OUTPUT':output}
processing.run("native:intersection", parameters)

input=output
output=pathTemp+r'\use_postCal'+r'_d.shp'
fieldname='weightA'
parameters={'INPUT': input,'FIELD_NAME': fieldname,'FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':'$area','OUTPUT': output}
processing.run("qgis:fieldcalculator", parameters)

#WHEAT
print('wheat')
window='-107.45489677055934,4.444164213895654,-83.9458172385535,-16.078893168426397 [EPSG:4326]'
input = pathInput+r"\geo_controls\wheatlo.tif"
output = pathTemp+r"\wheat_clipped.tif"
parameters={'INPUT':input,'PROJWIN':window,'NODATA':None,'OPTIONS':'','DATA_TYPE':0,'OUTPUT':output}
processing.run("gdal:cliprasterbyextent", parameters)

input=pathTemp+r"\wheat_clipped.tif"
output=pathTemp+r"\wheat.shp"
parameters={'INPUT_RASTER':input,'RASTER_BAND':1,'FIELD_NAME':'VALUE','OUTPUT':output}
processing.run("native:pixelstopolygons", parameters)

input=output
over=pathTemp+r"\geo2_ar1970_2010_fix.shp"
output=pathTemp+r"\wheat_"+r"inter.shp"
parameters={'INPUT':input,'OVERLAY':over,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OUTPUT':output}
processing.run("native:intersection", parameters)

input=output
output=pathTemp+r'\use_wheat'+r'_d.shp'
fieldname='weightA'
parameters={'INPUT': input,'FIELD_NAME': fieldname,'FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':'$area','OUTPUT': output}
processing.run("qgis:fieldcalculator", parameters)


#ELEVATION
print('elevation')
input=[pathInput+r"\geo_controls\gt30w060s10.tif", pathInput+r"\geo_controls\gt30w100s10.tif"]
output=pathTemp+r"/elevation_arg.tif"
parameters={'INPUT':input,'PCT':False,'SEPARATE':False,'NODATA_INPUT':None,'NODATA_OUTPUT':None,'OPTIONS':'','DATA_TYPE':5,'OUTPUT':output}
processing.run("gdal:merge", parameters)

input=output
output = pathTemp+r"\r_elev_clipped.tif"
parameters={'INPUT':input,'PROJWIN':window,'NODATA':None,'OPTIONS':'','DATA_TYPE':0,'OUTPUT':output}
processing.run("gdal:cliprasterbyextent", parameters)

##NIGHTLIGHT 1992
#print('nightlights 1992')
#input=pathInput+r"\geo_controls\F101992stable.tif"
#output = pathTemp+r"\r_NL92_clipped.tif"
#parameters={'INPUT':input,'PROJWIN':window,'NODATA':None,'OPTIONS':'','DATA_TYPE':0,'OUTPUT':output}
#processing.run("gdal:cliprasterbyextent", parameters)

#RUGGEDNESS
print('rugged')
input=pathInput+r"\geo_controls\tri.tif"
output = pathTemp+r"\r_rugged_clipped.tif"
parameters={'INPUT':input,'PROJWIN':window,'NODATA':None,'OPTIONS':'','DATA_TYPE':0,'OUTPUT':output}
processing.run("gdal:cliprasterbyextent", parameters)


raster=["elev", "rugged"]#, "NL92"]
print('zonal stats')
for s in raster:
    print('Zonal statistics:', s)
    input=pathTemp+r'\r_'+s+r'_clipped.tif'
    vector=pathTemp+r"\geo2_ar1970_2010_fix.shp"
    stats=[0,1,2,3,4,5,6]
    parameters={'INPUT_RASTER':input,'RASTER_BAND':1,'INPUT_VECTOR':vector,'COLUMN_PREFIX':s+r'_','STATS':stats}
    processing.run("qgis:zonalstatistics", parameters)

#AVERAGE DISTANCE TO BUENOS AIRES
print('BA distance')

input=pathTemp+r"\geo2_ar1970_2010_fix.shp"
output=pathTemp+r"\geo2_ar1970_2010_centroids.shp"
parameters={'INPUT':input,'ALL_PARTS':False,'OUTPUT':output}
processing.run("native:centroids", parameters)

input=pathInput+r"/geo_controls/areas_de_asentamientos_y_edificios_020105.shp"
value='Gran Buenos Aires'
field='fna'
output=pathTemp+r"\BuenosAires.shp"
parameters={'INPUT':input,'FIELD':field,'OPERATOR':0,'VALUE':value,'OUTPUT':output}
processing.run("native:extractbyattribute", parameters)

input=output
output=pathTemp+r"\BuenosAires_fixed.shp"
parameters={'INPUT':input,'OUTPUT':output}
processing.run("native:fixgeometries", parameters)

input=output
output=pathTemp+r"\BuenosAirescentroid.shp"
parameters={'INPUT':input,'ALL_PARTS':False,'OUTPUT':output}
processing.run("native:centroids", parameters)

input=pathTemp+r"\geo2_ar1970_2010_centroids.shp"
hubs=pathTemp+r"\BuenosAirescentroid.shp"
field='entidad'
output=pathTemp+r"\BAdist_districts.shp"
parameters={'INPUT':input,'HUBS':hubs,'FIELD':field,'UNIT':3,'OUTPUT':output}
processing.run("qgis:distancetonearesthubpoints", parameters)

#AREA - m2: ALREADY IN ATTRIBUTES

print('End of .py')
print(datetime.datetime.now())
os.kill(os.getpid(), 9)
