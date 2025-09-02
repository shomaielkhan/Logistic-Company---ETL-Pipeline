---Customer Base by Type---

SELECT type, count(*) as customer_count
from gold.dim_customers
group by type
order by customer_count desc;

--Customer Base by Payment Status--

select status, count(*) as payment_status
from gold.dim_payment
group by status
order by payment_status;

-- Count the customer base based on their payment mode in descending order of count.--
select Mode, count(*) as Customer_base
from gold.dim_payment
group by Mode
order by Customer_base desc;

-- Count the customers as per shipment domain in descending order.  --
select domain, count(*) as Shipment_Domain
from gold.dim_shipment
group by domain
order by Shipment_Domain desc;

--Count the customer according to service type in descending order of count.  

select type, count(customer_key) 	as customercount
from gold.dim_customers
group by type
order by customercount desc;

-- Explore employee count based on the designation-wise count of employees' IDs in descending order.  --
SELECT 
    designation,
    COUNT(*) AS employee_count
FROM gold.dim_employees_information
GROUP BY designation
ORDER BY employee_count DESC;

--Branch-wise count of employees for efficiency of deliveries in descending order.  --
SELECT 
    branch,
    COUNT(*) AS employee_branch_count
FROM gold.dim_employees_information
GROUP BY branch
ORDER BY employee_branch_count DESC;

-- Finding C_ID, M_ID, and tenure for those customers whose membership is over 10 years. --
select Customer_id, membership_id, count(*) as membership_count
from gold.fact_employee_shipment_management
group by Customer_id, membership_id
order by membership_count desc;




SELECT * FROM gold.dim_employees_information;


select * from gold.dim_payment;
select * from silver.payment_info;
select * from bronze.payment_info;

select * from silver.shipment_info;