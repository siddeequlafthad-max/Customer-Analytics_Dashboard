CREATE DATABASE customer_analytics;
USE customer_analytics;
CREATE TABLE customers (
  customer_id VARCHAR(10),
  age INT,
  gender VARCHAR(10),
  location VARCHAR(50),
  income_bracket VARCHAR(20),
  acquisition_channel VARCHAR(20),
  product_category VARCHAR(30),
  purchase_frequency INT,
  recency_days INT,
  avg_order_value DECIMAL(10,2),
  total_monetary_value DECIMAL(10,2),
  email_opened INT,
  email_clicked INT,
  social_engaged INT,
  paid_ad_clicked INT,
  campaign_converted INT,
  cac DECIMAL(10,2),
  clv DECIMAL(10,2),
  churn_flag INT,
  last_purchase_date DATE
);
USE customer_analytics;

LOAD DATA INFILE 'C:/Users/DELL/Downloads/customer_analytics_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
USE customer_analytics;
SELECT COUNT(*) FROM customers;
SELECT 
  gender,
  COUNT(*) AS total_customers,
  ROUND(AVG(total_monetary_value), 2) AS avg_spend,
  ROUND(AVG(purchase_frequency), 2) AS avg_frequency,
  SUM(churn_flag) AS churned_customers
FROM customers
GROUP BY gender
ORDER BY avg_spend DESC;
USE customer_analytics;

SELECT
  customer_id,
  recency_days,
  purchase_frequency,
  total_monetary_value,
  NTILE(5) OVER (ORDER BY recency_days ASC) AS r_score,
  NTILE(5) OVER (ORDER BY purchase_frequency DESC) AS f_score,
  NTILE(5) OVER (ORDER BY total_monetary_value DESC) AS m_score
FROM customers
LIMIT 20;
USE customer_analytics;

CREATE VIEW rfm_segments AS
SELECT
  customer_id,
  r_score,
  f_score,
  m_score,
  (r_score + f_score + m_score) AS rfm_total,
  CASE
    WHEN (r_score + f_score + m_score) >= 13 THEN 'Champion'
    WHEN (r_score + f_score + m_score) >= 10 THEN 'Loyal Customer'
    WHEN (r_score + f_score + m_score) >= 7 THEN 'Potential Loyalist'
    WHEN (r_score + f_score + m_score) >= 5 THEN 'At Risk'
    ELSE 'Lost'
  END AS segment
FROM (
  SELECT
    customer_id,
    NTILE(5) OVER (ORDER BY recency_days ASC) AS r_score,
    NTILE(5) OVER (ORDER BY purchase_frequency DESC) AS f_score,
    NTILE(5) OVER (ORDER BY total_monetary_value DESC) AS m_score
  FROM customers
) AS scores;
SELECT segment, COUNT(*) AS total_customers
FROM rfm_segments
GROUP BY segment
ORDER BY total_customers DESC;
SELECT 
  r.segment,
  COUNT(*) AS customers,
  ROUND(SUM(c.total_monetary_value), 2) AS total_revenue,
  ROUND(SUM(c.total_monetary_value) * 100.0 / 
    (SELECT SUM(total_monetary_value) FROM customers), 2) AS revenue_pct
FROM rfm_segments r
JOIN customers c ON r.customer_id = c.customer_id
GROUP BY r.segment
ORDER BY total_revenue DESC;
SELECT r.segment, COUNT(*) AS customers,
ROUND(SUM(c.total_monetary_value),2) AS total_revenue,
ROUND(SUM(c.total_monetary_value)*100.0/(SELECT SUM(total_monetary_value) FROM customers),2) AS revenue_pct
FROM rfm_segments r
JOIN customers c ON r.customer_id = c.customer_id
GROUP BY r.segment
ORDER BY total_revenue DESC;