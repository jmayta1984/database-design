-- select: que columnas
-- from: que tablas
-- where: que condiciones
-- Recuperar las filas de una tablas dada una condición


-- La relación de todos los empleados
select *
from Employees

-- Listar el nombre y apellido de los empleados
select FirstName, LastName
from Employees

-- Listar el nombre y apellido de los empleados del país de USA
select FirstName, LastName, Country
from Employees
where Country = 'USA'

-- Listar los nombres de los productos cuyo precio unitario sea mayor 18 pero menor a 100,
-- mostrando primero los productos de mayor precio

select ProductName, UnitPrice
from Products
where UnitPrice > 18 and UnitPrice < 100
order by UnitPrice desc

-- Indicar los países de procedencia de los clientes
select distinct Country
from Customers

-- Indicar los nombres de los clientes que no
-- sean de los siguientes países de Francia, Brasil y México

select CompanyName, Country
from Customers
where Country not in ('France', 'Brazil', 'Mexico')

-- Indicar los nombre de los clientes que comiecen con Ma
select CompanyName
from Customers
where CompanyName like 'ma%'

-- Indicar los nombre de los clientes con que contenga market
select CompanyName
from Customers
where CompanyName like '%market%'

-- Indicar los nombres de clientes que comiencen con la letra L o la letra M
select CompanyName
from Customers
where CompanyName like '[lm]%'

-- Indicar la cantidad de clientes
select count(CustomerID) from Customers

-- Indicar la cantidad de clientes cuya procedencia sea Alemania
select count(*) from Customers where Country = 'Germany'

-- Indicar la cantidad de clientes por país de procedencia
select Country, count(*) as Quantity from Customers group by Country

-- Indicar la cantidad de países de procedencia de los clientes
select count (distinct Country) from Customers

-- Indicar el mayor precio unitario de los productos
select max(UnitPrice) from Products

-- Indicar el menor precio unitario de los productos
select min(UnitPrice)from Products

-- Indicar el promedio de unidades en stock de todos los productos
select avg(UnitsInStock) from Products

-- Indicar el cantidad total de unidades en stock de todos los productos
select sum(UnitsInStock) from Products

-- Indicar la cantidad de productos de acuerdo a su discontinuidad
select Discontinued, count(*) from Products group by Discontinued

-- Indicar los países de procedencia que superen los cinco clientes
-- Alternativa 1
select Country, count(*) as Quantity from Customers group by Country having count(*)>5

-- Alternativa 2
select Country, count(*) as Quantity from Customers group by Country

select Country, Quantity 
from (select Country, count(*) as Quantity from Customers group by Country) as Temporal
where Quantity > 5

-- Indicar el nombre del producto con el mayor precio unitario
select max(UnitPrice) from Products
-- 263.50

select ProductName from Products where UnitPrice = (select max(UnitPrice) from Products)

-- Indicar el nombre del país con la mayor cantidad de clientes
