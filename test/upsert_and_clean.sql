-- ручной скрипт, созданный на этапе разработки кода, который:
--    * [X] должен класть новые строки в базу
--    * [X] должен обновлять поля существующих строк
--    * [X] должен удалять из базы строки, которые не пришли в новой пачке данных
--    * [X] делает это за 3 запроса к базе

-- // выполняется построчно в RubyMine
-- // mysql  Ver 15.1 Distrib 10.0.34-MariaDB, for debian-linux-gnu (x86_64) using readline 5.2

------------------------------------------------------------------------------------------------------------------------


--0) reset
--
DROP TABLE IF EXISTS test_categories;



--1) создаем тестовую таблицу
--
CREATE TABLE test_categories(
  id          BIGINT NOT NULL,
  parent_id   BIGINT,
  title       VARCHAR(255),
  updated_at  TIMESTAMP     DEFAULT now(),
  created_at  TIMESTAMP     DEFAULT now(),
  UNIQUE KEY id(id),
  PRIMARY KEY (id)
);




--2) кладём пару строк
--
INSERT INTO test_categories(id, parent_id, title) VALUES (1,NULL,'one'),(2,1,'two');





--3) смотрим, что положили
--
SELECT * FROM test_categories;
/*
+----+-----------+-------+---------------------+---------------------+
| id | parent_id | title | updated_at          | created_at          |
+----+-----------+-------+---------------------+---------------------+
|  1 |      NULL | one   | 2018-06-20 11:43:14 | 2018-06-20 11:43:14 |
|  2 |         1 | two   | 2018-06-20 11:43:14 | 2018-06-20 11:43:14 |
+----+-----------+-------+---------------------+---------------------+
*/




--4) симулируем новую порцию данных, где:
--     * одна строка обновилась   (id=1)
--     * добавилась новая строка  (id=3)
--     * она строка не пришла     (id=2)     (т.е. она как бы удалена была из YML магазина)
--
INSERT INTO test_categories(id, parent_id, title) VALUES (1,3,'one updated'),(3,1,'three') ON DUPLICATE KEY UPDATE parent_id = VALUES(parent_id), title = VALUES(title), updated_at = now();
-- шаблон запроса: INSERT INTO table(%{cols}) VALUES(%{vals}) ON DUPLICATE KEY UPDATE %{pairs}, updated_at = now();





--5) смотрим, что теперь в базе, сверяем вручную:
--    [+] должен обновится title у строки id=1
--    [+] должна появиться строка id=3
--    [+] у строк, фигурирующих в INSERT-е, должны обновиться updated_at
--    [+] у строки id=2, которая не фигурирует в INSERT-е, updated_at должен остаться необновлённым
--
SELECT * FROM test_categories;
/*
+----+-----------+-------------+---------------------+---------------------+
| id | parent_id | title       | updated_at          | created_at          |
+----+-----------+-------------+---------------------+---------------------+
|  1 |         3 | one updated | 2018-06-20 11:45:45 | 2018-06-20 11:43:14 |
|  2 |         1 | two         | 2018-06-20 11:43:14 | 2018-06-20 11:43:14 |
|  3 |         1 | three       | 2018-06-20 11:45:45 | 2018-06-20 11:45:45 |
+----+-----------+-------------+---------------------+---------------------+
*/




--6.1) Введём т.н. "время жизни строки", и установим его в 7 минут, и найдем все такие строки
--
SELECT * FROM test_categories WHERE updated_at < DATE_SUB(now(), INTERVAL 7 MINUTE);
/*
+----+-----------+-------+---------------------+---------------------+
| id | parent_id | title | updated_at          | created_at          |
+----+-----------+-------+---------------------+---------------------+
|  2 |         1 | two   | 2018-06-20 11:43:14 | 2018-06-20 11:43:14 |
+----+-----------+-------+---------------------+---------------------+
*/

--7) Удалим все такие строки.
SELECT @id := id FROM test_categories WHERE updated_at < DATE_SUB(now(), INTERVAL 7 MINUTE);
DELETE FROM test_categories WHERE id IN (@id);
