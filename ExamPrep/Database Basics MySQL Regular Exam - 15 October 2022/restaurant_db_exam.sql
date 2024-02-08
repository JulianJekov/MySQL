create table products
(
    id    int primary key auto_increment,
    name  varchar(30) unique not null,
    type  varchar(30)        not null,
    price decimal(10, 2)     not null
);

create table clients
(
    id         int primary key auto_increment,
    first_name varchar(50) not null,
    last_name  varchar(50) not null,
    birthdate  date        not null,
    card       varchar(50),
    review     text
);

create table tables
(
    id       int primary key auto_increment,
    floor    int not null,
    reserved tinyint(1),
    capacity int not null
);

create table waiters
(
    id         int primary key auto_increment,
    first_name varchar(50) not null,
    last_name  varchar(50) not null,
    email      varchar(50) not null,
    phone      varchar(50),
    salary     decimal(10, 2)
);

create table orders
(
    id           int primary key auto_increment,
    table_id     int  not null,
    waiter_id    int  not null,
    order_time   time not null,
    payed_status tinyint(1),

    constraint fk_orders_table
        foreign key (table_id)
            references tables (id),

    constraint fk_orders_waiters
        foreign key (waiter_id)
            references waiters (id)
);

create table orders_clients
(
    order_id  int not null,
    client_id int not null,

    constraint fk_orders_clients_orders
        foreign key (order_id)
            references orders (id),

    constraint fk_orders_clients_clients
        foreign key (client_id)
            references clients (id)
);

create table orders_products
(
    order_id   int not null,
    product_id int not null,

    constraint fk_orders_products_orders
        foreign key (order_id)
            references orders (id),

    constraint fk_orders_products_products
        foreign key (product_id)
            references products (id)
);

insert into products (name, type, price)
select concat(w.last_name, ' ', 'specialty'),
       'Cocktail',
       round(ceil(w.salary * 0.01))
from waiters w
where w.id > 6;

update orders
set table_id = table_id - 1
where orders.id between 12 and 23;

delete w
from waiters w
         left join orders o on w.id = o.waiter_id
where o.waiter_id is null;

select *
from clients c
order by c.birthdate desc, c.id desc;

select c.first_name, c.last_name, c.birthdate, c.review
from clients c
where year(c.birthdate) between 1978 and 1993
  and c.card is null
order by c.last_name desc, c.id
limit 5;

select concat(w.last_name, w.first_name, length(w.first_name), 'Restaurant') as username,
       reverse(substring(w.email, 2, 12))                                    as password
from waiters w
where w.salary is not null
order by password desc;

select p.id, p.name, count(p.id) as count
from products p
         join orders_products op on p.id = op.product_id
group by p.name
having count >= 5
order by count desc, name;

select t.id,
       t.capacity,
       count(oc.client_id) count_clients,
       case
           when t.capacity > count(oc.client_id) then 'Free seats'
           when t.capacity = count(oc.client_id) then 'Full'
           else 'Extra seats'
           end
                           availability
from tables t
         join orders o on t.id = o.table_id
         join orders_clients oc on o.id = oc.order_id
where t.floor = 1
group by t.id
order by t.id desc;

create function udf_client_bill(full_name varchar(50))
    returns decimal(19, 2)
    deterministic
begin
    #     declare firstSpace int;
#     declare firstName varchar(50);
#     declare lastName varchar(50);
#     declare clientId int;
#     set firstSpace = locate(' ', full_name);
#     set firstName = substring(full_name, 1, firstSpace - 1);
#     set lastName = substring(full_name, firstSpace + 1);
#
#     set clientId = (select c.id
#                     from clients c
#                     where c.first_name = firstName
#                       and c.last_name = lastName);
    declare clientId int;
    set clientId = (select c.id
                    from clients c
                    where concat(c.first_name, ' ', c.last_name) = full_name);

    return (select sum(p.price)
            from orders_clients oc
                     join orders o on o.id = oc.order_id
                     join orders_products op on o.id = op.order_id
                     join products p on op.product_id = p.id
            where client_id = clientId);
end;

SELECT c.first_name, c.last_name, udf_client_bill('Silvio Blyth') as 'bill'
FROM clients c
WHERE c.first_name = 'Silvio'
  AND c.last_name = 'Blyth';

create procedure udp_happy_hour(productType varchar(50))
begin
    update products p
    set p.price = p.price * 0.8
    where p.price >= 10
      and p.type = productType;
end;
call udp_happy_hour('Cognac');