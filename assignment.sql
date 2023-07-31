-- ASSIGNMENT - E COMMERCE

create table "euser" (
"id" uuid not null default uuid_generate_v4(),
"name" character varying not null,
"phone" integer not null,
"email" character varying not null,
"password" character varying not null,
constraint "PK_USER" primary key ("id"));

create table "order" (
"id" uuid not null default uuid_generate_v4(),
"ordered_user_id" uuid not null,
"order_address_id" uuid not null,
"price" float not null,
constraint "PK_ORDER" primary key ("id"),
constraint "FK_ORDER_USER" foreign key ("ordered_user_id") references euser("id") on delete cascade,
constraint "FK_ORDER_ADDRESS" foreign key ("order_address_id") references address("id") on delete cascade);

create table address (
"id" uuid not null default uuid_generate_v4(),
"user_id" uuid not null,
"address" character varying not null,
constraint "PK_ADDRESS" primary key ("id"),
constraint "FK_ADDRESS" foreign key ("user_id") references euser("id") on delete cascade);

create table product (
"id" uuid not null default uuid_generate_v4(),
"name" character varying not null,
"description" character varying,
"price" float not null,
"sku" character varying not null,
"category_id" uuid,
constraint "PK_PRODUCT" primary key ("id"),
constraint "FK_PRODUCT" foreign key ("category_id") references product_category("id") on delete cascade);

create table product_category (
"id" uuid not null default uuid_generate_v4(),
"name" character varying not null,
constraint "PK_PRODUCT_CATEGORY" primary key ("id"));

create table order_product_mapping (
"id" uuid not null default uuid_generate_v4(),
"order_id" uuid not null,
"product_id" uuid not null,
"product_count" int not null,
constraint "PK_ORDER_PRODUCT_MAPPING" primary key ("id"),
constraint "FK_ORDER_PRODUCT_MAPPING_ORDER" foreign key ("order_id") references "order"("id") on delete cascade,
constraint "FK_ORDER_PRODUCT_MAPPING_PRODUCT" foreign key ("product_id") references product("id") on delete cascade);

INSERT INTO public.euser
("name", phone, email, "password")
values
('abc', 123000000, 'abc@gmail.com', 'abc'),
('def', 456000000, 'def@gmail.com', 'def'),
('ghi', 789000000, 'ghi@gmail.com', 'ghi')
;

INSERT INTO public.product_category
("name")
VALUES('Smartphone');

INSERT INTO public.product
("name", description, price, sku, category_id)
values
('Vivo', 'vivo', 123, 'X1', (select id from product_category where name = 'Smartphone')),
('Oppo', 'oppo', 456, 'X2', (select id from product_category where name = 'Smartphone')),
('Samsung', 'samsung', 789, 'X3',(select id from product_category where name = 'Smartphone')),
('OnePlus', 'oneplus', 1200, 'X4', (select id from product_category where name = 'Smartphone')),
('Apple', 'apple', 5000, 'X5', (select id from product_category where name = 'Smartphone'));

INSERT INTO public.address
(user_id, address)
values
((select id from euser where name = 'abc'), 'ABC'),
((select id from euser where name = 'def'), 'DEF'),
((select id from euser where name = 'ghi'), 'GHI');

INSERT INTO public."order"
(ordered_user_id, order_address_id, price)
values
((select id from euser where name = 'abc'), (select id from address where address = 'ABC'), 123),
((select id from euser where name = 'abc'), (select id from address where address = 'ABC'), 912),
((select id from euser where name = 'abc'), (select id from address where address = 'ABC'), 789),
((select id from euser where name = 'def'), (select id from address where address = 'DEF'), 1200),
((select id from euser where name = 'ghi'), (select id from address where address = 'GHI'), 5000);

INSERT INTO public.order_product_mapping
(order_id, product_id, product_count)
values
((select id from "order" where price = 123), (select id from product where name = 'Vivo'), 1),
((select id from "order" where price = 912), (select id from product where name = 'Oppo'), 2),
((select id from "order" where price = 789), (select id from product where name = 'Samsung'), 1),
((select id from "order" where price = 1200), (select id from product where name = 'OnePlus'), 1),
((select id from "order" where price = 5000), (select id from product where name = 'Apple'), 1);

-- create indexes

create index product_index on product("name");
create index product_category_index on product_category("name");


