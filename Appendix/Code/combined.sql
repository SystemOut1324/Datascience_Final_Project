/* Drop SCHEMA TO START FRESH */
DROP SCHEMA IF EXISTS combined CASCADE;

/* Create schema make collection of database objects including tables, views, triggers, stored procedures, indexes, etc*/
CREATE MATERIALIZED VIEW combined.combined AS
SELECT id, type_id, content, title FROM fakenews.article
UNION ALL
SELECT article_id as id, category, content, title FROM wikinews.article

CREATE MATERIALIZED VIEW combined.types AS
SELECT * FROM fakenews.type

CREATE MATERIALIZED VIEW combined.tags AS
SELECT * FROM wikinews.categories
UNION ALL
SELECT * FROM fakenews.type
    