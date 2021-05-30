-- Ex 1:
set lines 120
set pagesize 24
set space 2
set newpage 5
set heading off
set feedback off

-- Ex 2:
column id_dep format 099 heading 'Departament' justofy center
column functie format A10 heading 'Job' justify left
column id_ang format 9999 heading 'Ecuson' justify center
column salariu format 99,999
column comision fromat 99,999.99 null 0
column venit format 99,999.99 heading 'Venit Lunar'

select 
    id_dep, functie, id_ang, salariu,
    comision, salariu+nvl(comision, 0) venit
from
    angajati
where
    id_dep = 30;

-- Ex 3:
set lines 80
set pagesize 20
column A format 9999 heading 'Ecuson' justify center
column B format A20 heading 'Nume Angajat'
column C format A10 heading 'Job' justify left
column D format A14 heading 'Data Angajare' justify center
column E format 99,999.00 heading 'Salariu'

ttitle left 'Pag: ' sql.pno center underline 'Lista Angajati'
btitle right 'DIRECTOR'

select
    id_ang A, nume B, functie C, data_ang D, salariu E
from angajati
where id_dep = 20;

-- Ex 4:
set pages 30
column den_dep heading 'Departament'
column nume format a25 heading 'Nume Angajat'
column functie format a15 heading 'Job' justify left
column salariu format 99,999 heading 'Salariu'

ttitle left 'Pag: ' sql.pno center underline 'Lista Salarii'
btitle right 'Director'

break on den_dep noduplicates on report
compute sum of salariu on den_dep skip 1 report

select d.den_dep, a.nume, a.functie, a.salariu
from angajati a 
    inner join departamente d 
        on a.id_dep = d.id_dep
order by a.id_dep;

btitle off
ttitle off
clear column
clear break
clear compute

-- Ex 5:
set pagesize 40
set linesize 120
set space 2
set echo off
set verify off
set feedback off

col den_dep for a15 hea 'Departament'
col nume for a20 hea 'Nume'
col functie for a15 hea 'Job'
col v for 99,9990.99$ hea 'Venit'
col i for 99,9990.99$ hea 'Departament'
col d noprint new_value H
sol s for a10 hea 'Semnatura'

ttitle center 'Stat Salarii' skip 1 center '============' skip 1 'Pagina' format 09 sql.pno skip 1
btitle left 'Data:  ' H right 'Director'

break on den_dep on report skip 1
comp sum label 'Total/Dept' of v i on den_dep
comp sum label 'Total' of v i on report

define venit="(salariu+nvl(comision,0))"
define data="to_char(sysdate, 'dd/mm/yyyy')"

select
    d.den_dep, a.nume, a.functie, &venit v,
    decode(sign(2000-&venit),
           1, 0.1*&venit, 0.2*&venit) i,
    &data d, null s
from
    angajati a
    natural join departamente d 
order by 1, 2;
spool d:\stat_plata.txt

spool off
clear col
clear break
clear comp
ttitle off
btitle off
set echo on

--Ex individual
-- dept cu numar max de ang cu aceeasi functie si acelasi grade
SELECT DISTINCT DEPTNO
    FROM EMP
        JOIN SALGRADE
            ON SAL BETWEEN LOSAL AND HISAL
    GROUP BY DEPTNO, JOB, GRADE
    HAVING COUNT(EMPNO) = (SELECT MAX(COUNT(EMPNO))
                                FROM EMP
                                    JOIN SALGRADE
                                        ON SAL BETWEEN LOSAL AND HISAL
                                GROUP BY DEPTNO, JOB, GRADE);
-- nr max ang care indeplinesc conditia
SELECT MAX(COUNT(EMPNO))
    FROM EMP
        JOIN SALGRADE
            ON SAL BETWEEN LOSAL AND HISAL
    GROUP BY DEPTNO, JOB, GRADE
    ORDER BY DEPTNO, JOB, GRADE;
-- selectat INITCAP, SAL, DNAME cu caractere
COLUMN SAL FORMAT $99999.99
SELECT INITCAP(ENAME) Nume_ang, SAL, TRANSLATE(DNAME, 'AEIOU', '****$') Translated, DNAME
FROM EMP
    NATURAL JOIN DEPT
WHERE DEPTNO IN (SELECT DISTINCT DEPTNO
    FROM EMP
        JOIN SALGRADE
            ON SAL BETWEEN LOSAL AND HISAL
    GROUP BY DEPTNO, JOB, GRADE
    HAVING COUNT(EMPNO) = (SELECT MAX(COUNT(EMPNO))
                                FROM EMP
                                    JOIN SALGRADE
                                        ON SAL BETWEEN LOSAL AND HISAL
                                GROUP BY DEPTNO, JOB, GRADE))
ORDER BY DNAME;
-- media tuturor grilelor salariale
SELECT AVG(GRADE)
    FROM SALGRADE
        JOIN EMP
            ON SAL BETWEEN LOSAL AND HISAL;
-- acordat prima
SELECT INITCAP(ENAME) Nume_ang, SAL, TRANSLATE(DNAME, 'AEIOU', '****$') Translated, DNAME,
CASE
    WHEN GRADE < (SELECT AVG(GRADE)
                FROM SALGRADE
                    JOIN EMP
                        ON SAL BETWEEN LOSAL AND HISAL) THEN 0.25 * SAL
    ELSE 0.1 * SAL
END Prima
FROM EMP
    NATURAL JOIN DEPT
    JOIN SALGRADE
        ON SAL BETWEEN LOSAL AND HISAL
WHERE DEPTNO IN (SELECT DISTINCT DEPTNO
    FROM EMP
        JOIN SALGRADE
            ON SAL BETWEEN LOSAL AND HISAL
    GROUP BY DEPTNO, JOB, GRADE
    HAVING COUNT(EMPNO) = (SELECT MAX(COUNT(EMPNO))
                                FROM EMP
                                    JOIN SALGRADE
                                        ON SAL BETWEEN LOSAL AND HISAL
                                GROUP BY DEPTNO, JOB, GRADE))
ORDER BY DNAME;
