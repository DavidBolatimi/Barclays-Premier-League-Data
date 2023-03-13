# Barclays-Premier-League-Data
Capstone simulating sports data analytics. Created a function that returns the league standings for the date and season specified.

Develop a function with the inputs of date and season that returns the league standings for the date and season specified. 
The season specified should, at a minimum, accept the current seasons and both of the two most recently completed seasons.

The csv data files available via the weblink provided above contain a lot of information that is not needed for this assignment.  The critical information is: 

Date (in day/month/year format)  

Home Team 

Away Team 

FTHG – the number of goals scored by the home team 

FTAG – the number of goals scored by the away team 

FTR – the result of the match (H indicates home team won, A indicates the away team won, D indicates a draw or tie) .

#Function Requirements

The parameters (arguments) of the function are, in order,  

Date, in the mm/dd/yy format, and 

Season specified by yyyy/yy, such as 2019/20 

 

Example Function Usage: 

If I were to load your script and enter the following command in my R console:  

EPL_Standings(“04/25/2019”, “2018/19”)  

Your function should return information specified below on the 2018/19 season at the conclusion of all matches played on April 25, 2019. 

#Function Specifications: 

The function should accomplish two goals.  It should 

return a data frame described in the next bullet, and  

display the standings in descending order according to the number of points per match earned up to and including the date parameter value.  When two teams have the same number of points per match, the teams should appear in descending order according to the number of points per match, then wins, then goals scored per match and finally ascending according to goals allowed per match. 

Along with the team name (named TeamName), the data frame returned by the function will contain the following columns where the column name is specified in parentheses: 

record as wins-loses-ties (Record)   

home record (HomeRec) 

away record (AwayRec) 

matches played (MathchesPlayed) 

points (Points),  

points per match (PPM),  

point percentage = points / 3 * the number of games played, (PtPct) 

goals scored (GS), 

goals scored per match (GSM) 

goals allowed (GA) 

goals allowed per match (GAM)  
