# ----- Descripción del Script ----
#
# Descarga de datos en crudo de las cinco grandes ligas
# Fecha: 20/07/2023
# Última vez editado por: Alejandro Navas González
#

# ------ Load packages ------

devtools::install_github("JaseZiv/worldfootballR")
library(worldfootballR)
library(tidyverse)

# ------ Top 5 leagues Stats ------

# match_urls <- get_match_urls(country = "ENG", 
#                              gender = "M", 
#                              season_end_year = c(2021:2021))
# 
# match_summaries <- get_match_summary(match_url = match_urls)

big5_player_standard <- fb_big5_advanced_season_stats(season_end_year= 2018:2021,
                                                        stat_type= "standard",
                                                        team_or_player= "player")
glimpse(big5_player_standard)

big5_player_possession <- fb_big5_advanced_season_stats(season_end_year= 2018:2021,
                                                        stat_type= "possession",
                                                        team_or_player= "player")
glimpse(big5_player_possession)

big5_player_passing <- fb_big5_advanced_season_stats(season_end_year= 2018:2021,
                                                        stat_type= "passing",
                                                        team_or_player= "player")
glimpse(big5_player_passing)


big5_player_passing_types <- fb_big5_advanced_season_stats(season_end_year= 2018:2021,
                                                        stat_type= "passing_types",
                                                        team_or_player= "player")
glimpse(big5_player_passing_types)


big5_player_gca <- fb_big5_advanced_season_stats(season_end_year= 2018:2021,
                                                        stat_type= "gca",
                                                        team_or_player= "player")
glimpse(big5_player_gca)


big5_player_defense <- fb_big5_advanced_season_stats(season_end_year= 2018:2021,
                                                        stat_type= "defense",
                                                        team_or_player= "player")
glimpse(big5_player_defense)


big5_player_shooting <- fb_big5_advanced_season_stats(season_end_year= 2018:2021,
                                                        stat_type= "shooting",
                                                        team_or_player= "player")
glimpse(big5_player_shooting)


big5_player_playing_time <- fb_big5_advanced_season_stats(season_end_year= 2018:2021,
                                                        stat_type= "playing_time",
                                                        team_or_player= "player")
glimpse(big5_player_playing_time)


big5_player_misc <- fb_big5_advanced_season_stats(season_end_year= 2018:2021,
                                                          stat_type= "misc",
                                                          team_or_player= "player")
glimpse(big5_player_misc)

big5_player_keepers_1 <- fb_big5_advanced_season_stats(season_end_year= 2018:2019,
                                                          stat_type= "keepers",
                                                          team_or_player= "player") 

big5_player_keepers_2 <- fb_big5_advanced_season_stats(season_end_year= 2020:2021,
                                stat_type= "keepers",
                                team_or_player= "player")

big5_player_keepers <- rbind(big5_player_keepers_1, big5_player_keepers_2)

glimpse(big5_player_keepers)

big5_player_keepers_adv_1 <- fb_big5_advanced_season_stats(season_end_year= 2018:2019,
                                                          stat_type= "keepers_adv",
                                                          team_or_player= "player")

big5_player_keepers_adv_2 <- fb_big5_advanced_season_stats(season_end_year= 2020:2021,
                                                         stat_type= "keepers_adv",
                                                         team_or_player= "player")

big5_player_keepers_adv <- rbind(big5_player_keepers_adv_1, big5_player_keepers_adv_2)

glimpse(big5_player_keepers_adv)

# Save the csv files
write_csv(big5_player_defense, "data/big5_player_defense_20182021.csv")
write_csv(big5_player_gca, "data/big5_player_gca_20182021.csv")
write_csv(big5_player_misc, "data/big5_player_misc_20182021.csv")
write_csv(big5_player_passing, "data/big5_player_passing_20182021.csv")
write_csv(big5_player_passing_types, "data/big5_player_passing_types_20182021.csv")
write_csv(big5_player_playing_time, "data/big5_player_playing_time_20182021.csv")
write_csv(big5_player_possession, "data/big5_player_possession_20182021.csv")
write_csv(big5_player_shooting, "data/big5_player_shooting_20182021.csv")
write_csv(big5_player_standard, "data/big5_player_standard_20182021.csv")
write_csv(big5_player_keepers, "data/big5_player_keepers_20182021.csv")
write_csv(big5_player_keepers_adv, "data/big5_player_keepers_adv_20182021.csv")


# ------ Bundesliga Stats ------

bundesliga_defense <- big5_player_defense %>%
  filter(Comp == "Bundesliga") 
bundesliga_gca <- big5_player_gca %>% 
  filter(Comp == "Bundesliga") 
bundesliga_misc <- big5_player_misc %>%
  filter(Comp == "Bundesliga") 
bundesliga_passing <- big5_player_passing %>%
  filter(Comp == "Bundesliga") 
bundesliga_passing_types <- big5_player_passing_types %>%
  filter(Comp == "Bundesliga") 
bundesliga_playing_time <- big5_player_playing_time %>% 
  filter(Comp == "Bundesliga") 
bundesliga_possession <- big5_player_possession %>%
  filter(Comp == "Bundesliga") 
bundesliga_shooting <- big5_player_shooting %>%
  filter(Comp == "Bundesliga") 
bundesliga_standard <- big5_player_standard %>%
  filter(Comp == "Bundesliga") 
bundesliga_keepers <- big5_player_keepers %>%
  filter(Comp == "Bundesliga") 
bundesliga_keepers_adv <- big5_player_keepers_adv %>%
  filter(Comp == "Bundesliga") 


write_csv(bundesliga_defense, "data/bundesliga_defense_20182021.csv")
write_csv(bundesliga_gca, "data/bundesliga_gca_20182021.csv")
write_csv(bundesliga_misc, "data/bundesliga_misc_20182021.csv")
write_csv(bundesliga_passing, "data/bundesliga_passing_20182021.csv")
write_csv(bundesliga_passing_types, "data/bundesliga_passing_types_20182021.csv")
write_csv(bundesliga_playing_time, "data/bundesliga_playing_time_20182021.csv")
write_csv(bundesliga_possession, "data/bundesliga_possession_20182021.csv")
write_csv(bundesliga_shooting, "data/bundesliga_shooting_20182021.csv")
write_csv(bundesliga_standard, "data/bundesliga_standard_20182021.csv")
write_csv(bundesliga_keepers, "data/bundesliga_keepers_20182021.csv")
write_csv(bundesliga_keepers_adv, "data/bundesliga_keepers_adv_20182021.csv")