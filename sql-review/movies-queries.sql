-- year, id --> Movies

-- funciones de agregación 
-- count
-- avg
-- max
-- min
-- sum

create view v_movies_count_by_year
as
select year, count(id) as movies_count
from Movies
group by year;
go;

select max(movies_count) from v_movies_count_by_year

go;
-- 3

select year 
from v_movies_count_by_year
where movies_count = (select max(movies_count) from v_movies_count_by_year)
go;

-- Crear una función que indique el año en que menos películas se estrenaron

create function f_year_with_min_movies_count() returns table
return
select year 
from v_movies_count_by_year
where movies_count = (select min(movies_count) from v_movies_count_by_year)
go;

select * from dbo.f_year_with_min_movies_count()
go;

-- Crear un consulta que permita mostrar el nombre de la películas con mayor cantidad de ratings.

-- title, id -> movies m 
-- movie_id - > ratings r

create view ratings_count_by_movie
as
select title, count(*) ratings_count
	from movies m
	join ratings r on m.id = r.movie_id
group by title
go;

create procedure usp_movies_with_max_ratings
as
begin
	select title from ratings_count_by_movie
	where ratings_count = (select max(ratings_count) from ratings_count_by_movie)
end;
go;

exec usp_movies_with_max_ratings
go;

-- Indicar los nombres de las películas que no tienen reseñas (ratings).

select title from movies
where id not in (select movie_id from ratings)
go;

select title from movies m
	left join ratings r on m.id = r.movie_id
where r.movie_id is null
go;

select * from actors
go;

-- Crear un procedimiento almacenado que permita insertar un actor
create procedure usp_insert_actor
@id int,
@name varchar(100),
@gender char(1)
as
begin
	insert into actors (id, name, gender)
	values (@id, @name, @gender)
end;

exec usp_insert_actor 2, 'Bill Murray' , 'M'

select * from actors
go;

