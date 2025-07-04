use ecommerce;
DELIMITER //

CREATE PROCEDURE PlaceOrderIfUserExists (
    IN p_user_id INT,
    IN p_order_date DATE,
    IN p_status VARCHAR(50),
    IN p_total_amount DECIMAL(10,2)
)
BEGIN
    DECLARE user_exists INT;

    SELECT COUNT(*) INTO user_exists
    FROM Users
    WHERE user_id = p_user_id;

    IF user_exists > 0 THEN
        INSERT INTO Orders(user_id, order_date, status, total_amount)
        VALUES (p_user_id, p_order_date, p_status, p_total_amount);
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User does not exist. Order not placed.';
    END IF;
END //

DELIMITER ;


DELIMITER //

CREATE FUNCTION GetStockStatus(p_product_id INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE stock_qty INT;
    DECLARE status VARCHAR(20);

    SELECT stock INTO stock_qty
    FROM Products
    WHERE product_id = p_product_id;

    IF stock_qty > 0 THEN
        SET status = 'In Stock';
    ELSE
        SET status = 'Out of Stock';
    END IF;

    RETURN status;
END //

DELIMITER ;
