DECLARE
    emp_rec employees%rowtype;
BEGIN
    select * into emp_rec
    from employees
    where employee_id = 100;
    DBMS_OUTPUT.PUT_LINE(emp_rec.first_name);
END;
/
--紀錄emp_data
DECLARE
    Type emp_data_type is record(
        emp_id number(6,0),
        fname VARCHAR2(20),
        last_name VARCHAR2(25)
    );
    emp_data emp_data_type;
BEGIN
    select employee_id, first_name, last_name
    into emp_data
    from EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    DBMS_OUTPUT.PUT_LINE(emp_data.fname);
END;
/
/*
emp
|id|fname|lname|
|1|'A'|'B'|
Declare
    emp_rec emp%rowtype;
    --[id,fname,lname]
Begin
    emp_rec.id = 1;
    emp_rec.fname = 'A';
    emp_rec.lname = 'B';
    insert into emp(id,fname,lname) values emp_rec;
    update emp set Row = emp_rec where id = emp_rec.id; 
*/