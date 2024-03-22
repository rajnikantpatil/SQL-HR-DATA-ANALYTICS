-- HR Analytics Project --
/* Queries:
1.	Write a query to find the number of observations in the table
2.	Write a query to find the count of employees by gender.
3.	Write a query to find the count of male and female employees by department.
4.	Write a query to find the count of the employees by blood group.
5.	Write a query to find the average satisfaction level by department.
6.	Write a query to find the average number of projects by department.
7.  Write a query to find the most tenured employees in the company.
8.	Write a query to find the count of employees who were promoted in the last five years by department and gender.
9.	Write a query to find the count of employees by city.
10.	Write a query to categorize salaries based on salary ranges.
11.	Write a query to find the percentage of employees with high salaries in the company.
*/


-- Create the Database:
create database Project; 
use  Project;

-- Query 1:
select * from hr_data;

-- Query 2:
select Gender,count(Employee_Name) from hr_data 
group by 1
order by 2;

-- Query 3:
select Department,count(Employee_Name) from hr_data 
group by 1
order by 2;

-- Query 4:
select Blood_Group,count(Employee_Name) from hr_data 
group by 1
order by 2;

-- Query 5:
select Department, avg(Satisfaction_level) from hr_data 
group by 1
order by 2;

-- Query 6:
select Department, avg(Number_Project) from hr_data 
group by 1
order by 2;

-- Change the column name for query 7:
ALTER TABLE hr_data
CHANGE COLUMN `Time_Spend_Company(years)` Time_Spend_Company INT;

-- Query 7: (Last 5 most tenured employees with their names and departments) 
select  Employee_Name,Time_Spend_Company, Department from hr_data
order by Time_Spend_Company desc
limit 5;

-- Query 8:
select Department,Gender, sum(Promotion_Last_5Years) as Promoted_Employees from hr_data
group by 1,2
order by 1;

-- Query 9:
select count(Employee_Name), city from hr_data
group by 2;

select Birth_Date from hr_data;
set sql_safe_updates=0;
update hr_data set Birth_Date=str_to_date(Birth_Date, 'dd/mm/yyyy');
alter table hr_data modify Birth_Date date;
SELECT * FROM hr_data
WHERE datediff(adddate(birth_date, interval 60 year), now()) between 0 AND 7;

-- Query 10
alter table hr_data add Salary_Cat varchar(30); 
update hr_data set Salary_Cat=
case
when Salary between 35000 and 50000 then 'High'
when salary between 20000 and 34999 then 'Medium'
else  'Low'
end;


-- Query 11:
set @counts =0;
select count(*) into @counts from hr_data;
select Salary,concat(cast(round(count(*)/@counts*100) as char),'%') from hr_data
group by 1;

