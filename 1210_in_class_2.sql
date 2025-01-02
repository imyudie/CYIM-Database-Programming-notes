set serveroutput on
DECLARE
    
    cursor emp_cursor(p_department_id NUMBER) IS
        SELECT employee_id, salary
        FROM employees
        where department_id = p_department_id
        ORDER BY salary DESC;
        
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('部門 80 的員工:');
    for emp_record IN emp_cursor(80) LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_record.employee_id || 
                             ' | Salary: ' || emp_record.salary);
    END LOOP;

    
    DBMS_OUTPUT.PUT_LINE('部門 100 的員工:');
    for emp_record IN emp_cursor(100) LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_record.employee_id || 
                             ' | Salary: ' || emp_record.salary);
    END LOOP;
end;
/
