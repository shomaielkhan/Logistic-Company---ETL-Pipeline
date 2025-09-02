/* 
=======================
DDL Script: Create Silver Table
=======================
Script Purpose:
	This scrips create tables for the bronze schema, dropping existing tables if any exists.
*/
use Logistic_DataWarehouse;
if OBJECT_ID('silver.cust_info','U') is not null
	drop table silver.cust_info
create table silver.cust_info(
	cust_id int,
	cust_m_id int,
	cust_name nvarchar(100),
	cust_email_id nvarchar(100),
	cust_type nvarchar(100),
	cust_addr VARCHAR(100),
	cust_cont_no bigint,
);

if OBJECT_ID('silver.membership_info','U') is not null
	drop table silver.membership_info

create table silver.membership_info(
	m_id int,
	Startdate DATE,
	end_date date
);

if OBJECT_ID('silver.emp_info','U') is not null
	drop table silver.emp_info

create table silver.emp_info(
	emp_id int,
	emp_name nvarchar(30),
	emp_designation nvarchar(50),
	emp_addr nvarchar(100),
	emp_branch nvarchar (50),
	emp_cont_no bigint
);

if OBJECT_ID('silver.payment_info','U') is not null
	drop table silver.payment_info

create table silver.payment_info(
	payment_id nvarchar(100),
	c_id int,
	si_id int,
	Amount int,
	payment_Status nvarchar(30),
	payment_mode nvarchar(50),
	payment_date nvarchar(30),
);

if OBJECT_ID('silver.shipment_info','U') is not null
	drop table silver.shipment_info

create table silver.shipment_info(
	si_id int,
	si_cust_id int,
	si_content nvarchar(40),
	si_domain nvarchar(15),
	si_type nvarchar(15),
	si_weight nvarchar(10),
	si_charges int,
	si_addr nvarchar(100),
	ds_addr nvarchar(100),
);

if OBJECT_ID('silver.status_info','U') is not null
	drop table silver.status_info

create table silver.status_info(
	status_si_id int,
	current_st nvarchar(15),
	sent_date date,
	delivery_date nvarchar(20)
);

if OBJECT_ID('silver.emp_ship_info','U') is not null
	drop table silver.emp_ship_info

create table silver.emp_ship_info(
	Employee_emp_id int,
	shipment_si_id int,
	status_si_id int
);

