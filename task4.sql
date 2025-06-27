use ecommerce;
SELECT u.name, COUNT(o.order_id) AS total_orders
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.name;

SELECT status, AVG(total_amount) AS average_order_value
FROM Orders
GROUP BY status;


SELECT p.name, SUM(oi.quantity * oi.price) AS total_sales
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.name;


SELECT method, SUM(amount) AS total_revenue
FROM Payments
GROUP BY method;

SELECT u.name, COUNT(o.order_id) AS order_count
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.name
HAVING COUNT(o.order_id) > 2;

SELECT c.category_name, SUM(p.stock) AS total_stock
FROM Categories c
JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_name;



