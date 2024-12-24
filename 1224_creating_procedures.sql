/*
subprogram => 子程序 : 減少重複code
特性:
 -有名字
 -saved in DB, only compile once
Create or replace Procedure
Table 不可 replace
1) procedure not has any return values
2) function has return values
*/
--exec find_max_salary;
--exec fing_max_salary_from_departments(100);
exec find_avg_salary_from_dept_job(100, 'FI_MGR');