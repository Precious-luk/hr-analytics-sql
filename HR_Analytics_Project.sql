/*
HR Analytics Project
Dataset: Parks and Recreation
Author: Thando Precious Luma

Objective:
Analyze employee demographics, salaries and departments
to provide workforce insights.

*/
 /*Question 1: How many employees are in the company?*/
SELECT 
       COUNT(*) AS total_employees
FROM employee_demographics;

/*Findings
The query calculates the total number of employees currently recorded in the employee database.

Business Insight
Understanding the total workforce size provides a foundation for workforce planning, 
budgeting, and resource allocation.
This metric helps management monitor company growth, 
assess staffing levels, and support strategic hiring decisions.*/

/*Question 2: What is the gender distribution of employees?*/
SELECT gender,
       COUNT(gender) AS gender_distribution
FROM employee_demographics
GROUP BY gender;

/*Findings
In the query we calculated the gender distribution of employees currently recorded in the employees database.

Business Insight
The results have shown that we have more male gender employees than female employees*/

/*Question 3: What is the average age of employees by gender?*/
SELECT gender, 
       AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender;

/*Findings
The analysis calculated the average age for each gender.
The results provide a comparison of the average age of male and female employees.
Each gender is represented by a single average age value, making it easy to compare workforce demographics.
The analysis summarizes age patterns within the organization by gender.

Business Insights
Understanding the average age by gender helps HR gain insight into the organization's workforce demographics.
Differences in average age between genders may indicate variations in hiring patterns, career progression, or workforce composition.
HR can use this information for workforce planning, succession planning, and talent development initiatives.*/

/*Question 4: What is the youngest and oldest employee in the company?*/
SELECT first_name,
       last_name,
       age,
       'Youngest' AS employee_type
FROM employee_demographics
WHERE age = (
    SELECT MIN(age)
    FROM employee_demographics
)

UNION

SELECT first_name,
       last_name,
       age,
       'Oldest' AS employee_type
FROM employee_demographics
WHERE age = (
    SELECT MAX(age)
    FROM employee_demographics
);

/*Findings
The analysis identified the minimum age (youngest employee) and the maximum age (oldest employee) in the company.
The workforce includes employees across a range of age groups, indicating a mix of early-career and more experienced employees.
The youngest employee represents the newest generation entering the workforce, 
while the oldest employee represents the most experienced age group in the organization.
The age range provides a snapshot of the company’s workforce diversity in terms of age and career stage.

Business Insights
A wide age range may indicate a healthy mix of fresh talent and experienced employees, which can benefit innovation and knowledge sharing.
HR can use this information for workforce planning and succession planning, 
especially if a significant portion of employees are approaching retirement age.
The presence of younger employees may highlight opportunities for training, mentorship, and career development programs.
Understanding the workforce age range helps management plan for future hiring needs, leadership development, and employee retention strategies.*/
 
 /*Question 5:Show each employee's first name, last name, gender, occupation, and salary.*/
SELECT dem.first_name,
       dem.last_name,
       gender,
       occupation,
       salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;
    
/*Findings
The analysis combines employee demographic information with salary and occupation details into a single dataset.
Each record includes the employee's name, gender, occupation, and salary.
The joined dataset provides a complete view of employees by linking information from both the demographics and salary tables.
The data can serve as a foundation for further analyses such as salary comparisons, gender distribution, occupation analysis, and compensation reporting.

Business Insights
Integrating demographic and salary data enables HR and management to perform more comprehensive workforce analyses.
The combined dataset can be used to evaluate compensation across different occupations and demographic groups.
Management can use this information to support workforce planning, salary reviews, and organizational reporting.*/
    
 /* Question 6:What is the average salary in each department?*/
 SELECT dept_id,
       AVG(salary) AS avg_sal
FROM employee_salary
GROUP BY dept_id;

/*Findings
The analysis calculated the average salary for each department.
The results show that average salaries differ across departments, indicating variations in compensation levels.
Each department is represented by a single average salary value, making it easy to compare compensation across the organization.
The analysis provides a summary of salary trends at the departmental level rather than for individual employees.

Business Insights
Comparing average salaries across departments helps management understand how compensation is distributed throughout the organization.
Departments with higher average salaries may require specialized skills, greater experience, or leadership responsibilities.
HR can use these results to benchmark departmental salaries and ensure compensation remains competitive and aligned with organizational goals.*/

/*Qustion 7: How many employees work in each department?*/
SELECT dept_id,
	   COUNT(*) AS total_employees
FROM employee_salary
GROUP BY dept_id;

/*Findings
Department 1 (Parks and Recreation) has the highest number of employees in the organization.

Business Insight
This suggests that Parks and Recreation is the largest operational department
and may require a larger workforce to maintain parks, facilities, and community services.*/

/*Question 8:Which employees earn more than the company average salary?*/
SELECT first_name,
       last_name,
       occupation,
       salary
FROM employee_salary
WHERE salary >
(
    SELECT AVG(salary)
    FROM employee_salary
);
/*Findings
Several employees earn above the company average salary.

Business Insight
Employees earning above the company average may occupy senior, 
managerial, or highly specialized roles.
These employees represent the organization's highest-compensated talent.*/

/*Question 9: Which employees earn more than the average salary of their own department?*/
SELECT first_name,
       last_name,
       occupation,
       salary,
       dept_id
FROM employee_salary s1
WHERE salary >
(
    SELECT AVG(salary)
    FROM employee_salary s2
    WHERE s1.dept_id = s2.dept_id
);
/*Findings
Several employees earn above the average salary within their department.

Business Insight
These employees are among the highest earners relative to their peers and may hold senior,
leadership, or specialized positions within their departments.*/

/*Question 10:
Categorize employees into salary bands:
High Salary: salary ≥ 80,000
Medium Salary: salary between 50,000 and 79,999
Low Salary: salary below 50,000*/
 SELECT first_name,
        last_name,
        salary,
 CASE
 WHEN salary >=80000 THEN 'high salary'
 WHEN salary BETWEEN 50000 AND 79999 THEN 'medium salary'
 ELSE 'low salary'
 END AS salary_band
 FROM employee_salary;
 
/*Findings
The majority of employees fall within the Medium Salary band (R50,000–R79,999), 
with fewer employees in the High Salary and Low Salary categories.

Business Insight
This suggests that the organization has a relatively balanced compensation structure, 
with most employees earning mid-range salaries. 
The smaller number of high-salary employees may 
indicate that senior or specialized positions are limited within the workforce.*/
       
 /*Question 11:
 Create age groups for employees
Young: under 30
Adult: 30 to 49
Senior: 50 and above*/
 
 SELECT first_name,
        last_name,
        age,
CASE
WHEN age <30 THEN 'Young'
WHEN age BETWEEN 30 AND 49 THEN 'Adult'
ELSE 'senior'
END AS age_band
FROM employee_demographics; 
       
/*Findings
Most employees fall into the Adult age group.

Business Insight
The workforce is primarily composed of mid-career employees,
which may indicate a balance between experience and operational capacity.*/

/*Question 12:
How many employees are in each salary band?
High Salary (≥ 80,000)
Medium Salary (50,000–79,999)
Low Salary (< 50,000)*/
SELECT 
CASE 
WHEN salary >= 80000 THEN 'high salary'
WHEN salary BETWEEN 50000 AND 79999 THEN 'medium salary'
ELSE 'low salary'
END AS salary_band,
    COUNT(*) AS Total_employees
FROM employee_salary
GROUP BY salary_band;

/*Findings
The majority of employees fall within the Medium Salary band.

Business Insight
The workforce is primarily concentrated in the Medium Salary band, 
suggesting that most employees occupy mid-level operational roles.
High-salary positions appear to be limited and may represent leadership or
specialized roles within the organization.*/

/*Question 13: What is the average salary for each occupation?*/
SELECT occupation,
       AVG(salary) AS avg_salary
FROM employee_salary
GROUP BY occupation;

/*Findings
ity mananger has the highest average salary among all occupations.

Business Insight
Leadership positions command significantly higher compensation, 
reflecting the increased responsibility and decision-making authority associated with these roles.
*/
use parks_and_recreation;
/* Question 14: Which occupation has the highest average salary?*/
SELECT occupation,
       AVG(salary) AS avg_salary
FROM employee_salary
GROUP BY occupation
ORDER BY avg_salary DESC
LIMIT 1;

/*Findings
The occupation with the highest average salary earns significantly more than other occupations in the company.
There is a noticeable salary gap between this occupation and lower-paying roles.
The results indicate that specialized or high-responsibility positions command higher compensation levels.

business insight
High-paying occupations are likely critical to business operations and may require specialized skills that are difficult to replace.
The company should focus on retaining employees in these roles through competitive compensation and career development opportunities.
*/

/*Question 15:Which occupation has the lowest average salary?*/
SELECT occupation,
       AVG(salary) AS avg_salary
FROM employee_salary
GROUP BY occupation
ORDER BY avg_salary ASC
LIMIT 1;
 
 /*Findings
 The average salary for this occupation is significantly lower compared to higher-paying roles.
This occupation may consist of entry-level, administrative, or 
support positions that require less specialized training or experience.
There is a clear variation in compensation across different occupations within the organization.

Business insight
Employees in lower-paying occupations may be at a higher risk of turnover if compensation is not competitive with market rates.
HR should regularly review salaries for these roles to ensure they remain fair and aligned with industry standards.
The company can improve employee retention by providing career development opportunities and 
clear pathways for advancement into higher-paying positions.*/


/*Question 16: Who is the highest-paid employee in the company?*/
SELECT first_name,
       last_name,
       salary
FROM employee_salary
WHERE salary IN
(
    SELECT MAX(salary)
    FROM employee_salary
);

/*Findings
Chris Traeger is the highest paid employee in the company.

Business insight
The highest-paid employees may occupy leadership, management, or 
highly specialized positions that require advanced expertise and responsibility.*/

/*Question 17:Rank employees by salary from highest to lowest.*/
SELECT first_name,
       last_name,
       salary,
 RANK()OVER(ORDER BY salary DESC) AS salary_rank
 FROM employee_salary;
 
 /*Findings
 Employees were ranked by salary across the organization. 
 Multiple employees share the top rank due to having the same highest salary.
 
 Business insight
 Salary rankings help identify the highest-paid employees and reveal how compensation is distributed across the workforce.*/
 
 /*Question 18:Find the highest-paid employee in each department.*/
 SELECT first_name,
       last_name,
       salary,
       dept_id
FROM (
    SELECT first_name,
           last_name,
           salary,
           dept_id,
           RANK() OVER (
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) AS salary_rank
    FROM employee_salary
) ranked_employees
WHERE salary_rank = 1;
 
/*Findings
The analysis identified the highest-paid employee(s) in each department.
Some departments may have multiple highest-paid employees if there is a salary tie (when using RANK()).
There is variation in top salaries across departments, indicating differences in skill requirements, 
responsibilities, and market demand.

Business insight
The highest-paid employees are likely key contributors whose skills and experience are valuable to the organization.
Management should focus on retention strategies for these employees to reduce the risk of losing critical talent.
Comparing top salaries across departments can help identify potential compensation imbalances and ensure pay equity.*/

/*Question 19:Assign a unique salary position to every employee from highest salary to lowest salary.*/
SELECT first_name,
       last_name,
       salary,
ROW_NUMBER()OVER(ORDER BY salary DESC) AS salary_position
FROM employee_salary;

/*Findings
Every employee has been assigned a unique salary position based on their salary, from highest to lowest.
The employee with the highest salary is ranked first, while the employee with the lowest salary appears last.
Employees with identical salaries still receive different salary positions because ROW_NUMBER() generates unique sequential numbers.
The ranking provides a complete view of the company's salary hierarchy.

Business Insights
Management can use this ranking to identify the organization's highest-paid and lowest-paid employees.
The salary positions help HR evaluate compensation structures and identify employees whose salaries may require review.
Unique salary rankings are useful for executive reporting, compensation analysis, and workforce planning.
The ranking can support succession planning by highlighting highly compensated employees who may hold critical roles within the organization.*/

/*Question 20:Identify the first employee in each department when employees are ordered by salary from highest to lowest.*/
SELECT first_name,
       last_name,
       salary,
       dept_id
FROM (
    SELECT first_name,
           last_name,
           salary,
           dept_id,
           ROW_NUMBER() OVER (
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) AS dept_row_num
    FROM employee_salary
) ranked_employees
WHERE dept_row_num = 1;

/*Findings
The analysis identified the highest-paid employee in each department.
Exactly one employee is returned for every department because ROW_NUMBER() assigns a unique ranking.
If multiple employees have the same highest salary, only one employee is selected based on the ordering.
The results provide a quick summary of the top-paid employee across all departments.

Business Insights
The highest-paid employee in each department is often a senior specialist, manager, or department leader.
These employees may hold key responsibilities and possess valuable expertise, making retention strategies important.
Identifying top earners helps management review compensation consistency across departments.
The results can support succession planning by highlighting employees who occupy critical positions within the organization.*/


 /*Question 21:Show the top 3 employees by salary in each department.*/
 SELECT first_name,
       last_name,
       salary,
       dept_id
FROM (
    SELECT first_name,
           last_name,
           salary,
           dept_id,
           ROW_NUMBER() OVER (
               PARTITION BY dept_id
               ORDER BY salary DESC
           ) AS row_num
    FROM employee_salary
) ranked_employees
WHERE row_num <= 3;

/*Findings
The analysis identified the top three highest-paid employees in each department based on salary.
Employees were ranked independently within each department, ensuring that the highest earners were selected from every department.
The results highlight the salary distribution among the top earners and reveal differences in compensation across departments.
Exactly three employees are returned per department (provided the department has at least three employees),
 as ROW_NUMBER() assigns a unique rank to each employee.
 
Business Insights
The top three highest-paid employees are likely to hold critical positions, possess specialized expertise, or
have significant leadership responsibilities.
Comparing the top earners across departments helps management evaluate whether salary levels are aligned with 
each department's responsibilities and strategic importance.
HR can use this analysis to identify key employees for retention initiatives, succession planning, and leadership development.
Large salary differences between the highest-paid and third-highest-paid employees within a department may indicate disparities in seniority or 
role complexity and could prompt a review of compensation structures.*/

/*Question 22:Rank employees by salary within each department.*/
SELECT first_name,
       last_name,
       salary,
       dept_id,
RANK()OVER(PARTITION BY dept_id ORDER BY salary DESC) AS sal_rank     
FROM employee_salary;

/*Findings
Employees were ranked according to their salaries within each department. 
The ranking restarts for every department, allowing salary comparisons among employees in the same department.

Business Insight
Department-level salary rankings help identify top earners and salary hierarchy within each team. 
This information can support compensation benchmarking, promotion decisions, 
succession planning, and budget allocation.*/

/*Question 23:Identify the highest-paid employee(s) in each department.*/
SELECT first_name,
       last_name,
       salary,
       dept_id
FROM       
(SELECT first_name,
       last_name,
       salary,
       dept_id,
RANK()OVER(PARTITION BY dept_id ORDER BY salary DESC) AS sal_rank
FROM employee_salary) dept_sal
WHERE sal_rank =1;

/*Findings
The analysis identified the highest-paid employee(s) within each department.
Departments with multiple employees earning the same highest salary include all of those employees in the results.
The results highlight the top earners across the organization and show how salary leadership differs by department.
Using RANK() ensures that no employee is excluded when there is a tie for the highest salary.

Business Insights
The highest-paid employees are likely to occupy strategic, managerial, or 
highly specialized roles that contribute significantly to the organization's success.
Departments with multiple highest-paid employees may have several individuals performing equally valuable or senior-level responsibilities.
Identifying top earners helps HR evaluate whether compensation is aligned with job responsibilities, performance, and market standards.
The results can support succession planning, leadership development, and employee retention strategies by highlighting critical talent.
*/
       
/*Question 24:Rank employees by salary within departments without skipping rank numbers when salaries are tied. */
SELECT first_name,
       last_name,
       salary,
       dept_id,
DENSE_RANK()OVER(PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
FROM employee_salary;       

/*Findings
Employees were ranked by salary within their respective departments.
Employees with the same salary received the same rank.
Consecutive rank numbers were maintained even when salary ties occurred, providing a continuous ranking sequence.
The results make it easy to compare employee salaries within each department while treating equal salaries consistently.

Business Insights
Using DENSE_RANK() provides a fair ranking system by assigning the same position to employees who earn equal salaries.
Continuous rankings simplify salary analysis and make it easier to identify salary tiers within each department.
HR can use these rankings to evaluate compensation structures, identify groups of employees with similar pay, and support salary review decisions.
Department managers can compare salary levels among employees to assess pay equity and identify opportunities for career progression.

/*Question 25:Identify the top 3 salary levels in each department. */
WITH ranked AS (SELECT first_name,
            last_name,
            salary,
            dept_id,
DENSE_RANK()OVER(PARTITION BY dept_id ORDER BY salary DESC) AS salary_level
FROM employee_salary) 
SELECT*
FROM ranked
WHERE salary_level <=3;            

/*Findings
The analysis identified employees whose salaries fall within the top three distinct salary levels in each department.
Employees earning the same salary were assigned the same salary level, ensuring that salary ties were handled fairly.
Some departments may have more than three employees in the results 
because multiple employees can share one of the top three salary levels.
The results provide a clear view of the highest-paying salary bands within each department.

Business Insights
Identifying the top salary levels helps management understand how compensation is 
distributed among the highest-paid employees within each department.
Employees in the highest salary levels are often experienced professionals, specialists, or 
leaders whose knowledge and skills are critical to the organization's success.
The analysis can support compensation reviews by highlighting whether salary structures are consistent across departments.
*/
           
/*Question 26:How many employees fall into each salary rank across the company? */
SELECT salary_rank,
      COUNT(*) AS employee_count
FROM(SELECT first_name,
       last_name,
       salary,
DENSE_RANK()OVER(ORDER BY salary DESC) AS salary_rank
FROM employee_salary) ranked
GROUP BY salary_rank
ORDER BY salary_rank;

/*Finding
The analysis counted the number of employees in each salary rank across the company.
Employees with the same salary were grouped into the same salary rank using DENSE_RANK().
The results show how employees are distributed across different salary levels.
Some salary ranks may contain multiple employees due to shared salary values.

Business Insights
Salary ranks with many employees may indicate common pay bands or 
standardized compensation levels within the organization.
Salary ranks with very few employees, especially the highest ranks, 
may represent senior leadership or highly specialized roles.
HR can use this analysis to understand the distribution of salaries and 
identify whether employees are concentrated in particular salary tiers.
*/
/*Question 27:Compare each employee's salary to the salary of the employee immediately below them in the salary ranking.*/
SELECT first_name,
       last_name,
       salary,
LEAD(salary)OVER(ORDER BY salary DESC) AS next_salary
FROM employee_salary;       

/*Findings
The analysis compares each employee's salary with the salary of the employee 
immediately below them in the company-wide salary ranking.
The results show the progression of salaries from the highest-paid employee to the lowest-paid employee.
The employee with the lowest salary has no employee below them, so the comparison value is NULL.
The comparison highlights the difference in pay between consecutive employees in the salary ranking.

Business Insights
Comparing consecutive salaries helps identify where significant pay gaps exist 
within the organization's compensation structure.
HR can use this analysis to assess whether salary progression between employees is consistent and 
aligned with experience, responsibilities, or job level.
Large differences between consecutive salaries may indicate promotions, 
leadership positions, or specialized roles that command higher compensation.
The results support salary benchmarking, compensation reviews, and workforce planning by 
providing a clear picture of salary progression across the organization. 
*/      

/*Question 28:Calculate the salary gap required for an employee to reach the next salary level.*/
SELECT first_name,
       last_name,
       salary,
LEAD(salary) OVER (
    ORDER BY salary DESC
) AS next_salary,

salary - LEAD(salary) OVER (
    ORDER BY salary DESC
) AS salary_gap
FROM employee_salary;

/*Findings
The analysis calculates the salary difference each employee must make up to reach the next higher salary level.
Employees are compared against the employee immediately above them in the salary ranking.
The highest-paid employee has no higher salary level to compare against, so the salary gap is NULL.
The results highlight the progression between consecutive salary levels across the company.

Business Insights
The salary gap shows how far each employee is from the next compensation level, providing insight into salary progression.
HR can use this information to evaluate promotion readiness and plan salary adjustments.
Large salary gaps may indicate differences in job level, responsibility, or specialized expertise that justify higher compensation.*/

/*Question 29:What is the average salary for each gender, and how can it be used to evaluate compensation patterns across the organization?*/
SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(partition by gender)
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
    ON dem.employee_id = sal.employee_id;
 
 /*Findings
The analysis calculated the average salary for each gender while displaying every employee's individual salary.
All employees of the same gender share the same average salary value, making it easy to compare individual salaries against their gender's average.
Some employees earn above their gender's average salary, while others earn below it.
The query provides a clear view of salary distribution without losing individual employee records.

Business Insights
HR can use this analysis to evaluate compensation patterns between genders and identify employees who earn significantly above or below their gender's average salary.
Comparing individual salaries to the gender average helps support pay equity reviews and identify potential inconsistencies in compensation.
Managers can use these insights during salary reviews to determine whether employee pay is aligned with organizational compensation practices.

/*Question 30:What is the cumulative payroll cost for male and female employees as the organization progresses through its employee records?*/

SELECT dem.first_name, dem.last_name, gender, salary, 
SUM(salary) OVER(partition by gender ORDER BY dem.employee_id) AS rolling_total
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
    ON dem.employee_id = sal.employee_id;
    
/* Findings
The analysis calculates a running total of salaries separately for each gender.
As each employee is processed (ordered by employee_id), their salary is added to the cumulative payroll for their gender.
The running total increases with each additional employee, showing how payroll costs accumulate over time within each gender group.
The final running total for each gender represents the total salary expenditure for that gender.

Business Insights
The running total helps HR and finance monitor how payroll expenses accumulate within each gender group.
Finance teams can use this analysis to understand payroll growth and support budgeting and workforce cost planning.
Comparing cumulative payroll trends between genders can provide additional context during workforce and compensation analyses.
The results can also be useful for forecasting salary expenses as new employees are hired or existing salaries change.   */

/*Question 31:Who are the highest-paid employees within each gender, and how do salary rankings differ when ties occur?*/

SELECT dem.employee_id,dem.first_name, dem.last_name, gender, salary, 
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK () OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM parks_and_recreation.employee_demographics AS dem
JOIN parks_and_recreation.employee_salary AS sal
    ON dem.employee_id = sal.employee_id;
    
/*Findings
The analysis ranks employees by salary separately for male and female employees.
ROW_NUMBER() assigns a unique position to every employee, even when salaries are the same.
RANK() assigns the same rank to employees with equal salaries but skips the next rank number.
DENSE_RANK() also assigns the same rank to tied salaries but does not skip rank numbers.
The results provide three different ranking methods, allowing comparison of how salary ties are handled.

Business Insights
The rankings help HR identify the highest-paid employees within each gender for compensation and talent management purposes.
Comparing ROW_NUMBER(), RANK(), and DENSE_RANK() demonstrates how different ranking methods can affect reporting and business decisions when salary ties exist.
ROW_NUMBER() is useful when a unique ordering of employees is required, such as selecting one top employee.
RANK() is appropriate when all employees sharing the same salary should receive the same position, even if this creates gaps in the ranking.
DENSE_RANK() is ideal for identifying salary levels because it groups equal salaries together without leaving gaps in the ranking sequence.*/


/*# Conclusion
This HR Analytics project demonstrates the use of SQL to transform raw employee data into meaningful business insights. Throughout the analysis, 
I applied a range of SQL concepts, including filtering, joins, aggregations, subqueries, CASE statements, window functions, and Common Table Expressions (CTEs),
to answer real-world HR business questions.
The analysis provided insights into workforce composition, salary distribution, departmental payroll, employee rankings, and compensation patterns. 
These findings illustrate how SQL can support data-driven decision-making in areas such as workforce planning, salary benchmarking, budgeting, and performance management.
Completing this project strengthened my ability to write efficient SQL queries, analyze business problems, and communicate findings in a clear and structured way. 
It also reinforced the importance of translating technical analysis into actionable business insights, a key responsibility of a data analyst.
This project represents an important step in my journey toward becoming a data analyst, and I look forward to expanding my portfolio with more advanced SQL,
data visualization, and business analytics projects.*/
