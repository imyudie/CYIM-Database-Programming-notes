/*


t1 表格中應該有 10 筆資料列。

你要撰寫一個命令稿, 將 t1 表格中的資料列的值小於閾值的資料列插入到 t1_keep 表格中，並刪除 t1 表格中的這些資料列。 這個閾值存於一個綁定變數(bind variable)中，值為 50。

依照下列步驟來完成:

宣告一個綁定變數(bind variable)來存儲一個閾值
設定閾值為 50
寫一個空的 PL/SQL 區塊
在區塊中，寫一個 INSERT WITH SUBQUERY 語句，將 t1 表格中的資料列的值小於閾值的資料列插入到 t1_keep 表格中。
輸出 INSERT 語句影響的資料列數
在同一個區塊中，寫一個 DELETE 語句，刪除 t1 表格中的資料列的值小於閾值的資料列。
輸出 DELETE 語句影響的資料列數
Commit 區塊中的交易
在區塊之後，撰寫 Query, 查詢 t1_keep 表格來檢查結果。
範例輸出：

PL/SQL procedure successfully completed.
Rows kept: 3
Rows deleted: 3

PL/SQL procedure successfully completed.
        ID        VAL
        ---------- ----------
                 3          3         
                 7         23         
                 8         10
*/
-- 原始表格
create table t1 (id number primary key, val number);

-- 用來保留將要刪除的資料列的表格
create table t1_keep (id number primary key, val number);

-- 新增 10 筆隨機數值的資料列至 t1 表格
insert into t1 
select rownum, round(dbms_random.value(1,100),0)  from dual connect by level <= 10;

-- 查看表格 t1
select * from t1;

commit;
/
set serveroutput on
VARIABLE v_threshold NUMBER
exec :v_threshold := 50;

BEGIN
    insert into T1_KEEP(id, val) 
    select id,VAL
    from T1
    where VAL < :v_threshold;
    DBMS_OUTPUT.PUT_LINE('Rows kept: ' || SQL%ROWCOUNT);
    delete from T1
    where VAL < :v_threshold;
    DBMS_OUTPUT.PUT_LINE('Rows deleted: ' || SQL%ROWCOUNT);
    commit;
END;
/
SELECT * FROM T1_KEEP;
