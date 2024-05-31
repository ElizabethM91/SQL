-- 1. Count cities in the USA
SELECT COUNT(CountryCode) AS [Amount of cities in USA]
FROM dbo.city
WHERE CountryCode = 'USA';


-- 2. Country with highest life expectancy
SELECT Name, LifeExpectancy
FROM dbo.country
WHERE LifeExpectancy = (
    SELECT MAX(LifeExpectancy)
    FROM dbo.country);

-- 3. New Year promotion- featuring cities with new
SELECT *
FROM dbo.city
WHERE Name LIKE '%New%';

-- 4. Display columns with limit - first 10 rows 
SELECT TOP 10 Name, Population
FROM dbo.city;

-- 5. Cities with a population larger than 2million
SELECT Name, Population
FROM dbo.city
WHERE Population > 2000000;

-- 6. Cities beginning with 'be' prefix
SELECT Name
FROM dbo.city
WHERE Name LIKE 'be%';

-- 7. Cities with population between 500000 - 1000000
SELECT Name, Population
FROM dbo.city
WHERE Population BETWEEN 500000 AND 1000000;

-- 8. Cities sorted by name in ascending order
SELECT Name
FROM dbo.city
ORDER BY Name ASC;

-- 9. Most populated city
SELECT Name, Population
FROM dbo.city
WHERE Population = (
    SELECT MAX(Population)
    FROM dbo.city);

-- 10. City name frequency analysis
-- Unique city names in alphabetical order and how many times it is listed
SELECT Name, COUNT(Name) AS [Frequency Appeared]
FROM dbo.city
GROUP BY Name
ORDER BY Name ASC;

-- 11. City with the lowest population
SELECT Name, Population
FROM dbo.city
WHERE Population = (
    SELECT MIN(Population)
    FROM dbo.city
)

-- 12. Country with highest population 
SELECT Name, Population
FROM dbo.country
WHERE Population = (
    SELECT MAX(Population)
    FROM dbo.country
)

-- 13. Identify capital of spain
SELECT city.Name as CAPITAL
FROM dbo.city
JOIN dbo.country on city.ID = country.Capital
WHERE country.Name = 'Spain';

-- 14. Country with highest life expectancy
SELECT Name, LifeExpectancy
FROM dbo.country
WHERE LifeExpectancy = (
    SELECT MAX(LifeExpectancy)
    FROM dbo.country
)

-- 15. Cities in Europe. Select all cities in Europe
SELECT Name AS [Cities in Europe]
FROM dbo.country
WHERE Continent = 'Europe';

-- 16. Average population by country
SELECT Name, AVG(Population) AS [Average Population]
FROM dbo.country
GROUP BY Name;

-- 17. Capital cities population comparison - 
-- Compare the populations of capital cities from different countries 
SELECT country.name AS Country, city.Name AS CapitalCity, city.Population AS CapitalPopulation
FROM dbo.country
JOIN city ON country.Capital = city.ID;

-- 18. Countries with low population density
SELECT Name AS Country, Population / SurfaceArea AS PopulationDensity
FROM dbo.country
ORDER BY PopulationDensity;

-- 19. Cities with high GDP per capita - average
SELECT city.Name AS City, (Country.GNP/City.Population) AS GDP
FROM dbo.city
JOIN country ON city.CountryCode = country.Code
WHERE (country.GNP / city.Population) > (SELECT AVG(GNP / city.Population) FROM City)
ORDER BY GDP DESC;


-- The answer 
SELECT c.name AS [City], c.population, co.GNP, (co.GNP/c.population) * 1000000 AS [GDP Per Capita]
FROM City c
INNER JOIN country co ON c.CountryCode = co.Code
WHERE co.GNP IS NOT NULL
AND c.Population IS NOT NULL
AND c.Population > 0
AND co.GNP / c.Population > (SELECT AVG(co.GNP / c.Population) FROM city c INNER JOIN country co ON c.CountryCode = co.Code WHERE co.GNP IS NOT NULL AND c.Population is NOT NULL AND c.Population > 0);


-- 20. Display cities with limit (34-40) by population
SELECT TOP 10 *
FROM dbo.city
ORDER BY Population DESC
OFFSET 30 ROWS;

--- another way
SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY Population DESC) AS RowNum
  FROM city
) AS Cities
WHERE RowNum BETWEEN 31 AND 40;

SELECT * FROM dbo.city;
SELECT * FROM dbo.country;


select city.name, (country.GNP/CITY.POPULATION) AS GDP
From dbo.city
JOIN dbo.Country
ON city.countrycode = country.code
where GNP > (select AVG (GNP)FROM dbo.country)
ORDER BY gdp desc

