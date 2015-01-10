



create table drpt_stage_reached (
	id	character varying(40)	not null,
	owner_id	character varying(40)	not null,
	process_start_time	date	not null,
	event_time	date	not null,
	bp_name	character varying(255)	not null,
	bp_stage	character varying(255)	null,
	is_transient	boolean	not null,
	bp_stage_sequence	numeric(10)	not null);




