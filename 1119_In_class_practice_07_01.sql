set serveroutput on
DECLARE
   TYPE emp_record_type IS RECORD (
      fname     employees.first_name%TYPE, 
      lname     employees.last_name%TYPE,
      hire_date employees.hire_date%TYPE,
      salary    employees.salary%TYPE
   );
   emp_record emp_record_type;

BEGIN

   SELECT first_name, last_name, hire_date, salary
   INTO emp_record
   FROM employees
   WHERE employee_id = 100;


   DBMS_OUTPUT.PUT_LINE('First Name: ' || emp_record.fname);
   DBMS_OUTPUT.PUT_LINE('Last Name: ' || emp_record.lname);
   DBMS_OUTPUT.PUT_LINE('Hire Date: ' || TO_CHAR(emp_record.hire_date, 'DD-MON-YYYY'));
   DBMS_OUTPUT.PUT_LINE('Salary: ' || emp_record.salary);

END;
/