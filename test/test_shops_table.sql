-- [ ] как вставлять одним запросом в mysql, чтобы не было автоинкремента?
-- [X] как получить id вставленной записи?

INSERT INTO shops(name) VALUES ('Тренажеры.Ру');
SELECT LAST_INSERT_ID();
SELECT * FROM shops;

INSERT IGNORE INTO shops(name) VALUES ('Тренажеры.Ру');

SELECT * FROM shops;

INSERT INTO shops(name) VALUES ('Тренажеры-для-рук-ног-и-головы.Ру');

SELECT * FROM shops;

INSERT INTO shops(name) VALUES ('Тренажеры.Ру') ON DUPLICATE KEY UPDATE name=VALUES(name);

SELECT * FROM shops;

INSERT IGNORE INTO shops(name) VALUES ('Озон');

INSERT IGNORE INTO shops(name) VALUES ('OBI');

SELECT * FROM shops;

select LAST_INSERT_ID();

--
