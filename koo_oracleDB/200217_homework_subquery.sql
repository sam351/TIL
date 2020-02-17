
-- 1-(5) �������� ������ ������ ���ǻ� ��
SELECT count(publisher)
FROM book
WHERE bookid IN (SELECT bookid
                 FROM orders
                 WHERE custid = (SELECT custid
                                 FROM customer
                                 WHERE name='������'));

-- 1-(6) �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
SELECT bk.bookname, bk.price, od.saleprice, bk.price-od.saleprice AS discount
FROM book bk RIGHT JOIN orders od
ON bk.bookid=od.bookid
WHERE od.custid IN (SELECT custid
                    FROM customer
                    WHERE name='������');

-- 1-(7) �������� �������� ���� ������ �̸�
SELECT bookname
FROM book
WHERE bookid NOT IN (SELECT bookid
                     FROM orders
                     WHERE custid = (SELECT custid
                                     FROM customer
                                     WHERE name='������'));



-- 2-(8) �ֹ����� ���� ���� �̸�(�μ� ���ǻ��)
SELECT name
FROM customer
WHERE custid NOT IN (SELECT custid FROM orders);

-- 2-(9) �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ�
SELECT SUM(saleprice) AS total_income, AVG(saleprice) AS income_per_order
FROM orders;

-- 2-(10) ���� �̸��� ���� ���ž�
SELECT name,SUM(saleprice)
FROM orders od LEFT JOIN customer cs
ON od.custid=cs.custid
GROUP BY name;

-- 2-(11) ���� �̸��� ���� ������ ���� ���
SELECT name, bookname
FROM orders od, customer cs, book bk
WHERE od.custid=cs.custid AND od.bookid=bk.bookid
ORDER BY name;

-- 2-(12) ������ ����(Book ���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�
SELECT *
FROM orders
WHERE orderid = (SELECT orderid FROM (SELECT od.orderid, bk.price - od.saleprice AS discount
                                      FROM orders od, book bk
                                      WHERE od.bookid=bk.bookid
                                      ORDER BY discount DESC)
                 WHERE rownum=1);

-- 2-(13) ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
SELECT name
FROM customer
WHERE custid IN (SELECT custid
                 FROM orders
                 GROUP BY custid
                 HAVING AVG(saleprice) > (SELECT AVG(saleprice)
                                          FROM orders));


