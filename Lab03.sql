LAB 3:
-- ex 1:

create table angajati (
    id_ang NUMBER(4),
    nume VARCHAR(20),
    functie VARCHAR2(9),
    id_sef NUMBER(4),
    data_ang DATE,
    salariu NUMBER(7, 2),
    comision NUMBER(7, 2),
    id_dep NUMBER(2)
);

insert into angajati select * from emp;

create table angajati as select * from emp;

select id_ang, nume, functie, salariu
from angajati
where id_sef = &id_sef;

-- ex 2:

select nume, '&functie' functie, salariu
from angajati
where functie = &functie;

-- ex 3:

select nume, functie, &salariu_anual salariu_anual
from &tabel
where &nume_coloana = &valoare_coloana;

-- ex 4:

select nume, functie, &&venit_lunar venit_lunar
from angajati
where &venit_lunar > 2000;

-- ex 5:

select id_ang, nume, functie, data_ang
from angajati
where functie = '&1' and data_ang > '&2'
order by data_ang;

-- ex 6:

accept functie_ang char prompt 'Introduceti functia angajatului:'

select nume, salariu, comision
from angajati 
where functie = '&functie_ang';

undefine functie_ang

-- ex 7:

accept id_ang char prompt 'Introduceti ecusonul angajatului:'
accept nume char prompt 'Introduceti numele angajatului:'
accept functie char prompt 'Introduceti functia angajatului:'
accept salariu char prompt 'Introduceti salariul angajatului:' hide

insert into angajati(id_ang, nume, functie, salariu)
values(&id_ang, '&nume', '&functie', &salariu);

undefine id_ang
undefine functie
undefine nume
undefine salariu

-- ex 8:

define procent_prima = 0.15
define id_dep = 20

select nume, salariu, salariu*&procent_prima prima
from angajati
where id_dep = &id_dep;

undefine procent_prima
undefine id_dep

-- ex individual:

-- 1:
select nume, id_dep, salariu
from angajati
where id_dep = &id_dep and salariu > &salariu_anual;

-- 2:
select nume, id_dep, salariu
from angajati
where id_dep = &&id_dept and salariu > &&venit_anual;

undefine id_dept
undefine venit_anual

-- 3:
select nume, id_dep, salariu
from angajati
where id_dep = &1 and salariu > &2;

-- 4:
accept id_dept char prompt 'Id dept:'
accept venit char prompt 'Venit:'

select nume, id_dep, salariu
from angajati
where id_dep = &id_dept and salariu > &venit;

undefine id_dept
undefine venit