-- script para obtener los privilegios de un usuario en oracle


--Those views only show the privileges granted directly to the user. Finding all the privileges, including those granted indirectly through roles, requires more complicated recursive SQL statements

select * from dba_role_privs connect by prior granted_role = grantee start with grantee = '&USER' order by 1,2,3;
select * from dba_sys_privs  where grantee = '&USER' or grantee in (select granted_role from dba_role_privs connect by prior granted_role = grantee start with grantee = '&USER') order by 1,2,3;
select * from dba_tab_privs  where grantee = '&USER' or grantee in (select granted_role from dba_role_privs connect by prior granted_role = grantee start with grantee = '&USER') order by 1,2,3,4;