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

