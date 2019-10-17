-- Create drop tables in case of a mistake
DROP TABLE departments;
DROP TABLE dept_emp;
DROP TABLE dept_manager;
DROP TABLE employees;
DROP TABLE salaries;
DROP TABLE titles;

-- Make the tables
CREATE TABLE "departments" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

SELECT * FROM departments;

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(30)   NOT NULL,
    "from_date" VARCHAR(30)   NOT NULL,
    "to_date" VARCHAR(30)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" VARCHAR(30)   NOT NULL,
    "to_date" VARCHAR(30)   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "birth_date" VARCHAR(30)   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "gender" VARCHAR(30)   NOT NULL,
    "hire_date" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    "from_date" VARCHAR(30)   NOT NULL,
    "to_date" VARCHAR(30)   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INT   NOT NULL,
    "title" VARCHAR(50)   NOT NULL,
    "from_date" VARCHAR(30)   NOT NULL,
    "to_date" VARCHAR(30)   NOT NULL
);

-- Exported to QuickDBD to get the alter table code written then imported back in
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");
--------------------------------------------------------------------------

-- Answer the questions
-- Query 1: List the following details of each employee: 
-- employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, 
	employees.first_name, employees.gender, salaries.salary
FROM employees, salaries
WHERE employees.emp_no = salaries.emp_no;
----------------------------------------------------------------------------

-- 	Query 2: List employees who were hired in 1986.
SELECT employees.emp_no, employees.last_name, 
	employees.first_name, employees.hire_date
FROM employees
WHERE employees.hire_date LIKE '1986%';
-----------------------------------------------------------------------

-- Query 3: List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, 
-- first name, and start and end employment dates.
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no,
	employees.last_name, employees.first_name, dept_manager.from_date,
	dept_manager.to_date
FROM departments, dept_manager, employees
WHERE employees.emp_no = dept_manager.emp_no
AND departments.dept_no = dept_manager.dept_no;
------------------------------------------------------------------------
	
-- Query 4: List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, 
	employees.first_name, departments.dept_name
FROM employees, departments, dept_emp
WHERE employees.emp_no = dept_emp.emp_no
AND departments.dept_no = dept_emp.dept_no;

----------------------------------------------------------------------

-- Query 5: List all employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name, employees.last_name
FROM employees
WHERE employees.first_name = 'Hercules'
AND employees.last_name LIKE 'B%';
------------------------------------------------------------------------------

-- Query 6: List all employees in the Sales department, including their
-- employee number, last name, first name, and department name.
SELECT dept_emp.emp_no, employees.last_name, 
	employees.first_name, departments.dept_name
FROM employees, departments, dept_emp
WHERE dept_emp.emp_no = employees.emp_no
AND departments.dept_no = dept_emp.dept_no
AND departments.dept_name = 'Sales'

-- I just wanted to see if I could do it using joins as well
SELECT dept_emp.emp_no, employees.last_name,
	employees.first_name, departments.dept_name
FROM departments
INNER JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
INNER JOIN employees
ON dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales';
------------------------------------------------------------------------------

-- Query 7: List all employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.	
SELECT dept_emp.emp_no, employees.last_name, 
	employees.first_name, departments.dept_name
FROM departments
inner join dept_emp
on departments.dept_no = dept_emp.dept_no
inner join employees
on dept_emp.emp_no = employees.emp_no
WHERE departments.dept_name = 'Sales'
OR departments.dept_name = 'Development';
-----------------------------------------------------------------------------

-- Query 8: In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.
SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY count DESC;

--SELECT * FROM employees
--WHERE employees.emp_no = 499942