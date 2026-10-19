DROP TABLE `user`;
DROP TABLE business;
DROP TABLE contact;
DROP TABLE business_contact;
DROP TABLE user_rewards_event_detail;
DROP TABLE reward_event_lookup;
DROP TABLE refer_user;
DROP TABLE user_rewards;
DROP TABLE user_group;
DROP TABLE user_in_group;

create table `user` (user_id int(10) not null auto_increment primary key, username VARCHAR(30) not null, password VARCHAR(30) not null, date_registered datetime not null, is_admin integer(1) not null, is_enabled integer(1) not null, date_last_login datetime not null, referrer_user_id int(10));
-- create table business (business_id int(10) not null auto_increment primary key, group_cat_id int(4) not null, cat_id int(10) not null, business_name VARCHAR(60) not null, business_url varchar(200), username VARCHAR(30) not null, password VARCHAR(30) not null, email_addr VARCHAR(80), phone_country_code varchar(4), phone_nbr varchar(30), country_code VARCHAR(2) not null, country_name varchar(60) NOT NULL, metro_area_pk int(6), address1 varchar(40), address2 varchar(40), address3 varchar(40), city varchar(40), state varchar(20), zip_code varchar(20), lat decimal(10,7), lon decimal(12,7), date_registered datetime not null, is_enabled integer(1) not null, date_last_login datetime not NULL);

create table business (business_id int(10) not null auto_increment primary key, group_cat_id int(4) not null, cat_id int(10) not null, business_name VARCHAR(60) not null, business_url varchar(200), is_HQ integer(1) not null, is_active integer(1) not null, username VARCHAR(30) not null, password VARCHAR(30) not null, email_addr VARCHAR(80), phone_country_code varchar(4), phone_nbr varchar(30), country_code VARCHAR(2) not null, country_name varchar(60) NOT NULL, address1 varchar(40), address2 varchar(40), address3 varchar(40), city varchar(40), state varchar(20), zip_code varchar(20), lat decimal(10,7), lon decimal(12,7), date_registered datetime not null, is_enabled integer(1) not null, date_last_login datetime not NULL);

-- ALTER TABLE business ADD COLUMN is_HQ integer(1) NOT NULL AFTER business_url;
-- ALTER TABLE business ADD COLUMN is_active integer(1) NOT NULL AFTER is_HQ;

create table contact (contact_id int(10) not null auto_increment primary key, user_id int(10) not null, first_name VARCHAR(60), last_name VARCHAR(60), email_addr VARCHAR(80), phone_country_code varchar(4), phone_nbr varchar(30), country_code VARCHAR(2) not null, country_name varchar(60) NOT NULL, metro_area_pk int(6), address1 varchar(40), address2 varchar(40), address3 varchar(40), city varchar(40), state varchar(30), zip_code varchar(30), lat decimal(10,7), lon decimal(12,7));
create table business_contact (business_contact_id int(10) not null auto_increment primary key, business_id int(10) not null, first_name VARCHAR(60), last_name VARCHAR(60), email_addr VARCHAR(80), phone_country_code varchar(4), phone_nbr varchar(30), country_code VARCHAR(2) not null, country_name varchar(60) NOT NULL, metro_area_pk int(6), address1 varchar(40), address2 varchar(40), address3 varchar(40), city varchar(40), state varchar(30), zip_code varchar(30));

create table refer_user (refer_user_id int(10) not null auto_increment primary key, user_id int(10) not null, name VARCHAR(60) NOT NULL, referred_email_addr varchar(80), referred_phone_country_code varchar(4), referred_phone_nbr varchar(50), date_referred datetime not null, has_referred_signed_up int(1), date_referred_signed_up datetime);

-- create table user_rewards_event_detail (user_reward_id int(10) NOT NULL, ad_id int(10), referred_user_id int(10), referred_user_login_id int(10), referred_email_addr varchar(80), referred_phone_nbr varchar(50));
create table user_rewards_event_detail (user_reward_id int(10) auto_increment primary key NOT NULL, referred_user_id int(10), referred_email_addr varchar(80), referred_phone_country_code varchar(4), referred_phone_nbr varchar(50));

create table reward_event_lookup (reward_event_pk int(3) not null auto_increment primary key, reward_event_id int(2) not null, reward_event_name varchar(40) not null, event_rewards int(7) not null);

insert into reward_event_lookup (reward_event_pk, reward_event_id, reward_event_name, event_rewards) values (101, 1, 'Register', 10000);
insert into reward_event_lookup (reward_event_pk, reward_event_id, reward_event_name, event_rewards) values (102, 2, 'Refer Register', 2000);

CREATE TABLE checkout_discount (checkout_discount_id int(10) not null auto_increment primary key, user_id int(10) not null, business_id int(10) not null, checkout_discount_str VARCHAR(60) NOT NULL, date_generated datetime not null, date_of_expiration datetime not null, is_enabled integer(1) not null);
CREATE TABLE checkout_discount_usage (checkout_discount_id int(10) not null, date_used datetime not null);

create table user_rewards (user_reward_id int(10) auto_increment primary key not null, user_id int(10) not null, referred_user_id int(10), reward_event_pk int(3) not null, total_rewards_points_this_event int(5) NOT null, date_rewards_event datetime not null);

-- Later:
-- create table user_contact (user_contact_id int(10) not null auto_increment primary key, user_id int(10) not null, contact_user_id int(10), contact_name VARCHAR(60) NOT NULL, contact_email_addr varchar(80), contact_phone_country_code varchar(4), contact_phone_nbr varchar(30), is_whatsapp_user int(1), date_contact_added datetime not null, is_contact_r2c_user int(1) NOT null, has_referred_signed_up int(1), date_referred_signed_up datetime);

create table user_contact (user_contact_id int(10) not null auto_increment primary key, user_id int(10) not null, contact_user_id int(10), contact_name VARCHAR(60) NOT NULL, contact_email_addr varchar(80), contact_phone_country_code varchar(4), contact_phone_nbr varchar(30), is_whatsapp_user int(1), date_contact_added datetime not null);

create table user_group (user_group_id int(10) not null auto_increment primary key, creator_user_id int(10) not null, date_created datetime not null, group_name varchar(100) NOT NULL);
create table user_in_group (user_in_group_id int(10) not null auto_increment primary key, user_group_id int(10) not null, user_contact_id int(10) not null, date_added datetime not null);

create table message (message_id int(10) not null auto_increment primary key, user_id int(10) not null, user_login_id int(10) not null, reply_to_message_id int(10), recipient_user_contact_str varchar(200), date_submitted datetime not null, message_text text not null);
create table message_recipient (message_id int(10) not null, user_contact_id int(10) not null, message_delivered int(1), date_delivered datetime, message_read int(1), date_read datetime);

-- create table user_login (user_login_id int(10) auto_increment primary key not null, user_id int(10) not null, login_date datetime not null, login_session_rewards int(10) not null, is_current int(1) not null);
-- ALTER TABLE `user` ADD user_type int(2) NOT NULL AFTER password;
-- ALTER TABLE `user` ADD is_admin int(1) NOT NULL AFTER password;
-- UPDATE `user` SET user_type = 1;
