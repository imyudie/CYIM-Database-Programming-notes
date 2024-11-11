-- Prepare the table and data
create table order_master(
  order_id number,
  order_total number
);

create table monthly_orders(
    order_id number,
    order_total number
);

insert into order_master values (1, 1000);
insert into order_master values (2, 2000);
insert into order_master values (3, 3000);
insert into order_master values (4, null);

insert into monthly_orders values(2, 2500);
insert into monthly_orders values(3, null);
commit;

/
/*
上述程式建立了二個表格 order_master 及 monthly_orders。
前者內有 4 筆訂單資料, 後者內有 2 筆訂單資料。
你需將 monthly_orders 表格中的資料合併到 order_master 表格中。

請完成以下要求:

在 PL/SQL 程式碼中撰寫 MERGE 敘述, 合併 monthly_orders 表格中的資
料列到 order_master 表格。合併過程中, 若資料列的 order_total 的值
為 null, 刪除該筆資料。
*/
MERGE INTO order_master OM
using monthly_orders MO
on (OM.order_id = MO.order_id)
when matched then
    update set OM.order_total = MO.order_total
    delete where (OM.order_total is null)
when not matched then
    insert (OM.order_id, OM.order_total) values (MO.order_id, MO.order_total);
commit;   
/
SELECT * FROM order_master;
drop table order_master;
drop table monthly_orders;
