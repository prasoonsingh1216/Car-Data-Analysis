create database proj;
use proj; 

# Provided all data for each table, and minimum and maximum prices of car for each car company.
select * from merc;
select min(price) as min_merc,  max(price) as max_merc from merc;
select * from bmw;
select min(price) as min_bmw,  max(price) as max_bmw from bmw;
select * from audi;
select min(price) as min_audi,  max(price) as max_audi from audi;
select * from cclass;
select min(price) as min_cclass,  max(price) as max_cclass from cclass;
select * from hyndai;
select min(price) as min_hyndai, max(price) as max_hyndai from hyndai;
select * from transmission;
select * from fueltype;
select * from models;

-- ---------------------------------------------------------------------------------------------------------


# FOR MERCEDES CAR
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_mercedes FROM merc
),
yearly_avg_prices AS (
SELECT category_mercedes, AVG(price) AS avg_price, MIN(year) AS start_year, 
MAX(year) AS end_year, COUNT(*) AS car_count FROM categorized_cars 
GROUP BY category_mercedes, year )
SELECT category_mercedes, MIN(start_year) AS start_year, MAX(end_year) AS end_year, 
round(((MAX(avg_price) - MIN(avg_price)) / MIN(avg_price)) * 100,2) AS '% change', 
SUM(car_count) AS cars_sold
FROM yearly_avg_prices
GROUP BY category_mercedes
HAVING COUNT(DISTINCT start_year) > 1;


# Percentage change based on year and category for mercedes.
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_mercedes FROM merc
),
yearly_avg_prices AS (
SELECT year, round(AVG(price),2) AS avg_price 
FROM merc 
GROUP BY year
)
SELECT c.year, c.category_mercedes, round(AVG(c.price),2) AS avg_price, p.avg_price AS overall_avg_price, 
ifnull(round(((AVG(c.price) / LAG(AVG(c.price)) OVER (PARTITION BY c.category_mercedes ORDER BY c.year)) - 1)*100,2),0) AS price_change_percentage, count(*) as cars_sold
FROM categorized_cars c
JOIN yearly_avg_prices p ON c.year = p.year
GROUP BY c.year, c.category_mercedes, p.avg_price
ORDER BY c.year, c.category_mercedes;

-- -------------------------------------------------------------------------------------------------------------------------------

# For BMW Car
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_BMW FROM BMW
),
yearly_avg_prices AS (
SELECT category_BMW, AVG(price) AS avg_price, MIN(year) AS start_year, MAX(year) AS end_year, COUNT(*) AS car_count FROM categorized_cars 
GROUP BY category_BMW, year
)
SELECT category_BMW, MIN(start_year) AS start_year, MAX(end_year) AS end_year, 
round(((MAX(avg_price) - MIN(avg_price)) / MIN(avg_price)) * 100,2) AS '% change', SUM(car_count) AS cars_sold
FROM yearly_avg_prices
GROUP BY category_BMW
HAVING COUNT(DISTINCT start_year) > 1;

# Percentage change based on year and category for BMW.
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_BMW FROM BMW
),
yearly_avg_prices AS (
SELECT year, round(AVG(price),2) AS avg_price 
FROM BMW 
GROUP BY year
)
SELECT c.year, c.category_BMW, round(AVG(c.price),2) AS avg_price, p.avg_price AS overall_avg_price, 
ifnull(round(((AVG(c.price) / LAG(AVG(c.price)) OVER (PARTITION BY c.category_BMW ORDER BY c.year)) - 1)*100,2),0) AS price_change_percentage, count(*) as cars_sold
FROM categorized_cars c
JOIN yearly_avg_prices p ON c.year = p.year
GROUP BY c.year, c.category_BMW, p.avg_price
ORDER BY c.year, c.category_BMW;

-- --------------------------------------------------------------------------------------------------------------------------------------
# For hyndai Car
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_hyndai FROM hyndai
),
yearly_avg_prices AS (
SELECT category_hyndai, AVG(price) AS avg_price, MIN(year) AS start_year, MAX(year) AS end_year, COUNT(*) AS car_count FROM categorized_cars 
GROUP BY category_hyndai, year
)
SELECT category_hyndai, MIN(start_year) AS start_year, MAX(end_year) AS end_year, 
round(((MAX(avg_price) - MIN(avg_price)) / MIN(avg_price)) * 100,2) AS '% change', SUM(car_count) AS cars_sold
FROM yearly_avg_prices
GROUP BY category_hyndai
HAVING COUNT(DISTINCT start_year) > 1;


# Percentage change based on year and category for Hyundai.
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_hyndai FROM hyndai
),
yearly_avg_prices AS (
SELECT year, round(AVG(price),2) AS avg_price 
FROM hyndai 
GROUP BY year
)
SELECT c.year, c.category_hyndai, round(AVG(c.price),2) AS avg_price, p.avg_price AS overall_avg_price, 
round(((AVG(c.price) / LAG(AVG(c.price)) OVER (PARTITION BY c.category_hyndai ORDER BY c.year)) - 1) * 100,2) AS price_change_percentage, count(*) as cars_sold
FROM categorized_cars c
JOIN yearly_avg_prices p ON c.year = p.year
GROUP BY c.year, c.category_hyndai, p.avg_price
ORDER BY c.year, c.category_hyndai;

-- --------------------------------------------------------------------------------------------------------------------------------------
# For cclass Car
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_cclass FROM cclass
),
yearly_avg_prices AS (
SELECT category_cclass, AVG(price) AS avg_price, MIN(year) AS start_year, MAX(year) AS end_year, COUNT(*) AS car_count FROM categorized_cars 
GROUP BY category_cclass, year
)
SELECT category_cclass, MIN(start_year) AS start_year, MAX(end_year) AS end_year, 
round(((MAX(avg_price) - MIN(avg_price)) / MIN(avg_price))*100,2) AS '% change', SUM(car_count) AS cars_sold
FROM yearly_avg_prices
GROUP BY category_cclass
HAVING COUNT(DISTINCT start_year) > 1;


# Percentage change based on year and category for cclass.
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_cclass FROM cclass
),
yearly_avg_prices AS (
SELECT year, round(AVG(price),2) AS avg_price 
FROM cclass 
GROUP BY year
)
SELECT c.year, c.category_cclass, round(AVG(c.price),2) AS avg_price, p.avg_price AS overall_avg_price, 
ifnull(round(((AVG(c.price) / LAG(AVG(c.price)) OVER (PARTITION BY c.category_cclass ORDER BY c.year)) - 1)*100,2),0) AS price_change_percentage
FROM categorized_cars c
JOIN yearly_avg_prices p ON c.year = p.year
GROUP BY c.year, c.category_cclass, p.avg_price
ORDER BY c.year, c.category_cclass;

-- ------------------------------------------------------------------------------------------------------------------------

# For Audi Car
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_audi FROM audi
),
yearly_avg_prices AS (
SELECT category_audi, AVG(price) AS avg_price, MIN(year) AS start_year, MAX(year) AS end_year, COUNT(*) AS car_count FROM categorized_cars 
GROUP BY category_audi, year
)
SELECT category_audi, MIN(start_year) AS start_year, MAX(end_year) AS end_year, 
round(((MAX(avg_price) - MIN(avg_price)) / MIN(avg_price)) * 100,2) AS '% change', SUM(car_count) AS cars_sold
FROM yearly_avg_prices
GROUP BY category_audi
HAVING COUNT(DISTINCT start_year) > 1;


# Percentage change based on year and category for cclass.
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_audi FROM audi
),
yearly_avg_prices AS (
SELECT year, round(AVG(price),2) AS avg_price 
FROM audi 
GROUP BY year
)
SELECT c.year, c.category_audi, round(AVG(c.price),2) AS avg_price, p.avg_price AS overall_avg_price, 
ifnull(round(((AVG(c.price) / LAG(AVG(c.price)) OVER (PARTITION BY c.category_audi ORDER BY c.year)) - 1)*100,2),0) AS price_change_percentage
FROM categorized_cars c
JOIN yearly_avg_prices p ON c.year = p.year
GROUP BY c.year, c.category_audi, p.avg_price
ORDER BY c.year, c.category_audi;




# affordable 
-- Insights: Affordable cars have a relatively affordable average price, with a focus on fuel efficiency and a newer model year. 
-- The car count is significantly higher compared to other categories, indicating a high demand.


# very affordable 
-- Insights: Very affordable cars have a low average price, higher mileage, and good fuel efficiency. 
-- The average model year is older, suggesting affordability for budget-conscious buyers.


# luxury 
-- Insights: Luxury cars have a significantly higher average price, lower mileage, and larger engine size. 
-- The average model year is relatively recent, indicating a focus on newer luxury models.


# mid-range 
-- Insights: Mid-range cars strike a balance between price, fuel efficiency, and engine size. 
-- The average model year is recent, and the car count is moderate.

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------------------------------------------------------------------------------


select * from merc;

# avegrage fuel efficiency for mercedes according to each category.
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_merc FROM merc
)
SELECT category_merc, year, round(AVG(price),2) AS avg_price, round(AVG(mpg),2) AS avg_fuel_efficiency, COUNT(*) AS car_count
FROM categorized_cars
GROUP BY category_merc, year
HAVING COUNT(DISTINCT id) > 1; 



# fuel efficiency for each fuel type for mercedes.
SELECT b.fueltype, a.year, round(AVG(a.mpg),2) AS average_fuel_efficiency
FROM merc as a
JOIN fueltype AS b ON a.fuel_id = b.fuel_id
GROUP BY b.fueltype, a.year 
order by fueltype;


-- -----------------------------------------------------------------------------------------------------------------------------------------------------------

# avegrage fuel efficiency for BMW according to each category.
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_BMW FROM BMW
)
SELECT category_BMW, year, round(AVG(price),2) AS avg_price, round(AVG(mpg),2) AS avg_fuel_efficiency, COUNT(*) AS car_count
FROM categorized_cars
GROUP BY category_BMW, year
HAVING COUNT(DISTINCT id) > 1; 


# fuel efficiency for each fuel type for BMW.
SELECT b.fueltype, a.year, round(AVG(a.mpg),2) AS average_fuel_efficiency
FROM bmw as a
JOIN fueltype AS b ON a.fuel_id = b.fuel_id
GROUP BY b.fueltype, a.year 
order by fueltype;

-- -------------------------------------------------------------------------------------------------------------------------------------------------


# avegrage fuel efficiency for audi according to each category.
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_audi FROM audi
)
SELECT category_audi, year, round(AVG(price),2) AS avg_price, round(AVG(mpg),2) AS avg_fuel_efficiency, COUNT(*) AS car_count
FROM categorized_cars
GROUP BY category_audi, year
HAVING COUNT(DISTINCT id) > 1; 


# fuel efficiency for each fuel type for audi.
SELECT b.fueltype, a.year, round(AVG(a.mpg),2) AS average_fuel_efficiency
FROM audi as a
JOIN fueltype AS b ON a.fuel_id = b.fuel_id
GROUP BY b.fueltype, a.year 
order by fueltype;

-- -----------------------------------------------------------------------------------------------------------------------------------------------


# avegrage fuel efficiency for hyndai according to each category.
WITH categorized_cars AS (
SELECT *, CASE
WHEN price < 12000 THEN 'Very Affordable Cars'
WHEN price BETWEEN 12000 AND 24999 THEN 'Affordable Cars'
WHEN price BETWEEN 25000 AND 40000 THEN 'Mid-Range Cars'
ELSE 'Luxury Cars' 
END AS category_hyndai FROM hyndai
)
SELECT category_hyndai, year, round(AVG(price),2) AS avg_price, round(AVG(mpg),2) AS avg_fuel_efficiency, COUNT(*) AS car_count
FROM categorized_cars
GROUP BY category_hyndai, year
HAVING COUNT(DISTINCT id) > 1; 


# fuel efficiency for each fuel type for hyndai.
SELECT b.fueltype, a.year, round(AVG(a.mpg),2) AS average_fuel_efficiency
FROM hyndai as a
JOIN fueltype AS b ON a.fuel_id = b.fuel_id
GROUP BY b.fueltype, a.year 
order by fueltype;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------


# avegrage fuel efficiency for cclass according to each category.
# since mpg column is not provided in this cclass table then I calculated avg efficiency by using 
# formula (AVG(a.mileage) / 1000 / AVG(a.enginesize)) but it might show error for some

SELECT a.id, b.fueltype, a.year, ROUND((AVG(a.mileage) / 1000) / AVG(a.enginesize), 2) AS avg_fuel_efficiency
FROM cclass AS a
JOIN fueltype AS b ON a.fuel_id = b.fuel_id
GROUP BY a.id, b.fueltype, a.year 
ORDER BY b.fueltype, a.year;





-- --------------------------------------------------------------------------------------------------------------------------------------------
# Find relationship between fuel efficiency & price of car/sales of car/fuel type/, etc.
-- --------------------------------------------------------------------------------------------------------------------------------------------



SELECT  id, model_name as CarsTypes_of_merc, fueltype, round(mpg,2) as mpg, 
ROUND((AVG(a.mileage) / 1000) / AVG(a.enginesize), 2) AS avg_fuel_efficiency, 
round(avg(price),2) as avg_price,count(*) as sale_of_cars, case 
when mpg<=10 then '0-10'  
when mpg <=20 then '10-20' 
when mpg <=35 then '20-35'
when mpg <=60 then '35-60'
else '> 60' end as mpg_range FROM merc as a
join models as b on a.model_id = b.model_id 
join fueltype as c on a.fuel_id = c.fuel_id 
group by id, model_name,fueltype, mpg 
order by mpg;


SELECT  model_name as CarsTypes_of_bmw, fueltype, round(mpg,2) as mpg, round(avg(price),2) as avg_price, count(*) as sale_of_cars, case when mpg<=10 then '0-10'  
when mpg <=20 then '10-20' 
when mpg <=35 then '20-35'
when mpg <=60 then '35-60'
else '> 60' end as mpg_range
FROM bmw as a
join models as b on a.model_id = b.model_id 
join fueltype as c on a.fuel_id = c.fuel_id 
group by model_name,fueltype, mpg 
order by mpg; 


SELECT  model_name as CarsTypes_of_audi, fueltype, round(mpg,2) as mpg, round(avg(price),2) as avg_price, count(*) as sale_of_cars, case when mpg<=10 then '0-10'  
when mpg <=20 then '10-20' 
when mpg <=35 then '20-35'
when mpg <=60 then '35-60'
else '> 60' end as mpg_range
FROM audi as a
join models as b on a.model_id = b.model_id 
join fueltype as c on a.fuel_id = c.fuel_id 
group by model_name,fueltype, mpg 
order by mpg; 


SELECT  model_name as CarsTypes_of_hyndai, fueltype, round(mpg,2) as mpg, round(avg(price),2) as avg_price, count(*) as sale_of_cars, case when mpg<=10 then '0-10'  
when mpg <=20 then '10-20' 
when mpg <=35 then '20-35'
when mpg <=60 then '35-60'
else '> 60' end as mpg_range
FROM hyndai as a
join models as b on a.model_id = b.model_id 
join fueltype as c on a.fuel_id = c.fuel_id 
group by model_name,fueltype, mpg 
order by mpg;

SELECT model_name as CarsTypes_of_cclass, b.fueltype, a.year, 
ROUND((AVG(a.mileage) / 1000) / AVG(a.enginesize), 2) AS avg_fuel_efficiency, CASE 
WHEN (AVG(a.mileage) / 1000) / AVG(a.enginesize) <= 10 THEN '0-10'  
WHEN (AVG(a.mileage) / 1000) / AVG(a.enginesize) <= 20 THEN '10-20' 
WHEN (AVG(a.mileage) / 1000) / AVG(a.enginesize) <= 35 THEN '20-35'
WHEN (AVG(a.mileage) / 1000) / AVG(a.enginesize) <= 60 THEN '35-60'
ELSE '> 60' END AS mpg_range, ROUND(AVG(a.price), 2) AS avg_price, count(*) as sale_of_cars
FROM cclass AS a
JOIN fueltype AS b ON a.fuel_id = b.fuel_id 
join models as c on a.model_id = c.model_id
GROUP BY CarsTypes_of_cclass,b.fueltype, a.year
ORDER BY CarsTypes_of_cclass,b.fueltype, a.year, mpg_range;

select * from models;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Create an analysis to show the effect of fuel expenditure on the sales of car over the years(Get the fuel prices in the UK through the years through internet sources)
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Now importing the fuel_price table which is collected from the various internet sources. Data is in Dollar per Litre for both Petrol and Diesel. 
# And calculating the fuel expenditure
select * from merc;

SELECT a.year, mileage, mpg, petrol, enginesize, price,
ROUND((mileage / mpg) * price * (enginesize / 100) * price, 2) AS fuel_expenditure_mercedes FROM merc as a 
join fuelprice as b on a.year = b.year
order by a.year;


SELECT a.year, mileage, mpg, petrol, enginesize, price,
ROUND((mileage / mpg) * price * (enginesize / 100) * price, 2) AS fuel_expenditure_mercedes FROM bmw as a 
join fuelprice as b on a.year = b.year
order by a.year;


SELECT a.year, mileage, mpg, petrol, enginesize, price,
ROUND((mileage / mpg) * price * (enginesize / 100) * price, 2) AS fuel_expenditure_mercedes FROM hyndai as a 
join fuelprice as b on a.year = b.year
order by a.year;


SELECT a.year, mileage, mpg, petrol, enginesize, price,
ROUND((mileage / mpg) * price * (enginesize / 100) * price, 2) AS fuel_expenditure_mercedes FROM audi as a 
join fuelprice as b on a.year = b.year
order by a.year;


-- ------------------------------------------------------------------------------------------------------------------------------------------------

-- Affordable Cars with Good Fuel Efficiency (Audi):

-- Model: A3
-- Fuel Type: Gasoline
-- MPG: Approximately 30
-- Average Price: Around $25,000
-- Mid-Range Cars with Balanced Performance (Audi):

-- Model: A6
-- Fuel Type: Diesel
-- MPG: Approximately 35
-- Average Price: Around $35,000
-- Luxury Cars with High Performance (Audi):

-- Model: A8
-- Fuel Type: Hybrid
-- MPG: Approximately 25
-- Average Price: Around $50,000
-- Compact Cars with Good Fuel Efficiency (Mercedes):

-- Model: A-Class
-- Fuel Type: Gasoline
-- MPG: Approximately 32
-- Average Price: Around $28,000
-- Mid-Range SUV with Balanced Performance (Mercedes):

-- Model: GLC
-- Fuel Type: Diesel
-- MPG: Approximately 28
-- Average Price: Around $40,000
-- Luxury SUV with High Performance (Mercedes):

-- Model: GLE
-- Fuel Type: Hybrid
-- MPG: Approximately 24
-- Average Price: Around $55,000

-- Hyundai:

-- Economical Compact Car (Hyundai):

-- Model: Hyundai Accent
-- Fuel Type: Gasoline
-- MPG: Approximately 33
-- Average Price: Around $17,000
-- Versatile SUV (Hyundai):

-- Model: Hyundai Tucson
-- Fuel Type: Gasoline
-- MPG: Approximately 26
-- Average Price: Around $25,000
-- Fuel-Efficient Hybrid (Hyundai):

-- Model: Hyundai Ioniq Hybrid
-- Fuel Type: Hybrid
-- MPG: Approximately 58
-- Average Price: Around $24,000
-- BMW:

-- Luxurious Compact Car (BMW):

-- Model: BMW 3 Series
-- Fuel Type: Gasoline
-- MPG: Approximately 30
-- Average Price: Around $40,000
-- High-Performance SUV (BMW):

-- Model: BMW X5
-- Fuel Type: Diesel
-- MPG: Approximately 26
-- Average Price: Around $55,000
-- Electric Luxury Car (BMW):

-- Model: BMW i4
-- Fuel Type: Electric
-- MPGe: Approximately 75
-- Average Price: Around $50,000
-- These recommendations cover a spectrum of vehicle types and cater to different preferences within the Hyundai and BMW brands. Launching a variety of cars will allow the brand to address the needs of diverse customer segments in the automotive market.

-- User
-- and cclass?
-- ChatGPT
-- Certainly, for the Mercedes-Benz C-Class, here are some recommendations:

-- Mercedes-Benz C-Class:

-- Luxurious Sedan (C-Class):

-- Model: Mercedes-Benz C300
-- Fuel Type: Gasoline
-- MPG: Approximately 28
-- Average Price: Around $45,000
-- Performance-oriented Coupe (C-Class):

-- Model: Mercedes-Benz C43 AMG Coupe
-- Fuel Type: Gasoline
-- MPG: Approximately 22
-- Average Price: Around $60,000
-- Eco-friendly Hybrid (C-Class):

-- Model: Mercedes-Benz C350e Plug-in Hybrid
-- Fuel Type: Plug-in Hybrid
-- MPG: Approximately 50 MPGe
-- Average Price: Around $50,000


-- -----------------------------------------------------------------------------------------------------------------------------------------------------
# You are also asked to rank across all the models based on their total sales, average price, average mileage, average engine size, etc. and 
# now filter the top 5 basis their sales. Observe the identified models and provide your inference.
-- -----------------------------------------------------------------------------------------------------------------------------------------------------


WITH st AS (
SELECT b.model_name AS CarsTypes_of_merc, ROUND((AVG(a.mileage) / 1000) / AVG(a.enginesize), 2) AS avg_fuel_efficiency,
ROUND(AVG(a.price), 2) AS avg_price, COUNT(*) AS total_sales, dense_rank() OVER (ORDER BY COUNT(*) DESC) AS sales_rank FROM merc a
JOIN models b ON a.model_id = b.model_id
GROUP BY b.model_name
ORDER BY total_sales DESC
)
SELECT CarsTypes_of_merc, avg_fuel_efficiency, avg_price, total_sales FROM st
WHERE sales_rank <= 5
ORDER BY total_sales DESC;
-- 5 model of cars are provided and those are the most sold car types. The reason behind that is the fuel efficiency and the price. 
-- Customers are satisfied with the car in Mercedes company for most of these car types 
-- and I'll prefer to modify those car sections and provide new technology to make them better.


WITH st AS (
SELECT b.model_name AS CarsTypes_of_BMW, ROUND((AVG(a.mileage) / 1000) / AVG(a.enginesize), 2) AS avg_fuel_efficiency,
ROUND(AVG(a.price), 2) AS avg_price, COUNT(*) AS total_sales, dense_rank() OVER (ORDER BY COUNT(*) DESC) AS sales_rank FROM bmw a
JOIN models b ON a.model_id = b.model_id
GROUP BY b.model_name
ORDER BY total_sales DESC
)
SELECT CarsTypes_of_BMW, avg_fuel_efficiency, avg_price, total_sales FROM st
WHERE sales_rank <= 5
ORDER BY total_sales DESC;
-- series 3 , 5 and 1 are best  according to average fuel efficiency but series 5 and slightly high price and less sold as compared. 
-- Customers are satisfied with the car in BMW company for most of these car types and I'll prefer to modify those car sections and provide new technology to make them better.


WITH st AS (
SELECT b.model_name AS CarsTypes_of_audi, ROUND((AVG(a.mileage) / 1000) / AVG(a.enginesize), 2) AS avg_fuel_efficiency,
ROUND(AVG(a.price), 2) AS avg_price, COUNT(*) AS total_sales, dense_rank() OVER (ORDER BY COUNT(*) DESC) AS sales_rank FROM audi a
JOIN models b ON a.model_id = b.model_id
GROUP BY b.model_name
ORDER BY total_sales DESC
)
SELECT CarsTypes_of_audi, avg_fuel_efficiency, avg_price, total_sales FROM st
WHERE sales_rank <= 5
ORDER BY total_sales DESC;
-- A3 car types are most sold because of good average fuel efficiency with good price section. 
-- Little imorovement can be done for A5 and Q3 models. However, they are good to be modified. 



WITH st AS (
SELECT b.model_name AS CarsTypes_of_hyundai, ROUND((AVG(a.mileage) / 1000) / AVG(a.enginesize), 2) AS avg_fuel_efficiency,
ROUND(AVG(a.price), 2) AS avg_price, COUNT(*) AS total_sales, dense_rank() OVER (ORDER BY COUNT(*) DESC) AS sales_rank FROM hyndai a
JOIN models b ON a.model_id = b.model_id
GROUP BY b.model_name
ORDER BY total_sales DESC
)
SELECT CarsTypes_of_hyundai, avg_fuel_efficiency, avg_price, total_sales FROM st
WHERE sales_rank <= 5
ORDER BY total_sales DESC;
-- I20 has the highest fuel efficiency and Hyundai provides more fuel efficient cars in the market. 
-- However, most sold car is Tucson car type due to the looks and customer satisfaction. 



WITH st AS (
SELECT b.model_name AS CarsTypes_of_cclass, ROUND((AVG(a.mileage) / 1000) / AVG(a.enginesize), 2) AS avg_fuel_efficiency,
ROUND(AVG(a.price), 2) AS avg_price, COUNT(*) AS total_sales, rank() OVER (ORDER BY COUNT(*) DESC) AS sales_rank FROM cclass a
JOIN models b ON a.model_id = b.model_id
GROUP BY b.model_name
ORDER BY total_sales DESC
)
SELECT CarsTypes_of_cclass, avg_fuel_efficiency, avg_price, total_sales FROM st
WHERE sales_rank <= 5
ORDER BY total_sales DESC;
-- C Class Car type is a separate category. Fuel efficiency is average in comparison but this types of cars need much improvement 
-- both in marketing and product classification and modification. 

use proj;

