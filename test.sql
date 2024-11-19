DECLARE
    v_customer VARCHAR2(50) := 'Wpamnsporrt';
    v_cerdit_rating VARCHAR2(50) :='EXCELLENT';
BEGIN
    <<A>>
    DECLARE
        v_customer NUMBER(7) := 201;
        v_name VARCHAR2(50) :='Unisports';
    BEGIN
        --B point
        v_cerdit_rating := 'GOOD';
        DBMS_OUTPUT.PUT_LINE('Inner block B: v_customer -> ' || v_customer || ' v_cerdit_rating -> ' || v_cerdit_rating);
    END;
    --A point
    DBMS_OUTPUT.PUT_LINE('Inner block A: v_customer -> ' || v_customer || ' v_cerdit_rating -> ' || v_cerdit_rating);
END;
/