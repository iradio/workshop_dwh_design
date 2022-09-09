-- DDS
create schema dev_dds;

drop table if exists dev_dds.d_product cascade;

create table if not exists dev_dds.d_product (
	id serial primary key,
	product varchar(50) NOT NULL 
);

drop table if exists dev_dds.d_sale_point cascade;

create table if not exists dev_dds.d_sale_point (
	id serial primary key,
	sales_point varchar(50) NOT NULL
);

drop table if exists dev_dds.f_plan;

create table if not exists dev_dds.f_plan (
	id serial PRIMARY key,
	sales_point_id int4 references dev_dds.d_sale_point (id),
	product_id int4 references dev_dds.d_product (id),
	--предлагаю все же разделить, чтобы, при необходимости, быстро создать дату
	"year" SMALLINT NOT NULL CONSTRAINT f_plan_year_check CHECK (("year">=2022) AND ("year"<2500)),
	"month" SMALLINT NOT NULL CONSTRAINT f_plan_month_check CHECK (("month">=1) AND ("month"<=12)),
	price decimal(10,2) DEFAULT 0 NOT NULL CONSTRAINT f_sales_price_check CHECK (price >= 0),
	sale_cnt int DEFAULT 0 NOT NULL CONSTRAINT f_plan_sales_cnt_check CHECK ((sale_cnt >= 0))
);

drop table if exists dev_dds.f_sales;

create table if not exists dev_dds.f_sales (
	id serial PRIMARY key,
	sales_point_id int4 references dev_dds.d_sale_point (id),
	product_id int4 references dev_dds.d_product (id),
	"date" date NOT NULL,
	price decimal(10,2) DEFAULT 0 NOT NULL CONSTRAINT f_sales_price_check CHECK (price >= 0),
	sale_cnt int DEFAULT 0 NOT NULL CONSTRAINT f_sales_sales_cnt_check CHECK ((sale_cnt >= 0))
);