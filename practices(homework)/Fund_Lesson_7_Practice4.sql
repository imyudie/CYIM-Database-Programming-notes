DECLARE
  TYPE dept_record_type IS RECORD (
    dept_id   departments.department_id%TYPE,
    dept_name departments.department_name%TYPE
  );

  TYPE dept_table_type IS TABLE OF dept_record_type INDEX BY BINARY_INTEGER;
  l_dept_uk_tab dept_table_type;

  v_index INTEGER := 1; 

BEGIN

  SELECT department_id, department_name
  BULK COLLECT INTO l_dept_uk_tab
  FROM departments
  WHERE location_id IN (
    SELECT location_id 
    FROM locations 
    WHERE country_id = 'UK'
  );


  WHILE v_index <= l_dept_uk_tab.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Department ID: ' || l_dept_uk_tab(v_index).dept_id ||' | Department Name: ' || l_dept_uk_tab(v_index).dept_name);
    v_index := v_index + 1;  
  END LOOP;

END;
/
