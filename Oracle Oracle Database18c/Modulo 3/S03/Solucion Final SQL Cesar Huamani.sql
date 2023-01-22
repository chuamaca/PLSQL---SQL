/*
ROL: personal, administrativo, analista
*/


create user juan identified by juan;
create role personal;
grant create session to personal;
grant personal to juan;


create user juana identified by juana;
create role administrativo;
grant personal to administrativo;
grant administrativo to juana;
GRANT CREATE TABLE TO ADMINISTRATIVO;


create user alex identified by alex;
create user maria identified by maria;
create role analista;
grant analista to alex, maria;
grant select, insert on hr.employees to analista;





