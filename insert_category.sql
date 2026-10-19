DROP TABLE group_category;
DROP TABLE category;
DROP TABLE cat_attr;
DROP TABLE cat_attr_detail;
DROP TABLE group_cat_type_lookup;

create table group_category (group_cat_id int(4) not null auto_increment primary key, group_cat_name varchar(50) not null, group_cat_label varchar(100) not null, group_cat_desc varchar(200), group_cat_type_id int(2) NOT NULL, display_order int(3) not null, has_child int(1), group_page_header VARCHAR(200), group_page_desc text);

create table category (cat_id int(10) not null auto_increment primary key, group_cat_id int(6) NOT NULL, cat_name varchar(50) not null, cat_label varchar(100) not null, cat_desc varchar(200), display_order int(3) not null, has_child int(1), is_child int(1), page_header VARCHAR(200), page_desc text);

create table cat_attr (cat_attr_id int(10) not null auto_increment primary key, cat_id int(10) not null, cat_attr_name varchar(50) not null, cat_attr_label varchar(100) not null, cat_attr_desc varchar(200), display_order int(3) not NULL, is_title int(1), is_required int(1), has_child int(1), field_type_id int(1), field_width int(4), max_field_width int(4));

create table cat_attr_detail (cat_attr_detail_id int(10) not null auto_increment primary key, cat_attr_id int(10) not null, cat_attr_detail_name varchar(50) not null, cat_attr_detail_label varchar(100) not null, cat_attr_detail_desc varchar(200), display_order int(3) not NULL, is_required int(1), field_type_id int(1), field_width int(4), max_field_width int(4));

CREATE TABLE group_cat_type_lookup(group_cat_type_id int(2) NOT NULL primary key, group_cat_type_desc VARCHAR(50) NOT NULL);

-- INSERT INTO group_cat_type_lookup (group_cat_type_id, group_cat_type_desc) VALUES (1, 'INDIVIDUAL');
INSERT INTO group_cat_type_lookup (group_cat_type_id, group_cat_type_desc) VALUES (1, 'CREDIT CARD ISSUER');
INSERT INTO group_cat_type_lookup (group_cat_type_id, group_cat_type_desc) VALUES (2, 'SERVICE/BUSINESS');
INSERT INTO group_cat_type_lookup (group_cat_type_id, group_cat_type_desc) VALUES (3, 'INDIVIDUAL');
-- INSERT INTO group_cat_type_lookup (group_cat_type_id, group_cat_type_desc) VALUES (3, 'NEWS-RELATED');

insert into group_category (group_cat_id, group_cat_name, group_cat_label, group_cat_desc, group_cat_type_id, display_order) values (1100, 'CREDIT CARD ISSUER', 'CREDIT CARD ISSUER', 'Credit Card Issuer', 1, 1);

insert into group_category (group_cat_id, group_cat_name, group_cat_label, group_cat_desc, group_cat_type_id, display_order) values (2100, 'SERVICES', 'SERVICES', 'Services', 2, 1);
insert into group_category (group_cat_id, group_cat_name, group_cat_label, group_cat_desc, group_cat_type_id, display_order) values (2200, 'RESTAURANTS/PIZZA', 'RESTAURANTS/PIZZA', 'Restaurants/Pizza', 2, 2);
insert into group_category (group_cat_id, group_cat_name, group_cat_label, group_cat_desc, group_cat_type_id, display_order) values (2300, 'RETAILERS', 'RETAILERS', 'Retailers', 2, 3);

insert into group_category (group_cat_id, group_cat_name, group_cat_label, group_cat_desc, group_cat_type_id, display_order) values (3100, 'INDIVIDUAL/BUYER', 'INDIVIDUAL/BUYER', 'Individual/Buyer', 3, 1);

UPDATE group_category SET group_page_header='CREDIT CARD ISSUER', group_page_desc='This group category for Credit Card Issuing Banks and Credit Unions wanting to increase revenue from existing/new customer referrals managed by Rewards2Connect.com' WHERE group_cat_id=1100;

UPDATE group_category SET group_page_header='SERVICES', group_page_desc='This group category is for services such as Hair Salons, Nail Salons, Skin Care services (facials, eye-brow, laser hair removal), Weight Loss Services, Fertility treatment, Real Estate agents, and other similar services wanting to increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE group_cat_id=2100;
UPDATE group_category SET group_page_header='RESTAURANTS/PIZZA', group_page_desc='This group category is for food services including restaurants, pizza, fast food, catering service and home-made food for sale wanting to increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE group_cat_id=2200;
UPDATE group_category SET group_page_header='RETAILERS', group_page_desc='This group category is for all retailers such as groceries, clothing, shoes, cosmetics, jewelry, and department stores such as Walmart, Target, Kohls, etc. wanting to increase revenue from existing/new customer referrals managed by Rewards2Connect.com' WHERE group_cat_id=2300;

UPDATE group_category SET group_page_header='INDIVIDUAL/PURCHASING COMPANY', group_page_desc='This group category for individuals or purchasing companies wanting to reduce their credit card finance charges and/or total bill at retail/wholesale stores/restaurants/services thro referrals managed by Rewards2Connect.com' WHERE group_cat_id=3100;

insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (11001, 1100, 'BANKS', 'BANKS', 'Banks', 1);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (11002, 1100, 'CREDIT_UNIONS', 'CREDIT UNIONS', 'Credit Unions', 2);

insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (21001, 2100, 'HAIR_SALON_SERVICES', 'HAIR SALON SERVICES', 'Hair Salon Services', 1);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (21002, 2100, 'SKIN_CARE_SERVICES', 'SKIN CARE SERVICES', 'Skin Care Services', 2);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (21003, 2100, 'NAIL_SALON_SERVICES', 'NAIL SALON SERVICES', 'Nail Salon Services', 3);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (21004, 2100, 'WEIGHT_LOSS_SERVICES', 'WEIGHT LOSS SERVICES', 'Weight Loss Services', 4);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (21005, 2100, 'REAL_ESTATE_SERVICES', 'REAL ESTATE SERVICES', 'Real Estate Services', 5);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (21006, 2100, 'CAR_AUTO_SERVICES', 'CAR AUTO SERVICES', 'Car Auto Services', 6);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (21007, 2100, 'TIRE_SERVICES', 'TIRE SERVICES', 'Tire Services', 7);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (21008, 2100, 'LEGAL_SERVICES', 'LEGAL SERVICES', 'Legal Services', 8);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (21009, 2100, 'FERTILITY_TREATMENT', 'FERTILITY TREATMENT', 'Fertility Treatment', 9);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (21010, 2100, 'OTHER_SERVICES', 'OTHER SERVICES', 'Other Services', 10);

insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (22001, 2200, 'AMERICAN_RESTAURANTS', 'AMERICAN RESTAURANTS', 'American Restaurants', 1);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (22002, 2200, 'INDIAN_RESTAURANTS', 'INDIAN RESTAURANTS', 'Indian Restaurants', 2);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (22003, 2200, 'CHINESE_RESTAURANTS', 'CHINESE RESTAURANTS', 'Chinese Restaurants', 3);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (22004, 2200, 'OTHER_RESTAURANTS', 'OTHER RESTAURANTS', 'Other Restaurants', 4);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (22005, 2200, 'PIZZA_OUTLETS', 'PIZZA OUTLETS', 'Pizza Outlet', 5);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (22006, 2200, 'FAST_FOOD', 'FAST FOOD', 'Fast Food', 6);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (22007, 2200, 'CATERING_HOME_MADE_FOOD', 'CATERING/HOME-MADE FOOD', 'Catering/Home-made Food', 7);

insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (23001, 2300, 'AMERICAN_GROCERY', 'AMERICAN GROCERY', 'American Grocery', 1);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (23002, 2300, 'INDIAN_GROCERY', 'INDIAN GROCERY', 'Indian Grocery', 2);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (23003, 2300, 'CHINESE_GROCERY', 'CHINESE GROCERY', 'Chinese Grocery', 3);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (23004, 2300, 'OTHER_GROCERY', 'OTHER GROCERY', 'Other Grocery', 4);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (23005, 2300, 'CLOTHING', 'CLOTHING STORE', 'Clothing Store', 5);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (23006, 2300, 'SHOES', 'SHOE STORE', 'Shoe Store', 6);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (23007, 2300, 'COSMETICS/MAKE-UP', 'COSMETICS/MAKE-UP STORE', 'Cosmetics/Make-up Store', 7);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (23008, 2300, 'JEWELRY', 'JEWELRY STORE', 'Jewelry Store', 8);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (23009, 2300, 'DEPT_STORE', 'DEPT STORE', 'Dept Store', 9);

insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (31001, 3100, 'INDIVIDUAL', 'INDIVIDUAL', 'Individual', 1);
insert into category (cat_id, group_cat_id, cat_name, cat_label, cat_desc, display_order) values (31002, 3100, 'PURCHASING COMPANY', 'PURCHASING COMPANY', 'Purchasing Company', 2);

UPDATE category SET page_header='BANKS', page_desc='This category is for credit card issuing banks to post info about the credit card(s) they offer.' WHERE cat_id=11001;
UPDATE category SET page_header='CREDIT UNIONS', page_desc='This category is for credit card issuing Credit Unions to post info about the credit card(s) they offer.' WHERE cat_id=11002;
                                                                                                                                                           
UPDATE category SET page_header='HAIR SALONS', page_desc='This category is for Hair Salon services (such as hair-cuts, etc.) to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=21001;
UPDATE category SET page_header='SKIN CARE SERVICES', page_desc='This category is for Skin Care services (such as facials, eye-brow, micro-blading, hair removal, etc.) to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=21002;
UPDATE category SET page_header='NAIL SALONS', page_desc='This category is for Nail Salon services to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=21003;
UPDATE category SET page_header='WEIGHT LOSS SERVICES', page_desc='This category is for Weight Loss services to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=21004;
UPDATE category SET page_header='REAL ESTATE SERVICES', page_desc='This category is for Real Estate services to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=21005;
UPDATE category SET page_header='CAR/AUTO SERVICES', page_desc='This category is for Car/Auto services to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=21006;
UPDATE category SET page_header='TIRE SERVICES', page_desc='This category is for Tire services to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=21007;
UPDATE category SET page_header='LEGAL SERVICES', page_desc='This category is for Legal services to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=21008;
UPDATE category SET page_header='FERTILITY TREATMENT', page_desc='This category is for Fertility Treatment services to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=21009;
UPDATE category SET page_header='OTHER SERVICES', page_desc='This category is for other in-person services to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=21010;

UPDATE category SET page_header='RESTAURANTS (AMERICAN)', page_desc='This category is for American restaurant(s) to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=22001;
UPDATE category SET page_header='RESTAURANTS (INDIAN)', page_desc='This category is for Indian restaurant(s) to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=22002;
UPDATE category SET page_header='RESTAURANTS (CHINESE)', page_desc='This category is for Chinese restaurant(s) to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=22003;
UPDATE category SET page_header='RESTAURANTS (OTHER)', page_desc='This category is for Other restaurant(s) to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=22004;
UPDATE category SET page_header='PIZZA', page_desc='This category is for Pizza outlets to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com' WHERE cat_id=22005;
UPDATE category SET page_header='FAST FOOD', page_desc='This category is for Fast Food outlets (such as McDonalds, Panera Bread, Wendys, etc.) to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=22006;
UPDATE category SET page_header='CATERING/HOME-MADE FOOD', page_desc='This category is for catering/home-made food services to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=22007;

UPDATE category SET page_header='AMERICAN GROCERY', page_desc='This category is for American groceries to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=23001;
UPDATE category SET page_header='INDIAN GROCERY', page_desc='This category is for Indian grocery stores to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=23002;
UPDATE category SET page_header='CHINESE GROCERY', page_desc='This category is for Chinese grocery stores to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=23003;
UPDATE category SET page_header='OTHER GROCERY', page_desc='This category is for other grocery stores to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=23004;
UPDATE category SET page_header='CLOTHING STORE', page_desc='This category is for Clothing stores to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=23005;
UPDATE category SET page_header='SHOE STORE', page_desc='This category is for Shoe stores to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=23006;
UPDATE category SET page_header='COSMETICS/MAKE-UP STORE', page_desc='This category is for Cosmetics/Make-up stores to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=23007;
UPDATE category SET page_header='JEWELRY STORE', page_desc='This category is for Jewelry stores to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=23008;
UPDATE category SET page_header='DEPT STORE', page_desc='This category is for Dept stores to showcase their profile and increase revenue from existing/new customer referrals managed by Rewards2Connect.com.' WHERE cat_id=23009;

UPDATE category SET page_header='INDIVIDUAL', page_desc='This category is for individuals wanting to reduce their credit card finance charges and/or total bill at retail stores/restaurants/services thro referrals managed by Rewards2Connect.com.' WHERE cat_id=31001;
UPDATE category SET page_header='PURCHASING COMPANY', page_desc='This category is for purchasing companies wanting to reduce their credit card finance charges and/or total bill at retail/wholesale stores/restaurants/services thro referrals managed by Rewards2Connect.com.' WHERE cat_id=31002;

insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (29991, 2999, 'AD_TITLE', 'AD TITLE', 'Ad Title', 1, 1, 1, 0, 1, 30, 100);
insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (29992, 2999, 'SERVICE_NAME', 'SERVICE NAME', 'Legal Name of Service or Business', 2, 0, 1, 0, 1, 15, 50);
insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (29993, 2999, 'ADDR_LINE_1', 'ADDR LINE 1', 'Address Line 1', 3, 0, 1, 0, 1, 15, 50);
insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (29994, 2999, 'ADDR_LINE_2', 'ADDR LINE 2', 'Address Line 2', 4, 0, 1, 0, 1, 15, 50);
insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (29995, 2999, 'ADDR_LINE_3', 'ADDR LINE 3', 'Address Line 3', 5, 0, 1, 0, 1, 15, 50);
insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (29996, 2999, 'LOC_CITY', 'LOC CITY', 'Service Location City', 6, 0, 1, 0, 1, 15, 50);
insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (29997, 2999, 'LOC_STATE', 'LOC STATE', 'Service Location State', 7, 0, 1, 0, 1, 3, 50);
insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (29998, 2999, 'LOC_COUNTRY', 'LOC COUNTRY', 'Service Location Country', 8, 0, 1, 0, 1, 5, 50);
insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (29999, 2999, 'PHONE_NBR', 'PHONE NBR', 'Phone No.', 9, 0, 1, 0, 1, 15, 30);
insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (299910, 2999, 'SERVICE_DESCR', 'SERVICE DESCR', 'Service Descr', 10, 0, 1, 0, 2, 50, 600);
insert into cat_attr (cat_attr_id, cat_id, cat_attr_name, cat_attr_label, cat_attr_desc, display_order, is_title, is_required, has_child, field_type_id, field_width, max_field_width) values (299911, 2999, 'URL', 'URL', 'URL', 11, 0, 0, 0, 1, 30, 100);
