/*
撰寫一個匿名 PL/SQL 區塊來將 emp_salary_2 表格的資料合併到 emp_salary_1 表格中。

當合併兩個表格時，emp_salary_1.NEW_SALARY 欄位的值應該更新為 emp_salary_2.salary * 1.2。
在合併完成後，輸出更新的資料列數。
(Hint: 使用 MERGE 語句和 SQL 游標屬性)
*/
create table emp_salary_1 as
select e.employee_id, e.first_name, e.salary , 0 as NEW_SALARY
from employees e
where rownum <2;

create table emp_salary_2 as
select e.employee_id, e.first_name, e.salary 
from employees e
where rownum <3;

select tname from tab where tname like 'EMP_SALARY%';
SELECT * FROM emp_salary_1;
SELECT * FROM emp_salary_2;
set serveroutput on
DECLARE
  v_count NUMBER;
BEGIN
    MERGE INTO emp_salary_1 e1
    USING emp_salary_2 e2
    ON (e1.employee_id = e2.employee_id)
    WHEN MATCHED THEN
        UPDATE SET e1.new_salary = e2.salary * 1.2
    WHEN NOT MATCHED THEN
        INSERT (employee_id, first_name, salary, new_salary)
        VALUES (e2.employee_id, e2.first_name, e2.salary, e2.salary * 1.2);
        
    v_count := SQL%ROWCOUNT;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Rows updated: ' || v_count);
END;
/
select * from emp_salary_1;
drop table emp_salary_1;
drop table emp_salary_2;