DECLARE
    e_insert_excep EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_insert_excep, -01400);
BEGIN
    INSERT into departments
    (department_id, department_name) VALUES (280,null);
EXCEPTION
    WHEN e_insert_excep THEN
        DBMS_OUTPUT.PUT_LINE('Insert operation failed');
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/