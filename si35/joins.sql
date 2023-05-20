use NORTHWND1

select ProductName,CategoryID from Products
--  77

select CategoryID, CategoryName from Categories
-- 8


select ProductName, CategoryName from Products, Categories
where Products.CategoryID = Categories.CategoryID

select ProductName,C.CategoryID,CategoryName
from Products P
    join Categories C on C.CategoryID = P.CategoryID

-- Indicar la cantidad de órdenes atendidas por cada empleado (mostrar el nombre y apellido de cada
-- empleado).

select LastName + ', ' + FirstName FullName, count(*) Quantity
from Orders O
    join Employees E on O.EmployeeID = E.EmployeeID
group by LastName + ', ' + FirstName

-- Indicar la cantidad de órdenes realizadas por cada cliente (mostrar el nombre de la compañía).
select CompanyName, count(*) Quantity
from Orders O
    join Customers C on O.CustomerID = C.CustomerID
group by CompanyName

-- Indicar el nombre del producto con la mayor cantidad de órdenes realizadas.

select ProductName, count(*) Quantity
        from [Order Details] OD
        join Products P on OD.ProductID = P.ProductID
        group by ProductName
        having count(*) = (select max(Quantity)
                            from    (select ProductName, count(*) Quantity
                                    from [Order Details] OD
                                    join Products P on OD.ProductID = P.ProductID
                                    group by ProductName) Temporal)

-- Identificar la relación de clientes (nombre de compañía) que no realizaron orden alguna.

select CompanyName from Customers where CustomerID not in (select distinct CustomerID from Orders)

-- Muestre el código y nombre de todos los clientes (nombre de compañía) que tienen órdenes
-- pendientes de despachar.

select  C.CustomerID, CompanyName
from Orders O
    join Customers C on O.CustomerID = C.CustomerID
where ShippedDate is null
order by C.CustomerID

-- Muestre el código y nombre de todos los clientes (nombre de compañía) que tienen órdenes
-- pendientes de despachar, y la cantidad de órdenes con esa característica.

select  C.CustomerID, CompanyName, count(*) Quantity
from Orders O
    join Customers C on O.CustomerID = C.CustomerID
where ShippedDate is null
group by C.CustomerID, CompanyName
order by C.CustomerID
