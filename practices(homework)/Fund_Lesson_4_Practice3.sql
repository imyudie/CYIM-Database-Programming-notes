-- Declare the block, 外部區塊
<<block_1>>
DECLARE
    -- 宣告變數
    v_employee_id employees.employee_id%TYPE;
    v_job employees.job_id%TYPE;
BEGIN
    -- 選擇 employee_id 100 的員工 ID 及 job_id
    SELECT employee_id, job_id 
    INTO v_employee_id, v_job
    FROM employees
    WHERE employee_id = 100;

    -- 宣告另一個區塊, 內部區塊
    <<block_2>>
    DECLARE
        -- 宣告變數
        v_employee_id employees.employee_id%TYPE;
        v_job employees.job_id%TYPE;
    BEGIN
        -- 選擇 employee_id 103 的員工的 ID 及 job_id
        SELECT employee_id, job_id  
        INTO v_employee_id, v_job
        FROM employees
        WHERE employee_id = 103;

        -- 輸出結果(Mark 1)
        DBMS_OUTPUT.PUT_LINE(block_1.v_employee_id || ' is a(n) ' || block_1.v_job);
    END block_2;
    -- 輸出結果
    DBMS_OUTPUT.PUT_LINE(v_employee_id || ' is a(n) ' || v_job);
END block_1;
/*
A. 內部區塊為什麼顯示員工 103 的 job_id，而不是員工 100 的 job_id？
因為它使用v_employee_id和v_job變數，這些變數在內部區塊中被重新宣告，所以內部區塊中的變數優先於外部區塊中的變數。

B. 外部區塊為什麼顯示員工 100 的 job_id，而不是員工 103 的 job_id？
因為內部區塊中的變數不可見，所以外部區塊中的變數被使用。

C. 修改程式碼以在內部區塊中(標示 Mark 1 處)印出員工 100 的詳細資料。使用區塊標籤修飾變數，以區分內部和外部區塊中的變數。
詳細資料? 要多詳細根本沒說明，也沒說能不能動宣告區塊。

注意: 此練習源自 Oracle Academy 的 Ch 2-6 巢狀區塊和變數範圍。
*/