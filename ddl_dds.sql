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

drop table if exists dev_dds.f_sales;

create table if not exists dev_dds.f_sales (
	id serial,
	sales_point_id int4 references dev_dds.d_sale_point (id),
	product_id int4 references dev_dds.d_product (id),
	"date" date,
	price decimal(10,2),
	sale_cnt int
);