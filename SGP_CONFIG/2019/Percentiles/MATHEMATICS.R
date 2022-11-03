######################################################################
###                                                                ###
###    SGP Configurations for 2019 MATHEMATICS subjects            ###
###                                                                ###
######################################################################

MATHEMATICS_2019.config <- list(
         MATHEMATICS.2019 = list(
                 sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS', 'MATHEMATICS'),
                 sgp.panel.years=c('2017', '2018', '2019'),
                 sgp.grade.sequences=list(c('3', '4'), c('3', '4', '5'), c('4', '5', '6'), c('5', '6', '7'), c('6', '7', '8'))),
         MATHEMATICS.2019 = list(
                 sgp.content.areas=c('MATHEMATICS', 'MATHEMATICS'),
                 sgp.panel.years=c('2017', '2019'),
                 sgp.grade.sequences=list(c('8', '10')))

)

MATHEMATICS_2019_SKIP_YEAR.config <- list(
	MATHEMATICS_2019 = list(
		sgp.content.areas=rep("MATHEMATICS", 2),
		sgp.panel.years=c("2017", "2019"),
		sgp.grade.sequences=list(c("3", "5"), c("4", "6"), c("5", "7"), c("6", "8"), c("8", "10")))
)
