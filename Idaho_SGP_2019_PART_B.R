#######################################################################################
###                                                                                 ###
###   Idaho Learning Loss Analyses -- 2019 Cohort & Baseline Growth Percentiles     ###
###                                                                                 ###
#######################################################################################

###   Load packages
require(SGP)
require(data.table)

###   Load data
load("Data/Idaho_SGP.Rdata")
load("Data/Idaho_Data_LONG_2019.Rdata")

###   Add baseline matrices to SGPstateData
SGPstateData <- SGPmatrices::addBaselineMatrices("ID", "2021")

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=2, BASELINE_PERCENTILES=2, PROJECTIONS=2, LAGGED_PROJECTIONS=2, SGP_SCALE_SCORE_TARGETS=2))

###   Read in BASELINE percentiles configuration scripts and combine
source("SGP_CONFIG/2019/Percentiles/ELA.R")
source("SGP_CONFIG/2019/Percentiles/MATHEMATICS.R")

ID_2019_Baseline_Config <- c(
	ELA_2019.config,
	MATHEMATICS_2019.config
)

ID_2019_Baseline_Config_SKIP_YEAR <- c(
	ELA_2019_SKIP_YEAR.config,
	MATHEMATICS_2019_SKIP_YEAR.config
)

#####
###   Run BASELINE SGP analysis for SKIP_YEAR (one-year skip) 
###   create new Idaho_SGP object with historical data
#####

Idaho_SGP <- updateSGP(
        what_sgp_object = Idaho_SGP,
        with_sgp_data_LONG = Idaho_Data_LONG_2019,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP"),
        sgp.config = ID_2019_Baseline_Config_SKIP_YEAR,
        sgp.percentiles = FALSE,
        sgp.projections = FALSE,
        sgp.projections.lagged = FALSE,
        sgp.percentiles.baseline = TRUE,  #  Skip year SGPs for 2021 comparisons
        sgp.projections.baseline = FALSE, #  Calculated in last step
        sgp.projections.lagged.baseline = FALSE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config 
)

baseline.names <- setdiff(grep("BASELINE", names(Idaho_SGP@Data), value = TRUE), grep("SKIP_2_YEAR", names(Idaho_SGP@Data), value = TRUE))
setnames(Idaho_SGP@Data, baseline.names, paste0(baseline.names, "_SKIP_YEAR"))

sgps.2019 <- grep(".2019.BASELINE", names(Idaho_SGP@SGP[["SGPercentiles"]]))
names(Idaho_SGP@SGP[["SGPercentiles"]])[sgps.2019] <- gsub(".2019.BASELINE", ".2019.BASELINE.SKIP_YEAR", names(Idaho_SGP@SGP[["SGPercentiles"]])[sgps.2019])

#####
###   Run Cohort & BASELINE SGP analysis for consecutive year
###   create new Idaho_SGP object with historical data
#####

Idaho_SGP <- abcSGP(
        sgp_object = Idaho_SGP,
        steps = c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config = ID_2019_Baseline_Config,
        sgp.percentiles = TRUE,
        sgp.projections = TRUE,
        sgp.projections.lagged = TRUE,
        sgp.percentiles.baseline = TRUE,  # Consecutive year SGPs for 2022 comparisons
        sgp.projections.baseline = TRUE, # 
        sgp.projections.lagged.baseline = TRUE,
        sgp.target.scale.scores = TRUE,
        save.intermediate.results = FALSE,
        parallel.config = parallel.config
)



###   Save results
save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
