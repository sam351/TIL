-- functions (SUM, AVG, MAX, MIN, COUNT)
SELECT SUM(saleprice) AS 총매출 FROM orders;

SELECT SUM(saleprice) AS 총매출 FROM orders WHERE custid=2;

SELECT SUM(saleprice) AS TOTAL,
    AVG(saleprice) AS AVERAGE,
    MIN(saleprice) AS MINIMUM,
    MAX(saleprice) AS MAXIMUM
    FROM orders;
    
SELECT COUNT(*) FROM orders;


-- GROUP BY, HAVING
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS 총액
    FROM orders
    GROUP BY custid;
SELECT custid, COUNT(*) AS 도서수량
    FROM orders
    WHERE saleprice >= 8000
    GROUP BY custid
    HAVING COUNT(*)>=2;


-- practice 1
-- (1)
SELECT bookid, bookname FROM book
WHERE bookid=1;
-- (2)
SELECT bookname, price FROM book
WHERE price>=20000;
-- (3)
SELECT SUM(saleprice)
FROM orders
WHERE custid=1;

SELECT a.name, SUM(b.saleprice)
FROM customer a, orders b
WHERE a.custid = b.custid AND b.custid=1;

SELECT SUM(Orders.saleprice)
FROM Customer, Orders
WHERE Customer.custid=Orders.custid
AND Customer.name = '박지성';
-- (4)
SELECT count(*)
FROM orders
WHERE custid=1;
SELECT COUNT(*) FROM Customer, Orders
WHERE Customer.custid=Orders.custid
AND Customer.name LIKE '박지성';


-- practice 2
-- (1)
SELECT count(*) FROM book;
-- (2)
SELECT count(DISTINCT publisher) FROM book;
-- (3)
SELECT name, address FROM customer;
-- (4)
SELECT orderid, orderdate FROM orders
WHERE orderdate BETWEEN '14/07/04' AND '14/07/07';
-- (5)
SELECT orderid, orderdate FROM orders
WHERE orderdate NOT BETWEEN '14/07/04' AND '14/07/07';
-- (6)
SELECT name, address FROM customer
WHERE name LIKE '김%';
-- (7)
SELECT name, address FROM customer
WHERE name LIKE '김%아';


-- JOIN
SELECT * FROM customer a, orders b
WHERE a.custid=b.custid;

SELECT name, saleprice FROM customer, orders
WHERE customer.custid = orders.custid;

SELECT name, SUM(saleprice)
FROM customer a, orders b
WHERE a.custid = b.custid
GROUP BY name
ORDER BY name;

SELECT name, bookname
FROM orders a, customer b, book c
WHERE a.custid=b.custid AND a.bookid=c.bookid;

SELECT name, bookname
FROM orders a, customer b, book c
WHERE a.custid=b.custid AND a.bookid=c.bookid AND a.saleprice=20000;

SELECT name, saleprice
FROM orders a, customer b
WHERE a.custid(+)=b.custid;

SELECT name, saleprice
FROM customer a LEFT OUTER JOIN orders b
ON a.custid = b.custid;

SELECT bookname
FROM book
WHERE price = (SELECT max(price) FROM book);

SELECT name
FROM customer
WHERE custid IN (SELECT custid
                    FROM orders);

SELECT name
FROM customer
WHERE custid IN (SELECT custid
                 FROM orders
                 WHERE bookid IN (SELECT bookid
                                  FROM book
                                  WHERE publisher='대한미디어'));
-- 출판사 별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오
SELECT a.bookname
FROM book a, (SELECT publisher, AVG(price) AS mean_price
              FROM book
              GROUP BY publisher) b
WHERE a.publisher=b.publisher AND a.price>b.mean_price;
-- (Simpler version)
SELECT a.bookname
FROM book a
WHERE a.price > (SELECT AVG(b.price) FROM book b
                 WHERE b.publisher=a.publisher);
