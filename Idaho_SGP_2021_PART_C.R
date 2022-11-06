################################################################################
###                                                                          ###
###           SGP LAGGED projections for skip year SGP analyses for 2021     ###
###                                                                          ###
################################################################################

###   Load packages
require(SGP)
require(SGPmatrices)

###   Load data
load("Data/Idaho_SGP.Rdata")

###   Load configurations
source("SGP_CONFIG/2021/PART_C/ELA.R")
source("SGP_CONFIG/2021/PART_C/MATHEMATICS.R")

ID_CONFIG <- c(ELA_2021.config, MATHEMATICS_2021.config)

### Parameters
parallel.config <- list(BACKEND="PARALLEL", WORKERS=list(PERCENTILES=4, BASELINE_PERCENTILES=4, PROJECTIONS=4, LAGGED_PROJECTIONS=4, SGP_SCALE_SCORE_TARGETS=4))

###   Setup SGPstateData with baseline coefficient matrices grade specific projection sequences

###   Add Baseline matrices to SGPstateData and update SGPstateData
SGPstateData <- addBaselineMatrices("ID", "2021")
SGPstateData[["ID"]][["Growth"]][["System_Type"]] <- "Baseline Referenced"

#  Establish required meta-data for LAGGED projection sequences
SGPstateData[["ID"]][["SGP_Configuration"]][["grade.projection.sequence"]] <- list(
    ELA_GRADE_3=c(3, 4, 5, 6, 7, 8, 10),
    ELA_GRADE_4=c(3, 4, 5, 6, 7, 8, 10),
    ELA_GRADE_5=c(3, 5, 6, 7, 8, 10),
    ELA_GRADE_6=c(3, 4, 6, 7, 8, 10),
    ELA_GRADE_7=c(3, 4, 5, 7, 8, 10),
    ELA_GRADE_8=c(3, 4, 5, 6, 8, 10),
    ELA_GRADE_10=c(3, 4, 5, 6, 7, 8, 10),
    MATHEMATICS_GRADE_3=c(3, 4, 5, 6, 7, 8, 10),
    MATHEMATICS_GRADE_4=c(3, 4, 5, 6, 7, 8, 10),
    MATHEMATICS_GRADE_5=c(3, 5, 6, 7, 8, 10),
    MATHEMATICS_GRADE_6=c(3, 4, 6, 7, 8, 10),
    MATHEMATICS_GRADE_7=c(3, 4, 5, 7, 8, 10),
    MATHEMATICS_GRADE_8=c(3, 4, 5, 6, 8, 10),
    MATHEMATICS_GRADE_10=c(3, 4, 5, 6, 7, 8, 10))
SGPstateData[["ID"]][["SGP_Configuration"]][["content_area.projection.sequence"]] <- list(
    ELA_GRADE_3=rep("ELA", 7),
    ELA_GRADE_4=rep("ELA", 7),
    ELA_GRADE_5=rep("ELA", 6),
    ELA_GRADE_6=rep("ELA", 6),
    ELA_GRADE_7=rep("ELA", 6),
    ELA_GRADE_8=rep("ELA", 6),
    ELA_GRADE_10=rep("ELA", 7),
    MATHEMATICS_GRADE_3=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_4=rep("MATHEMATICS", 7),
    MATHEMATICS_GRADE_5=rep("MATHEMATICS", 6),
    MATHEMATICS_GRADE_6=rep("MATHEMATICS", 6),
    MATHEMATICS_GRADE_7=rep("MATHEMATICS", 6),
    MATHEMATICS_GRADE_8=rep("MATHEMATICS", 6),
    MATHEMATICS_GRADE_10=rep("MATHEMATICS", 7))
SGPstateData[["ID"]][["SGP_Configuration"]][["max.forward.projection.sequence"]] <- list(
    ELA_GRADE_3=3,
    ELA_GRADE_4=3,
    ELA_GRADE_5=3,
    ELA_GRADE_6=3,
    ELA_GRADE_7=3,
    ELA_GRADE_8=3,
    ELA_GRADE_10=3,
    MATHEMATICS_GRADE_3=3,
    MATHEMATICS_GRADE_4=3,
    MATHEMATICS_GRADE_5=3,
    MATHEMATICS_GRADE_6=3,
    MATHEMATICS_GRADE_7=3,
    MATHEMATICS_GRADE_8=3,
    MATHEMATICS_GRADE_10=3)

### Run analysis
Idaho_SGP <- abcSGP(
        Idaho_SGP,
	years="2021",
        steps=c("prepareSGP", "analyzeSGP", "combineSGP", "outputSGP"),
        sgp.config=ID_CONFIG,
        sgp.percentiles=FALSE,
        sgp.projections=FALSE,
        sgp.projections.lagged=FALSE,
        sgp.percentiles.baseline=FALSE,
        sgp.projections.baseline=FALSE,
        sgp.projections.lagged.baseline=TRUE,
        sgp.target.scale.scores=TRUE,
        parallel.config=parallel.config
)


###  Save results
save(Idaho_SGP, file="Data/Idaho_SGP.Rdata")
