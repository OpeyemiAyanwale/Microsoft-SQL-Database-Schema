---Project 2 Query ------

---use employee db database
use Employees_db;

--- selecting the number of column in the department table
SELECT COUNT (*) FROM departments;

---display date of birth
SELECT YEAR(end_date) AS 'birth of date' , employee_id
FROM job_history;

---display all item in department table
SELECT * FROM departments;

---count of all the column in the department table
SELECT COUNT(department_id) AS count_of_dept_id, COUNT(department_name) AS count_of_dept_name,
COUNT(manager_id) AS count_of_mgr_id, COUNT (location_id) AS count_of_loc_id,
FROM departments;

---DISTINCT--- to count unique values
---display the distinct location id from the department
SELECT DISTINCT(location_id)
FROM departments;

---display count of distinct location id
SELECT COUNT (DISTINCT location_id)
FROM [departments];

---ORDER BY---
--- select the item and sort/order it by default its order in ascending order or desc
SELECT DISTINCT location_id
FROM departments
ORDER BY location_id;

SELECT DISTINCT location_id
FROM departments
ORDER BY location_id desc;

----GROUP BY-----
----count depatment id and group it by location--- id --
SELECT location_id, COUNT(department_id)
FROM departments
GROUP BY location_id;

---order it by location id in desc order----
SELECT location_id, COUNT(department_id) As 'count of dep'
FROM departments
GROUP BY location_id
ORDER BY location_id desc;

---order it by count of dep in desc order---
SELECT location_id, COUNT(department_id) As 'count of dep'
FROM departments
GROUP BY location_id
ORDER BY 'count of dep' desc;


---summation on all values in the column----
SELECT location_id, SUM (department_id) As 'sum of dep'
FROM departments
GROUP BY location_id
ORDER BY 'sum of dep' desc;

---minimium on all values in the column----
SELECT location_id, MIN (department_id) As 'min of dep'
FROM departments
GROUP BY location_id
ORDER BY 'min of dep' desc;

---maximium on all values in the column---
SELECT location_id, MAX (department_id) As 'max of dep'
FROM departments
GROUP BY location_id
ORDER BY 'max of dep' desc;


----Solving Exercise------------------------------
SELECT *
FROM employees;

----1.) Display the minimium salary---
SELECT MIN (salary) 
FROM employees;

---you can name the column---
SELECT MIN (salary) AS 'min salary'
FROM employees;

----2.) Display the maximum salary---
SELECT Max (salary) AS 'max salary'
FROM employees;

----3.) Display the total salary---
SELECT SUM (salary) AS 'Sum of salary'
FROM employees;

----4.) Display the average salary---
SELECT AVG (salary) AS 'Average of salary'
FROM employees;

----5.) Issue a query to count the number of rows in the employee table. The result should be just one row.---
SELECT COUNT(*)
FROM employees;

SELECT DISTINCT employee_id
FROM employees;

SELECT COUNT (employee_id)
FROM employees;

---6.) Issue a query to count the number of employees that make commission. The result should be just one row.----
--- we can try to count the commission perctage column first
SELECT COUNT (commission_pct)
FROM employees;

--where commission is null
SELECT employee_id, commission_pct
FROM employees
WHERE commission_pct IS NULL;

---where commission is not null--
SELECT employee_id, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

--- now to the main question count employee and filter by commission percentage
SELECT COUNT (employee_id)
FROM employees
WHERE commission_pct IS NOT NULL;

---7.)  Issue a query to count the number of employees’ first name column. The result should be just one row.---
SELECT COUNT (first_name)
FROM employees;

SELECT COUNT (first_name) AS First_Name_Count
FROM employees;

---8.) Display all employees that make less than Peter Hall.--
SELECT first_name, last_name, salary
FROM employees
WHERE first_name = 'Peter' AND last_name = 'Hall';

--- now to see all employee that make less than 9000
SELECT first_name, last_name, salary
FROM employees
WHERE salary < 9000;

SELECT first_name, last_name, salary
FROM employees
WHERE salary < (SELECT salary
FROM employees
WHERE first_name = 'Peter' AND last_name = 'Hall');

---9.) Display all the employees in the same department as Lisa Ozer.-----
SELECT *FROM employees;
SELECT * FROM departments;

SELECT first_name, last_name, department_id
FROM employees
WHERE first_name = 'LISA' AND last_name = 'Ozer';

SELECT first_name, last_name, department_id
FROM employees
WHERE department_id = 80;

SELECT first_name, last_name, department_id
FROM employees
WHERE department_id = (SELECT department_id
FROM employees
WHERE first_name = 'LISA' AND last_name = 'Ozer');

---10.) Display all the employees in the same department as Martha Sullivan and that make more than TJ Olson.----
SELECT first_name, last_name, salary
FROM employees
WHERE first_name = 'TJ' AND last_name = 'Olson';

SELECT first_name, last_name, salary
FROM employees
WHERE salary > 2100;

SELECT first_name, last_name, department_id, salary
 FROM employees
WHERE department_id = (SELECT department_id
 FROM employees 
WHERE first_name = 'Martha' AND last_name = 'Sullivan') AND salary > (SELECT salary
 FROM employees
WHERE first_name = 'TJ' AND last_name = 'Olson');

---11.) Display all the departments that exist in the departments table that are not in the employees’ table. Do not use a where clause.----
---use a joining clause
SELECT * FROM employees;
SELECT * FROM departments;

SELECT DISTINCT department_id
FROM employees;

SELECT department_id
FROM departments;

SELECT department_id FROM  employees 
WHERE department_id = 10;

SELECT department_id
FROM departments
WHERE department_id <> 10;
--- <> means not equal to --- 
--you can use the query before to replace the 10 to have subquery it will still be same result

--- now to the main question
SELECT department_id
FROM departments
WHERE department_id IN (NULL,10, 20, 30,40,50,60,70,80,90,100, 110);

SELECT DISTINCT department_id AS dept_own FROM departments;
SELECT DISTINCT department_id AS emp_own FROM employees;

SELECT department_id
FROM departments
WHERE department_id <> (SELECT department_id FROM  employees WHERE department_id = 10);


SELECT department_id AS dept_own
FROM departments
WHERE department_id NOT IN 
(SELECT DISTINCT department_id AS emp_own FROM employees WHERE department_id IS NOT NULL);

---straight forward 
SELECT department_id FROM departments  --- 27 rows,
EXCEPT
SELECT DISTINCT department_id FROM employees ----


---12.) Display all the departments that exist in department tables that are also in the employees’ table. Do not use a where clause.----
SELECT * FROM employees;
SELECT * FROM departments;

SELECT department_id FROM departments
INTERSECT
SELECT department_id FROM employees;

---- JOIN can also be applied
SELECT D.department_name
FROM employees e
INNER JOIN departments d ON (E.department_id = d.department_id);

SELECT D.department_name
FROM employees e
JOIN departments d ON (E.department_id = d.department_id);

---13.) Display all the departments name, street address, postal code, city, and state of each department. Use the departments and locations table for this query.----
SELECT D.department_name, L.street_address, L.postal_code, L.city, L.state_province
FROM departments D
JOIN LOCATIONS L ON D.location_id = L.location_id;

SELECT D.department_name, L.street_address, L.postal_code, L.city, L.state_province, D.location_id
FROM departments D
LEFT JOIN LOCATIONS L ON D.location_id = L.location_id;

---- same result for both query above bcos all values are in the left join

SELECT department_name, street_address, postal_code, city, state_province, department_id,
d.location_id AS dep_loc_id, l.location_id AS loc_loc_id
FROM departments D
LEFT JOIN LOCATIONS AS l ON d.location_id = l.location_id;


---14.) Display the first name and salary of all the employees in the accounting departments. ---
SELECT e.department_id, e.first_name, e.job_id , d.department_name  
FROM employees e , departments d  
WHERE e.department_id = d.department_id  
AND  d.department_name = 'Accounting';

SELECT e.department_id, e.first_name, e.job_id, d.department_name
  FROM employees e
  INNER JOIN departments d
    ON e.department_id = d.department_id
  WHERE d.department_name = 'Accounting';

SELECT first_name, salary 
FROM employees 
WHERE department_id = (SELECT department_id FROM departments WHERE department_name ='Accounting');

---15.) Display all the last name of all the employees whose department location id are 1700 and 1800.---
SELECT * FROM departments;

SELECT e.last_name, e.department_id, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.location_id = '1700' OR d.location_id = '1800';


SELECT last_name, department_id
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE location_id IN (1700, 1800));

SELECT last_name, em.department_id, location_id
FROM employees AS em
JOIN departments AS dep
ON em.department_id = dep.department_id
WHERE location_id IN (1700,1800);

SELECT DISTINCT department_id FROM departments WHERE location_id =1700 OR location_id =1800;


---16.) Display the phone number of all the employees in the Marketing department.---
SELECT e.department_id, e.first_name, e.job_id , d.department_name, e.phone_number 
FROM employees e , departments d  
WHERE e.department_id = d.department_id  
AND  department_name = 'Marketing';

SELECT first_name, phone_number
FROM employees 
WHERE department_id = (SELECT department_id FROM departments WHERE department_name ='Marketing');

---17.) Display all the employees in the Shipping and Marketing departments who make more than 3100.---
SELECT first_name, last_name, salary
FROM employees 
WHERE department_id IN (SELECT department_id FROM departments WHERE department_name IN ('Marketing', 'Shipping'))
AND salary > 3100.00;


---18.) Write an SQL query to print the first three characters of FIRST_NAME from employee’s table.---
SELECT SUBSTRING (first_name, 1, 3)
FROM employees;

--19.) Display all the employees who were hired before Tayler Fox.----
SELECT first_name, last_name, hire_date
FROM employees
Where first_name = 'Tayler' AND last_name = 'Fox';

---Taylor hire data is 2006-01-24--- apply this to the main question

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date < '2006-06-21'; 


SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date < (SELECT hire_date
FROM employees
WHERE first_name = 'Tayler' AND last_name = 'Fox');

--20.) Display names and salary of the employees in executive department.--- 
SELECT * FROM departments;
SELECT * FROM employees;

SELECT e.first_name, e.last_name, salary, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND  d.department_name = 'Executive';

SELECT first_name, last_name, salary
FROM employees
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Executive');

---21.) Display the employees whose job ID is the same as that of employee 141.
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = (SELECT job_id
				FROM employees
				WHERE employee_id =141);

---22.) For each employee, display the employee number, last name, salary, and salary increased by 15% and expressed as a whole number. Label the column New Salary.

SELECT employee_id, first_name, last_name, salary, 
CONVERT(DEC(10,0), (salary + (salary * 15/100))) AS 'NEW Salary'
FROM employees;

SELECT employee_id, first_name, last_name, salary, 
CONVERT(INT, (salary + (salary * 15/100))) AS 'NEW Salary'
FROM employees;

SELECT employee_id, first_name, last_name, salary, 
CONVERT(INT, (salary + (salary * 15/100))) AS 'NEW Salary'
FROM employees;

---23). Write an SQL query to print the FIRST_NAME and LAST_NAME from employees table into a single column COMPLETE_NAME. A space char should separate them.
SELECT CONCAT(first_name, ' ', last_name) AS COMPLETE_NAME
FROM employees;

SELECT first_name, last_name, CONCAT(first_name, ' ', last_name) AS COMPLETE_NAME
FROM employees;

---24.) Display all the employees and their salaries that make more than Abel.
SELECT  first_name, last_name, salary
FROM employees
WHERE first_name = 'Abel' OR last_name = 'Abel';

-----Abel salary is 11000.00

SELECT last_name
FROM employees
WHERE salary > (SELECT salary
				FROM employees
				WHERE last_name = 'Abel');

SELECT  first_name, last_name, salary
FROM employees
WHERE salary > 11000.00;


---25.) Create a query that displays the employees’ last names and commission amounts. If an employee does not earn commission, put “no commission”. Label the column COMM. 
SELECT * FROM departments;
SELECT * FROM employees;

SELECT last_name, NVL2 (commission_pct, TO CHAR(commission_pct)'no commission') "COMM"
FROM employees;






---26.) Create a unique listing of all jobs that are in department 80. Include the location of department in the output.
SELECT job_id, location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id =80;

---27.) Write a query to display the employee’s last name, department name, location ID, and city of all employees who earn a commission.
SELECT e.last_name, d.department_name, l.location_id, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND e.commission_pct IS NOT NULL;

---28.) Create a query to display the name and hire date of any employee hired after employee Davies.
SELECT e.last_name, e.hire_date
	FROM employees e, employees davies
	WHERE davies.last_name = 'Davies'
	AND davies.hire_date < e.hire_date

		-- OR

SELECT e.last_name, e.hire_date
	FROM employees e JOIN employees davies
	ON (davies.last_name = 'Davies')
	WHERE davies.hire_date < e.hire_date;

---29.) Write an SQL query to show one row twice in results from a table.
SELECT first_name FROM employees
	UNION ALL
SELECT first_name FROM employees ;


---30.) Display the highest, lowest, sum, and average salary of all employees. Label the columns Maximum, Minimum, Sum, and Average, respectively. Round your results to the nearest whole number.
SELECT ROUND (MAX(salary),0) 'Maximium',
ROUND(MIN(salary),0) 'Minimium',
ROUND(AVG(salary),0) 'Average',
ROUND(SUM(salary),0) 'Sum'
FROM employees;



