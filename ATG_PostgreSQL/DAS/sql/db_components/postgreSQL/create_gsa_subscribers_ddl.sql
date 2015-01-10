



create table das_gsa_subscriber (
	id	integer	not null,
	address	character varying(50)	not null,
	port	integer	not null,
	repository	character varying(256)	not null,
	itemdescriptor	character varying(256)	not null
,constraint das_gsa_subscrib_p primary key (id));




