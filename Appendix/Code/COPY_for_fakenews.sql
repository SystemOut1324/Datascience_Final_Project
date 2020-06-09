/* This file is unique to one pc, use Setup_SQL.ipynb to generate local */

/* Remove all data from SCHEMA */
TRUNCATE TABLE fakenews.domain_name CASCADE;

TRUNCATE TABLE fakenews.type CASCADE;

TRUNCATE TABLE fakenews.article CASCADE;

TRUNCATE TABLE fakenews.tags CASCADE;

TRUNCATE TABLE fakenews.tags_in CASCADE;

TRUNCATE TABLE fakenews.authors CASCADE;

TRUNCATE TABLE fakenews.authors_in CASCADE;

TRUNCATE TABLE fakenews.meta_keywords CASCADE;

TRUNCATE TABLE fakenews.meta_keywords_in CASCADE;

/* Used for encoding error */
SET CLIENT_ENCODING TO 'utf8';

/* COPY into SCHEMA */
\COPY fakenews.domain_name FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/domain_name.csv' DELIMITER ',' CSV HEADER;

COPY fakenews.type FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/type.csv' DELIMITER ',' CSV HEADER;

COPY fakenews.article FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/article.csv' DELIMITER ',' CSV HEADER;

COPY fakenews.tags FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/tags.csv' DELIMITER ',' CSV HEADER;

COPY fakenews.tags_in FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/tags_in.csv' DELIMITER ',' CSV HEADER;

COPY fakenews.authors FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/authors.csv' DELIMITER ',' CSV HEADER;

COPY fakenews.authors_in FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/authors_in.csv' DELIMITER ',' CSV HEADER;

COPY fakenews.meta_keywords FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/meta_keywords.csv' DELIMITER ',' CSV HEADER;

COPY fakenews.meta_keywords_in FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/meta_keywords_in.csv' DELIMITER ',' CSV HEADER;



