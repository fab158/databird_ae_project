{{ config(materialized='table') }}

WITH default_calendar  AS (
    select
        PARSE_DATE('%Y-%m-%d', CONCAT({{ var('default_min_year') }}, '-01-01'))  as default_min_date,
        PARSE_DATE('%Y-%m-%d', CONCAT({{ var('default_max_year') }}, '-12-31'))  as default_max_date,
        PARSE_DATE('%Y-%m-%d', CONCAT({{ var('default_min_calendar') }}, '-01-01'))  as default_min_calendar,
        PARSE_DATE('%Y-%m-%d', CONCAT({{ var('default_max_calendar') }}, '-12-31'))  as default_max_calendar
),
base_calendar AS (
    SELECT 
        DATE_ADD(
            (SELECT default_min_calendar FROM default_calendar),
            INTERVAL day_num DAY
        ) AS full_date
    FROM UNNEST(GENERATE_ARRAY(
        0, 
        DATE_DIFF(
            (SELECT default_max_calendar FROM default_calendar),
            (SELECT default_min_calendar FROM default_calendar),
            DAY
        )
    )) AS day_num
),
technical_dates AS (
        select 
            default_min_date AS full_date 
        from default_calendar
    union all
        select 
            default_max_date AS full_date
        from default_calendar
),
calendar AS (
        select 
            full_date 
        from base_calendar
    union all 
        select 
            full_date 
        from technical_dates
)


select
    full_date,
    FORMAT_DATE('%Y%m%d', full_date) AS date_key,
    EXTRACT(YEAR from full_date) AS year,
    EXTRACT(QUARTER from full_date) AS quarter,
    EXTRACT(MONTH from full_date) AS month,
    EXTRACT(DAY from full_date) AS day,
    EXTRACT(DAYOFWEEK from full_date) AS day_of_week,
    EXTRACT(WEEK from full_date) AS week_of_year,
    FORMAT_DATE('%A', full_date) AS day_name,

    CASE 
        WHEN EXTRACT(DAYOFWEEK from full_date) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

    CASE 
        WHEN EXTRACT(MONTH from full_date) BETWEEN 1 AND 3 THEN 'T1'
        WHEN EXTRACT(MONTH from full_date) BETWEEN 4 AND 6 THEN 'T2'
        WHEN EXTRACT(MONTH from full_date) BETWEEN 7 AND 9 THEN 'T3'
        ELSE 'T4'
    END AS quarter_label,

    CASE 
        WHEN EXTRACT(MONTH from full_date) IN (12, 1, 2) THEN 'Winter'
        WHEN EXTRACT(MONTH from full_date) IN (3, 4, 5) THEN 'Spring'
        WHEN EXTRACT(MONTH from full_date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Autumn'
    END AS season
from calendar