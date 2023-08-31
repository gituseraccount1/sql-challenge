-- PART 3. DATA ANAYLSIS
-- 3.1 List the employee number, last name, first name, sex, and salary of each employee (2 points)
SELECT employee.emp_no, employee.last_name, employee.first_name, employee.sex, salaries.salary
FROM employee
INNER JOIN salaries ON employee.emp_no=salaries.emp_no;

-- 3.2 List the first name, last name, and hire date for the employees who were hired in 1986 (2 points)
SELECT employee.first_name, employee.last_name, employee.hire_date
FROM employee
WHERE hire_date >= '01-01-1986' AND hire_date <= '12-31-1986';

-- 3.3 List the manager of each department along with their department number, department name, employee number, last name, and first name (2 points)
-- Used this as a reference about having two inner joins: https://stackoverflow.com/questions/14995000/sql-inner-join-more-than-two-tables
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employee.last_name, employee.first_name
FROM dept_manager
INNER JOIN departments
	ON dept_manager.dept_no = departments.dept_no
INNER JOIN employee
	ON dept_manager.emp_no = employee.emp_no;

-- 3.4 List the department number for each employee along with that employee’s employee number, last name, first name, and department name (2 points)



-- 3.5 List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points)
SELECT employee.first_name, employee.last_name, employee.sex
FROM employee
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 3.6 List each employee in the Sales department, including their employee number, last name, and first name (2 points)
-- My 2nd (Final) Step: 
SELECT employee.emp_no, employee.last_name, employee.first_name
FROM employee
WHERE emp_no IN
( 
	SELECT emp_num
	FROM dept_emp
	WHERE dept_no =
		(
		SELECT departments.dept_no
		FROM departments
		WHERE dept_name = 'Sales'
		)
);

-- Just to check if my query above is correct
SELECT COUNT(emp_num)
FROM dept_emp
WHERE dept_no =
(
	SELECT departments.dept_no
	FROM departments
	WHERE dept_name = 'Sales'
);

-- 3.7 List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name (4 points)
SELECT employee.emp_no, employee.last_name, employee.first_name
FROM employee
WHERE emp_no IN
( 
	SELECT emp_num--, dept_no, 
	FROM dept_emp
	WHERE dept_no =
		(
		SELECT departments.dept_no
		FROM departments
		WHERE dept_name = 'Sales'
		)
		OR
		dept_no = 
		(
		SELECT departments.dept_no
		FROM departments
		WHERE dept_name = 'Development'
		)
);

-- Just to check if my query above is correct
SELECT COUNT(emp_num)
FROM dept_emp
WHERE dept_no =
(
	SELECT departments.dept_no
	FROM departments
	WHERE dept_name = 'Sales'
)
OR
dept_no = 
(
	SELECT departments.dept_no
	FROM departments
	WHERE dept_name = 'Development'
);

-- 3.8 List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points)
SELECT last_name, COUNT(last_name) AS Frequency
FROM employee
GROUP BY last_name
ORDER BY COUNT(last_name) DESC
-- got this from a website https://www.c-sharpcorner.com/blogs/sql-query-to-find-out-the-frequency-of-each-element-in-a-column1