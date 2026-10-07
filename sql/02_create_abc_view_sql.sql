-- public.v_abc_sales_analysis исходный текст

CREATE OR REPLACE VIEW public.v_abc_sales_analysis
AS WITH total_margin_cte AS (
         SELECT sum(sales_products.margin_rub) AS total_margin
           FROM sales_products
        ), running_margin_cte AS (
         SELECT s.product_id,
            s.product_name,
            s.category,
            s.revenue_rub,
            s.margin_rub,
            s.sales_qty,
            s.stock_on_hand,
            sum(s.margin_rub) OVER (ORDER BY s.margin_rub DESC) AS running_margin,
            ( SELECT total_margin_cte.total_margin
                   FROM total_margin_cte) AS total_margin
           FROM sales_products s
        ), percent_cte AS (
         SELECT running_margin_cte.product_id,
            running_margin_cte.product_name,
            running_margin_cte.category,
            running_margin_cte.revenue_rub,
            running_margin_cte.margin_rub,
            running_margin_cte.sales_qty,
            running_margin_cte.stock_on_hand,
            running_margin_cte.running_margin,
            running_margin_cte.total_margin,
            round(running_margin_cte.running_margin / running_margin_cte.total_margin * 100::numeric, 2) AS margin_share_percent
           FROM running_margin_cte
        )
 SELECT product_id,
    product_name,
    category,
    revenue_rub,
    margin_rub,
    sales_qty,
    stock_on_hand,
    margin_share_percent,
        CASE
            WHEN margin_share_percent <= 80.00 THEN 'A'::text
            WHEN margin_share_percent <= 95.00 THEN 'B'::text
            ELSE 'C'::text
        END AS abc_category
   FROM percent_cte;