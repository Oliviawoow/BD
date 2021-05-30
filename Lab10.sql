-- ex:
create table exemplu (
    data_implicita date default sysdate,
    numar_implicit number(7,2) default 7.24,
    string_implicit varchar2(5) default 'test',
    operator varchar2(10) default user
);

-- ex1:
create table studenti (
    facultate char(30) default 'Automatica si Calculatoare',
    catedra char(20),
    cnp number(13),
    nume varchar2(30),
    data_nasterii date,
    an_univ number(4) default 2019,
    medie_admitere number(4,2),
    discip_oblig varchar2(20) default 'Matematica',
    discip_opy varchar(20) default 'Fizica',
    operator varchar(20) default user,
    data_op timestamp default sysdate
);

-- ex2:
create table dept_20 as
select id_dep, nume, data_ang,
    salariu + nvl(comision, 0) venit
from angajati
where id_dep = 20;

-- ex3:
create table dept_30 (
    id default 30,
    nume not null,
    data_ang,
    prima
) as
select id_dep, nume, data_ang,
    round(0.15 * (salariu + nvl(comision, 0)), 0)
from angajati
where id_dep = 30;

-- ex:
create table exemplu2 (
    col1 number(2) constraint nn_col1 not null,
    col2 varchar2(20) NOT NULL
);

create table exemplu3 (
    col1 number(2) constraint uq_col1 unique,
    col2 varchar2(20) unique
);

create table exemplu4 (
    col1 number(2),
    col2 varchar2(20),
    constraint uq_col1_a unique(col1),
    unique(col2)
);

create table exemplu5 (
    col1 number(2),
    col2 varchar2(20),
    constraint uq_col2 unique(col1, col2)
);

-- ex4:
create table functii (
    cod number(2) constraint pk_cod primary key,
    functie varchar2(20),
    data_vigoare date default sysdate
);

-- ex5:
create table persoane (
    nume varchar2(20),
    prenume varchar2(20),
    serie_ci varchar2(2),
    cod_ci number(6),
    cnp number(13),
    constraint pk_persoane primary key(serie_ci, cod_ci, cnp)
);

-- ex6:
create table angajati2 (
    id_ang number(4)
        constraint pk_id_ang2
        primary key,
    id_sef number(4),
    id_dep number(2)
        constraint fk_id_dep2
        references functii(cod),
    nume varchar2(20),
    functie varchar2(9),
    data_ang date,
    salariu number(7,2),
    comision number(7,2),
    constraint fk_id_sef2
        foreign key(id_sef)
        references angajati2(id_ang)
);

-- ex7:
create table angajati3 (
    id_ang number(4) constraint pk_id_ang3 primary key,
    nume varchar(10) constraint ck_nume check(nume=upper(nume)),
    functie varchar2(10),
    id_sef number(4) constraint fk_id_def3 references angajati3(id_ang),
    data_ang date default sysdate,
    salariu number(7,2) constraint nn_id_dep3 not null,
    comision number(7,2),
    id_dep number(2) constraint nn_id_dep3 not null,
    constraint fk_id_dep3 foreign key (id_dep)
        references departamente(id_dep),
    constraint ck_comision check(comision <= salariu)
);

-- ex:
create table example6 (
    colA number(2), col2 number(2), col3 number(2),
    col4 number(2), col5 number(2), col6 number(2),
    col7 number(2), col8 number(2), col9 number(2)
);

alter table example6 rename to exampleAlter;
alter table exampleAlter rename column colA to col1;
alter table exampleAlter modify (col1 varchar2(20));
alter table exampleAlter modify (col2 varchar2(20), col3 date);
alter table exampleAlter set unused(col4);
alter table exampleAlter set unused(col5, col6);
alter table exampleAlter drop unused columns;
alter table exampleAlter add
(col4 varchar2(20), col5 varchar2(20), col6 varchar2(20));
alter table exampleAlter add constraint uq_col45_alter unique(col4, col5);
alter table exampleAlter disable constraint uq_col3_alter;
alter table exampleAlter enable constraint uq_col3_alter;
alter table exampleAlter drop constraint uq_col3_alter;
alter table angajati add venit number(4, 3);
alter table angajati add (vechime number(4), venit_anual number(6, 2));

drop table example;

truncate table exemplu1;

-- ex:
create table dept2 (
    id_dep number(2),
    dname varchar2(14)
);

insert into dept2 values (50, IT);
insert into dept2(id_dep) values (50);

insert into dept2
select deptno, dname
    from dept
    where deptno in (20, 30);

select * from dept2;

-- ex:
update dept2
set dname = 'HR',
    id_dep = 80
where id_dep = 50;

update dept2
set dname = 'Human Res'
where id_dep = 80;

update dept2
set (id_dep, dname) = (select deptno, dname
                        from dept
                        where deptno = 10)
where id_dep = 20;

-- ex:
delete from dept2
where id_dep = 80;

select * from dept2;

delete from dept2
where (id_dep, dname) in (select deptno, dname
                          from dept
                          where deptno in (10, 30));

select * from dept2;

delete from dept2;

-- ex:
create sequence seq_id_dep
start with 1
increment by 10
nocache
nocycle;

alter sequence seq_id_dep cycle;

insert into dept2
values(seq_id_dep.nextval, 'test');

drop sequence seq_id_dep;

-- ex:
create index idx_name on dept2(dname);
alter index idx_name initrans 5 storage (next 100k);
drop index idx_name;

-- ex:
create or replace view view_dept
    as select id_dep, den_dep from departamente;

select * from view_dept;

insert into view_dept values(80, 'test');

select * from view_dept;

update view_dept set den_dep='HR' where id_dep = 80;

select * from view_dept;

delete from view_dept where id_dep = 80;

drop view view_dept;