set serveroutput on;
declare
    cursor emp_cursor is 
        select first_name, salary 
        from employees
        where department_id = 60;
    l_new_salary employees.salary%type;
    l_count number := 0;
BEGIN
    for row in emp_cursor loop
        l_new_salary := row.salary * 1.1;
        dbms_output.put_line(row.first_name || ' Old Salary: ' || row.salary || ' New Salary: ' || l_new_salary);
        l_count := l_count + 1;
    end loop;
    dbms_output.put_line('Fetch lines: ' || l_count);
end;
/
