-- ejemplo del tercer parametro en el RAISE_APPLICATION_ERROR

delete from DEPARTMENTS -- TABLA PADRE

-- sin parametro TRUE. 

declare
e_fk_err exception;
pragma EXCEPTION_INIT (e_fk_err, -02292);
begin
    delete from DEPARTMENTS;
exception
    when e_fk_err then
    RAISE_APPLICATION_ERROR (-20001, 'error');
end;

-- ahora se le agrega el parametro true
-- te permite agregar tambien un mensaje personalizado cuando se muestra el error.

declare
e_fk_err exception;
pragma EXCEPTION_INIT (e_fk_err, -02292);
begin
    delete from DEPARTMENTS;
exception
    when e_fk_err then
    RAISE_APPLICATION_ERROR (-20001, 'error',true);
end;