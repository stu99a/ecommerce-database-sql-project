-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it#
--the statement below creates the e-shop table
CREATE TABLE "e-shop" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "email" TEXT UNIQUE,
    "phone_number" INTEGER NOT NULL UNIQUE,
    "founded" INTEGER NOT NULL,
    "reviews" INTEGER DEFAULT '0',
    PRIMARY KEY ("id")
);

--the statement below creates the employees table
CREATE TABLE "employees" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "phone_number" INTEGER NOT NULL UNIQUE,
    "job_title" TEXT NOT NULL,
    "department" TEXT NOT NULL,
    "salary" INTEGER CHECK ("salary" !=0),
    PRIMARY KEY ("id")
);

--the statement below creates the products table
 CREATE TABLE "products" (
     "id" INTEGER,
     "title" TEXT NOT NULL UNIQUE,
     "description" TEXT NOT NULL,
     "unit_price" REAL NOT NULL CHECK ("unit_price" != 0),
     "release_date" NUMERIC YEAR,
     "language" TEXT NOT NULL,
     "genre" TEXT NOT NULL,
     "product_type" TEXT NOT NULL CHECK ("product_type" IN ('music record', 'movie', 'book')),
     PRIMARY KEY("id")
);

--the statement below creates the customers table
CREATE TABLE "customers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "phone_number" INTEGER UNIQUE,
    "house_number" INTEGER NOT NULL,
    "street_address" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "postcode" INTEGER,
    "country" TEXT NOT NULL,
    PRIMARY KEY ("id")
);

--the statement below creates the orders table
CREATE TABLE "orders" (
    "id" INTEGER,
    "customer_id" INTEGER,
    "product_id" INTEGER,
    "quantity" INTEGER NOT NULL CHECK ("quantity" !=0),
    "delivery_fee" REAL CHECK ("delivery_fee" != 0),
    "total_price" REAL NOT NULL CHECK ("total_price" !=0),
    "payment_type" TEXT NOT NULL CHECK ("payment_type" IN ('bank transfer', 'digital wallet', 'paypal', 'amazon pay', 'credit card', 'debit card', 'apple pay')),
    "datetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("customer_id") REFERENCES "customers"("id"),
    FOREIGN KEY ("product_id") REFERENCES "products"("id")
);

--the statement below creates the deliveries table
CREATE TABLE "deliveries" (
    "id" INTEGER,
    "employee_id" INTEGER,
    "order_id" INTEGER,
    "datetime" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("employee_id") REFERENCES "employees"("id"),
    FOREIGN KEY ("order_id") REFERENCES "orders"("id")
);

--the statement below creates the feedback table
CREATE TABLE "feedback" (
    "id" INTEGER,
    "customer_id" INTEGER,
    "product_id" INTEGER,
    "rating" INTEGER CHECK ("rating" IN ('1', '2', '3', '4', '5')),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("customer_id") REFERENCES "customers"("id"),
    FOREIGN KEY ("product_id") REFERENCES "products"("id")
);

--this statement inserts the data below into the e-shop table created above.
INSERT INTO "e-shop" ("id", "name", "email", "phone_number", "founded")
VALUES
('1', 'mathews store', 'mathewse-bookstore@gmail.com', '+2348163992356', '2014');

--this statement inserts the data below into the employees table created above.
INSERT INTO "employees" ("first_name", "last_name", "email", "phone_number", "job_title", "department", "salary")
VALUES
('ben', 'briggs', 'benbriggs@mathewsstore.org', '+2348033256472', 'manager', 'HR', '28500'),
('jamma', 'yusuf', 'jammayusuf@mathewsstore.org', '+2348087965489', 'auditor', 'accounting', '19300'),
('philomina', 'michael', 'philominamichael@mathewsstore.org', '+2348032544891', 'payroll manager', 'accounting', '17200'),
('simon', 'stephen', 'simonstephen@mathewsstore.org', '+2347032578946', 'music record orders coodinator', 'deliveries', '21000'),
('rose', 'nwachukwu', 'rosenwachukwu@mathewsstore.org', '+2348166321587', 'recruiter', 'HR', '25100'),
('moses', 'haruna', 'mosesharuna@mathewsstore.org', '+2349032569874', 'movie orders coordinator', 'deliveries', '19000'),
('abbas', 'bello', 'abbasbello@mathewsstore.org', '+2347023498756', 'staffing manager', 'HR', '26000'),
('karla', 'mark', 'karlamark@mathewsstore.org', '+2348022269874', 'book orders coordinator', 'deliveries', '20000'),
('esther', 'dariya', 'estherdariya@mathewsstore.org', '+2348087563578', 'book orders assistant', 'deliveries', '18650'),
('abba', 'wadak', 'abbawadak@mathewsstore.org', '+2347078431562', 'music record orders assistant', 'deliveries', '18100');

--this statement inserts the data below into the products table created above.
INSERT INTO "products" ("title", "description", "unit_price", "release_date", "language", "genre",  )
VALUES
('the shawshank redemption', 'Over the course of several years, two convicts form a friendship,
seeking consolation and, eventually, redemption through basic compassion.', '26.32', '1994', 'english', 'drama', 'movie'),
('inception', 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.,
but his tragic past may doom the project and his team to disaster.', '30.85', '2010', 'english', 'action, adventure, sci-fi', 'movie'),
('harakiri', 'When a ronin requesting seppuku at a feudal lords palace is told of the brutal suicide of another ronin who previously visited,
he reveals how their pasts are intertwined and in doing so challenges the clans integrity.', '29.99', '1962', 'japanese', 'action, drama, mystery', 'movie'),
('secondhand time', 'The Belarusian Nobel laureate recorded thousands of hours of testimony from ordinary people to create this oral history of the
Soviet Union and its end.', '50.35', '2013', 'russian', 'historical', 'book'),
('never let me go', 'From his 1989 Booker winner The Remains of the Day to twenty fifteen, The Buried Giant, Nobel laureate Ishiguro writes profound, puzzling allegories about history,
nationalism and the individual place in a world that is always beyond our understanding.', '30.95', '2005', 'english', 'sci-fi, speculative fiction', 'book'),
('austerlitz', 'Sebald died in a car crash in 2001, but his genre-defying mix of fact and fiction, keen sense of the moral weight of history and interleaving of inner and outer
journeys have had a huge influence on the contemporary literary landscape', '33.55', '2001', 'german', 'novel, historical fiction', 'book'),
('half of a yellow Sun', 'When Nigerian author Adichie was growing up, the Biafran war “hovered over everything”. Her sweeping, evocative novel,
which won the Orange prize, charts the political and personal struggles of those caught up in the conflict and
explores the brutal legacy of colonialism in Africa.', '49.99', '2006', 'english', 'historical fiction', 'book'),
('my brilliant friend', 'Powerfully intimate and unashamedly domestic, the first in Ferrantes Neapolitan series established her as a literary sensation.
This and the three novels that followed documented the ways misogyny and violence could determine lives,
 as well as the history of Italy in the late twentieth century.', '49.99', '2006', 'italian', 'novel, fiction', 'book'),
('clandestino', 'Clandestino is the first full-length solo album by Manu Chao, released in nineteen ninety eight', '102.20', '1998', 'spanish,
english, french, brazilian portuguese', 'reggae, rock', 'music record'),
('thriller', 'Thriller is the sixth studio album by the American singer and songwriter Michael Jackson, released on November nineteen eighty two by Epic Records',
'150.00', '1982', 'english', 'pop, post-disco, rock, funk, disco, synth-pop, RnB', 'music record'),
('the marshall mathers LP', 'The Marshall Mathers LP is the third studio album by the American rapper Eminem, released on May twenty third two thousand and two, by Aftermath Entertainment and Interscope Records.',
'96.55', '2000', 'english', 'horror core, hard core hip hop', 'music record');

--this statement inserts the data below into the customers table created above.
INSERT INTO "customers" ("first_name", "last_name", "email", "phone_number", "house_number", "street_address", "city", "postcode", "country")
VALUES
('iliyasu', 'hassan', 'iliyasuhassan@gmail.com', '2348125636148', '12', 'sanusi road, sabon gari', 'kano','700211', 'nigeria'),
('mubarak', 'zaki', 'mubarakzaki@gmail.com', '2347065842314', '44', 'dantuku road GRA, nasarawa', 'kano','700213', 'nigeria'),
('ebenezer', 'falumoni', 'ebenezerfalumoni@yahoo.com', '2349035128531', '2268', 'nwachukwu solomon street, lugbe', 'abuja','900107', 'nigeria'),
('moses', 'agwai', 'mosesagwai@gmail.com', '2348098653674', '65', 'katsina road, barnawa', 'kaduna','800243', 'nigeria'),
('papaalioune', 'diouf', 'papaaliounediouf@gmail.com', '2218898685412', '12', 'avenue cheikh anta diop', 'dakar','12500', 'senegal'),
('george', 'marfor', 'georgemarfor@gmail.com', '233712356849', '45', 'kofi annan street', 'accra','23321', 'ghana'),
('gisej', 'dogni', 'gisejdogni@gmail.com', '2250706371784', '45', 'immeuble trigone granss carrefour marcory', 'abidjan','000225', 'ivory coast');

--this statement inserts the data below into the orders table created above.
INSERT INTO "orders" ("customer_id", "product_id", "quantity", "delivery_fee", "total_price", "payment_type", "datetime")
VALUES
((SELECT "id" FROM "customers" WHERE "id" = 1), (SELECT "id" FROM "products" WHERE "id" = 1), '1', '10.25', '36.57', 'credit card', '2020-10-15 15:34:12'),
((SELECT "id" FROM "customers" WHERE "id" = 7), (SELECT "id" FROM "products" WHERE "id" = 10), '1', '30.99', '180.99', 'paypal', '2020-02-05 00:51:32'),
((SELECT "id" FROM "customers" WHERE "id" = 2), (SELECT "id" FROM "products" WHERE "id" = 11), '2', '10.25', '203.35', 'bank transfer', '2022-06-25 22:15:05'),
((SELECT "id" FROM "customers" WHERE "id" = 5), (SELECT "id" FROM "products" WHERE "id" = 5), '1', '45.00', '75.95', 'apple pay', '2019-11-03 18:32:44'),
((SELECT "id" FROM "customers" WHERE "id" = 6), (SELECT "id" FROM "products" WHERE "id" = 7), '1', '26.75', '76.30', 'credit card', '2019-02-09 08:52:33'),
((SELECT "id" FROM "customers" WHERE "id" = 2), (SELECT "id" FROM "products" WHERE "id" = 2), '1', '10.25', '41.10', 'credit card', '2023-08-01 12:12:12'),
((SELECT "id" FROM "customers" WHERE "id" = 3), (SELECT "id" FROM "products" WHERE "id" = 6), '1', '5.99', '39.54', 'bank transfer', '2021-08-23 11:18:30'),
((SELECT "id" FROM "customers" WHERE "id" = 4), (SELECT "id" FROM "products" WHERE "id" = 11), '1', '7.20', '103.75', 'digital wallet', '2024-01-23 13:40:50'),
((SELECT "id" FROM "customers" WHERE "id" = 4), (SELECT "id" FROM "products" WHERE "id" = 3), '1', '7.20', '37.19', 'credit card', '2024-02-03 23:14:01'),
((SELECT "id" FROM "customers" WHERE "id" = 3), (SELECT "id" FROM "products" WHERE "id" = 1), '1', '5.99', '32.31', 'amazon pay', '2024-01-29 20:24:14');

--this statement inserts the data below into the deliveries table created above.
INSERT INTO "deliveries" ("employee_id", "order_id", "datetime")
VALUES
((SELECT "id" FROM "employees" WHERE "id" = 6), (SELECT "id" FROM "orders" WHERE "id" = 1), '2020-10-22 18:13:44'),
((SELECT "id" FROM "employees" WHERE "id" = 4), (SELECT "id" FROM "orders" WHERE "id" = 2), '2020-02-20 09:54:00'),
((SELECT "id" FROM "employees" WHERE "id" = 10), (SELECT "id" FROM "orders" WHERE "id" = 3), '2022-06-28 14:03:20'),
((SELECT "id" FROM "employees" WHERE "id" = 8), (SELECT "id" FROM "orders" WHERE "id" = 4), '2019-11-18 16:12:45'),
((SELECT "id" FROM "employees" WHERE "id" = 9), (SELECT "id" FROM "orders" WHERE "id" = 5), '2019-02-19 12:06:55'),
((SELECT "id" FROM "employees" WHERE "id" = 6), (SELECT "id" FROM "orders" WHERE "id" = 6), '2023-08-04 09:03:20'),
((SELECT "id" FROM "employees" WHERE "id" = 9), (SELECT "id" FROM "orders" WHERE "id" = 7), '2021-08-25 15:31:15'),
((SELECT "id" FROM "employees" WHERE "id" = 10), (SELECT "id" FROM "orders" WHERE "id" = 8), '2024-01-25 13:48:59'),
((SELECT "id" FROM "employees" WHERE "id" = 6), (SELECT "id" FROM "orders" WHERE "id" = 9), '2024-02-05 11:40:13'),
((SELECT "id" FROM "employees" WHERE "id" = 6), (SELECT "id" FROM "orders" WHERE "id" = 10), '2024-02-01 09:58:00');

--this statement inserts the data below into the feedback table created above.
INSERT INTO "feedback" ("customer_id", "product_id", "rating")
VALUES
((SELECT "customer_id" FROM "orders" WHERE "id" = 3), (SELECT "product_id" FROM "orders" WHERE "id" = 3), '4'),
((SELECT "customer_id" FROM "orders" WHERE "id" = 8), (SELECT "product_id" FROM "orders" WHERE "id" = 8), '5'),
((SELECT "customer_id" FROM "orders" WHERE "id" = 4), (SELECT "product_id" FROM "orders" WHERE "id" = 4), '3'),
((SELECT "customer_id" FROM "orders" WHERE "id" = 2), (SELECT "product_id" FROM "orders" WHERE "id" = 2), '4');

--this statement updates the reviews column according to the total number of feedbacks into the feedback table created above.
UPDATE "e-shop"
SET "reviews" = 4;

--this view displays customers and products informations alongside some order information of plaaced orders
CREATE VIEW order details AS
SELECT "orders"."id", "first_name" AS "customer", "email", "city", "title" AS "product_name", "product_type", "payment_type", "datetime" FROM "orders"
JOIN "customers" ON "customers"."id" = "orders"."customer_id"
JOIN "products" ON "products"."id" = "orders"."product_id";

--this view extracts details of employees that handled the delivery of certain products alongside the date and time of delivery
CREATE VIEW delivery_details AS
SELECT "first_name" AS "employee", "employees"."email", "job_title", "product_name" AS "product ordered", "deliveries"."datetime" FROM "deliveries"
JOIN "employees" ON "employees"."id" = "deliveries"."employee_id"
JOIN "order details" ON "order details"."id" = "deliveries"."order_id";

--the index below speeds up the process of scanning any of the below listed columns in the customers table
CREATE INDEX "customer index"
ON "customers" ("first_name", "last_name", "city");
--the index below speeds up the process of scanning any of the below listed columns in the products table
CREATE INDEX "product index"
ON "products" ("title", "unit_price", "product_type");

