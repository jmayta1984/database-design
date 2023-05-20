-- Muestre el nombre del producto y el nombre su categoría para cada producto.

select ProductName, CategoryID from Products

select CategoryID, CategoryName from Categories

select ProductName, CategoryName from Products as P, Categories as C
where P.CategoryID = C.CategoryID

-- Muestre el nombre del producto y el nombre su categoría para cada producto.
select ProductName, CategoryName
from Products as P
	join Categories as C on P.CategoryID = C.CategoryID

-- Indicar la cantidad de órdenes realizadas por producto (mostrar el nombre del producto)

select ProductName, count(*) Quantity
from [Order Details] as OD
	join Products as P on OD.ProductID = P.ProductID
group by ProductName

-- Indicar la cantidad de órdenes atendidas por cada empleado (mostrar el nombre
-- y apellido de cada empleado).

select LastName, FirstName, count(*) as Quantity
from Orders O
	join Employees E on O.EmployeeID = E.EmployeeID
group by LastName, FirstName

