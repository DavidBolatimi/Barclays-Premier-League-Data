library(tidyverse)
library(dplyr)
library(lubridate)



EPL_Standings <- function(Date, Season) {
  
  # Import the data
  # 1a use Season input to choose which file to download
  if(Season == "2022/23"){
    df <- read.csv("https://www.football-data.co.uk/mmz4281/2223/E0.csv")
  }
  if(Season == "2021/22"){
    df <- read.csv("https://www.football-data.co.uk/mmz4281/2122/E0.csv")
  }
  if(Season == "2020/21"){
    df <- read.csv("https://www.football-data.co.uk/mmz4281/2021/E0.csv")
  }
  
  #Season  <- "2021/22" Test variables
  #Date <- "10/08/2021"
  DateInput <- mdy(Date)
  
  #Selecting the date
    df <- df %>%
      mutate(Date = lubridate::dmy(df$Date)) %>%
      filter(Date <= DateInput)
  
  #Clean up/Filter data frame
  df_clean <- df %>% 
    mutate() %>% 
    filter()
  
  #Select required columns
  df <- df %>% 
    select(Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)
  # Date (in day/month/year format) 
  # Home Team
  # Away Team
  # FTHG – the number of goals scored by the home team
  # FTAG – the number of goals scored by the away team
  # FTR – the result of the match (H indicates home team won, A indicates the away team won, D indicates a draw or tie)

  home <- df %>%
    select(team = HomeTeam, goals_scored = FTHG, goals_allowed = FTAG)
  
  away <- df %>%
    select(team = AwayTeam, goals_scored = FTAG, goals_allowed = FTHG)
  
  clean_df <- bind_rows(home, away)
    
  # calculate wins, losses, draws as columns (1 or 0)
 Arranged <- clean_df %>%
    mutate(wins = ifelse(goals_scored > goals_allowed, 1, 0),
           losses = ifelse(goals_scored < goals_allowed, 1, 0) ,
           draws = ifelse(goals_scored == goals_allowed, 1, 0) ,
           total = wins + losses + draws ,) %>% 
    group_by(team) %>% 
    summarize(wins = sum(wins), losses = sum(losses), draws = sum(draws), Matches_played = sum(total), Points = (3*wins +draws), PPM = sum(Points)/Matches_played, 
              PtPct = (Points/(3*Matches_played)), GS = sum(goals_scored), GSM = GS/Matches_played, GA = sum(goals_allowed), GAM = GA/Matches_played) %>% 
    arrange(desc(Points)) %>%
    # Display Record
    mutate(record = paste0(wins, "-", losses, "-", draws))
  
  #Home and Away Record
  Home <- home %>%
      mutate(wins = ifelse(goals_scored > goals_allowed, 1, 0),
             losses = ifelse(goals_scored < goals_allowed, 1, 0) ,
             draws = ifelse(goals_scored == goals_allowed, 1, 0) , ) %>% 
      group_by(team) %>% 
      summarize(winsH = sum(wins), lossesH = sum(losses), drawsH = sum(draws)) %>% 
      
      mutate(HomeRec = paste0(winsH, "-", lossesH, "-", drawsH))
    
  Away <-  away %>%
    mutate(wins = ifelse(goals_scored > goals_allowed, 1, 0),
           losses = ifelse(goals_scored < goals_allowed, 1, 0) ,
           draws = ifelse(goals_scored == goals_allowed, 1, 0) , ) %>% 
    group_by(team) %>% 
    summarize(winsA = sum(wins), lossesA = sum(losses), drawsA = sum(draws)) %>% 
    
    mutate(AwayRec = paste0(winsA, "-", lossesA, "-", drawsA))
  
  m <- merge(Arranged, Home, by.x="team", by.y="team")
  n <- merge(m, Away, by.x="team", by.y="team")
  
  output <- n %>%
    arrange(desc(Points))
  
  #Return the final data frame
  return(output)
  
}