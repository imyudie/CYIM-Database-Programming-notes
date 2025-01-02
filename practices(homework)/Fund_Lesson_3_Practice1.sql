set serveroutput on
DECLARE 
    v_date date;
    v_new_date date;
    v_salary employees.salary%TYPE;
    v_new_salary employees.salary%TYPE;
BEGIN
    select HIRE_DATE,SALARY
    into v_date,v_salary
    from employees 
    where employee_id = 104;
    v_new_date := v_date +366;--受閏年影響，所以加366
    v_new_salary := v_salary*1.1;
    --DBMS_OUTPUT.PUT_LINE(TO_DATE('2008-05-21', 'YYYY-MM-DD')-TO_DATE('2007-05-21', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('原始薪水: '||TO_CHAR(v_date, 'YYYY-MM-DD')||' Salary : '||v_salary);
    DBMS_OUTPUT.PUT_LINE('第一次加薪日期: '||TO_CHAR(v_new_date, 'YYYY-MM-DD')||' Salary : '||v_new_salary);
END;
/
--EXEC --是一個命令，後面接一個PL的敘述，會自動幫你的PL敘述包一個BEGIN
/*e.g.
VARIABLE b_a NUMBER ;

exec :b_a := 10;
exec :b_a := v_a + 10;
exec DBMS_OUTPUT.PUT_LINE(:b_a);
*/
