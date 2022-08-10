-- Base de datos Ejemplo
-- Pool Andre
-- 8/8/2022

use BDUniversidad
go

if DB_ID('DBUniversidad') is not null
	drop database BDUniversidad
go
create database BDUniversidad
go

use BDUniversidad
go


-- Crear tablas
if OBJECT_ID('TEscuela') is not null
	drop table TEscuela
go
create table TEscuela
(
	CodEscuela char(3) primary key,
	Escuela varchar(50),
	Facultad varchar(50)
)
go

if OBJECT_ID('TAlumnno') is not null
	drop table TAlumno
go
create table TAlumno
(
	CodAlumno char(5) primary key,
	Apellidos varchar(50),
	Nombres varchar(50),
	LugarNac varchar(50),
	FechaNac datetime,
	CodEscuela char(3),
	foreign key (CodEscuela) references TEscuela
)
go

-- Inserción de datos DE TEscuela
insert into TEscuela values('E01','Sistemas','Ingenieria')
insert into TEscuela values('E02','Civil','Ingenieria')
insert into TEscuela values('E03','Industrial','Ingenieria')
insert into TEscuela values('E04','Ambiental','Ingenieria')
insert into TEscuela values('E05','Arquitectura','Ingenieria')
go


-- Inserción de datos TAlumno

insert into TAlumno values('A01','Salva','Pool','Cusco','2022','E01')
insert into TAlumno values('A02','Palomino','Andre','Cusco','12/07/2022','E02')
insert into TAlumno values('A03','Perez','Juan','Cusco','09/07/2022','E03')
insert into TAlumno values('A04','Coaquira','Ernesto','Cusco','12/03/2022','E04')
go

select * from TEscuela
go

select * from TAlumno
go