create or replace PROCEDURE RAISE_USER_DEFINE_ERROR AS 
BEGIN
  raise_application_error(-20000, 'Throw an app error. User-defined error.');
END RAISE_USER_DEFINE_ERROR;
/
set serveroutput on
declare
    e_user_define_error exception;
    pragma exception_init(e_user_define_error, -20000);
BEGIN

-- Add codes 
-- call the procedure RAISE_USER_DEFINE_ERROR
raise_user_define_error();
EXCEPTION
    WHEN e_user_define_error THEN
        dbms_output.put_line('Err Msg:'||sqlerrm);
-- Add codes 

END;
/