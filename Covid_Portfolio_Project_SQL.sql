--Select *
--From CovidDeaths$
--Order by 3,4

--Select *
--From CovidVaccinations$
--Order by 3,4

--Select Location,date,total_cases,new_cases,total_deaths,population
--From CovidDeaths$
--order by 1,2


--Looking at Total cases vs Total deaths
--Select Location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
--From CovidDeaths$
--Where location like '%states%'
--order by 1,2

--Looking at Total cases vs Population
--Select Location,date,total_cases,(total_cases/population)*100 as PopulationPercentage
--From CovidDeaths$
--Where location like '%Singapore%'
--order by 1,2


--Looking at Countries with highest infection rate compared to poulation
--Select Location,Population,MAX(total_cases) as HighestInfectionCount,Max((total_cases/population))*100 as PopulationPercentageInfected
--From CovidDeaths$
--GROUP by location,population
--order by PopulationPercentageInfected desc


--Showing Countries with Highest Death Count per population
--Select Location,MAX(cast(total_deaths as int)) as TotalDeathCount,Max((total_deaths/population))*100 as PopulationPercentageReturnToGod
--From CovidDeaths$
--Where continent is not null
--GROUP by location
--order by TotalDeathCount desc

----Let's break things down by continent
--Select continent,MAX(cast(total_deaths as int)) as TotalDeathCount
--From CovidDeaths$
--Where continent is not null
--GROUP by continent
--order by TotalDeathCount desc

-- --SHowing continent with DeathCount
-- Select location,MAX(cast(total_deaths as int)) as TotalDeathCount
--From CovidDeaths$
--Where continent is null
--GROUP by location
--order by TotalDeathCount desc


--Global numbers
--Select SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases) as DeathPercentage--,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
--From CovidDeaths$
--where continent is not null
----group by date
--order by 1,2


-- Looking at toal Population vs Vaccinations

----Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
----,SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location,dea.Date ) as RollingPeopleVaccinated
------,(RollingPeopleVaccinated/population)*100
----From CovidDeaths$ dea
----Join CovidVaccinations$ vac
----	On dea.location = vac.location
----	and dea.date = vac.date	
----where dea.continent is not null --and vac.new_vaccinations is not null and dea.location like 'Cana%'
----order by 2,3


--USE CTE
--With PopvsVac(Continent,Location,Date,Population,New_Vaccinations,RollingPeopleVaccinated)
--as(
--Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location,dea.Date ) as RollingPeopleVaccinated
----,(RollingPeopleVaccinated/population)*100
--From CovidDeaths$ dea
--Join CovidVaccinations$ vac
--	On dea.location = vac.location
--	and dea.date = vac.date	
--where dea.continent is not null --and vac.new_vaccinations is not null and dea.location like 'Cana%'
----order by 2,3
--)

--Select *,(RollingPeopleVaccinated/population)*100
--from PopvsVac


--Temp Table
--Drop Table if exists #PercenPopulationVaccinated
--Create Table #PercenPopulationVaccinated
--(
--Continent nvarchar(255),
--Location nvarchar(255),
--Date datetime,
--population numeric,
--New_vaccinations numeric,
--RollingPeopleVaccinated numeric
--)

--Insert into #PercenPopulationVaccinated
--Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location,dea.Date ) as RollingPeopleVaccinated
----,(RollingPeopleVaccinated/population)*100
--From CovidDeaths$ dea
--Join CovidVaccinations$ vac
--	On dea.location = vac.location
--	and dea.date = vac.date	
--where dea.continent is not null --and vac.new_vaccinations is not null and dea.location like 'Cana%'
----order by 2,3

--Select *,(RollingPeopleVaccinated/population)*100
--from #PercenPopulationVaccinated



--Creating view to store date for later visualization

--Create View PercentPopulationVaccinated as
--Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
--,SUM(Convert(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location,dea.Date ) as RollingPeopleVaccinated
----,(RollingPeopleVaccinated/population)*100
--From CovidDeaths$ dea
--Join CovidVaccinations$ vac
--	On dea.location = vac.location
--	and dea.date = vac.date	
--where dea.continent is not null --and vac.new_vaccinations is not null and dea.location like 'Cana%'
----order by 2,3

Select *
from PercentPopulationVaccinated