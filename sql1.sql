CREATE DATABASE camp1
USE camp1

--Normalising the given table into 3NF, we will get the following tables:
--EmployeeDetails {emp_id, emp_name, pay, dept_id}
--DepartmentDetails {dept_id, dept_name}

--Creating tables
CREATE TABLE DepartmentDetails(
	dept_id INT PRIMARY KEY,
	dept_name VARCHAR(25)
);

CREATE TABLE EmployeeDetails(
	emp_id INT PRIMARY KEY,
	emp_name VARCHAR(25),
	pay INT,
	dept_id INT NOT NULL,
	CONSTRAINT fk_employee
		FOREIGN KEY (dept_id)
		REFERENCES DepartmentDetails(dept_id)
);

--Insert values 
INSERT INTO DepartmentDetails VALUES
(01, 'IT'),
(02, 'Sales'),
(03, 'Marketing'),
(04, 'HR')

INSERT INTO EmployeeDetails VALUES
(001, 'Dilip', 3000, 01),
(002, 'Fahad', 4000, 02),
(003, 'Lal', 6000, 03),
(004, 'Nivin', 2000, 01),
(005, 'Vijay', 9000, 02),
(006, 'Anu', 5000, 04),
(007, 'Nimisha', 5000, 02),
(008, 'Praveena', 8000, 03)

--Preview the tables
SELECT * FROM DepartmentDetails

SELECT * FROM EmployeeDetails

--The total number of employees
SELECT COUNT(emp_id) 'Total Count'
FROM EmployeeDetails

--Total amount required to pay all employees
SELECT SUM(pay) 'Total Amount'
FROM EmployeeDetails

--Average, minimum and maximum pay in the organization
SELECT AVG(pay) 'Avg Pay', MAX(pay) 'Max Pay', MIN(pay) 'Min Pay'
FROM EmployeeDetails

--Each Department wise total pay
SELECT DepartmentDetails.dept_name, SUM(EmployeeDetails.pay) 'Total Pay'
FROM EmployeeDetails
INNER JOIN DepartmentDetails ON EmployeeDetails.dept_id = DepartmentDetails.dept_id
GROUP BY DepartmentDetails.dept_name

-- Average, minimum and maximum pay department-wise
SELECT DepartmentDetails.dept_name, AVG(EmployeeDetails.pay) 'Avg Pay', MIN(EmployeeDetails.pay) 'Min Pay', MAX(EmployeeDetails.pay) 'Max Pay'
FROM EmployeeDetails
INNER JOIN DepartmentDetails ON EmployeeDetails.dept_id = DepartmentDetails.dept_id
GROUP BY DepartmentDetails.dept_name

-- Employee details who earns the maximum pay
SELECT * 
FROM EmployeeDetails
WHERE pay = (SELECT MAX(pay) FROM EmployeeDetails)

-- Employee details who is having a maximum pay in the department
CREATE VIEW dept_wise_nax AS
SELECT dept_id, MAX(pay) MaxPay
FROM EmployeeDetails
GROUP BY dept_id

SELECT emp_id, emp_name, pay, DepartmentDetails.dept_name FROM EmployeeDetails
RIGHT JOIN dept_wise_nax ON EmployeeDetails.pay = dept_wise_nax.MaxPay AND EmployeeDetails.dept_id = dept_wise_nax.dept_id
JOIN DepartmentDetails ON EmployeeDetails.dept_id = DepartmentDetails.dept_id

--Employee who has more pay than the average pay of his department

  
--Unique departments in the company
SELECT dept_name
FROM DepartmentDetails

--Employees In increasing order of pay
SELECT * 
FROM EmployeeDetails
ORDER BY pay

--Department In increasing order of pay
SELECT DepartmentDetails.dept_name, SUM(EmployeeDetails.pay) 'Total Pay'
FROM EmployeeDetails
INNER JOIN DepartmentDetails ON EmployeeDetails.dept_id = DepartmentDetails.dept_id
GROUP BY DepartmentDetails.dept_name
ORDER BY SUM(EmployeeDetails.pay)