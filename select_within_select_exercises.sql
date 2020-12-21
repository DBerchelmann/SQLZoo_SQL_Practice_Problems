# List each country name where the population is larger than that of 'Russia'.

SELECT name FROM world
WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

# Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

SELECT name
FROM world
WHERE  continent = 'europe' AND gdp/population > (
    SELECT gdp/population
    FROM world WHERE name = 'United Kingdom')

# List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.

SELECT name, continent
FROM world
WHERE name IN (SELECT name FROM world WHERE continent = 'South America' OR continent = 'Oceania')
ORDER BY name

# Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
# Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

SELECT name, 
       CONCAT(ROUND(100 * population/(SELECT population
                                      FROM world 
                                      WHERE name ='Germany')),'%' )AS percentage
FROM world
WHERE continent = 'Europe';

# Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)

SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp FROM world WHERE gdp > 0 and continent = 'Europe')
