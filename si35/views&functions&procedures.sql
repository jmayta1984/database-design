-- Crear una función que retorne el nombre de la categoría con la mayor cantidad de unidades
-- vendidas para un determinado año.


-- CategoryName, CategoryID -> Categories C
-- CategoryID, ProductID -> Products P
-- Quantity, ProductID, OrderID -> [Order Details] OD
-- OrderDate, OrderID -> Orders O

create view VTotalUnitsByYearByCategoryName
as
select CategoryName, Year(OrderDate) Year, sum(Quantity) TotalUnits
from Categories C
	join Products P on C.CategoryID = P.CategoryID
	join [Order Details] OD on P.ProductID = OD.ProductID
	join Orders O on OD.OrderID = O.OrderID
group by CategoryName, Year(OrderDate);
go;

select max(TotalUnits)
from VTotalUnitsByYearByCategoryName
where Year = 2018
go;
-- 3694


create function FCategoryNameWithMaxTotalUnits(@Year int) returns table
return
select CategoryName
from VTotalUnitsByYearByCategoryName
where Year = @Year and TotalUnits = (select max(TotalUnits)
					from VTotalUnitsByYearByCategoryName
					where Year = @Year);
go;

select * from dbo.FCategoryNameWithMaxTotalUnits(2016)
go;

-- Crear una función que retorne el nombre del shipper (empresa que envía)
-- con la mayor cantidad de pedidos asignados para un determinado año.

-- CompanyName, ShipperID -> Shippers S
-- OrderID, OrderDate, ShipVia -> Orders O

create view VTotalOrdersByYearByShipper
as
select CompanyName, Year(OrderDate) Year,  count(OrderID) TotalOrders
from Shippers S
	join Orders O on S.ShipperID = O.ShipVia
group by CompanyName, Year(OrderDate);
go;

create function FShipperNameWithMaxOrders(@Year int) returns table
return
select CompanyName
from VTotalOrdersByYearByShipper
where Year = @Year and TotalOrders = (select max(TotalOrders) from VTotalOrdersByYearByShipper
										where Year = @Year);
go;


-- Crear un procedimiento o función que liste la relación de los nombres de los
-- productos para una determinada categoría (nombre de categoría).

-- ProductName, CategoryID -> Products P
-- CategoryName, CateogoryID -> Categories C

create procedure USPProductsByCategoryName
@CategoryName nvarchar(15)
as
begin
	select ProductName, CategoryName
	from Products P
		join Categories C on P.CategoryID = C.CategoryID
	where CategoryName = @CategoryName
end;
go;

exec USPProductsByCategoryName 'Beverages'
go;

-- Crear un procedimiento almacenado que permita actualizar el stock de un
-- producto. Para lo cual se indica el código del producto y la cantidad
-- de unidades vendidas.

create procedure USPUpdateProducts
@ProductID int,
@Quantity int
as
begin
	update Products
	set UnitsInStock = UnitsInStock - @Quantity
	where ProductID = @ProductID and UnitsInStock >= @Quantity
end;

exec USPUpdateProducts 1,9
