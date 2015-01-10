


/* This file contains create table statements needed to configure your database for use with the DPS logging/reporting subsystem.This script will create tables and indexes associated with the newlogging and reporting subsystem. To initialize these tables run thelogging_init.sql script. */
/* Tables for storing logging data for reports */

create table dps_event_type (
	id	integer	not null,
	name	character varying(32)	not null
,constraint dps_event_type_p primary key (id)
,constraint dps_event_type_u unique (name));


create table dps_user_event (
	id	numeric(19,0)	not null,
	timestamp	date	not null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	eventtype	integer	not null,
	profileid	character varying(25)	null,
	member	boolean	default FALSE not null
,constraint dps_user_event_p primary key (id)
,constraint dps_usrvevnttyp_f foreign key (eventtype) references dps_event_type (id));

create index dps_user_event_ix on dps_user_event (eventtype);
create index dps_ue_ts on dps_user_event (timestamp);

create table dps_user_event_sum (
	eventtype	integer	not null,
	summarycount	integer	not null,
	fromtime	date	not null,
	totime	date	not null
,constraint dps_usrsuevnttyp_f foreign key (eventtype) references dps_event_type (id));

create index dps_user_ev_sum_ix on dps_user_event_sum (eventtype);
create index dps_ues_ft on dps_user_event_sum (fromtime,totime,eventtype);

create table dps_request (
	id	numeric(19,0)	not null,
	timestamp	date	not null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	name	character varying(255)	not null,
	member	boolean	default FALSE not null
,constraint dps_request_p primary key (id));

create index dps_r_ts on dps_request (timestamp);

create table dps_reqname_sum (
	name	character varying(255)	not null,
	member	boolean	default FALSE not null,
	summarycount	integer	not null,
	fromtime	date	not null,
	totime	date	not null);

create index dps_rns_ft on dps_reqname_sum (fromtime,totime);

create table dps_session_sum (
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	member	boolean	default FALSE not null,
	summarycount	integer	not null,
	fromtime	date	not null,
	totime	date	not null);

create index dps_rss_ft on dps_session_sum (fromtime,totime,sessionid);

create table dps_con_req (
	id	numeric(19,0)	not null,
	timestamp	date	not null,
	requestid	numeric(19,0)	null,
	contentid	character varying(255)	not null
,constraint dps_con_req_p primary key (id));

create index dps_cr_ts on dps_con_req (timestamp);

create table dps_con_req_sum (
	contentid	character varying(255)	not null,
	member	boolean	default FALSE not null,
	summarycount	integer	not null,
	fromtime	date	not null,
	totime	date	not null);

create index dps_crs_ft on dps_con_req_sum (fromtime,totime);

create table dps_pgrp_req_sum (
	groupname	character varying(64)	not null,
	contentname	character varying(255)	not null,
	summarycount	integer	not null,
	fromtime	date	not null,
	totime	date	not null);

create index dps_prs_ft on dps_pgrp_req_sum (fromtime,totime);

create table dps_pgrp_con_sum (
	groupname	character varying(64)	not null,
	contentname	character varying(64)	not null,
	summarycount	integer	not null,
	fromtime	date	not null,
	totime	date	not null);

create index dps_pcs_ft on dps_pgrp_con_sum (fromtime,totime);

create table dps_log_id (
	tablename	character varying(30)	not null,
	nextid	numeric(19,0)	not null
,constraint dps_log_id_p primary key (tablename));




