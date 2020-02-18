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
-- 고객번호가 2 이하인 고객의 판매액을 보이시오 (결과는 고객이름과 고객별 판매액 출력)
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
-- 평균 주문금액 이하의 주문에 대해서, 주문번호와 금액 (비교 연산자)
SELECT orderid, 
       saleprice 
FROM   orders 
WHERE  saleprice <= (SELECT Avg(saleprice) 
                     FROM   orders); 

-- 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호 , 고객번호 , 금액 (비교 연산자)
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

-- 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오 (IN, NOT IN)
SELECT SUM(saleprice) 
FROM   orders 
WHERE  custid IN (SELECT custid 
                  FROM   customer 
                  WHERE  address LIKE '대한민국%'); 

-- 3 번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액을 보이시오 (ALL, ANY/SOME)
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

-- EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오
SELECT * FROM customer
WHERE address LIKE '대한민국%';

SELECT * FROM orders where custid in (2, 3, 5);
SELECT SUM(saleprice) FROM orders where custid in (2, 3, 5);

SELECT SUM(saleprice) 
FROM   orders 
WHERE  EXISTS (SELECT * 
               FROM   customer 
               WHERE  orders.custid = customer.custid 
                      AND address LIKE '대한민국%'); 
