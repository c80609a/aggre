CREATE TABLE categories(
  id          BIGINT NOT NULL,
  parent_id   BIGINT,
  title       VARCHAR(255),
  updated_at  TIMESTAMP     DEFAULT now(),
  created_at  TIMESTAMP     DEFAULT now(),
  UNIQUE KEY id(id),
  PRIMARY KEY (id)
);
