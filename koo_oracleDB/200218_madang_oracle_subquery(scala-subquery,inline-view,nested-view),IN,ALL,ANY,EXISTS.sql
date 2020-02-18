-- 2.1 subquery in SELECT (scala subquery)
SELECT name 
FROM   customer cs, 
       orders od 
WHERE  cs.custid = od.custid; 

SELECT (SELECT name 
        FROM   customer 
        WHERE  customer.custid = orders.custid) name, 
       SUM(saleprice)                           total 
FROM   orders 
GROUP  BY custid; 

-- UPDATE tbl SET col (Not run...)
UPDATE orders 
SET    bookname = (SELECT bookname 
                   FROM   book 
                   WHERE  book.bookid = orders.bookid);


-- 2.2 subquery in FROM (inline view)
-- ����ȣ�� 2 ������ ���� �Ǹž��� ���̽ÿ� (����� ���̸��� ���� �Ǹž� ���)
SELECT name, SUM(saleprice) total 
FROM   (SELECT * 
        FROM   customer 
        WHERE  custid <= 2) cs, 
       (SELECT * 
        FROM   orders 
        WHERE  custid <= 2) od 
WHERE  cs.custid = od.custid 
GROUP  BY name;


-- 2.3 subquery in WHERE (nested view)
-- ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ�, �ֹ���ȣ�� �ݾ� (�� ������)
SELECT orderid, 
       saleprice 
FROM   orders 
WHERE  saleprice <= (SELECT Avg(saleprice) 
                     FROM   orders); 

-- �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���ؼ� �ֹ���ȣ , ����ȣ , �ݾ� (�� ������)
SELECT od1.orderid, od1.custid, od1.saleprice 
FROM   orders od1, 
       (SELECT custid, Avg(saleprice) mean_price 
        FROM   orders 
        GROUP  BY custid) od2 
WHERE  od1.custid = od2.custid 
       AND od1.saleprice > od2.mean_price; 

SELECT orderid, custid, saleprice 
FROM   orders od1 
WHERE  saleprice > (SELECT Avg(saleprice) 
                    FROM   orders od2 
                    WHERE  od2.custid = od1.custid); 

-- ���ѹα��� �����ϴ� ������ �Ǹ��� ������ ���Ǹž��� ���Ͻÿ� (IN, NOT IN)
SELECT SUM(saleprice) 
FROM   orders 
WHERE  custid IN (SELECT custid 
                  FROM   customer 
                  WHERE  address LIKE '���ѹα�%'); 

-- 3 �� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ��� ���̽ÿ� (ALL, ANY/SOME)
SELECT orderid, saleprice 
FROM   orders 
WHERE  saleprice > (SELECT Max(saleprice) 
                    FROM   orders 
                    WHERE  custid = 3); 

SELECT orderid, saleprice 
FROM   orders 
WHERE  saleprice > ALL (SELECT saleprice 
                        FROM   orders 
                        WHERE  custid = 3); 

-- EXISTS �����ڷ� ���ѹα��� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�
SELECT * FROM customer
WHERE address LIKE '���ѹα�%';

SELECT * FROM orders where custid in (2, 3, 5);
SELECT SUM(saleprice) FROM orders where custid in (2, 3, 5);

SELECT SUM(saleprice) 
FROM   orders 
WHERE  EXISTS (SELECT * 
               FROM   customer 
               WHERE  orders.custid = customer.custid 
                      AND address LIKE '���ѹα�%'); 
