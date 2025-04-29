PRESENTATION: Russian Equipment Losses During the War in Ukraine (2022–2025)
Analytical report based on Power BI dashboards

This analytical project investigates the scale, structure, and evolution of Russian military equipment losses during the full-scale invasion of Ukraine. Through dashboard design and DAX transformations, we visualized key trends and built a dynamic, data-driven picture of battlefield attrition.

Title:
Russian Military Equipment Losses (2022–2025)

Details:

- Pet Project
- Data Source: Open Google Sheet
- Duration: 25 Feb 2022 – 13 Apr 2025
-Tools: Power BI, DAX

Data Overview

- Data Format: Cumulative daily figures
- Fields: date, aircraft, helicopter, tank, APC, field artillery, MRL, drone, military auto, fuel tank
- Challenge: Convert cumulative to daily values
- Solution: Custom DAX measures calculating per-day losses
- Period covered: 1145 days


Total Losses Overview
![Image alt](https://github.com/YakymivLuybomyr/2022-Russia-Ukraine-War/blob/main/DATA/WAR%202022%20dashboard%201.png)

What it Shows:

- Total losses by year
- Daily average losses by year
- Share (%) of each equipment type
- Hierarchy of losses (from drones to aircraft)

Key Insights:

- Drones account for 34.74% of total losses
- Artillery and APCs follow in total losses
- 2023 was the peak year in loss intensity
- Aircraft and helicopters were least affected


 
 Equipment Type Focus
![Image alt](https://github.com/YakymivLuybomyr/2022-Russia-Ukraine-War/blob/main/DATA/WAR%202022%20dashboard%202.png)

What it Shows:

- Yearly and quarterly losses for drones, artillery, and APCs
- Average daily losses by year per category
- Equipment-specific patterns

Key Insights:

- Drone losses rose sharply in 2023 and remained high through 2025
- Artillery losses were consistently high across all years
- APC losses peaked in 2023 and then declined in 2025

Timeline of Losses
![Image alt](https://github.com/YakymivLuybomyr/2022-Russia-Ukraine-War/blob/main/DATA/WAR%202022%20dashboard%203.png)

What it Shows:

- Time series (monthly and quarterly) for all categories
- Simultaneous trends for tanks, drones, aircraft, APCs, MRL, artillery
- Seasonal and campaign-based shifts

Key Insights:

- Mid-2023 was the most intense period of synchronized losses
- Spring and summer saw consistent surges
- Early 2025 shows signs of plateauing or decline


Trends and Change Dynamics

Identified Trends:

- Rapid expansion in drone deployment met with increasing countermeasures
- Artillery remains crucial, but its vulnerability has grown
- Decline in vehicle-based assets may indicate shift to defensive or low-exposure tactics
- Seasonality patterns suggest alignment with offensive phases

Anticipated Changes:

- Russia may increasingly prioritize smaller, cheaper unmanned platforms
- Static warfare and fortified defense lines may reduce need for APCs
- Declining helicopter use may reflect higher risk or limited stock


Strategic Hypotheses

- Hypothesis 1:
If current drone loss rates persist, Russia will shift to swarm tactics or micro-UAVs to minimize cost and risk.

- Hypothesis 2:
The decrease in APC losses in 2025 may reflect Russia’s transition toward trench-based or defensive warfare.

- Hypothesis 3:
Plateaued loss rates across categories suggest either equipment shortages or an operational pause in strategic offensives.

- Hypothesis 4:
Artillery losses may drive Russia to rely more on MLRS and stand-off missile systems to compensate for short-range firepower.

Technical Process

- Created calculated measures using DAX to extract daily losses
- Applied difference logic (current – previous) per category
- Used Power BI visuals: bar charts, line graphs, pie charts, matrix tables, sql
   Enhanced filters by year and category

Example DAX (Tank Daily Loss):

DAX

daily losses of everything = 
VAR currentDate = SELECTEDVALUE('russia_losses_equipment'[date])
VAR currentValue = CALCULATE(SUM('russia_losses_equipment'[aircraft]), 'russia_losses_equipment'[date] = currentDate)
VAR previousValue = 
    CALCULATE(
        SUM('russia_losses_equipment'[aircraft]),
        FILTER(
            'russia_losses_equipment',
            'russia_losses_equipment'[date] = currentDate - 1
        )
    )
RETURN
    IF(ISBLANK(currentValue) || ISBLANK(previousValue), BLANK(), currentValue - previousValue)
    --------------------------------------------------------------------------------------------------------------------------------------------------------------------
    daily losses drone = 
VAR currentDate = MAX('russia_losses_equipment'[date])
VAR currentValue = CALCULATE(SUM('russia_losses_equipment'[drone]), 'russia_losses_equipment'[date] = currentDate)
VAR previousValue = CALCULATE(SUM('russia_losses_equipment'[drone]), FILTER('russia_losses_equipment', 'russia_losses_equipment'[date] = currentDate - 1))
RETURN currentValue - previousValue



Conclusions

- Drones became the most heavily used and lost equipment type
- Ground vehicle losses highlight vulnerability to modern anti-armor weapons
- Warfare evolved from mobile strikes to static and drone-based operations
- Power BI enabled a transparent and layered view of war-related attrition

Future Work

- Include geospatial analysis based on frontline changes
- Compare Russian losses with estimated Ukrainian losses
- Predict future loss patterns using historical and seasonal regression

