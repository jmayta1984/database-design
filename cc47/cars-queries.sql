-- DDL
-- Definir estructuras de objetos de base de datos
-- create
-- alter
-- drop

create database vehiculos

use vehiculos

create table garajes (
    codigo int not null,
    nombre varchar(100) not null,
    direccion varchar(255) not null,
    ciudad varchar(100) not null,
    constraint garajes_pk primary key (codigo)
)

alter table garajes
add capacidad int not null

-- DML
-- INSERT: Insertar filas a una tabla
-- SELECT: Seleccionar filas de una tabla dada una condición
-- UPDATE: Actualizar filas de una tabla dada una condición
-- DELETE: Eliminar filas de una tabla dada una condición

insert into garajes (codigo, nombre, direccion, ciudad, capacidad)
values (1, 'Local Angamos', 'Av. Primavera 1240', 'Lima', 100)

insert into garajes (codigo, nombre, direccion, ciudad, capacidad)
values (2, 'Local Arequipa', 'Av. Arequipa 1240', 'Lima', 50)

insert into garajes (codigo, nombre, direccion, ciudad, capacidad)
values (3, 'Local Aviación', 'Av. Lumbreras 1240', 'Arequipa', 70)

select * from garajes

-- Mostrar los garajes que tienen una capacidad mayor a 80
select * from garajes where capacidad > 80

-- Mostrar los garajes que tienen una capacidad mayor a 50 y están en Lima
select * from garajes where capacidad > 50 and ciudad = 'Lima'

-- Actualizar la capacidad de los garajes en Lima a 200
update garajes set capacidad = 200 where ciudad = 'Lima'
