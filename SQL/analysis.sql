1. Загальна динаміка втрат техніки з початку війни
sql
Copy
SELECT 
    date,
    day,
    (aircraft + helicopter + tank + APC + "field artillery" + MRL + "military auto" + "fuel tank" + drone) AS total_losses
FROM russian_losses
ORDER BY date;
(Це можна візуалізувати як лінійний графік з фільтрами за типами техніки.)

5. Середньодобова кількість знищених літаків/гелікоптерів
sql
Copy
SELECT 
    AVG(aircraft) AS avg_aircraft_per_day,
    AVG(helicopter) AS avg_helicopters_per_day
FROM russian_losses;
(Можна додати breakdown по місяцях.)

6. Чи є кореляція між втратами танків та ББМ (APC)?
sql
Copy
SELECT 
    CORR(tank, APC) AS tank_apc_correlation
FROM russian_losses;
(Якщо кореляція близька до 1, це означає, що танки і ББМ часто гинуть разом у боях.)

7. Дні з аномально високими втратами (наприклад, топ-5 днів за танками)
sql
Copy
SELECT 
    date,
    tank AS tanks_destroyed
FROM russian_losses
ORDER BY tank DESC
LIMIT 5;
(Аналогічно можна зробити для інших видів техніки.)

8. Динаміка втрат дронів з часом (наприклад, по місяцях)
sql
Copy
SELECT 
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    SUM(drone) AS total_drones_destroyed
FROM russian_losses
GROUP BY year, month
ORDER BY year, month;
(Можна побудувати графік зростання/спаду.)

9. Чи є тижнева залежність втрат (наприклад, більше втрат у вихідні)?
sql
Copy
SELECT 
    EXTRACT(DOW FROM date) AS day_of_week, -- 0=неділя, 1=понеділок...
    AVG(tank + APC + "field artillery") AS avg_armor_losses
FROM russian_losses
GROUP BY day_of_week
ORDER BY day_of_week;
(Якщо середні втрати вищі у дні 0 або 6 (вихідні), це може свідчити про активність.)

10. Співвідношення втрат танків vs ББМ (APC)
sql
Copy
SELECT 
    SUM(tank) AS total_tanks_destroyed,
    SUM(APC) AS total_apcs_destroyed,
    ROUND(SUM(tank) * 100.0 / (SUM(tank) + SUM(APC)), 2) AS tanks_percentage,
    ROUND(SUM(APC) * 100.0 / (SUM(tank) + SUM(APC)), 2) AS apcs_percentage
FROM russian_losses;
(Можна зробити кругову діаграму.)

12. Зміна структури втрат (наприклад, літаки vs дрони)
sql
Copy
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

14. Чи збільшення втрат паливних цистерн пов'язане з наступами?
sql
Copy
SELECT 
    date,
    "fuel tank" AS fuel_tanks_destroyed,
    tank + APC AS armored_vehicles_losses
FROM russian_losses
ORDER BY "fuel tank" DESC
LIMIT 10;
(Якщо в дні з великими втратами цистерн також багато втрат техніки, це може свідчити про наступ.)

15.Загальна кількість знищеної техніки за весь час
sql
Copy
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
