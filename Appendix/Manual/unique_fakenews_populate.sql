SET CLIENT_ENCODING TO 'utf8';

TRUNCATE TABLE fakenews.domain_name CASCADE; 
COPY fakenews.domain_name FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/domain_name_clean.csv' DELIMITER ',' CSV HEADER;

TRUNCATE TABLE fakenews.type CASCADE; 
COPY fakenews.type FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/type_clean.csv' DELIMITER ',' CSV HEADER;

TRUNCATE TABLE fakenews.article CASCADE; 
COPY fakenews.article FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/article_clean.csv' DELIMITER ',' CSV HEADER;

TRUNCATE TABLE fakenews.tags CASCADE; 
COPY fakenews.tags FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/tags_clean.csv' DELIMITER ',' CSV HEADER;

TRUNCATE TABLE fakenews.tags_In CASCADE; 
COPY fakenews.tags_In FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/tags_in.csv' DELIMITER ',' CSV HEADER;

TRUNCATE TABLE fakenews.author CASCADE; 
COPY fakenews.author FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/author_clean.csv' DELIMITER ',' CSV HEADER;

TRUNCATE TABLE fakenews.author_In CASCADE; 
COPY fakenews.author_In FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/author_In_clean.csv' DELIMITER ',' CSV HEADER;

TRUNCATE TABLE fakenews.meta_keywords CASCADE; 
COPY fakenews.meta_keywords FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/meta_keywords_clean.csv' DELIMITER ',' CSV HEADER;

TRUNCATE TABLE fakenews.meta_keywords_in CASCADE; 
COPY fakenews.meta_keywords_in FROM 'd:/Personal/OneDrive/KU-uni/DataScience/Python/Datascience_Final_Project/Appendix/Data_git_ignore/clean_csv/meta_keywords_in_clean.csv' DELIMITER ',' CSV HEADER;

