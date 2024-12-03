set serveroutput on
DECLARE
   
   TYPE emp_record_type IS RECORD (
      emp_id employees.employee_id%TYPE,
      first_name employees.first_name%TYPE,
      last_name employees.last_name%TYPE,
      dept_name departments.department_name%TYPE,
      salary employees.salary%TYPE
   );
   emp_record emp_record_type;
BEGIN
   
   SELECT e.employee_id, e.first_name, e.last_name, d.department_name, e.salary
   INTO emp_record
   FROM employees e
   JOIN departments d
   ON e.department_id = d.department_id
   WHERE e.employee_id = 124;

   DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_record.emp_id);
   DBMS_OUTPUT.PUT_LINE('First Name: ' || emp_record.first_name);
   DBMS_OUTPUT.PUT_LINE('Salary: ' || emp_record.salary);
END;
