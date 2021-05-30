LAB 6:
-- functii numerice
-- returneaza -1
select SIGN(-12) from dual;

-- returneaza 12
select ABS(-12) from dual;

-- returneaza 15
select CEIL(14.2) from dual;

-- definire PI
DEFINE pi = '(select asin(1)*2 from dual'

-- returneaza 0.5
select SIN(30 * &pi / 180) sin from dual;

-- returneaza 0.5
select COS(60 * &pi / 180) cos from dual;

-- returneaza -1
select TAN(135 * &pi / 180) tan from dual;

-- returneaza 1.17520119
select SINH(1) sinh from dual;

-- returneaza 1
select COSH(0) cosh from dual;

-- returneaza 0.462117157
select TANH(0.5) tanh from dual;

-- returneaza 0.523598776
select ASIN(0.5) asin from dual;

-- returneaza 1.57079633
select ACOS(0.5) acos from dual;

-- returneaza 0.785398163
select ATAN(1) atan from dual;

-- returneaza 54.59815
select EXP(4) exp from dual;

-- returneaza 9
select POWER(3, 2) power from dual;

-- returneaza 3
select SQRT(9) sqrt from dual;

-- returneaza 4.55387689
select LN(95) ln from dual;

-- returneaza 2
select LOG(10, 100) log from dual;

-- returneaza 4
select MOD(14, 5) mod from dual;

-- returneaza 15.2
select ROUND(15.193, 1) from dual;

-- returneaza 15
select ROUND(15.193) from dual;

-- returneaza 20
select ROUND(15.193, -1) from dual;

-- returneaza 15.1
select TRUNC(15.193, 1) from dual;

-- returneaza 15
select TRUNC(15.193) from dual;

-- returneaza 10
select TRUNC(15.193, -1) from dual;

-- functii pentru siruri de caractere
-- returneaza K
select CHR(75) from dual;

-- returneaza KING este PRESIDENT
select CONCAT(CONCAT(nume, ' este '), functie) ANG_FUNC
	from angajati
	where id_ang = 7839;

-- returneaza King
select INITCAP(nume) ex_initcap
	from angajati
	where id_ang = 7839;

-- returneaza BLACK si BLUE
select REPLACE('JACK si JUE', 'J', 'BL') EX_REPLACE
	from dual;

select RPAD(nume, 10, '*') EX_RPAD
	from angajati where id_dep = 10;

select LPAD(nume, 10, '*') EX_LPAD
	from angajati where id_dep = 10;

-- returneaza Pope
select RTRIM('Popescu', 'scu') from dual;

-- returneaza ope
select SUBSTR('Popescu', 2, 3) from dual;

-- returneaza 7
select INSTR('Protopopescu', 'op', 3, 2) from dual;

-- returneaza 7
select LENGTH('analyst') from dual;

-- am inlocuit O cu spatiu si m cu p
select TRANSLATE('Oana are mere', 'Om', ' p') from dual;
-- functii pentru date calendaristice
select nume, data_ang, ADD_MONTHS(data_ang, 3) data_mod
	from angajati
	where id_dep = 10;

select nume, data_ang, LAST_DAY(data_ang) ultima_zi
	from angajati
	where id_dep = 10;

select NEXT_DAY('24-MAR-2014', 'MONDAY') urmatoarea_luni
	from dual;

select nume, data_ang,
	MONTHS_BETWEEN('01-JAN-2014', data_ang) luni_vechime1,
	MONTHS_BETWEEN(data_ang, '01-JAN-2014') luni_vechime2
from angajati
where id_dep = 10;

select
	data_ang,
	ROUND(data_ang, 'YEAR') rot_an
from angajati
where id_ang = 7369;

select
	data_ang,
	ROUND(data_ang, 'MONTH') rot_luna
from angajati
where id_ang = 7369;

select
	data_ang,
	TRUNC(data_ang, 'YEAR') trunc_an
from angajati
where id_ang = 7369;

select
	data_ang,
	TRUNC(data_ang, 'MONTH') trunc_luna
from angajati
where id_ang = 7369;

select SYSDATE from dual;

-- extrag ziua
select EXTRACT(DAY from sysdate) from dual;

-- extrag luna
select EXTRACT(MONTH from sysdate) from dual;

-- extrag anul
select EXTRACT(YEAR from sysdate) from dual;


select
	data_ang,
	data_ang + 7,
	data_ang - 7,
	sysdate - data_ang
from angajati
where data_ang like '%JUN%';

-- schimbam formatul datei la nivel de sesiune in DD-MM-YYYY
alter session set NLS_DATE_FORMAT='DD-MM-YYYY';
select sysdate from dual;

-- schimbam formatul datei la nivel de sesiune in DD-MM-YYYY HH24:MI:SS
alter session set NLS_DATE_FORMAT='DD-MM-YYYY HH24:MI:SS';
select sysdate from dual;


-- schimbam formatul datei la nivel de sesiune in DAY MONTH YEAR
alter session set NLS_DATE_FORMAT='DD-MONTH-YYYY';
select replace(sysdate, ' ', '') from dual;