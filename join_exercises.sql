# The first example shows the goal scored by a player with the last name 'Bender'. 
# The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

SELECT matchid, player
FROM goal 
WHERE teamid = 'GER';

