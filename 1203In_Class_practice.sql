declare
    type emp_aa_t is table of employees%rowtype
        index by pls_integer;
    
    emp_aa emp_aa_t;
begin
    
    select * bulk collect into emp_aa
    from employees
    where department_id = 90;

     for i in 1..emp_aa.count loop
         dbms_output.put_line('Employee ID: ' || emp_aa(i).employee_id);
         dbms_output.put_line('Employee Salary: ' || emp_aa(i).salary);
     end loop;
end;
/