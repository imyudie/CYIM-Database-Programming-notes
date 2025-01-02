set serveroutput on
DECLARE
    
    cursor emp_cursor IS
        SELECT employee_id, salary
        FROM employees
        where department_id = 100
        ORDER BY salary DESC;
        
BEGIN
    DBMS_OUTPUT.PUT_LINE('部門 100 的員工:');
    for emp_record IN emp_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_record.employee_id || 
                             ' | Salary: ' || emp_record.salary);
    END LOOP;
end;
/
