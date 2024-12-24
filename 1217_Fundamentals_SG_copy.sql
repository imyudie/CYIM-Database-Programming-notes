set SERVEROUTPUT on
DECLARE
cursor emp_cur(p_dep_id number) IS
    select * from employees
    where department_id = p_dep_id
    for UPDATE of salary;--lock整列或者特定欄位

BEGIN
    for emp_rec in emp_cur(80) LOOP
        --DBMS_OUTPUT.PUT_LINE(emp_rec.salary);
        break; -- 保險 避免執行更新到我的DB
        update EMPLOYEES
            set SALARY = salary * 1.1
            --where emp_rec.salary = emp_rec.salary; --太low了
            where current of emp_rec;
    end loop;

END;
/

/*
--select
-single row
    select into _純量_ --number ,varchar2...
-multi rows
    1.select bulk collet into collection || index-by ||  table 
    2.cursor for loop [record]
    


*/