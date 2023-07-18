library(tidyverse)
library(worldfootballR)
library(openxlsx)

union_berlin_2023_results<- fb_team_match_results(
  "https://fbref.com/en/squads/7a41008f/Union-Berlin-Stats"
)

glimpse(union_berlin_2023_results)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "")
writeData(wb, sheet = "", tudataframe)
saveWorkbook(wb, file = "results/....xlsx", overwrite = TRUE)


union_berlin_passing_stats <- fb_team_match_log_stats(
  team_urls = "https://fbref.com/en/squads/7a41008f/Union-Berlin-Stats",
  stat_type = "passing"
)

glimpse(union_berlin_passing_stats)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "")
writeData(wb, sheet = "", tudataframe)
saveWorkbook(wb, file = "results/....xlsx", overwrite = TRUE)

goal_log <- fb_team_goal_logs(
  team_urls = "https://fbref.com/en/squads/7a41008f/Union-Berlin-Stats", 
  for_or_against="both"
)

glimpse(goal_log)

wb <- createWorkbook("Konigsberg")
addWorksheet(wb, sheetName = "")
writeData(wb, sheet = "", tudataframe)
saveWorkbook(wb, file = "results/....xlsx", overwrite = TRUE)