CREATE DATABASE churn_analysis;
USE churn_analysis;


SELECT COUNT(*) FROM cleaned_telco_churn;

-- 1. What is the total churn rate? --

SELECT COUNT(*) as total_customers,
	SUM(CASE WHEN CHURN = 'YES' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
		SUM(CASE WHEN CHURN = 'YES' THEN 1 ELSE 0 END) * 100 /COUNT(*),
			2
		) as churn_rate
FROM cleaned_telco_churn;

-- 2. How many customers stayed vs churned? --

SELECT COUNT(*) as total_csutomers,
	SUM(CASE WHEN CHURN = 'YES' THEN 1 ELSE 0 END) as churned_customers
FROM cleaned_telco_churn;

-- 3. Does gender affect churn?

SELECT gender,
	   COUNT(*) as total_churned,
	SUM(CASE WHEN CHURN = 'YES' THEN 1 ELSE 0 END) as churned_customers
FROM cleaned_telco_churn
GROUP BY gender;

-- 4. Which contract type has the highest churn? --


	
SELECT contract,
	   COUNT(*) as total_customer,
	SUM(CASE WHEN CHURN = 'YES' THEN 1 ELSE 0 END) as churned_customers,
    ROUND(SUM(CASE WHEN CHURN = 'YES' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2 )as churn_rate
FROM cleaned_telco_churn
GROUP BY contract
ORDER BY contract;

-- 5. Which payment method has the highest churn? ⭐



-- Level 2 — Business Insights
-- 6. What is the average monthly charge of churned vs retained customers?

SELECT churn,
	ROUND(AVG(monthlycharges),2) as average_mnth_charges
FROM cleaned_telco_churn
GROUP BY churn;

-- 7. What is the average total charge of churned vs retained customers?
SELECT churn, ROUND(AVG(totalcharges),2) as total_charges 
FROm cleaned_telco_churn
GROUP BY churn;

-- 8. Which tenure group churns the most? ⭐
SELECT
	CASE
		WHEN tenure BETWEEN 0 AND 12 THEN 'New'
        WHEN tenure BETWEEN 13 AND 24 THEN 'Mid'
        ELSE 'Loyal'
	END as tenure_group,
	
    COUNT(*) as total_customers,
    
     SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM cleaned_telco_churn
GROUP BY tenure_group
ORDER BY churned_customers DESC;

-- 9. How much revenue was lost due to churn? ⭐
SELECT 
	ROUND(SUM(totalcharges), 2) as revenue_lost
FROM cleaned_telco_churn
WHERE churn = 'YES';   

-- 10. Which internet service has highest churn?
SELECT internetservice, 
		SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)as highest_churn,
        ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)* 100.0 / count(*),2) as churn_rate
FROM cleaned_telco_churn
GROUP BY internetservice
ORDER BY highest_churn desc;

-- 3 — Advanced (Portfolio Boost)
-- 11. Which contract + payment method combination has the highest churn?
SELECT contract, paymentmethod,
		SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as highest_churn
FROM cleaned_telco_churn
GROUP BY contract, paymentmethod
ORDER BY highest_churn desc;

-- 13. Does having a partner affect churn?
SELECT partner,
	count(*) as total_customers,
	SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as affect_churn,
    ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)* 100.0 / count(*),
    2
    ) as churn_rate
FROM cleaned_telco_churn
GROUP BY partner;

-- 14. Does having dependents affect churn?
SELECT dependents, 
		count(*) as total_customers,
		SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) as dependants_churn,
        ROUND(SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)* 100.0 / count(*), 2) as churn_rate
FROM cleaned_telco_churn
GROUP BY dependents;

-- 15. Which customer segment generates the highest revenue?
SELECT 
    contract,
    internetservice,
    ROUND(SUM(totalcharges), 2) AS total_revenue
FROM cleaned_telco_churn
GROUP BY contract, internetservice
ORDER BY total_revenue DESC;

-