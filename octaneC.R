library(readxl)
library(lubridate)
octaneCore_2_1_ <- read_excel("D:/Téléchargement/octaneCore (2)(1).xlsx", 
      range = "C1:V46", col_types = c("text", 
         "numeric", "numeric", "numeric", 
         "numeric", "numeric", "numeric", 
         "numeric", "numeric", "numeric", 
         "numeric", "numeric", "text", "text", 
         "numeric", "numeric", "text", "text", 
         "text", "text"))
View(octaneCore_2_1_)
temps_a_modif <- c('POSSESSION_TIME', 'TIME_ON_SIDE', 'BEHIND_BALL', 'IN_FRONT_OF_BALL','IN_DEF_1/2', 'IN_OFF_1/2')
var_sec <- paste(temps_a_modif, '_sec', sep='')

##Passage du format mm:ss à hh:mm:ss 
x = 1:45
for (i in x) {
  octaneCore_2_1_$POSSESSION_TIME[i] <- paste0("00:", octaneCore_2_1_$POSSESSION_TIME[i])
  octaneCore_2_1_$TIME_ON_SIDE[i] <- paste0("00:", octaneCore_2_1_$TIME_ON_SIDE[i])
  octaneCore_2_1_$BEHIND_BALL[i] <- paste0("00:", octaneCore_2_1_$BEHIND_BALL[i])
  octaneCore_2_1_$IN_FRONT_OF_BALL[i] <- paste0("00:", octaneCore_2_1_$IN_FRONT_OF_BALL[i])
  octaneCore_2_1_$`IN_DEF_1/2`[i] <- paste0("00:", octaneCore_2_1_$`IN_DEF_1/2`[i])
  octaneCore_2_1_$`IN_OFF_1/2`[i] <- paste0("00:", octaneCore_2_1_$`IN_OFF_1/2`[i])
}

##création des variables qui vont stocker la durée en seconde
for (m in temps_a_modif) {
  octaneCore_2_1_[, paste(m, '_sec', sep='')] <-0
}

for (i in x) {
  octaneCore_2_1_$POSSESSION_TIME_sec[i] <- lubridate::period_to_seconds(lubridate::hms(octaneCore_2_1_$POSSESSION_TIME[i]))
  octaneCore_2_1_$TIME_ON_SIDE_sec[i] <- lubridate::period_to_seconds(lubridate::hms(octaneCore_2_1_$TIME_ON_SIDE[i]))
  octaneCore_2_1_$BEHIND_BALL_sec[i] <- lubridate::period_to_seconds(lubridate::hms(octaneCore_2_1_$BEHIND_BALL[i]))
  octaneCore_2_1_$IN_FRONT_OF_BALL_sec[i] <- lubridate::period_to_seconds(lubridate::hms(octaneCore_2_1_$IN_FRONT_OF_BALL[i]))
  octaneCore_2_1_$`IN_DEF_1/2_sec`[i] <- lubridate::period_to_seconds(lubridate::hms(octaneCore_2_1_$`IN_DEF_1/2`[i]))
  octaneCore_2_1_$`IN_OFF_1/2_sec`[i] <- lubridate::period_to_seconds(lubridate::hms(octaneCore_2_1_$`IN_OFF_1/2`[i]))
}
##Ordonne en fonction du taux de victoire (décroissant)
octaneCore_2_1_[order(octaneCore_2_1_$`WIN%`, decreasing = TRUE),]

##Modification de la base en ajoutant les régions où sont localisés les équipes
region <- c("NA","NA","EU","EU","NA", "EU", "NA", "EU","NA","EU", "EU", "EU","NA","EU","NA","EU","EU","NA","NA","NA","EU","NA","EU", "EU","NA","NA","NA","EU","NA","EU","EU","EU","NA","EU","NA","NA","NA","NA","NA","NA","EU","NA","NA","NA","EU")
octaneCore_2_1_$Regions <- region
##sauvegarde du fichier
save(octaneCore_2_1_, file = "octane.RData")
