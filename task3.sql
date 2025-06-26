-- Task 3: Writing Basic SELECT Queries
-- Name: Yagna

-- 1. All users
SELECT * FROM Users;

-- 2. Product name and price
SELECT name, price FROM Products;

-- 3. Users from Hyderabad
SELECT * FROM Users WHERE address LIKE '%Hyderabad%';

-- 4. High-priced, high-stock products
SELECT * FROM Products WHERE price > 1000 AND stock > 10;

-- 5. Products in price range
SELECT * FROM Products WHERE price BETWEEN 500 AND 2000;

-- 6. Orders by date
SELECT * FROM Orders ORDER BY order_date DESC;



-- 8. Electronics products
SELECT p.product_id, p.name, p.price
FROM Products p
JOIN Categories c ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics';
