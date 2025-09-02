/* 
=======================
DDL Script: Create Bronze Table
=======================
Script Purpose:
	This scrips create tables for the bronze schema, dropping existing tables if any exists.
*/
if OBJECT_ID('bronze.cust_info','U') is not null
	drop table bronze.cust_info
create table bronze.cust_info(
	cust_id int,
	cust_m_id int,
	cust_name nvarchar(100),
	cust_email_id nvarchar(100),
	cust_type nvarchar(100),
	cust_addr VARCHAR(100),
	cust_cont_no bigint,
);

if OBJECT_ID('bronze.membership_info','U') is not null
	drop table bronze.membership_info

create table bronze.membership_info(
	m_id int,
	Startdate DATE,
	end_date date
);

if OBJECT_ID('bronze.emp_info','U') is not null
	drop table bronze.emp_info

create table bronze.emp_info(
	emp_id int,
	emp_name nvarchar(30),
	emp_designation nvarchar(50),
	emp_addr nvarchar(100),
	emp_branch nvarchar (50),
	emp_cont_no bigint
);

if OBJECT_ID('bronze.payment_info','U') is not null
	drop table bronze.payment_info

create table bronze.payment_info(
	payment_id nvarchar(100),
	c_id int,
	si_id int,
	Amount int,
	payment_Status nvarchar(30),
	payment_mode nvarchar(50),
	payment_date date,
);

if OBJECT_ID('bronze.shipment_info','U') is not null
	drop table bronze.shipment_info

create table bronze.shipment_info(
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

if OBJECT_ID('bronze.status_info','U') is not null
	drop table bronze.status_info

create table bronze.status_info(
	status_si_id int,
	current_st nvarchar(15),
	sent_date date,
	delivery_date date,
);

if OBJECT_ID('bronze.emp_ship_info','U') is not null
	drop table bronze.emp_ship_info

create table bronze.emp_ship_info(
	Employee_emp_id int,
	shipment_si_id int,
	status_si_id int
);










