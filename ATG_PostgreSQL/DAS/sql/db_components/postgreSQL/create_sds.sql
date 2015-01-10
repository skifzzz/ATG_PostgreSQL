



create table das_sds (
	sds_name	character varying(50)	not null,
	curr_ds_name	character varying(50)	null,
	dynamo_server	character varying(80)	null,
	last_modified	date	null
,constraint das_sds_p primary key (sds_name));




