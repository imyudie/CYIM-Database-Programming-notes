CREATE TABLE retired_emps
  (
    EMPNO     NUMBER(4),
    ENAME     VARCHAR2(10), -- last name
    JOB       VARCHAR2(9),  -- job id
    MGR       NUMBER(4),    -- manager id
    HIREDATE  DATE,
    LEAVEDATE DATE,
    SAL       NUMBER(7,2),  -- salary
    COMM      NUMBER(7,2),  -- commission percentage
    DEPTNO    NUMBER(2)     -- department number
  );

DECLARE
  -- Declare the record variable for the table retired_emps.
  v_retired_emps retired_emps%ROWTYPE;
BEGIN
  -- Task 1: 
  select employee_id, last_name, job_id, manager_id, hire_date, 
         NULL, salary, commission_pct, department_id
  into v_retired_emps
  FROM employees
  WHERE employee_id = 124;
  
  -- Task 2:
  insert INTO retired_emps
  VALUES v_retired_emps;
  
  -- Task 3:
  v_retired_emps.leavedate := SYSDATE;

  -- Task 4:
  UPDATE retired_emps
  set 
    ename = v_retired_emps.ename,
    job = v_retired_emps.job,
    mgr = v_retired_emps.mgr,
    hiredate = v_retired_emps.hiredate,
    leavedate = v_retired_emps.leavedate,
    sal = v_retired_emps.sal,
    comm = v_retired_emps.comm,
    deptno = v_retired_emps.deptno
  WHERE empno = v_retired_emps.empno;
END;
/
select * from retired_emps;
drop TABLE retired_emps;