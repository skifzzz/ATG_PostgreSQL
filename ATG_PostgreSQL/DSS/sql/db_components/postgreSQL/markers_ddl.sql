



create table dps_markers (
	marker_id	character varying(40)	not null,
	marker_key	character varying(100)	not null,
	marker_value	character varying(100)	null,
	marker_data	character varying(100)	null,
	creation_date	timestamp	null,
	version	numeric(10)	not null,
	marker_type	numeric(10)	null
,constraint dps_markers_p primary key (marker_id));


create table dps_usr_markers (
	profile_id	character varying(40)	not null,
	marker_id	character varying(40)	not null,
	sequence_num	numeric(10)	not null
,constraint dps_usr_markers_p primary key (profile_id,sequence_num)
,constraint dpsusrmarkers_u_f foreign key (profile_id) references dps_user (id)
,constraint dpsusrmarkers_m_f foreign key (marker_id) references dps_markers (marker_id));

create index dpsusrmarkers1_ix on dps_usr_markers (marker_id);



