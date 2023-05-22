-- Indicar el nombre del producto con la mayor cantidad de órdenes

create view orders_by_product as
select ProductName, count(*) Quantity
	from [Order Details] OD
		join Products P on OD.ProductID = P.ProductID
	group by ProductName;
go;


select * from orders_by_product
go;

select max(quantity) from orders_by_product;
go;

select ProductName
from orders_by_product
where Quantity = (select max(quantity) from orders_by_product)
go;
-- Crear una vista con todas las ordenes cuyo destino sea brazil

create view orders_to_brazil as
select * from Orders where ShipCountry = 'Brazil'
go;

-- Indicar el nombre del producto con
-- menor cantidad de pedidos utilizando vistas

select ProductName
from orders_by_product
where Quantity = (select min(quantity) from orders_by_product)
go;
-- Crear una función que permita calcular la cantidad de pedidos hacia un destino.
-- Para lo cual se debe ingresar el pais como parámetro.

create function f_orders_quantity_by_country(@country nvarchar(15))
returns int
as
begin
	declare @quantity int

	select @quantity = count(*) from Orders where ShipCountry = @country
	return @quantity
end;
go;

print dbo.f_orders_quantity_by_country('Mexico')
go;
--

-- Crear una función que permita calcular la cantidad de pedidos atendidos por un empleado.
-- Para lo cual se debe ingresar el código del empleado.

create function f_orders_quantity_by_employee(@employee int)
returns int
as
begin
	declare @quantity int

	select @quantity = count(*) from Orders where EmployeeID = @employee
	return @quantity
end;
go;


print concat('Total orders: ' ,dbo.f_orders_quantity_by_employee(1))
go;


create view orders_quantity_by_year_by_customer_country
as
select year(OrderDate) as Year, Country, count(*) as Quantity
from Orders as O
	inner join Customers as C on O.CustomerID = C.CustomerID
group by year(OrderDate), Country;
go;


create function f_country_min_orders_by_year(@Year int)
returns table
return
select Country, Quantity from orders_quantity_by_year_by_customer_country
where Quantity = (
		select min(quantity) from orders_quantity_by_year_by_customer_country
		where Year = @Year)
go;

select * from dbo.f_country_min_orders_by_year(2016)
