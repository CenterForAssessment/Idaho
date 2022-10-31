##########################################################################################
###
### Script for calculating SGPs for 2018 Idaho
###
##########################################################################################

### Load SGP package
require(SGP)
options(error=recover)
#options(warn=2)
#debug(analyzeSGP)

### Load Data
load("Data/Idaho_Data_LONG.Rdata")

###   Read in SGP Configuration Scripts and Combine
source("SGP_CONFIG/2018/ELA.R")
source("SGP_CONFIG/2018/MATHEMATICS.R")

ID_Config_2018 <- c(
  ELA_2018.config,
  MATHEMATICS_2018.config
)

### Modify SGPstateData temporarily
SGPstateData[["ID"]][["Growth"]][["System_Type"]] <- "Cohort Referenced"

### Run analyses
Idaho_SGP <- abcSGP(
		Idaho_Data_LONG,
		steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
		sgp.percentiles=TRUE,
		sgp.projections=TRUE,
		sgp.projections.lagged=TRUE,
		sgp.percentiles.baseline=FALSE,
		sgp.projections.baseline=FALSE,
		sgp.projections.lagged.baseline=FALSE,
		get.cohort.data.info=TRUE,
		sgp.target.scale.scores=TRUE,
		plot.types=c("growthAchievementPlot", "studentGrowthPlot"),
		sgPlot.demo.report=TRUE,
		sgp.config=ID_Config_2018,
		parallel.config=list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4, GA_PLOTS=1, SG_PLOTS=1)))


### Save results

save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
