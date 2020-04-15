--sqlhw
DROP TABLE IF EXISTS data_departments;

CREATE TABLE data_departments (
  dep_no VARCHAR PRIMARY KEY,
  dept_name character varying(45) NOT NULL
  );
COPY data_departments FROM 'C:\temp-data\data_departments.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM data_departments;

DROP TABLE IF EXISTS data_titles;

CREATE TABLE data_titles (
  emp_no INT,
	title VARCHAR(45),
	from_date DATE,
	to_date DATE);

COPY data_titles FROM 'C:\temp-data\data_titles.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM data_titles;

DROP TABLE IF EXISTS dept_manager;

CREATE TABLE dept_manager (
dept_no VARCHAR(45),
emp_no INT,
from_date DATE,
to_date DATE);

COPY dept_manager FROM 'C:\temp-data\dept_manager.csv' DELIMITER ',' CSV HEADER;
SELECT * FROM dept_manager;

DROP TABLE IF EXISTS salaries;

CREATE TABLE salaries (
emp_no INT,
	salary FLOAT,
from_date DATE,
to_date DATE);

COPY salaries FROM 'C:\temp-data\data_salaries.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM salaries;


DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
emp_no INT,
	birth_date DATE,
	first_name VARCHAR(45),
	last_name VARCHAR(45),
	gender VARCHAR(2),
	hire_date DATE);

COPY employees FROM 'C:\temp-data\data_employees.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM employees;

DROP TABLE IF EXISTS dept_employees;

CREATE TABLE dept_employees (
emp_no INT,
	dept_no VARCHAR,
	from_date DATE,
	to_date DATE);

COPY dept_employees FROM 'C:\temp-data\data_dept_emp.csv' DELIMITER ',' CSV HEADER;

SELECT * FROM dept_employees;
SELECT * FROM salaries;

--1. List the following details 
--of each employee: employee number, last name, first name, gender, and salary.

-- Perform an INNER JOIN on the two tables
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender,
salaries.salary
FROM salaries
INNER JOIN employees ON
employees.emp_no=salaries.emp_no;

--2. List employees who were hired in 1986.
SELECT * FROM employees;

SELECT * FROM employees WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31'

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.

SELECT * FROM data_departments;
--dept_no	dept_name
SELECT * FROM dept_manager;
----dept_no	emp_no
SELECT * FROM dept_employees;
--emp_no	dept_no	from_date	to_date
SELECT * FROM employees;

--CREATE VIEW MANAGERVIEW
--AS SELECT data_departments.dep_no, data_departments.dept_name,dept_manager.emp_no,employees.last_name,
--	emplyees.first_name, dept_manager.from_date, dept_manager.to_date
CREATE VIEW managerview AS
    SELECT data_departments.dep_no, data_departments.dept_name,dept_manager.emp_no,employees.last_name,
	employees.first_name, dept_manager.from_date, dept_manager.to_date
    FROM data_departments, dept_manager, employees
    WHERE (data_departments.dep_no = dept_manager.dept_no) AND
    (dept_manager.emp_no = employees.emp_no)
    ORDER BY data_departments.dep_no;
	
	SELECT * FROM managerview;

SELECT data_departments.dep_no, 
data_departments.dept_name, 
dept_manager.emp_no
FROM dept_manager
INNER JOIN data_departments ON
data_departments.dep_no=dept_manager.dept_no
INNER JOIN 

SELECT * FROM data_departments


--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT * FROM dept_employees

SELECT employees.emp_no, employees.last_name, employees.first_name,
dept_employees.dept_no
FROM dept_employees
INNER JOIN employees ON
employees.emp_no=dept_employees.emp_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

CREATE VIEW SALESDEPTVIEW AS
    SELECT employees.emp_no, employees.last_name, employees.first_name,data_departments.dept_name
    FROM data_departments, dept_employees, employees
    WHERE (data_departments.dep_no = dept_employees.dept_no) AND
    (dept_employees.emp_no = employees.emp_no)
    ORDER BY data_departments.dep_no;
	
SELECT * FROM SALESDEPTVIEW WHERE dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
CREATE VIEW ALL_DEPT_VIEW AS
    SELECT employees.emp_no, employees.last_name, employees.first_name,data_departments.dept_name
    FROM data_departments, dept_employees, employees
    WHERE (data_departments.dep_no = dept_employees.dept_no) AND
    (dept_employees.emp_no = employees.emp_no)
    ORDER BY data_departments.dep_no;
SELECT * FROM ALL_DEPT_VIEW WHERE dept_name = 'Sales' OR dept_name = 'Development';	

--8. In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.
SELECT * FROM employees;

SELECT last_name, COUNT(last_name)
  FROM employees
  GROUP BY last_name
  ORDER BY COUNT(last_name) DESC;
  

  
  




