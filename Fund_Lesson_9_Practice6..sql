set serveroutput on
DECLARE
    -- Define required variables
    v_country_id varchar2 (20) := 'TW';
    v_name VARCHAR2(20) := 'Taichung';
    E_INVALID_LOCATION EXCEPTION;
BEGIN
    -- update the department
    UPDATE locations
    SET city = v_name
    where country_id = v_country_id;
    if sql%rowcount = 0 then
        RAISE E_INVALID_LOCATION;
    end if;
    DBMS_OUTPUT.put_line('Updated rows: ' || sql%rowcount);
EXCEPTION
    WHEN E_INVALID_LOCATION THEN
        DBMS_OUTPUT.put_line('No such country ID: '||v_country_id||' exists.');
END;
/