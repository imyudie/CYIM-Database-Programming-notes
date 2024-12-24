DECLARE
  TYPE emp_table_type IS TABLE OF employees%ROWTYPE INDEX BY BINARY_INTEGER;
  v_emp_table emp_table_type;

  v_avg_salary employees.salary%type;
  v_index INTEGER := 0;
BEGIN

  select avg(salary)
  into v_avg_salary
  from employees
  WHERE employee_id BETWEEN 100 AND 200;

  DBMS_OUTPUT.PUT_LINE('平均薪資: ' || v_avg_salary);


  for emp_rec in (
    SELECT * 
    FROM employees
    WHERE employee_id BETWEEN 100 AND 200
    AND salary < v_avg_salary
  ) LOOP
    v_index := v_index + 1;
    v_emp_table(v_index) := emp_rec; 
  END LOOP;


  v_index := v_emp_table.first; 
  WHILE v_index IS NOT NULL loop
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_emp_table(v_index).employee_id ||
                         ' | Salary: ' || v_emp_table(v_index).salary);
    v_index := v_emp_table.NEXT(v_index); 
  END LOOP;

END;
/
