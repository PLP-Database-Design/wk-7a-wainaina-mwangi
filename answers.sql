-- question 1
-- If this is a one-time transformation and the data is small, you can manually insert it into a normalized table like this:
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

INSERT INTO ProductDetail_1NF VALUES (101, 'John Doe', 'Laptop');
INSERT INTO ProductDetail_1NF VALUES (101, 'John Doe', 'Mouse');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Tablet');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Keyboard');
INSERT INTO ProductDetail_1NF VALUES (102, 'Jane Smith', 'Mouse');
INSERT INTO ProductDetail_1NF VALUES (103, 'Emily Clark', 'Phone');


-- question 2
--  Solution: Split the table into two tables
-- Orders table (stores OrderID and CustomerName)
-- OrderItems table (stores OrderID, Product, and Quantity)
-- SQL to Create the 2NF Table
-- Table 1: Orders (removes partial dependency)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Table 2: OrderItems (non-key columns fully depend on composite key)
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- SQL to Insert Transformed Data:
-- Insert into Orders table (distinct OrderID–CustomerName pairs)
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert into OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- SQL SELECT Query to Join and View Normalized Data:
SELECT 
    o.OrderID,
    o.CustomerName,
    i.Product,
    i.Quantity
FROM 
    Orders o
INNER JOIN 
    OrderItems i ON o.OrderID = i.OrderID
ORDER BY 
    o.OrderID;
