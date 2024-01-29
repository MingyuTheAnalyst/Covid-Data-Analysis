# Covid-19 Data Analysis

### Project Overview
 
This data analysis project aims to provide insights into vaccinated, infected and death of COVID-19 from Jan, 2020 to Jan, 2024. At the same time, will be focused on developing SQL and Tableau skill by analyzing COVID-19 data. We seek to identify the trends and gain a deeper understanding of the COVID-19.

### Data Sources

COVID-19 Data : Sourced from OurWorldData from Jan, 2020 to Jan 2024. (https://ourworldindata.org/covid-deaths)

### Tools

- Excel - Data Cleaning
- SQL(MSSQL) - Data Exploration, Data Analysis 
- Tableau - Predictive Analysis, Creating Reports

### Data Cleaning/Preparation

In the initial data preparation phase, we performed the following tasks:
1. Data loading and inspection.
2. Handling missing values.
3. Data cleaning and formatting.

### Exploration Data Analysis

EDA involved exploring the COVID data to answer key questions, such as:

- Case Fatality Rate: What is the death rate from COVID-19 as a percentage of total cases in a specific country, such as Canada?
- Infection Rate Relative to Population: How has the COVID-19 infection rate relative to the population in Canada (or another country) changed over time?
- Countries with Highest Infection Rate: Which countries have the highest infection rates of COVID-19 relative to their population sizes?
- Deaths by Continent: What are the highest COVID-19 death counts across different continents?
- Vaccination Trends: How has the vaccination rate against COVID-19 evolved in a particular country over time?

### Data Analysis

- [SQL Code-Data Exploration](https://github.com/MingyuTheAnalyst/Covid-Data-Analysis/blob/main/COVID19DataAnalysis.sql)
- [SQL Code-Data Extract for Tableau](https://github.com/MingyuTheAnalyst/Covid-Data-Analysis/blob/main/COVID19ForTableau.sql)

  Include some interesting code/features worked with

```sql
Select
    location,
    date,
    total_cases,
    total_deaths,
    (Convert(decimal,total_deaths)/Convert(decimal,total_cases))*100 as DeathPercentage
From
    portfolioproject..CovidDeaths
Where
    location
    like '%Canada%' and continent is not null
Order By
    1,2;
```

### Data Visualization - Tableau
 - [Dashborad - Tableau](https://public.tableau.com/app/profile/mingyu.kim/viz/CovidPortfolioProject_17060535651500/Dashboard1#1)
 
 ![Cap 2024-01-29 15-42-23-408](https://github.com/MingyuTheAnalyst/Covid-Data-Analysis/assets/88122148/33e83c4a-2ec4-4fd0-8f27-32c55d06fe36)
  







### Results/Findings







### Recommendations


### Limitations

