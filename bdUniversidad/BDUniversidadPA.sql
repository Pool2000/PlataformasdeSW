-- Procedimientos almacenados TEscuela
-- Pool Andre
-- 8 de agosto 2022

-- PA para TEscuela
use BDUniversidad 
go

if OBJECT_ID('spListarEscuela') is not null
	drop proc spListarEscuela
go

create proc spListarEscuela
as
begin
	select CodEscuela, Escuela, Facultad from TEscuela
end
go

exec spListarEscuela
go

select * from TEscuela

if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go
create proc spAgregarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	-- CodEscuela no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		-- Escuela no puede ser duplicado
		if not exists(select Escuela from TEscuela where Escuela=@Escuela)
			begin
				insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
				select CodError = 0, Mensaje= 'Se inserto correctamente escuela'
			end
		else select CodError= 1, Mensaje = 'Error: Escuela duplicada'
	else select CodError = 1, Mensaje = 'Error: CodEscuela duplicado'
end
go




exec spAgregarEscuela 'E05','Civil','Ingenieria' --duplicado
go
exec spAgregarEscuela 'E06','Drecho','Ingenieria' --duplicado
go
exec spAgregarEscuela 'E05','Psicologia','Ingenieria' -- new
go


--  Actividad: Eliminar, Actualizar, Buscar, Listar

--------------------------------------
---Procedimiento eleminado
if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go
create proc spEliminarEscuela
@CodEscuela char(3)
as begin
	--1. CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		--2. No exista alummnos en la escuela que quiero eliminar
		if not exists(select CodEscuela from TAlumno where CodEscuela = @CodEscuela)
		begin 
			delete from TEscuela WHERE CodEscuela =  @CodEscuela
			select CodError = 0, Mensaje = 'Escuela elimanada correctamente'
		end

		else select CodError = 1, Mensaje = 'Error: No se puede eliminar por que existe alumnos en la escuela'
	else select CodError = 1, Mensaje = 'Error: CodEscuela no existe'
end
go

exec spEliminarEscuela 'E05'

 
exec spEliminarEscuela 'E04'


exec spListarEscuela
go




SELECT * FROM TEscuela
SELECT * FROM TAlumno



-- Procedimientos Actualizar escuela


if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go
create proc spActualizarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as
begin
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		-- 2.- No exista alumnos en la escuela que quiero actualizar
		if not exists(select Escuela, Facultad from TEscuela where Escuela = @Escuela and Facultad = @Facultad)
			begin
				update TEscuela set Escuela = @Escuela,Facultad = @Facultad  where CodEscuela = @CodEscuela
				select CodError = 0, Mensaje = 'Escuela actualizada correctamente'
			end
		else select CodError=1, Mensaje = 'Error: La escuela es duplicada'
	else select CodError = 1, Mensaje = 'Error: Codigo de Escuela no existe'

end


exec spActualizarEscuela 'E01', 'Derecho','Derecho y Ciencia Política'
go

exec spActualizarEscuela 'E04', 'Psicologia','Derecho y Ciencia Política' --New
go

exec spActualizarEscuela 'E05', 'Psicologia','Derecho y Ciencia Política'
go

select * from TEscuela


-- Procedimiento almacenado para Buscar Escuela con sensitivas y exactas
if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go
create proc spBuscarEscuela
	@Texto varchar(50),
	@Criterio varchar(50)
as
begin
	-- Busqueda exacta para el codigo de escuela
	if(@Criterio = 'CodEscuela')
		select CodEscuela, Escuela, Facultad from TEscuela where CodEscuela = @Texto
	--Busqueda sensitiva para el nombre de la escueka
	else if (@Criterio = 'Nombre')
		select Escuela, CodEscuela from TEscuela where Escuela like @Texto + '%'
	else if (@Criterio = 'Tipo')
		select Facultad, CodEscuela from TEscuela where Facultad like @Texto + '%'

	end
go

exec spListarEscuela
go

exec spBuscarEscuela 'E03','CodEscuela'
go 

exec spBuscarEscuela 'D', 'Nombre'
go 

exec spBuscarEscuela 'In', 'Tipo'
go 
-- Presentad para el día miercoles 10 de agosto a traves de aula virtual



