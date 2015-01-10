



create table dss_audit_trail (
	id	character varying(32)	not null,
	timestamp	date	null,
	label	character varying(255)	null,
	profileid	character varying(25)	null,
	segmentName	character varying(254)	null,
	processName	character varying(254)	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null);




