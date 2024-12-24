DECLARE
    l_salary employees.salary%TYPE;
BEGIN
    select salary into l_salary from employees;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found');
    WHEN TOO_MANY_ROWS THEN 
        DBMS_OUTPUT.PUT_LINE('Too many rows');
END;
/
/*
拋出自訂例外名稱
情境:update時發現未更新任何rows，回報例外 --商業邏輯錯誤
*/
DECLARE
    e_no_updated EXCEPTION;
BEGIN
    UPDATE employees
    SET salary = salary + 1000
    WHERE employee_id = 9999;
    
    IF SQL%notfound THEN
        RAISE e_no_updated;
    END IF;
EXCEPTION
    WHEN e_no_updated THEN
        DBMS_OUTPUT.PUT_LINE('No rows updated');
END;
/