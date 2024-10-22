set serveroutput on

declare
v_salary number(6) :=6000;
v_total_salary v_salary%type;
v_add varchar2(10) := '1000';
v_hire_date  varchar2(100) := 'December 31, 2016';
v_interval CONSTANT interval year to month := '3-0';
v_retire_date date;

begin
-- Mark 1：編寫程式碼計算 v_total_salary的 值
-- 你的程式碼從這裡開始
v_total_salary := v_salary + TO_NUMBER(v_add);
dbms_output.put_line('Salary: ' || v_total_salary);


-- Mark 2：編寫程式碼計算v_retire_date的值
-- 你的程式碼從這裡開始
v_retire_date := TO_DATE(v_hire_date,'month DD, YYYY') + v_interval;
dbms_output.put_line('Retired Date:' || to_char(v_retire_date,'YYYY-MM-DD'));

end;
/