/* 
=========================================
Stored Procedure : Load Bronze Layer (Source -> Bronze)
=========================================
Script Purpose:
	This stored procedure loads data into the 'bronze' from external csv files.
	It perfroms following actions:
		- Truncate the bronze table before loading data.
		- Uses the 'bulk insert' command to load data from csv files to bronze tables.

*/
EXEC bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME = GETDATE();
	BEGIN TRY
		set @batch_start_time = GETDATE();
		PRINT('===============================');
		PRINT('Loading Bronze Layer')
		PRINT('==============================');

		print('-----------------------------');
		PRINT 'Loading Logistic Tables';
		PRINT('------------------------------');

		SET @start_time  = GETDATE();
		PRINT '>>Truncating Table: bronze.cust_info';
		TRUNCATE TABLE bronze.cust_info;
		PRINT '>> Inserting Data Into: bronze.cust_info';
		BULK INSERT bronze.cust_info
		FROM 'C:\Users\User-PC\Downloads\Logistics Company\Customer.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '\n',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR)+ 'seconds'
		PRINT '>>----------------';
		
		SET @start_time  = GETDATE();
		PRINT '>> Truncating Table: bronze.emp_info';
		TRUNCATE TABLE bronze.emp_info;
		PRINT '>> Inserting Data Into: bronze.emp_info';
		BULK INSERT bronze.emp_info
		FROM 'C:\Users\User-PC\Downloads\Logistics Company\Employee_Details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '\n',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR)+ 'seconds'
		PRINT '>>----------------';

		SET @start_time= GETDATE();
		PRINT '>> Truncate Table: bronze.membership_info';
		TRUNCATE TABLE bronze.membership_info;
		PRINT '>> INSERT DATA INTO: bronze.membership_info';
		BULK INSERT bronze.membership_info 
		FROM 'C:\Users\User-PC\Downloads\Logistics Company\Membership.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '\n',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time,@end_time)as NVARCHAR) + 'seconds'
		PRINT '---------------------';		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.emp_info';
		TRUNCATE TABLE bronze.emp_info;
		PRINT '>> Inserting Data Into: bronze.emp_info';
		BULK INSERT bronze.emp_info
		FROM 'C:\Users\User-PC\Downloads\Logistics Company\Employee_Details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '\n',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR)+ 'seconds'
		PRINT '>>----------------';

		SET @start_time= GETDATE();
		PRINT '>> Truncate Table: bronze.payment_info';
		TRUNCATE TABLE bronze.payment_info;
		PRINT '>> INSERT DATA INTO: bronze.payment_info';
		BULK INSERT bronze.payment_info 
		FROM 'C:\Users\User-PC\Downloads\Logistics Company\Payment_Details.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '\n',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time,@end_time)as NVARCHAR) + 'seconds'
		PRINT '---------------------';
		
		
		SET @start_time= GETDATE();
		PRINT '>> Truncate Table: bronze.shipment_info';
		TRUNCATE TABLE bronze.shipment_info;
		PRINT '>> INSERT DATA INTO: bronze.shipment_info';
		BULK INSERT bronze.shipment_info 
		FROM 'C:\Users\User-PC\Downloads\Logistics Company\Shipment_Details.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '\n',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time,@end_time)as NVARCHAR) + 'seconds'
		PRINT '---------------------';

		SET @start_time= GETDATE();
		PRINT '>> Truncate Table: bronze.status_info';
		TRUNCATE TABLE bronze.status_info;
		PRINT '>> INSERT DATA INTO: bronze.status_info';
		BULK INSERT bronze.status_info 
		FROM 'C:\Users\User-PC\Downloads\Logistics Company\Status.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '\n',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time,@end_time)as NVARCHAR) + 'seconds'
		PRINT '---------------------';
		
		SET @start_time= GETDATE();
		PRINT '>> Truncate Table: bronze.emp_ship_info';
		TRUNCATE TABLE bronze.emp_ship_info;
		PRINT '>> INSERT DATA INTO: bronze.emp_ship_info';
		BULK INSERT bronze.emp_ship_info 
		FROM 'C:\Users\User-PC\Downloads\Logistics Company\employee_manages_shipment.csv'
		WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		ROWTERMINATOR = '\n',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time,@end_time)as NVARCHAR) + 'seconds'
		PRINT '---------------------';




	END TRY
	BEGIN CATCH
		PRINT 'Error occurred while loading Bronze Layer: ' 
			+ ERROR_MESSAGE();
	END CATCH

END
GO

