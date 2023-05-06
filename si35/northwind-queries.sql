use NORTHWND1

-- DDl: Data definition language (metada)
-- Definir estructuras de los objetos de base de datos
-- database
-- table

-- create: crear
-- alter: modificar
-- drop: eliminar

-- DML: Data manipulation language
-- Manipular los datos que se encuentran dentro de los objetos de base de datos

-- insert: agregar filas a las tablas
-- update: actualizar filas de las tablas dada una condición
-- delete: eliminar filas de las tablas dada una condición
-- select: recuperar filas de las tablas dada una condición

select CompanyName,Country
from Customers
order by Country

-- Indicar los nombres de los productos cuyo precio unitario sea menor a 50

select ProductName, UnitPrice from Products
where UnitPrice < 50
order by UnitPrice desc

-- Indicar los nombres de los productos
-- cuyo precio unitario sea menor a 50 y mayor a 20

select ProductName, UnitPrice from Products
where UnitPrice < 50 and UnitPrice > 20
order by UnitPrice

-- Indicar los nombres de los productos
-- cuyo precio unitario sea mayor a 50 o menor a 20
select ProductName, UnitPrice from Products
where UnitPrice > 50 or UnitPrice < 20
order by UnitPrice
