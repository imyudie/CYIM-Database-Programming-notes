create table updated_bonus (emp_id number(4), bonus number(4));
create table MASTER (emp_id number(4), bonus number(4));
INSERT INTO updated_bonus (emp_id, bonus) VALUES (1000 , 10);
INSERT INTO updated_bonus (emp_id, bonus) VALUES (1002 , 20);
INSERT INTO updated_bonus (emp_id, bonus) VALUES (1004 , null);
--INSERT INTO MASTER (emp_id, bonus) VALUES (1000 , 5);
INSERT INTO MASTER (emp_id, bonus) VALUES (1000 , 5);
INSERT INTO MASTER (emp_id, bonus) VALUES (1004 , 15);

COMMIT;
select * from MASTER;
select * from updated_bonus;

set SERVEROUTPUT on
BEGIN
    MERGE INTO MASTER m
    USING updated_bonus u ON (m.emp_id = u.emp_id)
    WHEN MATCHED THEN
        UPDATE SET m.bonus = u.bonus
        DELETE WHERE m.bonus IS NULL
    WHEN NOT MATCHED THEN
        INSERT (emp_id, bonus) VALUES (u.emp_id, u.bonus);
    DBMS_OUTPUT.PUT_LINE(sql%rowcount);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(sql%rowcount);
    
end;
/
select * from MASTER;

DROP table updated_bonus;
DROP table MASTER;
