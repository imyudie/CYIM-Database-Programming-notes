-- Mark 1 加入區塊的標籤
<<Gen_One>>
DECLARE 
  -- 變數 v_name 在內部區塊中不可見，因為內部區塊中也有一個 v_name。
  v_name  VARCHAR2(20) := 'Big Brother';
  v_birth DATE         := '01-Jan-2000';
BEGIN 
    <<Gen_Two>>
  DECLARE
    --此變數使外部區塊中的 v_name 不可見。
    v_name VARCHAR2(20) := 'Young Brother ';
    v_birth DATE         := '01-Jan-2020';
  BEGIN
    DBMS_OUTPUT.PUT_LINE( Gen_One.v_name || ', born on ' || to_char(Gen_One.v_birth,'dd-MON-yy'));
    DBMS_OUTPUT.PUT_LINE( v_name || ', born on ' || to_char(v_birth,'dd-MON-yy'));
    -- Mark 2
    -- 在這裡寫程式碼以列印出 `Big Brother` 和 `Young Brother` 的名字和出生日期。
  END Gen_Two;
END Gen_One;
/