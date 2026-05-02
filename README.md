# Tennis-Statistics-of-ATP-Matches
Anika Chugh
ECON 4970 - Data Science for Economics
May 2026

## Project Overview 
This project contains a deep analysis of ATP Tour match data spanning from 2010 - 2014. The study
focuses on physical performances and global distrubutions of professional talent.


# Research Questions: 
- Do players who win the first set tend to win the match overall?
- Do matches with more aces made have higher win percentages? 
- I take a broader view of the ten years and take a look at which countries produce the highest number of pros.

## Dataset
This project uses ATP Matches spanning from 2014 to 2024
- **Temporal Scope**: The study uses longitudinal dataset from 2014 - 2024 allowing the observations of long term trends in pro tennis
- **Data**: Specific match performance statistics (aces, set scores, match outcomes, etc.) are linked with player specific demographics such as IOC codes and player IDs
- **Github**: Data all came from `https://github.com/JeffSackmann/tennis_atp`

## Methodology
This analysis is all done in R, using alot of "dplyr" and "tidyverse".
- **Data Integration**: Merged 10 years of match tables into a single data frame using `bind_rows`
- **Validation Logic**: I applied filters to excluse matches with walkovers and retirements to allow for the findings to be focused on just competitive play
- **Momentum Logic**: Developed custom logic using `substr` and `mutate` to create first set winners from the ATP scores
- **Geospatial Mapping**: Calculated unique professional player volume per nation using `distinct` and mapped the findings through `geom_polygon` and `ggrepel`

## Key Visualizations
This project created three main insights using `ggplot2`:

1. Win Probability Distribution: shows the win percentages of those matches where first set was won or lost
   
   <img src="https://github.com/anikachugh8-debug/Tennis-Statistics-of-ATP-Matches-/blob/main/first%20set%20stats.png" alt="Win Probability" width="500">

2. The Aces Impact: shows the win percentages of those matches with higher aces

   <img src="https://github.com/anikachugh8-debug/Tennis-Statistics-of-ATP-Matches-/blob/main/ace%20stats.png" alt="Win Probability" width="500">

3. Global Distribution Map: a world map showing the top pro player producing nations with a gradient scale over the 10 year span of these matches being played

<img src="https://github.com/anikachugh8-debug/Tennis-Statistics-of-ATP-Matches-/blob/main/global%20dist%203.png" width="500">

## Setups
1. Make sure you have the `tidyverse`, `ggrepel`, `ggplot2`, `maps`, and `dplyr` installed.
2. Make sure the ATP 2014 - 2024 csv files are in your working directory
3. Run the `Final Final Project.R` in RStudio

    




