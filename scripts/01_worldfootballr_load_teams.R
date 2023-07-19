# ----- Descripción del Script ----
#
# Ejemplo de descarga de datos en crudo de los equipos
# Fecha: 20/07/2023
# Última vez editado por: Alejandro Navas González
#

# ------ Load packages ------

library(tidyverse)
library(worldfootballR)
library(openxlsx)

union_berlin_2023_results<- fb_team_match_results(
  "https://fbref.com/en/squads/7a41008f/Union-Berlin-Stats"
)

glimpse(union_berlin_2023_results)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "Union Berlin 2023")
writeData(wb, sheet = "Union Berlin 2023", union_berlin_2023_results)
saveWorkbook(wb, file = "results/union_berlin_2023.xlsx", overwrite = TRUE)


union_berlin_passing_stats <- fb_team_match_log_stats(
  team_urls = "https://fbref.com/en/squads/7a41008f/Union-Berlin-Stats",
  stat_type = "passing"
)

glimpse(union_berlin_passing_stats)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "Union Berlin Passing Stats")
writeData(wb, sheet = "Union Berlin Passing Stats", union_berlin_passing_stats)
saveWorkbook(wb, file = "results/union_berlin_passing_stats.xlsx", overwrite = TRUE)

goal_log <- fb_team_goal_logs(
  team_urls = "https://fbref.com/en/squads/7a41008f/Union-Berlin-Stats", 
  for_or_against="both"
)

glimpse(goal_log)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "Union Berlin Goal Log")
writeData(wb, sheet = "Union Berlin Goal Log", goal_log)
saveWorkbook(wb, file = "results/union_berlin_goal_log.xlsx", overwrite = TRUE)