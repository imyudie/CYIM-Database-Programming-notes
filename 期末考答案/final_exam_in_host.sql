create or REPLACE function department_count(
    p_department_id employees.department_id%type
)
return number as
    v_count number;
begin
    select count(*)
    into v_count
    from employees
    where department_id = p_department_id;
    return v_count;
end;
/
select department_id AS "部門編號", department_name AS "部門名稱", department_count(department_id) AS "員工人數"
from departments;