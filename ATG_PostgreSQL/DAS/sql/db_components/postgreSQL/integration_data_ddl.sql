



create table if_integ_data (
	item_id	character varying(40)	not null,
	descriptor	character varying(64)	not null,
	repository	character varying(255)	not null,
	state	numeric(10)	not null,
	last_import	date	null,
	version	numeric(10)	not null
,constraint if_int_data_p primary key (item_id,descriptor,repository));




