set SERVEROUTPUT on
<<here>>
declare
    a NUMBER := 10;
    class VARCHAR2(10);
BEGIN
    WHILE a > 0 LOOP
        DBMS_OUTPUT.PUT_LINE(a);
        a := a - 1;
    end loop;

end;
/