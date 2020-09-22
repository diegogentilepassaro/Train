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
path=r"C:\Users\diegog\Desktop\Diego\Train\derived\code"
os.chdir(path)

pathInput=r"../../raw_data"
pathOutput=r"../output"
pathTemp=r"../temp"

# Create shapefile exterior_pais
input = pathInput + r"/georef/generic_argentina/shapefiles/restopais.shp"
overlay = pathInput + r"/georef/generic_argentina/shapefiles/pais.shp"
output = pathTemp + r'\\exterior_pais.shp'
processing.run("native:difference", {'INPUT':input,'OVERLAY':overlay,'OUTPUT':output})

#	Rasterize shapefiles
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/pais.dbf", pathTemp + r"/pais.dbf")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/pais.prj", pathTemp + r"/pais.prj")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/pais.shp", pathTemp + r"/pais.shp")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/pais.shx", pathTemp + r"/pais.shx")
layer_input = iface.addVectorLayer(pathTemp + r"/pais.shp", '', 'ogr')
pv = layer_input.dataProvider()
pv.addAttributes([QgsField('rast', QVariant.Double)])
layer_input.updateFields()
expression = QgsExpression('1')
context = QgsExpressionContext()
context.appendScopes(QgsExpressionContextUtils.globalProjectLayerScopes(layer_input))
with edit(layer_input):
	for f in layer_input.getFeatures():
		context.setFeature(f)
		f['rast'] = expression.evaluate(context)
		layer_input.updateFeature(f)
output = pathTemp + r'\\pais.tif'
processing.run("gdal:rasterize", {'INPUT':pathTemp + r"/pais.shp",
	'FIELD':'rast','BURN':0,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
	'EXTENT':'-73.99999999999994,-24.999999999999943,-89.99999999999994,-21.781134793999968 [EPSG:4326]',
	'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'EXTRA':'','OUTPUT':output})

layer_input = iface.addVectorLayer(pathTemp + r'\\exterior_pais.shp', '', 'ogr')
pv = layer_input.dataProvider()
pv.addAttributes([QgsField('rast', QVariant.Double)])
layer_input.updateFields()
expression = QgsExpression('1000')
context = QgsExpressionContext()
context.appendScopes(QgsExpressionContextUtils.globalProjectLayerScopes(layer_input))
with edit(layer_input):
	for f in layer_input.getFeatures():
		context.setFeature(f)
		f['rast'] = expression.evaluate(context)
		layer_input.updateFeature(f)
output = pathTemp + r'\\exterior_pais.tif'
processing.run("gdal:rasterize", 
	{'INPUT':pathTemp + r'\\exterior_pais.shp','FIELD':'rast','BURN':0,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
	'EXTENT':'-81.85422635558515,-46.234142384660416,-57.824173773930674,-18.83037341566659 [EPSG:4326]',
	'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'OUTPUT':output})

copyfile(pathInput + r"/georef/generic_argentina/shapefiles/areas_de_asentamientos_y_edificios_020105.dbf", 
	pathTemp + r"/asentamientos.dbf")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/areas_de_asentamientos_y_edificios_020105.prj", 
	pathTemp + r"/asentamientos.prj")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/areas_de_asentamientos_y_edificios_020105.shp", 
	pathTemp + r"/asentamientos.shp")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/areas_de_asentamientos_y_edificios_020105.shx", 
	pathTemp + r"/asentamientos.shx")
layer_input = iface.addVectorLayer(pathTemp + r"/asentamientos.shp", '', 'ogr')
pv = layer_input.dataProvider()
pv.addAttributes([QgsField('rast', QVariant.Double)])
layer_input.updateFields()
expression = QgsExpression('25')
context = QgsExpressionContext()
context.appendScopes(QgsExpressionContextUtils.globalProjectLayerScopes(layer_input))
with edit(layer_input):
	for f in layer_input.getFeatures():
		context.setFeature(f)
		f['rast'] = expression.evaluate(context)
		layer_input.updateFeature(f)
output = pathTemp + r'\\asentamientos.tif'
processing.run("gdal:rasterize", 
	{'INPUT':pathTemp + r"/asentamientos.shp",'FIELD':'rast','BURN':0,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
	'EXTENT':'-72.89708309299994,-53.63873899999999,-54.848922356999935,-21.87500881899996 [EPSG:4326]',
	'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'OUTPUT':output})

copyfile(pathInput + r"/georef/generic_argentina/shapefiles/banados.dbf", pathTemp + r"/banados.dbf")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/banados.prj", pathTemp + r"/banados.prj")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/banados.sbn", pathTemp + r"/banados.sbn")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/banados.sbx", pathTemp + r"/banados.sbx")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/banados.shp", pathTemp + r"/banados.shp")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/banados.shx", pathTemp + r"/banados.shx")
layer_input = iface.addVectorLayer(pathTemp + r"/banados.shp", '', 'ogr')
pv = layer_input.dataProvider()
pv.addAttributes([QgsField('rast', QVariant.Double)])
layer_input.updateFields()
expression = QgsExpression('25')
context = QgsExpressionContext()
context.appendScopes(QgsExpressionContextUtils.globalProjectLayerScopes(layer_input))
with edit(layer_input):
	for f in layer_input.getFeatures():
		context.setFeature(f)
		f['rast'] = expression.evaluate(context)
		layer_input.updateFeature(f)
output = pathTemp + r'\\banados.tif'
processing.run("gdal:rasterize", 
	{'INPUT':pathTemp + r"/banados.shp",'FIELD':'rast','BURN':0,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
	'EXTENT':'-72.07939147949219,-55.73194885253906,-47.97042465209961,-21.998111724853516 [EPSG:4326]',
	'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'OUTPUT':output})

copyfile(pathInput + r"/georef/generic_argentina/shapefiles/cuerpos_de_agua.cpg", pathTemp + r"/cuerpos_de_agua.cpg")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/cuerpos_de_agua.dbf", pathTemp + r"/cuerpos_de_agua.dbf")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/cuerpos_de_agua.prj", pathTemp + r"/cuerpos_de_agua.prj")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/cuerpos_de_agua.shp", pathTemp + r"/cuerpos_de_agua.shp")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/cuerpos_de_agua.shx", pathTemp + r"/cuerpos_de_agua.shx")
layer_input = iface.addVectorLayer(pathTemp + r"/cuerpos_de_agua.shp", '', 'ogr')
pv = layer_input.dataProvider()
pv.addAttributes([QgsField('rast', QVariant.Double)])
layer_input.updateFields()
expression = QgsExpression('25')
context = QgsExpressionContext()
context.appendScopes(QgsExpressionContextUtils.globalProjectLayerScopes(layer_input))
with edit(layer_input):
	for f in layer_input.getFeatures():
		context.setFeature(f)
		f['rast'] = expression.evaluate(context)
		layer_input.updateFeature(f)
output = pathTemp + r'\\cuerpos_de_agua.tif'
processing.run("gdal:rasterize", 
	{'INPUT':pathTemp + r"/cuerpos_de_agua.shp",'FIELD':'rast','BURN':0,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
	'EXTENT':'-73.45678711,-54.36331177,-55.0887413,-22.15041924 [EPSG:4326]',
	'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'OUTPUT':output})

copyfile(pathInput + r"/georef/generic_argentina/shapefiles/cursos_de_agua.cpg", pathTemp + r"/cursos_de_agua.cpg")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/cursos_de_agua.dbf", pathTemp + r"/cursos_de_agua.dbf")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/cursos_de_agua.prj", pathTemp + r"/cursos_de_agua.prj")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/cursos_de_agua.shp", pathTemp + r"/cursos_de_agua.shp")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/cursos_de_agua.shx", pathTemp + r"/cursos_de_agua.shx")
layer_input = iface.addVectorLayer(pathTemp + r"/cursos_de_agua.shp", '', 'ogr')
pv = layer_input.dataProvider()
pv.addAttributes([QgsField('rast', QVariant.Double)])
layer_input.updateFields()
expression = QgsExpression('25')
context = QgsExpressionContext()
context.appendScopes(QgsExpressionContextUtils.globalProjectLayerScopes(layer_input))
with edit(layer_input):
	for f in layer_input.getFeatures():
		context.setFeature(f)
		f['rast'] = expression.evaluate(context)
		layer_input.updateFeature(f)
output = pathTemp + r'\\cursos_de_agua.tif'
processing.run("gdal:rasterize", 
	{'INPUT':pathTemp + r"/cursos_de_agua.shp",'FIELD':'rast','BURN':0,'UNITS':0,'WIDTH':1000,'HEIGHT':1000,
	'EXTENT':'-73.40245056,-53.64107895,-55.05172729,-21.77843666 [EPSG:4326]',
	'NODATA':0,'OPTIONS':'','DATA_TYPE':5,'INIT':None,'INVERT':False,'OUTPUT':output})

# Merge rasters
output = pathTemp + r'\\bandas.tif'
processing.run("gdal:merge", 
	{'INPUT':[pathTemp + r'\\asentamientos.tif',
	pathTemp + r'\\banados.tif',
	pathTemp + r'\\cuerpos_de_agua.tif',
	pathTemp + r'\\cursos_de_agua.tif',
	pathTemp + r'\\exterior_pais.tif',
	pathTemp + r'\\pais.tif',
	pathInput + r'/georef/generic_argentina/rasters/pendiente_2.tif'],
	'PCT':False,'SEPARATE':True,'NODATA_INPUT':None,'NODATA_OUTPUT':None,'OPTIONS':'',
	'DATA_TYPE':5,'OUTPUT':output})

# Compute construction cost
bands_raster = QgsRasterLayer(pathTemp + r'\\bandas.tif')
output = pathTemp + r'\\construction_costs.tif'
entries = []
for num in range(1,8):
	ras = QgsRasterCalculatorEntry()
	ras.ref = 'bandas@' + str(num)
	ras.raster = bands_raster
	ras.bandNumber = num
	entries.append(ras)
calc = QgsRasterCalculator('bandas@1 + bandas@2 + bandas@3 + bandas@4 + bandas@5 + bandas@6 + bandas@7', 
	output,'GTiff', bands_raster.extent(), bands_raster.width(), 
	bands_raster.height(), entries)
calc.processCalculation()

# Create ids for shapefile capitals
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/capitales.cpg", pathTemp + r"/capitales.cpg")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/capitales.dbf", pathTemp + r"/capitales.dbf")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/capitales.prj", pathTemp + r"/capitales.prj")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/capitales.qpj", pathTemp + r"/capitales.qpj")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/capitales.shp", pathTemp + r"/capitales.shp")
copyfile(pathInput + r"/georef/generic_argentina/shapefiles/capitales.shx", pathTemp + r"/capitales.shx")
layer_input = iface.addVectorLayer(pathTemp + r"/capitales.shp", '', 'ogr')
pv = layer_input.dataProvider()
pv.addAttributes([QgsField('id', QVariant.Double)])
layer_input.updateFields()
context = QgsExpressionContext()
context.appendScopes(QgsExpressionContextUtils.globalProjectLayerScopes(layer_input))
count = 0
with edit(layer_input):
	for f in layer_input.getFeatures():
		count = count + 1
		expression = QgsExpression(str(count))
		context.setFeature(f)
		f['id'] = expression.evaluate(context)
		layer_input.updateFeature(f)

# Create shapefiles out of single capitals and compute a LCP for each capital point
for num in range(1,25):
	layers = QgsProject.instance().mapLayersByName('capitales')
	layer = layers[0]
	layer.selectByExpression('"id" = ' + str(num))
	fn = pathTemp + r"/capitales" + str(num) + ".shp"
	writer = QgsVectorFileWriter.writeAsVectorFormat(layer, fn, 'utf-8', 
		driverName = 'ESRI Shapefile', onlySelected = True)
	selected_layer = iface.addVectorLayer(fn, '', 'ogr')
	del(writer)
	output = pathTemp + r'\\LCP' + str(num) + '.shp'
	processing.run("Cost distance analysis:Least Cost Path", 
		{'INPUT_COST_RASTER':pathTemp + r'\\construction_costs.tif',
		'INPUT_RASTER_BAND':1,
		'INPUT_START_LAYER':pathTemp + r'\\capitales' + str(num) + '.shp',
		'INPUT_END_LAYER':pathTemp + r'\\capitales.shp',
		'BOOLEAN_FIND_LEAST_PATH_TO_ALL_ENDS':False,
		'BOOLEAN_OUTPUT_LINEAR_REFERENCE':False,
		'OUTPUT':output})

# Merge all LCPs
processing.run("native:mergevectorlayers", 
	{'LAYERS':[pathTemp + r'\\LCP1.shp',
	pathTemp + r'\\LCP2.shp',
	pathTemp + r'\\LCP3.shp',
	pathTemp + r'\\LCP4.shp',
	pathTemp + r'\\LCP5.shp',
	pathTemp + r'\\LCP6.shp',
	pathTemp + r'\\LCP7.shp',
	pathTemp + r'\\LCP8.shp',
	pathTemp + r'\\LCP9.shp',
	pathTemp + r'\\LCP10.shp',
	pathTemp + r'\\LCP11.shp',
	pathTemp + r'\\LCP12.shp',
	pathTemp + r'\\LCP13.shp',
	pathTemp + r'\\LCP14.shp',
	pathTemp + r'\\LCP15.shp',
	pathTemp + r'\\LCP16.shp',
	pathTemp + r'\\LCP17.shp',
	pathTemp + r'\\LCP18.shp',
	pathTemp + r'\\LCP19.shp',
	pathTemp + r'\\LCP20.shp',
	pathTemp + r'\\LCP21.shp',
	pathTemp + r'\\LCP22.shp',
	pathTemp + r'\\LCP23.shp',
	pathTemp + r'\\LCP24.shp'],
	'CRS':QgsCoordinateReferenceSystem('EPSG:4326'),
	'OUTPUT':pathTemp + r'\\LCP.shp'})

# Compute MST
processing.run("grass7:v.net.spanningtree", 
	{'input':pathTemp + r'\\LCP.shp',
	'points':None,
	'threshold':50,
	'arc_column':None,
	'node_column':None,
	'-g':False,
	'output':pathTemp + r'\\LCP_MST.shp',
	'GRASS_REGION_PARAMETER':None,
	'GRASS_SNAP_TOLERANCE_PARAMETER':-1,
	'GRASS_MIN_AREA_PARAMETER':0.0001,
	'GRASS_OUTPUT_TYPE_PARAMETER':0,
	'GRASS_VECTOR_DSCO':'',
	'GRASS_VECTOR_LCO':'',
	'GRASS_VECTOR_EXPORT_NOCAT':False})

# Crear matrix de distancia para computar MST euclideano
processing.run("qgis:distancematrix", 
	{'INPUT':pathTemp + r'\\capitales.shp',
	'INPUT_FIELD':'id',
	'TARGET':pathTemp + r'\\capitales.shp',
	'TARGET_FIELD':'id',
	'MATRIX_TYPE':0,
	'NEAREST_POINTS':0,
	'OUTPUT':pathTemp + r'\\distance_matrix.shp'})

# Create all possible bilateral lines between the 24 capitals
processing.run("native:hublines", 
	{'HUBS':pathTemp + r'\\capitales.shp',
	'HUB_FIELD':'id',
	'HUB_FIELDS':[],
	'SPOKES':pathTemp + r'\\distance_matrix.shp',
	'SPOKE_FIELD':'InputID',
	'SPOKE_FIELDS':[],
	'OUTPUT':pathTemp + r'\\bilateral_capitals_distances.shp'})

# Create MST of bilateral euclidean distances
processing.run("grass7:v.net.spanningtree", 
	{'input':pathTemp + r'\\bilateral_capitals_distances.shp',
	'points':None,
	'threshold':50,
	'arc_column':None,
	'node_column':None,
	'-g':False,
	'output':pathTemp + r'\\EUC_MST.shp',
	'GRASS_REGION_PARAMETER':None,
	'GRASS_SNAP_TOLERANCE_PARAMETER':-1,
	'GRASS_MIN_AREA_PARAMETER':0.0001,
	'GRASS_OUTPUT_TYPE_PARAMETER':0,
	'GRASS_VECTOR_DSCO':'',
	'GRASS_VECTOR_LCO':'',
	'GRASS_VECTOR_EXPORT_NOCAT':False})

print('End of .py')
print(datetime.datetime.now())
os.kill(os.getpid(), 9)
