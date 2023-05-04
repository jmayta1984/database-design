-- DDL: Definición de estructuras de objetos de base de datos
-- create
-- alter
-- drop

-- DML: Manipulación de datos
-- select
-- insert
-- update
-- delete

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

select * from artistas
