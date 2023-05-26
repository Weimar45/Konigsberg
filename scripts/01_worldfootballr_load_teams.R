library(tidyverse)
library(worldfootballR)
library(openxlsx)

union_berlin_2023_results<- fb_team_match_results(
  "https://fbref.com/en/squads/7a41008f/Union-Berlin-Stats"
)

glimpse(union_berlin_2023_results)


union_berlin_passing_stats <- fb_team_match_log_stats(
  team_urls = "https://fbref.com/en/squads/7a41008f/Union-Berlin-Stats",
  stat_type = "passing"
)

glimpse(union_berlin_passing_stats)


goal_log <- fb_team_goal_logs(
  team_urls = "https://fbref.com/en/squads/7a41008f/Union-Berlin-Stats", 
  for_or_against="both"
)

glimpse(goal_log)