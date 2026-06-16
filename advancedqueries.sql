--Ranks products by revenue.
SELECT
    p.title,
    SUM(o.total_price) AS revenue,
    RANK() OVER (
        ORDER BY SUM(o.total_price) DESC
    ) AS revenue_rank
FROM products p
JOIN orders o
    ON p.id = o.product_id
GROUP BY p.title;

--Common Table Expression
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(total_price) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.first_name,
    c.last_name,
    cs.total_spent
FROM customers c
JOIN customer_spending cs
    ON c.id = cs.customer_id
ORDER BY cs.total_spent DESC;

--Index Optimization
CREATE INDEX idx_customer_city
ON customers(city);

CREATE INDEX idx_product_category
ON products(category);

CREATE INDEX idx_order_customer
ON orders(customer_id);
