


/* This file contains create table statements needed to configure your database for personzalization assets.This script will create tables and indexes associated with the user segment list manager. */

create table dps_seg_list (
	segment_list_id	character varying(40)	not null,
	display_name	character varying(256)	null,
	description	character varying(1024)	null,
	folder_id	character varying(40)	null
,constraint dps_seg_list_p primary key (segment_list_id));


create table dps_seg_list_name (
	segment_list_id	character varying(40)	not null,
	seq	numeric(10)	not null,
	group_name	character varying(256)	not null
,constraint dps_s_l_n_p primary key (segment_list_id,seq)
,constraint dps_s_l_n_f1 foreign key (segment_list_id) references dps_seg_list (segment_list_id));


create table dps_seg_list_folder (
	folder_id	character varying(40)	not null,
	display_name	character varying(256)	null,
	description	character varying(1024)	null,
	parent_folder_id	character varying(40)	null
,constraint dps_s_l_f_p primary key (folder_id)
,constraint dps_s_l_f_f1 foreign key (parent_folder_id) references dps_seg_list_folder (folder_id));

create index dps_sgmlstfldr1_x on dps_seg_list_folder (parent_folder_id);



