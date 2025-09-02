/*
==============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================

*/
-- Create Dimension: gold.dim_customers
-- =============================================================================

IF OBJECT_ID('gold.dim_customers','V')is not null
	DROP VIEW gold.dim_customers;
GO
CREATE VIEW gold.dim_customers AS 
SELECT
	ROW_NUMBER() OVER (ORDER BY c.cust_id) AS customer_key,
    c.cust_name AS customer_name,
    c.cust_email_id AS email_id,
    c.cust_type AS type,
    c.cust_addr AS address,
    c.cust_cont_no AS contact_no
FROM silver.cust_info c

IF OBJECT_ID('gold.employees_information','V')is not null
	DROP VIEW gold.employess_information;
GO

----------Dimension Employee Table-------------
CREATE VIEW gold.dim_employees_information AS
SELECT
	ROW_NUMBER() OVER (ORDER BY emp_id) AS employee_key,
	emp_name,
	emp_designation as designation,
	emp_addr as address,
	emp_branch as branch,
	emp_cont_no as contact 
FROM silver.emp_info;


------------Dimension Membership table-----------
IF OBJECT_ID('gold.dim_membership','V')is not null
	DROP VIEW gold.dim_membership_info;
GO

CREATE VIEW gold.dim_membership_info AS
SELECT
	m_id int,
	Startdate as start_date,
	end_date as expiry_date
FROM silver.membership_info;

--------Dimension Payment Table--------
IF OBJECT_ID('gold.dim_payment','V')is not null
	DROP VIEW gold.dim_payment;
GO

CREATE VIEW gold.dim_payment AS
SELECT
	payment_id,
	payment_status as status,
	payment_mode as Mode,
	payment_date
FROM silver.payment_info;


--------Dimension Shipment Table--------
IF OBJECT_ID('gold.dim_shipment','V')is not null
	DROP VIEW gold.dim_shipment;
GO

CREATE VIEW gold.dim_shipment AS
SELECT
	ROW_NUMBER() OVER (ORDER BY si_id) AS shipment_key,
	si_id as shipment_id,
	si_content as content,
	si_domain as domain,
	si_type as shipment_type,
	si_addr as shipment_address,
	ds_addr as delivery_address
FROM silver.shipment_info 

---Dimension Table-Status----
IF OBJECT_ID('gold.dim_status','V')is not null
	DROP VIEW gold.dim_status;
GO

CREATE VIEW gold.dim_status AS
SELECT
	status_si_id as status_id,
	current_st as current_status,
	sent_date,
	delivery_date
FROM silver.status_info 


----FACT Table : Employee_Shipment_Management

IF OBJECT_ID('gold.fact_employee_shipment_management','V')is not null
	DROP VIEW gold.fact_employee_shipment_management;
GO

CREATE VIEW gold.fact_employee_shipment_management AS
SELECT
	e.emp_id as Employee_id,
	s.si_id as Shipment_id,
	st.status_si_id as Status_id,
	c.cust_id as Customer_id,
	m_id as membership_id,
	si_charges as Shipment_charges,
	amount,
	si_weight as Shipment_weight
FROM silver.emp_ship_info esi
--Employee Dimension
LEFT JOIN silver.emp_info e ON esi.Employee_emp_id = e.emp_id
--Shipment Dimension
LEFT JOIN silver.shipment_info s ON esi.shipment_si_id=s.si_id
--Status Dimension
LEFT JOIN silver.status_info st ON esi.status_si_id = st.status_si_id
--Customer Dimension
LEFT JOIN silver.cust_info c ON s.si_cust_id= c.cust_id
--Membership Dimension
LEFT JOIN silver.membership_info m ON c.cust_id= m.m_id
--Payment Dimension
LEFT JOIN silver.payment_info p on s.si_id= p.payment_id








