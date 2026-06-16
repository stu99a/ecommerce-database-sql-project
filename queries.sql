-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database
--the query below extracts all the customers from a specific city, in this case "kano".
SELECT * FROM "customers" WHERE "city" = "kano";

--the query below searches for a product(s) of specific genre(s).
SELECT * FROM "products" WHERE "genre" LIKE '%sci-fi%';

--the query below counts how many customers are from a specific city.
SELECT COUNT("id") AS "kaduna customers" FROM "customers" WHERE "city" = 'kaduna';

--the query below calculates the average of the unit prices, rounded to two decimal places.
SELECT ROUND (AVG("unit_price"), 2) AS "average unit price" FROM "products";

--the query below extracts all current orders.
SELECT * FROM "orders";

--the query below extracts the count of all orders.
SELECT COUNT ("id") AS "total number of orders" FROM "orders";

--the query below extracts all delivered orders.
SELECT * FROM "deliveries";

--the query below extracts the count of all deliveries.
SELECT COUNT ("id") AS "total number of deliveries" FROM "deliveries";

--this query extracts name and type of products that were paid for with a credit card
SELECT "title", "product_type" FROM "products"
WHERE "id" IN (
    SELECT "product_id" FROM "orders"
    WHERE "payment_type" = 'credit card'
);

--this query extracts names of customers that paid using bank transfers
SELECT "first_name", "last_name" FROM "customers"
WHERE "id" IN (
    SELECT "customer_id" FROM "orders"
    WHERE "payment_type" = 'bank transfer'
);

--this query extracts the count of each product type being sold at the e-shop
 SELECT "product_type", COUNT("product_type") AS "number of products" FROM "products"
 GROUP BY "product_type";

--this query extracts all the information about the highest paid employee
SELECT * FROM "employees"
WHERE "salary" = (
    SELECT MAX("salary") FROM "employees"
);

--this query extracts the average price of all products rounded to 2 decimal places that are sold in the e-shop
SELECT ROUND(AVG("unit_price"), 2) AS "average unit price" FROM "products";

--this query extracts the average rating of products from customers
SELECT AVG("rating") AS "average rating" FROM "feedback";

--this query extracts the count of each rating given by customers
SELECT "rating", COUNT("rating") AS "count of rating" FROM "feedback"
GROUP BY "rating";
