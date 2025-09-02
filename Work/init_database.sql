/* 
====================================
Create Database and Schemas
=====================================

Script Purpose:
	This purpose is to create a new database 'Logistic_DataWarehouse' after checking if its already exist.
	if the database exist, it is dropped or altered. Also, scripts set up three schemas within the 
	database; 'bronze','silver' and 'gold'.

	Warning:
		Running this script will drop the entire database 'Logistic_DataWarehouse' if it's already exist.

*/
use master;

if exists (select 1 from sys.databases where name= 'Logistic_DataWarehouse')
begin 
	alter database Logistic_DataWarehouse set SINGLE_USER WITH rollback immediate; 
	drop database Logistic_DataWarehouse;
end;
go

create database Logistic_DataWarehouse;

use Logistic_DataWarehouse;

create schema bronze;

create schema silver;
go

create schema gold;
