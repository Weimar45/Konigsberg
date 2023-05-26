library(tidyverse)
library(worldfootballR)
library(openxlsx)


leah_williamson <- "https://fbref.com/en/players/9a40ae1f/Leah-Williamson"
leah_williamson_passing <-  fb_player_season_stats(
  player_url = leah_williamson, stat_type = "passing"
)

glimpse(leah_williamson_passing)


big5_player_possession <- fb_big5_advanced_season_stats(
  season_end_year = 2023, 
  stat_type = "possession", 
  team_or_player = "player"
)

glimpse(big5_player_possession)


leah_williamson_goal_log <- fb_player_goal_logs(
  player_urls = leah_williamson, 
  goals_or_assists = "both"
)

glimpse(leah_williamson_goal_log)


leah_williamson_summary <- fb_player_match_logs(
  leah_williamson,
  season_end_year = 2023, 
  stat_type = 'summary'
)

glimpse(leah_williamson_summary)


man_city_wages <- fb_squad_wages(
  team_urls = "https://fbref.com/en/squads/b8fd03ef/Manchester-City-Stats"
)

glimpse(man_city_wages)