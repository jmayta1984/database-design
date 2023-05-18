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

-- Indicar la cantidad de items vendidos por cada produdcto (mostrar el nombre del producto)
select ProductName, sum(Quantity)
from [Order Details] OD
    join Products P on P.ProductID = OD.ProductID
group by ProductName

-- Encontrar los pedidos que debieron despacharse a una ciudad o código postal diferente de la ciudad
-- o código postal del cliente que los solicitó. Para estos pedidos, mostrar el país, ciudad y código postal
-- del destinatario, así como la cantidad total de pedidos por cada destino

select ShipCountry, ShipCity, ShipPostalCode, count(*) Quantity
from Orders O
join Customers C on O.CustomerID = C.CustomerID
where (ShipCity <> City) or (ShipPostalcode <> PostalCode)
group by ShipCountry, ShipCity, ShipPostalCode


-- Seleccionar todas las compañías de envío (código y nombre) que hayan efectuado algún despacho a
-- México entre el primero de enero y el 28 de febrero de 2018.
-- Formatos sugeridos a emplear para fechas:
-- • Formatos numéricos de fecha (por ejemplo, '4/15/2018')
-- • Formatos de cadenas sin separar (por ejemplo, '20181207')

select ShipperID, CompanyName
from Orders O
    join Shippers S on O.ShipVia = S.ShipperID
where (ShipCountry = 'Mexico') and (ShippedDate between '20180101' and '20180228')

-- Mostrar el nombre de las compañias (empresa de envio) que tienen ordenes pendienes de envio


select  CompanyName
from Orders O
    join Shippers S on O.ShipVia = S.ShipperID
where ShippedDate is null

-- Mostrar los nombres y apellidos de los empleados junto con los nombres y apellidos de sus respectivos
-- jefes

select E.EmployeeID, E.LastName, E.FirstName, E.ReportsTo, B.EmployeeID, B.LastName, B.FirstName
from Employees E
left join Employees B on E.ReportsTo = B.EmployeeID


select Country, year(OrderDate) Year, sum((Quantity*UnitPrice)*(1-Discount)) Total
from [Order Details] OD
    join Orders O on OD.OrderID = O.OrderID
    join Employees E on O.EmployeeID = E.EmployeeID
group by  Country, year(OrderDate)
order by Total desc

