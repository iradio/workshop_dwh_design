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
