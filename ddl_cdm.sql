-- CDM 
create schema dev_cdm;

drop table if exists dev_cdm.m_sales_daily;

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