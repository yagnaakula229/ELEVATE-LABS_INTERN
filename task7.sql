use ecommerce;

CREATE VIEW UserOrderSummary AS
SELECT
    u.user_id,
    u.name AS user_name,
    o.order_id,
    o.order_date,
    o.status,
    p.product_id,
    p.name AS product_name,
    oi.quantity,
    oi.price AS unit_price,
    (oi.quantity * oi.price) AS total_price
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id;



CREATE VIEW PublicUserData AS
SELECT user_id, name, address
FROM Users;


CREATE VIEW ProductStockInfo AS
SELECT 
    p.product_id,
    p.name,
    c.category_name,
    p.price,
    p.stock
FROM Products p
JOIN Categories c ON p.category_id = c.category_id;


