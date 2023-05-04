-- DDL: Definición de estructuras de objetos de base de datos
-- create: crear tablas/base de datos
-- alter: modificar tablas/base de datos
-- drop: eliminar tablas/base de datos

-- DML: Manipulación de datos
-- select: recupear filas
-- insert: insertar filas (agregar nuevos registros)
-- update: modificar filas (modificar los valores de las columnas)
-- delete: eliminar filas

-- Modificar la tabla artistas, agregando un campo que permita almacenar
-- el país de nacimiento del artista

use audioslave

alter table artistas
add pais varchar(100)

insert into artistas (codigo, nombre)
values (1, 'Madonna')

insert into artistas (codigo, nombre)
values	(2, 'Britney Spears'),
		(3, 'Bono')

insert into artistas (codigo, nombre, pais)
values (4, 'Bon Jovi', 'USA')


update artistas
set pais = 'USA'
where pais is null

delete from artistas
where codigo = 4

update artistas
set pais = 'Canada', nombre = 'Madona'
where codigo = 1

select * from artistas

insert into conciertos
values (1, 'Festival de Rock', '05-10-2023', 'Detroit')

insert into conciertos
values (2, 'Festival de Pop', '05/15/2023', 'Chicago')

insert into conciertos
values (3, 'Festival Latin Pop', '04/13/2023', 'New York')

select * from conciertos


-- Indicar los nombres de los conciertos del mes de mayo del año 2023
select nombre from conciertos where fecha >='2023-05-01' and fecha<= '2023-05-31'

select nombre from conciertos where fecha between '2023-05-01' and '2023-05-31'

select nombre from conciertos where year(fecha)=2023 and month(fecha) = 5

insert into artistas_por_concierto (codigo_artista, codigo_concierto)
values (1,1),
		(1,2),
		(2,1),
		(2,3),
		(3,1)


select * from artistas
select * from conciertos

select * from artistas_por_concierto

delete from artistas_por_concierto where codigo_artista = 3
delete from artistas where codigo = 3
