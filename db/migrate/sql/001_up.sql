CREATE TABLE categories(
  id          BIGINT NOT NULL,
  parent_id   BIGINT,
  title       VARCHAR(255),
  updated_at  TIMESTAMP     DEFAULT now(),
  created_at  TIMESTAMP     DEFAULT now(),
  shop_id     BIGINT UNSIGNED NOT NULL,
  UNIQUE KEY shop_and_category (id, shop_id),
  PRIMARY KEY (id)
);
