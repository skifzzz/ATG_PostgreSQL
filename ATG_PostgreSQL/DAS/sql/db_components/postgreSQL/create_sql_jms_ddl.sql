



create table dms_client (
	client_name	character varying(250)	not null,
	client_id	numeric(19,0)	null
,constraint dms_client_p primary key (client_name));


create table dms_queue (
	queue_name	character varying(250)	null,
	queue_id	numeric(19,0)	not null,
	temp_id	numeric(19,0)	null
,constraint dms_queue_p primary key (queue_id));


create table dms_queue_recv (
	client_id	numeric(19,0)	null,
	receiver_id	numeric(19,0)	not null,
	queue_id	numeric(19,0)	null
,constraint dms_queue_recv_p primary key (receiver_id));


create table dms_queue_entry (
	queue_id	numeric(19,0)	not null,
	msg_id	numeric(19,0)	not null,
	delivery_date	numeric(19,0)	null,
	handling_client_id	numeric(19,0)	null,
	read_state	numeric(19,0)	null
,constraint dms_queue_entry_p primary key (queue_id,msg_id));

create index dms_queue_msg_idx on dms_queue_entry (msg_id);

create table dms_topic (
	topic_name	character varying(250)	null,
	topic_id	numeric(19,0)	not null,
	temp_id	numeric(19,0)	null
,constraint dms_topic_p primary key (topic_id));


create table dms_topic_sub (
	client_id	numeric(19,0)	null,
	subscriber_name	character varying(250)	null,
	subscriber_id	numeric(19,0)	not null,
	topic_id	numeric(19,0)	null,
	durable	numeric(1,0)	null,
	active	numeric(1,0)	null
,constraint dms_topic_sub_p primary key (subscriber_id));


create table dms_topic_entry (
	subscriber_id	numeric(19,0)	not null,
	msg_id	numeric(19,0)	not null,
	delivery_date	numeric(19,0)	null,
	read_state	numeric(19,0)	null
,constraint dms_topic_entry_p primary key (subscriber_id,msg_id));

create index dms_topic_msg_idx on dms_topic_entry (msg_id,subscriber_id);
create index dms_topic_read_idx on dms_topic_entry (read_state,delivery_date);

create table dms_msg (
	msg_class	character varying(250)	null,
	has_properties	numeric(1,0)	null,
	reference_count	numeric(10,0)	null,
	msg_id	numeric(19,0)	not null,
	timestamp	numeric(19,0)	null,
	correlation_id	character varying(250)	null,
	reply_to	numeric(19,0)	null,
	destination	numeric(19,0)	null,
	delivery_mode	numeric(1,0)	null,
	redelivered	numeric(1,0)	null,
	type	character varying(250)	null,
	expiration	numeric(19,0)	null,
	priority	numeric(1,0)	null,
	small_body	bytea	null,
	large_body	bytea	null
,constraint dms_msg_p primary key (msg_id));


create table dms_msg_properties (
	msg_id	numeric(19,0)	not null,
	data_type	numeric(1,0)	null,
	name	character varying(250)	not null,
	value	character varying(250)	null
,constraint dms_msg_properti_p primary key (msg_id,name));

create or replace function dms_queue_flag
(Pbatch_size    numeric
,Pread_lock     numeric
,Pdelivery_date numeric
,Pclient_id     numeric
,Pqueue_id      numeric) returns numeric
as '
    DECLARE
       i int;
    BEGIN
    UPDATE dms_queue_entry qe
    SET qe.handling_client_id = Pclient_id, 
        qe.read_state = Pread_lock 
    WHERE ROWNUM < Pbatch_size
      AND qe.handling_client_id < 0 
      AND qe.delivery_date < Pdelivery_date 
      AND qe.queue_id = Pqueue_id;
    GET DIAGNOSTICS i = ROW_COUNT;
    return i;
  END;
  ' language plpgsql;

create or replace function dms_topic_flag
(Pbatch_size    numeric
,Pread_lock     numeric
,Pdelivery_date numeric
,Psubscriber_id numeric) returns numeric
as'DECLARE
	i int;
   BEGIN
    UPDATE dms_topic_entry te 
    SET te.read_state = Pread_lock 
    WHERE ROWNUM < Pbatch_size
      AND te.delivery_date < Pdelivery_date 
      AND te.read_state = 0 
      AND te.subscriber_id = Psubscriber_id;
   GET DIAGNOSTICS i = ROW_COUNT;
    return i;
  END;
  ' language plpgsql;


