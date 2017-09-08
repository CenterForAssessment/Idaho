###########################################################
###
### Idaho SGP Analysis
###
###########################################################

### Load SGP Package

require(SGP)


### Load data

load("Data/Idaho_Data_LONG.Rdata")


### Calculate SGPs

Idaho_SGP <- abcSGP(
		Idaho_Data_LONG,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "summarizeSGP", "visualizeSGP", "outputSGP"),
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		save.intermediate.results=TRUE,
		sgp.target.scale.scores=TRUE,
		sgPlot.demo.report=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2, PROJECTIONS=2, LAGGED_PROJECTIONS=2, SGP_SCALE_SCORE_TARGETS=2, SUMMARY=2, GA_PLOTS=2, SG_PLOTS=1)))


### Save results

save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
