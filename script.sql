-- Подключаемся к clickhouse как пользовватель default (без пароля)
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
CREATE ROLE IF NOT EXISTS mainselect;

-- Предоставляем права на чтение роли mainselect в базе данных main
GRANT SELECT ON main.* TO mainselect;

-- Создаём роль maininsert
CREATE ROLE IF NOT EXISTS maininsert;

-- Предоставляем права на запись роли maininsert в базе данных main
GRANT INSERT ON main.* TO maininsert;

-- Создаём пользователя user1
CREATE USER IF NOT EXISTS user1;

-- Назначаем роль mainselect пользователю user1 (права на чтение из базы данных main)
GRANT mainselect TO user1;

-- В DBeaver отключаем соединение с clickhouse и удаляем его. Затем как пользователь user1 подключаемся к clickhouse к базе данных main (также без пароля).
USE main;

-- Для проверки делаем запрос на чтение данных из таблицы autobrand_models базы данных main для user1 с ролью mainselect (права на чтение). Результат запроса - screen.png
SELECT (*) FROM main.autobrand_models;

-- https://github.com/ivanays/docker_clickhouse.git - этот репозитарий был клонирован. Выполнены все вышеописанные запросы и зделаны соответственно скрины (папка screens)



