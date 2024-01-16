Select *
From [PROJECT 1 ]..Coviddeath
where continent is not null
order by 3,4

--Select *
--From [PROJECT 1 ]..covidvaccination
--order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
From [PROJECT 1 ]..Coviddeath
order by 1,2 

--looking at the total cases vs total deaths

select location, date, total_cases, new_cases, total_deaths, 
(total_deaths/total_cases)*100 as DeathPercentage
From [PROJECT 1 ]..Coviddeath
order by 1,2 

--If the columns are of type nvarchar, you may need to convert them to a numeric
--data type before performing the division.
--You can use the CAST or CONVERT functions for this purpose

select cast (total_deaths as float)/total_deaths as Result
From Coviddeath;
Select total_deaths/ ISNULL(total_deaths,1) as Result
From Coviddeath;
select cast (total_cases as float)/total_deaths as Result1
From Coviddeath;

--This query uses the TRY_CAST function to attempt to convert the total_cases
--and total_deaths columns to float. If the conversion is successful, 
--it returns the float value; otherwise, it returns NULL. The CASE statement 
--ensures that division is performed only when total_cases is not null and not equal to zero.

SELECT
    location,
    date,
    TRY_CAST(total_cases AS float) AS total_cases,
    new_cases,
    TRY_CAST(total_deaths AS float) AS total_deaths,
    CASE
        WHEN TRY_CAST(total_cases AS float) IS NOT NULL AND TRY_CAST(total_cases AS float) <> 0 
        THEN (TRY_CAST(total_deaths AS float) / TRY_CAST(total_cases AS float)) * 100
        ELSE NULL
    END AS DeathPercentage
FROM [PROJECT 1]..Coviddeath
WHERE TRY_CAST(total_cases AS float) IS NOT NULL AND TRY_CAST(total_deaths AS float) IS NOT NULL
ORDER BY 1, 2;

--looking at county with highest location rate compared to population

Select Location, Population, Max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as 
PercentPopluationInfected 
From [PROJECT 1 ]..Coviddeath
where continent is not null
group by location, population
order by PercentPopluationInfected desc

--showing countries with highest death count per population 

select location, max(cast(total_deaths as int)) as totaldeathcount
from [PROJECT 1 ]..Coviddeath
where continent is not null
group by location
order by totaldeathcount desc

--global number 

select Sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from [PROJECT 1 ]..coviddeath
where continent is not null
order by 1,2


--looking at the total population vs vaccinations
-- not working for now as columb new_vaccination columb missing 
select death.continent, death.location, death.date, death.population, vac.new_vaccinations
from [PROJECT 1 ]..Coviddeath death
join [PROJECT 1 ]..covidvaccination vac
    on death.location = vac.location
	and death.date= vac.date
where death.continent is not null
order by 2,3 

--select * from [PROJECT 1 ]..covidvaccination
