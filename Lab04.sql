LAB 4:
-- ex 1
CREATE TABLE departamente AS
SELECT
  deptno id_dep,
  dname den_dep,
  loc locatie
FROM dept;

-- ex 2
CREATE TABLE ANGAJATI AS
SELECT
  EMPNO ID_ANG,
  ENAME NUME,
  JOB FUNCTIE,
  MGR ID_SEF,
  HIREDATE DATA_ANG,
  SAL SALARIU,
  COMM COMISION,
  DEPTNO ID_DEP
FROM EMP;

-- ex 3
SELECT * FROM angajati;

-- ex 4
SELECT id_dep, den_dep
FROM departamente;

-- ex 5
SELECT
  id_ang||'-'||nume angajat,
  functie,
  DATA_ANG
FROM angajati
ORDER BY id_ang DESC;

-- ex 6
SELECT
  id_ang||'-'||nume angajat,
  functie,
  salariu+nvl(comision, 0) AS "venit lunar",
  '     ' AS semnatura
FROM angajati
ORDER BY id_dep;

-- ex 7
SELECT nume, 'cu functie', functie
FROM angajati;

-- ex 8
SELECT
  den_dep||' are codul '||id_dep "Lista Departamente"
FROM Departamente
ORDER BY den_dep ASC;

-- ex 9
select
  a.id_ang ecuson,
  a.nume,
  a.data_ang AS "Data Angajarii",
  a.salariu
FROM angajati a
WHERE id_dep = 10;

-- ex 10
SELECT
  id_dep "Nr. departament",
  nume,
  functie,
  salariu,
  data_ang AS "Data Angajarii"
FROM angajati
WHERE LOWER(functie) = 'manager'
ORDER BY id_dep;

-- ex 11
-- Metoda 1
SELECT
  id_dep departament,
  functie,
  nume,
  data_ang AS "Data Angajarii"
FROM angajati
WHERE data_ang BETWEEN '1-MAY-1981' AND '31-DEC-1981'
ORDER BY 1 DESC, 2 DESC;

-- Metoda 2
SELECT
  id_dep departament,
  functie,
  nume,
  data_ang AS "Data Angajarii"
FROM angajati
WHERE data_ang >= '1-MAY-1981' AND data_ang <= '31-DEC-1981'
ORDER BY 1 DESC, 2 DESC;

-- ex 12
-- Metoda 1
SELECT
  id_ang AS ecuson,
  nume,
  functie,
  salariu + nvl(comision, 0) "Venit lunar"
FROM angajati
WHERE id_ang IN (7499, 7902, 7876)
ORDER BY nume;

-- Metoda 2
SELECT
  id_ang AS ecuson,
  nume,
  functie,
  salariu + nvl(comision, 0) "Venit lunar"
FROM angajati
Where id_ang = 7499 OR id_ang = 7902 OR id_ang = 7876
ORDER BY nume;

-- ex 13
SELECT
  id_ang AS ecuson,
  nume,
  functie,
  data_ang AS "Data Angajarii"
FROM angajati
Where data_ang LIKE '%80';

-- ex 14
SELECT
  id_ang AS ecuson,
  nume,
  functie,
  data_ang AS "Data Angajarii"
FROM angajati
WHERE nume LIKE 'F%' AND functie LIKE '_______';

-- ex 15
SELECT
  id_ang AS ecuson,
  nume,
  functie,
  salariu,
  comision
FROM angajati
WHERE
  (comision = 0 OR comision IS NULL) AND
  id_dep = 20
ORDER BY nume;

-- ex 16
SELECT
  id_ang AS ecuson,
  nume,
  functie,
  salariu,
  comision
FROM angajati
WHERE
  (comision != 0 AND comision IS NOT NULL) AND
  functie = UPPER('salesman')
ORDER BY nume;

-- ex 17
SELECT
  id_ang AS ecuson,
  nume,
  functie,
  salariu,
  id_dep departament
FROM angajati
WHERE
  salariu > 1500 AND
  LOWER(functie) = 'manager' OR
  UPPER(functie) = 'ANALYST'
ORDER BY functie, nume DESC;

-- Exercitii
-- 1
SELECT
  id_ang AS ecuson,
  nume,
  functie,
  data_ang,
  comision
FROM angajati
WHERE
  (comision = 0 OR comision IS NULL) AND
  data_ang <= '1-JAN-1982'
ORDER BY id_ang, nume;

-- 2
SELECT
  id_ang AS ecuson,
  nume,
  functie "Departament",
  id_sef,
  salariu
FROM angajati
WHERE
  salariu > 3000 AND
  id_sef IS NULL
ORDER BY functie;

-- 3
SELECT
  nume,
  functie,
  12*(salariu  + nvl(comision, 0)) AS "Venit anual",
  id_dep
FROM angajati
WHERE
  LOWER(functie) <> 'manager' AND
  id_dep = '&id_dep';

-- 4
SELECT
  id_dep "Departament",
  nume AS Nume,
  data_ang,
  salariu
FROM angajati
WHERE
  data_ang LIKE '%81' AND
  (id_dep = '&dep1' OR id_dep = '&dep2')
ORDER BY id_dep, Nume;