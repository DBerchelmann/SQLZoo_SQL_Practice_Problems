# The first example shows the goal scored by a player with the last name 'Bender'. 
# The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

SELECT matchid, player
FROM goal 
WHERE teamid = 'GER';

# From the previous query you can see that Lars Benders scored a goal in game 1012. Now we want to know what teams were playing in that match.
# Notice in the that the column matchid in the goal table corresponds to the id column in the game table. 
# We can look up information about game 1012 by finding that row in the game table.

SELECT id,stadium,team1,team2
FROM game
WHERE id = 1012;

# You can combine the two steps into a single query with a JOIN.
# SELECT *
# FROM game JOIN goal ON (id=matchid)
# The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say
# ON (game.id=goal.matchid)
# The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
# Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player,teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER';

# Use the same JOIN as in the previous question.
# Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
FROM game JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%';

# The table eteam gives details of every national team including the coach. 
# You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
# Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON (teamid=id)
WHERE gtime<=10;

# To JOIN game with eteam you could use either
# game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)
# Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
# List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
FROM game JOIN eteam ON (team1=eteam.id)
WHERE coach = 'Fernando Santos';

# List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
FROM game JOIN goal ON (id=matchid)
WHERE stadium = 'National Stadium, Warsaw';

# The example query shows all goals scored in the Germany-Greece quarterfinal.
# Instead show the name of all players who scored a goal against Germany.

SELECT DISTINCT player
FROM game JOIN goal ON (matchid = id) 
WHERE (team1='GER' OR team2='GER') AND teamid != 'GER';

# Show teamname and the total number of goals scored.

SELECT teamname, count(gtime)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname
ORDER BY teamname

# Show the stadium and the number of goals scored in each stadium.

SELECT stadium, count(gtime)
FROM game JOIN goal ON id=matchid
GROUP BY stadium;

# For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT id, mdate, count(gtime)
FROM game JOIN goal ON id = matchid
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY id, mdate;

# For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(teamid)
FROM game JOIN goal ON id=matchid
WHERE teamid = 'GER'
GROUP BY matchid, mdate;

# List every match with the goals scored by each team as shown. 
# This will use "CASE WHEN" which has not been explained in any previous exercises.

SELECT mdate,
       team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
       team2,
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2 FROM
    game LEFT JOIN goal ON (id = matchid)
    GROUP BY mdate,team1,team2
    ORDER BY mdate, matchid, team1, team2


# List all of the Star Trek movies, include the id, title and yr
# (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr
FROM movie
WHERE title LIKE ('STAR TREK%')
ORDER BY yr ASC;

# Obtain the cast list for 'Casablanca'.

SELECT name
FROM casting JOIN actor ON id=actorid
WHERE movieid = 11768;

# OR YOU CAN USE THE BELOW code

SELECT name
FROM actor JOIN casting ON actor.id=casting.actorid
WHERE movieid = 11768;

# Obtain the cast list for the film 'Alien'

SELECT name
FROM casting 
     JOIN actor ON (id=actorid AND movieid = (SELECT id FROM movie WHERE title = 'Alien'));

# List the films in which 'Harrison Ford' has appeared

SELECT title
FROM movie JOIN casting ON (movieid=id AND actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford'));

# List the films where 'Harrison Ford' has appeared - but not in the starring role. 
# [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

SELECT title
FROM movie JOIN casting ON 
    (movieid=id AND actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford' AND ord!= 1));

# OR YOU CAN figure out the above problem using multiple JOIN operations instead of select within select

SELECT title
FROM casting
     JOIN movie ON (casting.movieid=movie.id)
     JOIN actor ON (casting.actorid=actor.id)
WHERE name = 'Harrison Ford' AND
      ord!=1;

    # List the films together with the leading star for all 1962 films.

    SELECT title, name
FROM casting 
     JOIN movie ON (casting.movieid=movie.id)
     JOIN actor ON (casting.actorid=actor.id)
WHERE yr = 1962 AND
      ord = 1;

# Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) 
FROM
  casting JOIN movie ON casting.movieid=movie.id
          JOIN actor ON casting.actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

# List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT title, name
FROM casting JOIN actor ON (casting.actorid=actor.id)
             JOIN movie ON (casting.movieid=movie.id)
WHERE movieid IN (
                  SELECT movieid 
                  FROM casting JOIN actor ON 
                  (casting.actorid=actor.id)
                  WHERE name = 'Julie Andrews')
 AND ord=1;


 Obtain a list, in alphabetical order, of actors who havve had at least 15 starring roles.

 SELECT name
FROM actor JOIN casting ON (actor.id=casting.actorid)
WHERE ord = 1
GROUP BY NAME
HAVING COUNT(name) >= 15;

# List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT title, COUNT(actorid)
FROM movie JOIN casting ON (movie.id = casting.movieid)
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title;

# List all the people who have worked with 'Art Garfunkel'.

SELECT name
FROM casting JOIN actor ON (casting.actorid = actor.id)
WHERE movieid IN (
                  SELECT movieid 
                  FROM casting JOIN actor ON (casting.actorid=actor.id)
                  WHERE name = 'Art Garfunkel')
AND name != 'Art Garfunkel';