/*
1. Посчитать кол-во телефонов, которые были проданы
2. Кол-во телефонов, которые есть "на складе"
3. Средняя цена всех телефонов
4. Средняя цена каждого бренда
5. Кол-во моделей каждого бренда
6. Кол-во заказов каждого пользователя, которые совершали заказы
7. Средняя цена на IPhone
8. Стоимость всех телефонов в диапазоне их цен от 10К до 20К
9.  Узнать каких брендов телефонов осталось меньше всего
10. Сортировка юзеров по возрасту(не день рождения) и по имени
JOIN:
11. Извлечь все телефоны заказа №4
12. Кол-во заказов каждого пользователя и его емейл
13. Извлечь самый популярный телефон (каких моделей телефонов заказано больше всего) 
*/

/*1*/
SELECT SUM("quantity") AS "Проданные телефоны"
FROM "phones_to_orders";
/*2*/
SELECT SUM("quantity") AS "Телефоны на складе"
FROM "phones";
/*3*/
SELECT AVG("price")
FROM "phones";
/*4*/
SELECT "brand", AVG("price")
FROM "phones"
GROUP BY "brand";
/*5*/
SELECT "brand", "model", SUM("quantity")
FROM "phones"
GROUP BY "brand", "model"
ORDER BY "brand", "model";
/*6*/
SELECT "userId", COUNT("id")
FROM "orders"
GROUP BY "userId"
ORDER BY "userId";
/*7*/
SELECT AVG("price")
FROM "phones"
WHERE "brand" = 'Iphone';
/*8*/
SELECT *
FROM "phones"
WHERE "price" > 10000 AND "price" < 20000;
/*9*/
SELECT "brand", MIN("quantity") AS "quantity"
FROM "phones"
GROUP BY "brand"
ORDER BY "quantity"
LIMIT 5;
/*10*/
SELECT "Age", "firstname"
FROM (
  SELECT EXTRACT(
    YEAR
    FROM AGE("birthday")
  ) AS "Age",
  *
  FROM "users"
) AS "users_age"
GROUP BY "Age", "firstname"
ORDER BY "Age", "firstname";
/*11*/
SELECT * FROM "phones" AS p
JOIN "phones_to_orders" AS pto ON p."id" = pto."phoneId"
WHERE pto."orderId" = 4;
/*12*/
SELECT u."id",
  u."email",
  COUNT(o."id") AS "ordersCount"
FROM users AS u
  LEFT JOIN orders AS o ON u."id" = o."userId"
GROUP BY u."id",
  u."email";
/*13*/
SELECT p.* FROM "phones" AS p
JOIN "phones_to_orders" AS pto ON p."id" = pto."phoneId"
ORDER BY pto."quantity" DESC
LIMIT 1;

