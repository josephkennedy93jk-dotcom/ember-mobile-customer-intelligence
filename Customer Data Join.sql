USE embermobile;
-- Purpose: demonstrate multi-table join across the star schema
SELECT
  cu.customerID,
  cu.gender,
  ct.Contract,
  ct.tenure,
  s.InternetService,
  b.MonthlyCharges,
  a.account_status,
  a.disconnection_reason
FROM dim_customer cu
JOIN dim_contract ct USING (customerID)
JOIN dim_services s  USING (customerID)
JOIN fact_billing b  USING (customerID)
JOIN dim_account  a  USING (customerID)
LIMIT 20;