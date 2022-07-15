USE camp1

--Creating tables
CREATE TABLE Department(
	deptno INT PRIMARY KEY,
	dname varchar(25),
	loc varchar(25)
);

CREATE TABLE Employee(
	empno INT PRIMARY KEY,
	ename varchar(25) not null,
	job varchar(25) NOT NULL,
	mgr INT,
	hiredate date,
	sal INT,
	commission INT,
	deptno INT,
	CONSTRAINT fk_employee_dept
	FOREIGN KEY(deptno)
	REFERENCES Department(deptno)
);

--Inserting values
INSERT INTO Department VALUES
(10,'ACCOUNTING','NEW YORK'),
(20,'RESEARCH','DALLAS'),
(30,'SALES','NEW YORK'),
(40,'OPERATIONS','BOSTON')

INSERT INTO Employee VALUES
(7839,'KING','PRESIDENT',null,'11/17/1981',5000,NULL,10),
(7698,'BLAKE','MANAGER',7839,'05/01/1981',2850,NULL,30),
(7782,'CLARK','MANAGER',7839,'06/09/1981',2450,NULL,10),
(7566,'JONES','MANAGER',7839,'04/02/1981',2975,NULL,20),
(7788,'SCOTT','ANALYST',7566,'12/09/1982',3000,NULL,20),
(7902,'FORD','ANALYST',7566,'12/03/1981',3000,NULL,20),
(7369,'SMITH','CLERK',7902,'12/17/1981',800,NULL,20),
(7499,'ALLEN','SALESMAN',7698,'02/20/1981',1600,300,30),
(7521,'WARD','SALESMAN',7698,'02/22/1981',1250,500,30),
(7654,'MARTIN','SALESMAN',7698,'09/28/1981',1250,1400,30),
(7844,'TURNER','SALESMAN',7698,'09/08/1981',1500,NULL,30),
(7876,'ADAMS','CLERK',7788,'01/12/1983',1100,NULL,20),
(7900,'JAMES','CLERK',7698,'12/03/1981',950,NULL,30),
(7934,'MILLER','CLERK',7782,'01/23/1982',1300,NULL,10)

--Report needed: Names of employees who are manager
SELECT ename FROM Employee 
WHERE job = 'MANAGER'

-- List the name of all employees along with their department name and Annual Income
SELECT Employee.ename, Department.dname, Employee.sal*12 'Annual Income' 
FROM Employee
JOIN Department ON Employee.deptno = Department.deptno

--Report needed: Names of departments and names of employees. Names of departments
--in ascending order. Within the same department, employee name should be in the
--descending order
SELECT Department.dname, Employee.ename
FROM Employee
JOIN Department ON Employee.deptno = Department.deptno
ORDER BY Department.dname ASC, Employee.ename DESC

--Find out employee name and departmentname of employees who either works in a Toy or Shoe department

--Report needed: Name concatenated with department, separated by comma and space and name column Employee and department