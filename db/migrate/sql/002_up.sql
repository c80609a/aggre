CREATE TABLE shops(
  id       SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name     VARCHAR(64) UNIQUE
);

-- ALTER TABLE categories ADD CONSTRAINT fk_category_shop FOREIGN KEY categories(shop_id) REFERENCES shops(id);
