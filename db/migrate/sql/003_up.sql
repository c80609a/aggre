CREATE TABLE offers(
  id            BIGINT        NOT NULL PRIMARY KEY,
  available     BOOLEAN       NOT NULL,
  group_id      BIGINT        NOT NULL,
  name          VARCHAR(255)  NOT NULL,
  description   TEXT,
  price         DECIMAL(15,2) NOT NULL,
  url           VARCHAR(255)  NOT NULL,
  picture       VARCHAR(255)  NOT NULL,
  vendor        VARCHAR(255)  NOT NULL,
  age           VARCHAR(64)   NOT NULL,
  barcode       BIGINT        NOT NULL,
  delivery      BOOLEAN       NOT NULL,
  updated_at    TIMESTAMP     DEFAULT now(),
  created_at    TIMESTAMP     DEFAULT now(),
  shop_id       SMALLINT
);

