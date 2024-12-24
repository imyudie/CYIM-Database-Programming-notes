/*
撰寫 PL/SQL 印出員工 ID 為 206 的薪資等級。薪資等級的規則如下：

如果薪資小於等於 9400，則等級為 C。
如果薪資介於 9400 和 16700 之間，則等級為 B。
其他情況，等級為 A。
請使用 Searched CASE 敘述完成此練習。

程式輸出：

PL/SQL procedure successfully completed.

Employee ID#206. Salary: 8300.Salary code: C
*/
set SERVEROUTPUT on;
DECLARE
    emp_id employees.employee_id%type := 206;
    emp_salary employees.salary%type;
    emp_level varchar2(10);
BEGIN
    select salary into emp_salary from employees where employee_id = emp_id;
    emp_level := CASE 
                    when emp_salary <= 9400 THEN 'C'
                    when emp_salary <= 16700 THEN 'B'
                    else 'A'
                end;
    DBMS_OUTPUT.PUT_LINE('Employee ID#'||emp_id||'. Salary: '||emp_salary||'.Salary code: '||emp_level);

end;