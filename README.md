# CYIM-Database-Programming-notes
## 教材
教材:[Book A (FD): Oracle, Oracle Database: PL/SQL Fundamentals, Student Guide, 1.1 Ed, 2012.](https://o365cyut-my.sharepoint.com/personal/t2005022_o365_cyut_edu_tw/_layouts/15/onedrive.aspx?id=%2Fpersonal%2Ft2005022%5Fo365%5Fcyut%5Fedu%5Ftw%2FDocuments%2F1%2DTeaching%2FPLSQL%20Course%2F00%2DPLSQL%20Fundamentals%2DSG%2Epdf&parent=%2Fpersonal%2Ft2005022%5Fo365%5Fcyut%5Fedu%5Ftw%2FDocuments%2F1%2DTeaching%2FPLSQL%20Course&ga=1)
## 期中考範圍 ch1 ~ ch6
    - ch1 Introduction
    - ch2 Introduction to - PL/SQL
    - ch3 Declaring PL/SQL Variables
    - ch4 Writing Executable Statements
    - ch5 Interacting whit Oracle Database Server:SQL Statements in PL/SQL Programs
    - ch6 Writing Control Structures
---
## 重點整理
這些是我從課本中翻譯以及整理過來的資訊，並且融入許多上課內容，若覺得太多，時間不足，推薦[懶人包](/for_dummies.md)給你 ❤️
### Chapter 1：Introduction (unimportant)
### Chapter 2：Introduction to - PL/SQL
#### 語法結構：PL/SQL Block 結構
PL/SQL 程式的基本單位是**區塊 (block)**，其結構通常分為四部分：

1. **宣告區段 (Declarative Section)**：使用 `DECLARE` 關鍵字，通常是可選的。這部分包含變數、游標和自定義異常的宣告，用於在執行區段中使用。

2. **執行區段 (Executable Section)**：以 `BEGIN` 開始，這是所有 PL/SQL 區塊中唯一強制的部分。這部分包含 SQL 語句和 PL/SQL 語句，用於操作資料。

3. **異常處理區段 (Exception Handling Section)**：以 `EXCEPTION` 開始，這部分為可選，用於定義異常情況下的處理邏輯。

4. **結束 (END)**：每個 PL/SQL 區塊必須以 `END;` 結尾。注意 `END` 後要有分號。

**只要有`BEGIN`和`END;`便可組為一區塊。**

```sql
--e.g. 
set serveroutput on
DECLARE
    --宣告
    l_name list(100) := 'John';
BEGIN
    --可執行敘述
    select FIRST_NAME into l_name from employees
    where EMPLOYEE_ID = 100;
    --SQL context 
    DBMS_OUTPUT.PUT_LINE(l_name || '你好'); --PL Engine context
    --寫在資料庫的Buffer(緩衝區)，要讓devp知道要下一個指令
    --輸出的內容會被放到 Oracle 的 DBMS_OUTPUT 緩衝區中，然後當程式執行完畢後再將緩衝區中的內容顯示出來。
    --因此要記的打上 set serveroutput on 於區塊前
--EXCEPTION //例外執行區段 
END;

```

#### PL/SQL 執行引擎架構
PL/SQL 在 Oracle 資料庫中執行，其執行架構包括以下部分：

- **PL/SQL 引擎**：主要負責處理 PL/SQL 程式碼，並執行邏輯語句和程序式語句。PL/SQL 引擎存在於 Oracle 資料庫中，用於執行儲存過程和匿名區塊，也可以在 Oracle Forms 和 Oracle Application Server 的客戶端執行。

- **SQL 語句執行程序**：當 PL/SQL 引擎遇到 SQL 語句時，會進行「上下文切換」，將 SQL 語句傳遞給 Oracle 伺服器中的 SQL 執行程序處理。處理完成後返回結果供 PL/SQL 程序繼續執行。
```sql
--以下為常用方法
--簡易查詢
SELECT _column_name into _variable_name 
FROM _table_name
where _conditions;

--join查詢
SELECT _column_name into _variable_name 
FROM _table_name_1 JOIN _table_name_2
USING(_foreign_keys)-- using內不可使用修飾別名
WHERE _conditions;

--插入資料
INSERT INTO _table_name (_column1, _column2, ...)
VALUES (_value1, _value2, ...);

--使用SELECT插入資料
INSERT INTO _table_name (_column1, _column2)
SELECT _column1, _column2
FROM _another_table_name
WHERE _conditions;

--更新
UPDATE _table_name
SET _column1 = _value1, _column2 = _value2
WHERE _conditions;

--刪除
DELETE FROM _table_name
WHERE _conditions;
--更詳細方式會再Ch4 Ch5 詳細說明
```

#### 三種類型的 PL/SQL 區塊
PL/SQL 程式可以由以下三種類型的區塊組成：

1. **程序 (Procedure)**：一種命名的區塊，包含 SQL 或 PL/SQL 語句，通常用於執行一系列動作。
`還沒教，我就不寫出來，免得混淆視聽。`
2. **函數 (Function)**：也是命名區塊，但與程序不同的是，函數返回一個特定類型的值。
`同上。`
3. **匿名區塊 (Anonymous Block)**：無名稱，通常在 SQL*Plus 或其他工具中直接撰寫並執行。
```sql
--這就是一個匿名區塊
BEGIN
    DBMS_OUTPUT.PUT_LINE('hello world');
END;
/
```

#### 執行環境
PL/SQL 可以在多種 Oracle 工具中運行，包括：
- **Oracle SQL Developer**：一款免費的圖形化工具，支持 PL/SQL 開發與測試。
- **SQL*Plus**：命令行工具，用於直接執行 PL/SQL 程式。
- **Oracle JDeveloper**：提供進階功能，用於撰寫、測試和除錯 PL/SQL 程式。
- **VS code**：我最喜歡的IDE，有許多套件方便開發。
這些結構和工具使 PL/SQL 成為處理 Oracle 資料庫應用開發的強大工具。

### Chapter 3：Declaring PL/SQL Variables
#### 1. 變數的用途
PL/SQL 變數用於：
- **暫時存儲數據**：臨時存放查詢或計算的結果。
- **數值操作**：變數可以用於數據的處理與計算。
- **重複使用**：已宣告的變數可在多個程式段中重複使用，避免重複查詢。

#### 2. 變數命名規則
- **必須以字母開頭**。
- **可以包含字母、數字**，以及特定符號（如 `$`、`_`、`#`）。
- **最多包含 30 個字符**。
- **不得使用保留字**（例如 `SELECT`、`FROM` 等 SQL 關鍵字）。

#### 3. 宣告與初始化變數
- **宣告語法**：
  ```sql
  identifier [CONSTANT] datatype [NOT NULL] [:= | DEFAULT expr];
  ```
- **範例**：
  ```sql
  v_hiredate DATE;
  v_deptno NUMBER(2) NOT NULL := 10;
  v_location VARCHAR2(13) := 'Atlanta';
  c_comm CONSTANT NUMBER := 1400;
  ```
- 使用 `CONSTANT` 宣告常數，且必須在宣告時初始化。
- 使用 `:=` 或 `DEFAULT` 進行初始化；未賦值的變數預設為 `NULL`。

#### 4. 宣告變數的建議
- **一致的命名規範**：例如，用 `v_` 開頭表示變數，用 `c_` 開頭表示常數。
- **使用有意義的名稱**：避免簡單數字區分，建議使用描述性名稱。
- **避免使用資料表的欄位名稱作為變數名稱**：這樣容易產生混淆。當變數名稱與資料庫欄位名稱相同時，Oracle 預設會將其視為欄位名稱。
- **NOT NULL 約束 (必考)**：當變數必須包含值時，使用 `NOT NULL` 約束並進行初始化，**切記有not null一定要初始化**。

#### 5. 變數類型
- **Scalar**：單一數值（如 `NUMBER`、`VARCHAR2`、`DATE`）。
- **Reference**：指向存儲位置的指標（如指標變數）。
- **LOB（Large Object）**：用於儲存大數據物件（如 `BLOB`、`CLOB`）。
- **Composite**：可以包含多個元素，如集合或記錄類型。
- **Bind（非 PL/SQL 變數）**：在預編譯程式或其他環境中宣告的變數。

#### 6. `%TYPE` 屬性 **(必考)**
- **用途**：使變數可以自動採用某個表欄位的數據類型，保持變數和欄位的數據類型一致。
- **範例**：
  ```sql
  v_emp_name employees.first_name%TYPE;
  ```
  這樣即使 `employees` 表中的 `first_name` 欄位的數據類型改變，`v_emp_name` 的類型也會隨之改變。

#### 7. 賦值與字符串定界符
- **賦值運算符**：使用 `:=` 將值賦給變數，例如 `v_myName := 'John';`
- **字串定界符**：若字串中包含單引號（如 "Father's Day"），可以用雙單引號或 `q'!string!'` 的方式來避免語法錯誤。

```sql
-- e.g. 
DECLARE
    v_message VARCHAR2(50);
BEGIN
    -- 使用 q'!' 來定義包含單引號的字串
    v_message := q'!It's a beautiful day!';
    DBMS_OUTPUT.PUT_LINE(v_message);
END;
/

```
Output
```
It's a beautiful day!
```


#### 8. 常見的變數使用方法
- **在可執行區段中賦值和使用變數**：可以在 `BEGIN...END` 區段中多次為變數賦值。
- **作為參數傳遞**：可以將變數傳遞給 PL/SQL 的子程序（如程序或函數）。
- **用於存儲子程序的輸出**：變數可以用於儲存從函數返回的結果。
#### 9. 變數生命可見範圍(scope visibility declare)(必考)
- 若內外變數有相同名稱，內部區塊的變數，永遠高優先權
- 要取得外部變數，要在外部區塊加上標籤 
- e.g. `<<outer>> Declare  => outer.v_salary(使用標籤修飾名稱)`

### Chapter 4：Writing Executable Statements
#### 1. **Lexical Units（詞彙單位）**
   - **詞彙單位**是 PL/SQL 中的基本構件，包括字母、數字、符號、空白等。主要的類型如下：
     - **Identifiers（識別符號）**：例如變數名稱 `v_name`，不能使用關鍵字作為名稱。
     - **Delimiters（界定符號）**：如 `;`、`,`、`+`、`-`。
     - **Literals（文字值）**：如 `John`、`428`、`TRUE` 等文字和數值。
     - **Comments（註解）**：使用 `--` 進行單行註解，`/* ... */` 進行多行註解。

#### 2. **PL/SQL Block Syntax and Guidelines**
   - **語法結構**：PL/SQL 中的語法結構必須遵循指定的格式，包括區塊必須以 `BEGIN ... END` 包圍，並使用正確的縮排以提高可讀性。
   - **命名規範**：變數和程序的名稱應該有意義且具有描述性，遵循一致的命名規則。

#### 3. **SQL Functions in PL/SQL (必考)**
   - PL/SQL 支援內建的 SQL 函數，例如數學函數、字串函數、日期函數。
   - **不支援的函數**：例如 `DECODE` 函數及一些分組函數（如 `AVG`、`MIN`、`MAX`、`COUNT` 等）無法在 PL/SQL 中直接使用，但可以在使用Query(使用SQL引擎)賦值給變數前，使用只回傳1筆資料的函數。
```sql
-- e.g. 可以通過查詢獲取部門內的最高和最低薪資：
-- 宣告區段：宣告變數以儲存查詢結果
DECLARE
    v_min_salary NUMBER(10,2);  -- 儲存部門內最低薪資
    v_max_salary NUMBER(10,2);  -- 儲存部門內最高薪資
BEGIN
    -- 使用 SQL 查詢獲取指定部門（ID=10）內的最低和最高薪資
    SELECT MIN(salary), MAX(salary)
    INTO v_min_salary, v_max_salary  -- 將查詢結果賦值給宣告的變數
    FROM employees
    WHERE department_id = 10;  -- 過濾條件，僅查詢部門編號為 10 的員工

    -- 輸出結果到控制台，顯示最低和最高薪資
    DBMS_OUTPUT.PUT_LINE('Min Salary: ' || v_min_salary);  -- 顯示最低薪資
    DBMS_OUTPUT.PUT_LINE('Max Salary: ' || v_max_salary);  -- 顯示最高薪資
END;
/

```

#### 4. **使用序列（Sequences）**
   - 序列可用於產生唯一的數字標識（ID），通常在插入資料時使用。
   - 例子：
     ```sql
     v_id := sequence_name.NEXTVAL;
     ```
   - `NEXTVAL` 和 `CURRVAL` 是序列常用的屬性，分別代表下一個值和當前值。

#### 5. **資料型別轉換（Data Type Conversion）(必考)**
   - **隱式轉換**：PL/SQL 可以在某些情況下自動將資料型別轉換，如字串轉換成數字。
```sql
DECLARE
    -- 宣告數字與字串變數
    v_num NUMBER;               -- 用於儲存數字運算結果
    v_str VARCHAR2(10) := '123';  -- 字串型變數，儲存數字形式的字串
    v_date DATE := SYSDATE;      -- 當前日期
    v_message VARCHAR2(50);      -- 用於字串連接的訊息

BEGIN
    -- 1. 字串隱式轉換成數字
    v_num := v_str + 10;  -- 字串 '123' 自動轉為數字 123，與 10 相加得到 133
    DBMS_OUTPUT.PUT_LINE('Result of string to number conversion: ' || v_num);  -- 輸出 133

    -- 2. 數字隱式轉換成字串
    v_message := 'The total is ' || v_num;  -- 數字 133 被隱式轉換為字串 '133'
    DBMS_OUTPUT.PUT_LINE(v_message);  -- 輸出：The total is 133

    -- 3. 日期隱式轉換成字串
    v_message := 'Today is ' || v_date;  -- 日期型變數 v_date 被轉換為字串
    DBMS_OUTPUT.PUT_LINE(v_message);  -- 輸出當前日期，例如：Today is 11-NOV-24

    -- 4. 布林值隱式轉換
    IF v_num THEN  -- 在條件中，非零數字被隱式轉換為 TRUE
        DBMS_OUTPUT.PUT_LINE('The condition is TRUE because v_num is non-zero.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The condition is FALSE.');
    END IF;

    -- 5. 自動轉換運算（例如浮點數與整數相加）
    v_num := '5.5' + 2;  -- 字串 '5.5' 自動轉換為浮點數 5.5，與 2 相加得到 7.5
    DBMS_OUTPUT.PUT_LINE('Result of implicit conversion with floating-point: ' || v_num);  -- 輸出 7.5

END;
/

```
output
```
Result of string to number conversion: 133
The total is 133
Today is 11-NOV-24  -- 假設執行的日期為 11 月 24 日，格式可能依環境不同
The condition is TRUE because v_num is non-zero.
Result of implicit conversion with floating-point: 7.5

```
   - **顯式轉換**：使用內建函數（如 `TO_DATE`、`TO_NUMBER`）來轉換數據型別，以確保正確的型別符合。
```sql
DECLARE
    v_num VARCHAR2(10) := '123';           -- 儲存數字形式的字串
    v_date_str VARCHAR2(10) := '2024-11-11'; -- 日期字串
    v_date DATE;                            -- 日期型變數
    v_result NUMBER;                        -- 用於計算的數字型變數
    v_date_formatted VARCHAR2(20);          -- 用於存儲格式化後的日期字串
BEGIN
    -- 1. 使用 TO_NUMBER 將字串轉換成數字
    v_result := TO_NUMBER(v_num) + 10;  -- 將 '123' 顯式轉換為數字 123，並加上 10
    DBMS_OUTPUT.PUT_LINE('Result of explicit number conversion: ' || v_result);  -- 輸出 133

    -- 2. 使用 TO_DATE 將字串轉換為日期型別
    v_date := TO_DATE(v_date_str, 'YYYY-MM-DD');  -- 指定日期格式進行顯式轉換
    DBMS_OUTPUT.PUT_LINE('Converted date: ' || TO_CHAR(v_date, 'DD-MON-YYYY'));  -- 輸出格式化的日期，如：11-NOV-2024

    -- 3. 使用 TO_CHAR 將數字轉換為字串
    v_date_formatted := TO_CHAR(v_result);  -- 將數字 133 顯式轉換為字串 '133'
    DBMS_OUTPUT.PUT_LINE('Result of explicit char conversion: ' || v_date_formatted);  -- 輸出 133

    -- 4. 使用 TO_CHAR 格式化日期為特定格式
    v_date_formatted := TO_CHAR(v_date, 'YYYY/MM/DD');  -- 將日期轉換為特定格式的字串
    DBMS_OUTPUT.PUT_LINE('Formatted date: ' || v_date_formatted);  -- 輸出：2024/11/11
END;
/

```
#### 6. **嵌套區塊（Nested Blocks）(必考)**
   - PL/SQL 支援在 `BEGIN ... END` 區塊中嵌套多層區塊。
   - **作用域**：內層區塊中的變數只在該區塊內有效，而外層區塊的變數可以在內層區塊中存取。
   - 當嵌套區塊中變數名稱與外層區塊相同時，內層變數會覆蓋外層變數，稱為「遮蔽」。

#### 7. **運算符（Operators）**
   - PL/SQL 支援標準運算符，包括算術運算符（如 `+`、`-`、`*`）、比較運算符（如 `=`、`!=`）、邏輯運算符（如 `AND`、`OR`）等。
   - 這些運算符可在條件判斷、數值計算和邏輯運算中使用。

#### 8. **程式碼風格指南（Programming Guidelines）**
   - **縮排和可讀性**：良好的縮排和註解有助於提高程式碼的可讀性。
   - **命名規則**：變數和函數的名稱應該簡潔且具描述性。
   - **使用註解**：適當使用註解來說明程式碼邏輯和重要部分，特別是在複雜的運算或區塊中。

#### 9. **變數的作用域與可見性（Variable Scope and Visibility）(必考)**
   - 在嵌套區塊中，內部變數無法在外部區塊存取；而外部變數在內部區塊可見，除非內部有相同名稱的變數遮蔽。
   - **Qualifying Variables**：使用區塊標籤和變數名稱來確保正確的變數被調用。
### Chapter 5：Interacting whit Oracle Database Server:SQL Statements in PL/SQL Programs
#### 1. **SQL語句在PL/SQL中的使用**
   - **SQL 語句**：PL/SQL 支援在程式中嵌入 SQL 語句，這些語句包括 `SELECT`、`INSERT`、`UPDATE`、`DELETE`、`MERGE` 等，用於在 PL/SQL 中進行資料庫操作。
   - **查詢語句的使用**：可透過 `SELECT INTO` 來查詢單筆資料並儲存到變數中。若查詢多筆資料，則必須使用游標。
   - **常見語句**：
     ```sql
     DECLARE
         v_emp_name VARCHAR2(50);
     BEGIN
         -- 查詢單筆資料並儲存到變數中
         SELECT employee_name INTO v_emp_name 
         FROM employees 
         WHERE employee_id = 101;
         DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_emp_name);
     END;
     /
     ```

##### 1.1. **INSERT 語句**
   - **語法**：
     ```sql
     INSERT INTO table_name (column1, column2, ...)
     VALUES (value1, value2, ...);
     ```
   - **語法說明**：
     - `table_name`：插入資料的表名稱。
     - `(column1, column2, ...)`：指定要插入的欄位。
     - `VALUES`：指定要插入的值，需與欄位的數量和順序相符。
   - **範例**：
     ```sql
     BEGIN
         INSERT INTO employees (employee_id, employee_name, salary)
         VALUES (107, 'Emma Smith', 4500);
         DBMS_OUTPUT.PUT_LINE('Record inserted successfully.');
     END;
     /
     ```
     - 此範例將新的員工記錄插入到 `employees` 表中。

##### 1.2. **UPDATE 語句**
   - **語法**：
     ```sql
     UPDATE table_name
     SET column1 = value1, column2 = value2, ...
     WHERE condition;
     ```
   - **語法說明**：
     - `table_name`：更新資料的表名稱。
     - `SET`：指定要修改的欄位及其新值。
     - `WHERE`：條件，限制更新的範圍。若省略，會更新表中的所有行。
   - **範例**：
     ```sql
     BEGIN
         UPDATE employees
         SET salary = 5000
         WHERE employee_id = 107;
         DBMS_OUTPUT.PUT_LINE('Record updated successfully.');
     END;
     /
     ```
     - 此範例將員工 ID 為 107 的薪水更新為 5000。

##### 1.3. **DELETE 語句**
   - **語法**：
     ```sql
     DELETE FROM table_name
     WHERE condition;
     ```
   - **語法說明**：
     - `table_name`：刪除資料的表名稱。
     - `WHERE`：條件，限制刪除的範圍。若省略，會刪除表中的所有行。
   - **範例**：
     ```sql
     BEGIN
         DELETE FROM employees
         WHERE employee_id = 107;
         DBMS_OUTPUT.PUT_LINE('Record deleted successfully.');
     END;
     /
     ```
     - 此範例刪除員工 ID 為 107 的記錄。

##### 1.4. **MERGE 語句(必考)**
   - **語法**：
     ```sql
     MERGE INTO target_table t
     USING source_table s
     ON (t.key_column = s.key_column)
     WHEN MATCHED THEN
         UPDATE SET t.column1 = s.column1, t.column2 = s.column2, ...
     WHEN NOT MATCHED THEN
         INSERT (column1, column2, ...)
         VALUES (s.column1, s.column2, ...);
     ```
   - **語法說明**：
     - `MERGE INTO`：指定目標表 (`target_table`)。
     - `USING`：指定來源表 (`source_table`)。
     - `ON`：定義兩表的匹配條件。
     - `WHEN MATCHED THEN UPDATE`：當找到匹配的記錄時，執行更新操作。
     - `WHEN NOT MATCHED THEN INSERT`：當無法匹配到記錄時，執行插入操作。
   - **範例**：
     ```sql
     BEGIN
         MERGE INTO employees t
         USING new_employees s
         ON (t.employee_id = s.employee_id)
         WHEN MATCHED THEN
             UPDATE SET t.salary = s.salary
         WHEN NOT MATCHED THEN
             INSERT (employee_id, employee_name, salary)
             VALUES (s.employee_id, s.employee_name, s.salary);
         DBMS_OUTPUT.PUT_LINE('Merge operation completed.');
     END;
     /
     ```
     - 此範例會先檢查 `employees` 表中是否已存在 `new_employees` 表的 `employee_id`。如果存在，則更新 `salary`；如果不存在，則插入新的員工記錄。


#### 2. **DML（Data Manipulation Language）語句的操作**
   - **DML語句**：包括 `INSERT`、`UPDATE`、`DELETE` 和 `MERGE`。PL/SQL 允許在程式塊中進行資料的新增、修改、刪除和合併操作。
   - **例子**：
     ```sql
     -- 插入資料
     INSERT INTO employees (employee_id, employee_name) VALUES (105, 'John Doe');

     -- 更新資料
     UPDATE employees 
     SET employee_name = 'Jane Doe' 
     WHERE employee_id = 105;

     -- 刪除資料
     DELETE FROM employees WHERE employee_id = 105;
     ```

#### 3. **交易控制語句（Transaction Control Statements）**
   - **Transaction Control**：PL/SQL 支援 `COMMIT`、`ROLLBACK` 和 `SAVEPOINT` 等指令來控制交易。這些指令允許開發者管理資料庫的持久性，確保數據的完整性。
   - **重要指令**：
     - `COMMIT`：提交交易，永久儲存所有更改。
     - `ROLLBACK`：回復未提交的更改。
     - `SAVEPOINT`：設定保存點，允許部分回復。
   - **範例**：
     ```sql
     BEGIN
         INSERT INTO employees (employee_id, employee_name) VALUES (106, 'Alice');
         SAVEPOINT save_emp;  -- 設置保存點
         
         UPDATE employees SET employee_name = 'Alice Johnson' WHERE employee_id = 106;

         ROLLBACK TO save_emp;  -- 回復到保存點
         COMMIT;  -- 最後提交
     END;
     /
     ```

#### 4. **隱式游標與顯式游標（Implicit and Explicit Cursors）(必考)**
   - **游標的概念**：游標是用於查詢多筆資料的控制機制。當查詢結果返回多行時，需要使用游標來逐行處理。PL/SQL 提供隱式和顯式游標。
   - **隱式游標**：自動管理，適用於單行查詢。
     - 常用隱式游標屬性：
       - `%FOUND`：若查詢成功，則為 `TRUE`。
       - `%NOTFOUND`：若查詢失敗，則為 `TRUE`。
       - `%ROWCOUNT`：返回受影響的行數。
       - `%ISOPEN`：檢查游標是否開啟。
   - **隱式游標範例**：
     ```sql
     DECLARE
         v_salary NUMBER(10,2);
     BEGIN
         SELECT salary INTO v_salary FROM employees WHERE employee_id = 101;
         IF SQL%FOUND THEN
             DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
         END IF;
     END;
     /
     ```

   - **顯式游標**：手動管理，適用於多行查詢。
     - 顯式游標需要明確開啟、提取資料和關閉。
   - **顯式游標範例**：
       ```sql
       DECLARE
           CURSOR emp_cursor IS SELECT employee_name FROM employees WHERE department_id = 10;
           v_name employees.employee_name%TYPE;
       BEGIN
           OPEN emp_cursor;
           LOOP
               FETCH emp_cursor INTO v_name;
               EXIT WHEN emp_cursor%NOTFOUND;
               DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_name);
           END LOOP;
           CLOSE emp_cursor;
       END;
       /
       ```

### Chapter 6：Writing Control Structures

#### 1. **IF Statement（條件語句）(必考)**
   - **語法結構**：
     ```sql
     IF condition THEN
         statements;
     [ELSIF condition THEN
         statements;]
     [ELSE
         statements;]
     END IF;
     ```
   - **語法說明**：
     - `condition` 是布林表達式，回傳 `TRUE`、`FALSE` 或 `NULL`。
     - 當 `condition` 為 `TRUE` 時，會執行 `THEN` 內的語句。
     - 可以使用 `ELSIF` 和 `ELSE` 進行多條件判斷。
   - **範例**：
     ```sql
     DECLARE
         v_score NUMBER := 85;
     BEGIN
         IF v_score >= 90 THEN
             DBMS_OUTPUT.PUT_LINE('Grade: A');
         ELSIF v_score >= 80 THEN
             DBMS_OUTPUT.PUT_LINE('Grade: B');
         ELSE
             DBMS_OUTPUT.PUT_LINE('Grade: C');
         END IF;
     END;
     /
     ```
     - 此範例根據 `v_score` 的分數顯示不同的成績評等。

#### 2. **CASE Statement（多條件選擇）(必考)**
   - **語法結構**：
     ```sql
     CASE
         WHEN condition1 THEN result1
         WHEN condition2 THEN result2
         ...
         ELSE resultN
     END;
     ```
   - **語法說明**：
     - `CASE` 語句用於多條件選擇，可使用 `WHEN` 子句定義每個條件。
     - `ELSE` 子句是可選的，當所有 `WHEN` 條件皆不符合時執行。
   - **範例**：
     ```sql
     DECLARE
         v_dept_id NUMBER := 10;
         v_location VARCHAR2(50);
     BEGIN
         CASE v_dept_id
             WHEN 10 THEN v_location := 'New York';
             WHEN 20 THEN v_location := 'Los Angeles';
             ELSE v_location := 'Unknown';
         END CASE;
         DBMS_OUTPUT.PUT_LINE('Location: ' || v_location);
     END;
     /
     ```
     - 此範例根據 `v_dept_id` 的值設定 `v_location` 的地點。
- **Case賦值變數**：
    - 觀念:可以將 CASE 語句直接用於變數賦值，這樣可以根據條件設定變數的值而無需多次使用 IF-THEN 結構，從而簡化程式碼。
    ```sql
    variable := CASE
               WHEN condition1 THEN result1
               WHEN condition2 THEN result2
               ...
               ELSE resultN
            END;
    ```
- **範例**
    ```sql
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
    ```
- **條件為等號時的特殊使用方法**  
   - **觀念**：當 `CASE` 的 `WHEN` 條件是 `=` 比較時，可以在 `CASE` 後面直接放置要判斷的變數或值。這樣的寫法能簡化語法，不需要每個 `WHEN` 子句中重複該變數或值。

   - **語法**：
     ```sql
     CASE variable
         WHEN value1 THEN result1
         WHEN value2 THEN result2
         ...
         ELSE resultN
     END;
     ```
   - **語法說明**：
     - `variable` 是 `CASE` 判斷的目標變數或值。
     - 每個 `WHEN value THEN result` 用於檢查 `variable` 是否等於 `value`。
     - `ELSE` 子句是可選的，當沒有 `WHEN` 條件符合時執行。

   - **範例**：
     ```sql
     DECLARE
         v_status_code NUMBER := 2;
         v_status_message VARCHAR2(20);
     BEGIN
         v_status_message := CASE v_status_code
                                WHEN 1 THEN 'Pending'
                                WHEN 2 THEN 'Approved'
                                WHEN 3 THEN 'Rejected'
                                ELSE 'Unknown'
                             END;

         DBMS_OUTPUT.PUT_LINE('Status: ' || v_status_message);
     END;
     /
     ```
   - **範例說明**：
     - 在此範例中，`v_status_code` 為判斷的變數。根據其值進行對應的狀態訊息賦值：
       - 若 `v_status_code` 為 `1`，則 `v_status_message` 被賦值為 `'Pending'`。
       - 若 `v_status_code` 為 `2`，則 `v_status_message` 被賦值為 `'Approved'`。
       - 若 `v_status_code` 為 `3`，則 `v_status_message` 被賦值為 `'Rejected'`。
       - 若不符合上述條件，則 `v_status_message` 被設為 `'Unknown'`。



#### 3. **LOOP（迴圈）(必考)**
   - PL/SQL 提供三種類型的迴圈：基本迴圈、`FOR` 迴圈、`WHILE` 迴圈。每個迴圈的語法和用途如下：

   ##### 3.1. **Basic Loop（基本迴圈）**
   - **語法**：
     ```sql
     LOOP
         statements;
         EXIT WHEN condition;
     END LOOP;
     ```
   - **說明**：
     - 基本迴圈持續執行，直到遇到 `EXIT WHEN` 條件。
   - **範例**：
     ```sql
     DECLARE
         v_counter NUMBER := 1;
     BEGIN
         LOOP
             DBMS_OUTPUT.PUT_LINE('Counter: ' || v_counter);
             v_counter := v_counter + 1;
             EXIT WHEN v_counter > 5;
         END LOOP;
     END;
     /
     ```
     - 此範例計數並在計數器超過 5 時結束迴圈。

   ##### 3.2. **FOR Loop（計數迴圈）**
   - **語法**：
     ```sql
     FOR i IN start..end LOOP
         statements;
     END LOOP;
     ```
   - **說明**：
     - `FOR` 迴圈會在指定範圍內進行迭代，`i` 會從 `start` 到 `end` 自動增加。
   - **範例**：
     ```sql
     BEGIN
         FOR i IN 1..5 LOOP
             DBMS_OUTPUT.PUT_LINE('Iteration: ' || i);
         END LOOP;
     END;
     /
     ```
     - 此範例執行 5 次迭代，每次輸出 `i` 的當前值。

   ##### 3.3. **WHILE Loop（條件迴圈）**
   - **語法**：
     ```sql
     WHILE condition LOOP
         statements;
     END LOOP;
     ```
   - **說明**：
     - `WHILE` 迴圈會在條件為 `TRUE` 時執行，直到條件變為 `FALSE` 為止。
   - **範例**：
     ```sql
     DECLARE
         v_count NUMBER := 1;
     BEGIN
         WHILE v_count <= 5 LOOP
             DBMS_OUTPUT.PUT_LINE('Count: ' || v_count);
             v_count := v_count + 1;
         END LOOP;
     END;
     /
     ```
     - 此範例每次迭代計數並在 `v_count` 大於 5 時結束迴圈。

#### 4. **EXIT 與 CONTINUE 語句**
   - **EXIT**：結束當前迴圈。
   - **CONTINUE**：跳過當前迴圈剩餘的程式，進行下一次迭代。
   - **範例**：
     ```sql
     DECLARE
         v_total NUMBER := 0;
     BEGIN
         FOR i IN 1..10 LOOP
             IF MOD(i, 2) = 0 THEN
                 CONTINUE;  -- 若 i 為偶數，跳過當前迭代
             END IF;
             v_total := v_total + i;
         END LOOP;
         DBMS_OUTPUT.PUT_LINE('Total of odd numbers: ' || v_total);
     END;
     /
     ```
     - 此範例只累加奇數，`CONTINUE` 用於跳過偶數的計算。

### 補充:數學函式
#### 1. **ABS()**：絕對值
   - **作用**：返回數字的絕對值，即去掉數字的符號。
   - **語法**：
     ```sql
     ABS(number)
     ```
   - **範例**：
     ```sql
     SELECT ABS(-15) AS absolute_value FROM dual;
     -- 結果：absolute_value = 15
     ```

#### 2. **CEIL()**：向上取整
   - **作用**：返回大於或等於指定數字的最小整數（向上取整）。
   - **語法**：
     ```sql
     CEIL(number)
     ```
   - **範例**：
     ```sql
     SELECT CEIL(7.2) AS ceiling_value FROM dual;
     -- 結果：ceiling_value = 8
     ```

#### 3. **FLOOR()**：向下取整
   - **作用**：返回小於或等於指定數字的最大整數（向下取整）。
   - **語法**：
     ```sql
     FLOOR(number)
     ```
   - **範例**：
     ```sql
     SELECT FLOOR(7.8) AS floor_value FROM dual;
     -- 結果：floor_value = 7
     ```

#### 4. **ROUND()(必考)**：四捨五入
   - **作用**：將數字四捨五入到指定的小數位數。
   - **語法**：
     ```sql
     ROUND(number, decimal_places)
     ```
   - **範例**：
     ```sql
     SELECT ROUND(15.678, 2) AS rounded_value FROM dual;
     -- 結果：rounded_value = 15.68
     ```

#### 5. **TRUNC()**：截取數字
   - **作用**：將數字截取到指定的小數位數，而不進行四捨五入。
   - **語法**：
     ```sql
     TRUNC(number, decimal_places)
     ```
   - **範例**：
     ```sql
     SELECT TRUNC(15.678, 2) AS truncated_value FROM dual;
     -- 結果：truncated_value = 15.67
     ```

#### 6. **POWER()**：次方
   - **作用**：返回指定數字的指定次方。
   - **語法**：
     ```sql
     POWER(number, exponent)
     ```
   - **範例**：
     ```sql
     SELECT POWER(2, 3) AS power_value FROM dual;
     -- 結果：power_value = 8
     ```

#### 7. **SQRT()**：平方根
   - **作用**：返回指定數字的平方根。
   - **語法**：
     ```sql
     SQRT(number)
     ```
   - **範例**：
     ```sql
     SELECT SQRT(25) AS square_root FROM dual;
     -- 結果：square_root = 5
     ```

#### 8. **EXP()**：指數
   - **作用**：返回 e（自然對數的基數，約等於 2.718）提升到指定次方的值。
   - **語法**：
     ```sql
     EXP(number)
     ```
   - **範例**：
     ```sql
     SELECT EXP(1) AS exp_value FROM dual;
     -- 結果：exp_value ≈ 2.718
     ```

#### 9. **LN() 和 LOG()**：自然對數與對數
   - **LN()**：返回指定數字的自然對數。
   - **LOG()**：返回指定數字在指定基數下的對數。
   - **語法**：
     ```sql
     LN(number)
     LOG(base, number)
     ```
   - **範例**：
     ```sql
     SELECT LN(2.718) AS natural_log, LOG(10, 100) AS log_value FROM dual;
     -- 結果：natural_log ≈ 1, log_value = 2
     ```

#### 10. **SIGN()**：符號函數
   - **作用**：返回數字的符號。若數字為正數，返回 1；若為負數，返回 -1；若為零，返回 0。
   - **語法**：
     ```sql
     SIGN(number)
     ```
   - **範例**：
     ```sql
     SELECT SIGN(-25) AS sign_value FROM dual;
     -- 結果：sign_value = -1
     ```

