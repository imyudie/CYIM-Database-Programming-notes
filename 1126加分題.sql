/*
抓部門ID200的所有員工的欄位置到一個index by table1 變數中
資料來源:employees
*/
DECLARE
    type emp_tab_type is table of employees%rowtype
    index by PLS_INTEGER;
    emp_tab emp_tab_type;
BEGIN
    SELECT * bulk COLLECT into emp_tab from employees;
    FOR i IN 1..emp_tab.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(emp_tab(i).employee_id || ' ' || emp_tab(i).first_name || ' ' || emp_tab(i).last_name);
    END LOOP;
END;
/