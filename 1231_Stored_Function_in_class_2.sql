create or REPLACE FUNCTION get_dept_name(
    p_emp_id employees.employee_id%type
)RETURN VARCHAR2 AS
    l_dept_name departments.DEPARTMENT_NAME%TYPE;
BEGIN
    SELECT d.department_name into l_dept_name
    from employees e join departments d 
    using(department_id)
    where employee_id = p_emp_id;
    RETURN l_dept_name;
end;
/
DECLARE
    l_dept_name departments.DEPARTMENT_NAME%TYPE;
BEGIN
    l_dept_name := get_dept_name(100);
    dbms_output.put_line(l_dept_name);
end;
/
select employee_id ,get_dept_name(employee_id) "dep_name"
from EMPLOYEES;