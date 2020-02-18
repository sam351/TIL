-- (1) �� ���� ����ȣ, �ּ�, �� ����� ��� 
SELECT od.custid, 
       (SELECT address 
        FROM   customer cs 
        WHERE  cs.custid = od.custid) address, 
       SUM(od.saleprice)              total 
FROM   orders od 
GROUP  BY od.custid; 



-- (2) �� ���� ���̸�, ��� ����� ��� 
SELECT (SELECT name 
        FROM   customer cs 
        WHERE  cs.custid = od.custid) name, 
       Avg(od.saleprice)              mean_price 
FROM   orders od 
GROUP  BY od.custid; 

SELECT name, 
       mean_price 
FROM   customer cs, 
       (SELECT custid, 
               Avg(saleprice) mean_price 
        FROM   orders 
        GROUP  BY custid) od 
WHERE  cs.custid = od.custid; 



-- (3) ����ȣ�� 3�� ������ ������ �� ����� ��� 
SELECT SUM(saleprice) total 
FROM   orders 
WHERE  custid <= 3; 

SELECT SUM(saleprice) total 
FROM   orders od 
WHERE  EXISTS (SELECT * 
               FROM   customer cs 
               WHERE  cs.custid <= 3 
                      AND cs.custid = od.custid); 

SELECT SUM(saleprice) total 
FROM   orders od1 
WHERE  EXISTS (SELECT * 
               FROM   orders od2 
               WHERE  od2.custid <= 3 
                      AND od1.custid = od2.custid); 