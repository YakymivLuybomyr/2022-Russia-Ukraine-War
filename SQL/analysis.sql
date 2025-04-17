1. Overall dynamics of equipment losses since the beginning of the war
    
SELECT 
    date,
    day,
    (aircraft + helicopter + tank + APC + "field artillery" + MRL + "military auto" + "fuel tank" + drone) AS total_losses
FROM russian_losses
ORDER BY date;


2. Average daily number of aircraft/helicopters destroyed

SELECT 
    AVG(aircraft) AS avg_aircraft_per_day,
    AVG(helicopter) AS avg_helicopters_per_day
FROM russian_losses;


3. Is there a correlation between tank and APC losses?

SELECT 
    CORR(tank, APC) AS tank_apc_correlation
FROM russian_losses;
(Якщо кореляція близька до 1, це означає, що танки і ББМ часто гинуть разом у боях.)

    
4. Days with abnormally high losses (e.g. top 5 days by tanks)

SELECT 
    date,
    tank AS tanks_destroyed
FROM russian_losses
ORDER BY tank DESC
LIMIT 5;
(Аналогічно можна зробити для інших видів техніки.)

    
5. Dynamics of drone losses over time ( by month)

SELECT 
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    SUM(drone) AS total_drones_destroyed
FROM russian_losses
GROUP BY year, month
ORDER BY year, month;
(Можна побудувати графік зростання/спаду.)

    
6. Is there a weekly pattern of losses 

SELECT 
    EXTRACT(DOW FROM date) AS day_of_week, 
    AVG(tank + APC + "field artillery") AS avg_armor_losses
FROM russian_losses
GROUP BY day_of_week
ORDER BY day_of_week;
(Якщо середні втрати вищі у дні 0 або 6 (вихідні), це може свідчити про активність.)

    
7. Tank vs APC Loss Ratio

SELECT 
    SUM(tank) AS total_tanks_destroyed,
    SUM(APC) AS total_apcs_destroyed,
    ROUND(SUM(tank) * 100.0 / (SUM(tank) + SUM(APC)), 2) AS tanks_percentage,
    ROUND(SUM(APC) * 100.0 / (SUM(tank) + SUM(APC)), 2) AS apcs_percentage
FROM russian_losses;
(Можна зробити кругову діаграму.)

8. Changing loss structure ( airplanes vs. drones)

SELECT 
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    SUM(aircraft) AS aircraft,
    SUM(drone) AS drones,
    ROUND(SUM(drone) * 100.0 / (SUM(aircraft) + SUM(drone)), 2) AS drones_percentage
FROM russian_losses
GROUP BY year, month
ORDER BY year, month;
(Тут можна побачити, чи зростає роль дронів з часом.)

9. Is the increase in fuel tank losses related to the offensives?

SELECT 
    date,
    "fuel tank" AS fuel_tanks_destroyed,
    tank + APC AS armored_vehicles_losses
FROM russian_losses
ORDER BY "fuel tank" DESC
LIMIT 10;
(If on days with high tank losses there are also many losses of equipment, this may indicate an offensive.)

15.Total number of destroyed equipment for all time (aircraft,helicopter,tank,APC,field artillery,fuel tank,drone)

SELECT 
    SUM(aircraft) AS total_aircraft,
    SUM(helicopter) AS total_helicopters,
    SUM(tank) AS total_tanks,
    SUM(APC) AS total_apcs,
    SUM("field artillery") AS total_artillery,
    SUM(MRL) AS total_mlrs,
    SUM("military auto") AS total_military_vehicles,
    SUM("fuel tank") AS total_fuel_tanks,
    SUM(drone) AS total_drones
FROM russian_losses;
