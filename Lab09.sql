-- Ex 1:
-- Metoda 1:
select d.den_dep, 
			a.functie, 
			count(a.id_ang) nr_ang
from angajati a
	NATURAL JOIN departamente d
group by d.den_dep, 
				a.functie
having count(a.id_ang) = (select max(count(id_ang))
										from angajati
										group by id_dep, functie);

-- Metoda 2:
-- Pasul 1:
select max((select (count(id_ang))
            from angajati
            where id_dep = s.id_dep and
                  functie = s.functie
            group by id_dep,
                    functie)) max_count
from angajati s;

-- Pasul 2:
select d.den_dep, 
			a.functie, 
			count(a.id_ang) nr_ang
from angajati a
    NATURAL JOIN departamente d
group by d.den_dep, a.functie
having count(a.id_ang) = (select max((select (count(id_ang))
										from angajati
										where id_dep = s.id_dep 
											and functie = s.functie
										group by id_dep, functie)) max_count
										from angajati s);

-- Ex 2:
define id_dep = 30
select d.den_dep,
       a.nume,
       a.functie,
       a.comision
from angajati a
    INNER JOIN departamente d
    ON a.id_dep = d.id_dep
group by d.den_dep,
         a.nume,
         a.functie,
         a.comision
having max(a.comision) in (select max(comision)
											from angajati
											where id_dep =& id_dep
											group by id_dep)
order by 2;

-- Ex 3:
select a.nume,
       a.functie,
       a.data_ang,
       a.salariu
from angajati a,
     (select id_dep,
      max(salariu) sal_MAX_dep
      from angajati
      group by id_dep) b
group by a.nume,
         a.functie,
         a.data_ang,
         a.salariu
having a.salariu = max(b.sal_MAX_dep)
order by a.nume;

-- Ex 4:
select nume Nume_Ang,
       (select nume
        from angajati
        where id_ang = a.id_sef) Nume_Sef
from angajati a
where id_dep = 20
order by nume;

-- Ex 5:
select id_dep, nume, functie
from angajati a
where id_dep in (10, 20)
order by (select count(*) 
				from angajati b
				where a.id_dep = b.id_dep) desc;

-- Ex 6:
select id_dep, nume, 
			functie, 
			salariu
from angajati
where salariu > some(select distinct salariu
								from angajati
								where functie = 'SALESMAN')
order by id_dep, nume;

-- Ex 7:
select id_dep, 
			nume, 
			functie, 
			salariu
from angajati
where salariu >= all(select distinct salariu
							from angajati
							where functie = 'SALESMAN')
order by id_dep, 
				nume;

-- Ex 8:
select d.id_dep, 
			d.den_dep
from departamente d
where exists (select nume
					from angajati
					where id_dep = d.id_dep)
order by id_dep;

-- Ex 9:
select id_dep, 
			id_ang, 
			nume, 
			functie, 
			id_sef
from angajati a
where not exists (select id_sef
							from angajati
							where id_ang=a.id_sef)
order by id_dep;

-- Ex 10:
select id_dep, 
			id_ang, 
			nume, 
			functie, 
			id_sef
from angajati a
where id_sef not in (select distinct id_sef
								from angajati)
order by id_dep;

-- Ex individuale:
-- Ex 1:
-- venit mediu:
select b.functie, 
			avg(all b.salariu + nvl(b.comision, 0)) sal_mediu
from angajati b
group by b.functie;
having b.functie = a.functie;

-- functie:
select a.functie functie, 
			(select avg(all b.salariu + nvl(b.comision, 0))
                            from angajati b
                            group by b.functie
                            having b.functie = a.functie) venit_mediu
from angajati a
group by a.functie;

-- Ex 2:
SELECT e.JOB, g.GRADE, AVG(e.SAL)
    FROM EMP e
        JOIN SALGRADE g
            ON e.SAL BETWEEN g.LOSAL AND g.HISAL
    GROUP BY e.JOB, g.GRADE
    HAVING AVG(e.SAL) >= (SELECT AVG(e1.SAL)
                            FROM EMP e1
                                JOIN SALGRADE g1
                                    ON e1.SAL BETWEEN g1.LOSAL AND g1.HISAL
                            WHERE g1.GRADE = g.GRADE);  

-- Ex 3:
-- OPERATORUL ALL:
select  a.nume,
		d.den_dep,
		a.functie,
		a.salariu + nvl(a.comision, 0) venit_lunar
from angajati a, departamente d
where a.id_dep = d.id_dep and
      a.salariu + nvl(a.comision, 0) >= all(select salariu + nvl(comision, 0)
                                            from angajati
                                            where id_dep = a.id_dep)
order by d.den_dep;

-- OPERATORUL EXISTS:
select a.nume,
       d.den_dep,
       a.functie,
       a.salariu + nvl(a.comision, 0) venit_lunar
from angajati a, departamente d
where a.id_dep = d.id_dep and
      not exists(select *
                 from angajati a2, departamente d2
                 where a2.id_dep = d2.id_dep and 
                       d.id_dep = d2.id_dep and
                       a2.salariu + nvl(a2.comision, 0) > a.salariu + nvl(a.comision, 0))
order by d.den_dep;
