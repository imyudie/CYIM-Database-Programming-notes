/*
可直接執行:
    Query: SELECT
    DML: INSERT (values, subquery), UPDATE, DELETE, Merge
    交易控制: commit, rollback, savepoint

不可直接執行(只可透過套件):
    DDL: CREATE, ALTER, DROP
    
SQl/PL 比較像自然語言。

*/
set SERVEROUTPUT on
DECLARE
  l_salary employees.salary%TYPE;
BEGIN
   
    SELECT salary into l_salary from employees where employee_id = 100;
    l_salary := l_salary * 1.1;
    DBMS_OUTPUT.PUT_LINE(l_salary);
    /* 子句
    1.取出欄位清單 e.g. SELECT
    2.賦予區域變數清單 e.g. into
    3.指定欄位資料來源 e.g. from
    4.篩選/過濾 e.g. where
    5.排序 e.g. order by
    6.分群 e.g. group by
    7.分群後篩選 e.g. having

    那些子句可以放區域變數?
    1.into必定要放區域變數
    2.where 可以去比較PL/SQL的結果 e.g. where emp_id = l_avg
    */
END;
/
--以下為課堂練習
-- 印出員工100號的工作部門名稱
-- 1.Query -> 找出100號的dept_name
-- 2.把Query的結果放到Block, 加上into子句
DECLARE
    l_dept_name departments.department_name%TYPE;
BEGIN
    SELECT DEPARTMENT_NAME into l_dept_name 
    from EMPLOYEES  e, DEPARTMENTS d
    where e.department_id = d.department_id
    and e.employee_id = 100;  
    DBMS_OUTPUT.PUT_LINE(l_dept_name);
END;
/
--teacher_example
SELECT department_name
FROM EMPLOYEES e join DEPARTMENTS
using(department_id) -- using內不可使用修飾別名
WHERE e.employee_id = 100;
--此方法可以精簡SQL語法，大多使用再已正規畫的資料表
set serveroutput on
DECLARE
    l_dept_name departments.DEPARTMENT_NAME%TYPE;
BEGIN
    SELECT department_name into l_dept_name 
    FROM EMPLOYEES e join DEPARTMENTS
    using(department_id) -- using內不可使用修飾別名
    WHERE e.employee_id = 100;
    DBMS_OUTPUT.PUT_LINE(l_dept_name);
END;