-- FILL DDS

INSERT INTO dev_dds.d_product (product)
SELECT DISTINCT product
FROM dev_stg.plan_2022 p;


INSERT INTO dev_dds.d_sale_point (sales_point)
select distinct sales_point from dev_stg.plan_2022; 

insert into dev_dds.f_plan (	
sales_point_id,
product_id,
year_month,
price,
sale_cnt)
select 
	dsp.id sales_point_id,
	dp.id product_id,
	concat('2022-',p."month_")  year_month,
	p.price price,
	p.sale_cnt sale_cnt 
from dev_stg.plan_2022 p 
left join dev_dds.d_sale_point dsp on p.sales_point = dsp.sales_point 
left join dev_dds.d_product dp on p.product = dp.product 

insert into dev_dds.f_sales (	
sales_point_id,
product_id,
date,
price,
sale_cnt)
select 
	dsp.id sales_point_id,
	dp.id product_id,
	p.sale_date,
	p.price price,
	p.sale_cnt sale_cnt 
from (
select 'DNS' as sales_point, * from dev_stg.dns_2022
union all 
select 'Эльдорадо',* from dev_stg.eldorado_2022
union all 
select 'Связной',* from dev_stg.svyaznoy_2022
) p
left join dev_dds.d_sale_point dsp on p.sales_point  = dsp.sales_point 
left join dev_dds.d_product dp on p.product = dp.product;
