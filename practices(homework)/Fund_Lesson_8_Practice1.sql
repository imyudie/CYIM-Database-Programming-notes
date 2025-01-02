set serveroutput on;
declare
    cursor emp_cursor is 
        select first_name, salary 
        from employees
        where department_id = 60;
    l_first_name employees.first_name%type;
    l_original_salary employees.salary%type;
    l_new_salary employees.salary%type;
BEGIN
    OPEN emp_cursor;
    loop
        fetch emp_cursor into l_first_name,l_original_salary;
        --fetch後游標的內部指標自動移動到下一行，為下一次提取做準備
        exit when emp_cursor%notfound;
        l_new_salary := l_original_salary * 1.1;
        dbms_output.put_line(l_first_name || ' Old Salary: ' || l_original_salary || ' New Salary: ' || l_new_salary);
    end loop;
    --dbms_output.put_line('Fetch lines: ' || emp_cursor%rowcount);
    close emp_cursor;
end;
/

