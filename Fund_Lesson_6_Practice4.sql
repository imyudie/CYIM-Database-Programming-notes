create table A_EMP(employee_id NUMBER(6,0) PRIMARY KEY, salary number(8,2));
create table B_EMP(employee_id NUMBER(6,0) PRIMARY KEY, salary number(8,2));

DECLARE
    max_id employees.employee_id%type;
    min_id employees.employee_id%type;
    emp_salary employees.salary%type;
BEGIN
    select min(employee_id) into min_id from employees;
    select max(employee_id) into max_id from employees;

    for emp_id in min_id .. max_id loop
        select salary into emp_salary from employees where employee_id = emp_id;
        if emp_salary >= 10000 then
            insert into A_EMP (employee_id, salary) values (emp_id, emp_salary);
        elsif emp_salary <= 2500 then
            insert into B_EMP (employee_id, salary) values (emp_id, emp_salary);
        else 
            DBMS_OUTPUT.PUT_LINE('id = '||emp_id||' and salary = '||emp_salary||'不符合');
        end if;
    end loop;
end;
/
SELECT * FROM A_EMP;
SELECT * FROM B_EMP;