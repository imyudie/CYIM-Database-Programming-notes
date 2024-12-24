DECLARE
  l_val NUMBER;
BEGIN
  l_val := 1 / 0;
EXCEPTION
  
  WHEN OTHERS THEN
    
    DBMS_OUTPUT.PUT_LINE('Error code: ' || SQLCODE);
    DBMS_OUTPUT.PUT_LINE('Error msg: ' || SQLERRM);
END;
/