LAB 07:
-- Ex 1:
select nume, to_char (data_ang, 'dd-mm-yyyy') data_ang
from angajati
where to_char (data_ang, 'YYYY') like '1982';

select nume, to_char(data_ang, 'dd-mm-yyyy') data_ang
from angajati
where to_date (to_char(data_ang, 'YYYY'), 'YYYY') = 
      to_date (to_char(1982), 'YYYY');

select nume, to_char(data_ang, 'dd-mm-yyyy') data_ang
from angajati
where to_number(to_char(data_ang, 'YYYY')) = 1982;

-- 
column numar format 99999
select 123.14 numar from dual;

column numar format 999.99
select 123.14 numar from dual;

column numar format $999.99
select 123.12 numar from dual;

column numar format 00999.99
select 123.14 numar from dual;
select 0.14 numar from dual;

select greatest (23, 12, 34, 77, 89, 52) gr
from dual;

select least (23, 12, 34, 77, 89, 52) lst
from dual;

select greatest ('15-JAN-1985', '23-AUG-2001') gr
from dual;

select least ('15-JAN-1985', '23-AUG-2001') lst
from dual;

-- Ex 2:
select nume, functie, salariu,
    decode(functie, 'MANAGER', salariu*1.25,
                    'ANALYST', salariu*1.24,
                    salariu/4) prima
from angajati
where id_dep = 20
order by functie;

-- Ex 3:
select nume, functie, salariu,
    to_char(data_ang, 'YYYY') an_ang,
    decode(sign(data_ang - to_date('1-JAN-1982')),
           -1, salariu*1.25, salariu*1.10) prima
from angajati
where id_dep = 20
order by functie;

--
select
	case lower(locatie)
		when 'new york' then 1
		when 'dallas' then 2
		when 'chicago' then 3
		when 'boston' then 4
	end cod_dep
from departament;

select nume
from angajati
where id_ang = (case functie
	when 'SALESMAN' then 7844
	when 'CLERK' then 7900
	when 'ANALYST' then 7902
	else 7839
end);

select
	case
		when lower(locatie) = 'new york' then 1
		when id_dep = 20 or lower(locatie) = 'dallas' then 2
		when lower(locatie) = 'chicago' then 3
		when id_dep = 40 then 4
		else 5
	end cod_dep
from departament;

select nume
from angajati
where id_ang = (case
	when functie = 'SALESMAN' then 7844
	when functie = 'CLERK' then 7900
	when functie = 'ANALYST' then 7902
	else 7839
end);

set null NULL
select nume, comision, nvl(comision, 0) nvl_com, salariu + comision "Sal + Com", salariu + nvl(comision, 0) "sal + nvl_com"
from angajati
where id_dep = 30;
set null ''

-- Ex 4:
select avg(salariu) salariu from angajati;
select avg(all salariu) salariu from angajati;
select avg(distinct salariu) salariu from angajati;

-- Ex5:
select id_dep, avg(salariu) from angajati
group by id_dep
order by 1;

-- Ex 6:
select id_dep, avg(salariu + nvl(comision, 0))
from angajati
group by id_dep
having avg(salariu + nvl(comision, 0)) > 2000;

-- Ex 7:
select id_dep, count(*) nr_ang, 
	count(salariu) count, 
	count (all salariu) count_all, 
	count(distinct salariu) count_distinct
from angajati
group by id_dep
order by 1;

-- Ex 8:
select id_dep,
	count(functie) count, 
	count(distinct functie) count_distinct
from angajati
group by id_dep
having count (distinct functie) >= 2
order by 1;

-- Ex 9:
select d.den_dep,
	min(a.salariu) sal_min,
	min(distinct a.salariu) sal_min_d,
	max (a.salariu) sal_max,
	max(distinct a.salariu) sal_max_d,
	sum(a.salariu) sal_sum,
	sum(distinct a.salariu) sal_sum_d
from angajati a natural join departamente d
group by d.den_dep
order by d.den_dep;

-- Ex 10:
select id_dep,
    variance (salariu) sal_varstd,
    variance (distinct salariu) sal_varstd_d,
    stddev(salariu) sal_devstd,
    stddev (distinct salariu) sal_devstd_d,
    stddev (comision) com_devstd
from angajati
group by id_dep
order by 1;

-- Ex individual 1:
select sef.id_ang, sef.nume, nr_subalterni, min_sal, avg_sal, max_sal, d.den_dep
from angajati sef
        inner join (select count(*) as nr_subalterni,
                           min(a.SALARIU) as min_sal,
                           avg(a.SALARIU) as avg_sal,
                           max(a.SALARIU) as max_sal,
                           id_sef as a_id_sef
                    from angajati a
                    group by a.id_sef)
        on sef.id_ang = a_id_sef
        inner join departamente d on d.id_dep = sef.id_dep;

-- Ex individual 2:
select initcap(a.nume) nume_ang, lower(d.den_dep) den_dep, to_char(a.data_ang, 'MM-YYYY') data_ang,
case
    when g.grad = 2 and extract(year from a.data_ang) = extract(year from sef.data_ang)
        then a.salariu * sqrt(&c * LOG((SYSDATE - a.data_ang) / 30, 2))
    when g.grad = 4 and extract(year from a.data_ang) = extract(year from sef.data_ang)
        then a.salariu * sqrt(&c * LOG((SYSDATE - a.data_ang) / 30, 3))
    else 0
    end
    prima, g.grad grad, initcap(sef.nume) nume_sef, lower(dep_sef.den_dep) den_dep_sef
from angajati a
    inner join departamente d on a.id_dep = d.id_dep
    inner join grila_salariu g on a.salariu between g.nivel_inferior and g.nivel_superior
    left outer join (
        angajati sef inner join departamente dep_sef on sef.id_dep = dep_sef.id_dep)
    on a.id_sef = sef.id_ang
order by a.nume;