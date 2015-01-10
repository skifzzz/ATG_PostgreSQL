


/* This file contains create table statements, which will configure your database for use with the new DPS schema. */
/* Add the organization definition.  It's out of place, but since dps_user references it, it's got to be defined up here */

create table dps_organization (
	org_id	character varying(40)	not null,
	name	character varying(254)	not null,
	description	character varying(254)	null,
	parent_org	character varying(40)	null
,constraint dps_organization_p primary key (org_id)
,constraint dps_orgnparnt_rg_f foreign key (parent_org) references dps_organization (org_id));

create index dps_orgparent_org on dps_organization (parent_org);
/* Default Profile User Template */
/* Basic user info.  note: the password field size must be at a minimum 70 characters       if DPS stores a hash of the password and not the actual value. */

create table dps_user (
	id	character varying(40)	not null,
	login	character varying(40)	not null,
	auto_login	numeric(1,0)	null,
	password	character varying(70)	null,
	password_salt	character varying(250)	null,
	password_kdf	character varying(40)	null,
	realm_id	character varying(40)	null,
	member	numeric(1,0)	null,
	first_name	character varying(40)	null,
	middle_name	character varying(40)	null,
	last_name	character varying(40)	null,
	user_type	integer	null,
	locale	integer	null,
	lastactivity_date	timestamp	null,
	lastpwdupdate	timestamp	null,
	generatedpwd	numeric(1)	null,
	registration_date	timestamp	null,
	email	character varying(255)	null,
	email_status	integer	null,
	receive_email	integer	null,
	last_emailed	timestamp	null,
	gender	integer	null,
	date_of_birth	date	null,
	securityStatus	integer	null,
	description	character varying(254)	null
,constraint dps_user_p primary key (id)
,constraint dps_user1_c check (auto_login in (0,1))
,constraint dps_user2_c check (member in (0,1)));

create unique index dps_user_u on dps_user (login,realm_id);
create index dps_user_l on dps_user (lower(email));

create table dps_contact_info (
	id	character varying(40)	not null,
	user_id	character varying(40)	null,
	prefix	character varying(40)	null,
	first_name	character varying(100)	null,
	middle_name	character varying(100)	null,
	last_name	character varying(100)	null,
	suffix	character varying(40)	null,
	job_title	character varying(100)	null,
	company_name	character varying(40)	null,
	address1	character varying(50)	null,
	address2	character varying(50)	null,
	address3	character varying(50)	null,
	city	character varying(30)	null,
	state	character varying(20)	null,
	postal_code	character varying(10)	null,
	county	character varying(40)	null,
	country	character varying(40)	null,
	phone_number	character varying(30)	null,
	fax_number	character varying(30)	null
,constraint dps_contact_info_p primary key (id));


create table dps_user_address (
	id	character varying(40)	not null,
	home_addr_id	character varying(40)	null,
	billing_addr_id	character varying(40)	null,
	shipping_addr_id	character varying(40)	null
,constraint dps_user_address_p primary key (id)
,constraint dps_usrddrssid_f foreign key (id) references dps_user (id));

create index dps_usr_adr_shp_id on dps_user_address (shipping_addr_id);
create index dps_usr_blng_ad_id on dps_user_address (billing_addr_id);
create index dps_usr_home_ad_id on dps_user_address (home_addr_id);

create table dps_other_addr (
	user_id	character varying(40)	not null,
	tag	character varying(42)	not null,
	address_id	character varying(40)	not null
,constraint dps_other_addr_p primary key (user_id,tag)
,constraint dps_othrddrusr_d_f foreign key (user_id) references dps_user (id));


create table dps_mailing (
	id	character varying(40)	not null,
	name	character varying(255)	null,
	subject	character varying(80)	null,
	uniq_server_id	character varying(255)	null,
	from_address	character varying(255)	null,
	replyto	character varying(255)	null,
	template_URL	character varying(255)	null,
	alt_template_URL	character varying(255)	null,
	batch_exec_id	character varying(40)	null,
	cc	character varying(4000)	null,
	bcc	character varying(4000)	null,
	send_as_html	integer	null,
	send_as_text	integer	null,
	params	bytea	null,
	start_time	timestamp	null,
	end_time	timestamp	null,
	status	integer	null,
	num_profiles	integer	null,
	num_sent	integer	null,
	num_bounces	integer	null,
	num_soft_bounces	integer	null,
	num_errors	integer	null,
	num_skipped	numeric(10)	null,
	fill_from_templ	numeric(1,0)	null,
	is_batched	numeric(1)	null,
	ignore_fatigue	numeric(1)	null,
	batch_size	numeric(10)	null
,constraint dps_mailing_p primary key (id));


create table dps_mail_trackdata (
	mailing_id	character varying(40)	not null,
	map_key	character varying(254)	not null,
	map_value	character varying(254)	null
,constraint dps_mail_trackd_p primary key (mailing_id,map_key)
,constraint dps_mail_trackd_f foreign key (mailing_id) references dps_mailing (id));


create table dps_mail_batch (
	mailing_id	character varying(40)	not null,
	start_idx	numeric(10)	not null,
	uniq_server_id	character varying(254)	null,
	start_time	timestamp	null,
	end_time	timestamp	null,
	status	numeric(10)	null,
	num_profiles	numeric(10)	null,
	num_sent	numeric(10)	null,
	num_bounces	numeric(10)	null,
	num_errors	numeric(10)	null,
	num_skipped	numeric(10)	null,
	is_summarized	numeric(1)	null
,constraint dps_mail_batch_p primary key (mailing_id,start_idx)
,constraint dps_mailbatch_d_f foreign key (mailing_id) references dps_mailing (id));


create table dps_mail_server (
	uniq_server_id	character varying(254)	not null,
	last_updated	timestamp	null
,constraint dps_mail_server_p primary key (uniq_server_id));


create table dps_user_mailing (
	mailing_id	character varying(40)	not null,
	user_id	character varying(40)	not null,
	idx	integer	not null
,constraint dps_user_mailing_p primary key (mailing_id,user_id)
,constraint dps_usrmmalng_d_f foreign key (mailing_id) references dps_mailing (id)
,constraint dps_usrmlngusr_d_f foreign key (user_id) references dps_user (id));

create index dps_u_mail_uid on dps_user_mailing (user_id);

create table dps_email_address (
	mailing_id	character varying(40)	not null,
	email_address	character varying(255)	not null,
	idx	integer	not null
,constraint dps_email_addres_p primary key (mailing_id,idx)
,constraint dps_emldmalng_d_f foreign key (mailing_id) references dps_mailing (id));

/* Organizations/roles */

create table dps_role (
	role_id	character varying(40)	not null,
	type	integer	not null,
	version	integer	not null,
	name	character varying(254)	not null,
	description	character varying(254)	null
,constraint dps_role_p primary key (role_id));

/* Extending the user profile to include references to the roles that are assigned to this user */

create table dps_user_roles (
	user_id	character varying(40)	not null,
	atg_role	character varying(40)	not null
,constraint dps_user_roles_p primary key (user_id,atg_role)
,constraint dps_usrrlsatg_rl_f foreign key (atg_role) references dps_role (role_id)
,constraint dps_usrrlsusr_d_f foreign key (user_id) references dps_user (id));

create index dps_usr_roles_id on dps_user_roles (atg_role);

create table dps_org_role (
	org_id	character varying(40)	not null,
	atg_role	character varying(40)	not null
,constraint dps_org_role_p primary key (org_id,atg_role)
,constraint dps_orgrlorg_d_f foreign key (org_id) references dps_organization (org_id)
,constraint dps_orgrlatg_rl_f foreign key (atg_role) references dps_role (role_id));

create index dps_org_rolerole on dps_org_role (atg_role);

create table dps_role_rel_org (
	organization	character varying(40)	not null,
	sequence_num	integer	not null,
	role_id	character varying(40)	not null
,constraint dps_role_rel_org_p primary key (organization,sequence_num)
,constraint dps_rolrorgnztn_f foreign key (organization) references dps_organization (org_id)
,constraint dps_rolrlrgrol_d_f foreign key (role_id) references dps_role (role_id));

/*create index dps_role_rel_org on dps_role_rel_org (role_id);*/

create table dps_relativerole (
	role_id	character varying(40)	not null,
	dps_function	character varying(40)	not null,
	relative_to	character varying(40)	not null
,constraint dps_relativerole_p primary key (role_id)
,constraint dps_reltreltv_t_f foreign key (relative_to) references dps_organization (org_id)
,constraint dps_reltvrlrol_d_f foreign key (role_id) references dps_role (role_id));

/* create index dps_relativerole on dps_relativerole (relative_to); */

create table dps_user_org (
	organization	character varying(40)	not null,
	user_id	character varying(40)	not null
,constraint dps_user_org_p primary key (organization,user_id)
,constraint dps_usrrgorgnztn_f foreign key (organization) references dps_organization (org_id)
,constraint dps_usrrgusr_d_f foreign key (user_id) references dps_user (id));

create index dps_usr_orgusr_id on dps_user_org (user_id);

create table dps_user_org_anc (
	user_id	character varying(40)	not null,
	sequence_num	integer	not null,
	anc_org	character varying(40)	not null
,constraint dps_user_org_anc_p primary key (user_id,sequence_num)
,constraint dps_usrranc_rg_f foreign key (anc_org) references dps_organization (org_id)
,constraint dps_usrrgncusr_d_f foreign key (user_id) references dps_user (id));

create index dps_usr_org_ancanc on dps_user_org_anc (anc_org);

create table dps_org_chldorg (
	org_id	character varying(40)	not null,
	child_org_id	character varying(40)	not null
,constraint dps_org_chldorg_p primary key (org_id,child_org_id)
,constraint dps_orgcchild_rg_f foreign key (child_org_id) references dps_organization (org_id)
,constraint dps_orgcorg_d_f foreign key (org_id) references dps_organization (org_id));

create index dps_org_chldorg_id on dps_org_chldorg (child_org_id);

create table dps_org_ancestors (
	org_id	character varying(40)	not null,
	sequence_num	integer	not null,
	anc_org	character varying(40)	not null
,constraint dps_org_ancestor_p primary key (org_id,sequence_num)
,constraint dps_orgnanc_rg_f foreign key (anc_org) references dps_organization (org_id)
,constraint dps_orgnorg_d_f foreign key (org_id) references dps_organization (org_id));

create index dps_org_ancanc_org on dps_org_ancestors (anc_org);
/* Secondary organizations information */

create table dps_user_sec_orgs (
	user_id	character varying(40)	not null,
	secondary_org_id	character varying(40)	not null
,constraint dps_usr_sec_orgs_p primary key (user_id,secondary_org_id)
,constraint dps_usrsecorg_rl_f foreign key (secondary_org_id) references dps_organization (org_id)
,constraint dps_usrsorgusr_d_f foreign key (user_id) references dps_user (id));

create index dps_usr_sec_org_id on dps_user_sec_orgs (secondary_org_id);
/* Adding the folder information */

create table dps_folder (
	folder_id	character varying(40)	not null,
	type	integer	not null,
	name	character varying(254)	not null,
	parent	character varying(40)	null,
	description	character varying(254)	null
,constraint dps_folder_p primary key (folder_id)
,constraint dps_foldrparnt_f foreign key (parent) references dps_folder (folder_id));

create index dps_folderparent on dps_folder (parent);

create table dps_child_folder (
	folder_id	character varying(40)	not null,
	child_folder_id	character varying(40)	not null
,constraint dps_child_folder_p primary key (folder_id,child_folder_id)
,constraint dps_chilchild_fl_f foreign key (child_folder_id) references dps_folder (folder_id)
,constraint dps_chilfoldr_d_f foreign key (folder_id) references dps_folder (folder_id));

create index dps_chld_fldr_fld on dps_child_folder (child_folder_id);

create table dps_rolefold_chld (
	rolefold_id	character varying(40)	not null,
	role_id	character varying(40)	not null
,constraint dps_rolefold_chl_p primary key (rolefold_id,role_id)
,constraint dps_rolfrolfld_d_f foreign key (rolefold_id) references dps_folder (folder_id)
,constraint dps_rolfrol_d_f foreign key (role_id) references dps_role (role_id));

create index dps_rolfldchldrole on dps_rolefold_chld (role_id);
/* Adding the previous password information */

create table dps_user_prevpwd (
	id	character varying(40)	not null,
	seq_num	numeric(10)	not null,
	prevpwd	character varying(70)	null
,constraint dps_prevpwd_p primary key (id,seq_num)
,constraint dps_prvpwd_d_f foreign key (id) references dps_user (id));


create table dps_profile_realm (
	id	character varying(40)	not null,
	name	character varying(255)	null,
	description	character varying(255)	null
,constraint dps_prfl_rlm_p primary key (id));




