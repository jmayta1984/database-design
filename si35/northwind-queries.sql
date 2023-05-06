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

use NORTHWND1

-- Indicar la cantidad de clientes
select count(*) from Customers

-- Indicar la cantidad de clientes cuya procedencia sea Alemania
select count(*) from Customers where Country = 'Germany'

-- Indicar la cantidad de clientes por país de procedencia
select Country, count(*) as Quantity from Customers group by country

-- Indicar los nombres de los países que tengan más de 5 clientes
select Country, count(*) as Quantity from Customers
group by country
having count(*) > 5

-- Indicar el nombre del país con la mayor cantidad de clientes
select Country, count(*) as Quantity from Customers group by country


-- temporal
select max(Quantity)
from (select Country, count(*) as Quantity from Customers group by country)Temporal

-- temp
select Country
from (select Country, count(*) as Quantity from Customers group by country) Temporal
where Quantity = (select max(Quantity)
from (select Country, count(*) as Quantity from Customers group by country) Temp)
