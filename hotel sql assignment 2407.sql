SELECT * FROM hotel2018;
SELECT * FROM hotel2019;
SELECT * FROM hotel2020;
SELECT * FROM market_segment;
SELECT * FROM meal_cost;


-- Room rent = Total night * adr
-- Meal Cost = Total people * Meal Cost * Total Night
-- Final payment = Room rent + Meal cost - Discount



-- 1. Is hotel revenue increasing year on year?
SELECT
  arrival_date_year,
  SUM(after_discount) AS revenue_2018
FROM (
  SELECT
    arrival_date_year,
    is_canceled,
    adr,
    adults,
    children,
    stays_in_week_nights,
    stays_in_weekend_nights,
    h.market_segment,
    h.meal,
    mc.cost, -- Correct alias for the cost column
    (stays_in_week_nights + stays_in_weekend_nights) * adr AS tariff,
    (stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost AS total_food_cost,
   CASE
WHEN is_canceled= 1 then null else ((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * adr) end AS total_amt,
   case when  is_canceled= 1 then null else (((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * adr)) * (1 - ms.discount) end AS after_discount
  FROM hotel2018 h
  INNER JOIN meal_cost mc ON h.meal = mc.meal
  INNER JOIN market_segment ms ON h.market_segment = ms.market_segment
) AS subquery

UNION ALL
SELECT
  arrival_date_year,
  SUM(after_discount) AS revenue_2018
FROM (
  SELECT
    arrival_date_year,
    is_canceled,
    adr,
    adults,
    children,
    stays_in_week_nights,
    stays_in_weekend_nights,
    h.market_segment,
    h.meal,
    mc.cost, -- Correct alias for the cost column
    (stays_in_week_nights + stays_in_weekend_nights) * adr AS tariff,
    (stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost AS total_food_cost,
   CASE
WHEN is_canceled= 1 then null else ((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * adr) end AS total_amt,
   case when  is_canceled= 1 then null else (((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * adr)) * (1 - ms.discount) end AS after_discount
  FROM hotel2019 h
  INNER JOIN meal_cost mc ON h.meal = mc.meal
  INNER JOIN market_segment ms ON h.market_segment = ms.market_segment
) AS subquery

UNION ALL

SELECT
  arrival_date_year,
  SUM(after_discount) AS revenue_2018
FROM (
  SELECT
    arrival_date_year,
    is_canceled,
    daily_room_rate,
    adults,
    children,
    stays_in_week_nights,
    stays_in_weekend_nights,
    h.market_segment,
    h.meal,
    mc.cost, -- Correct alias for the cost column
    (stays_in_week_nights + stays_in_weekend_nights) * daily_room_rate AS tariff,
    (stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost AS total_food_cost,
   CASE
WHEN is_canceled= 1 then null else ((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * daily_room_rate) end AS total_amt,
   case when  is_canceled= 1 then null else (((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * daily_room_rate)) * (1 - ms.discount) end AS after_discount
  FROM hotel2020 h
  INNER JOIN meal_cost mc ON h.meal = mc.meal
  INNER JOIN market_segment ms ON h.market_segment = ms.market_segment
) AS subquery
GROUP BY arrival_date_year;





-- Final query for 2. What market segment are major contributors of the revenue per year? In there a change year on year?
-- For hotel2018
SELECT
  arrival_date_year, market_segment,
  SUM(after_discount) AS revenue_2018
FROM (
  SELECT
    arrival_date_year,
    is_canceled,
    adr,
    adults,
    children,
    stays_in_week_nights,
    stays_in_weekend_nights,
    h.market_segment,
    h.meal,
    mc.cost, -- Correct alias for the cost column
    (stays_in_week_nights + stays_in_weekend_nights) * adr AS tariff,
    (stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost AS total_food_cost,
   CASE
WHEN is_canceled= 1 then null else ((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * adr) end AS total_amt,
   case when  is_canceled= 1 then null else (((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * adr)) * (1 - ms.discount) end AS after_discount
  FROM hotel2018 h
  INNER JOIN meal_cost mc ON h.meal = mc.meal
  INNER JOIN market_segment ms ON h.market_segment = ms.market_segment
) AS subquery
GROUP BY market_segment;


-- For hotel2019
SELECT
  arrival_date_year, market_segment,
  SUM(after_discount) AS revenue_2019
FROM (
  SELECT
    arrival_date_year,
    is_canceled,
    adr,
    adults,
    children,
    stays_in_week_nights,
    stays_in_weekend_nights,
    h.market_segment,
    h.meal,
    mc.cost, -- Correct alias for the cost column
    (stays_in_week_nights + stays_in_weekend_nights) * adr AS tariff,
    (stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost AS total_food_cost,
   CASE
WHEN is_canceled= 1 then null else ((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * adr) end AS total_amt,
   case when  is_canceled= 1 then null else (((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * adr)) * (1 - ms.discount) end AS after_discount
  FROM hotel2019 h
  INNER JOIN meal_cost mc ON h.meal = mc.meal
  INNER JOIN market_segment ms ON h.market_segment = ms.market_segment
) AS subquery
GROUP BY market_segment;

-- For hotel2020

SELECT
  arrival_date_year, market_segment,
  SUM(after_discount) AS revenue_2020
FROM (
  SELECT
    arrival_date_year,
    is_canceled,
    daily_room_rate,
    adults,
    children,
    stays_in_week_nights,
    stays_in_weekend_nights,
    h.market_segment,
    h.meal,
    mc.cost, -- Correct alias for the cost column
    (stays_in_week_nights + stays_in_weekend_nights) * daily_room_rate AS tariff,
    (stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost AS total_food_cost,
   CASE
WHEN is_canceled= 1 then null else ((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * daily_room_rate) end AS total_amt,
   case when  is_canceled= 1 then null else (((stays_in_week_nights + stays_in_weekend_nights) * (adults + children) * mc.cost) + ((stays_in_week_nights + stays_in_weekend_nights) * daily_room_rate)) * (1 - ms.discount) end AS after_discount
  FROM hotel2020 h
  INNER JOIN meal_cost mc ON h.meal = mc.meal
  INNER JOIN market_segment ms ON h.market_segment = ms.market_segment
) AS subquery
GROUP BY market_segment;


-- 3. When is the hotel at maximum occupancy? Is the period consistent across the years?
SELECT
    '2018' AS year,
    month_2018 AS month,
    total_guests_2018 AS total_guests
FROM (
    SELECT
        arrival_date_month AS month_2018,
        SUM(adults + children + babies) AS total_guests_2018
    FROM hotel2018
    WHERE is_canceled = 0
    GROUP BY month_2018
    ORDER BY total_guests_2018 DESC
    LIMIT 1
) AS data_2018

UNION ALL

SELECT
    '2019' AS year,
    month_2019 AS month,
    total_guests_2019 AS total_guests
FROM (
    SELECT
        arrival_date_month AS month_2019,
        SUM(adults + children + babies) AS total_guests_2019
    FROM hotel2019
    WHERE is_canceled = 0
    GROUP BY month_2019
    ORDER BY total_guests_2019 DESC
    LIMIT 1
) AS data_2019

UNION ALL

SELECT
    '2020' AS year,
    month_2020 AS month,
    total_guests_2020 AS total_guests
FROM (
    SELECT
        arrival_date_month AS month_2020,
        SUM(adults + children + babies) AS total_guests_2020
    FROM hotel2020
    WHERE is_canceled = 0
    GROUP BY month_2020
    ORDER BY total_guests_2020 DESC
    LIMIT 1
) AS data_2020;


-- 4. When are people cancelling the most?
SELECT
    year,
    month,
    count_total
FROM (
    SELECT
        '2018' AS year,
        arrival_date_month AS month, COUNT(arrival_date_month) AS count_total
    FROM hotel2018
    WHERE is_canceled = 1 
    GROUP BY year, month
ORDER BY year, count_total DESC
LIMIT 3
) AS data2018
    
    UNION ALL
SELECT
    year,
    month,
  count_total   
FROM (
SELECT
        '2019' AS year,
        arrival_date_month AS month, COUNT(arrival_date_month) AS count_total
    FROM hotel2019
    WHERE is_canceled = 1 
    GROUP BY year, month
ORDER BY year, count_total DESC
LIMIT 3
) AS data2019
UNION ALL

SELECT
    year,
    month,
    count_total
    FROM(
SELECT
        '2020' AS year,
        arrival_date_month AS month, COUNT(arrival_date_month) AS count_total
    FROM hotel2020
    WHERE is_canceled = 1 
    GROUP BY year, month
ORDER BY year, count_total DESC
LIMIT 3
)AS data2020;



-- 5. Are families with kids more likely to cancel the hotel booking?
SELECT
    children, babies,
    AVG(is_canceled) AS cancellation_rate
FROM (
    SELECT
        children, is_canceled, babies
    FROM hotel2018
    UNION ALL
    SELECT
        children, is_canceled, babies
    FROM hotel2019
    UNION ALL
    SELECT
        children, is_canceled, babies
    FROM hotel2020
) AS combined_data
GROUP BY children, babies;
