# Change the query shown so that it displays Nobel prizes for 1950.

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

 # Show who won the 1962 prize for Literature.
 
SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature'

# Show the year and subject that won 'Albert Einstein' his prize.

SELECT yr, subject
FROM nobel
WHERE winner IN ('Albert Einstein')

# Give the name of the 'Peace' winners since the year 2000, including 2000.

SELECT winner
FROM nobel
WHERE yr >= 2000 AND subject = 'Peace'

# Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.

SELECT yr, subject, winner
FROM nobel
WHERE yr LIKE '198%' AND subject = 'Literature'

# Show all details of the presidential winners:

# Theodore Roosevelt
# Woodrow Wilson
# Jimmy Carter
# Barack Obama

SELECT * 
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')

# Show the winners with first name John

SELECT winner
FROM nobel
WHERE winner LIKE 'John %'

# Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984.

SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Physics' AND yr = '1980') OR (subject = 'Chemistry' AND yr = 1984)


# Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine

SELECT yr, subject, winner
FROM nobel
WHERE subject NOT IN ('Chemistry', 'Medicine') AND yr = 1980

# Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) 
# together with winners of a 'Literature' prize in a later year (after 2004, including 2004)

SELECT yr, subject, winner
FROM nobel
WHERE (yr < 1910 and subject IN ('Medicine')) OR (yr >= 2004 and subject IN ('Literature'))

# Find all details of the prize won by PETER GRÜNBERG

SELECT *
FROM nobel
WHERE winner LIKE 'PETER G%G'

# Find all details of the prize won by EUGENE O'NEILL'

SELECT *
FROM nobel
WHERE winner LIKE 'EUGENE O%L'

# Knights in order

# List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order.

SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'SIR %'
ORDER BY yr DESC;

# The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
# Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
# 0 and the 1 are boolean values (1 is TRUE and 0 is FALSE)

   winner	         subject	 subject IN (..
Richard Stone	    Economics	    0
Jaroslav Seifert	Literature	    0
César Milstein	    Medicine	    0
Georges J.F. Köhler	Medicine	    0
Niels K. Jerne	    Medicine	    0
Desmond Tutu	    Peace	        0
Bruce Merrifield	Chemistry	    1
Carlo Rubbia	    Physics	        1
Simon van der Meer	Physics	        1

SELECT winner, subject 
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'),subject,winner

#PROPER SQL BELOW  for line 108 if we want it to work outside of MYSQL>>>i.e. ORACLE

CASE WHEN subject in ('Physics', 'Chemistry') THEN 1 ELSE 0 END, 
 subject, winner

 # SUM & COUNT exercices from nobel

 # List each subject - just once
 SELECT DISTINCT subject
 FROM nobel;

 # Show the total number of prizes awarded for Physics.

SELECT count(winner)
FROM nobel
WHERE subject = 'Physics';

# For each subject show the subject and the number of prizes.

SELECT DISTINCT subject, count(winner) AS total_wins
FROM nobel
GROUP BY subject

# For each subject show the first year that the prize was awarded.

SELECT subject, MIN(yr)
FROM nobel
GROUP BY subject;

# For each subject show the number of prizes awarded in the year 2000.

SELECT subject, count(winner)
FROM nobel
WHERE yr = 2000
GROUP BY subject;

# Show the number of different winners for each subject.

SELECT subject, count(distinct(winner))
FROM nobel
GROUP BY subject;

 # For each subject show how many years have had prizes awarded.

SELECT subject, COUNT(DISTINCT(yr))
FROM nobel
GROUP BY subject;



