
use NORTHWND1;
go;
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
go;

create view orders_quantity_by_product
as
select ProductName, count(*) Quantity
from [Order Details] OD
        join Products P on OD.ProductID = P.ProductID
group by ProductName;
go;

select ProductName
from orders_quantity_by_product
where Quantity = (select max(Quantity) from orders_quantity_by_product)

-- Indicar el nombre del producto con la menor cantidad de órdenes realizadas.

select ProductName
from orders_quantity_by_product
where Quantity = (select min(Quantity) from orders_quantity_by_product)
go;
-- Indicar el empleado (apellido y nombre) con la mayor cantidad de ordenes atendidas

create view orders_quantity_by_employee
as
select concat(LastName, ', ', FirstName) as FullName, count(*) as Quantity
from Orders O
    join Employees E on O.EmployeeID = E.EmployeeID
group by concat(LastName, ', ', FirstName);
go;

select FullName
from orders_quantity_by_employee
where Quantity = (select max(Quantity) from orders_quantity_by_employee)

-- Crear una vista con todas la órdenes realizadas cuyo destino sea Francia

create view orders_to_france
as
select * from Orders where ShipCountry = 'France'
go;

select * from orders_to_france


-- Crear una función que retorne la cantidad de empleados

create function f_employees_quantity() returns int
as
begin
    declare @quantity int
    select @quantity=count(*) from Employees
    return @quantity
end;
go;

print dbo.f_employees_quantity()

-- Crear una función que retorne la cantidad de órdenes para un determinado país

create  function f_orders_by_country(@Country nvarchar(15)) returns int
as
begin
    declare @Quantity int

    select @Quantity=count(*)
    from Orders
    where ShipCountry = @Country

    return @Quantity
end;

print dbo.f_orders_by_country ('France')


-- Crear una vista que muestra la cantidad de pedidos por cada cliente por cada año.
create view orders_quantity_by_country_by_year
as
select year(OrderDate) Year, Country, count(*) Quantity
from Orders O
    join Customers C on O.CustomerID = C.CustomerID
group by year(OrderDate), Country
go;

-- Crear una función que retorne el país de procedencia del cliente con la menor cantidad de pedidos
-- atendidos para un determinado año.

create function f_min_orders_by_year(@year int) returns table
return
select * from orders_quantity_by_country_by_year
where year = @year and
      Quantity = (select min(Quantity) from orders_quantity_by_country_by_year where Year = @year)
go;

select * from dbo.f_min_orders_by_year(2016)
