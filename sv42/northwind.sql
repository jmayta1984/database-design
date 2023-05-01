use NORTHWND

select * from Customers

--select EmployeeID, LastName, FirstName, ReportsTo from Employees

-- Mostrar todos los clientes que sean del país de Germany

select * from Customers where Country = 'Brazil'

-- Mostrar todos los clientes que sean de la ciudad de Berlin
select * from Customers where City = 'Berlin'

-- Mostrar todos los clientes que sean del país de Germany
select CompanyName from Customers where Country <> 'Germany'

-- Mostrar todos los clientes que sean del país de France y la ciudad de Marseille
select * from Customers where Country = 'France' and City = 'Marseille'

-- Funciones de agregación
-- count: contar

-- Indicar la cantidad de clientes que son del país de Germany

select count(CustomerID) from Customers where Country = 'Germany'

-- Indicar la cantidad de órdenes

select count (OrderID) from Orders 


-- ddl: definición de las estructuras
-- create
-- alter
-- drop

-- dml: manipulación de datos
-- insert
-- select
-- update
-- delete

-- select: recuperar filas dada una condición
use northwind

-- Indicar los clientes que son del país de Francia
select *
from Customers
where Country = 'France'

-- Indicar los clientes que son de la ciudad de Berlin
select *
from Customers
where (City = 'Berlin')

-- Indicar el nombre de la empresa que tenga su contacto como dueño (Owner)
select CompanyName
from Customers
where ContactTitle = 'owner'

-- Listar los nombres de los productos cuyo precio unitario sea mayor a 18 pero menor a 100, mostrando
-- primero los productos de mayor precio
-- Alternativa 1
select ProductName, UnitPrice
from Products
where UnitPrice > 18
  and UnitPrice < 100
order by UnitPrice

-- Alternativa 2 (considerando los extremos)
select ProductName, UnitPrice
from Products
where UnitPrice between 18 and 100
order by UnitPrice

-- Indicar los países de procedencia de los clientes
select distinct Country
from Customers C
order by Country

-- Indicar los nombres de los clientes que no sean de los siguientes países Francia, Brazil y Mexico
select CompanyName
from Customers
where Country not in ('France', 'Brazil', 'Mexico')

-- Funciones de agregación
-- count: contar
-- max: mayor valor
-- min: menor valor
-- avg: promedio

-- Indicar la cantidad de clientes
select count(*) quantity
from Customers

-- Indicar el mayor precio unitario de los productos
select max(UnitPrice) max
from Products

-- Indicar el menor precio unitario de los productos
select min(UnitPrice) max
from Products

-- Indicar la cantidad de clientes que sean del país de Germany
select count(*) quantity
from Customers
where Country = 'Germany'

-- Indicar la cantidad de clientes por país de procedencia
select country, count(*) quantity
from Customers
group by country
order by quantity desc


-- Indicar la cantidad de clientes por país de procedencia que superen los 5 clientes
-- Alternativa 1
select country, count(*) quantity
from Customers
group by country
having count(*) > 5
order by quantity desc

-- Alternativa 2
select country, quantity
from (select country, count(*) quantity
      from Customers
      group by country) temporal
where quantity > 5
order by quantity desc

-- Indicar el nombre del producto con mayor precio
select max(UnitPrice) max
from Products

select ProductName
from Products
where UnitPrice = (select max(UnitPrice) max from Products)

-- Indicar el nombre del país con la mayor cantidad de clientes

select country, count(*) quantity
from Customers
group by country

select max(quantity)
from (select country, count(*) quantity
      from Customers
      group by country) temporal

select country, count(*) quantity
from Customers
group by country
having count(*) = (select max(quantity)
                   from (select country, count(*) quantity
                         from Customers
                         group by country) temporal)
