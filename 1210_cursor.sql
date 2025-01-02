declare 
    cursor emp_cursor is 
        select employee_id, first_name, last_name 
        from employees;

    l_emp_id employees.employee_id%type;
    l_first_name employees.first_name%type;
    l_last_name employees.last_name%type;
BEGIN
    open emp_cursor;
    loop
        fetch emp_cursor into l_emp_id, l_first_name, l_last_name;
        /*FETCH 操作必須與游標返回的列數和類型對應。*/
        exit when emp_cursor%notfound;
        dbms_output.put_line(l_emp_id || ' ' || l_first_name || ' ' || l_last_name);
    end loop;
    close emp_cursor;
end;
/
DECLARE
  CURSOR emp_cursor IS
    SELECT employee_id, salary FROM emp FOR UPDATE;
  v_employee_id emp.employee_id%TYPE;
  v_salary emp.salary%TYPE;
BEGIN
  OPEN emp_cursor;
  LOOP
    FETCH emp_cursor INTO v_employee_id, v_salary;
    EXIT WHEN emp_cursor%NOTFOUND;
    UPDATE emp
    SET salary = v_salary * 1.1
    WHERE CURRENT OF emp_cursor; -- 更新當前游標指向的資料列
  END LOOP;
  COMMIT;
  CLOSE emp_cursor;
END;
/*
游標必須加上 FOR UPDATE 才能使用 WHERE CURRENT OF。
確保游標在 CLOSE 前未退出迴圈，避免未釋放資源。
*/
/
DECLARE
  CURSOR emp_cursor IS
    SELECT employee_id, first_name, last_name FROM employees;
  emp_record emp_cursor%ROWTYPE; -- 定義 RECORD 型別變數
BEGIN
  OPEN emp_cursor;
  LOOP
    FETCH emp_cursor INTO emp_record;
    EXIT WHEN emp_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || emp_record.employee_id || ', Name: ' || emp_record.first_name || ' ' || emp_record.last_name);
  END LOOP;
  CLOSE emp_cursor;
END;
/*RECORD 型別變數的結構必須與游標查詢的結構一致。*/
/
BEGIN
  FOR emp_record IN (SELECT employee_id, first_name, last_name FROM employees) LOOP
    DBMS_OUTPUT.PUT_LINE('ID: ' || emp_record.employee_id || ', Name: ' || emp_record.first_name || ' ' || emp_record.last_name);
  END LOOP;
END;
/*不需要明確開啟或關閉游標，FOR-LOOP 會自動完成。*/
/
BEGIN
  FOR emp_record IN (SELECT employee_id, salary FROM employees FOR UPDATE) LOOP
    UPDATE employees
    SET salary = emp_record.salary * 1.1
    WHERE employee_id = emp_record.employee_id;
  END LOOP;
END;
/