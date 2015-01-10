


/* This file contains create table statements, which will configureyour database for use MultiSite */

create table site_template (
	id	character varying(40)	not null,
	name	character varying(254)	not null,
	description	character varying(254)	not null,
	item_mapping_id	character varying(40)	not null
,constraint site_template1_p primary key (id));


create table site_configuration (
	id	character varying(40)	not null,
	name	character varying(254)	not null,
	description	character varying(254)	null,
	template	character varying(40)	null,
	production_url	character varying(254)	null,
	enabled	boolean	not null,
	site_down_url	character varying(254)	null,
	open_date	date	null,
	pre_opening_url	character varying(254)	null,
	closing_date	date	null,
	post_closing_url	character varying(254)	null,
	modification_time	date	null,
	creation_time	date	null,
	author	character varying(254)	null,
	last_modified_by	character varying(254)	null,
	site_icon	character varying(254)	null,
	favicon	character varying(254)	null,
	site_priority	numeric(10)	null,
	context_root	character varying(254)	null,
	access_level	numeric(10)	null,
	realm_id	character varying(40)	null,
	endeca_site_id	character varying(254)	null
,constraint site_configurat1_p primary key (id));


create table site_additional_urls (
	id	character varying(40)	not null,
	additional_production_url	character varying(254)	null,
	idx	numeric(10)	not null
,constraint siteadditio_url1_p primary key (id,idx));


create table site_types (
	id	character varying(40)	not null,
	site_type	character varying(254)	not null
,constraint site_types1_p primary key (id,site_type));


create table site_group (
	id	character varying(40)	not null,
	display_name	character varying(254)	not null
,constraint site_group1_p primary key (id));


create table site_group_sites (
	site_id	character varying(40)	not null,
	site_group_id	character varying(40)	not null
,constraint site_group_sites_p primary key (site_id,site_group_id)
,constraint site_group_site1_f foreign key (site_id) references site_configuration (id)
,constraint site_group_site2_f foreign key (site_group_id) references site_group (id));

create index site_group_site1_x on site_group_sites (site_id);
create index site_group_site2_x on site_group_sites (site_group_id);

create table site_group_shareable_types (
	shareable_types	character varying(254)	not null,
	site_group_id	character varying(40)	not null
,constraint site_group_share_p primary key (shareable_types,site_group_id)
,constraint site_group_shar1_f foreign key (site_group_id) references site_group (id));

create index site_group_shar1_x on site_group_shareable_types (site_group_id);



