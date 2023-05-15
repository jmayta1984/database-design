-- Indicar el nombre del producto y el nombre su categoría para cada producto

select ProductName, CategoryID from Products

select CategoryID, CategoryName from Categories

select ProductName, CategoryName from Products, Categories
where Products.CategoryID = Categories.CategoryID

select ProductName, CategoryName
from Products as P
join Categories as C on P.CategoryID = C.CategoryID

-- Indicar el nombre del producto con la mayor cantidad de órdenes

select ProductName, count(*) Quantity
from [Order Details] OD
	join Products P on OD.ProductID = P.ProductID
group by ProductName
having count(*) =
	(select max(Quantity) 

	from (select ProductName, count(*) Quantity
	from [Order Details] OD
		join Products P on OD.ProductID = P.ProductID
	group by ProductName) Temporal)

-- Indicar la cantidad de órdenes atendidas
-- por cada empleado (mostrar el nombre y apellido del empleado)

select LastName + ', ' +FirstName  FullName, count(*) Quantity
from Orders O
	join Employees E on O.EmployeeID = E.EmployeeID
group by LastName + ', ' +FirstName

-- Indicar la cantidad de órdenes realizadas por cada cliente
-- (mostrar el nombre de la compañía)
select CompanyName, count(*) Quantity
from Orders O
	join Customers C on O.CustomerID = C.CustomerID
group by CompanyName

-- Realizar la consulta que permita identificar los nombres de las
-- compañías que no realizaron ninguna orden

-- Clientes que han hecho órdenes
select distinct CustomerID from Orders

-- Clientes que no han hecho órdens
select CompanyName from Customers
where CustomerID not in (select distinct CustomerID from Orders)

-- Muestre el código y nombre de todos los clientes (companyname)
-- que tienen órdenes pendientes de despachar.

select distinct C.CustomerID, CompanyName
from Orders O
	join Customers C on O.CustomerID = C.CustomerID
where ShippedDate is null
order by C.CustomerID

-- Muestre el código y nombre de todos los clientes (companyname)
-- que tienen órdenes pendientes de despachar,
-- y la cantidad de órdenes con esa característica.

select C.CustomerID, CompanyName, count(*)
from Orders O
	join Customers C on O.CustomerID = C.CustomerID
where ShippedDate is null
group by C.CustomerID, CompanyName
order by C.CustomerID

-- Indicar el nombre del cliente (nombre compañía)
-- con menor cantidad de órdenes realizadas

select CompanyName, count(*)Quantity
	from Orders O
		join Customers C on O.CustomerID = C.CustomerID
	group by CompanyName
	having count(*) =
		(select min(Quantity)
		from (select CompanyName, count(*)Quantity
			from Orders O
				join Customers C on O.CustomerID = C.CustomerID
			group by CompanyName) Temporal)
