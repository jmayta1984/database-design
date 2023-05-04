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

