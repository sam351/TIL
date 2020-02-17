
-- 1-(5) 박지성이 구매한 도서의 출판사 수
SELECT count(publisher)
FROM book
WHERE bookid IN (SELECT bookid
                 FROM orders
                 WHERE custid = (SELECT custid
                                 FROM customer
                                 WHERE name='박지성'));

-- 1-(6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT bk.bookname, bk.price, od.saleprice, bk.price-od.saleprice AS discount
FROM book bk RIGHT JOIN orders od
ON bk.bookid=od.bookid
WHERE od.custid IN (SELECT custid
                    FROM customer
                    WHERE name='박지성');

-- 1-(7) 박지성이 구매하지 않은 도서의 이름
SELECT bookname
FROM book
WHERE bookid NOT IN (SELECT bookid
                     FROM orders
                     WHERE custid = (SELECT custid
                                     FROM customer
                                     WHERE name='박지성'));



-- 2-(8) 주문하지 않은 고객의 이름(부속 질의사용)
SELECT name
FROM customer
WHERE custid NOT IN (SELECT custid FROM orders);

-- 2-(9) 주문 금액의 총액과 주문의 평균 금액
SELECT SUM(saleprice) AS total_income, AVG(saleprice) AS income_per_order
FROM orders;

-- 2-(10) 고객의 이름과 고객별 구매액
SELECT name,SUM(saleprice)
FROM orders od LEFT JOIN customer cs
ON od.custid=cs.custid
GROUP BY name;

-- 2-(11) 고객의 이름과 고객이 구매한 도서 목록
SELECT name, bookname
FROM orders od, customer cs, book bk
WHERE od.custid=cs.custid AND od.bookid=bk.bookid
ORDER BY name;

-- 2-(12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
SELECT *
FROM orders
WHERE orderid = (SELECT orderid FROM (SELECT od.orderid, bk.price - od.saleprice AS discount
                                      FROM orders od, book bk
                                      WHERE od.bookid=bk.bookid
                                      ORDER BY discount DESC)
                 WHERE rownum=1);

-- 2-(13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
SELECT name
FROM customer
WHERE custid IN (SELECT custid
                 FROM orders
                 GROUP BY custid
                 HAVING AVG(saleprice) > (SELECT AVG(saleprice)
                                          FROM orders));


