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


----Solving Exercise-----
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


SELECT employee_id, salary FROM employees
WHERE salary >(SELECT salary FROM employees
WHERE last_name = 'Abel')

---25.) Create a query that displays the employees’ last names and commission amounts. If an employee does not earn commission, put “no commission”. Label the column COMM. 
SELECT * FROM departments;
SELECT * FROM employees;

SELECT last_name, commission_pct, 'no commission' AS COMM ----71 rows
FROM employees
WHERE commission_pct IS NULL
UNION
SELECT last_name, commission_pct, CAST(commission_pct AS VARCHAR) AS COMM ----35 rows
FROM employees
WHERE commission_pct IS NOT NULL;

-----OR------

SELECT last_name, 'no commission' AS COMM -- 71 rows
FROM employees
WHERE commission_pct IS NULL
UNION
SELECT last_name, CONVERT(VARCHAR, commission_pct) AS COMM -- 35 rows
FROM employees
WHERE commission_pct IS NOT NULL

----OR Using a Case/Else statement--------
SELECT last_name, commission_pct,
(CASE WHEN commission_pct IS NULL THEN 'no commission'
	ELSE CONVERT(VARCHAR, commission_pct) END) AS COMM 
FROM employees;



---26.) Create a unique listing of all jobs that are in department 80. Include the location of department in the output.
SELECT job_id, location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id =80;



SELECT DISTINCT job_id, dep.department_id, location_id
FROM employees AS emp
JOIN departments AS dep
ON emp.department_id = dep.department_id
WHERE dep.department_id = 80;

---- Joining more than one table----
SELECT DISTINCT job_id, dep.department_id, dep.location_id, street_address
FROM employees AS emp
JOIN departments AS dep
ON emp.department_id = dep.department_id
JOIN locations AS loc
ON dep.location_id = loc.location_id
WHERE dep.department_id = 80;


---27.) Write a query to display the employee’s last name, department name, location ID, and city of all employees who earn a commission.
SELECT e.last_name, d.department_name, l.location_id, l.city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id
AND e.commission_pct IS NOT NULL;

------OR Using Join-----

SELECT last_name, dep.department_name, loc.location_id, city 
FROM employees AS emp
JOIN departments AS dep
ON emp.department_id = dep.department_id
JOIN locations AS loc
ON dep.location_id = loc.location_id
WHERE commission_pct IS NOT NULL;

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
SELECT * FROM employees
	UNION ALL
SELECT * FROM employees
ORDER BY employee_id;


---30.) Display the highest, lowest, sum, and average salary of all employees. Label the columns Maximum, Minimum, Sum, and Average, respectively. Round your results to the nearest whole number.
SELECT ROUND (MAX(salary),0) 'Maximium',
ROUND(MIN(salary),0) 'Minimium',
ROUND(AVG(salary),0) 'Average',
ROUND(SUM(salary),0) 'Sum'
FROM employees;

---31.) Write an SQL query to show the top n (say 10) records of a table.
SELECT TOP 10 * FROM employees; 

---32.) Display the MINIMUN, MAXIMUM, SUM AND AVERAGE salary of each job type. 
SELECT job_id, MIN(salary) AS MINIMUM, MAX(salary) AS MAXIMUM, AVG(salary)  AS AVERAGE, 
SUM(salary) AS TOTAL 
FROM employees
GROUP BY job_id;

SELECT job_id, ROUND(MAX(salary),0) "Maximum",
ROUND(MIN(salary),0) "Minimum",
ROUND(SUM(salary),0) "Sum",
ROUND(AVG(salary),0) "Average"
FROM employees
GROUP BY job_id;

---33.) Display all the employees and their managers from the employees’ table.
SELECT E.first_name AS "Employee Name",
   M.first_name AS "Manager"
    FROM employees E 
      LEFT OUTER JOIN employees M
       ON E.manager_id = M.employee_id;

------OR-------JOIN

SELECT emp.employee_id, emp.first_name AS emp_first_name, emp.last_name As emp_last_name,
emp.manager_id, man.first_name As man_first_name, man.last_name AS man_last_name
FROM employees AS emp
JOIN employees AS man
ON emp.manager_id = man.employee_id;


-----OR------ LEFT JOIN

SELECT emp.employee_id, emp.first_name AS emp_first_name, emp.last_name As emp_last_name,
emp.manager_id, man.first_name As man_first_name, man.last_name AS man_last_name
FROM employees AS emp
LEFT JOIN employees AS man
ON emp.manager_id = man.employee_id;


---34.) Determine the number of managers without listing them. Label the column NUMBER of managers. Hint: use manager_id column to determine the number of managers.
SELECT COUNT(DISTINCT manager_id) "Number of Managers"
FROM employees;

---35.) Write a query that displays the difference between the HIGHEST AND LOWEST salaries. Label the column DIFFERENCE.
SELECT MAX(salary) - MIN(salary) DIFFERENCE
FROM employees;

---36.) Display the sum salary of all employees in each department.
SELECT SUM(salary) FROM employees;

SELECT department_id, SUM(salary) AS sum_of_salary
FROM employees
GROUP BY department_id
ORDER BY SUM(Salary) DESC;

---37.) Write a query to display each department's name, location, number of employees, and the average salary of employees in the department. Label the column NAME, LOCATION, NUMBER OF PEOPLE, respectively.

SELECT department_name AS "NAME", location_id AS "LOCATION",
COUNT(employee_id) AS "NUMBER OF PEOPLE", AVG(salary) AS "AVERAGE SALARY"
FROM departments AS d
INNER JOIN employees AS e 
ON d.department_id = e.department_id
GROUP BY d.department_name, d.location_id; 


---38.) Write an SQL query to find the position of the alphabet (‘J’) in the first name column ‘Julia’ from employee’s table.
SELECT CHARINDEX('J',FIRST_NAME, 0) AS POSITION, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME = 'JULIA';


---39.) Create a query to display the employee number and last name of all employees who earns more than the average salary. Sort the result in ascending order of salary.
SELECT AVG(salary) FROM employees;

SELECT employee_id, last_name, salary
FROM employees
WHERE salary >(SELECT AVG(salary)
FROM employees)
ORDER BY salary;


---40.) Write a query that displays the employee number and last names of all employees who work in a department with any employees whose last name contains a letter U.
SELECT employee_id, last_name
FROM employees
WHERE department_id IN (SELECT department_id
FROM employees
WHERE last_name LIKE '%U%')
ORDER BY department_id;


---41.) Display the last name, department number and job id of all employees whose department location ID is 1700.
SELECT last_name, department_id, job_id
FROM employees
WHERE department_id IN (SELECT department_id
FROM departments
WHERE location_id =1700);

---42.) Display the last name and salary of every employee who reports to king.
SELECT first_name, last_name, employee_id
FROM employees
WHERE first_name = 'king' OR last_name ='king';

SELECT last_name, salary
FROM employees
WHERE manager_id = (SELECT manager_id
FROM employees
WHERE last_name = 'King');

SELECT last_name, salary
FROM employees
WHERE manager_id = (SELECT employee_id
FROM employees
WHERE last_name = 'King');


---43.) Display the department number, last name, job ID of every employee in Executive department.---
SELECT department_id, last_name, job_id
FROM employees
WHERE department_id IN (SELECT department_id
FROM departments
WHERE department_name = 'Executive')


---44.) Display all last name, their department name and id from employees and department tables.---
SELECT employee_id, last_name, department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE last_name IS NOT NULL;
	

---45.) Display all the last name department name, id and location from employees, department, and locations tables.---
SELECT last_name, department_name, e.department_id, d.location_id
FROM employees AS e
LEFT JOIN departments AS d
ON e.department_id = d.department_id
LEFT JOIN locations AS l
ON d.location_id = l.location_id;


---46.) Write an SQL query to print all employee details from the employees table order by DEPARTMENT Descending.---
SELECT * 
FROM employees 
ORDER BY department_id DESC;

---47.) Write a query to determine who earns more than Mr. Tobias:---
SELECT first_name, last_name, salary
FROM employees
WHERE salary >(SELECT salary 
FROM employees
WHERE last_name ='Tobias');

---48.) Write a query to determine who earns more than Mr. Taylor:---
SELECT first_name, last_name FROM employees
WHERE first_name = 'Taylor' OR last_name ='Taylor';

SELECT first_name, last_name, salary
FROM employees
WHERE salary >(SELECT MAX (salary)
FROM employees
WHERE last_name ='Taylor');


---49.) Find the job with the highest average salary.---
SELECT TOP 1 job_id, AVG(salary) AS Highest_Salary
FROM employees
GROUP BY job_id
ORDER BY Highest_Salary DESC;

-----OR------
WITH avg_salaries as (SELECT avg(salary) AS avg_job_salary 
FROM employees GROUP BY job_id)
SELECT cast(max(avg_job_salary) AS int) AS highest_avg_salary 
FROM avg_salaries;

---50.) Find the employees that make more than Taylor and are in department 80.---

SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary >(SELECT MAX(salary)
FROM employees
WHERE last_name ='Taylor') AND department_id =80; 

-----OR--------
SELECT *
FROM employees
WHERE salary >(SELECT MAX(salary)
FROM employees
WHERE last_name ='Taylor') AND department_id =80; 

--51.) Display all department names and their full street address.
SELECT department_name, street_address
FROM departments AS d
LEFT JOIN locations AS l
on d.location_id =l.location_id;

---52.) Write a query to display the number of people with the same job.
SELECT job_id, COUNT(*) AS no_of_people
FROM employees
GROUP BY job_id;

---53.) Write an SQL query to fetch “FIRST_NAME” from employees table in upper case.
SELECT UPPER(first_name) AS first_name
FROM employees;

---54.) Display the full name and salary of the employee that makes the most in departments 50 and 80.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary >(SELECT MAX(salary)
FROM employees
WHERE department_id IN (50, 80));

---55.) Display the department names for the departments 10, 20 and 30.
SELECT department_name, department_id
FROM departments
WHERE department_id IN(10, 20, 30);


---56.) Display all the manager id and department names of all the departments in United Kingdom (UK).
SELECT manager_id, department_id
FROM departments
WHERE department_id IN (SELECT department_id
FROM departments 
WHERE location_id IN (SELECT location_id
FROM locations
WHERE country_id = (SELECT country_id
FROM COUNTRIES 
WHERE country_name = 'United Kingdom')));

---OR---
WITH CTE AS
(SELECT e.manager_id, department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN locations l
ON d.location_id = l.location_id
LEFT JOIN countries c
ON l.country_id = c.country_id
WHERE e.department_id IN (SELECT department_id
FROM departments WHERE location_id IN (SELECT location_id
FROM locations WHERE country_id = (SELECT country_id
FROM COUNTRIES WHERE country_name = 'United Kingdom'))))
SELECT DISTINCT CTE.manager_id, department_name
FROM CTE;


---57.) Display the full name and phone numbers of all employees who are not in location id 1700. 
SELECT CONCAT(first_name, ' ', last_name) AS FULL_NAME, phone_number
FROM employees
WHERE department_id IN (SELECT department_id FROM departments 
WHERE location_id <> '1700')
ORDER BY 1 ASC;

---OR----
SELECT CONCAT(first_name, ' ', last_name) AS FULL_NAME, phone_number
FROM employees e
LEFT JOIN department d
ON e.department_id = d.department_id
WHERE e.department_id IS NOT NULL
EXCEPT
SELECT CONCAT(first_name, ' ', last_name) AS FULL_NAME, phone_number
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id IN (SELECT department_id FROM departments WHERE location_id = '1700');


--58.) Display the full name, department name and hire date of all employees that were hired after Shelli Baida.
SELECT e.first_name, e.last_name, e.hire_date 
	FROM employees e, employees Shelli
		WHERE Shelli.first_name = 'Shelli'
		AND Shelli.hire_date < e.hire_date;
	
	
---59.) Display the full name and salary of all employees who make the same salary as Janette King.
SELECT CONCAT(first_name, ' ', last_name) AS FULL_NAME, salary
FROM employees
WHERE salary = (SELECT salary FROM employees WHERE first_name = 'Janette' and last_name = 'King');


---60.) Display the full name hire date and salary of all employees who were hired in 2007 and make more than Elizabeth Bates.
SELECT CONCAT(First_name, ' ', last_name) AS FULL_NAME, hire_date, salary
FROM employees
WHERE YEAR(hire_date) = (2007)
AND salary > (SELECT salary FROM employees WHERE first_name = 'Elizabeth' and last_name = 'Bates');


---61.) Issue a query to display all departments whose average salary is greater than $8000. 
SELECT *
  FROM departments
  WHERE department_id IN (SELECT department_id
        FROM employees
        GROUP BY department_id
        HAVING AVG(salary) >= 8000);

---62.) Issue a query to display all departments whose maximum salary is greater than 10000.
SELECT department_id, salary
FROM employees
WHERE salary > 10000

---63) Issue a query to display the job title and total monthly salary for each job that has a total salary exceeding $13,000. Exclude any job title that looks like rep and sort the result by total monthly salary.
SELECT emp.job_id, job_title, SUM(salary) AS monthly_sal
FROM employees AS emp
JOIN jobs
ON emp.job_id = jobs.job_id
GROUP BY emp.job_id, job_title
HAVING SUM(salary) > 13000 AND job_title NOT LIKE ('%rep%')
ORDER BY SUM(salary) DESC;

---64.) Issue a query to display the department id, department name, location id and city of departments 20 and 50.
SELECT department_id, department_name, d.location_id, city
FROM departments d, locations
WHERE d.department_id IN (20, 50)

---65.) Issue a query to display the city and department name that are having a location id of 1400.
SELECT * FROM Locations

SELECT CITY, DEPARTMENT_NAME, D.LOCATION_ID, CITY
FROM LOCATIONS L
LEFT JOIN departments D ON L.location_id = D.location_id
WHERE L.location_id IN (1400)


---66.) Display the salary of last name, job id and salary of all employees whose salary is equal to the minimum salary.
SELECT * FROM jobs;

SELECT last_name, job_id, salary
FROM employees e
WHERE e.salary = (SELECT min_salary
FROM jobs j
WHERE e.job_id = j.job_id);

---67.) Display the departments who have a minimum salary greater that of department 50.
SELECT department_id, salary
FROM employees
WHERE salary >  (SELECT MIN(salary) 
FROM employees
WHERE department_id = 50);

---OR

SELECT salary, department_id 
 FROM employees
  WHERE salary < ALL
     (SELECT salary 
       FROM employees 
         WHERE department_id = 50);

---68.) Issue a query to display all employees who make more than Timothy Gates and less than Harrison Bloom.
SELECT * 
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Timothy' and LAST_NAME = 'Gates')
AND SALARY < (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Harrison' and LAST_NAME = 'Bloom');

---69.) Issue a query to display all employees who are in Lindsey Smith or Joshua Patel department, who make more than Ismael Sciarra and were hired in 2007 and 2008.
SELECT *
FROM EMPLOYEES
WHERE department_id IN ((SELECT department_id FROM employees WHERE FIRST_NAME = 'Lindsey' and LAST_NAME = 'Smith'),
						(SELECT department_id FROM employees WHERE FIRST_NAME = 'Joshua' and LAST_NAME = 'Patel'))
AND
SALARY > (SELECT SALARY FROM employees WHERE FIRST_NAME = 'Ismael' and LAST_NAME = 'Sciarra')
AND 
HIRE_DATE IN (SELECT HIRE_DATE FROM EMPLOYEES WHERE YEAR(HIRE_DATE) IN ('2007', '2008'));

---70.) Issue a query to display the full name, 10-digit phone number, salary, department name, street address, postal code, city, and state province of all employees.
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS FULL_NAME, PHONE_NUMBER, SALARY, DEPARTMENT_NAME, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE
FROM EMPLOYEES E
LEFT JOIN departments D
ON E.department_id = D.department_id
LEFT JOIN LOCATIONS L
ON D.location_id = L.location_id;

---71.) Write an SQL query that fetches the unique values of DEPARTMENT from employees table and prints its length.
SELECT DISTINCT(LEN(department_id))
FROM employees;


WITH DEPT_NAME AS (SELECT DEPARTMENT_NAME FROM EMPLOYEES EMP
					LEFT JOIN DEPARTMENTS DEP
					ON EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID)
SELECT DISTINCT DEPARTMENT_NAME AS DIS_NAME, LEN(department_name) AS LENGHT_OF_DEPARTMENT FROM DEPT_NAME;

---72.) Write an SQL query to print all employee details from the Worker table order by FIRST_NAME Ascending.
SELECT * 
FROM employees 
ORDER BY first_name ASC;
