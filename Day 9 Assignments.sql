create database day9;
use day9;

CREATE TABLE Products (product_id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(100),price DECIMAL(10, 2),
stock_quantity INT,status VARCHAR(20) DEFAULT 'Available');

CREATE TABLE Inventory_Audit (audit_id INT PRIMARY KEY AUTO_INCREMENT,product_id INT,action_type VARCHAR(50),
    old_value VARCHAR(100),new_value VARCHAR(100),changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

-- 1. Prevent Negative Stock Question: Create a trigger to prevent the stock_quantity from being updated to a value less than 0.

DELIMITER $$

CREATE TRIGGER PreventNegativeStock
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.stock_quantity < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock quantity cannot be negative';
    END IF;
END $$

DELIMITER ;

-- 2. Audit Price Changes Question: Log whenever a product price is updated into the Inventory_Audit table.

DELIMITER $$

CREATE TRIGGER AuditPriceChange
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO Inventory_Audit(product_id, action_type, old_value, new_value)
        VALUES (OLD.product_id, 'PRICE UPDATE', OLD.price, NEW.price);
    END IF;
END $$

DELIMITER ;

-- 3. Auto-Update Status to 'Out of Stock' Question: If stock reaches 0, automatically change the status to 'Out of Stock'.

DELIMITER $$

CREATE TRIGGER AutoOutOfStock
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.stock_quantity = 0 THEN
        SET NEW.status = 'Out of Stock';
    END IF;
END $$

DELIMITER ;

-- 4. Enforce Uppercase Product Names Question: Ensure all product names are stored in uppercase upon insertion.

DELIMITER $$

CREATE TRIGGER UppercaseProductName
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    SET NEW.name = UPPER(NEW.name);
END $$

DELIMITER ;

-- 5. Log New Product Additions Question: Record a log entry whenever a new product is added to the system.


DELIMITER $$

CREATE TRIGGER LogNewProduct
AFTER INSERT ON Products
FOR EACH ROW
BEGIN
    INSERT INTO Inventory_Audit(product_id, action_type, old_value, new_value)
    VALUES (NEW.product_id, 'NEW PRODUCT ADDED', NULL, NEW.name);
END $$

DELIMITER ;

-- 6. Prevent Deletion of Active Products Question: Stop users from deleting a product if the stock_quantity is greater than 0.


DELIMITER $$

CREATE TRIGGER PreventDeleteActiveProduct
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
    IF OLD.stock_quantity > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete product with stock remaining';
    END IF;
END $$

DELIMITER ;

-- 7. Track Deleted Products Question: When a product is deleted, save its ID and name in the audit table.

DELIMITER $$

CREATE TRIGGER TrackDeletedProducts
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO Inventory_Audit(product_id, action_type, old_value, new_value)
    VALUES (OLD.product_id, 'PRODUCT DELETED', OLD.name, NULL);
END $$

DELIMITER ;


-- 8. Minimum Price Enforcement Question: Ensure no product is ever listed with a price lower than $1.00.

DELIMITER $$

CREATE TRIGGER EnforceMinimumPrice
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    IF NEW.price < 1.00 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price must be at least $1.00';
    END IF;
END $$

DELIMITER ;

-- 9. Record Stock Replenishment Question: Log an audit entry specifically when stock_quantity increases.

DELIMITER $$

CREATE TRIGGER LogStockIncrease
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.stock_quantity > OLD.stock_quantity THEN
        INSERT INTO Inventory_Audit(product_id, action_type, old_value, new_value)
        VALUES (OLD.product_id, 'STOCK INCREASED', OLD.stock_quantity, NEW.stock_quantity);
    END IF;
END $$

DELIMITER ;

-- 10. Prevent Weekend Price Drops Question: Block price updates if today is Saturday or Sunday (to prevent weekend sales errors).

DELIMITER $$

CREATE TRIGGER PreventWeekendPriceDrops
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF (DAYOFWEEK(CURDATE()) IN (1,7)) AND NEW.price < OLD.price THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price drops are not allowed on weekends';
    END IF;
END $$

DELIMITER ;

select * from Products;
select * from Inventory_Audit;
