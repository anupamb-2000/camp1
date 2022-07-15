USE camp1

--Normalising the given table into 3NF, we will get the following tables:
--OrderDetails {OrderId, OrderDate, OrderPrice, OrderQuantity, CustomerId}
--CustomerDetails {CustomerId, CustomerName}
--ProductDetails {Product_id, OrderId, Manufacture_Date, Product_Name, Manufr_id}
--ManufacturerDetails {Manufr_id, Manufr_name}

--Creating Tables
CREATE TABLE CustomerDetails(
	CustomerId INT IDENTITY PRIMARY KEY,
	CustomerName VARCHAR(25)
);

CREATE TABLE ManufacturerDetails(
	Manufr_id INT IDENTITY PRIMARY KEY,
	Manufr_name VARCHAR(25)
);

CREATE TABLE OrderDetails(
	OrderId INT IDENTITY PRIMARY KEY,
	OrderDate DATE,
	OrderPrice INT,
	OrderQuantity INT,
	CustomerId INT NOT NULL
	CONSTRAINT fk_order
	FOREIGN KEY (CustomerId)
	REFERENCES CustomerDetails(CustomerId)  
);

CREATE TABLE ProductDetails(
	Product_id INT PRIMARY KEY, 
	OrderId INT FOREIGN KEY REFERENCES OrderDetails(OrderId),
	Manufacture_Date DATE,
	Product_Name VARCHAR(25),
	Manufr_id INT FOREIGN KEY REFERENCES ManufacturerDetails(Manufr_id) 
);

--Insert values
INSERT INTO CustomerDetails VALUES
('Jayesh'),
('Abhilash'),
('Lily'),
('Aswathy')

INSERT INTO ManufacturerDetails VALUES
('Samsung'),
('Sony'),
('Mi'),
('Boat')

INSERT INTO OrderDetails VALUES
('2020/12/22', 270, 2, 1),
('2019/08/10', 280, 4, 2),
('2019/07/13', 600, 5, 3),
('2020/07/15', 520, 1, 1),
('2020/12/22', 1200, 4, 4),
('2019/10/02', 420, 3, 1),
('2020/11/03', 3000, 2, 3),
('2020/12/22', 1100, 4, 4),
('2019/12/29', 5500, 2, 1)

INSERT INTO ProductDetails VALUES
(145, 2, '2019/12/23', 'MobilePhone', 1),
(147, 6, '2019/08/15', 'MobilePhone', 3),
(435, 5, '2018/11/04', 'MobilePhone', 1),
(783, 1, '2017/11/03', 'LED TV', 2),
(784, 4, '2019/11/28', 'LED TV', 2),
(123, 2, '2019/10/03', 'Laptop', 2),
(267, 5, '2019/11/03', 'Headphone', 4),
(333, 9, '2017/12/12', 'Laptop', 1),
(344, 3, '2018/11/03', 'Laptop', 1),
(233, 3, '2019/11/30', 'PowerBank', 2),
(567, 6, '2019/09/03', 'PowerBank', 2)

--Preview the tables
SELECT * FROM CustomerDetails

SELECT * FROM ManufacturerDetails

SELECT * FROM OrderDetails

SELECT * FROM ProductDetails

--Total number of orders placed in each year