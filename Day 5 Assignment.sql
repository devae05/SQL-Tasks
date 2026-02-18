create database day5;
use day5;

CREATE TABLE Customers (CustomerID INT PRIMARY KEY,CustomerName VARCHAR(50),City VARCHAR(50));
CREATE TABLE Products (ProductID INT PRIMARY KEY,ProductName VARCHAR(50),Price DECIMAL(10, 2));
CREATE TABLE Orders (OrderID INT PRIMARY KEY,CustomerID INT,ProductID INT,OrderDate DATE,Quantity INT,
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID));

INSERT INTO Customers VALUES (1, 'Alice', 'New York'), (2, 'Bob', 'London'), (3, 'Charlie', 'Paris'), (4, 'David', 'Berlin');
INSERT INTO Products VALUES (101, 'Laptop', 1200.00), (102, 'Mouse', 25.00), (103, 'Keyboard', 50.00);
INSERT INTO Orders VALUES (1, 1, 101, '2023-01-01', 1), (2, 2, 102, '2023-01-02', 2), (3, 1, 103, '2023-01-03', 1), (4, NULL, 101, '2023-01-04', 1);

select * from customers;
select * from products;
select * from orders;

-- 1.Write a query to display the CustomerName and the OrderID for every order placed.

select CustomerName,OrderID from Orders
inner join Customers
on Customers.CustomerID = Orders.CustomerID;

-- 2.List all customers and their OrderID. Include customers who have never placed an order.

select CustomerName, OrderID from Customers
left join Orders
on Customers.CustomerID = Orders.CustomerID;

-- 3.List all products and the OrderID associated with them, including products that have never been ordered.

select ProductName, OrderID from Products
left join Orders
on Products.ProductID = Orders.ProductID;

-- 4.Retrieve the CustomerName, ProductName, and OrderDate for all successful orders.

select CustomerName, ProductName, OrderDate 
from Orders
join Customers
on Orders.CustomerID = Customers.CustomerID
join Products
on Products.ProductID = Orders.ProductID;

-- 5.Find the names of customers who bought a 'Laptop'.

select CustomerName 
from Customers
inner join Orders
on Customers.customerID = Orders.customerID
inner join Products
on Products.productID = Orders.productID
where productName = "Laptop";

-- 6.Calculate the total amount spent by each customer. Display CustomerName and the total sum.

select CustomerName, sum(Products.Price * Orders.Quantity) as Amount_Spent
from Customers
inner join Orders
on Customers.customerID = Orders.orderID
inner join Products
on Products.productID = Orders.productID
group by Customers.CustomerName;

-- 7.Identify orders that do not have an associated customer (where CustomerID is NULL).

select orderID from Orders
where customerID is null;

-- 8.Generate a list of all possible combinations between Customers and Products (Cartesian product).

select Customers.CustomerName, Products.ProductName
from Customers
cross join Products;

-- 9.Suppose you added a ManagerID to the Customers table; how would you join the table to itself to show each customer and their manager's name?

select Customers.CustomerName as Customer, Manager.CustomerName as Manager
from Customers 
left join Customers 
on Customers.ManagerID = Manager.CustomerID	;

-- 10. List the names of customers from 'New York' who ordered more than 1 item in a single order, along with the product name.

-- 10. Customers from New York who ordered more than 1 item in a single order, with product name

select Customers.CustomerName, Products.ProductName
from Customers 
inner join Orders 
on Customers.CustomerID = Orders.CustomerID
inner join Products 	
on Products.ProductID = Orders.ProductID
where Customers.City = 'New York' and Orders.Quantity > 0;
