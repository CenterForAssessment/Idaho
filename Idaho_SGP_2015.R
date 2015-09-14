###########################################################
###
### Idaho SGP Analysis for 2015
###
###########################################################

### Load SGP Package

require(SGP)


### Load previous SGP object 

load("Data/Idaho_SGP.Rdata")


### Load 2015 Data and create object Idaho_Data_LONG_2015



### Configuration if using different CONTENT_AREA labels for READING (2014 and prior) and ELA (2015)

Idaho_2015.config <- list(
        ELA.2015 = list(
                sgp.content.areas=c('READING', 'READING', 'READING', 'READING', 'ELA'),
                sgp.panel.years=c('2010', '2011' '2012', '2013', '2015'),
                sgp.grade.sequences=list(c('3', '5'), c('3', '4', '6'), c('3', '4', '5', '7'), c('3', '4', '5', '6', '8'), c('4', '5', '6', '7', '9'), c('5', '6', '7', '8', '10'))),
        MATHEMATICS.2015 = list(
                sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
                sgp.panel.years=c('2010', '2011' '2012', '2013', '2015'),
                sgp.grade.sequences=list(c('3', '5'), c('3', '4', '6'), c('3', '4', '5', '7'), c('3', '4', '5', '6', '8'), c('4', '5', '6', '7', '9'), c('5', '6', '7', '8', '10'))))


### Update SGPs

Idaho_SGP <- updateSGP(
			Idaho_SGP,
			Idaho_Data_LONG_2015,
			sgPlot.demo.report=TRUE)#,
#			parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SUMMARY=4, GA_PLOTS=4, SG_PLOTS=1)))


### Save results

save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
