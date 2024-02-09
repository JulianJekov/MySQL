create table countries
(
    id        int primary key auto_increment,
    name      varchar(30) not null unique,
    continent varchar(30) not null,
    currency  varchar(5)  not null
);

create table genres
(
    id   int primary key auto_increment,
    name varchar(50) not null unique
);

create table actors
(
    id         int primary key auto_increment,
    first_name varchar(50) not null,
    last_name  varchar(50) not null,
    birthdate  date        not null,
    height     int,
    awards     int,
    country_id int         not null,

    constraint fk_actors_countries
        foreign key (country_id)
            references countries (id)
);

create table movies_additional_info
(
    id            int primary key auto_increment,
    rating        decimal(10, 2) not null,
    runtime       int            not null,
    picture_url   varchar(80)    not null,
    budget        decimal(10, 2),
    release_date  date           not null,
    has_subtitles tinyint(1),
    description   text
);

create table movies
(
    id            int primary key auto_increment,
    title         varchar(70) not null unique,
    country_id    int         not null,
    movie_info_id int         not null unique,

    constraint fk_movies_countries
        foreign key (country_id)
            references countries (id),

    constraint fk_movies_movies_info
        foreign key (movie_info_id)
            references movies_additional_info (id)
);

create table movies_actors
(
    movie_id int not null,
    actor_id int not null,

    constraint fk_movies_actors_movies
        foreign key (movie_id)
            references movies (id),

    constraint fk_movies_actors_actors
        foreign key (actor_id)
            references actors (id)
);

create table genres_movies
(
    genre_id int not null,
    movie_id int not null,

    constraint genres_movies_genres
        foreign key (genre_id)
            references genres (id),

    constraint genres_movies_movies
        foreign key (movie_id)
            references movies (id)
);

insert into actors (first_name, last_name, birthdate, height, awards, country_id)
select reverse(a.first_name),
       reverse(a.last_name),
       date_sub(a.birthdate, interval 2 day),
       a.height + 10,
       a.country_id,
       (select c.id from countries c where c.name = 'Armenia')
from actors a
where a.id <= 10;

update movies_additional_info mai
set mai.runtime = mai.runtime - 10
where mai.id >= 15
  and mai.id <= 25;

delete c
from countries c
         left join movies m on c.id = m.country_id
where m.id is null;

select id, name, continent, currency
from countries c
order by currency desc, id;

select mai.id, m.title, mai.runtime, mai.budget, mai.release_date
from movies_additional_info mai
         join movies m on mai.id = m.movie_info_id
where year(mai.release_date) between 1996 and 1999
order by mai.runtime, mai.id
limit 20;


select concat(a.first_name, ' ', a.last_name)                         as full_name,
       concat(reverse(a.last_name), length(a.last_name), '@cast.com') as email,
       2022 - year(a.birthdate)                                       as age,
       a.height
from actors a
         left join movies_actors ma on a.id = ma.actor_id
where ma.actor_id is null
order by a.height;

select c.name, count(m.country_id) movies_count
from movies m
         join countries c on c.id = m.country_id
group by c.name
having movies_count >= 7
order by c.name desc;

select m.title,
       case
           when mai.rating <= 4 then 'poor'
           when mai.rating <= 7 then 'good'
           else 'excellent'
           end
           as 'rating',
       IF(mai.has_subtitles = 1, 'english', '-')
           as 'subtitles',
       mai.budget
from movies m
         join movies_additional_info mai on mai.id = m.movie_info_id
order by mai.budget desc;

create function udf_actor_history_movies_count(full_name VARCHAR(50))
    returns int
    deterministic
begin
    declare actorId int;
    set actorId = (select a.id from actors a where concat(a.first_name, ' ', a.last_name) = full_name);

    return (select count(ma.movie_id)
            from actors a
                     join movies_actors ma on a.id = ma.actor_id
                     join genres_movies gm on ma.movie_id = gm.movie_id
                     join genres g on g.id = gm.genre_id
            where g.name = 'History'
              and a.id = actorId);
end;

create procedure udp_award_movie(movie_title varchar(50))
begin
    update actors a
        join movies_actors ma on a.id = ma.actor_id
    set a.awards = a.awards + 1
    where ma.movie_id = (select m.id from movies m where m.title = movie_title);
end;

CALL udp_award_movie('Tea For Two');