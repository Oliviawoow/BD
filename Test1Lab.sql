TEST LAB 1
-- met 1
select ename, sal||' si bonus '|| (comm + 0.25*sal) as "bonus", deptno, hiredate
from emp
where (deptno = &deptno) and (hiredate between '1-JAN-1981' and '1-APR-1981') and ((ename like 'A%') or (ename like 'B%') or (ename like 'C%') or (ename like 'D%') or (ename like 'E%'));

-- met 2
select ename, sal||' si bonus '|| (comm + 0.25*sal) as "bonus", deptno, hiredate
from emp
where (deptno = &&deptno) and (hiredate between '1-JAN-1981' and '1-APR-1981') and ((ename like 'A%') or (ename like 'B%') or (ename like 'C%') or (ename like 'D%') or (ename like 'E%'));
undifine deptno

-- met 3
accept deptno char prompt 'Id dept:'
select ename, sal||' si bonus '|| (comm + 0.25*sal) as "bonus", deptno, hiredate
from emp
where (deptno = &deptno) and (hiredate between '1-JAN-1981' and '1-APR-1981') and ((ename like 'A%') or (ename like 'B%') or (ename like 'C%') or (ename like 'D%') or (ename like 'E%'));
undifine deptno

-- met 4
select ename, sal||' si bonus '|| (comm + 0.25*sal) as "bonus", deptno, hiredate
from emp
where (deptno = &1) and (hiredate between '1-JAN-1981' and '1-APR-1981') and ((ename like 'A%') or (ename like 'B%') or (ename like 'C%') or (ename like 'D%') or (ename like 'E%'));
