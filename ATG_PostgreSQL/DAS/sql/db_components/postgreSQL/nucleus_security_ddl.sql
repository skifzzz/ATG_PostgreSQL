



create table das_nucl_sec (
	func_name	character varying(254)	not null,
	policy	character varying(254)	not null
,constraint func_name_pk primary key (func_name));


create table das_ns_acls (
	id	character varying(254)	not null,
	index_num	numeric(10)	not null,
	acl	character varying(254)	not null
,constraint id_index_pk primary key (id,index_num));




