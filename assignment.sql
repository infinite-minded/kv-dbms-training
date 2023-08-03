-- ASSIGNMENT - E COMMERCE

create table "user" (
"id" uuid not null default uuid_generate_v4(),
"name" character varying not null,
"phone" integer not null,
"email" character varying not null,
"password" character varying not null,
constraint "PK_USER" primary key ("id"));

create table "order" (
"id" uuid not null default uuid_generate_v4(),
"user_id" uuid not null,
"shipment_address_id" uuid not null,
constraint "PK_ORDER" primary key ("id"),
constraint "FK_ORDER_USER" foreign key ("user_id") references "user"("id") on delete cascade,
constraint "FK_ORDER_ADDRESS" foreign key ("shipment_address_id") references address("id") on delete cascade);

create table address (
"id" uuid not null default uuid_generate_v4(),
"user_id" uuid not null,
"address" character varying not null,
constraint "PK_ADDRESS" primary key ("id"),
constraint "FK_ADDRESS" foreign key ("user_id") references "user"("id") on delete cascade);

create table product (
"id" uuid not null default uuid_generate_v4(),
"name" character varying not null unique,
"description" character varying,
"price" float not null,
"sku" character varying not null,
"category_id" uuid,
constraint "PK_PRODUCT" primary key ("id"),
constraint "FK_PRODUCT" foreign key ("category_id") references product_category("id") on delete cascade);

create table product_category (
"id" uuid not null default uuid_generate_v4(),
"name" character varying not null unique,
constraint "PK_PRODUCT_CATEGORY" primary key ("id"));

create table order_product(
"id" uuid not null default uuid_generate_v4(),
"order_id" uuid not null,
"product_id" uuid not null,
"product_count" int not null,
"price" float not null,
constraint "PK_ORDER_PRODUCT_MAPPING" primary key ("id"),
constraint "FK_ORDER_PRODUCT_MAPPING_ORDER" foreign key ("order_id") references "order"("id") on delete cascade,
constraint "FK_ORDER_PRODUCT_MAPPING_PRODUCT" foreign key ("product_id") references product("id") on delete cascade);

INSERT INTO public.user
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
((select id from "user" where name = 'abc'), 'ABC'),
((select id from "user" where name = 'def'), 'DEF'),
((select id from "user" where name = 'ghi'), 'GHI');

INSERT INTO public."order"
(user_id, shipment_address_id)
values
((select id from "user" where name = 'abc'), (select id from address where address = 'ABC')),
((select id from "user" where name = 'abc'), (select id from address where address = 'ABC')),
((select id from "user" where name = 'abc'), (select id from address where address = 'ABC')),
((select id from "user" where name = 'def'), (select id from address where address = 'DEF')),
((select id from "user" where name = 'ghi'), (select id from address where address = 'GHI'));

INSERT INTO public.order_product
(order_id, product_id, product_count, price)
values
('4344b23c-0382-4b07-bdd8-9375e482790d', (select id from product where name = 'Vivo'), 1, 123),
('e5e12290-caf6-41b4-9bd8-6eedf8e747f9', (select id from product where name = 'Oppo'), 2, 912),
('26e1a73a-dc0a-43c8-b3fb-562aea51316e', (select id from product where name = 'Samsung'), 1, 789),
('a1804996-2f9c-47d2-9746-3c3f4da82370', (select id from product where name = 'OnePlus'), 1, 1200),
('7adf6841-390c-4adc-b20e-6841aeb2c239', (select id from product where name = 'Apple'), 1, 5000);

-- create indexes

create index product_index on product("name");
create index product_category_index on product_category("name");
create index order_product_index on order_product("order_id", "product_id");


