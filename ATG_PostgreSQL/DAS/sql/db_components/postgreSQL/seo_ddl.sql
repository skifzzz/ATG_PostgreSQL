


/* Table for seo-tag repository item */

create table das_seo_tag (
	seo_tag_id	character varying(40)	not null,
	display_name	character varying(100)	null,
	title	character varying(254)	null,
	description	character varying(254)	null,
	keywords	character varying(254)	null,
	content_key	character varying(100)	null
,constraint das_seo_tag_pk primary key (seo_tag_id));


create table das_seo_sites (
	seo_tag_id	character varying(40)	not null,
	site_id	character varying(40)	not null
,constraint das_seo_site_pk primary key (seo_tag_id,site_id));




