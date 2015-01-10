


/*     These tables are for the daf deployment system  */  

create table das_deployment (
	deployment_id	character varying(40)	not null,
	version	numeric(10)	not null,
	start_time	date	null,
	end_time	date	null,
	failure_time	date	null,
	status	numeric(10)	null,
	prev_status	numeric(10)	null,
	status_detail	character varying(255)	null,
	current_phase	numeric(10)	null,
	rep_high_mark	numeric(10)	null,
	rep_marks_avail	numeric(10)	null,
	file_high_mark	numeric(10)	null,
	file_marks_avail	numeric(10)	null,
	thread_batch_size	numeric(10)	null,
	failure_count	numeric(10)	null,
	purge_deploy_data	boolean	null
,constraint daf_depl_pk primary key (deployment_id));

create index das_dpl_start_idx on das_deployment (start_time);

create table das_depl_progress (
	deployment_id	character varying(40)	not null,
	version	numeric(10)	not null,
	work_completed	numeric(10)	null,
	total_work	numeric(10)	null
,constraint daf_depl_prg_pk primary key (deployment_id));


create table das_thread_batch (
	thread_batch_id	character varying(40)	not null,
	version	numeric(10)	not null,
	deployment	character varying(40)	null,
	type	numeric(10)	null,
	owner	character varying(255)	null,
	thread_name	character varying(255)	null,
	lower_bound	numeric(10)	null,
	upper_bound	numeric(10)	null,
	last_update_time	timestamp	null,
	running	boolean	not null
,constraint das_dpl_tb_pk primary key (thread_batch_id));

create index das_tb_deployment on das_thread_batch (deployment);
create index das_tb_owner on das_thread_batch (owner);
create index das_tb_thread_nam on das_thread_batch (thread_name);

create table das_deploy_data (
	deploy_data_id	character varying(40)	not null,
	version	numeric(10)	not null,
	type	numeric(10)	null,
	source	character varying(255)	null,
	destination	character varying(255)	null,
	dest_server	character varying(255)	null,
	deployment	character varying(40)	null
,constraint deploy_data_pk primary key (deploy_data_id)
,constraint dd_deployment_fk foreign key (deployment) references das_deployment (deployment_id));

create index dd_deployment_idx on das_deploy_data (deployment);

create table das_deploy_mark (
	marker_id	character varying(40)	not null,
	version	numeric(10)	not null,
	type	numeric(10)	null,
	status	numeric(10)	null,
	index_number	numeric(10)	null,
	marker_action	numeric(10)	null,
	f_src_devline_id	character varying(40)	null,
	r_src_devline_id	character varying(40)	null,
	deployment_id	character varying(40)	null,
	deployment_data	character varying(40)	null
,constraint marker_pk primary key (marker_id));

create index marker_index_idx on das_deploy_mark (index_number);
create index marker_data_idx on das_deploy_mark (deployment_data);

create table das_rep_mark (
	rep_marker_id	character varying(40)	not null,
	item_desc_name	character varying(255)	null,
	item_id	character varying(255)	null
,constraint rep_marker_pk primary key (rep_marker_id));


create table das_file_mark (
	file_marker_id	character varying(40)	not null,
	file_path	character varying(1000)	null
,constraint file_marker_pk primary key (file_marker_id));


create table das_depl_depldat (
	deployment_id	character varying(40)	not null,
	sequence_num	numeric(10)	not null,
	deployment_data	character varying(40)	null
,constraint das_dpl_depdat_pk primary key (deployment_id,sequence_num));


create table das_depl_options (
	deployment_id	character varying(40)	not null,
	tag	character varying(255)	not null,
	optionValue	character varying(255)	null
,constraint das_dpl_depopt_pk primary key (deployment_id,tag));


create table das_depl_repmaps (
	deployment_id	character varying(40)	not null,
	source	character varying(255)	not null,
	destination	character varying(255)	null
,constraint das_dpl_repmap_pk primary key (deployment_id,source));


create table das_depl_item_ref (
	item_ref_id	character varying(40)	not null,
	version	numeric(10)	not null,
	deployment_id	character varying(40)	null,
	repository	character varying(255)	null,
	item_desc_name	character varying(255)	null,
	item_id	character varying(255)	null,
	item_index	numeric(10)	null
,constraint das_dpl_itmref_pk primary key (item_ref_id));

create index das_dpl_itmx_idx on das_depl_item_ref (item_index);
create index das_dpl_dplid_idx on das_depl_item_ref (deployment_id);

create table das_dd_markers (
	deploy_data_id	character varying(40)	not null,
	sequence_num	numeric(10)	not null,
	marker	character varying(40)	null
,constraint das_dpl_dd_mrk_pk primary key (deploy_data_id,sequence_num)
,constraint marker_fk foreign key (marker) references das_deploy_mark (marker_id));

create index marker_idx on das_dd_markers (marker);

create table das_dep_fail_info (
	id	character varying(40)	not null,
	deployment_id	character varying(40)	not null,
	marker_id	character varying(40)	null,
	severity	character varying(40)	null,
	failure_message	character varying(255)	null,
	failure_time	timestamp	null,
	error_code	character varying(40)	null,
	cause	text	null
,constraint das_dp_fl_inf_pk primary key (id));

create index das_dep_fl_dp_idx on das_dep_fail_info (deployment_id);



