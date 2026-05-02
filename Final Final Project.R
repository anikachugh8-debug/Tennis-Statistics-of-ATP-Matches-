library(dplyr)
library(ggplot2)
library(refugees)
library(dplyr)
library(tidyr)
library(scales)
library(tidyverse)
install.packages("ggrepel")
library(ggrepel)
library(maps)

atp_2022 = read.csv("atp_matches_2022.csv")
atp_2023 = read.csv("atp_matches_2023.csv")
atp_2024 = read.csv("atp_matches_2024.csv")
# I started off with clearing out any Walkovers or retirements to better focus on the data
total_atp_matches = rbind(atp_2022, atp_2023, atp_2024) |>
  filter(score != "W/O") |>
  filter(!endsWith(score, "RET")) |> #i had to find code i could use to get rid of the word RET at the end so endsWith does that for me
  filter(score != "")
#here I created a variable where it marked all spots where the first set was won
first_set_winner = total_atp_matches |>
  mutate(
    first_set_won = ifelse(substr(score, 1, 1) > substr(score, 3, 3), "Yes", "No")
  )
#this gets the percentages of those who won first set and won the entire match and those who lost first set and still cameback
match_analysis = first_set_winner |>
  group_by(first_set_won) |>
  summarise(count = n()) |>
  mutate(Percentage = count / sum(count) * 100)



#created a bar graph showing my percentages
ggplot(match_analysis, aes(x = first_set_won, y = Percentage, fill = first_set_won)) +
  geom_col() +
  geom_text(aes(label = paste0(round(Percentage, 1), "%")), vjust = -0.5) +
  scale_fill_manual(values = c("Yes" = "darkgreen", "No" ="lightgreen")) +
  labs(title = "Probability of Winning Match After Winning First Set",
       subtitle = "Data from ATP 2022-2024",
       x = "Won the First Set?",
       y = "Win Percentage (%)") +
  theme_minimal() +
  guides(fill = "none")


################################ace percentages#################################
#removed any NAs and created a new var where if winner had more aces it will write as is
total_aces = total_atp_matches |> 
  filter(!is.na(w_ace) & !is.na(l_ace)) |>
  mutate(more_aces = ifelse(w_ace > l_ace, "Winner had more", "Loser had more or equal"))
#this calcs the percentages
ace_analysis = total_aces |>
  group_by(more_aces) |>
  summarise(count = n()) |>
  mutate(Percentage = count / sum(count) * 100)
#same bar graph as above
ggplot(ace_analysis, aes(x = more_aces, y = Percentage, fill = more_aces)) +
  geom_col() +
  geom_text(aes(label = paste0(round(Percentage, 1), "%")), vjust = -0.5) +
  scale_fill_manual(values = c("Winner had more" = "navy", "Loser had more or equal" ="lightblue")) +
  labs(title = "Probability of Winning Match with Higher number of Aces",
       subtitle = "Data from ATP 2022-2024",
       x = "Who had more aces?",
       y = "Win Percentage (%)") +
  theme_minimal() +
  guides(fill = "none")




#################################################################################
#################################################################################
#################################################################################
install.packages("countrycode")
library(countrycode)
#combine all the match data into one
combined_files = c("atp_matches_2014.csv", "atp_matches_2015.csv", "atp_matches_2016.csv",
                   "atp_matches_2017.csv", "atp_matches_2018.csv", "atp_matches_2019.csv",
                   "atp_matches_2020.csv", "atp_matches_2021.csv", "atp_matches_2022 (1).csv",
                   "atp_matches_2023 (1).csv", "atp_matches_2024.csv")
total_atp_data = bind_rows(lapply(combined_files, read.csv))
#make sure unique players are seperated by ID
pro_players = bind_rows(
  total_atp_data |> select(id = winner_id, ioc = winner_ioc),
  total_atp_data |> select(id = loser_id, ioc = loser_ioc)) |>
  distinct(id, .keep_all = TRUE) |>
  group_by(ioc) |>
  summarise(player_total = n())
#merge the data with world map coordinates
world_map = map_data("world") |>
  left_join(iso3166 |> select(region = mapname, ioc = a3), by = "region")

final_map = left_join(world_map, pro_players, by = "ioc")  
# i pciked top 15 nations with most producing pro players
nations = pro_players |> arrange(desc(player_total)) |> head(15)
#calcs the label positions on the map
count_labels = world_map |>
  group_by(ioc) |>
  summarize(long = mean(long), lat = mean(lat)) |>
  inner_join(nations, by = "ioc") |>
  mutate(label = paste0(ioc, "\n", player_total, " Pros"))
#creates the world distribution map
ggplot(final_map, aes(x = long, y = lat, group = group, fill = player_total)) +
  geom_polygon(color = "white", linewidth = 0.1) +
  geom_label_repel(data = count_labels,
                   aes(x = long, y = lat, label = label),
                   inherit.aes = FALSE, size = 3,
                   fill = "white", color = "black",
                   box.padding = 0.5) +
  scale_fill_gradient(low = "#e0f2f1", high = "#004d40", 
                      na.value = "lightgrey",
                      name = "Total Players") +
  labs(
    title = "Global Distribution of Professional Tennis Pros from ATP (2014-2024)",
    subtitle = "Mapping player volume by IOC"
  ) +
  theme_void() +
  theme( 
    plot.title = element_text(hjust = 0.5, face = "bold", size = 15),
    plot.subtitle = element_text(hjust = 0.5, size = 10),
    legend.position = "bottom"
  )














