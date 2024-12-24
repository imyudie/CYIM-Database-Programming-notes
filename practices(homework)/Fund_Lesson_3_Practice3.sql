set SERVEROUTPUT on
DECLARE
    v_dept_name DEPARTMENTS.DEPARTMENT_NAME%type;
BEGIN
    select department_name
    into v_dept_name
    from employees e join departments d
    using (department_id)
    where e.employee_id = 200;
    DBMS_OUTPUT.PUT_LINE(v_dept_name);
END;
/
/*
PL內部不可執行:
    decode
    group function
group func -- 多列函數，多行輸入一行輸出，不可在群函數內執行
單列func -- one in one out
*/
set serveroutput on
DECLARE
    l_avg_salary NUMBER;
BEGIN
    select avg(salary)
    into l_avg_salary 
    from employees
    where department_id  = 100;
    l_avg_salary := round(l_avg_salary,2);
    DBMS_OUTPUT.PUT_LINE('平均薪水: '||l_avg_salary);
END;