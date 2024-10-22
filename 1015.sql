/*
who 轉換?
A:引擎(預設規則)以及程式設計師(超出預設狀態)
Progammer how do ?
A: TO_XXX
e.g. 
TO_number
TO_char
TO_date

--輸出轉為字串，輸入轉為目標型態(格式化輸入的時候)
*/
set SERVEROUTPUT on
DECLARE
v_date date := '15-OCT-2024'; -- DD-MON-RR (要確定是否符合預設語系)
v_date_to_char date := '15-OCT-2024';
-- to_date(來源,格式化模型)
-- e.g. 'month DD,YYYY'

BEGIN
DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_date,'mon DD,YYYY'));
END;
/
ALTER SESSION set nls_date_language = 'AMERICAN'
/
select HIRE_DATE,TO_CHAR(HIRE_DATE, 'month DD,YYYY')
from employees ;
/
select TO_CHAR(HIRE_DATE ,'MONTH DD,YYYY')
from employees 
WHERE HIRE_DATE <= TO_date('OCT 15,2005','MON dd,YYYY');
/
/*
變數生命範圍
生命可見範圍(scope visibility declare)
若內外變數有相同名稱，內部區塊的變數，永遠高優先權
要取得外部變數，要在外部區塊加上標籤 e.g. <<outer>> Declare  => outer.v_salary(使用標籤修飾名稱)

結論:
變數遮蔽
內部區塊對外部是closed
*/