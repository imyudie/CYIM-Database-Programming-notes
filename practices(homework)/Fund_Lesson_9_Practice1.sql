SET serveroutput ON
DECLARE
  v_emp employees%rowtype;
BEGIN
  SELECT * INTO v_emp FROM employees e WHERE e.department_id = 99;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
    DBMS_OUTPUT.PUT_LINE('Error message: ' || SQLERRM);
END;
/