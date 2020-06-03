/* entities eller hvad det nu hedder */
CREATE TABLE wikinews_article (
    article_id int,
    content TEXT,
    title varchar(1000),
    screaped_at DATE,
    publish_date DATE,
    PRIMARY KEY (article_id)
);

CREATE TABLE wikinews_sources (
    source_domain_id int,
    source_domain varchar(255),
    PRIMARY KEY (source_domain_id)
);

CREATE TABLE wikinews_categories (
    category_id int,
    category varchar(1000),
    PRIMARY KEY (category_id)
);

/* relations */
CREATE TABLE wikinews_source_to (
    article_id int,
    source_domain_id int,
    PRIMARY KEY (article_id, source_domain_id),
    FOREIGN KEY(article_id) References article,
    FOREIGN KEY(source_domain_id) References sources
);

CREATE TABLE wikinews_in_category (
    article_id Int,
    category_id int,
    PRIMARY KEY (article_id, category_id),
    FOREIGN KEY(article_id) References article,
    FOREIGN KEY(category_id) References categories
);
