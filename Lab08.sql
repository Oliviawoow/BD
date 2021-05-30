LAB 8:
-- Ex 1:
SELECT id_dep, nume, functie, salariu
FROM angajati
WHERE salariu = (SELECT max(salariu)
                FROM angajati);

-- Ex 2:
SELECT id_dep, nume, functie, salariu
FROM angajati
WHERE
    NOT id_dep = 20 AND
    functie IN (SELECT functie
                FROM angajati WHERE id_dep = 20)
ORDER BY functie;

-- Ex 3:
SELECT nume, functie, data_ang
FROM angajati
WHERE data_ang NOT IN (SELECT distinct(data_ang)
                       FROM angajati
                       WHERE TO_CHAR(data_ang, 'MON') IN
                       ('DEC', 'JAN', 'FEB'))
ORDER BY nume;

-- Ex 4:
SELECT den_dep, nume, salariu
FROM angajati
    NATURAL JOIN departamente
WHERE salariu IN
    (SELECT MAX(salariu)
     FROM angajati
     GROUP BY id_dep)
ORDER BY den_dep;

-- Ex 5:
SELECT id_dep, nume, functie, data_ang
FROM angajati
WHERE
    (TO_CHAR(data_ang, 'YYYY'), functie) IN
    (SELECT TO_CHAR(data_ang, 'YYYY'), functie
        FROM angajati
        WHERE LOWER(nume) = 'jones');

-- Ex 6:
SELECT id_dep, nume, salariu
FROM angajati
WHERE (id_dep, salariu+nvl(comision,0)) IN
        (SELECT id_dep, min(salariu+nvl(comision,0))
            FROM angajati
            GROUP BY id_dep)
ORDER BY id_dep;

-- Ex 7:
SELECT nume, functie, data_ang, salariu
FROM angajati
WHERE salariu > 
    (SELECT MAX(salariu)
		FROM angajati
		WHERE id_dep = 
			(SELECT id_dep
				FROM departamente
				WHERE LOWER(den_dep) = 'sales'));

-- Ex 8:
SELECT a.id_dep, a.nume, a.functie, a.salariu
FROM angajati a
WHERE
    a.salariu > (SELECT AVG(b.salariu)
                 FROM angajati b
                 WHERE b.id_dep = a.id_dep)
ORDER BY a.id_dep;

-- Ex 9:
UPDATE angajati a
SET (a.salariu, a.comision) =
    (SELECT a.salariu+avg(b.salariu)*0.1, avg(b.comision)
		FROM angajati b
		WHERE b.id_dep = a.id_dep)
WHERE data_ang <= '1-JUN-81';

-- Ex 10:
SELECT b.id_dep, a.den_dep, b.max_sal_dep
FROM 
	departamente a INNER JOIN
		(SELECT id_dep, MAX(salariu) max_sal_dep
		FROM angajati
		GROUP BY id_dep) b
    ON a.id_dep = b.id_dep
ORDER BY b.id_dep;

SELECT b.id_dep, a.den_dep, b.max_sal_dep
FROM 
	departamente a,
    (SELECT id_dep, MAX(salariu) max_sal_dep
    FROM angajati
    GROUP BY id_dep) b
WHERE a.id_dep = b.id_dep
ORDER BY b.id_dep;

-- Exindividuale:
-- Met1:
SELECT a.nume, d.den_dep, a.salariu
FROM angajati a
	    INNER JOIN departamente d
        ON a.id_dep = d.id_dep
WHERE a.salariu = (SELECT MIN(b.salariu) 
			     FROM angajati b
			     WHERE b.id_dep = a.id_dep)
ORDER BY a.nume;

-- Met2:
SELECT a.nume, d.den_dep, a.salariu
FROM angajati a
	INNER JOIN departamente d
    ON a.id_dep = d.id_dep
WHERE
	(a.id_dep, a.salariu) IN (SELECT b.id_dep, MIN(b.salariu)
				              FROM angajati b
				              WHERE b.id_dep = a.id_dep
				              GROUP BY b.id_dep)
ORDER BY a.nume;

-- Met3:
SELECT a.nume, d.den_dep, a.salariu
FROM angajati a
	INNER JOIN departamente d
    ON a.id_dep = d.id_dep
WHERE
	(a.id_dep, a.salariu) IN (SELECT id_dep, MIN(salariu)
				              FROM angajati
				              GROUP BY id_dep)
ORDER BY a.nume;

-- Met4:
SELECT c.nume, a.den_dep, b.min_sal_dep
FROM departamente a,
     (SELECT id_dep, MIN(salariu) min_sal_dep
     FROM angajati
     GROUP BY id_dep) b,
     angajati c
WHERE a.id_dep = b.id_dep AND a.id_dep = c.id_dep AND c.salariu = b.min_sal_dep
ORDER BY c.nume;
