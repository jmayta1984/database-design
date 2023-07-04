-- Crear una función que indique el año en que menos películas se estrenaron

create view v_movies_count_by_year
as
select year, count(id) as movies_count
from Movies
group by year;
go;

select max(movies_count) from v_movies_count_by_year

go;
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

-- Crear un procedimiento almacenado o función que retorne el nombre de los actores que no participaron en un determinado 
-- género de película. 
use MovieDB 
-- name, id --> actors 
-- actor_id, movie_id --> movie_cast 
-- id, genre_id     --> movies 
-- description, id --> genres 
 
create function f_actors_not_in_genre( 
    @description varchar(50) 
) returns table 
return 
    select name 
    from actors 
    where name not in 
    (select name 
    from actors as a 
        join movie_cast as mc on a.id = mc.actor_id 
        join movies as m on mc.movie_id = m.id 
        join genres as g on m.genre_id = g.id 
    where description = @description) 
go; 
 
select * from dbo.f_actors_not_in_genre ('drama') 
go; 
 
-- Crear un procedimiento almacenado o función que retorne la cantidad de actores que participaron en 
-- películas de un determinado género (ingresado como parámetro) para un determinado año (ingresado como parámetro). 
create view v_actor_quantity_by_category_by_year 
as 
select description, year, count(distinct  actor_id) as quantity 
    from movie_cast as mc 
    join movies as m on mc.movie_id = m.id 
    join genres as g on m.genre_id = g.id 
group by description, year 
go; 
 
create function f_actor_quantity_by_category_by_year( 
    @description varchar(50), 
    @year int 
) returns int 
as 
begin 
    declare @quantity int 
    set @quantity = (select quantity 
    from v_actor_quantity_by_category_by_year 
    where description = @description and year = @year) 
    return @quantity 
end 
go; 
 
-- Crear un procedimiento almacenado o función que retorne el nombre del actor (o actores) que participó más veces 
-- en películas de un determinado género (ingresado como parámetro) para un determinado año (ingresado como parámetro). 
create view v_actors_quantity_by_year_by_category 
as 
select name, year, description, count(m.id) as quantity 
from actors as a 
    join movie_cast as mc on a.id = mc.actor_id 
    join movies as m on mc.movie_id = m.id 
    join genres as g on m.genre_id = g.id 
group by name, year, description 
go 
 
 
create function f_actor_max_movies_by_year_by_category( 
    @year int, 
    @description varchar(50) 
) returns table 
return 
select name 
from v_actors_quantity_by_year_by_category 
where year = @year and description = @description 
    and quantity = (select max(quantity) 
                    from v_actors_quantity_by_year_by_category 
                    where year = @year and description = @description) 
go; 
 
-- Crear un procedimiento almacenado o función que retorne la película con el mayor promedio de calificación. 
create view v_movies_score 
as 
select title, avg(stars) as quantity 
from movies as m 
    join ratings as r on m.id = r.movie_id 
group by title 
go; 
 
create procedure usp_movies_max_score 
as 
begin 
    select title from 
    v_movies_score 
        where quantity = (select max(quantity) from v_movies_score) 
end; 
 
exec usp_movies_max_score 
 
-- Crear un procedimiento almacenado que imprima en pantalla las películas en que participó un actor dado un determinado 
-- género (ingresado como parámetro). 
 
create procedure usp_print_actors_by_genre 
    @description varchar(50) 
as 
begin 
    declare @actor_name varchar(100) 
    declare @movie_title varchar(50)     
   -- declarar el cursor 
    declare cursor_actors cursor for 
    select name, title 
    from actors a 
        join movie_cast mc on a.id = mc.actor_id 
        join movies m on mc.movie_id = m.id 
        join genres g on m.genre_id = g.id 
    where description = @description 
     
   -- abrir el cursor 
    open cursor_actors 
     
   -- saltar a la primera fila 
    fetch cursor_actors into @actor_name, @movie_title 
     
   WHILE (@@FETCH_STATUS = 0) 
    BEGIN 
        PRINT(@actor_name) 
        fetch cursor_actors into @actor_name, @movie_title 
    END 
     
   -- cerrar el cursor 
    close cursor_actors 
     
   -- liberar el cursor 
    deallocate cursor_actors 
end 

