



create table dss_coll_scenario (
	id	character varying(25)	not null,
	scenario_name	character varying(255)	null,
	modification_time	numeric(19,0)	null,
	segment_name	character varying(255)	null,
	creator_id	character varying(25)	null,
	state	character varying(16)	null
,constraint dss_coll_scenari_p primary key (id));

/* user_id references the user table but because it is a backwards referencewe cannot have a REFERENCES(dps_user) here. */

create table dss_ind_scenario (
	id	character varying(25)	not null,
	scenario_name	character varying(255)	null,
	modification_time	numeric(19,0)	null,
	segment_name	character varying(255)	null,
	creator_id	character varying(25)	null,
	state	character varying(16)	null,
	user_id	character varying(25)	not null
,constraint dss_ind_scenario_p primary key (id));

create index dss_indscenario1_x on dss_ind_scenario (modification_time);

create table dss_scenario_strs (
	id	character varying(25)	not null,
	tag	character varying(25)	not null,
	context_str	character varying(255)	null
,constraint dss_scenario_str_p primary key (id,tag)
,constraint dss_scenrstrsid_f foreign key (id) references dss_ind_scenario (id));

create index dss_scn_st_idx on dss_scenario_strs (id);

create table dss_scenario_bools (
	id	character varying(25)	not null,
	tag	character varying(25)	not null,
	context_bool	boolean	null
,constraint dss_scenario_boo_p primary key (id,tag)
,constraint dss_scenrblsid_f foreign key (id) references dss_ind_scenario (id));

create index dss_scn_bo_idx on dss_scenario_bools (id);

create table dss_scenario_longs (
	id	character varying(25)	not null,
	tag	character varying(25)	not null,
	context_long	numeric(19,0)	null
,constraint dss_scenario_lon_p primary key (id,tag)
,constraint dss_scenrlngsid_f foreign key (id) references dss_ind_scenario (id));

create index dss_scn_lg_idx on dss_scenario_longs (id);

create table dss_scenario_dbls (
	id	character varying(25)	not null,
	tag	character varying(25)	not null,
	context_dbl	numeric(15,4)	null
,constraint dss_scenario_dbl_p primary key (id,tag)
,constraint dss_scenrdblsid_f foreign key (id) references dss_ind_scenario (id));

create index dss_scn_db_idx on dss_scenario_dbls (id);

create table dss_scenario_dates (
	id	character varying(25)	not null,
	tag	character varying(25)	not null,
	context_date	date	null
,constraint dss_scenario_dat_p primary key (id,tag)
,constraint dss_scenrdtsid_f foreign key (id) references dss_ind_scenario (id));

create index dss_scn_dt_idx on dss_scenario_dates (id);

create table dps_user_scenario (
	id	character varying(40)	not null,
	ind_scenario_id	character varying(25)	not null
,constraint dps_user_scenari_p primary key (ind_scenario_id)
,constraint dps_usrscnrid_f foreign key (id) references dps_user (id)
,constraint dps_usrsind_scnr_f foreign key (ind_scenario_id) references dss_ind_scenario (id));

create index dps_uscn_u_idx on dps_user_scenario (id);

create table dss_scenario_info (
	id	character varying(25)	not null,
	scenario_name	character varying(255)	null,
	scenario_status	integer	null,
	modification_time	numeric(19,0)	null,
	creation_time	numeric(19,0)	null,
	author	character varying(254)	null,
	last_modified_by	character varying(254)	null,
	sdl	bytea	null,
	psm_version	numeric(10)	null
,constraint dss_scenario_inf_p primary key (id));

create unique index dss_scenario_inf_x on dss_scenario_info (scenario_name);

create table dss_scen_mig_info (
	id	character varying(25)	not null,
	scenario_info_id	character varying(25)	not null,
	scenario_name	character varying(255)	null,
	modification_time	numeric(19,0)	null,
	psm_version	numeric(10)	null,
	sdl	bytea	null,
	migration_status	numeric(10)	null
,constraint dss_scenmiginfo_pk primary key (id)
,constraint dss_scenmiginfo_fk foreign key (scenario_info_id) references dss_scenario_info (id));

create index dss_scenmiginfo_id on dss_scen_mig_info (scenario_info_id);

create table dss_mig_info_seg (
	id	character varying(25)	not null,
	idx	integer	not null,
	segment_name	character varying(255)	null
,constraint dss_mig_infoseg_pk primary key (id,idx)
,constraint dss_mig_infoseg_fk foreign key (id) references dss_scen_mig_info (id));


create table dss_template_info (
	id	character varying(25)	not null,
	template_name	character varying(255)	null,
	modification_time	numeric(19,0)	null,
	creation_time	numeric(19,0)	null,
	author	character varying(254)	null,
	last_modified_by	character varying(254)	null,
	sdl	bytea	null
,constraint dss_template_inf_p primary key (id));

create unique index dss_template_inf_x on dss_template_info (template_name);

create table dss_coll_trans (
	id	character varying(25)	not null,
	scenario_name	character varying(255)	null,
	modification_time	numeric(19,0)	null,
	server_id	character varying(80)	null,
	message_bean	bytea	null,
	event_type	character varying(255)	null,
	segment_name	character varying(255)	null,
	state	character varying(16)	null,
	coll_scenario_id	character varying(25)	null,
	step	integer	null,
	current_count	integer	null,
	last_query_id	character varying(25)	null
,constraint dss_coll_trans_p primary key (id)
,constraint dss_collcoll_scn_f foreign key (coll_scenario_id) references dss_coll_scenario (id));

create index dss_ctrcid_idx on dss_coll_trans (coll_scenario_id);

create table dss_ind_trans (
	id	character varying(25)	not null,
	scenario_name	character varying(255)	null,
	modification_time	numeric(19,0)	null,
	server_id	character varying(80)	null,
	message_bean	bytea	null,
	event_type	character varying(255)	null,
	segment_name	character varying(255)	null,
	state	character varying(16)	null,
	last_query_id	character varying(25)	null
,constraint dss_ind_trans_p primary key (id));


create table dss_deletion (
	id	character varying(25)	not null,
	scenario_name	character varying(255)	null,
	modification_time	numeric(19,0)	null
,constraint dss_deletion_p primary key (id));


create table dss_server_id (
	server_id	character varying(80)	not null,
	server_type	integer	not null
,constraint dss_server_id_p primary key (server_id));


create table dss_del_seg_name (
	id	character varying(25)	not null,
	idx	integer	not null,
	segment_name	character varying(255)	null
,constraint dss_del_seg_name_p primary key (id,idx));

/* migration_info_id references the migration info table, but we don't have aREFERENCES dss_scen_mig_info(id) here, because we want to be ableto delete the migration info without deleting this row */

create table dss_migration (
	id	character varying(25)	not null,
	scenario_name	character varying(255)	null,
	old_mod_time	numeric(19,0)	null,
	new_mod_time	numeric(19,0)	null,
	migration_info_id	character varying(25)	null
,constraint dss_migration_pk primary key (id));


create table dss_mig_seg_name (
	id	character varying(25)	not null,
	idx	numeric(10)	not null,
	segment_name	character varying(255)	null
,constraint dss_mig_segname_pk primary key (id,idx)
,constraint dss_mig_segname_fk foreign key (id) references dss_migration (id));


create table dss_xref (
	id	character varying(25)	not null,
	scenario_name	character varying(255)	null,
	reference_type	character varying(30)	null,
	reference_target	character varying(255)	null
,constraint dss_xref_p primary key (id));

/* user_id references the user table but because it is a backwards referencewe cannot have a REFERENCES(dps_user) here. */

create table dss_profile_slot (
	id	character varying(25)	not null,
	slot_name	character varying(255)	null,
	item_offset	numeric(19,0)	null,
	user_id	character varying(25)	not null
,constraint dss_profile_slot_p primary key (id));


create table dps_user_slot (
	id	character varying(40)	not null,
	profile_slot_id	character varying(25)	not null
,constraint dps_user_slot_p primary key (id,profile_slot_id)
,constraint dps_usrsltid_f foreign key (id) references dps_user (id)
,constraint dps_usrsprofl_sl_f foreign key (profile_slot_id) references dss_profile_slot (id));

create index dps_usr_sltprfl_id on dps_user_slot (profile_slot_id);

create table dss_slot_items (
	slot_id	character varying(25)	not null,
	item_id	character varying(255)	null,
	idx	integer	not null
,constraint dss_slot_items_p primary key (slot_id,idx)
,constraint dss_slotslot_d_f foreign key (slot_id) references dss_profile_slot (id));


create table dss_slot_priority (
	slot_id	character varying(25)	not null,
	idx	integer	not null,
	priority	numeric(19,0)	not null
,constraint dss_slot_priorit_p primary key (slot_id,idx)
,constraint dss_slotpslot_d_f foreign key (slot_id) references dss_profile_slot (id));




