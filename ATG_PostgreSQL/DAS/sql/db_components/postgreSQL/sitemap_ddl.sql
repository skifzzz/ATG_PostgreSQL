


/* Table for siteindex repository item */

create table das_siteindex (
	siteindex_id	character varying(40)	not null,
	lastmod	date	null,
	filename	character varying(100)	null,
	xml	text	null
,constraint siteindex_pk primary key (siteindex_id));

/* Table for sitemap repository item */

create table das_sitemap (
	sitemap_id	character varying(40)	not null,
	lastmod	date	null,
	filename	character varying(100)	null,
	xml	text	null
,constraint sitemap_pk primary key (sitemap_id));




