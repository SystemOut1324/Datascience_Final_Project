/* Drop SCHEMA TO START FRESH */
DROP SCHEMA IF EXISTS combined CASCADE;

/* Create schema make collection of database objects including tables, views, triggers, stored procedures, indexes, etc*/
CREATE VIEW combined_news AS

SELECT id, type_id, content, title 
FROM fakenews.article;
    