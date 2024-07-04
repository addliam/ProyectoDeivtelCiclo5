use DataGenius

---- Login ----

CREATE LOGIN Empleado WITH PASSWORD = 'BDDataGenius2024'

---- USER ---- Roles Base Datos
CREATE USER Empleado FOR LOGIN Empleado

CREATE LOGIN AdministradorDB WITH PASSWORD = 'BDDataGenius2024'

---- USER ---- Roles Base Datos
CREATE USER AdministradorDB FOR LOGIN AdministradorDB



---- Select ----
GRANT SELECT ON [DetalleRouter] To Empleado
GRANT SELECT ON [Celular] To Empleado
GRANT SELECT ON [CategoriaBitacoraAtencion] To Empleado
GRANT SELECT ON [BitacoraAtencion] To Empleado
GRANT SELECT ON [Departamento] To Empleado
GRANT SELECT ON [Provincia] To Empleado
GRANT SELECT ON [Distrito] To Empleado
GRANT SELECT ON [CicloFacturacion] To Empleado
GRANT SELECT ON [Cliente] To Empleado
GRANT SELECT ON [TipoDocumentoIdentidad] To Empleado
GRANT SELECT ON [DocumentoIdentidad] To Empleado
GRANT SELECT ON [PlanSuscripcion] To Empleado
GRANT SELECT ON [Producto] To Empleado
GRANT SELECT ON [DetallePlan] To Empleado
GRANT SELECT ON [Suscripcion] To Empleado
GRANT SELECT ON [Factura] To Empleado
GRANT SELECT ON [DetalleFactura] To Empleado
GRANT SELECT ON [Pago] To Empleado
GRANT SELECT ON [TipoComunicacion] To Empleado
GRANT SELECT ON [Comunicacion] To Empleado
GRANT SELECT ON [Recurso] To Empleado

---- Insert ----
GRANT INSERT ON [EstadoUsuario] To Empleado
GRANT INSERT ON [Celular] To Empleado
GRANT INSERT ON [CategoriaBitacoraAtencion] To Empleado
GRANT INSERT ON [Departamento] To Empleado
GRANT INSERT ON [CicloFacturacion] To Empleado
GRANT INSERT ON [TipoDocumentoIdentidad] To Empleado
GRANT INSERT ON [PlanSuscripcion] To Empleado
GRANT INSERT ON [Factura] To Empleado
GRANT INSERT ON [Recurso] To Empleado

---- Update ----
GRANT UPDATE ON [EstadoUsuario] To Empleado
GRANT UPDATE ON [Celular] To Empleado
GRANT UPDATE ON [CategoriaBitacoraAtencion] To Empleado
GRANT UPDATE ON [Departamento] To Empleado
GRANT UPDATE ON [CicloFacturacion] To Empleado
GRANT UPDATE ON [TipoDocumentoIdentidad] To Empleado
GRANT UPDATE ON [PlanSuscripcion] To Empleado
GRANT UPDATE ON [Factura] To Empleado
GRANT UPDATE ON [Recurso] To Empleado

---- Permisos del AdministradorDB ----
ALTER ROLE db_owner ADD MEMBER [AdministradorDB];


---- Auditoria de eventos ----
Use master
CREATE SERVER AUDIT AuditoriaInicioSesion
TO FILE (FILEPATH = 'C:\Registro de Auditorias\', MAXSIZE = 100 MB);
ALTER SERVER AUDIT AuditoriaInicioSesion WITH (STATE = ON);

---- Ver registro de Auditoria ----
