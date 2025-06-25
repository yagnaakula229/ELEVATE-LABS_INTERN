use ecommerce;
INSERT INTO Users (user_id, name, email, password, address)
VALUES 
(1, 'Yagna', 'yagna@example.com', 'pass123', 'Hyderabad'),
(2, 'Ravi', 'ravi@example.com', 'pass456', NULL), -- NULL address
(3, 'Priya', 'priya@example.com', 'pass789', 'Delhi');


INSERT INTO Categories (category_id, category_name)
VALUES 
(1, 'Electronics'),
(2, 'Books'),
(3, 'Fashion');

INSERT INTO Products (product_id, name, description, price, stock, category_id)
VALUES 
(101, 'Smartphone', '5G Android Phone', 19999.99, 50, 1),
(102, 'T-Shirt', NULL, 499.00, 100, 3), -- NULL description
(103, 'Java Book', 'Beginner to Advanced', 899.00, 25, 2);


INSERT INTO Orders (order_id, user_id, order_date, status, total_amount)
VALUES 
(201, 1, '2025-06-20', 'Pending', 20998.99),
(202, 2, '2025-06-21', 'Shipped', 1398.00);


INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, price)
VALUES 
(301, 201, 101, 1, 19999.99),
(302, 202, 102, 2, 998.00),
(303, 202, 103, 1, 899.00);


INSERT INTO Payments (payment_id, order_id, payment_date, amount, method)
VALUES 
(400, 201, '2025-06-22', 20998.99, 'UPI'),
(405, 202, '2025-06-22', 1897.00, NULL); -- NULL payment method

drop table Payments;


UPDATE Users
SET address = 'Mumbai'
WHERE address IS NULL;


UPDATE Products
SET stock = stock - 1
WHERE product_id = 101;

DELETE FROM Orders
WHERE status = 'Cancelled';



INSERT INTO Orders (order_id, user_id, order_date, status, total_amount)
VALUES (203, 3, '2025-06-25', 'Cancelled', 0.00);

-- Now delete it
DELETE FROM Orders WHERE order_id = 203;
