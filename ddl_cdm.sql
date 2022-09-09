-- CDM 
create schema dev_cdm;

create table if not exists dev_cdm.m_sales_daily (
	id serial PRIMARY key,
	"date" date not null,
	sales_point varchar(50) not null,
	product varchar(50) not null,
	actual_price decimal(14,2) DEFAULT 0 NOT NULL CONSTRAINT m_sales_daily_actual_price_check CHECK (actual_price >= 0),
	actual_count int DEFAULT 0 NOT NULL CONSTRAINT m_sales_actual_count_check CHECK ((actual_count >= 0)),
	actual_revenue decimal(14,2) DEFAULT 0 NOT NULL CONSTRAINT m_sales_daily_actual_revenue_check CHECK (actual_revenue >= 0),
	plan_price decimal(14,2) DEFAULT 0 NOT NULL CONSTRAINT m_sales_daily_plan_price_check CHECK (plan_price >= 0),
	plan_count int DEFAULT 0 NOT NULL CONSTRAINT m_sales_plan_count_check CHECK ((plan_count >= 0)),
	plan_revenue decimal(14,2) DEFAULT 0 NOT NULL CONSTRAINT m_sales_daily_plan_revenue_check CHECK (plan_revenue >= 0),
	cum_month_revenue decimal(14,2) DEFAULT 0 NOT NULL CONSTRAINT m_sales_daily_cum_month_revenue CHECK (plan_revenue >= 0),
	plan_completion decimal(14,2) DEFAULT 0 NOT NULL CONSTRAINT m_sales_daily_plan_completion_check CHECK (plan_completion >= 0) -- процент выполнения на этот день с начала месяца
);