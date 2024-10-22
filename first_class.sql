--命令稿
select * from employees;
set serveroutput on ;
--SET 是下指令給資料庫，上面這段是代表開啟輸出
DECLARE
    --宣告
    l_name list(100) := 'John';
BEGIN
    --可執行敘述
    select FIRST_NAME into l_name from employees
    where EMPLOYEE_ID = 100;
    --SQL context 
    DBMS_OUTPUT.PUT_LINE(l_name || '你好'); --PL Engine context
    --寫在資料庫的Butter，要讓devp知道要下一個指令
--EXCEPTION //例外執行區段 
END;
/
--此斜線分割區塊

--1 == null -> F
--0 == null -> F
-- null == null -> F
--Assignment 2
set serveroutput on ;
DECLARE
    l_max_salary NUMBER not null := 0; --有not null 一定要初始化
    -- l_max_salary constant NUMBER not null := 0; -- 變為常數(無法變動)
    l_fname employees.FIRST_NAME%TYPE;  --綁定型態與表格一樣，若變數資料來自表個欄位此法妙 
    --l_fname varchar2(1000);
    l_dept_name departments.department_name%TYPE; 
    --l_dept_name varchar2(1000);
BEGIN
    select max(salary) into l_max_salary from employees; --從employees搜尋薪水最大的值給l_max_salary
    select first_name, department_name --搜尋
    into l_fname, l_dept_name --賦予變數
    From employees e join departments d --從哪裡來，並用哪個名字代替
    using (department_id) --綁定哪個表格
    WHERE ROWNUM = 1 and e.salary = l_max_salary; --回傳一行，並規定薪水等於最大的
    DBMS_OUTPUT.PUT_LINE( 'first name: '||l_fname||', department name: '||l_dept_name||', salary: '||l_max_salary); --用||串接字串
END;
/
--Assignment 1
set serveroutput on
DECLARE
    l_name employees.LAST_NAME%TYPE;
    f_name employees.FIRST_NAME%TYPE;
BEGIN
    select first_name, last_name
    into f_name, l_name
    from employees e
    where e.employee_id = 110;
    DBMS_OUTPUT.PUT_LINE('The full name is: '||l_name||','||f_name);
END;
/
VARIABLE b_dept_id number --指派全域變數，指令不需要分號
DECLARE
    
BEGIN --以下為PL/SQL
    :b_dept_id := 200; -- 使用外部宣告的綁定變數，前方要加冒號
END;
--以下為SQL
select * from employees
WHERE department_id = :b_dept_id;