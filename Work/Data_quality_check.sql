use Logistic_DataWarehouse;
select * from bronze.cust_info;
select * from bronze.emp_info;
select * from bronze.membership_info;
select * from bronze.payment_info;
select * from bronze.shipment_info;
select * from bronze.status_info;
select * from bronze.emp_ship_info;

-----membership_info----
select Startdate, end_date , count(*) as incorrect_date from bronze.membership_info
where end_date < Startdate
group by Startdate, end_date;


---bronze.payment_info------

----Data Duplicates----(Data Consistentcy)
SELECT payment_id, count(*) 
from bronze.payment_info
group by payment_id 
having count(*) >1 or payment_id is null;

select distinct shipment_client_id
from bronze.payment_info

select distinct shipment_sh_id
from bronze.payment_info

--Null Values or 0
select amount from bronze.payment_info where amount <= 0 or amount is null;

--Data Standardized (Lowercase)
select lower(rtrim(payment_status)) as payment_status
from bronze.payment_info

select lower(rtrim(payment_mode)) as payment_mode
from bronze.payment_info

select payment_date, case when payment_date is null then 'Not Sure' else 'Cleared' end as is_payment_missing
from bronze.payment_info ;


--------Shipment_info--------------
select * from bronze.shipment_info;

SELECT 
    si_id,
	si_cust_id,
    COUNT(*) AS duplicate_count
FROM bronze.shipment_info
GROUP BY 
    si_id,
	si_cust_id
    HAVING COUNT(*) > 1 

select si_content, si_domain, si_type from bronze.shipment_info
where si_content is null or si_domain is null or si_type is null;

------------------------

----------status----

select * from bronze.status_info;

select status_si_id
from bronze.status_info
group by status_si_id
having count(*)>1;

select (lower(ltrim(current_st))) as current_st
from bronze.status_info;

select sent_date,delivery_date, count(*) as incorrect_sent_date from bronze.status_info
WHERE sent_date > delivery_date
group by sent_date,delivery_date;

DELETE FROM bronze.status_info
WHERE sent_date > delivery_date;

UPDATE bronze.status_info
set delivery_date ='Not Delivered'
where delivery_date is null;

---bronze_emp_ship_info----

select * from bronze.emp_ship_info
where Employee_emp_id is not null or shipment_si_id is not null or status_si_id is not null
order by 1;

use Logistic_DataWarehouse;
select * from silver.emp_info;
select * from silver.emp_ship_info;
select * from silver.membership_info;
select * from silver.payment_info;
select * from silver.shipment_info;
select * from silver.status_info;
select * from gold.dim_customers