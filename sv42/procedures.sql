-- Crear un procedimiento almacenado que permite ingresar una nueva categoría

create procedure USPInsertCategory
@CategoryName nvarchar(15),
@Description ntext
as
begin
	insert into Categories (CategoryName, Description)
	values (@CategoryName, @Description)
end;
go;

select * from Categories
go;

exec USPInsertCategory  'Test', 'Test'
go;

-- Crear un procedimiento almacenado que permite eliminar una categoría indicando el
-- id de la categoría

create procedure USPDeleteCategory 
@CategoryID int,
@Quantity int output
as
begin
	 
	select @Quantity = count(*) from Products where CategoryID = @CategoryID

	if @Quantity = 0
	begin
		delete from Categories
		where CategoryID = @CategoryID;

		print ('Se eliminó la categoría') 
	end
	else
		print('No se puede eliminar la categoría por estar siendo utilizada')
end;
go;

declare @q int
exec USPDeleteCategory 1, @Quantity = @q output
print @q
go;


-- Crear un procedimiento almacenado que imprima la cantidad de unidades en stock
-- para cada producto

create procedure USPUnitsInStock
as
begin
	declare @ProductName nvarchar(40)
	declare @UnitsInStock smallint
	declare @TotalUnitsInStock smallint
	
	set @TotalUnitsInStock = 0

	declare ProductCursor cursor for
	select ProductName, UnitsInStock 
	from Products

	open ProductCursor

	fetch ProductCursor into @ProductName, @UnitsInStock
	while (@@FETCH_STATUS = 0)
	begin
		print (concat(@ProductName, ': ',@UnitsInStock))
		set @TotalUnitsInStock += @UnitsInStock
		fetch ProductCursor into @ProductName, @UnitsInStock
	end

	print (concat('Total de unidades: ',@TotalUnitsInStock))
	close ProductCursor
	deallocate ProductCursor
end;
go;

exec USPUnitsInStock
go;

create trigger TXCategories ON Categories
for insert
as
print ('Se ingresó un nuevo registro')
go;

exec USPInsertCategory 'Demo', 'Prueba'
go;

create trigger TXCategoriesInsert on Categories
for insert
as
if (select count(*) from inserted, Categories
where inserted.CategoryName = Categories.CategoryName) > 1
begin
	Rollback transaction
	print ('El nombre de la categoría se encuentra registrado')
end 
else
	print ('La categoría fue ingresada')
