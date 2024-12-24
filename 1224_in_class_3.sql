CREATE OR REPLACE PROCEDURE find_avg_salary_from_dept_job
(p_dept_id employees.department_id%type,
p_job_id employees.job_id%type) AS
    l_avg_salary number;
BEGIN
    
    select avg(salary) into l_avg_salary 
    from employees
    where department_id = p_dept_id and job_id = p_job_id;

    dbms_output.put_line('avg_salary: '||round(l_avg_salary,4));
END;