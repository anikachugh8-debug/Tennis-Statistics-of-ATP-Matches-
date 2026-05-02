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
This project uses ATP Matches from 2014 - 2016
- The project involves cobinging the player demographic tables with those of specific match performance statistics(aces, break points, set scores, etc.)
- 10 years of professional tour data

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

   <img src="" alt="Win Probability" width="500">

   





