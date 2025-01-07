DECLARE
    a NUMBER := 2;
BEGIN
    dbms_output.put_line('1');
    a := 1/1;
    BEGIN
        dbms_output.put_line('2');
        a := 1/0;
        dbms_output.put_line('3');
    end;
    dbms_output.put_line('4');
exception
    when others then
        dbms_output.put_line('5');
END;