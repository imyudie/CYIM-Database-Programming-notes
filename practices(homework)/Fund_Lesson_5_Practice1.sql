/*撰寫一個匿名區塊來完成下列要求：

在 dept 表格中找到最大的部門 ID。然後將這個 ID 存儲到區域變數 v_max_deptno 中。接著輸出這個變數的值。
新增一個部門到 dept 表格中。新部門的欄位值如下:
部門 ID: v_max_deptno + 10
部門名稱: 'Education'
位置 ID: null*/
DECLARE
    v_max_deptno dept.department_id%type;
BEGIN
    SELECT MAX(department_id) INTO v_max_deptno FROM dept;
    --dbms_output.put_line('Max department ID: ' || v_max_deptno);
    insert into DEPT(department_id, department_name, location_id)
            values(v_max_deptno + 10, 'Education', null);  
    COMMIT;
END;
/
SELECT * FROM DEPT WHERE department_id = 280;

