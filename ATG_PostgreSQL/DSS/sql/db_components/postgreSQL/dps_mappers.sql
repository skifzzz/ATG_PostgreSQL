



create table dss_dps_event (
	id	character varying(32)	not null,
	timestamp	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	profileid	character varying(25)	null,
	scenarioPathInfo	character varying(254)	null);


create table dss_dps_page_visit (
	id	character varying(32)	not null,
	timestamp	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	path	character varying(255)	null,
	profileid	character varying(25)	null);


create table dss_dps_view_item (
	id	character varying(32)	not null,
	timestamp	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	repositoryname	character varying(255)	null,
	folder	character varying(255)	null,
	itemtype	character varying(255)	null,
	repositoryid	character varying(255)	null,
	itemdescriptor	character varying(255)	null,
	page	character varying(255)	null,
	profileid	character varying(25)	null);


create table dss_dps_click (
	id	character varying(32)	not null,
	timestamp	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	destinationpath	character varying(255)	null,
	sourcenames	character varying(255)	null,
	sourcepath	character varying(255)	null,
	profileid	character varying(25)	null);


create table dss_dps_referrer (
	id	character varying(32)	not null,
	timestamp	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	referrerpath	character varying(255)	null,
	referrersite	character varying(255)	null,
	referrerpage	character varying(255)	null,
	profileid	character varying(25)	null);


create table dss_dps_inbound (
	id	character varying(32)	not null,
	timestamp	date	null,
	messagesubject	character varying(255)	null,
	originalsubject	character varying(255)	null,
	messagefrom	character varying(64)	null,
	messageto	character varying(255)	null,
	messagecc	character varying(255)	null,
	messagereplyto	character varying(64)	null,
	receiveddate	numeric(19,0)	null,
	bounced	character varying(6)	null,
	bounceemailaddr	character varying(255)	null,
	bouncereplycode	character varying(10)	null,
	bounceerrormess	character varying(255)	null,
	bouncestatuscode	character varying(10)	null);


create table dss_dps_admin_reg (
	id	character varying(32)	not null,
	clocktime	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	adminprofileid	character varying(25)	null,
	profileid	character varying(25)	null);


create table dss_dps_property (
	id	character varying(32)	not null,
	clocktime	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	propertypath	character varying(254)	null,
	oldvalue	character varying(254)	null,
	newvalue	character varying(254)	null,
	changesign	character varying(16)	null,
	changeamount	numeric(19,7)	null,
	changepercentage	numeric(19,7)	null,
	elementsadded	character varying(254)	null,
	elementsremoved	character varying(254)	null,
	profileid	character varying(25)	null);


create table dss_dps_admin_prop (
	id	character varying(32)	not null,
	clocktime	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	propertypath	character varying(254)	null,
	oldvalue	character varying(254)	null,
	newvalue	character varying(254)	null,
	changesign	character varying(16)	null,
	changeamount	numeric(19,7)	null,
	changepercentage	numeric(19,7)	null,
	elementsadded	character varying(254)	null,
	elementsremoved	character varying(254)	null,
	adminprofileid	character varying(25)	null,
	profileid	character varying(25)	null);


create table dss_dps_update (
	id	character varying(32)	not null,
	clocktime	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	changedproperties	character varying(4000)	null,
	oldvalues	character varying(4000)	null,
	newvalues	character varying(4000)	null,
	profileid	character varying(25)	null);


create table dss_dps_admin_up (
	id	character varying(32)	not null,
	clocktime	date	null,
	sessionid	character varying(100)	null,
	parentsessionid	character varying(100)	null,
	changedproperties	character varying(4000)	null,
	oldvalues	character varying(4000)	null,
	newvalues	character varying(4000)	null,
	adminprofileid	character varying(25)	null,
	profileid	character varying(25)	null);


create table dps_scenario_value (
	id	character varying(40)	not null,
	tag	character varying(42)	not null,
	scenario_value	character varying(100)	null
,constraint dps_scenario_val_p primary key (id,tag)
,constraint dps_scenrvlid_f foreign key (id) references dps_user (id));

create index dps_scenval_id on dps_scenario_value (id);



