-- FILL CDM

select 
	s."date"::date "date",
	dsp.sales_point::varchar(50) sales_point,
	dp.product::varchar(50) product,
	s.price::decimal(10,2) actual_price,
	s.sale_cnt::int actual_count,
	(s.price*s.sale_cnt)::decimal(14,2) actual_revenue,
	p.price::decimal(10,2)  plan_price,
	p.sale_cnt::int plan_count,
	(p.price*p.sale_cnt)::decimal(14,2) plan_revenue
from dev_dds.f_sales s
left join dev_dds.f_plan p on 
	p.sales_point_id = s.sales_point_id  
	and p.product_id = s.product_id 
	and date_trunc('month',to_date(p."year_month",'YYYY_MM')) = date_trunc('month',s."date") 
left join dev_dds.d_product dp on dp.id = s.product_id 
left join dev_dds.d_sale_point dsp  on dsp.id = s.sales_point_id 
