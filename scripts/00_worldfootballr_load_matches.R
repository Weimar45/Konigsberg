# ----- Descripción del Script ----
#
# Ejemplo de descarga de datos en crudo de los partidos
# Fecha: 20/07/2023
# Última vez editado por: Alejandro Navas González
#

# ------ Load packages ------

library(tidyverse)
library(worldfootballR)
library(openxlsx)

liga_2020 <- fb_match_results(country = "ESP", 
                              gender = "M", 
                              season_end_year = 2020, 
                              tier = "1st")

glimpse(liga_2020)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "La Liga 2020")
writeData(wb, sheet = "La Liga 2020", liga_2020)
saveWorkbook(wb, file = "results/liga_2020.xlsx", overwrite = TRUE)


ligaF_2023 <- fb_match_results(country = "ESP", 
                               gender = "F", 
                               season_end_year = 2023, 
                               tier = "1st")

glimpse(ligaF_2023)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "La Liga F 2023")
writeData(wb, sheet = "La Liga F 2023", ligaF_2023)
saveWorkbook(wb, file = "results/ligaF_2023.xlsx", overwrite = TRUE)


big_5_2023 <- fb_match_results(country = c("ENG", "ESP", "ITA", "GER", "FRA"),
                               gender = c("M", "F"),
                               season_end_year = 2023, 
                               tier = "1st")

glimpse(big_5_2023)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "Big 5 2023")
writeData(wb, sheet = "Big 5 2023", big_5_2023)
saveWorkbook(wb, file = "results/big_5_2023.xlsx", overwrite = TRUE)

ATM_vs_RM_report <- fb_match_report(
  "https://fbref.com/en/matches/1160e7f1/El-Derbi-Madrileno-Real-Madrid-Atletico-Madrid-January-26-2023-Copa-del-Rey"
)

glimpse(ATM_vs_RM_report)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "ATM-RM")
writeData(wb, sheet = "ATM-RM", ATM_vs_RM_report)
saveWorkbook(wb, file = "results/ATM_vs_RM_report.xlsx", overwrite = TRUE)

ATM_vs_RM_lineups <- fb_match_lineups(
  "https://fbref.com/en/matches/1160e7f1/El-Derbi-Madrileno-Real-Madrid-Atletico-Madrid-January-26-2023-Copa-del-Rey"
)

glimpse(ATM_vs_RM_lineups)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "ATM-RM")
writeData(wb, sheet = "ATM-RM", ATM_vs_RM_lineups)
saveWorkbook(wb, file = "results/ATM_vs_RM_lineups.xlsx", overwrite = TRUE)

LIV_vs_MU_shooting <- fb_match_shooting(
  "https://fbref.com/en/matches/756e8036/North-West-Derby-Liverpool-Manchester-United-Marzo-5-2023-Premier-League"
)

glimpse(LIV_vs_MU_shooting)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "LIV-MU")
writeData(wb, sheet = "LIV-MU", LIV_vs_MU_shooting)
saveWorkbook(wb, file = "results/LIV_vs_MU_shooting.xlsx", overwrite = TRUE)

ARS_off <- fb_match_shooting(
  c(
    "https://fbref.com/en/matches/9bb3a778/Newcastle-United-Arsenal-Mayo-7-2023-Premier-League",
    "https://fbref.com/en/matches/2d551ff5/North-West-London-Derby-Arsenal-Chelsea-Mayo-2-2023-Premier-League",
    "https://fbref.com/en/matches/00a73645/Manchester-City-Arsenal-Abril-26-2023-Premier-League",
    "https://fbref.com/en/matches/12efc7dd/Arsenal-Southampton-Abril-21-2023-Premier-League"    
  )
)

glimpse(ARS_off)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "ARS")
writeData(wb, sheet = "ARS", ARS_off)
saveWorkbook(wb, file = "results/ARS_off.xlsx", overwrite = TRUE)


RM_vs_PSG_summary <- fb_match_summary(
  "https://fbref.com/en/matches/9a3684d8/Real-Madrid-Paris-Saint-Germain-March-9-2022-Champions-League"
)

glimpse(RM_vs_PSG_summary)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "RM-PSG")
writeData(wb, sheet = "RM-PSG", RM_vs_PSG_summary)
saveWorkbook(wb, file = "results/RM_vs_PSG_summary.xlsx", overwrite = TRUE)



advanced_match_stats_BAR <- fb_advanced_match_stats(
  match_url = "https://fbref.com/en/matches/fac347dd/Barcelona-Internazionale-Octubre-12-2022-Champions-League", 
  stat_type = "defense", 
  team_or_player = "team"
)

glimpse(advanced_match_stats_BAR)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "FCB")
writeData(wb, sheet = "FCB", advanced_match_stats_BAR)
saveWorkbook(wb, file = "results/advanced_match_stats_BAR.xlsx", overwrite = TRUE)
