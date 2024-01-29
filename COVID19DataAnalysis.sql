select *
From portfolioproject..CovidDeaths
Where continent is not null
Order by 3,4

--select *
--From portfolioproject..CovidVaccinations
--Order by 3,4

--Select Data that we are going to be using

Select location, date, total_cases, new_cases, total_deaths, population
From portfolioproject..CovidDeaths
Where continent is not null
Order By 1,2


--Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract covid in your country
Select location, date, total_cases, total_deaths, (Convert(decimal,total_deaths)/Convert(decimal,total_cases))*100 as DeathPercentage
From portfolioproject..CovidDeaths
Where location like '%Canada%' and continent is not null
Order By 1,2


--Looking at Total Cases vs Population
--Shows what percentage of population got Covid
Select location, date, population, total_cases, (Convert(decimal,total_cases)/Convert(decimal,population))*100 as PercentPopulationInfected
From portfolioproject..CovidDeaths
Where location like '%Canada%'and continent is not null
Order By 1,2


-- Looking at Countries with Highest Infection Rate compared to Population

Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((Convert(decimal,total_cases)/Convert(decimal,population)))*100 as PercentPopulationInfected
From portfolioproject..CovidDeaths
Where continent is not null
Group by location, population
Order By PercentPopulationInfected desc


--Showing Countries with Highest Death Count per Population
Select location, MAX(Convert(int,Total_deaths)) as TotalDeathCount
From portfolioproject..CovidDeaths
Where continent is not null
Group by location
Order By TotalDeathCount desc


--Let's Break Things down by Continent

Select continent, MAX(Convert(int,Total_deaths)) as TotalDeathCount
From portfolioproject..CovidDeaths
Where continent is not null
Group by continent
Order By TotalDeathCount desc


--Global Numbers

Select  sum(cast(new_cases as int)) as total_newCases, sum(cast(new_deaths as int)) as total_newDeaths, sum(cast(new_deaths as decimal))/sum(cast(new_cases as decimal))*100 as deathPercentage
From portfolioproject..CovidDeaths
Where continent is not null
--Group by date
Order By 1,2


--Looking at Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(bigint,vac.new_vaccinations)) Over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From portfolioproject..CovidDeaths dea
Join portfolioproject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
Order by 2,3


--USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(bigint,vac.new_vaccinations)) Over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From portfolioproject..CovidDeaths dea
Join portfolioproject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
)
Select*, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Temp Table
Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(bigint,vac.new_vaccinations)) Over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From portfolioproject..CovidDeaths dea
Join portfolioproject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3

Select*, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


--Create View to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(bigint,vac.new_vaccinations)) Over (partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From portfolioproject..CovidDeaths dea
Join portfolioproject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3


Select *
From PercentPopulationVaccinated