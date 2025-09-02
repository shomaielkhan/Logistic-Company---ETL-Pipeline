/* 
=========================================
Stored Procedure : Load Silver Layer (Bronze -> Silver)
=========================================
Script Purpose:
	This stored procedure loads data into the 'Silver' from Bronze Layer.
	It perfroms following actions:
		- Truncate the bronze table before loading data.
		- Perform Cleaning and Standardizing Data and then Inserting into Silver Layer Tables.

*/

EXEC silver.load_silver;

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME = GETDATE();
	BEGIN TRY
		set @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Silver Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading Logistic Tables';
		PRINT '------------------------------------------------';
		-------------

		SET @start_time=GETDATE();
		print '>> Truncating Table silver.cust_info';
		Truncate table silver.cust_info
		print'=========================';
		print '>> Inserting Data into: silver.cust_info';
		print'=========================';

		INSERT INTO silver.cust_info(
			cust_id,
			cust_m_id,
			cust_name,
			cust_email_id,
			cust_type ,
			cust_addr,
			cust_cont_no
		)
		SELECT 
		cust_id,
		cust_m_id,
		LTRIM(RTRIM(cust_name)) AS cust_name,
		LOWER(cust_email_id) AS cust_email_id,
		cust_type,
		NULLIF(cust_addr, '') AS cust_addr,
		cust_cont_no 
		FROM bronze.cust_info
		where cust_id is not null;
		SET @end_time =GETDATE();	

		PRINT '>> Data load completed. Duration: '+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';
		-------------
		SET @start_time=GETDATE();
		print '>> Truncating Table silver.emp';
		Truncate table silver.emp_info
		print'=========================';
		print '>> Inserting Data into: silver.emp_info';
		print'=========================';

		INSERT INTO silver.emp_info (
			emp_id ,
			emp_name ,
			emp_designation,
			emp_addr,
			emp_branch,
			emp_cont_no
		)
		SELECT 
		emp_id,
		LTRIM(RTRIM(emp_name)) AS emp_name,
		LTRIM(RTRIM(emp_designation)) AS emp_designation,
		NULLIF(emp_addr, '') AS emp_addr,
		emp_branch,
		emp_cont_no
		FROM bronze.emp_info
		WHERE emp_branch IS NOT NULL        -- remove rows with NULL branch
		AND emp_cont_no IS NOT NULL       -- remove rows with NULL contact
		AND LEN(emp_cont_no) >= 10;-- example: filter invalid contact length

		SET @end_time =GETDATE();	
		PRINT '>> Data load completed. Duration: '+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';
		---------------
		SET @start_time=GETDATE();
		print '>> Truncating Table silver.membership_info';
		Truncate table silver.membership_info
		print'=========================';
		print '>> Inserting Data into: silver.membership_info';
		print'=========================';

		INSERT INTO silver.membership_info (
			m_id,
			Startdate,
			end_date
		)
		SELECT 
		m_id,
		Startdate,
	    end_date
		FROM bronze.membership_info
		WHERE Startdate < end_date
		order by 1;

		SET @end_time =GETDATE();	
		PRINT '>> Data load completed. Duration: '+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';
		------------------------
		SET @start_time=GETDATE();
		print '>> Truncating Table silver.payment_info';
		Truncate table silver.payment_info
		print'=========================';
		print '>> Inserting Data into: silver.payment_info';
		print'=========================';

		INSERT INTO silver.payment_info(
			payment_id,
			c_id,
			si_id,
			Amount,
			payment_Status,
			payment_mode,
			payment_date
		)
		SELECT 
		payment_id,
		c_id,
		si_id,
		case 
			when amount is null or amount <= 0 then 0 else amount
		end as Amount,
        LOWER(RTRIM(payment_Status)) AS payment_status,
		LOWER(RTRIM(payment_mode)) AS payment_mode,
		COALESCE(CONVERT(VARCHAR, payment_date, 23), 'Not Sure') AS payment_date
        FROM bronze.payment_info;
		SET @end_time =GETDATE();	
		PRINT '>> Data load completed. Duration: '+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';
		-------------------


		SET @start_time=GETDATE();
		print '>> Truncating Table silver.shipment_info';
		Truncate table silver.shipment_info
		print'=========================';
		print '>> Inserting Data into: silver.shipment_info';
		print'=========================';

		INSERT INTO silver.shipment_info(
			si_id,
			si_cust_id,
			si_content,
			si_domain,
			si_type,
			si_weight,
			si_charges,
			si_addr,
			ds_addr
			)
			SELECT 
			si_id,
			si_cust_id,
			si_content,
			si_domain,
			si_type,
			si_weight,
			si_charges,
			si_addr,
			ds_addr
			FROM bronze.shipment_info
			where 
				si_cust_id is not null
				and si_content is not null 
				and si_domain is not null 
				and si_type is not null 
				and si_weight is not null 
				and si_charges is not null
		SET @end_time =GETDATE();	
		PRINT '>> Data load completed. Duration: '+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';
		---------------------------
		SET @start_time=GETDATE();
		print '>> Truncating Table silver.shipment_info';
		Truncate table silver.shipment_info
		print'=========================';
		print '>> Inserting Data into: silver.shipment_info';
		print'=========================';

		INSERT INTO silver.shipment_info(
			si_id,
			si_cust_id,
			si_content,
			si_domain,
			si_type,
			si_weight,
			si_charges,
			si_addr,
			ds_addr
			)
			SELECT 
			si_id,
			si_cust_id,
			si_content,
			si_domain,
			si_type,
			si_weight,
			si_charges,
			si_addr,
			ds_addr
			FROM bronze.shipment_info
			where 
				si_cust_id is not null
				and si_content is not null 
				and si_domain is not null 
				and si_type is not null 
				and si_weight is not null 
				and si_charges is not null
		SET @end_time =GETDATE();	
		PRINT '>> Data load completed. Duration: '+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';
		------------------

		SET @start_time=GETDATE();
		print '>> Truncating Table silver.status_info';
		Truncate table silver.status_info
		print'=========================';
		print '>> Inserting Data into: silver.status_info';
		print'=========================';

		INSERT INTO silver.status_info(
			status_si_id,
			current_st,
			sent_date,
			delivery_date
			)
			SELECT
			status_si_id ,
			lower(rtrim(current_st)) as current_st,
			sent_date,
			case when delivery_date is NULL then 'Not Sure' else convert(nvarchar(20), delivery_date, 120) end as delivery_date
			FROM bronze.status_info
			ORDER BY 1;

			DELETE FROM bronze.status_info
			WHERE sent_date > delivery_date;
			
		SET @end_time =GETDATE();	
		PRINT '>> Data load completed. Duration: '+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';
		----------------
		SET @start_time=GETDATE();
		print '>> Truncating Table silver.emp_Ship_info';
		Truncate table silver.emp_ship_info
		print'=========================';
		print '>> Inserting Data into: silver.emp_ship_info';
		print'=========================';

		INSERT INTO silver.emp_ship_info(
			Employee_emp_id,
			shipment_si_id,
			status_si_id
			)
			select * from bronze.emp_ship_info
			where Employee_emp_id is not null or shipment_si_id is not null or status_si_id is not null
			order by 1;
			
		SET @end_time =GETDATE();	
		PRINT '>> Data load completed. Duration: '+ CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';

    END TRY
    BEGIN CATCH
        PRINT '>> Error occurred: ' + ERROR_MESSAGE();
        PRINT '>> Error occurred: ' + ERROR_MESSAGE();
    END CATCH
END
