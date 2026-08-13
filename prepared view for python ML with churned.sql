USE embermobile;

SELECT
    `customerID`,
    CASE WHEN `disconnection_date` IS NULL OR `disconnection_date` = ''
         THEN 0 ELSE 1 END AS `IsChurned`,
    `gender`,
    `SeniorCitizen`,
    `Partner`,
    `Dependents`,
    `tenure`,
    `MonthlyCharges`,
    `TotalCharges`,
    `PhoneService`,
    `MultipleLines`,
    `InternetService`,
    `OnlineSecurity`,
    `OnlineBackup`,
    `DeviceProtection`,
    `TechSupport`,
    `StreamingTV`,
    `StreamingMovies`,
    `Contract`,
    `PaperlessBilling`,
    `PaymentMethod`
FROM `ember_mobile_raw`;

CREATE TABLE embermobile.ember_ml AS
SELECT
    `customerID`,
    CASE WHEN `disconnection_date` IS NULL OR `disconnection_date` = ''
         THEN 0 ELSE 1 END AS `IsChurned`,
    `gender`, `SeniorCitizen`, `Partner`, `Dependents`,
    `tenure`, `MonthlyCharges`, `TotalCharges`,
    `PhoneService`, `MultipleLines`, `InternetService`,
    `OnlineSecurity`, `OnlineBackup`, `DeviceProtection`, `TechSupport`,
    `StreamingTV`, `StreamingMovies`,
    `Contract`, `PaperlessBilling`, `PaymentMethod`
FROM `ember_mobile_raw`;
