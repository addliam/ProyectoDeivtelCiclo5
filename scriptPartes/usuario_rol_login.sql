USE master;
GO
-- CREACION DE LOGIN
CREATE LOGIN Empleado WITH PASSWORD='Empleado2024'
GO
USE pubs;
GO
-- CREACION DE USER 
CREATE USER Empleado FOR LOGIN Empleado
GO
-- ASIGNAR PERMISOS PARA TABLAS
-- 1. TABLA: EMPLOYEE
GRANT SELECT ON [dbo].[employee] TO Empleado 
-- 2. TABLA: JOBS
GRANT SELECT ON [dbo].[jobs] TO Empleado 
-- EJEMPLO DE QUITAR PERMISOS DE INSERCION
DENY INSERT ON [dbo].[jobs] TO Empleado

-- PROBAR PERMISOS
/*
-- 1. TABLA: EMPLOYEE
SELECT * FROM employee
-- 2. TABLA: JOBS
SELECT * FROM jobs
INSERT INTO [pubs].[dbo].[jobs] ([job_id] ,[job_desc] ,[min_lvl] ,[max_lvl])
	VALUES (1, 'Nuevo trabajo', 10,	10);
*/
