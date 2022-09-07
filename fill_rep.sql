-- STG > DDS > CDM > REP

-- STG
select * from dev_stg.plan_2022;
select * from dev_stg.dns_2022;
select * from dev_stg.eldorado_2022;
select * from dev_stg.svyaznoy_2022;

-- DDS
create schema dev_dds;

drop table if exists dev_dds.d_product;

create table if not exists dev_dds.d_product (
	id serial primary key,
	product varchar(50)
);

drop table if exists dev_dds.d_sale_point;

create table if not exists dev_dds.d_sale_point (
	id serial primary key,
	sales_point varchar(50)
);

drop table if exists dev_dds.f_plan;

create table if not exists dev_dds.f_plan (
	id serial,
	sales_point_id int4 references dev_dds.d_sale_point (id),
	product_id int4 references dev_dds.d_product (id),
	year_month varchar,
--	plan_revenue_amount,
	price decimal(10,2),
	sale_cnt int
);

create table if not exists dev_dds.f_sales (
	id serial,
	sales_point_id int4 references dev_dds.d_sale_point (id),
	product_id int4 references dev_dds.d_product (id),
	"date" date,
	price decimal(10,2),
	sale_cnt int
);

-- CDM 
create schema dev_cdm;

create table if not exists dev_cdm.m_sales_daily (
	"date" date,
	sales_point varchar(50),
	product varchar(50),
	actual_price decimal(10,2),
	actual_count int,
	actual_revenue decimal(10,2),
	plan_price decimal(10,2),
	plan_count int,
	plan_revenue decimal(10,2)
--	plan_completion decimal(10,2) -- процент выполнения на этот день с начала месяца
);

-- REP
create schema dev_rep;

drop table if exists dev_rep.m_sales_monthly;

create table if not exists dev_rep.m_sales_monthly (
	"month" varchar(50),
	Report_date date,
	Shop_name varchar(50),
	Product_name varchar(50),
	Plan_revenue_amt decimal(10,2),
	Fact_revenue_amt decimal(10,2),
	Plan_comp_perc int
);


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
	concat('2022-0',p."month_")  year_month,
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




select 
	"month_",
	sales_point, 
	product,
	sum(price * sale_cnt) Plan_revenue_amt
from dev_stg.plan_2022 p 
group by "month_", sales_point, product 