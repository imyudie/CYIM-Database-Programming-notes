CREATE OR REPLACE PROCEDURE print_max_salary
(p_dept_id employees.department_id%type := Null,
p_job_id employees.job_id%type default null) AS
    l_max_salary number;
BEGIN
    
    select max(salary) into l_max_salary 
    from employees
    where department_id = nvl(p_dept_id,department_id) 
    and job_id = nvl(p_job_id,job_id);

    dbms_output.put_line('max_salary: '||round(l_max_salary,4));
END;
/

exec print_max_salary(); 
exec print_max_salary(p_dept_id => 60);
exec print_max_salary(p_job_id => 'IT_PROG');
exec print_max_salary(p_dept_id => 60, p_job_id => 'IT_PROG');