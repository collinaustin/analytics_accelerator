--SQL JOIN PRACTICE

--Question 1
SELECT r.name AS region,
       s.name AS rep,
       a.name AS account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY account;

--Question #2
SELECT r.name AS region,
       s.name AS rep,
       a.name AS account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE s.name LIKE 'S%' AND r.name = 'Midwest'
ORDER BY a.name;

--Question #3
SELECT r.name AS region,
       s.name AS rep,
       a.name AS account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE s.name LIKE '% K%' AND r.name = 'Midwest'
ORDER BY a.name;

--Question #4
SELECT r.name AS region,
       a.name AS account,
       o.total_amt_usd/(o.total+0.01) AS unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;

--Question #5
SELECT r.name AS region,
       a.name AS account,
       o.total_amt_usd/(o.total+0.01) AS unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_amt_usd > 50
ORDER BY unit_price ASC;

--Question #6
SELECT r.name AS region,
       a.name AS account,
       o.total_amt_usd/(o.total+0.01) AS unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_amt_usd > 50
ORDER BY unit_price DESC;

--Question #7
SELECT DISTINCT a.name AS name,
                w.channel AS channel
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
WHERE a.id = 1001;

--Question #8
SELECT o.occurred_at,
       a.name,
       o.total,
       o.total_amt_usd
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2015-12-31'
ORDER BY o.occurred_at ASC;

----GROUP BY QUIZ

--Question #2
SELECT a.name AS name,
       sum(o.total_amt_usd) AS total_sales
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY name
ORDER BY name;

--QUESTION 3
SELECT w.occurred_at AS date,
       w.channel,
       a.name
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY date, w.channel, a.name
ORDER BY date DESC
LIMIT 1;

--QUESTION 4
SELECT w.channel,
       count(w.channel)
FROM web_events w
GROUP BY w.channel
ORDER BY count(w.channel) DESC;

--QUESTION 5
SELECT a.primary_poc AS contact,
       a.name,
       w.occurred_at AS date
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
GROUP BY contact, a.name, date
ORDER BY date ASC
LIMIT 1;

--QUESTION 6
SELECT a.name, MIN(o.total_amt_usd) AS min_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY name
ORDER BY min_order;

--question 7
SELECT count(s.name) AS reps,
       r.name AS region
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
GROUP BY region
ORDER BY reps ASC;

--AVG/COUNT/MIN/MAX

--Q#1
SELECT a.name,
       AVG(o.standard_qty) AS standard,
       AVG(o.gloss_qty) AS glossy,
       AVG(o.poster_qty) AS poster
FROM orders o
JOIN accounts a
ON a.id = o.id
GROUP BY name;

--Q#2
SELECT a.name,
       AVG(o.standard_amt_usd) AS standard,
       AVG(o.gloss_amt_usd) AS glossy,
       AVG(o.poster_amt_usd) AS poster
FROM orders o
JOIN accounts a
ON a.id = o.id
GROUP BY name;

--Q3
SELECT s.name,
       w.channel,
       COUNT(w.channel) AS channel_ct
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN web_events w
ON w.account_id = a.id
GROUP BY s.name, w.channel
ORDER BY channel_ct DESC;

--Q4
SELECT r.name,
       w.channel,
       COUNT(w.channel) AS channel_ct
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN web_events w
ON w.account_id = a.id
GROUP BY r.name, w.channel
ORDER BY channel_ct DESC;

--HAVING SQL STATEMENTS--

--Q1
SELECT s.id, s.name, COUNT(*) AS num_accts
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accts DESC;

--Q2
SELECT a.id, a.name, COUNT(*) AS orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY orders DESC;

--q3
SELECT a.id, a.name, COUNT(*) AS orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY orders DESC
LIMIT 1;

--q4
SELECT a.id, a.name, SUM(o.total_amt_usd) AS total
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total DESC;

--Q5
SELECT a.id, a.name, SUM(o.total_amt_usd) AS total
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total DESC;

--Q6
SELECT a.id, a.name, SUM(o.total_amt_usd) AS total
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total DESC
LIMIT 1;


--Q7
SELECT a.id, a.name, SUM(o.total_amt_usd) AS total
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total ASC
LIMIT 1;

--Q8
SELECT a.id, a.name, COUNT(*) AS channel_ct
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE channel = 'facebook'
GROUP BY a.id, a.name
HAVING COUNT(*) > 6
ORDER BY channel_ct DESC;

--Q9
SELECT a.id, a.name, COUNT(*) AS channel_ct
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE channel = 'facebook'
GROUP BY a.id, a.name
HAVING COUNT(*) > 6
ORDER BY channel_ct DESC
LIMIT 1;

--Q10
SELECT w.channel, COUNT(*) AS channel_ct
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY w.channel
ORDER BY channel_ct DESC;

--DATE FUNCTIONS

--Q1
SELECT DATE_PART('year', o.occurred_at) AS year,
       SUM(o.total_amt_usd) AS sales
FROM orders o
GROUP BY year
ORDER BY sales DESC;

--Q2
SELECT DATE_PART('month', o.occurred_at) AS month,
       SUM(o.total_amt_usd) AS sales
FROM orders o
GROUP BY month
ORDER BY sales DESC;

--q3
SELECT DATE_PART('year', o.occurred_at) AS year,
       SUM(o.total) AS total
FROM orders o
GROUP BY year
ORDER BY total DESC;

--q4
SELECT DATE_PART('month', o.occurred_at) AS month,
       SUM(o.total_amt_usd) AS total
FROM orders o
GROUP BY month
ORDER BY total DESC;

--q5
SELECT DATE_TRUNC('month', o.occurred_at) ord_date, SUM(o.gloss_amt_usd) tot_spent
FROM orders o 
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;


--CASE FUNCTIONS--

--Q1
SELECT o.id, o.total_amt_usd AS total,
       CASE WHEN o.total_amt_usd > 3000 THEN 'Large' ELSE 'Small'
       END AS order_level
FROM orders o;

--Q2
SELECT COUNT(*), 
   CASE 
       WHEN o.total >= 2000 THEN 'At least 2000'
       WHEN o.total BETWEEN 1000 AND 2000 THEN 'Betweeen 1000 and 2000'
       WHEN o.total < 1000 THEN 'Less than 1000'
   END AS order_level
FROM orders o
GROUP BY 2
ORDER BY 1;

--q3
SELECT a.name, SUM(o.total_amt_usd),
  CASE
    WHEN SUM(o.total_amt_usd) > 200000 THEN 'Top Level'
    WHEN SUM(o.total_amt_usd) > 100000 THEN 'Middle Level'
    WHEN SUM(o.total_amt_usd) < 100000 THEN 'Lowest Level'
  END AS level
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY level desc;

--q4
SELECT a.name, SUM(o.total_amt_usd) AS total_spend, o.occurred_at,
  CASE
    WHEN SUM(o.total_amt_usd) > 200000 THEN 'Top Level'
    WHEN SUM(o.total_amt_usd) > 100000 THEN 'Middle Level'
    ELSE 'Lowest Level'
  END AS level
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE o.occurred_at > '2015-12-31'
GROUP BY a.name, o.occurred_at
ORDER BY 2 DESC;

--q5
SELECT s.name, COUNT(*) AS orders, 
 CASE
   WHEN COUNT(*) > 200 THEN 'top'
   ELSE 'not'
  END AS sales_rep_rank
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
GROUP BY s.name
ORDER BY 2 DESC;

--q6
SELECT s.name, COUNT(*) AS orders, SUM(total_amt_usd) AS dollar_sales,
 CASE
   WHEN COUNT(*) > 200 OR SUM(total_amt_usd) > 750000 THEN 'top'
   WHEN COUNT(*) > 150 OR SUM(total_amt_usd) > 500000 THEN 'middle'
   ELSE 'low'
 END AS sales_rep_rank
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
GROUP BY s.name
ORDER BY 3 DESC;

--SUBQUERIES!!!--

SELECT channel, AVG(num_events) AS avg_event
FROM
(SELECT DATE_TRUNC('day', w.occurred_at) AS day, w.channel, COUNT(*) AS num_events
FROM web_events w
GROUP BY 1,2) sub
GROUP BY 1
ORDER BY 2 DESC;

SELECT AVG(o.standard_qty) AS avg_standard,
       AVG(o.gloss_qty) AS avg_gloss,
       AVG(o.poster_qty) AS avg_poster,
       SUM(total_amt_usd) AS total
FROM orders o
WHERE DATE_TRUNC('month', o.occurred_at) =
     (SELECT DATE_TRUNC('month',MIN(o.occurred_at)) AS date
      FROM orders o);

SELECT s.name AS rep_name, r.name AS region, SUM(o.total_amt_usd) AS total_amt
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON o.account_id = a.id
GROUP BY rep_name, region
ORDER BY 3 DESC;

SELECT region, MAX(total_amt) total_amt
        FROM(SELECT s.name rep_name, r.name region,     
        SUM(o.total_amt_usd) total_amt
        FROM sales_reps s
        JOIN region r
        ON s.region_id = r.id
        JOIN accounts a
        ON s.id = a.sales_rep_id
        JOIN orders o
        ON o.account_id = a.id
        GROUP BY rep_name, region) t1
GROUP BY 1;

SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM(SELECT region_name, MAX(total_amt) total_amt
       FROM(SELECT s.name rep_name, r.name region_name,     
       SUM(o.total_amt_usd) total_amt
       FROM sales_reps s
       JOIN region r
       ON s.region_id = r.id
       JOIN accounts a
       ON s.id = a.sales_rep_id
       JOIN orders o
       ON o.account_id = a.id
       GROUP BY 1,2) t1
     GROUP BY 1) t2
JOIN(SELECT s.name rep_name, r.name region_name,  
      SUM(o.total_amt_usd) total_amt
      FROM sales_reps s
      JOIN region r
      ON s.region_id = r.id
      JOIN accounts a
      ON s.id = a.sales_rep_id
      JOIN orders o
      ON o.account_id = a.id
      GROUP BY 1,2
      ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;

SELECT r.name region, COUNT(o.total) total_orders
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
HAVING SUM(o.total_amt_usd) = (
   SELECT MAX(total_sales) total_sales
    FROM(SELECT r.name AS region, SUM(o.total_amt_usd) AS total_sales 
       FROM region r
       JOIN sales_reps s
       ON r.id = s.region_id
       JOIN accounts a
       ON a.sales_rep_id = s.id
       JOIN orders o
       ON o.account_id = a.id
       GROUP BY 1) t1
  );

SELECT COUNT(*)
FROM(SELECT a.name
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) > 
       (
              SELECT total_orders
              FROM (
                     SELECT a.name account_name,    
                            SUM(o.standard_qty) standard_qty_amt,    
                            SUM(o.total) total_orders
                     FROM accounts a
                     JOIN orders o
                     ON a.id = o.account_id
                     GROUP BY 1
                     ORDER BY 2 DESC
                     LIMIT 1
                     ) t1
       )
) t2;

SELECT a.name,
       w.account_id, 
       w.channel,
       COUNT(w.channel)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE w.account_id = (
       SELECT id
       FROM (
              SELECT a.id,
                     a.name,  
                     SUM(o.total_amt_usd) total
              FROM orders o
              JOIN accounts a
              ON a.id = o.account_id
              GROUP BY 1, 2
              ORDER BY 3 DESC
              LIMIT 1
              ) top_customer 
       )
GROUP BY 1, 2, 3
ORDER BY 4 DESC;
       
SELECT AVG(total)
FROM
       (
       SELECT a.name,
              a.id,
              SUM(o.total_amt_usd) AS total
       FROM accounts a
       JOIN orders o
       ON a.id = o.account_id
       GROUP BY 1, 2
       ORDER BY 3 DESC
       LIMIT 10
       )
;

SELECT AVG(avg_amt)
FROM 
       (
       SELECT o.account_id,
       AVG(o.total_amt_usd) AS avg_amt
       FROM orders o
       GROUP BY 1
       HAVING AVG(o.total_amt_usd) >    
              (
              SELECT AVG(o.total_amt_usd) AS avg_all
              FROM orders o
              )
       ) t1
;

--1ST WITH STATEMENT QUERY
WITH t1 AS 
       (
       SELECT s.name rep_name, 
              r.name region_name,     
              SUM(o.total_amt_usd) total_amt
       FROM sales_reps s
       JOIN region r
       ON s.region_id = r.id
       JOIN accounts a
       ON s.id = a.sales_rep_id
       JOIN orders o
       ON o.account_id = a.id
       GROUP BY 1,2
       ),
t2 AS
       (
       SELECT region_name, 
              MAX(total_amt) total_amt
       FROM t1
       GROUP BY 1
       )
       
SELECT t1.rep_name,
       t1.region_name,
       t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;
        
--2ND WITH STATEMENT QUERY
WITH t1 AS 
       (
       SELECT r.name AS region,
       SUM(o.total_amt_usd) AS total_sales 
       FROM region r
       JOIN sales_reps s
       ON r.id = s.region_id
       JOIN accounts a
       ON a.sales_rep_id = s.id
       JOIN orders o
       ON o.account_id = a.id
       GROUP BY 1
       ),       
t2 AS
       (SELECT MAX(total_sales) total_sales
       FROM t1
       )
       
SELECT r.name region, 
       COUNT(o.total) total_orders
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
GROUP BY 1
HAVING SUM(o.total_amt_usd) = 
       (
       SELECT *
       FROM T2
       );

--3RD WITH STATEMENT SUBQUERY

WITH t1 AS
       (
       SELECT a.name account_name,    
       SUM(o.standard_qty) standard_qty_amt,    
       SUM(o.total) total_orders
       FROM accounts a
       JOIN orders o
       ON a.id = o.account_id
       GROUP BY 1
       ORDER BY 2 DESC
       LIMIT 1
       ),
t2 AS (
       SELECT a.name
       FROM accounts a
       JOIN orders o
       ON a.id = o.account_id
       GROUP BY 1
       HAVING SUM(o.total) > 
              (
              SELECT total_orders
              FROM t1
              )
       )

SELECT COUNT(*)
FROM t2;
    

--4TH WITH STATEMENT SUBQUERY

WITH t1 AS
       (
       SELECT a.id,
              a.name,  
              SUM(o.total_amt_usd) total
       FROM orders o
       JOIN accounts a
       ON a.id = o.account_id
       GROUP BY 1, 2
       ORDER BY 3 DESC
       LIMIT 1
       )

SELECT a.name,
       w.account_id, 
       w.channel,
       COUNT(w.channel)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE w.account_id = 
       (SELECT id
       FROM t1
       )
GROUP BY 1, 2, 3
ORDER BY 4 DESC;

---6TH WITH STATEMENT SUBQUERY

SELECT AVG(avg_amt)
FROM 
       (
       SELECT o.account_id,
       AVG(o.total_amt_usd) AS avg_amt
       FROM orders o
       GROUP BY 1
       HAVING AVG(o.total_amt_usd) >    
              (
              SELECT AVG(o.total_amt_usd) AS avg_all
              FROM orders o
              )
       ) t1
;

WITH t1 AS 
       (SELECT o.account_id,
       AVG(o.total_amt_usd) AS avg_amt
       FROM orders o
       GROUP BY 1
       HAVING AVG(o.total_amt_usd) >    
              (
              SELECT AVG(o.total_amt_usd) AS avg_all
              FROM orders o
              )
       )
SELECT AVG(avg_amt)
FROM t1
;
               




