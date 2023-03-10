set echo off
-- DROP USER
DROP USER lab10 CASCADE;
-- USER SQL
CREATE USER lab10 IDENTIFIED BY oracle 
DEFAULT TABLESPACE SYSAUX
TEMPORARY TABLESPACE TEMP;

-- QUOTAS
ALTER USER lab10 QUOTA UNLIMITED ON SYSAUX;

-- ROLES
GRANT "CONNECT" TO lab10 ;

-- SYSTEM PRIVILEGES
GRANT CREATE SEQUENCE TO lab10 ;
GRANT CREATE TABLE TO lab10 ;

-- OBJECT PRIVILEGES
GRANT SELECT ON hr.employees TO lab10;
GRANT SELECT ON hr.departments TO lab10;
GRANT SELECT ON hr.jobs TO lab10;
GRANT SELECT ON hr.locations TO lab10;
GRANT SELECT ON hr.countries TO lab10;
GRANT SELECT ON hr.regions TO lab10;

