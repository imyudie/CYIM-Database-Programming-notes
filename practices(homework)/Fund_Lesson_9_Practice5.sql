SET serveroutput ON
declare 
    v_value number;
BEGIN
  
    dbms_output.put_line('Mark-1'); -- ##2 
    DECLARE
        E_NOT_VALID EXCEPTION;
        PRAGMA EXCEPTION_INIT(E_NOT_VALID, -06502);
    -- #1 The line below throw the VALUE_ERROR  exception (ORA-06502) 
    BEGIN
        v_value := to_number('AA0');
    EXCEPTION
        WHEN E_NOT_VALID THEN
            dbms_output.put_line('AA0 is not a valid number.');
    END;  

  dbms_output.put_line('Mark-2');  -- #3

END;