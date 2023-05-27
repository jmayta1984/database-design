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
