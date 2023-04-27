use NORTHWND

select * from Customers

-- Mostrar los clientes que son de Mexico
select * from Customers where Country = 'Mexico'

-- Mostrar los clientes que son de France
select * from Customers where Country = 'France'

-- Mostrar los clientes cuyo contacto sea del tipo Owner
select * from Customers where ContactTitle = 'Owner'

-- Mostrar los clientes cuyo contacto sea del tipo Owner y sean del pais de Germany
select * from Customers where ContactTitle = 'Owner' and Country = 'Germany'

-- Indicar la cantidad total de clientes
select * from Customers

-- Funciones de agregación
-- count: contar

select count(*) from Customers

-- Indicar la cantidad total de órdenes
select count(*) from Orders

-- Indicar la cantidad total de clientes que son de México
select count(*) from Customers where Country = 'Mexico'


-- Mostrar los países de procedencia de los clientes
select Country from Customers order by Country

-- distinct: muestra los valores únicos
select distinct Country from Customers
