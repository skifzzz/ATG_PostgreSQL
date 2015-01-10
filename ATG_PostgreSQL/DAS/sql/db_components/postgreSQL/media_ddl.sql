


/*     media content repository tables. */  

create table media_folder (
	folder_id	character varying(40)	not null,
	version	integer	not null,
	creation_date	date	null,
	description	character varying(254)	null,
	name	character varying(254)	not null,
	path	character varying(254)	not null,
	parent_folder_id	character varying(40)	null
,constraint md_folder_p primary key (folder_id)
,constraint md_foldparnt_fl_f foreign key (parent_folder_id) references media_folder (folder_id));

create index fldr_mfldrid_idx on media_folder (parent_folder_id);
create index md_fldr_path_idx on media_folder (path);

create table media_base (
	media_id	character varying(40)	not null,
	version	integer	not null,
	creation_date	date	null,
	description	character varying(254)	null,
	name	character varying(254)	not null,
	path	character varying(254)	not null,
	parent_folder_id	character varying(40)	not null,
	media_type	integer	null
,constraint media_p primary key (media_id)
,constraint medparnt_fl_f foreign key (parent_folder_id) references media_folder (folder_id));

create index med_mfldrid_idx on media_base (parent_folder_id);
create index media_path_idx on media_base (path);
create index media_type_idx on media_base (media_type);

create table media_ext (
	media_id	character varying(40)	not null,
	url	character varying(254)	not null
,constraint media_ext_p primary key (media_id)
,constraint medxtmed_d_f foreign key (media_id) references media_base (media_id));


create table media_bin (
	media_id	character varying(40)	not null,
	length	integer	not null,
	last_modified	date	not null,
	data	bytea	not null
,constraint media_bin_p primary key (media_id)
,constraint medbnmed_d_f foreign key (media_id) references media_base (media_id));


create table media_txt (
	media_id	character varying(40)	not null,
	length	integer	not null,
	last_modified	date	not null,
	data	text	not null
,constraint media_txt_p primary key (media_id)
,constraint medtxtmed_d_f foreign key (media_id) references media_base (media_id));




