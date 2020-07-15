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
os.chdir(path)

pathInput=r"../../raw_data"
pathOutput=r"../output"
pathTemp=r"../temp"

##Intersection + add length


#railroads: larkin plan + 1979 status
input = pathInput + r"/georef/output/shapefiles/larkin_plan_1979.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_lp79.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_lp79_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

#roads: 1954
input = pathInput + r"/shapefiles_to_check/red_vial_1954.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_roads54.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_roads54_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

#roads: 1896
input = pathInput + r"/shapefiles_to_check/red_vial_1986.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_roads86.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_roads86_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

#hypothetical network 1
input = pathInput + r"/perez/output/hypo_CMST_network.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_hypoCMST.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_hypoCMST_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

#hypothetical network 2
input = pathInput + r"/perez/output/hypo_EMST_network.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_hypoEMST.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_hypoEMST_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

#hypothetical network 3
input = pathInput + r"/perez/output/hypo_mean_EMST_network.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_hypomeanEMST.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_hypomeanEMST_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)


print('End of .py')
print(datetime.datetime.now())
os.kill(os.getpid(), 9)
