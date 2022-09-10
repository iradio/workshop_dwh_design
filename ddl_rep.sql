-- REP
create schema dev_rep;

drop table if exists dev_rep.m_sales_monthly;

create table if not exists dev_rep.m_sales_monthly (
	Report_date date NOT null,
	Shop_name varchar(50) NOT null,
	Product_name varchar(50) NOT null,
	Plan_revenue_amt decimal(14,2) DEFAULT 0 NOT NULL CONSTRAINT m_sales_monthly_plan_revenue_check CHECK (plan_revenue_amt >= 0),
	Fact_revenue_amt decimal(14,2) DEFAULT 0 NOT NULL CONSTRAINT m_sales_monthly_cum_month_revenue CHECK (fact_revenue_amt >= 0),
	Plan_comp_perc  decimal(14,2) DEFAULT 0 NOT NULL CONSTRAINT m_sales_monthly_Plan_comp_perc_check CHECK (Plan_comp_perc >= 0)
);