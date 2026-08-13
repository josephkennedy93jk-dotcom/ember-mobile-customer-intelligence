USE embermobile;
SELECT * FROM ember_mobile_raw LIMIT 20;
-- --- only for future runs once new tables are created
DROP TABLE IF EXISTS fact_activity;
DROP TABLE IF EXISTS fact_billing;
DROP TABLE IF EXISTS dim_services;
DROP TABLE IF EXISTS dim_contract;
DROP TABLE IF EXISTS dim_account;
DROP TABLE IF EXISTS dim_customer;

-- --- dim_customer-Star Schema Pep
CREATE TABLE dim_customer (
  customerID    VARCHAR(20)  PRIMARY KEY,
  gender        VARCHAR(10),
  SeniorCitizen TINYINT,
  Partner       VARCHAR(3),
  Dependents    VARCHAR(3),
  signup_date   DATE
);
-- --- dim_account : lifecycle / status
CREATE TABLE dim_account (
  customerID           VARCHAR(20) PRIMARY KEY,
  account_status       VARCHAR(20),
  contract_start_date  DATE,
  contract_end_date    DATE,
  disconnection_date   DATE,
  disconnection_reason VARCHAR(50),
  FOREIGN KEY (customerID) REFERENCES dim_customer(customerID)
);
-- --- dim_contract : contract terms 
CREATE TABLE dim_contract (
  customerID VARCHAR(20) PRIMARY KEY,
  Contract   VARCHAR(20),
  tenure     INT,
  FOREIGN KEY (customerID) REFERENCES dim_customer(customerID)
);
-- --- dim_services : what they subscribed to 
CREATE TABLE dim_services (
  customerID       VARCHAR(20) PRIMARY KEY,
  PhoneService     VARCHAR(3),
  MultipleLines    VARCHAR(20),
  InternetService  VARCHAR(20),
  OnlineSecurity   VARCHAR(20),
  OnlineBackup     VARCHAR(20),
  DeviceProtection VARCHAR(20),
  TechSupport      VARCHAR(20),
  StreamingTV      VARCHAR(20),
  StreamingMovies  VARCHAR(20),
  FOREIGN KEY (customerID) REFERENCES dim_customer(customerID)
);
-- --- fact_billing : money -------------------------------------
CREATE TABLE fact_billing (
  customerID        VARCHAR(20) PRIMARY KEY,
  MonthlyCharges    DECIMAL(10,2),
  TotalCharges      DECIMAL(12,2),
  PaymentMethod     VARCHAR(50),
  PaperlessBilling  VARCHAR(3),
  last_payment_date DATE,
  FOREIGN KEY (customerID) REFERENCES dim_customer(customerID)
);
-- --- fact_activity : usage recency 
CREATE TABLE fact_activity (
  customerID         VARCHAR(20) PRIMARY KEY,
  last_activity_date DATE,
  FOREIGN KEY (customerID) REFERENCES dim_customer(customerID)
);

-- --- INSERT CTE'S POULATE ALL TABLES WITH REF VALUEES

-- 1. dim_customer
INSERT INTO dim_customer
SELECT customerID, gender, SeniorCitizen, Partner, Dependents,
       STR_TO_DATE(NULLIF(TRIM(signup_date), ''), '%d/%m/%Y')
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY customerID ORDER BY customerID) AS rn
  FROM ember_mobile_raw
) t
WHERE rn = 1;


-- 2. dim_account
INSERT INTO dim_account
SELECT customerID, account_status,
       STR_TO_DATE(NULLIF(TRIM(contract_start_date), ''), '%d/%m/%Y'),
       STR_TO_DATE(NULLIF(TRIM(contract_end_date),   ''), '%d/%m/%Y'),
       STR_TO_DATE(NULLIF(TRIM(disconnection_date),  ''), '%d/%m/%Y'),
       disconnection_reason
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY customerID ORDER BY customerID) AS rn
  FROM ember_mobile_raw
) t
WHERE rn = 1;

-- 3. dim_contract  
INSERT INTO dim_contract
SELECT customerID, TRIM(Contract), tenure
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY customerID ORDER BY customerID) AS rn
  FROM ember_mobile_raw
) t
WHERE rn = 1;

-- 4. dim_services
INSERT INTO dim_services
SELECT customerID, PhoneService, MultipleLines, InternetService,
       OnlineSecurity, OnlineBackup, DeviceProtection, TechSupport,
       StreamingTV, StreamingMovies
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY customerID ORDER BY customerID) AS rn
  FROM ember_mobile_raw
) t
WHERE rn = 1;

-- 5. fact_billing  
INSERT INTO fact_billing
SELECT customerID,
       MonthlyCharges,
       CAST(NULLIF(TRIM(TotalCharges), '') AS DECIMAL(12,2)),
       PaymentMethod, PaperlessBilling,
       STR_TO_DATE(NULLIF(TRIM(last_payment_date), ''), '%d/%m/%Y')
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY customerID ORDER BY customerID) AS rn
  FROM ember_mobile_raw
) t
WHERE rn = 1;

-- 6. fact_activity
INSERT INTO fact_activity
SELECT customerID,
       STR_TO_DATE(NULLIF(TRIM(last_activity_date), ''), '%d/%m/%Y')
FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY customerID ORDER BY customerID) AS rn
  FROM ember_mobile_raw
) t
WHERE rn = 1;

-- --- Verify tables created 
SELECT 'dim_customer' AS t, COUNT(*) AS row_count FROM dim_customer
UNION ALL SELECT 'dim_account',   COUNT(*) FROM dim_account
UNION ALL SELECT 'dim_contract',  COUNT(*) FROM dim_contract
UNION ALL SELECT 'dim_services',  COUNT(*) FROM dim_services
UNION ALL SELECT 'fact_billing',  COUNT(*) FROM fact_billing
UNION ALL SELECT 'fact_activity', COUNT(*) FROM fact_activity;