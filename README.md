# workshop_dwh_design
 Проектирование DWH

## Для старта работы выполните следующие действия
- Из терминала перейдите в папку  
./postgres  
  
- Выполните команду  
docker-compose up  
  
- Дождитесь следующего сообщения:  
LOG:  database system is ready to accept connections  
  

- Зайтите в DBeaver, подключитесь к БД со следующими реквизитами:  
Хост: localhost  
Порт: 5430  
База данных: test  
Пользователь: postgres  
Пароль: password  
  
- Проверьте, что данные в базу dev_stg загрузились успешно (должно быть 186):  
select count(*) from dev_stg.dns_2022  
  
## Для завершения работы 
- В новом окне терминала перейти в папку ./postgres
- Выполнить следующую команду из нового терминала:  
docker-compose down --remove-orphans --volumes  

## Задача
Спроектировать DWH и построить отчет содержащий:
* Report_date::date
* Shop_name::varchar(50)
* Product_name::varchar(50)
* Plan_revenue_amt::decimal(10,2)
* Fact_revenue_amt::decimal(10,2)
* Plan_comp_perc::int

## Входные данные 
Таблицы в слое `dev_stg`:
* dns_2022
* eldorado_2022
* plan_2022
* svyaznoy_2022

## Архитектура DWH
Выбрана архитектура
```
STG > DDS > CDM > REP
```
