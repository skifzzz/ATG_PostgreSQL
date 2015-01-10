


/* SQL for creating the Dynamo Staff Repository for the GSA */
/* Primary account table. */
/*  Type=1 is a login account.  The first_name, last_name, and password         fields are valid for this type of account. */
/* Type=2 is a group account.  The description field is valid for        this type of account. */
/* Type=4 is a privilege account.  The description field is valid for        this type of account. */

create table das_account (
	account_name	character varying(254)	not null,
	type	integer	not null,
	first_name	character varying(254)	null,
	last_name	character varying(254)	null,
	password	character varying(254)	null,
	description	character varying(254)	null,
	lastpwdupdate	date	null,
	password_kdf	character varying(250)	null
,constraint das_account_p primary key (account_name));


create table das_group_assoc (
	account_name	character varying(254)	not null,
	sequence_num	integer	not null,
	group_name	character varying(254)	not null
,constraint das_grp_asc_p primary key (account_name,sequence_num));

/* Adding the previous password information */

create table das_acct_prevpwd (
	account_name	character varying(254)	not null,
	seq_num	numeric(10)	not null,
	prevpwd	character varying(70)	null
,constraint das_prevpwd_p primary key (account_name,seq_num)
,constraint das_prvpwd_d_f foreign key (account_name) references das_account (account_name));




