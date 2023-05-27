use NORTHWND1;
go;

-- De cada producto que haya tenido venta en por lo menos 20 transacciones (ordenes) del año 2017
-- mostrar el código, nombre y cantidad de unidades vendidas y cantidad de ordenes en las que se
-- vendió.

-- ProductName, ProductID -> Products
-- Quantity, OrderID, ProductID -> Order Details
-- OrderDate, OrderID -> Orders

select OD.ProductID, ProductName, sum(Quantity) TotalUnits, count(O.OrderID) TotalOrders
from [Order Details] OD
	join Orders O on OD.OrderID = O.OrderID
	join Products P on OD.ProductID = P.ProductID
where Year(OrderDate) = 2017
group by OD.ProductID, ProductName
having count(O.OrderID) >= 20;
go;
-- funciones de agregación
-- count
-- sum
-- min
-- max
-- avg

-- Indicar el nombre del producto con la mayor cantidad de órdenes.

-- ProductName, ProductID -> Products
-- ProductID, OrderID -> [Order Details]

create view OrdersQuantityByProductName
as
select ProductName, count(OrderID) OrdersQuantity
from Products P
	join [Order Details] OD on P.ProductID = OD.ProductID
group by ProductName;
go;

select max(OrdersQuantity) from OrdersQuantityByProductName;
go;
-- 54

select ProductName
from OrdersQuantityByProductName
where OrdersQuantity = (select max(OrdersQuantity) from OrdersQuantityByProductName);
go;

-- Crear una vista que muestre la cantidad de unidades vendidas por cada categoría de producto anualmente.

-- CategoryName, CategoryID -> Categories
-- CategoryID, ProductID -> Products
-- Quantity, ProductID, OrderID -> [Order Details]
-- OrderDate, OrderID -> Orders

create view TotalUnitsByYearByCategoryName
as
select CategoryName, Year(OrderDate) Year, sum(Quantity) TotalUnits
from Categories C
	join Products P on C.CategoryID = P.CategoryID
	join [Order Details] OD on P.ProductID = OD.ProductID
	join Orders O on OD.OrderID = O.OrderID
group by CategoryName, Year(OrderDate);
go;

select * from TotalUnitsByYearByCategoryName
go;

-- Crear una función que retorne la cantidad total de órdenes

create function FTotalOrders() returns int
as
begin
	declare @TotalOrders int
	select @TotalOrders = count(OrderID) from Orders
	return @TotalOrders
end;
go;

select dbo.FTotalOrders()
go;

-- Crear una función que retorne la cantidad total de órdenes para un determinado año

create function FTotalOrdersByYear(@Year int) returns int
begin
	declare @TotalOrders int
	select @TotalOrders = count(OrderID) from Orders where Year(OrderDate) = @Year
	return @TotalOrders
end;
go;

select dbo.FTotalOrdersByYear(2016)
go;

-- Crear una función que retorne los nombres de los clientes que realizaron al menos un pedido
-- para un determinado año.

-- CompanyName, CustomerID -> Customers as C
-- OrderID, OrderDate, CustomerID -> Orders as O

create function CustomerWithOrders(@Year int) returns table
return
	select CompanyName, Year(OrderDate) as Year, count(OrderID) as TotalOrders
	from Customers as C
		join Orders as O on C.CustomerID = O.CustomerID
	where Year(OrderDate) = @Year
	group by CompanyName, Year(OrderDate);
go;

select * from dbo.CustomerWithOrders(2016)
go;

-- Crear una función que retorne el nombre del shipper (empresa que hace el envío)
-- con la mayor cantidad de pedidos asignados para un determinado año.

-- CompanyName, ShipperID -> Shippers as S
-- OrderID, OrderDate, ShipVia -> Orders as O

create view TotalOrdersByYearByShipper
as
select CompanyName, Year(OrderDate) as Year, count(OrderID) as TotalOrders
from Shippers as S
	join Orders as O on S.ShipperID = O.ShipVia
group by CompanyName, Year(OrderDate)
go;


select * from TotalOrdersByYearByShipper
go;

-- 2016

select max(TotalOrders)
from TotalOrdersByYearByShipper
where Year = 2016;
--58
go;


create function ShipperWithMaxOrders(@Year int) returns table
return
select CompanyName
from TotalOrdersByYearByShipper
where Year = @Year and TotalOrders = (select max(TotalOrders)
					from TotalOrdersByYearByShipper
					where Year = @Year)
go;

select * from dbo.ShipperWithMaxOrders(2016)

-- Crear un procedimiento o función que liste los nombres de los productos
-- para una determinada categoría (nombre la categoría)

-- ProductName, CategoryID -> Products as P
-- CategoryName, CategoryID -> Categories as C

create procedure USPProductsByCategoryName
@CategoryName nvarchar(15)
as
begin
	select ProductName
	from Products as P
		join Categories as C on P.CategoryID = C.CategoryID
	where CategoryName = @CategoryName
end
go;

exec USPProductsByCategoryName 'Beverages'


-- Crear un procedimiento almacenado que permita actualizar el stock de
-- unidades de un producto, teniendo como dato el código del producto y
-- la cantidad de unidades vendidas.

-- Producto: Chai  Código:1  Vender: 9

select ProductID, ProductName, UnitsInStock
from Products
go;

create procedure USPUpdateProductsStock
@ProductID int,
@Quantity int
as
begin

	update Products
	set UnitsInStock = UnitsInStock - @Quantity
	where ProductID = @ProductID and UnitsInStock >= @Quantity
end;

exec USPUpdateProductsStock 1, 31
