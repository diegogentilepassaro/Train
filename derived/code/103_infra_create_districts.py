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

# path=r"C:\Users\Cote\Dropbox\Documents\Economia\__Brown\Research\Trains\Train\derived\code"
path=r"C:\Users\diegog\Desktop\Diego\Train\derived\code"
os.chdir(path)

pathInput=r"../../raw_data"
pathOutput=r"../output"
pathTemp=r"../temp"

##Intersection + add length


#railroads: larkin plan + 1979 status
input = pathInput + r"/georef/railroads/larkin_plan_1979.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_lp79.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_lp79_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

#roads: paved+gravel 1954;1970;1986

input = pathInput + r"/georef/roads/comparacion_54_70_86.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_roadsall.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_roadsall_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

#roads: 1954
input = pathInput + r"/georef/roads/red_vial_1954.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_roads54.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_roads54_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

#roads: 1970
input = pathInput + r"/georef/roads/red_vial_1970.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_roads70.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_roads70_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

#roads: 1986
input = pathInput + r"/georef/roads/red_vial_1986.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/inter_roads86.shp"
parameters={'INPUT':input,'OVERLAY':overlay,'INPUT_FIELDS':[],'OVERLAY_FIELDS':[],'OVERLAY_FIELDS_PREFIX':'','OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\inter_roads86_l.shp'
parameters={'INPUT':input,'FIELD_NAME':'length_meters','FIELD_TYPE':0,'FIELD_LENGTH':10,'FIELD_PRECISION':3,'NEW_FIELD':True,'FORMULA':' $length ','OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

# Hypothetical network LCP
input = pathTemp + r"/LCP_MST.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/hypo_LCP_MST_temp.shp"
parameters={'INPUT':input,
	'OVERLAY':overlay,
	'INPUT_FIELDS':[],
	'OVERLAY_FIELDS':[],
	'OVERLAY_FIELDS_PREFIX':'',
	'OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\hypo_LCP_MST.shp'
parameters={'INPUT':input,
	'FIELD_NAME':'length_meters',
	'FIELD_TYPE':0,
	'FIELD_LENGTH':10,
	'FIELD_PRECISION':3,
	'NEW_FIELD':True,
	'FORMULA':' $length ',
	'OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

# Hypothetical network EUC
input = pathTemp + r"/EUC_MST.shp"
overlay = pathTemp + r"/geo2_ar1970_2010_fix.shp"
output= pathTemp + r"/hypo_EUC_MST_temp.shp"
parameters={'INPUT':input,
	'OVERLAY':overlay,
	'INPUT_FIELDS':[],
	'OVERLAY_FIELDS':[],
	'OVERLAY_FIELDS_PREFIX':'',
	'OUTPUT':output}
processing.run("native:intersection", parameters)

input = output
output=pathTemp + r'\\hypo_EUC_MST.shp'
parameters={'INPUT':input,
	'FIELD_NAME':'length_meters',
	'FIELD_TYPE':0,
	'FIELD_LENGTH':10,
	'FIELD_PRECISION':3,
	'NEW_FIELD':True,
	'FORMULA':' $length ',
	'OUTPUT':output}
processing.run("qgis:fieldcalculator", parameters)

#### Legacy instruments
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
