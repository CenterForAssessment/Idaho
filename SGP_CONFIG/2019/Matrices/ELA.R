################################################################################
###                                                                          ###
###      ELA BASELINE matrix configurations (sequential and skip-year)       ###
###                                                                          ###
################################################################################

ELA_BASELINE.config <- list(
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2018", "2019"),
		sgp.baseline.grade.sequences=c("3", "4"),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2018", "2019"),
		sgp.baseline.grade.sequences=c("4", "5"),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("3", "4", "5"),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2017", "2019"),
		sgp.baseline.grade.sequences=c("3", "5"),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2018", "2019"),
		sgp.baseline.grade.sequences=c("5", "6"),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("4", "5", "6"),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2017", "2019"),
		sgp.baseline.grade.sequences=c("4", "6"),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2016", "2017", "2019"),
		sgp.baseline.grade.sequences=c("3", "4", "6"),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2018", "2019"),
		sgp.baseline.grade.sequences=c("6", "7"),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("5", "6", "7"),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2017", "2019"),
		sgp.baseline.grade.sequences=c("5", "7"),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2016", "2017", "2019"),
		sgp.baseline.grade.sequences=c("4", "5", "7"),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2018", "2019"),
		sgp.baseline.grade.sequences=c("7", "8"),
		sgp.baseline.grade.sequences.lags=1),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2017", "2018", "2019"),
		sgp.baseline.grade.sequences=c("6", "7", "8"),
		sgp.baseline.grade.sequences.lags=c(1,1)),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2017", "2019"),
		sgp.baseline.grade.sequences=c("6", "8"),
		sgp.baseline.grade.sequences.lags=2),
	list(
		sgp.baseline.content.areas=rep("ELA", 3),
		sgp.baseline.panel.years=c("2016", "2017", "2019"),
		sgp.baseline.grade.sequences=c("5", "6", "8"),
		sgp.baseline.grade.sequences.lags=c(1,2)),
	list(
		sgp.baseline.content.areas=rep("ELA", 2),
		sgp.baseline.panel.years=c("2017", "2019"),
		sgp.baseline.grade.sequences=c("8", "10"),
		sgp.baseline.grade.sequences.lags=2)
)
