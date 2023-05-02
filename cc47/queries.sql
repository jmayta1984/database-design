use northwnd1

-- Sentencias ddl
-- create
-- alter
-- drop

-- Sentencias dml
-- select
-- insert
-- update
-- delete


-- Listar los nombres de los productos cuyo precio unitario
-- sea mayor a 18 pero menor a 100, mostrando
-- primero los productos de mayor precio
select ProductName, UnitPrice
from Products
where UnitPrice > 18
  and UnitPrice < 100
order by UnitPrice desc

-- Indicar los países de procedencia de los clientes
select distinct Country
from Customers

-- Indicar los nombres de los clientes que no sean de los siguientes países Francia, Brazil y Mexico
select CompanyName, Country
from Customers
where Country not in ('France', 'Brazil', 'Mexico')

--Indicar los nombres de clientes que comiencen con la letra L o la letra M
select CompanyName
from Customers
where CompanyName like '[lm]%'

-- Funciones de agregación
-- count: contar
-- max: determina el mayor valor
-- min: determina el menor valor
-- avg: determina el promedio
-- sum: determina la suma

-- Indicar la cantidad de clientes
select count(*)
from Customers

-- Indicar el mayor precio unitario de los productos
select max(UnitPrice)
from Products

-- Indicar el menor precio unitario de los productos
select min(UnitPrice)
from Products

-- Indicar la cantidad de países distintos de procedencia de los clientes
select count(distinct Country)
from Customers

-- Indicar la cantidad de clientes cuya procedencia sea Germany
select count(*)
from Customers
where Country = 'Germany'

-- Indicar la cantidad de clientes por país de procedencia
select Country, count(*)
from Customers
group by Country

-- Indicar la cantidad de productos de acuerdo a su continuidad
select Discontinued, count(*) Quantity
from Products
group by Discontinued

-- Indicar los países de procedencia que superen los cinco clientes
-- Alternativa 1
select Country, count(*) Quantity
from Customers
group by Country
having count(*) > 5

-- Alternativa 2
select Country, Quantity
from (select Country, count(*) Quantity
      from Customers
      group by Country) Temporal
where Quantity > 5

-- Indicar el nombre del producto con mayor precio
select max(UnitPrice)
from Products
-- 263.5

select ProductName, UnitPrice
from Products
where UnitPrice = (select max(UnitPrice)
                   from Products)

-- Indicar el nombre del país con la mayor cantidad de clientes
select Country, count(*) Quantity
from Customers
group by Country

select max(Quantity)
from (select Country, count(*) Quantity
      from Customers
      group by Country) Temporal
-- 13


select Country, count(*) Quantity
from Customers
group by Country
having count(*) = (select max(Quantity)
                   from (select Country, count(*) Quantity
                         from Customers
                         group by Country) Temporal)
