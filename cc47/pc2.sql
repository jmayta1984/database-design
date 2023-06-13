
-- Crear un procedimiento almacenado o funcion que indique los actores que no han participado
-- en un determinado género de película.

-- name, id --> actors as a
-- actor_id, movie_id --> movie_cast as mc
-- genre_id, id --> movies as m
-- description, id --> genres as g

create function f_actors_by_genre(
	@genero varchar(50)
) returns table
return 
select name from actors
where name not in 
	(select name
	from actors as a
		join movie_cast as mc on a.id = mc.actor_id
		join movies as m on mc.movie_id = m.id
		join genres as g on m.genre_id = g.id
	where description = @genero)
go;

select * from dbo.f_actors_by_genre('drama')
go;

-- Crear un procedimiento almacenado o función que retorne la cantidad de actores
-- que participaron en películas de un determinado género (ingresado como parámetro)
-- para un determinado año (ingresado como parámetro).

create view v_actors_quantity_by_genre_by_year
as
select year, description, COUNT(distinct actor_id) as quantity
from movie_cast as mc
	join movies as m on mc.movie_id = m.id
	join genres as g on m.genre_id = g.id
group by year, description
go;

create function f_actors_quantity_by_genre_by_year
( @year int,
	@description varchar(50)
) returns int
as
begin
	declare @quantity int
	set @quantity = (select quantity
	from v_actors_quantity_by_genre_by_year
	where year = @year and description = @description)
	return @quantity
end
go;

-- Crear un procedimiento almacenado o función que retorne el nombre del actor (o actores)
-- que participó más veces en películas de un determinado género (ingresado como parámetro)
-- para un determinado año (ingresado como parámetro).


-- Crear un procedimiento almacenado que permita imprimir la cantidad de películas por
-- género para un determinado año (ingresado como parámetro).


declare @year int
declare @desc varchar(50)
declare @q int
-- declarar el cursor
declare cursor_movies cursor for
select YEAR, description, COUNT(m.id) as quantity
from movies as m 
	join genres as g on m.genre_id = g.id
group by year, description

-- abrir
open cursor_movies

-- saltar al siguiente registor
fetch cursor_movies into @year, @desc, @q

while (@@fetch_status = 0)
begin
	print (@q)
	fetch cursor_movies into @year, @desc, @q
end 

-- cerrar
close cursor_movies

-- liberar
deallocate cursor_movies




-- Crear un procedimiento almacenado o función que retorne la pelicula con la mayor 
-- calificacion promedio.

create view v_average_by_movie
as
select title, AVG(stars) as average
from movies as m
	join ratings as r on m.id = r.movie_id
group by title
go;


create procedure usp_movie_with_max_rating
as
begin
	select title
	from v_average_by_movie
	where average = (select MAX(average)
	from v_average_by_movie)
end
go

exec usp_movie_with_max_rating
