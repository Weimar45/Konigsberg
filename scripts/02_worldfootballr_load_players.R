# ----- Descripción del Script ----
#
# Ejemplo de descarga de datos en crudo de los jugadores
# Fecha: 20/07/2023
# Última vez editado por: Alejandro Navas González
#

# ------ Load packages ------

library(tidyverse)
library(worldfootballR)
library(openxlsx)


leah_williamson <- "https://fbref.com/en/players/9a40ae1f/Leah-Williamson"
leah_williamson_passing <-  fb_player_season_stats(
  player_url = leah_williamson, stat_type = "passing"
)

glimpse(leah_williamson_passing)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "Leah Williamson Passing")
writeData(wb, sheet = "Leah Williamson Passing", leah_williamson_passing)
saveWorkbook(wb, file = "results/leah_williamson_passing.xlsx", overwrite = TRUE)

big5_player_possession <- fb_big5_advanced_season_stats(
  season_end_year = 2023, 
  stat_type = "possession", 
  team_or_player = "player"
)

glimpse(big5_player_possession)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "Big5 Player Possession")
writeData(wb, sheet = "Big5 Player Possession", big5_player_possession)
saveWorkbook(wb, file = "results/big5_player_possession.xlsx", overwrite = TRUE)

leah_williamson_goal_log <- fb_player_goal_logs(
  player_urls = leah_williamson, 
  goals_or_assists = "both"
)

glimpse(leah_williamson_goal_log)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "")
writeData(wb, sheet = "", tudataframe)
saveWorkbook(wb, file = "results/....xlsx", overwrite = TRUE)

leah_williamson_summary <- fb_player_match_logs(
  leah_williamson,
  season_end_year = 2023, 
  stat_type = 'summary'
)

glimpse(leah_williamson_summary)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "")
writeData(wb, sheet = "", tudataframe)
saveWorkbook(wb, file = "results/....xlsx", overwrite = TRUE)

man_city_wages <- fb_squad_wages(
  team_urls = "https://fbref.com/en/squads/b8fd03ef/Manchester-City-Stats"
)

glimpse(man_city_wages)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "")
writeData(wb, sheet = "", tudataframe)
saveWorkbook(wb, file = "results/....xlsx", overwrite = TRUE)