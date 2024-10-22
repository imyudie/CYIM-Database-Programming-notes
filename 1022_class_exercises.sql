/*建立表格
Create table emp01 as 
SELECT * FROM employees;

Block
1.找出公司的平均薪水，放到PL變數
2.更新emp01 中的 salary 欄位，增加平均薪水的5%

*/
DECLARE
    l_avg employees.salary%TYPE;
BEGIN
    SELECT avg(salary) into l_avg from employees;
    UPDATE emp01
    SET salary = salary + l_avg * 0.05;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('更新完成');
END;/

