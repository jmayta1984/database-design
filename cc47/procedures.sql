-- Crear un procedimiento almacenado que permita ingresar una nueva categoría
use northwnd1;
go;

create procedure usp_insert_category
    @CategoryName nvarchar(15),
    @Description ntext
as
begin
    insert into Categories ( CategoryName, Description)
    values ( @CategoryName, @Description)
end;
go;

exec usp_insert_category  'Test', 'Test'
go;
-- Crear un procedimiento almacenado que permite eliminar una categoría

create procedure usp_delete_category
    @CategoryID int,
    @Quantity int output
as
begin
    select @Quantity = count(*) from Products where CategoryID = @CategoryID

    if @Quantity = 0
        begin
            delete from Categories where CategoryID = @CategoryID
        end
    else
        begin
            print (N'No se ha podido eliminar la categoría por tener productos asignados')
        end
end

declare @Q int
exec usp_delete_category @CategoryID = 2, @Quantity = @Q output
print(@q)

-- Crear un procedimiento almacenado que imprima los nombres y las unidades en stock
-- de cada producto
create procedure usp_print_stock
as
begin
    declare @ProductName nvarchar(40)
    declare @UnitInStock smallint
    declare products_cursor cursor for
    select ProductName, UnitsInStock
    from Products

    open products_cursor

    fetch products_cursor into @ProductName, @UnitInStock
    while (@@fetch_status = 0)
    begin
        print(concat(@ProductName, ': ', @UnitInStock))
        fetch products_cursor into @ProductName, @UnitInStock
    end

    close products_cursor
    deallocate products_cursor
end

exec usp_print_stock

-- Crear un procedimiento almacenado que imprima los cantidad de pedidos realizados para un producto (nombre)
-- en un determinado año

-- OrderID, OrderDate --> Orders O
-- OrderID, ProductID --> [Order Details] OD
-- ProductName, ProductID --> Products P

create procedure usp_print_stock_product
    @Year int,
    @ProductName nvarchar(40)
as
begin
    declare @Quantity int
    set @Quantity = (select TotalOrders from (select ProductName, year(OrderDate) Year, count(O.OrderID) TotalOrders
    from Orders O
        join [Order Details] OD on O.OrderID = OD.OrderID
        join Products P on OD.ProductID = P.ProductID
    where year(OrderDate) = @Year and ProductName = @ProductName
    group by ProductName, year(OrderDate)) Temporal)
    print(@Quantity)
end

exec usp_print_stock_product @Year = 2018, @ProductName = 'Chai'


create trigger tr_categories on Categories
for insert
    as
    print(N'Se insertó un registro')

exec usp_insert_category 'Demo' , 'Demo'

