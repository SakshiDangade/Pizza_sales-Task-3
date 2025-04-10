CREATE TABLE pizza_sales (
    pizza_id INT,
    order_id INT,
    pizza_name_id VARCHAR(255),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),
    pizza_size VARCHAR(10),
    pizza_category VARCHAR(50),
    pizza_ingredients TEXT,
    pizza_name TEXT
);

SELECT * FROM pizza_sales LIMIT 10;

SELECT * FROM pizza_sales WHERE order_date > '2015-01-01';

SELECT pizza_name, SUM(total_price) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC;

CREATE TABLE pizza_info AS
SELECT DISTINCT pizza_name, pizza_category, pizza_size
FROM pizza_sales;

SELECT ps.order_id, ps.order_date, ps.pizza_name, pi.pizza_category, ps.total_price
FROM pizza_sales ps
INNER JOIN pizza_info pi ON ps.pizza_name = pi.pizza_name;

SELECT ps.order_id, ps.order_date, ps.pizza_name, pi.pizza_category, ps.total_price
FROM pizza_sales ps
LEFT JOIN pizza_info pi ON ps.pizza_name = pi.pizza_name;

SELECT ps.order_id, ps.order_date, ps.pizza_name, pi.pizza_category, ps.total_price
FROM pizza_sales ps
RIGHT JOIN pizza_info pi ON ps.pizza_name = pi.pizza_name;

SELECT * FROM pizza_sales ps
LEFT JOIN pizza_info pi ON ps.pizza_name = pi.pizza_name
UNION
SELECT * FROM pizza_sales ps
RIGHT JOIN pizza_info pi ON ps.pizza_name = pi.pizza_name;

SELECT pizza_name, total_revenue FROM (
  SELECT pizza_name, SUM(total_price) AS total_revenue
  FROM pizza_sales
  GROUP BY pizza_name
) AS sub
ORDER BY total_revenue DESC
LIMIT 5;

SELECT * FROM pizza_sales
WHERE total_price > (
  SELECT AVG(total_price) FROM pizza_sales
);

SELECT SUM(total_price) AS total_revenue FROM pizza_sales;

SELECT MAX(total_price) AS highest_order, MIN(total_price) AS lowest_order
FROM pizza_sales;

SELECT AVG(total_price) AS avg_order_value FROM pizza_sales;

CREATE VIEW daily_sales_summary AS
SELECT order_date, SUM(total_price) AS daily_total
FROM pizza_sales
GROUP BY order_date;

SELECT * FROM daily_sales_summary;


CREATE VIEW size_wise_sales AS
SELECT pizza_size, SUM(total_price) AS total_sales
FROM pizza_sales
GROUP BY pizza_size;

SELECT * FROM size_wise_sales;

CREATE INDEX idx_order_date ON pizza_sales(order_date);

CREATE INDEX idx_pizza_name ON pizza_sales(pizza_name(20));







