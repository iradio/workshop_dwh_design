INSERT into dev_rep.m_sales_monthly (
	Report_date,
	Shop_name,
	Product_name,
	Plan_revenue_amt,
	Fact_revenue_amt,
	Plan_comp_perc
)
SELECT 
make_date(
extract("year" FROM date)::int,
extract("month" FROM date)::int,
1) + INTERVAL '1 month' - INTERVAL '1 day' AS report_date,
sales_point AS shop_name,
product AS product_name,
avg(plan_revenue) AS plan_revenue_amt,
sum(actual_revenue) AS fact_revenue_amt,
sum(actual_revenue) / avg(plan_revenue) AS plan_comp_perc
FROM dev_cdm.m_sales_daily msd
GROUP BY extract("month" FROM date),
extract("year" FROM date),
sales_point,
product;