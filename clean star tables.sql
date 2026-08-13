SET SQL_SAFE_UPDATES = 0;
USE embermobile;
-- --- Previewing size of gender naming issues
SELECT gender, COUNT(*) FROM dim_customer GROUP BY gender;
SELECT InternetService, COUNT(*) FROM dim_services GROUP BY InternetService;
SELECT COUNT(*) AS bad_tenure   FROM dim_contract WHERE tenure < 0 OR tenure > 72;
SELECT COUNT(*) AS bad_charges  FROM fact_billing WHERE MonthlyCharges < 0 OR MonthlyCharges > 200;
SELECT
  SUM(TechSupport    IS NULL) AS null_techsupport,
  SUM(OnlineSecurity IS NULL) AS null_security
FROM dim_services;
SELECT SUM(PaymentMethod IS NULL) AS null_payment FROM fact_billing;

-- --- clean customer table
UPDATE dim_customer
SET gender = CONCAT(
      UPPER(LEFT(TRIM(gender), 1)),
      LOWER(SUBSTRING(TRIM(gender), 2))
    )
WHERE gender IS NOT NULL;

-- --- clean services table
UPDATE dim_services
SET InternetService = 'Fiber optic'
WHERE InternetService = 'Fiber Optic';

-- --- clean contract table
UPDATE dim_contract
SET tenure = NULL
WHERE tenure < 0 OR tenure > 72;

-- --- billing table update
UPDATE fact_billing
SET MonthlyCharges = NULL
WHERE MonthlyCharges < 0 OR MonthlyCharges > 200;

-- ---impute unknown to null missing data
UPDATE dim_services SET TechSupport    = 'Unknown' WHERE TechSupport    IS NULL;
UPDATE dim_services SET OnlineSecurity = 'Unknown' WHERE OnlineSecurity IS NULL;
UPDATE fact_billing SET PaymentMethod  = 'Unknown' WHERE PaymentMethod  IS NULL;
UPDATE dim_account SET account_status = 'Unknown' WHERE account_status IS NULL;

-- --- verify clean steps
SELECT gender, COUNT(*) FROM dim_customer GROUP BY gender ORDER BY 2 DESC;
SELECT InternetService, COUNT(*) FROM dim_services GROUP BY InternetService;
SELECT MIN(tenure), MAX(tenure) FROM dim_contract;
SELECT MIN(MonthlyCharges), MAX(MonthlyCharges) FROM fact_billing;
SELECT account_status, COUNT(*) FROM dim_account GROUP BY account_status;