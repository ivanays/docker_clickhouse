-- Создаём базу данных test
CREATE DATABASE IF NOT EXISTS test;

-- Создаём базу данных main
CREATE DATABASE IF NOT EXISTS main;

USE main;

-- Создаём таблицу autobrand_models в базе данных main
CREATE TABLE IF NOT EXISTS main.autobrand_models 
(
    model_id UInt32,
    model_name String
)
ENGINE = MergeTree()
PRIMARY KEY (model_id)

-- Заполняем таблицу autobrand_models данными
INSERT INTO main.autobrand_models (*) VALUES (1, 'AUDI');

-- Создаём роль mainselect
CREATE ROLE mainselect;

-- Предоставляем права на чтение роли mainselect в базе данных main
GRANT SELECT ON db.main TO mainselect;

-- Создаём роль maininsert
CREATE ROLE maininsert;

-- Предоставляем права на запись роли maininsert в базе данных main
GRANT INSERT ON db.main TO maininsert;

-- Создаём пользователя driver
CREATE USER IF NOT EXISTS driver;

-- Назначаем роль mainselect пользователю driver (права на чтение базы данный main)
GRANT mainselect TO driver;

-- Логинимся в DBeaver как пользователь driver и применяем роль mainselect
SET ROLE mainselect;

USE main;

-- Результат запроса на чтение данных из таблицы autobrand_models базы данных main - screen1.png
SELECT (*) FROM main.autobrand_models;

-- Результат запроса на запись данных в таблицу autobrand_models базы данных main - screen2.png
INSERT INTO main.autobrand_models (*) VALUES (2, 'BMW');


