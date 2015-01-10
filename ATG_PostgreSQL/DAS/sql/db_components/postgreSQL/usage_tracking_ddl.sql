


/* This file contains create table statements, which will configureyour database for usage tracking */

create table das_usage_metric (
	usage_metric_id	numeric(19)	not null,
	server_identifier	character varying(100)	not null,
	usage_date	timestamp	not null,
	usage_hour_of_day	numeric(3)	not null,
	usage_value	numeric(10)	default 0 not null
,constraint das_usage_metric_p primary key (usage_metric_id));




