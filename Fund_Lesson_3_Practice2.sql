VARIABLE b_empolyee_id number
VARIABLE b_new_salary number
set serveroutput on
exec :b_empolyee_id := 104;
BEGIN
    
    select salary
    into :b_new_salary 
    from employees 
    where employee_id = :b_empolyee_id;
    DBMS_OUTPUT.PUT_LINE('b_empolyee_id : '||:b_empolyee_id);
    DBMS_OUTPUT.PUT_LINE('b_new_salary : '||:b_new_salary*1.1);
END;