create table continents
(
    id   int primary key auto_increment,
    name varchar(40) not null unique

);

create table countries
(
    id           int primary key auto_increment,
    name         varchar(40) not null unique,
    country_code varchar(10) not null unique,
    continent_id int         not null,

    constraint fk_countries_continents
        foreign key (continent_id)
            references continents (id)
);

create table preserves
(
    id             int primary key auto_increment,
    name           varchar(255) not null unique,
    latitude       decimal(9, 6),
    longitude      decimal(9, 6),
    area           int,
    type           varchar(20),
    established_on date
);

create table positions
(
    id           int primary key auto_increment,
    name         varchar(40) not null unique,
    description  text,
    is_dangerous tinyint(1)  not null
);

create table workers
(
    id              int primary key auto_increment,
    first_name      varchar(40) not null,
    last_name       varchar(40) not null,
    age             int,
    personal_number varchar(20) not null unique,
    salary          decimal(19, 2),
    is_armed        tinyint(1)  not null,
    start_date      date,
    preserve_id     int         not null,
    position_id     int         not null,

    constraint fk_workers_preserves
        foreign key (preserve_id)
            references preserves (id),

    constraint fk_workers_positions
        foreign key (position_id)
            references positions (id)
);

create table countries_preserves
(
    country_id  int not null,
    preserve_id int not null,

    constraint fk_countries_preserves_countries
        foreign key (country_id)
            references countries (id),

    constraint fk_countries_preserves_preserves
        foreign key (preserve_id)
            references preserves (id)
);

insert into preserves (name, latitude, longitude, area, type, established_on)
select concat(p.name, ' ', 'is in South Hemisphere'),
       p.latitude,
       p.longitude,
       p.area * p.id,
       lower(p.type),
       p.established_on
from preserves p
where p.latitude < 0;

update workers w
set w.salary = w.salary + 500
where w.position_id in (5, 8, 11, 13);

delete p
from preserves p
where p.established_on is null;

select concat(w.first_name, ' ', w.last_name)        full_name,
       to_days('2024-01-01') - to_days(w.start_date) days_of_experience
from workers w
where to_days('2024-01-01') - to_days(w.start_date) > 5
order by days_of_experience desc
limit 10;

select w.id, w.first_name, w.last_name, p.name, c.country_code
from workers w
         join preserves p on p.id = w.preserve_id
         join countries_preserves cp on p.id = cp.preserve_id
         join countries c on c.id = cp.country_id
where w.salary > 5000
  and w.age < 50
order by c.country_code;

select p.name, count(w.is_armed) armed_workers
from preserves p
         join workers w on p.id = w.preserve_id
where w.is_armed = 1
group by p.name
order by armed_workers desc, p.name;

select p.name, c.country_code, year(p.established_on) founded_id
from preserves p
         join countries_preserves cp on p.id = cp.preserve_id
         join countries c on c.id = cp.country_id
where established_on is not null
  and month(p.established_on) = 05
order by p.established_on
limit 5;

select p.id,
       p.name,
       case
           when p.area <= 100 then 'very small'
           when p.area <= 1000 then 'small'
           when p.area <= 10000 then 'medium'
           when p.area <= 50000 then 'large'
           else 'very large'
           end
           category
from preserves p
order by p.area desc;

create function udf_average_salary_by_position_name(name VARCHAR(40))
    returns decimal(19, 2)
    deterministic
begin

    declare positionId int;
    set positionId = (select p.id
                      from positions p
                      where p.name = name);

    return (select avg(w.salary)
            from workers w
                     join positions p on p.id = w.position_id
            where w.position_id = positionId);
end;

SELECT p.name, udf_average_salary_by_position_name('Forester') as position_average_salary
FROM positions p
WHERE p.name = 'Forester';


create procedure udp_increase_salaries_by_country(country_name varchar(40))
begin
    declare countryId int;
    set countryId = (select c.id
                     from countries c
                     where c.name = country_name);
    update workers w
        join preserves p on p.id = w.preserve_id
        join countries_preserves cp on p.id = cp.preserve_id
    set w.salary = w.salary * 1.05
    where cp.country_id = countryId;
end;