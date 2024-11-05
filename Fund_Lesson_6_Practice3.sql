DROP TABLE messages;
CREATE TABLE messages (results VARCHAR2(80));
begin 
    for i in 1..10 loop
        CONTINUE WHEN i = 6 or i = 8;
        INSERT INTO messages (results) VALUES (i);
    end loop;
end;
/
SELECT * FROM messages;