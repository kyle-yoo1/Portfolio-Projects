Select *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER by 3,4

--Select *
--From PortfolioProject..CovidVaccincations
--order by 3,4


-- Select Data that we are going to be using
SELECT location, last_updated_date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER by 1,2

-- Looking at Total Cases VS Total Deaths
-- Result: Show likelihood of dying if you contract covid in your country
SELECT location, last_updated_date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
ORDER by 1,2


-- Looking at Total Cases VS Population
-- Result: Shows what percentage of population got Covid
SELECT location, last_updated_date, population, total_cases, (total_cases/population)*100 AS PercentagePopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location like '%united states%'
ORDER by 1,2 


-- Looking at Countries with highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS PercentagePopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location like '%united states%'
GROUP BY location, population
ORDER by PercentagePopulationInfected desc


-- Showing Countries with highest death count per population
SELECT location, MAX(cast(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY location
ORDER by TotalDeathCount DESC


-- LET'S BREAK THINGS DOWN BY CONTINENT

-- Showing continents with the highest deadth count per population
SELECT continent, MAX(cast(total_deaths AS INT)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER by TotalDeathCount DESC


-- GLOBAL NUMBERS

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--Where loaction like '%states%'
WHERE continent is not null
--Group By date
ORDER BY 1,2


-- LOOKING AT Total Populations VS Vaccinations

SELECT dea.continent, dea.location, CAST(dea.date as date) AS date, dea.population, vac.new_vaccinations
, SUM(CONVERT (int, vac.new_vaccinations)) OVER (Partition BY dea.Location ORDER BY dea.location,
dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccincations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3

--USE CTE
With PopvsVac (Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated)
as
(
SELECT dea.continent, dea.location, CAST(dea.date as date) AS date, dea.population, vac.new_vaccinations
, SUM(CONVERT (int, vac.new_vaccinations)) OVER (Partition BY dea.Location ORDER BY dea.location,
dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccincations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac


-- TEMP TABLE

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT dea.continent, dea.location, CAST(dea.date as date) AS date, dea.population, vac.new_vaccinations
, SUM(CONVERT (int, vac.new_vaccinations)) OVER (Partition BY dea.Location ORDER BY dea.location,
dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccincations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3

Select *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated

--Creating view to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, CAST(dea.date as date) AS date, dea.population, vac.new_vaccinations
, SUM(CONVERT (int, vac.new_vaccinations)) OVER (Partition BY dea.Location ORDER BY dea.location,
dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccincations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2,3

SELECT *
From PercentPopulationVaccinated






