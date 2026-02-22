create database day8;
use day8;

-- Question 1: Create a stored procedure to add a new customer.

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Mobile_no VARCHAR(15),
    Address VARCHAR(255),
    Bill_Amount DECIMAL(10,2),
    Billdate DATE
);

DELIMITER $$

CREATE PROCEDURE AddCustomer(
    IN p_customer_id INT,
    IN p_name VARCHAR(100),
    IN p_mobile VARCHAR(15),
    IN p_address VARCHAR(255),
    IN p_bill_amount DECIMAL(10,2),
    IN p_bill_date DATE
)
BEGIN
    INSERT INTO Customer (customer_id, Name, Mobile_no, Address, Bill_Amount, Billdate)
    VALUES (p_customer_id, p_name, p_mobile, p_address, p_bill_amount, p_bill_date);
END $$

DELIMITER ;

CALL AddCustomer(2,'Don','9876543210','Madurai',1500,'2026-01-15');

-- Question 2: Create a stored procedure to retrieve customer details by CustomerID.

DELIMITER $$

CREATE PROCEDURE GetCustomerByID(
    IN p_customer_id INT
)
BEGIN
    SELECT *
    FROM Customer
    WHERE customer_id = p_customer_id;
END $$

DELIMITER ;

CALL GetCustomerByID(1);

-- Question 3: Create a stored procedure to update a customer's email and phone number.

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

DELIMITER $$

CREATE PROCEDURE UpdateCustomerContact(
    IN p_customer_id INT,
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(15)
)
BEGIN
    UPDATE Customers
    SET Email = p_email,
        Phone = p_phone
    WHERE customer_id = p_customer_id;
END $$

DELIMITER ;

CALL UpdateCustomerContact(1,'john@email.com','9876543210');

-- Question 4: Create a stored procedure to get all customers from a specific city.

CREATE TABLE CustomerCity (
    customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(100),
    Address VARCHAR(255)
);

DELIMITER $$

CREATE PROCEDURE GetCustomersByCity(
    IN p_city VARCHAR(100)
)
BEGIN
    SELECT *
    FROM Customercity
    WHERE City = p_city;
END $$

DELIMITER ;

CALL GetCustomersByCity('Chennai');

-- Question 5: Create a stored procedure to delete a customer by CustomerID.

CREATE TABLE CustomerDelete (
    customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(100)
);

DELIMITER $$

CREATE PROCEDURE DeleteCustomerByID(
    IN p_customer_id INT
)
BEGIN
    DELETE FROM CustomerDelete
    WHERE customer_id = p_customer_id;
END $$

DELIMITER ;

CALL DeleteCustomerByID(1);

-- Question 6: Create a stored procedure to list customers registered within a given date range.

CREATE TABLE CustomerDateRange (
    customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    RegisterDate DATE
);

DELIMITER $$

CREATE PROCEDURE GetCustomersByDateRange(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    SELECT *
    FROM CustomerDateRange
    WHERE RegisterDate BETWEEN start_date AND end_date;
END $$

DELIMITER ;

CALL GetCustomersByDateRange('2026-01-01','2026-02-01');

-- Question 7: Create a stored procedure to search for customers by partial FirstName or LastName.

CREATE TABLE CustomerSearch (
    customer_id INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

DELIMITER $$

CREATE PROCEDURE SearchCustomerByName(
    IN name_part VARCHAR(50)
)
BEGIN
    SELECT *
    FROM CustomerSearch
    WHERE FirstName LIKE CONCAT('%', name_part, '%')
       OR LastName LIKE CONCAT('%', name_part, '%');
END $$

DELIMITER ;

CALL SearchCustomerByName('joey');

-- Question 8: Create a stored procedure to update a customer's entire address.

CREATE TABLE CustomerAddress (
    customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Street VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10)
);

DELIMITER $$

CREATE PROCEDURE UpdateCustomerAddress(
    IN p_customer_id INT,
    IN p_street VARCHAR(100),
    IN p_city VARCHAR(50),
    IN p_state VARCHAR(50),
    IN p_zip VARCHAR(10)
)
BEGIN
    UPDATE CustomerAddress
    SET Street = p_street,
        City = p_city,
        State = p_state,
        ZipCode = p_zip
    WHERE customer_id = p_customer_id;
END $$

DELIMITER ;

CALL UpdateCustomerAddress(1,'12 MG Road','Chennai','Tamil Nadu','600001');

-- Question 9: Create a stored procedure that returns the total number of customers.

CREATE TABLE CustomerCount (
    customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);

DELIMITER $$

CREATE PROCEDURE GetTotalCustomers()
BEGIN
    SELECT COUNT(*) AS Total_Customers
    FROM CustomerCount;
END $$

DELIMITER ;

CALL GetTotalCustomers();

-- Question 10: Create a stored procedure to retrieve customers who have not provided an email address.

DELIMITER $$

CREATE PROCEDURE GetCustomersWithoutEmail()
BEGIN
    SELECT *
    FROM CustomerCount
    WHERE Email IS NULL OR Email = '';
END $$

DELIMITER ;

CALL GetCustomersWithoutEmail();
	
