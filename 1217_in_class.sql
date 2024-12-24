/*
1.建立測試用表格
2.使用cursor for loop 更新部門100 下的員工，薪水加500;
3.commit 交易
4.使用select查詢結果
*/
set SERVEROUTPUT on
exec DBMS_OUTPUT.PUT_LINE('original data');
create table emp as select * from employees;
select * from emp where department_id = 100;

DECLARE
CURSOR emp_cur(p_dept_id number) IS
    select * from emp
    WHERE department_id = p_dept_id
    for update of salary;
BEGIN
    for l_emp_rec in emp_cur(100) loop 
        update emp
        set salary = salary + 500
        where current of emp_cur;
    end loop;
    commit;
    DBMS_OUTPUT.PUT_LINE('Update Done');
end;
/
SELECT * FROM emp WHERE department_id = 100;
DROP TABLE emp;