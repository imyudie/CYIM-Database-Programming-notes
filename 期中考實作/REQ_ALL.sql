set SERVEROUTPUT on
DECLARE
    v_total_rows NUMBER := 0;
BEGIN
    INSERT INTO promotions VALUES(1001,'Bath Towels',TO_DATE('2024-12-01','YYYY-MM-DD'),TO_DATE('2024-12-31','YYYY-MM-DD'),15.00,null);
    v_total_rows := v_total_rows + SQL%ROWCOUNT;
    
    INSERT INTO promotions VALUES(1002,'Paper Towels',TO_DATE('2024-12-01','YYYY-MM-DD'),TO_DATE('2024-12-31','YYYY-MM-DD'),10.00,null);
    v_total_rows := v_total_rows + SQL%ROWCOUNT;
    
    INSERT INTO promotions VALUES(1003,'Baby Wipes',TO_DATE('2024-12-01','YYYY-MM-DD'),TO_DATE('2024-12-31','YYYY-MM-DD'),8.00,null);
    v_total_rows := v_total_rows + SQL%ROWCOUNT;
    
    DBMS_OUTPUT.PUT_LINE('Affected rows: ' || v_total_rows);
    COMMIT;
END;
/
VARIABLE b_discount NUMBER
exec :b_discount := 0.2;
BEGIN
    UPDATE promotions SET promo_price = orig_price * (1 - :b_discount);
    DBMS_OUTPUT.PUT_LINE('Affected rows: ' || SQL%ROWCOUNT);
END;
/
SELECT * FROM promotions order by id;

