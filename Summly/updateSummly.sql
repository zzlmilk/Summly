CREATE TABLE [summly_table] (topic_id integer NOT NULL,title text,content text,source text,image_url text,time text,interval text,identifieId integer NOT NULL PRIMARY KEY UNIQUE);

CREATE TABLE [collect_table] (topic_id integer NOT NULL,title text,content text,source text,image_url text,time text,interval text,identifieId integer NOT NULL)
