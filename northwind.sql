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
