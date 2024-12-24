CREATE OR REPLACE PROCEDURE find_max_salary AS
    l_max_salary number;
BEGIN
    select max(salary) into l_max_salary from employees;
    dbms_output.put_line('max_salary: '||l_max_salary);
END;
/
exec find_max_salary();
/
DROP PROCEDURE find_max_salary;