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

--Total number of orders placed in each yearSELECT YEAR(OrderDate) 'Year', COUNT(OrderId) 'No. of orders placed'FROM OrderDetailsGROUP BY YEAR(OrderDate)--Total number of orders placed in each year by JayeshSELECT YEAR(OrderDate) 'Year', COUNT(OrderId) 'No. of orders placed'FROM OrderDetailsGROUP BY CustomerId, YEAR(OrderDate)HAVING  CustomerId IN (	SELECT CustomerId	FROM CustomerDetails 	WHERE CustomerName = 'Jayesh')--Products which are ordered in the same year of its manufacturing yearSELECT * FROM OrderDetailsINNER JOIN ProductDetails ON OrderDetails.OrderId = ProductDetails.OrderIdWHERE YEAR(OrderDetails.OrderDate) = YEAR(ProductDetails.Manufacture_Date)--Products which is ordered in the same year of its manufacturing year where the Manufacturer is ‘Samsung’SELECT * FROM OrderDetailsINNER JOIN ProductDetails ON OrderDetails.OrderId = ProductDetails.OrderIdWHERE YEAR(OrderDetails.OrderDate) = YEAR(ProductDetails.Manufacture_Date) 	AND ProductDetails.Manufr_id = (SELECT Manufr_id FROM ManufacturerDetails WHERE Manufr_name = 'Samsung')--Total number of products ordered every yearSELECT YEAR(OrderDate) 'Year', SUM(OrderQuantity) 'No. of products ordered'FROM OrderDetailsGROUP BY YEAR(OrderDate)--Display the total number of products ordered every year made by sonySELECT YEAR(OrderDetails.OrderDate), SUM(OrderQuantity)FROM OrderDetailsJOIN ProductDetails ON OrderDetails.OrderId = ProductDetails.OrderIdJOIN ManufacturerDetails ON ProductDetails.Manufr_id = ManufacturerDetails.Manufr_idGROUP BY ManufacturerDetails.Manufr_name, YEAR(OrderDetails.OrderDate)HAVING ManufacturerDetails.Manufr_name = 'Sony'--All customers who are ordering mobile phone by samsungSELECT * FROM CustomerDetailsJOIN OrderDetails ON OrderDetails.CustomerId = CustomerDetails.CustomerIdJOIN ProductDetails ON OrderDetails.OrderId = ProductDetails.OrderIdJOIN ManufacturerDetails ON ProductDetails.Manufr_id = ManufacturerDetails.Manufr_idWHERE ManufacturerDetails.Manufr_name = 'Samsung'--Total number of orders got by each Manufacturer every yearSELECT ManufacturerDetails.Manufr_name, YEAR(OrderDetails.OrderDate) 'Year', COUNT(OrderDetails.OrderId) 'No. of Orders'FROM ManufacturerDetailsJOIN ProductDetails ON ProductDetails.Manufr_id = ManufacturerDetails.Manufr_idJOIN OrderDetails ON OrderDetails.OrderId = ProductDetails.OrderIdGROUP BY ManufacturerDetails.Manufr_name, YEAR(OrderDetails.OrderDate)--All Manufacturers whose products were sold more than 1500 Rs every yearSELECT ManufacturerDetails.Manufr_name, YEAR(OrderDetails.OrderDate) 'Year', COUNT(OrderDetails.OrderId) 'No. of Orders', SUM(OrderDetails.OrderPrice) 'Price' FROM ManufacturerDetailsJOIN ProductDetails ON ProductDetails.Manufr_id = ManufacturerDetails.Manufr_idJOIN OrderDetails ON OrderDetails.OrderId = ProductDetails.OrderIdGROUP BY ManufacturerDetails.Manufr_name, YEAR(OrderDetails.OrderDate)HAVING SUM(OrderDetails.OrderPrice) > 1500