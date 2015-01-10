


/* Purge Progress Tables */

create table das_purge_progress (
	purge_progress_id	character varying(40)	not null,
	item_type	character varying(254)	not null,
	start_timestamp	timestamp	null,
	update_timestamp	timestamp	null,
	end_timestamp	timestamp	null,
	status	numeric(10)	not null,
	success_items	numeric(10)	default 0 not null,
	skipped_items	numeric(10)	default 0 not null,
	skipped_on_error_items	numeric(10)	default 0 not null,
	error_items	numeric(10)	default 0 not null,
	processed_items	numeric(10)	default 0 not null,
	estimated_items	numeric(10)	default 0 not null,
	total_items	numeric(10)	default 0 not null,
	owner	character varying(254)	null,
	criteria	character varying(4000)	null,
	related_criteria	character varying(4000)	null,
	error_message	text	null
,constraint das_purge_pr_p primary key (purge_progress_id));




