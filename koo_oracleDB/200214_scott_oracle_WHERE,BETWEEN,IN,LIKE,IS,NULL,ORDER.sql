select * from emp where rownum<=10;

-- WHERE + condition statement
select * from emp where deptno=10;
select empno, ename, sal from emp where sal<=1500;
select empno, ename, sal from emp where ename='SCOTT';
select * from emp where hiredate<='82/01/01';

-- WHERE col BETWEEN val_a AND val_b
select * from emp WHERE hiredate BETWEEN '1987/01/01' AND '1987/12/31';

-- WHERE col in ( )
select empno, sal from emp WHERE empno in (7521, 7654, 7844);
select empno, ename from emp WHERE empno NOT IN (7521, 7654, 7844);

-- WHERE col LIKE pattern('%', '_')
select * from emp WHERE ename LIKE 'A%';
select * from emp WHERE ename LIKE '_A%';
select * from emp WHERE ename LIKE '%A%';
select * from emp WHERE ename NOT LIKE '%A%';

-- WHERE col IS NULL
select * from emp WHERE comm IS NULL;
select * from emp WHERE comm IS NULL OR comm=0;
select * from emp WHERE comm IS NOT NULL;
select * from emp WHERE comm IS NOT NULL AND comm!=0;
select * from emp WHERE mgr IS NULL;

-- ORDER BY
SELECT * FROM emp ORDER BY hiredate DESC;
SELECT * FROM emp ORDER BY sal DESC, ename ASC;
SELECT empno, hiredate, ename, sal FROM emp ORDER BY deptno, hiredate DESC
