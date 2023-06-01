-- Crear un procedimiento almacenado que permita registrar una categoría

create procedure USPInsertCategory
	@CategoryName nvarchar(15)
as
begin

	if not exists
		(select * from Categories where CategoryName = @CategoryName)
	begin
		insert into Categories (CategoryName)
		values (@CategoryName)
		print(concat(N'Se ingresó la categoría de nombre: ', @CategoryName))
	end
	else 
		print (N'No se pudo ingresar la categoría')
end;
go;

select * from Categories;
go;

exec USPInsertCategory  @CategoryName = 'Electronics'
go;

-- Crear un procedimiento almacenado que permita borrar una categoría
create procedure USPDeleteCategory
	@CategoryID int
as
begin
	if not exists
	(select * from Products where CategoryID = @CategoryID)
	begin
		delete from Categories
		where CategoryID = @CategoryID
		print(concat(N'Se eliminó la categoría de código: ', @CategoryID))
	end
	else 
		print (N'No se pudo eliminar la categoría al estar referenciada')
end;
go;

-- Crear un procedimiento almacenado que retorne la cantidad de clientes
create procedure USPCustomerQuantity
	@Quantity int output
as
begin
	set @Quantity = (select count(*) from Customers)
end
go;

declare @Q int
exec USPCustomerQuantity @Quantity = @Q output
print (@Q)
go;

-- Crear un procedimiento almacenado que imprima los nombres y unidades en stock de cada producto

create procedure USPPrintProductsStock
as
begin
	declare @ProductName nvarchar(40)
	declare @UnitsInStock int
	declare ProductsCursor cursor for
	select ProductName, UnitsInStock from Products

	open ProductsCursor

	fetch next from ProductsCursor into @ProductName, @UnitsInStock

	while (@@FETCH_STATUS = 0)
	begin
		print(concat(@ProductName, ': ', @UnitsInStock))
		fetch next from ProductsCursor into @ProductName, @UnitsInStock
	end

	close ProductsCursor
	deallocate ProductsCursor
end
go;

exec USPPrintProductsStock
go;

-- Crear un trigger que se ejecute al ingresar una nueva categoría

create trigger TRInsertCategory on Categories
for insert
as
	print(N'Se ejecutó el trigger para el insert de la tabla Categories')
go;

exec USPInsertCategory 'Demo'
go;

create trigger TRDeleteCategory on Categories
for delete
as
	begin
		declare @CategoryName nvarchar(15)
		set @CategoryName = (select CategoryName from deleted)
		print(concat(N'Se ejecutó el trigger para eliminar la categoría: ', @CategoryName))
	end
go;

select * from Categories
go;

exec USPDeleteCategory 11
go;
