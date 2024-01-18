-- First let's look at our datas.
Select * from deaths
Select * from vaccinations

-- Looking at total cases vs total deaths select only code, location and deaths.
Select iso_code, location, date, total_cases, total_deaths,
(total_deaths/total_cases)*100 As Death_Rate 
From deaths
Where continent is not null
Order By 2,3;

-- What is the death Rate in your country?
Select iso_code, location, date, total_cases, total_deaths,
(total_deaths/total_cases)*100 As Death_Rate 
From deaths
Where location = 'India' and continent is not null
Order By 2,3;

-- Looking at Total Cases Vs Polulation.
SELECT iso_code, location, date, population, total_cases,
(total_cases/population)*100 As Total from deaths
Where location = 'India' and continent is not null
Order by 2,3;

-- Looking at countries with higher infection rate compared to population.
Select location, population, MAX(total_cases) As higherinfection, 
MAX(total_cases/population)*100 AS HighestinfectionRate
from deaths
Where continent is not null
Group By location, population
order by 3 desc, 4 desc;

-- Showing	Countries with higher death rate per population.
Select location, population, MAX(total_deaths) As Highestdeaths, 
MAX(total_deaths/population) As Highestdeaths_Rate
from deaths
Where continent is not null
Group by location, population
Order by 3 desc,4 Desc;

-- Showing	Continents with higher death.
Select continent, MAX(total_deaths) As Highestdeaths
from deaths
Where continent is not null
Group By continent
Order by 2 Desc;

-- Looking at population vs vaccinations.
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
from deaths dea
Join vaccinations vac on vac.location  = dea.location
Order by 2;

-- Looking at population vs vaccinations with Windows function.
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
Sum(vac.new_vaccinations) Over(Partition by dea.location Order by dea.location) 
As People_vaccinated
from deaths dea
Join vaccinations vac on vac.location  = dea.location
Order by 2;

-- Looking at New Cases Vs New Vaccination in Fully Vaccinated Peoples all over the world 
-- With the help of CTE.
With New_vac_cases as (
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, dea.new_cases,
Sum(vac.people_fully_vaccinated) Over(Partition By dea.location Order by dea.location) 
As Rate_of_vaccinationscases 
from deaths dea
Join vaccinations vac on vac.location = dea.location
)
Select * from New_vac_cases;



























