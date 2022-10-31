##########################################################################################
###
### Script for calculating SGPs for 2019-2020 WIDA/ACCESS Idaho
###
##########################################################################################

### Load SGP package
require(SGP)


### Load Data
load("Data/WIDA_ID_SGP.Rdata")
load("Data/WIDA_ID_Data_LONG_2020.Rdata")


### Run analyses
WIDA_ID_SGP <- updateSGP(
		WIDA_ID_SGP,
		WIDA_ID_Data_LONG_2020,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "visualizeSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=TRUE,
		sgp.projections.baseline=TRUE,
		sgp.projections.lagged.baseline=TRUE,
		get.cohort.data.info=TRUE,
		sgp.target.scale.scores=TRUE,
		plot.types=c("growthAchievementPlot", "studentGrowthPlot"),
		sgPlot.demo.report=TRUE,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1)))


### Save results
save(WIDA_ID_SGP, file="Data/WIDA_ID_SGP.Rdata")
