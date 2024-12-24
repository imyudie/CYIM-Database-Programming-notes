declare
    e_insert_error exception;
    pragma exception_init(e_insert_error, -01400);
BEGIN
  INSERT INTO DEPARTMENTS
    (DEPARTMENT_ID, DEPARTMENT_NAME) 
    VALUES     (280, NULL );
EXCEPTION
    when e_insert_error then
        dbms_output.put_line('Insert error: ' || sqlerrm);
end;
/