-- FILL CDM

INSERT INTO dev_cdm.m_sales_daily (
date, 
sales_point,
product,
actual_price,
actual_count,
actual_revenue,
plan_price,
plan_count,
plan_revenue, 
cum_month_revenue,
plan_completion)
select 
	s."date" ,
	dsp.sales_point,
	dp.product product,
	s.price actual_price,
	s.sale_cnt  actual_count,
	(s.price*s.sale_cnt) actual_revenue,
	p.price plan_price,
	p.sale_cnt plan_count,
	(p.price*p.sale_cnt) plan_revenue,
	round(sum(s.price*s.sale_cnt) OVER (PARTITION BY dp.product, dsp.sales_point, p."month", p."year" ORDER BY s."date"), 2) AS cum_month_revenue,
	round(sum(s.price*s.sale_cnt) OVER (PARTITION BY dp.product, dsp.sales_point, p."month", p."year" ORDER BY s."date") / 
	(p.price*p.sale_cnt), 2) AS plan_completion
from dev_dds.f_sales s
left join dev_dds.f_plan p on 
	p.sales_point_id = s.sales_point_id  
	and p.product_id = s.product_id 
	AND p."year" = extract('year' FROM s."date")
	AND p."month" = extract('month' from s."date")
left join dev_dds.d_product dp on dp.id = s.product_id 
left join dev_dds.d_sale_point dsp  on dsp.id = s.sales_point_id
WHERE s."date" NOT IN 
(SELECT DISTINCT "date"
FROM dev_cdm.m_sales_daily);
