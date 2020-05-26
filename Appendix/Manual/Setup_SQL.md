# Setting up SQL database (Fakenew's data)

This document is based on the fakenews dataset

## Preparation of data
When you have the data set in csv format, you first need to update it in smaller parts and clean up the data. This can be done with the script: https://github.com/JonathanAhrenkiel-Frellsen/Milestone_Datascience/blob/master/Organize_Daniel_crash.ipynb
This is the script we use in the milestone task.

## Configuration of tools
After that you have to set up your database. This can be done in the pgadmin or psql terminal. I'm starting from psql! The credentials to use in psql are just the default and then your code (the code does not have to be long, it is usually just "root").

## Setting up the database
First man builds databases it is a good idea by writing "\ d" in psql, this gives all tables. If empty, you can continue, if you want to delete a table, type "DROP TABLE [table_name] CASCADE;" [table_name] is the name of the table you want to delete, CASCADE is not necessary only if you end a table related to other tables or vice versa. REMEMBER SIMICOLON I always forget it 😉
When or if you deleted the tables that should not be there you can type the command "\ i [sti_til_sql_fil] .sql;" example: "\ in C: /Users/jola1/Desktop/ERDreal.sql;" it is important to type "/" and not "\", but is not safe. After that, you can type "\ d" again to see if your tables are made.

## Populating the Database
Now you have set up the csv files from the section "Preparation of data" and set up databases in the section "Setup of databases" now you can transfer data from the csv files to databases with psql. This is what the man does with the command: “\ COPY [table_name] FROM '[csv_file_position]' DELIMITER ',' CSV HEADER;
Her is an example:
\ COPY article (id, domain_id, type_id, url, content, title, meta_descript, scraped_at, updated_at, inserted_at) FROM 'C: /Users/jola1/Desktop/Milestone_Datascience-master/article_clean.csv' DELIMITER ',' CSV HEADER ;
or
\ COPY article FROM 'C: /Users/jola1/Desktop/Milestone_Datascience-master/article_clean.csv' DELIMITER ',' CSV HEADER;
The sql file I use can download from her:
https://discordapp.com/channels/@me/690271126944874496/714802715682668585


# DK

Opsætning af SQL-database (Fakenews data)
Dette dokument tager udgangspunkt i fakenews datasættet

Klargøring af data
Når man har datasættet i csv-format skal man først opdatere det i mindre dele og ryde på i data’et. Dette kan gøre med scriptet: https://github.com/JonathanAhrenkiel-Frellsen/Milestone_Datascience/blob/master/Organize_Daniel_crash.ipynb
Dette er det script vi bruger i milepæl opgaven.

Opsætning af værktøjer
Efter det skal man opsætte sin database. Dette kan man gøre i pgadmin eller psql terminalen. Jeg tager udgangspunkt i psql! De legitimationsoplysninger der skal bruges i psql er bare standard og derefter din kode (koden behøver ikke at være lang, det er normalt på den bare er ”rod”).

Opstilling af databasen
Første mand opstiller databaser er det i en gud ide ved skrive ”\ d” i psql, dette giver alle tabeller. Hvis der er tom kan du forsætte, hvis du vil slætte et bord skal man skrive ”DROP TABLE [table_name] CASCADE;” [table_name] er navnet på det bord mand vil slætte, CASCADE er ikke nødvendigt, kun hvis man slutter et bord der har relation til andre tabeller eller omvent. HUSK SIMICOLON Jeg glemmer det altid 😉
Når eller hvis du har slættet tabellerne der ikke skal være der kan du skrive komandoen ”\ i [sti_til_sql_fil] .sql;” eksempel: ”\ i C: /Users/jola1/Desktop/ERDreal.sql;” tor det er vigtigt at skrive ”/” og ikke ”\”, men er ikke sikker. Efter det kan du skrive ”\ d” igen for at se om dine borde er lavet.

Befolkningsdatabase
Nu har du opsættet csv filerne fra afsnittet ”Klargøring af data” og opsættet databaser i afsnittet ”Opstilling af databaser” nu kan du overføre data fra csv filerne til databaser med psql. Dette gør mand med komandoen: “\ COPY [table_name] FRA '[csv_file_position]' DELIMITER ',' CSV HEADER;
Hendes er et eksempel:
\ COPY-artikel (id, domain_id, type_id, url, indhold, titel, meta_descript, scraped_at, opdateret_at, indsat_at) FRA 'C: /Users/jola1/Desktop/Milestone_Datascience-master/article_clean.csv' DELIMITER ',' CSV HEADER;
or
\ COPY-artikel FRA 'C: /Users/jola1/Desktop/Milestone_Datascience-master/article_clean.csv' DELIMITER ',' CSV HEADER;
Den sql fil som jeg bruger kan downloade fra hende:
https://discordapp.com/channels/@me/690271126944874496/714802715682668585