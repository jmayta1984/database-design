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
exec usp_delete_category 2, @Q output
print(@q)
