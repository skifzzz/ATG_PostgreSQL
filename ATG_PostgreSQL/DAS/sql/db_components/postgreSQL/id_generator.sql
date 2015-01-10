



create table das_id_generator (
	id_space_name	character varying(60)	not null,
	seed	numeric(19,0)	not null,
	batch_size	integer	not null,
	prefix	character varying(10)	null,
	suffix	character varying(10)	null
,constraint das_id_generator_p primary key (id_space_name));


create table das_secure_id_gen (
	id_space_name	character varying(60)	not null,
	seed	numeric(19,0)	not null,
	batch_size	integer	not null,
	ids_per_batch	integer	null,
	prefix	character varying(10)	null,
	suffix	character varying(10)	null
,constraint das_secure_id_ge_p primary key (id_space_name));
