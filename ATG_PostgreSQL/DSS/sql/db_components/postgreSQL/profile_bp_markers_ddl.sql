



create table dss_user_bpmarkers (
	marker_id	character varying(40)	not null,
	profile_id	character varying(40)	not null,
	marker_key	character varying(100)	not null,
	marker_value	character varying(100)	null,
	marker_data	character varying(100)	null,
	creation_date	timestamp	null,
	version	numeric(10)	not null,
	marker_type	numeric(10)	null
,constraint dssprofilebp_p primary key (marker_id,profile_id));




