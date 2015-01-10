


create table rlex_file_folder (
	folder_id	character varying(40)	not null,
	folder_name	character varying(255)	not null,
	parent_folder	character varying(40)	null
,constraint file_folder_pk primary key (folder_id));

create index rlex_file_fold_id1 on rlex_file_folder (folder_name);

create table rlex_file_asset (
	file_asset_id	character varying(40)	not null,
	asset_type	numeric(19)	not null,
	filename	character varying(255)	not null,
	last_modified	date	null,
	size_bytes	numeric(19)	null,
	parent_folder	character varying(40)	null
,constraint file_asset_rl_pk primary key (file_asset_id)
,constraint rlex_file_fold_fk foreign key (parent_folder) references rlex_file_folder (folder_id));

create index rlex_file_asst_id2 on rlex_file_asset (parent_folder);
create index rlex_file_asst_id1 on rlex_file_asset (filename);
create index rlex_file_asst_id3 on rlex_file_asset (size_bytes);
create index rlex_file_asst_id4 on rlex_file_asset (last_modified);

create table rlex_text_file (
	text_file_id	character varying(40)	not null,
	text_content	text	null
,constraint rlex_text_file_pk primary key (text_file_id)
,constraint rlex_text_file_fk foreign key (text_file_id) references rlex_file_asset (file_asset_id));


create table rlex_binary_file (
	binary_file_id	character varying(40)	not null,
	binary_content	bytea	null
,constraint rlex_binary_fil_pk primary key (binary_file_id)
,constraint rlex_binary_fil_fk foreign key (binary_file_id) references rlex_file_asset (file_asset_id));


create table rlex_article_file (
	article_file_id	character varying(40)	not null,
	published_date	date	null,
	keywords	character varying(80)	null
,constraint rlex_article_fi_pk primary key (article_file_id)
,constraint rlex_article_fi_fk foreign key (article_file_id) references rlex_file_asset (file_asset_id));


create table rlex_user (
	id	character varying(32)	not null,
	nam_col	character varying(32)	null,
	age_col	character varying(32)	null
,constraint rlex_user_p primary key (id));


create table rlex_address (
	addr_id	character varying(32)	not null,
	user_id	character varying(32)	null,
	street	character varying(32)	null,
	city	character varying(32)	null
,constraint rlex_address_p primary key (addr_id)
,constraint rlex_address_f1 foreign key (user_id) references rlex_user (id));


create table rlex_contact (
	con_id	character varying(32)	not null,
	rank	numeric(10)	not null,
	user_id	character varying(32)	null,
	email	character varying(255)	null,
	url	character varying(255)	null
,constraint rlex_contact_p primary key (con_id,rank)
,constraint rlex_contact_f1 foreign key (user_id) references rlex_user (id));


create table rlex_phone (
	phone_id	character varying(32)	not null,
	kind	character varying(64)	not null,
	user_id	character varying(32)	null,
	pnumber	character varying(64)	null
,constraint rlex_phone_p primary key (phone_id,kind)
,constraint rlex_phone_f1 foreign key (user_id) references rlex_user (id));


create table rlex_job (
	id	character varying(32)	not null,
	jobtype	character varying(32)	null,
	title	character varying(32)	null
,constraint rlex_job_p primary key (id)
,constraint rlex_job_f1 foreign key (id) references rlex_user (id));


create table rlex_subjects (
	id	character varying(32)	not null,
	seq_num	numeric(10)	not null,
	subject	character varying(32)	null
,constraint rlex_subjects_p primary key (id,seq_num)
,constraint rlex_subjects_f1 foreign key (id) references rlex_user (id));


create table rlex_worst (
	id	character varying(32)	not null,
	seq_num	numeric(10)	not null,
	subject	character varying(32)	null
,constraint rlex_worst_p primary key (id,seq_num)
,constraint rlex_worst_f1 foreign key (id) references rlex_user (id));


create table rlex_credit_card (
	id	character varying(32)	not null,
	card_key	character varying(32)	not null,
	card_num	character varying(32)	null
,constraint rlex_credit_card_p primary key (id,card_key)
,constraint rlex_credit_f1 foreign key (id) references rlex_user (id));




