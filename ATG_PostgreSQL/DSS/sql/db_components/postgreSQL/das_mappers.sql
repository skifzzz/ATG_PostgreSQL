



create table dss_das_event (
	id	character varying(32)	not null,
	timestamp	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null);


create table dss_das_form (
	id	character varying(32)	not null,
	clocktime	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	formname	character varying(254)	null);




