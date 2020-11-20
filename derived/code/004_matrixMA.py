from qgis.core import *
from qgis.utils import iface
import os
import processing
from osgeo import gdal
from qgis.analysis import *
import os
import datetime
from shutil import copyfile
from PyQt5.QtCore import *
from qgis.PyQt.QtCore import *

print(datetime.datetime.now())

# path=r"C:\Users\Cote\Dropbox\Documents\Economia\__Brown\Research\Trains\Train\derived\code"
path=r"D:\cotebelmar\Dropbox\Documents\Economia\__Brown\Research\Trains\Train\derived\code"

#path=r"C:\Users\diegog\Desktop\Diego\Train\derived\code"
os.chdir(path)

pathInput=r"../../raw_data"
pathOutput=r"../output"
pathTemp=r"../temp"

#RASTERIZE RAILROADS BY YEAR
input=pathInput + r"\\georef\\railroads\\larkin_plan_1979.shp"
output=pathTemp + r"\\rails_79.shp"
processing.run("native:extractbyattribute", {'INPUT':input,'FIELD':'status1979','OPERATOR':0,'VALUE':'1','OUTPUT':output})

input=output
output=pathTemp + r"\\rails_79.tif"
processing.run("gdal:rasterize", {'INPUT':input,'FIELD':None,'BURN':1,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
                                  'EXTENT':'-81.85422635558515,-46.234142384660416,-57.82417377393067,-18.83037341566659 [EPSG:4326]',
                                  'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'EXTRA':'','OUTPUT':output})

input=output
output=pathTemp + r"\\rails_79n.tif"
parameters={'map':input,'setnull':'','null':-9,'-f':False,'-i':False,'-n':False,'-c':False,'-r':False,'output':output,'GRASS_REGION_PARAMETER':None,'GRASS_REGION_CELLSIZE_PARAMETER':0,'GRASS_RASTER_FORMAT_OPT':'','GRASS_RASTER_FORMAT_META':''}
processing.run("grass7:r.null", parameters)


input=pathInput + r"\\georef\\railroads\\larkin_plan_1979.shp"
output=pathTemp + r"\\rails_76.shp"
processing.run("native:extractbyattribute",
               {'INPUT':input,'FIELD':'status1979','OPERATOR':5,'VALUE':'2','OUTPUT':output})
input=output
output=pathTemp + r"\\rails_76.tif"
processing.run("gdal:rasterize", {'INPUT':input,'FIELD':None,'BURN':1,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
                                  'EXTENT':'-81.85422635558515,-46.234142384660416,-57.82417377393067,-18.83037341566659 [EPSG:4326]',
                                  'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'EXTRA':'','OUTPUT':output})

input=output
output=pathTemp + r"\\rails_76n.tif"
parameters={'map':input,'setnull':'','null':-9,'-f':False,'-i':False,'-n':False,'-c':False,'-r':False,'output':output,'GRASS_REGION_PARAMETER':None,'GRASS_REGION_CELLSIZE_PARAMETER':0,'GRASS_RASTER_FORMAT_OPT':'','GRASS_RASTER_FORMAT_META':''}
processing.run("grass7:r.null", parameters)

input=pathInput + r"\\georef\\railroads\\larkin_plan_1979.shp"
output=pathTemp + r"\\rails_60.shp"
processing.run("native:extractbyattribute",
               {'INPUT':input,'FIELD':'status1979','OPERATOR':5,'VALUE':'3','OUTPUT':output})
input=output
output=pathTemp + r"\\rails_60.tif"
processing.run("gdal:rasterize", {'INPUT':input,'FIELD':None,'BURN':1,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
                                  'EXTENT':'-81.85422635558515,-46.234142384660416,-57.82417377393067,-18.83037341566659 [EPSG:4326]',
                                  'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'EXTRA':'','OUTPUT':output})

input=output
output=pathTemp + r"\\rails_60n.tif"
parameters={'map':input,'setnull':'','null':-9,'-f':False,'-i':False,'-n':False,'-c':False,'-r':False,'output':output,'GRASS_REGION_PARAMETER':None,'GRASS_REGION_CELLSIZE_PARAMETER':0,'GRASS_RASTER_FORMAT_OPT':'','GRASS_RASTER_FORMAT_META':''}
processing.run("grass7:r.null", parameters)

#RASTERIZE ROADS
input=pathInput + r"\\georef\\roads\\red_vial_1954.shp"
output=pathTemp + r"\\roads_54.tif"
processing.run("gdal:rasterize", {'INPUT':input,'FIELD':None,'BURN':1,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
                                  'EXTENT':'-81.85422635558515,-46.234142384660416,-57.82417377393067,-18.83037341566659 [EPSG:4326]',
                                  'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'EXTRA':'','OUTPUT':output})

input=output
output=pathTemp + r"\\roads_54n.tif"
parameters={'map':input,'setnull':'','null':-9,'-f':False,'-i':False,'-n':False,'-c':False,'-r':False,'output':output,'GRASS_REGION_PARAMETER':None,'GRASS_REGION_CELLSIZE_PARAMETER':0,'GRASS_RASTER_FORMAT_OPT':'','GRASS_RASTER_FORMAT_META':''}
processing.run("grass7:r.null", parameters)

input=pathInput + r"\\georef\\roads\\red_vial_1970.shp"
output=pathTemp + r"\\roads_70.tif"
processing.run("gdal:rasterize", {'INPUT':input,'FIELD':None,'BURN':1,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
                                  'EXTENT':'-81.85422635558515,-46.234142384660416,-57.82417377393067,-18.83037341566659 [EPSG:4326]',
                                  'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'EXTRA':'','OUTPUT':output})

input=output
output=pathTemp + r"\\roads_70n.tif"
parameters={'map':input,'setnull':'','null':-9,'-f':False,'-i':False,'-n':False,'-c':False,'-r':False,'output':output,'GRASS_REGION_PARAMETER':None,'GRASS_REGION_CELLSIZE_PARAMETER':0,'GRASS_RASTER_FORMAT_OPT':'','GRASS_RASTER_FORMAT_META':''}
processing.run("grass7:r.null", parameters)


input=pathInput + r"\\georef\\roads\\red_vial_1986.shp"
output=pathTemp + r"\\roads_86.tif"
processing.run("gdal:rasterize", {'INPUT':input,'FIELD':None,'BURN':1,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
                                  'EXTENT':'-81.85422635558515,-46.234142384660416,-57.82417377393067,-18.83037341566659 [EPSG:4326]',
                                  'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'EXTRA':'','OUTPUT':output})

input=output
output=pathTemp + r"\\roads_86n.tif"
parameters={'map':input,'setnull':'','null':-9,'-f':False,'-i':False,'-n':False,'-c':False,'-r':False,'output':output,'GRASS_REGION_PARAMETER':None,'GRASS_REGION_CELLSIZE_PARAMETER':0,'GRASS_RASTER_FORMAT_OPT':'','GRASS_RASTER_FORMAT_META':''}
processing.run("grass7:r.null", parameters)

#CREATING COST RASTERS

#1960
landprice='100'
#exteriorprice=500
railprice='1'
roadprice='0.5'

##1960 - total
#output=pathTemp+r"\MAcost60_both.tif"
#inputA=pathTemp+r"\rails_60n.tif"
#inputB=pathTemp+r"\roads_54n.tif"
#formula=landprice+'*(A==-9)*(B==-9)+'+railprice+'*(A==1)*(B==-9)+'+railprice+'*(A==1)*(B==1)+'+roadprice+'*(A==-9)*(B==1)'
#
#parameters={'INPUT_A':inputA,'BAND_A':1,'INPUT_B':inputB,'BAND_B':1,'FORMULA':formula,'NO_DATA':-9,'RTYPE':5,'OPTIONS':'','OUTPUT':output}
#processing.run("gdal:rastercalculator", parameters)
#

#1960 - rails
output=pathTemp+r"\MAcost60_rails.tif"
inputA=pathTemp+r"\rails_60n.tif"
inputB=pathTemp+r"\roads_54n.tif"
formula=landprice+'*(A==-9)+'+railprice+'*(A==1)'

parameters={'INPUT_A':inputA,'BAND_A':1,'INPUT_B':inputB,'BAND_B':1,'FORMULA':formula,'NO_DATA':-9,'RTYPE':5,'OPTIONS':'','OUTPUT':output}
processing.run("gdal:rastercalculator", parameters)

#1954 - roads
output=pathTemp+r"\MAcost54_roads.tif"
inputA=pathTemp+r"\rails_60n.tif"
inputB=pathTemp+r"\roads_54n.tif"
formula=landprice+'*(B==-9)+'+roadprice+'*(B==1)'

parameters={'INPUT_A':inputA,'BAND_A':1,'INPUT_B':inputB,'BAND_B':1,'FORMULA':formula,'NO_DATA':-9,'RTYPE':5,'OPTIONS':'','OUTPUT':output}
processing.run("gdal:rastercalculator", parameters)

#1976 - rails
output=pathTemp+r"\MAcost76_rails.tif"
inputA=pathTemp+r"\rails_76n.tif"
inputB=pathTemp+r"\roads_70n.tif"
formula=landprice+'*(A==-9)+'+railprice+'*(A==1)'

parameters={'INPUT_A':inputA,'BAND_A':1,'INPUT_B':inputB,'BAND_B':1,'FORMULA':formula,'NO_DATA':-9,'RTYPE':5,'OPTIONS':'','OUTPUT':output}
processing.run("gdal:rastercalculator", parameters)

#1970 - roads
output=pathTemp+r"\MAcost70_roads.tif"
inputA=pathTemp+r"\rails_76n.tif"
inputB=pathTemp+r"\roads_70n.tif"
formula=landprice+'*(B==-9)+'+roadprice+'*(B==1)'

parameters={'INPUT_A':inputA,'BAND_A':1,'INPUT_B':inputB,'BAND_B':1,'FORMULA':formula,'NO_DATA':-9,'RTYPE':5,'OPTIONS':'','OUTPUT':output}
processing.run("gdal:rastercalculator", parameters)

#1979 - rails
output=pathTemp+r"\MAcost79_rails.tif"
inputA=pathTemp+r"\rails_79n.tif"
inputB=pathTemp+r"\roads_86n.tif"
formula=landprice+'*(A==-9)+'+railprice+'*(A==1)'

parameters={'INPUT_A':inputA,'BAND_A':1,'INPUT_B':inputB,'BAND_B':1,'FORMULA':formula,'NO_DATA':-9,'RTYPE':5,'OPTIONS':'','OUTPUT':output}
processing.run("gdal:rastercalculator", parameters)

#1986 - roads
output=pathTemp+r"\MAcost86_roads.tif"
inputA=pathTemp+r"\rails_79n.tif"
inputB=pathTemp+r"\roads_86n.tif"
formula=landprice+'*(B==-9)+'+roadprice+'*(B==1)'

parameters={'INPUT_A':inputA,'BAND_A':1,'INPUT_B':inputB,'BAND_B':1,'FORMULA':formula,'NO_DATA':-9,'RTYPE':5,'OPTIONS':'','OUTPUT':output}
processing.run("gdal:rastercalculator", parameters)

#origins and destinations

#input=pathTemp + r"\\geo2_ar1970_2010_centroids.shp"
#output=pathTemp + r"\\sample_centroids.shp"
#parameters={'INPUT':input,'FIELD':'PARENT','OPERATOR':0,'VALUE':'038','OUTPUT':output}
#processing.run("native:extractbyattribute", parameters)

#input=output
input=pathTemp + r"\\geo2_ar1970_2010_centroids.shp"
output=pathTemp + r"\\geo2_ar1970_2010_centroids_clean1.shp"
parameters={'INPUT':input,'FIELD':'GEOLEVEL2','OPERATOR':1,'VALUE':'032030000','OUTPUT':output}
processing.run("native:extractbyattribute", parameters)

input=output
output=pathTemp + r"\\geo2_ar1970_2010_centroids_clean2.shp"
parameters={'INPUT':input,'FIELD':'GEOLEVEL2','OPERATOR':1,'VALUE':'238094004','OUTPUT':output}
processing.run("native:extractbyattribute", parameters)

input=output
output=pathTemp + r"\\geo2_ar1970_2010_centroids_clean3.shp"
parameters={'INPUT':input,'FIELD':'GEOLEVEL2','OPERATOR':1,'VALUE':'239094003','OUTPUT':output}
processing.run("native:extractbyattribute", parameters)

input=output
output=pathTemp + r"\\centroids.shp"
dropvars=['elev_count','elev_sum','elev_mean','elev_media','elev_stdev','elev_min','elev_max','rugged_cou','rugged_sum','rugged_mea','rugged_med','rugged_std','rugged_min','rugged_max']
parameters={'INPUT':input,'COLUMN':dropvars,'OUTPUT':output}
processing.run("qgis:deletecolumn", parameters)

input=output
output=pathTemp + r"\\centroids_ID.shp"
parameters = {'INPUT':input,'FIELD_NAME':'AUTO','START':0,'GROUP_FIELDS':[],'SORT_EXPRESSION':'','SORT_ASCENDING':True,'SORT_NULLS_FIRST':False,'OUTPUT':output}
processing.run("native:addautoincrementalfield", parameters)

##CALCULO MA

#1960 - rails
costraster=pathTemp+r"\MAcost60_rails.tif"
points=pathTemp + r"\\centroids_ID.shp"
for num in range(312):
    input=points
    output=pathTemp+'\\centroid_'+str(num)+'.shp'
    parameters={'INPUT':points,'FIELD':'AUTO','OPERATOR':0,'VALUE':num,'OUTPUT':output}
    processing.run("native:extractbyattribute", parameters)

    input_start=output
    output = pathTemp + r'\\MA_1960rails_LCP_' + str(num) + '.shp'
    processing.run("Cost distance analysis:Least Cost Path",
        {'INPUT_COST_RASTER':costraster,
        'INPUT_RASTER_BAND':1,
        'INPUT_START_LAYER':input_start,
        'INPUT_END_LAYER':points,
        'BOOLEAN_FIND_LEAST_PATH_TO_ALL_ENDS':False,
        'BOOLEAN_OUTPUT_LINEAR_REFERENCE':False,
        'OUTPUT':output})
    n=num+1
    print(datetime.datetime.now())
    print('cost-distance matrix '+str(n)+' of 312; 1960 - rails')

#1954 - roads
costraster=pathTemp+r"\MAcost54_roads.tif"
for num in range(312):
    input_start=pathTemp+'\\centroid_'+str(num)+'.shp'
    output = pathTemp + r'\\MA_1954roads_LCP_' + str(num) + '.shp'
    processing.run("Cost distance analysis:Least Cost Path",
        {'INPUT_COST_RASTER':costraster,
        'INPUT_RASTER_BAND':1,
        'INPUT_START_LAYER':input_start,
        'INPUT_END_LAYER':points,
        'BOOLEAN_FIND_LEAST_PATH_TO_ALL_ENDS':False,
        'BOOLEAN_OUTPUT_LINEAR_REFERENCE':False,
        'OUTPUT':output})
    n=num+1
    print(datetime.datetime.now())
    print('cost-distance matrix '+str(n)+' of 312; 1954 - roads')

#1976 - rails
costraster=pathTemp+r"\MAcost76_rails.tif"
#for num in range(312):
for num in range(230,312):
    input_start=pathTemp+'\\centroid_'+str(num)+'.shp'
    output = pathTemp + r'\\MA_1976rails_LCP_' + str(num) + '.shp'
    processing.run("Cost distance analysis:Least Cost Path",
        {'INPUT_COST_RASTER':costraster,
        'INPUT_RASTER_BAND':1,
        'INPUT_START_LAYER':input_start,
        'INPUT_END_LAYER':points,
        'BOOLEAN_FIND_LEAST_PATH_TO_ALL_ENDS':False,
        'BOOLEAN_OUTPUT_LINEAR_REFERENCE':False,
        'OUTPUT':output})
    n=num+1
    print(datetime.datetime.now())
    print('cost-distance matrix '+str(n)+' of 312; 1976 - rails')

#1970 - roads
costraster=pathTemp+r"\MAcost70_roads.tif"
for num in range(312):
    input_start=pathTemp+'\\centroid_'+str(num)+'.shp'
    output = pathTemp + r'\\MA_1970roads_LCP_' + str(num) + '.shp'
    processing.run("Cost distance analysis:Least Cost Path",
        {'INPUT_COST_RASTER':costraster,
        'INPUT_RASTER_BAND':1,
        'INPUT_START_LAYER':input_start,
        'INPUT_END_LAYER':points,
        'BOOLEAN_FIND_LEAST_PATH_TO_ALL_ENDS':False,
        'BOOLEAN_OUTPUT_LINEAR_REFERENCE':False,
        'OUTPUT':output})
    n=num+1
    print(datetime.datetime.now())
    print('cost-distance matrix '+str(n)+' of 312; 1970 - roads')

#1979 - rails
costraster=pathTemp+r"\MAcost79_rails.tif"
for num in range(312):
    input_start=pathTemp+'\\centroid_'+str(num)+'.shp'
    output = pathTemp + r'\\MA_1979rails_LCP_' + str(num) + '.shp'
    processing.run("Cost distance analysis:Least Cost Path",
        {'INPUT_COST_RASTER':costraster,
        'INPUT_RASTER_BAND':1,
        'INPUT_START_LAYER':input_start,
        'INPUT_END_LAYER':points,
        'BOOLEAN_FIND_LEAST_PATH_TO_ALL_ENDS':False,
        'BOOLEAN_OUTPUT_LINEAR_REFERENCE':False,
        'OUTPUT':output})
    n=num+1
    print(datetime.datetime.now())
    print('cost-distance matrix '+str(n)+' of 312; 1979 - rails')

#1986 - roads
costraster=pathTemp+r"\MAcost86_roads.tif"
for num in range(312):
    input_start=pathTemp+'\\centroid_'+str(num)+'.shp'
    output = pathTemp + r'\\MA_1986roads_LCP_' + str(num) + '.shp'
    processing.run("Cost distance analysis:Least Cost Path",
        {'INPUT_COST_RASTER':costraster,
        'INPUT_RASTER_BAND':1,
        'INPUT_START_LAYER':input_start,
        'INPUT_END_LAYER':points,
        'BOOLEAN_FIND_LEAST_PATH_TO_ALL_ENDS':False,
        'BOOLEAN_OUTPUT_LINEAR_REFERENCE':False,
        'OUTPUT':output})
    n=num+1
    print(datetime.datetime.now())
    print('cost-distance matrix '+str(n)+' of 312; 1986 - roads')

print('End of .py')
print(datetime.datetime.now())
#os.kill(os.getpid(), 9)
#
