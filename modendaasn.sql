use lms;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products (ProductName, Price, Stock) VALUES
('Laptop', 999.99, 20),
('Smartphone', 699.99, 50),
('Tablet', 299.99, 30),
('Headphones', 49.99, 100),
('Smartwatch', 199.99, 40),
('Gaming Console', 399.99, 25),
('Camera', 549.99, 15),
('Printer', 89.99, 10),
('Router', 59.99, 35),
('Monitor', 129.99, 20);

INSERT INTO Customers (CustomerName, Email, Phone, Address) VALUES
('Alice Johnson', 'alice@example.com', '123-456-7890', '123 Main St, City A'),
('Bob Smith', 'bob@example.com', '234-567-8901', '456 Oak St, City B'),
('Charlie Brown', 'charlie@example.com', '345-678-9012', '789 Pine St, City C'),
('Diana Prince', 'diana@example.com', '456-789-0123', '101 Maple St, City D'),
('Eve Davis', 'eve@example.com', '567-890-1234', '202 Birch St, City E');

INSERT INTO Orders (CustomerID, ProductID, Quantity, OrderDate) VALUES
(1, 1, 1, '2024-12-01'),
(2, 2, 2, '2024-12-02'),
(3, 3, 1, '2024-12-03'),
(4, 4, 4, '2024-12-04'),
(5, 5, 1, '2024-12-05'),
(1, 6, 1, '2024-12-06'),
(2, 7, 1, '2024-12-07'),
(3, 8, 1, '2024-12-08'),
(4, 9, 1, '2024-12-09'),
(5, 10, 2, '2024-12-10');

ALTER TABLE Products ADD COLUMN Discount DECIMAL(5, 2) DEFAULT 0;


UPDATE Products SET Discount = 10.00 WHERE ProductID = 1;
UPDATE Products SET Discount = 5.00 WHERE ProductID = 2;
UPDATE Products SET Discount = 15.00 WHERE ProductID = 6;

SELECT 
    Orders.OrderID, 
    Customers.CustomerName, 
    Products.ProductName, 
    Orders.Quantity, 
    (Products.Price * Orders.Quantity) AS TotalValue, 
    Orders.OrderDate
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Products ON Orders.ProductID = Products.ProductID
WHERE (Products.Price * Orders.Quantity) > 100
ORDER BY Orders.OrderDate DESC;

SELECT 
    Customers.CustomerName,
    Orders.CustomerID, 
    SUM(Products.Price * Orders.Quantity) AS TotalSpent
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Products ON Orders.ProductID = Products.ProductID
GROUP BY Orders.CustomerID
ORDER BY TotalSpent DESC;

SELECT 
    Customers.CustomerName,
    Orders.CustomerID, 
    SUM(Products.Price * Orders.Quantity) AS TotalSpent
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN Products ON Orders.ProductID = Products.ProductID
GROUP BY Orders.CustomerID
HAVING TotalSpent >= 500
ORDER BY TotalSpent DESC;

SELECT AVG(Price) AS AveragePrice FROM Products;

SELECT MAX(Products.Price * Orders.Quantity) AS MaxOrderValue
FROM Orders
JOIN Products ON Orders.ProductID = Products.ProductID;

SELECT COUNT(*) AS ProductCount FROM Products;

SELECT 
    ProductID,
    ProductName,
    Price,
    Stock
FROM Products
WHERE (Price BETWEEN 20 AND 50)
   OR (ProductName LIKE '%Laptop%');
   
   
SELECT * FROM Orders;

SELECT Customers.CustomerName, Orders.OrderID, Orders.OrderDate, Orders.Quantity
FROM Customers
INNER JOIN orders ON Customers.CustomerID = Orders.CustomerID;

select * from Products;

SELECT Products.ProductID, Products.ProductName, Orders.OrderID, Orders.Quantity, Orders.OrderDate
FROM Orders
LEFT JOIN Products ON Products.ProductID = Orders.ProductID;


SELECT Customers.CustomerName, Orders.OrderID, Orders.OrderDate, orders.Quantity
FROM Customers
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;




