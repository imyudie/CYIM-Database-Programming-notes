set SERVEROUTPUT on;
DECLARE
    emp_id employees.employee_id%type := 206;
    emp_salary employees.salary%type;
    emp_level varchar2(10);
BEGIN
    select salary into emp_salary from employees where employee_id = emp_id;
    if emp_salary <= 9400 THEN
        emp_level := 'C';
    elsif emp_salary <= 16700 THEN
        emp_level := 'B';
    else 
        emp_level := 'A';
    end if;
    DBMS_OUTPUT.PUT_LINE('Employee ID#'||emp_id||'. Salary: '||emp_salary||'.Salary code: '||emp_level);

end;