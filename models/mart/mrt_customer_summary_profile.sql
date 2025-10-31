

WITH staff_monthly AS (
    SELECT
        staff_id,
        employee_first_name,
        employee_last_name,
        store_id,
        store_name,
        year,
        month,
        total_sales_amount,
        total_orders,
        total_items_sold,
        avg_order_value
    FROM {{ ref('mart_staff_performance_monthly') }}
),

ranked AS (
    SELECT
        *,
        RANK() OVER (PARTITION BY year, month ORDER BY total_sales_amount DESC) AS rank_by_sales,
        RANK() OVER (PARTITION BY year, month ORDER BY total_orders DESC) AS rank_by_orders,
        RANK() OVER (PARTITION BY year, month ORDER BY avg_order_value DESC) AS rank_by_avg_order
    FROM staff_monthly
)

SELECT *
FROM ranked
WHERE rank_by_sales <= 10  -- top 10 vendeurs du mois
ORDER BY year, month, rank_by_sales
