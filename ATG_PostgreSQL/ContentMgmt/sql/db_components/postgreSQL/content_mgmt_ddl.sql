



/* This file contains create table statements, which will configure your database for use with the Content Management schema. */
/* Folder*/
/* MediaContent*/

create table wcm_tag (
	id	character varying(40)	not null,
	version	integer	not null,
	tag	character varying(255)	not null
,constraint wcm_tag_p primary key (id));

create index wcm_tag_x on wcm_tag (tag);

create table wcm_media_content (
	id	character varying(40)	not null,
	version	integer	not null,
	name	character varying(1024)	not null,
	url	character varying(2048)	null,
	media_type	integer	null,
	thumbnail_image_id	character varying(40)	null,
	title	character varying(2048)	null,
	description	character varying(4000)	null,
	start_date	timestamp	null,
	end_date	timestamp	null,
	parent_folder_id	character varying(40)	null,
	last_mod_user_id	character varying(40)	null,
	last_mod_date	timestamp	null,
	creation_user_id	character varying(40)	null,
	creation_date	timestamp	null
,constraint wcm_media_p primary key (id));

/* Article */

create table wcm_article (
	id	character varying(40)	not null,
	version	integer	not null,
	name	character varying(1024)	not null,
	headline	character varying(2048)	null,
	main_image_id	character varying(40)	null,
	thumbnail_image_id	character varying(40)	null,
	title	character varying(2048)	null,
	description	character varying(4000)	null,
	author	character varying(1024)	null,
	post_date	timestamp	null,
	start_date	timestamp	null,
	end_date	timestamp	null,
	parent_folder_id	character varying(40)	null,
	last_mod_user_id	character varying(40)	null,
	last_mod_date	timestamp	null,
	creation_user_id	character varying(40)	null,
	creation_date	timestamp	null,
	article_body	text	null,
	abstract	text	null
,constraint wcm_article_p primary key (id));


create table wcm_media_sites (
	media_id	character varying(40)	not null,
	site_id	character varying(40)	not null
,constraint wcm_media_sites_p primary key (media_id,site_id));

create index wcm_media_sites_x on wcm_media_sites (site_id);

create table wcm_media_tags (
	media_id	character varying(40)	not null,
	tag_id	character varying(40)	not null
,constraint wcm_media_tags_p primary key (media_id,tag_id)
,constraint wcm_media_tags1_f foreign key (media_id) references wcm_media_content (id)
,constraint wcm_media_tags2_f foreign key (tag_id) references wcm_tag (id));

create index wcm_media_tags_idx on wcm_media_tags (tag_id);

create table wcm_media_rltd_media (
	media_id	character varying(40)	not null,
	sequence_num	integer	not null,
	related_media_id	character varying(40)	not null
,constraint wcm_media_rltd_media_p primary key (media_id,sequence_num)
,constraint wcm_media_rltd_media1_f foreign key (media_id) references wcm_media_content (id)
,constraint wcm_media_rltd_media2_f foreign key (related_media_id) references wcm_media_content (id));

create index wcm_media_rltd_idx on wcm_media_rltd_media (related_media_id);

create table wcm_article_sites (
	article_id	character varying(40)	not null,
	site_id	character varying(40)	not null
,constraint wcm_article_sites_p primary key (article_id,site_id));

create index wcm_article_sites_x on wcm_article_sites (site_id);

create table wcm_article_tags (
	article_id	character varying(40)	not null,
	tag_id	character varying(40)	not null
,constraint wcm_article_tags_p primary key (article_id,tag_id)
,constraint wcm_article_tags1_f foreign key (article_id) references wcm_article (id)
,constraint wcm_article_tags2_f foreign key (tag_id) references wcm_tag (id));

create index wcm_article_tags_idx on wcm_article_tags (tag_id);

create table wcm_article_rltd_article (
	article_id	character varying(40)	not null,
	sequence_num	integer	not null,
	related_article_id	character varying(40)	not null
,constraint wcm_article_rltd_article_p primary key (article_id,sequence_num)
,constraint wcm_article_rltd_article1_f foreign key (article_id) references wcm_article (id)
,constraint wcm_article_rltd_article2_f foreign key (related_article_id) references wcm_article (id));

create index wcm_article_rltd_idx on wcm_article_rltd_article (related_article_id);

create table wcm_article_rltd_media (
	article_id	character varying(40)	not null,
	sequence_num	integer	not null,
	related_media_id	character varying(40)	not null
,constraint wcm_article_rltd_media_p primary key (article_id,sequence_num)
,constraint wcm_article_rltd_media1_f foreign key (article_id) references wcm_article (id)
,constraint wcm_article_rltd_media2_f foreign key (related_media_id) references wcm_media_content (id));

/* create index wcm_article_rltd_idx on wcm_article_rltd_media (related_media_id); */

create table wcm_media_rltd_article (
	media_id	character varying(40)	not null,
	sequence_num	integer	not null,
	related_article_id	character varying(40)	not null
,constraint wcm_media_rltd_article_p primary key (media_id,sequence_num)
,constraint wcm_media_rltd_article1_f foreign key (media_id) references wcm_media_content (id)
,constraint wcm_media_rltd_article2_f foreign key (related_article_id) references wcm_article (id));

/* create index wcm_media_rltd_idx on wcm_media_rltd_article (related_article_id); */

create table wcm_folder (
	id	character varying(40)	not null,
	version	integer	not null,
	name	character varying(1024)	not null,
	description	character varying(4000)	null,
	parent_folder_id	character varying(40)	null,
	last_mod_user_id	character varying(40)	null,
	last_mod_date	timestamp	null,
	creation_user_id	character varying(40)	null,
	creation_date	timestamp	null
,constraint wcm_folder_p primary key (id));




