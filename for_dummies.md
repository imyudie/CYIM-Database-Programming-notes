## 上課筆記懶人包
事實上也沒懶到哪裡，但全是重點。
### 前言

這份筆記是為了協助同學們複習資料庫程式設計課程的重要概念，特別針對期中考試的重點進行整理。內容涵蓋 PL/SQL 的基本結構、變數宣告、控制結構、交易控制、游標、例外處理，以及與 SQL 的互動等。筆記將從基礎開始，逐步深入，詳細解釋每個概念，並輔以正確且完整的範例。特別強調註釋部分，因為它們包含了關鍵的知識點和重要的細節。

---

### 1. 啟用伺服器輸出

```sql
SET SERVEROUTPUT ON;
```

- **說明**：在執行 PL/SQL 程式塊時，為了能夠看到 `DBMS_OUTPUT.PUT_LINE` 的輸出結果，必須啟用伺服器輸出。
- **注意**：`SET` 是向資料庫發出的指令，不需要以分號結束。

---

### 2. PL/SQL 程式塊的基本結構

PL/SQL 程式塊由以下部分組成：

```sql
DECLARE
    -- 宣告區段（可選）
    -- 在此宣告變數、常數、游標等
BEGIN
    -- 執行區段（必須）
    -- 放置可執行的 PL/SQL 語句
EXCEPTION
    -- 例外處理區段（可選）
    -- 處理執行區段中可能發生的例外情況
END;
/
```

- **說明**：
  - `DECLARE`：宣告變數、常數、游標等。
  - `BEGIN`：開始執行區段。
  - `EXCEPTION`：處理可能發生的例外狀況。
  - `END;`：結束 PL/SQL 區塊。
  - `/`：告知 SQL*Plus 或開發工具執行前面的 PL/SQL 區塊。

---

### 3. 交易控制語句（Transaction Control Statements）

#### 3.1 交易控制的概念

- **Transaction Control**：PL/SQL 支援交易控制語句，用於管理資料庫交易的原子性和一致性。主要的交易控制語句包括 `COMMIT`、`ROLLBACK` 和 `SAVEPOINT`。
- **作用**：這些語句允許開發者控制資料庫的變更，確保資料的完整性和一致性。

#### 3.2 重要指令

- **`COMMIT`**：提交交易，將所有未提交的變更永久地儲存到資料庫中。
- **`ROLLBACK`**：回滾交易，撤銷自上次提交以來的所有未提交變更。
- **`SAVEPOINT`**：設置保存點，允許部分回滾到特定的保存點。

#### 3.3 範例

```sql
BEGIN
    INSERT INTO employees (employee_id, first_name) VALUES (106, 'Alice');
    SAVEPOINT save_emp;  -- 設置保存點

    UPDATE employees SET first_name = 'Alice Johnson' WHERE employee_id = 106;

    ROLLBACK TO save_emp;  -- 回滾到保存點，撤銷更新操作
    COMMIT;  -- 提交插入操作
END;
/
```

- **說明**：
  - 首先插入一筆新的員工資料，員工編號為 106，姓名為 'Alice'。
  - 設置保存點 `save_emp`。
  - 更新剛插入的員工姓名為 'Alice Johnson'。
  - 使用 `ROLLBACK TO save_emp`，回滾到保存點，撤銷更新操作，但保留插入操作。
  - 最後使用 `COMMIT`，提交交易，永久保存插入的資料。

---

### 4. 隱式游標與顯式游標（Implicit and Explicit Cursors）

#### 4.1 游標的概念

- **游標（Cursor）**：在 PL/SQL 中，游標是用於逐行處理查詢結果的機制。當查詢返回多行資料時，需要使用游標來遍歷和處理每一行。

#### 4.2 隱式游標

- **定義**：隱式游標是 PL/SQL 自動為每個 SQL 資料操作語句（如 `SELECT INTO`、`INSERT`、`UPDATE`、`DELETE`）建立的游標。
- **特點**：
  - 不需要明確地宣告、開啟、提取或關閉。
  - 適用於返回單行資料的查詢。
- **常用隱式游標屬性**：
  - `%FOUND`：如果上一個操作影響到一行或多行，則返回 `TRUE`；否則返回 `FALSE`。
  - `%NOTFOUND`：如果上一個操作沒有影響任何行，則返回 `TRUE`；否則返回 `FALSE`。
  - `%ROWCOUNT`：返回上一個操作影響的行數。
  - `%ISOPEN`：檢查游標是否開啟，隱式游標在執行後自動關閉，因此始終為 `FALSE`。

#### 4.3 隱式游標範例

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_salary employees.salary%TYPE;
BEGIN
    SELECT salary INTO v_salary FROM employees WHERE employee_id = 101;
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No employee found with ID 101.');
    END IF;
END;
/
```

- **說明**：
  - 使用 `SELECT INTO` 將員工編號為 101 的薪資存入變數 `v_salary`。
  - 使用隱式游標屬性 `SQL%FOUND` 檢查是否找到資料。
  - 如果找到，則輸出薪資；否則，輸出沒有找到員工。

#### 4.4 顯式游標

- **定義**：顯式游標需要開發者明確地宣告、開啟、提取和關閉。適用於需要處理多行查詢結果的情況。
- **特點**：
  - 可以更加靈活地控制查詢的執行和資料的提取。
  - 適用於需要逐行處理查詢結果的情況。

#### 4.5 顯式游標的使用步驟

1. **宣告游標**：在宣告區段使用 `CURSOR` 語句定義游標和其查詢語句。
2. **開啟游標**：使用 `OPEN` 語句開啟游標，執行查詢。
3. **提取資料**：使用 `FETCH` 語句從游標中提取一行資料。
4. **檢查結束**：使用游標屬性 `%NOTFOUND` 或 `%FOUND` 檢查是否到達查詢結果的末尾。
5. **關閉游標**：使用 `CLOSE` 語句關閉游標，釋放資源。

#### 4.6 顯式游標範例

```sql
SET SERVEROUTPUT ON;
DECLARE
    -- 宣告游標
    CURSOR emp_cursor IS
        SELECT first_name FROM employees WHERE department_id = 10;

    -- 宣告變數存儲提取的資料
    v_name employees.first_name%TYPE;
BEGIN
    OPEN emp_cursor;  -- 開啟游標
    LOOP
        FETCH emp_cursor INTO v_name;  -- 提取資料
        EXIT WHEN emp_cursor%NOTFOUND;  -- 檢查是否到達末尾
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_name);
    END LOOP;
    CLOSE emp_cursor;  -- 關閉游標
END;
/
```

- **說明**：
  - 宣告游標 `emp_cursor`，查詢部門編號為 10 的所有員工的名字。
  - 在 `BEGIN` 區段中，開啟游標並進入迴圈。
  - 每次迴圈中，從游標中提取一行資料到變數 `v_name`。
  - 使用 `EXIT WHEN emp_cursor%NOTFOUND` 判斷是否已經提取完所有資料。
  - 輸出員工的名字。
  - 最後關閉游標。

---

### 5. 變數宣告與初始化

#### 5.1 基本變數宣告

```sql
DECLARE
    l_name VARCHAR2(100) := 'John';
    l_salary NUMBER NOT NULL := 0;
```

- **說明**：
  - `VARCHAR2(100)`：宣告一個最大長度為 100 的字串變數。
  - `NUMBER`：宣告一個數值變數。
  - `NOT NULL`：表示該變數不能為空值，必須初始化。
  - `:=`：用於賦值初始值。

#### 5.2 使用 `%TYPE` 綁定資料庫欄位類型

```sql
DECLARE
    l_fname employees.first_name%TYPE;
    l_dept_name departments.department_name%TYPE;
```

- **說明**：
  - `%TYPE`：用於將變數的資料類型綁定到資料庫中某個表格的欄位類型。
  - 好處是如果資料庫欄位的類型發生變化，PL/SQL 程式中的變數類型會自動更新，保持一致性。

---

### 6. 使用 `SELECT INTO` 語句

```sql
BEGIN
    SELECT column1, column2
    INTO variable1, variable2
    FROM table_name
    WHERE condition;
END;
/
```

- **例子**：

```sql
DECLARE
    l_name employees.last_name%TYPE;
    f_name employees.first_name%TYPE;
BEGIN
    SELECT first_name, last_name
    INTO f_name, l_name
    FROM employees
    WHERE employee_id = 110;
    DBMS_OUTPUT.PUT_LINE('The full name is: ' || l_name || ', ' || f_name);
END;
/
```

- **說明**：
  - `SELECT INTO`：將查詢結果的值賦給變數。
  - 必須確保查詢結果只返回一條記錄，否則會拋出 `NO_DATA_FOUND` 或 `TOO_MANY_ROWS` 的例外。

---

### 7. 控制輸出與字串連接

```sql
DBMS_OUTPUT.PUT_LINE('訊息');
```

- **說明**：
  - 用於在 PL/SQL 中輸出訊息到控制台。
  - 使用 `||` 進行字串連接。

- **例子**：

```sql
DBMS_OUTPUT.PUT_LINE('The full name is: ' || l_name || ', ' || f_name);
```

---

### 8. 比較 NULL 值

- **重要觀念**：
  - 在 SQL 和 PL/SQL 中，`NULL` 代表未知的值。
  - 任何與 `NULL` 的比較都會返回 `UNKNOWN`（未知），在條件判斷時被視為 `FALSE`。

```sql
-- 以下比較結果均為 UNKNOWN（在條件判斷中被視為 FALSE）
IF 1 = NULL THEN
    -- 不會執行
END IF;

IF NULL = NULL THEN
    -- 不會執行
END IF;
```

- **說明**：
  - `NULL` 不等於任何值，包括它自己。
  - 在判斷是否為 `NULL` 時，應使用 `IS NULL` 或 `IS NOT NULL`。

---

### 9. 資料類型轉換與格式化

#### 9.1 資料類型轉換函數

- **`TO_NUMBER`**：將字串轉換為數值。
- **`TO_CHAR`**：將數值或日期轉換為字串。
- **`TO_DATE`**：將字串轉換為日期。

- **例子**：

```sql
v_salary := TO_NUMBER('1000');

v_date := TO_DATE('15-OCT-2024', 'DD-MON-YYYY');
v_date_str := TO_CHAR(v_date, 'Month DD, YYYY');
```

- **說明**：
  - 使用 `TO_DATE` 時，需提供適當的格式模型，確保字串能正確轉換為日期。
  - 使用 `TO_CHAR` 進行格式化輸出，控制日期或數值的顯示格式。

#### 9.2 語系設定

```sql
ALTER SESSION SET NLS_DATE_LANGUAGE = 'AMERICAN';
```

- **說明**：
  - 設定會話的日期語言，確保在日期格式化時使用正確的月份名稱。

---

### 10. 變數的生命週期與作用域

- **觀念**：
  - **生命週期（Lifetime）**：變數存在的時間範圍。
  - **作用域（Scope）**：變數可被訪問的區域。

- **區塊結構中的變數遮蔽**：
  - 在內部區塊中，可以宣告與外部區塊同名的變數，內部區塊的變數會遮蔽外部區塊的變數。

#### 10.1 範例

```sql
SET SERVEROUTPUT ON;
<<outer>>
DECLARE
    v_name VARCHAR2(20) := 'Big Brother';
    v_birth DATE := TO_DATE('01-Jan-2000', 'DD-MON-YYYY');
BEGIN
    <<inner>>
    DECLARE
        v_name VARCHAR2(20) := 'Young Brother';
        v_birth DATE := TO_DATE('01-Jan-2020', 'DD-MON-YYYY');
    BEGIN
        -- 內部區塊，可以訪問內部和外部變數
        DBMS_OUTPUT.PUT_LINE(outer.v_name || ', born on ' || TO_CHAR(outer.v_birth, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE(v_name || ', born on ' || TO_CHAR(v_birth, 'DD-MON-YYYY'));
    END inner;
END outer;
/
```

- **輸出結果**：

```
Big Brother, born on 01-JAN-2000
Young Brother, born on 01-JAN-2020
```

- **說明**：
  - 在內部區塊中，`v_name` 和 `v_birth` 遮蔽了外部區塊的同名變數。
  - 使用區塊標籤 `outer`，可以在內部區塊中訪問外部區塊的變數。

---

### 11. SQL 與 PL/SQL 的區別與關聯

#### 11.1 SQL 可直接執行的語句

- **查詢語句**：`SELECT`
- **DML（資料操作語言）**：`INSERT`、`UPDATE`、`DELETE`、`MERGE`
- **交易控制**：`COMMIT`、`ROLLBACK`、`SAVEPOINT`

#### 11.2 SQL 中不可直接執行的語句

- **DDL（資料定義語言）**：`CREATE`、`ALTER`、`DROP`
  - 這些語句需要在 PL/SQL 中透過動態 SQL（`EXECUTE IMMEDIATE`）執行。

#### 11.3 PL/SQL 與 SQL 的互動

- **PL/SQL** 是一種程式語言，擴充了 SQL 的功能，允許在程式中使用變數、條件語句、迴圈等結構。
- 在 PL/SQL 中，可以嵌入 SQL 語句，實現對資料庫的操作。

---

### 12. 控制結構

#### 12.1 條件語句：`IF - THEN - ELSE`

```sql
IF condition THEN
    -- 當條件為真時執行
ELSIF other_condition THEN
    -- 當其他條件為真時執行
ELSE
    -- 當以上條件皆不成立時執行
END IF;
```

- **注意**：在 PL/SQL 中，條件為 `NULL` 被視為 `FALSE`。

#### 12.2 條件語句：`CASE`

- **搜尋式 CASE（Searched CASE）**

```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END;
```

- **簡單 CASE（Simple CASE）**

```sql
CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ELSE default_result
END;
```

- **例子**：

```sql
l_rank := CASE
    WHEN s <= 20 THEN 'E'
    WHEN s <= 40 THEN 'D'
    WHEN s <= 60 THEN 'C'
    WHEN s <= 80 THEN 'B'
    ELSE 'A'
END;

l_comment := CASE l_rank
    WHEN 'A' THEN 'Excellent'
    WHEN 'B' THEN 'Good'
    WHEN 'C' THEN 'Fair'
    ELSE 'Needs Improvement'
END;
```

- **說明**：
  - `CASE` 語句可用於根據條件或表達式返回值。
  - 在 `CASE` 語句中，返回的結果類型必須一致。

#### 12.3 迴圈結構

##### 12.3.1 基本迴圈

```sql
LOOP
    -- 執行語句
    EXIT WHEN condition;
END LOOP;
```

- **說明**：無限迴圈，直到 `EXIT WHEN` 條件為真時退出。

##### 12.3.2 `WHILE` 迴圈

```sql
WHILE condition LOOP
    -- 執行語句
END LOOP;
```

- **說明**：在條件為真時執行迴圈。

##### 12.3.3 `FOR` 迴圈

```sql
FOR counter IN lower_bound..upper_bound LOOP
    -- 執行語句
END LOOP;
```

- **說明**：
  - `counter` 是隱含宣告的變數，類型為整數，只能在迴圈內使用。
  - `counter` 的值在迴圈內不可修改。

#### 12.4 迴圈控制語句

- **`EXIT`**：退出迴圈。

```sql
EXIT [label] WHEN condition;
```

- **`CONTINUE`**：跳過當前迭代，進入下一次迭代。

```sql
CONTINUE [label] WHEN condition;
```

- **使用標籤控制多層迴圈**

```sql
<<outer_loop>>
FOR i IN 1..10 LOOP
    FOR j IN 1..10 LOOP
        EXIT outer_loop WHEN condition; -- 退出外層迴圈
        CONTINUE WHEN other_condition;  -- 跳過當前迭代
    END LOOP;
END LOOP;
```

---

### 13. MERGE 語句（合併資料）

```sql
MERGE INTO target_table tgt
USING source_table src
ON (tgt.id = src.id)
WHEN MATCHED THEN
    UPDATE SET tgt.column = src.column
    DELETE WHERE condition -- 可選，當條件為真時刪除
WHEN NOT MATCHED THEN
    INSERT (columns) VALUES (src.values);
```

- **說明**：
  - `MERGE` 語句用於合併資料，根據條件執行更新、刪除或插入操作。
  - 在匹配（`MATCHED`）時，可以選擇更新或刪除。
  - 在不匹配（`NOT MATCHED`）時，可以執行插入操作。

#### 13.1 範例：合併訂單資料

```sql
MERGE INTO order_master OM
USING monthly_orders MO
ON (OM.order_id = MO.order_id)
WHEN MATCHED THEN
    UPDATE SET OM.order_total = MO.order_total
    DELETE WHERE OM.order_total IS NULL
WHEN NOT MATCHED THEN
    INSERT (order_id, order_total)
    VALUES (MO.order_id, MO.order_total);
COMMIT;
```

- **說明**：
  - 將 `monthly_orders` 表格中的資料合併到 `order_master` 表格中。
  - 如果訂單已存在，更新 `order_total`；如果更新後 `order_total` 為 `NULL`，則刪除該訂單。
  - 如果訂單不存在，則插入新的訂單資料。

---

### 14. 使用綁定變數（Bind Variables）

#### 14.1 宣告綁定變數

```sql
VARIABLE b_dept_id NUMBER;
```

- **說明**：
  - `VARIABLE` 用於在 SQL*Plus 或開發工具中宣告綁定變數。
  - 綁定變數在會話中是全域的，可在 SQL 和 PL/SQL 中使用。

#### 14.2 在 PL/SQL 中使用綁定變數

```sql
BEGIN
    :b_dept_id := 200;
END;
/
```

- **注意**：
  - 在 PL/SQL 中使用綁定變數時，前面要加冒號 `:`。

#### 14.3 在 SQL 語句中使用綁定變數

```sql
SELECT * FROM employees
WHERE department_id = :b_dept_id;
```

- **說明**：
  - 綁定變數有助於提升程式的可讀性和可維護性。

---

### 15. 資料操作語句（DML）與交易控制

#### 15.1 資料操作語句

- **INSERT**

```sql
INSERT INTO table_name (column1, column2)
VALUES (value1, value2);
```

- **UPDATE**

```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

- **DELETE**

```sql
DELETE FROM table_name
WHERE condition;
```

- **說明**：
  - 在 DML 語句中，可以使用變數作為值。
  - 一定要注意 `WHERE` 條件，避免對整個表格進行無條件更新或刪除。

#### 15.2 交易控制

- **COMMIT**

```sql
COMMIT;
```

- **ROLLBACK**

```sql
ROLLBACK;
```

- **SAVEPOINT**

```sql
SAVEPOINT savepoint_name;
```

- **說明**：
  - `COMMIT`：提交交易，永久保存對資料庫的更改。
  - `ROLLBACK`：回滾交易，撤銷自上次提交以來的更改。
  - `SAVEPOINT`：設置保存點，可以回滾到指定的保存點。

---

### 16. 錯誤處理與例外（Exception Handling）

#### 16.1 例外處理結構

```sql
BEGIN
    -- 可執行語句
EXCEPTION
    WHEN exception_name1 THEN
        -- 例外處理語句
    WHEN exception_name2 THEN
        -- 例外處理語句
    WHEN OTHERS THEN
        -- 其他未處理的例外
END;
```

- **常見的內建例外**：
  - `NO_DATA_FOUND`：當 `SELECT INTO` 未返回任何資料時。
  - `TOO_MANY_ROWS`：當 `SELECT INTO` 返回多於一條記錄時。
  - `ZERO_DIVIDE`：除以零錯誤。
  - `INVALID_NUMBER`：數字轉換錯誤。

#### 16.2 範例

```sql
BEGIN
    SELECT salary INTO v_salary FROM employees WHERE employee_id = 9999;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No employee found with ID 9999.');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Multiple employees found with ID 9999.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/
```

- **說明**：
  - `SQLERRM`：返回當前錯誤的錯誤訊息。
  - 在例外處理區段中，可以根據不同的例外進行相應的處理。

---

### 17. 綜合範例與練習

#### 17.1 計算平均薪資並更新員工薪資

- **問題描述**：
  - 計算所有員工的平均薪資，並將其 5% 加到 `emp01` 表格的每位員工的薪資中。
  - 更新完成後，輸出「更新完成」。

- **解決方案**：

```sql
SET SERVEROUTPUT ON;
DECLARE
    l_avg employees.salary%TYPE;
BEGIN
    SELECT AVG(salary) INTO l_avg FROM employees;
    UPDATE emp01
    SET salary = salary + l_avg * 0.05;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('更新完成');
END;
/
```

- **說明**：
  - 使用 `AVG` 函數計算平均薪資，結果存入變數 `l_avg`。
  - 更新 `emp01` 表格，將每位員工的薪資增加平均薪資的 5%。
  - 使用 `COMMIT` 提交交易，確保更改被保存。
  - 使用 `DBMS_OUTPUT.PUT_LINE` 輸出結果。

#### 17.2 使用 `CASE` 語句判斷薪資等級

- **問題描述**：
  - 根據員工編號 206 的薪資，判斷其薪資等級。
  - 薪資等級規則：
    - 薪資小於等於 9400，等級為 C。
    - 薪資介於 9400 和 16700 之間，等級為 B。
    - 其他情況，等級為 A。
  - 使用搜尋式 `CASE` 語句完成。

- **解決方案**：

```sql
SET SERVEROUTPUT ON;
DECLARE
    emp_id employees.employee_id%TYPE := 206;
    emp_salary employees.salary%TYPE;
    emp_level VARCHAR2(1);
BEGIN
    SELECT salary INTO emp_salary FROM employees WHERE employee_id = emp_id;
    emp_level := CASE
        WHEN emp_salary <= 9400 THEN 'C'
        WHEN emp_salary <= 16700 THEN 'B'
        ELSE 'A'
    END;
    DBMS_OUTPUT.PUT_LINE('Employee ID#' || emp_id || '. Salary: ' || emp_salary || '. Salary code: ' || emp_level);
END;
/
```

- **說明**：
  - 使用 `CASE` 語句根據薪資範圍判斷薪資等級。
  - 輸出結果包含員工編號、薪資和薪資等級。

#### 17.3 使用迴圈與條件控制操作資料

- **問題描述**：
  - 將 `t1` 表格中值小於閾值的資料列插入到 `t1_keep` 表格中，並刪除 `t1` 表格中的這些資料列。
  - 閾值存於綁定變數 `v_threshold` 中，值為 50。
  - 輸出插入和刪除的資料列數。

- **解決方案**：

```sql
SET SERVEROUTPUT ON;
VARIABLE v_threshold NUMBER;
EXEC :v_threshold := 50;

BEGIN
    INSERT INTO t1_keep (id, val)
    SELECT id, val FROM t1 WHERE val < :v_threshold;
    DBMS_OUTPUT.PUT_LINE('Rows kept: ' || SQL%ROWCOUNT);

    DELETE FROM t1 WHERE val < :v_threshold;
    DBMS_OUTPUT.PUT_LINE('Rows deleted: ' || SQL%ROWCOUNT);

    COMMIT;
END;
/
```

- **說明**：
  - 使用綁定變數設定閾值。
  - `SQL%ROWCOUNT`：返回上一個 SQL 語句影響的資料列數。
  - 插入和刪除操作完成後，使用 `COMMIT` 提交交易。

---

### 18. 注意事項

#### 18.1 群組函數的使用限制

- **觀念**：
  - 群組函數（如 `AVG`、`SUM`、`MAX`、`MIN`）不能在 PL/SQL 中直接用於變數運算，只能在 SQL 查詢中使用。
  - 需要透過 `SELECT INTO` 將結果賦值給變數。

- **例子**：

```sql
DECLARE
    l_avg_salary NUMBER;
BEGIN
    SELECT AVG(salary) INTO l_avg_salary FROM employees;
    -- 正確：使用 SELECT INTO 將 AVG 結果賦值給變數
END;
```

#### 18.2 動態 SQL 的使用

- **觀念**：
  - 在 PL/SQL 中，DDL 語句（如 `CREATE`、`DROP`、`ALTER`）不能直接執行，需要使用動態 SQL。

- **例子**：

```sql
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE temp_table (id NUMBER)';
END;
/
```

- **說明**：
  - `EXECUTE IMMEDIATE` 用於執行動態 SQL 語句。

#### 18.3 變數作用域與命名衝突

- **觀念**：
  - 在巢狀區塊中，內部區塊的變數可以遮蔽外部區塊的同名變數。
  - 建議避免在內外部區塊中使用同名變數，或使用區塊標籤區分。

- **例子**：

```sql
SET SERVEROUTPUT ON;
<<outer>>
DECLARE
    v_var NUMBER := 10;
BEGIN
    <<inner>>
    DECLARE
        v_var NUMBER := 20;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Inner v_var: ' || v_var);           -- 輸出 20
        DBMS_OUTPUT.PUT_LINE('Outer v_var: ' || outer.v_var);     -- 輸出 10
    END inner;
END outer;
/
```
## 易錯觀念 - MERGE

### 初始狀態

**1. `order_master` 表格**

| order_id | order_total |
|----------|-------------|
| 1        | 1000        |
| 2        | 2000        |
| 3        | 3000        |
| 4        | NULL        |

**2. `monthly_orders` 表格**

| order_id | order_total |
|----------|-------------|
| 2        | 2500        |
| 3        | NULL        |

---

### MERGE 語句解釋

```sql
MERGE INTO order_master OM
USING monthly_orders MO
ON (OM.order_id = MO.order_id)
WHEN MATCHED THEN
    UPDATE SET OM.order_total = MO.order_total
    DELETE WHERE (OM.order_total IS NULL)
WHEN NOT MATCHED THEN
    INSERT (OM.order_id, OM.order_total) VALUES (MO.order_id, MO.order_total);
COMMIT;
```

- **目標表格**：`order_master`，簡稱 `OM`
- **來源表格**：`monthly_orders`，簡稱 `MO`
- **匹配條件**：`OM.order_id = MO.order_id`

---

### 步驟解析

#### **步驟 1：識別匹配和不匹配的行**

- **匹配的行**（存在於兩個表格中，`order_id` 相同）：
  - `order_id = 2`
  - `order_id = 3`

- **在 `monthly_orders` 中有，但在 `order_master` 中沒有的行**（不匹配）：
  - 無，因為 `monthly_orders` 中的 `order_id` 都存在於 `order_master` 中。

---

#### **步驟 2：處理匹配的行（`WHEN MATCHED THEN`）**

對於匹配的行，執行以下操作：

1. **更新操作**：
   - 將 `OM.order_total` 更新為 `MO.order_total`。

2. **刪除操作**：
   - 如果更新後的 `OM.order_total` 為 `NULL`，則刪除該行。

---

##### **處理 `order_id = 2`**

- **更新前**：
  - `OM.order_total` = 2000
  - `MO.order_total` = 2500

- **執行更新**：
  - 更新 `OM.order_total` 為 `2500`。

- **檢查是否刪除**：
  - 更新後的 `OM.order_total` = 2500，不是 `NULL`，不刪除。

---

##### **處理 `order_id = 3`**

- **更新前**：
  - `OM.order_total` = 3000
  - `MO.order_total` = `NULL`

- **執行更新**：
  - 更新 `OM.order_total` 為 `NULL`。

- **檢查是否刪除**：
  - 更新後的 `OM.order_total` = `NULL`，符合刪除條件，刪除該行。

---

**更新和刪除操作後的 `order_master` 表格**

| order_id | order_total |
|----------|-------------|
| 1        | 1000        |  （未受影響）
| 2        | 2500        |  （更新）
| 4        | NULL        |  （未受影響）
| *（`order_id = 3` 已被刪除）*

---

#### **步驟 3：處理不匹配的行（`WHEN NOT MATCHED THEN`）**

- **在 `monthly_orders` 中有，但在 `order_master` 中沒有的 `order_id`**：
  - 無，因為所有 `MO.order_id` 都存在於 `OM.order_id` 中。

- **因此，沒有需要插入的行**。

---

#### **步驟 4：提交更改**

```sql
COMMIT;
```

- 將所有更改永久地保存到資料庫中。

---

### 最終結果

**`order_master` 表格**

| order_id | order_total |
|----------|-------------|
| 1        | 1000        | （原始資料，未受影響）
| 2        | 2500        | （`order_total` 更新為 2500）
| 4        | NULL        | （原始資料，未受影響）

- **注意**：
  - `order_id = 3` 的行已被刪除，因為更新後 `order_total` 為 `NULL`。
  - `order_id = 4` 的行未被刪除，即使其 `order_total` 為 `NULL`，因為它不在匹配的行中（`order_id = 4` 不存在於 `monthly_orders` 中）。

---

### 詳細解釋

#### **為何 `order_id = 4` 的行未被刪除？**

- **刪除條件限制在匹配的行**：
  - 在 `MERGE` 語句的 `WHEN MATCHED THEN` 子句中，`DELETE WHERE` 只適用於匹配的行。
  - 因此，只有那些在 `order_master` 和 `monthly_orders` 中 `order_id` 匹配的行，才會根據更新後的 `order_total` 是否為 `NULL` 來決定是否刪除。
  
- **`order_id = 4` 不在匹配的行中**：
  - 因為 `order_id = 4` 不存在於 `monthly_orders` 表格中，因此不屬於匹配的行。
  - `MERGE` 語句對於不匹配的行，如果未在 `WHEN NOT MATCHED THEN` 子句中指定刪除操作，則不會對其進行任何操作。

#### **刪除操作的限制**

- **`DELETE WHERE` 子句僅適用於 `WHEN MATCHED THEN` 中的行**：
  - 根據 Oracle 的 `MERGE` 語句語法，`DELETE WHERE` 只能用在 `WHEN MATCHED THEN` 子句中，且只能刪除那些已經進行了 `UPDATE` 操作的行。
  
- **不影響未匹配的行**：
  - 因此，`order_id = 4` 的行，即使其 `order_total` 為 `NULL`，也不會被刪除，因為它沒有被匹配，也沒有被更新。

---

### 小結

- **匹配的行**：
  - **`order_id = 2`**：
    - 更新 `order_total` 為 `2500`。
    - 更新後不為 `NULL`，不刪除。
  
  - **`order_id = 3`**：
    - 更新 `order_total` 為 `NULL`。
    - 更新後為 `NULL`，刪除該行。

- **不匹配的行**：
  - **`order_id = 1`** 和 **`order_id = 4`**：
    - 未被匹配，`MERGE` 操作對其無影響。
    - `order_id = 1` 保持 `order_total = 1000`。
    - `order_id = 4` 保持 `order_total = NULL`。

- **最終結果**：
  - `order_master` 中剩餘的行：
    - `order_id = 1`，`order_total = 1000`
    - `order_id = 2`，`order_total = 2500`
    - `order_id = 4`，`order_total = NULL`

---

### 結論

- `MERGE` 語句在此操作中：

  - **更新**了匹配行的 `order_total` 值。
  - **刪除**了匹配行中更新後 `order_total` 為 `NULL` 的行。
  - **未插入**任何新行，因為沒有不匹配的 `order_id` 需要插入。
  - **未影響**未匹配的行（如 `order_id = 1` 和 `order_id = 4`）。

- **因此，`order_master` 的最終結果與您提供的結果一致**：

  | order_id | order_total |
  |----------|-------------|
  | 1        | 1000        |
  | 2        | 2500        |
  | 4        | NULL        |

## 易錯觀念 - MERGE & CURSOR
### **背景資料**

首先，讓我們回顧一下資料：

**1. 表格 `emp_salary_1`**

```sql
EMPLOYEE_ID FIRST_NAME   SALARY  NEW_SALARY
----------- ------------- ------- ----------
        100 Steven        24000          0
```

**2. 表格 `emp_salary_2`**

```sql
EMPLOYEE_ID FIRST_NAME   SALARY
----------- ------------- -------
        100 Steven        24000
        101 Neena         17000
```

---

### **MERGE 語句分析**

我們執行以下的 PL/SQL 區塊：

```sql
DECLARE
  v_count NUMBER;
BEGIN
    MERGE INTO emp_salary_1 e1
    USING emp_salary_2 e2
    ON (e1.employee_id = e2.employee_id)
    WHEN MATCHED THEN
        UPDATE SET e1.new_salary = e2.salary * 1.2
    WHEN NOT MATCHED THEN
        INSERT (employee_id, first_name, salary, new_salary)
        VALUES (e2.employee_id, e2.first_name, e2.salary, e2.salary * 1.2);
        
    v_count := SQL%ROWCOUNT;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Rows updated: ' || v_count);
END;
/
```

---

### **步驟 1：執行 MERGE 操作**

`MERGE` 語句將 `emp_salary_2` 的資料合併到 `emp_salary_1` 中，根據員工編號（`employee_id`）進行匹配。

**匹配條件：**

- `e1.employee_id = e2.employee_id`

---

#### **處理每一筆資料**

**1. 處理 `employee_id = 100`**

- **匹配狀況：**`emp_salary_1` 和 `emp_salary_2` 中都有 `employee_id = 100`。

- **執行更新：**

  ```sql
  UPDATE SET e1.new_salary = e2.salary * 1.2
  ```

  - 計算新的薪資：`24000 * 1.2 = 28800`
  - 更新 `emp_salary_1` 中 `employee_id = 100` 的 `new_salary` 為 `28800`。

**2. 處理 `employee_id = 101`**

- **匹配狀況：**`emp_salary_1` 中沒有 `employee_id = 101`，`emp_salary_2` 中有。

- **執行插入：**

  ```sql
  INSERT (employee_id, first_name, salary, new_salary)
  VALUES (e2.employee_id, e2.first_name, e2.salary, e2.salary * 1.2);
  ```

  - 計算新的薪資：`17000 * 1.2 = 20400`
  - 插入新的資料到 `emp_salary_1`：
    - `employee_id`: 101
    - `first_name`: Neena
    - `salary`: 17000
    - `new_salary`: 20400

---

### **步驟 2：計算 SQL%ROWCOUNT**

在執行完 `MERGE` 語句後，`SQL%ROWCOUNT` 會返回此語句所影響的資料列數。

- **`MERGE` 操作影響的資料列數 = 更新的資料列數 + 插入的資料列數 + 刪除的資料列數**

在本例中：

- **更新的資料列數：1**

  - `employee_id = 100` 的資料被更新。

- **插入的資料列數：1**

  - `employee_id = 101` 的資料被插入。

- **刪除的資料列數：0**

  - `MERGE` 語句中沒有刪除操作。

**總計影響的資料列數：1（更新） + 1（插入） = 2**

因此：

```sql
v_count := SQL%ROWCOUNT;
```

`v_count` 的值為 **2**。

---

### **步驟 3：輸出結果**

```sql
DBMS_OUTPUT.PUT_LINE('Rows updated: ' || v_count);
```

輸出：

```
Rows updated: 2
```

---

### **驗證結果**

執行查詢：

```sql
SELECT * FROM emp_salary_1;
```

結果：

```sql
EMPLOYEE_ID FIRST_NAME   SALARY  NEW_SALARY
----------- ------------- ------- ----------
        100 Steven        24000     28800
        101 Neena         17000     20400
```

- 可以看到：

  - `employee_id = 100` 的 `new_salary` 已更新為 `28800`。
  - `employee_id = 101` 的資料已被插入，`new_salary` 為 `20400`。

---

### **總結**

- **`SQL%ROWCOUNT` 的值為 2，因為 `MERGE` 語句總共影響了兩筆資料：**

  1. **更新了 1 筆資料：**

     - `employee_id = 100` 的資料被更新（`new_salary` 被更新）。

  2. **插入了 1 筆資料：**

     - `employee_id = 101` 的資料被插入到 `emp_salary_1`。

- **因此，`SQL%ROWCOUNT` 返回了 2，表示總共影響了 2 行資料。**

---

### **補充說明**

- **`SQL%ROWCOUNT` 在 `MERGE` 操作後，返回的是該語句影響的資料列總數，包括插入、更新和刪除的資料列數。**

- **`MERGE` 語句的影響行數計算方式：**

  - **更新的資料列數**：所有符合 `WHEN MATCHED THEN UPDATE` 條件並被更新的資料列數。

  - **插入的資料列數**：所有符合 `WHEN NOT MATCHED THEN INSERT` 條件並被插入的資料列數。

  - **刪除的資料列數**：所有在 `WHEN MATCHED THEN UPDATE` 子句中符合 `DELETE WHERE` 條件並被刪除的資料列數。

- **在本例中：**

  - **更新的資料列數：1**

    - `employee_id = 100`

  - **插入的資料列數：1**

    - `employee_id = 101`

  - **刪除的資料列數：0**

    - 沒有刪除操作。

---

### **結論**

- `SQL%ROWCOUNT` 的值為 **2**，因為 `MERGE` 操作總共影響了 **2** 行資料（1 行更新，1 行插入）。

- 透過這個例子，我們理解了 `MERGE` 操作與 `SQL%ROWCOUNT` 的互動方式，這對於監控資料操作的影響範圍非常有用。

---

祝同學們複習順利，考試成功！
Jerry Hsu
