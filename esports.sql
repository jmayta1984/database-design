create database esports

use esports

create table propietarios(
	codigo int not null,
	nombre varchar(100) not null,
	direccion varchar(255) not null,
	telefono varchar(20) not null,
	constraint propietarios_pk primary key (codigo)
)
--DDL: Definir estructuras de los objetos de base de datos 
-- create: crear objetos de base de datos
-- alter: modificar objetos de base de datos
-- drop: eliminar objetos de base de datos

alter table propietarios
add ciudad varchar(100)

alter table propietarios
drop column ciudad

--DML: Permitir manipular datos
-- insert: insertar filas a una tabla
-- update: modificar filas de una tabla dada una condición
-- delete: eliminar filas de una tabla dada una condición
-- select: recuperar filas de una tabla dada una condición

-- Recuperar filas
select * from propietarios

-- Insertar filas
insert into propietarios (codigo, nombre, direccion, telefono)
values (1, 'Francisco Bedoya', 'Av. San Marcos 164', '945678132')

insert into propietarios (codigo, nombre, direccion, telefono)
values (2, 'Juana Castro', 'Av. San Luis 164', '945678152')

insert into propietarios (codigo, nombre, direccion, telefono)
values (3, 'Liliana Campos', 'Av. San Roque 184', '947678132')

alter table propietarios
add ciudad varchar(100)

update propietarios set ciudad = 'Lima'

update propietarios set ciudad = 'Huancayo' where codigo = 2

insert into propietarios (codigo, nombre, direccion, telefono)
values (4, 'Marcos Quispe', 'Av. San Luque 184', '968678132')

delete from propietarios where codigo = 4

alter table propietarios alter column ciudad varchar(100) not null

insert into propietarios (codigo, nombre, direccion, telefono, ciudad)
values (4, 'Marcos Quispe', 'Av. San Luque 184', '968678132', 'Huancayo')

select * from propietarios where ciudad = 'Huancayo'
