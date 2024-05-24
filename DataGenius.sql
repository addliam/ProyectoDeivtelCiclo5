-- Creacion de la BaseDatos
USE master
GO
CREATE DATABASE DataGenius
GO
USE DataGenius
-- 1. CREACION DE TABLAS

-- Nombre es UNICO
CREATE TABLE [Departamento] (
  [DepartamentoID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) UNIQUE NOT NULL
);

-- Nombre es UNICO
CREATE TABLE [Provincia] (
  [ProvinciaID] int PRIMARY KEY IDENTITY(1,1),
  [DepartamentoID] int NOT NULL,
  [Nombre] varchar(32) UNIQUE NOT NULL,
  CONSTRAINT [FK_Provincia.DepartamentoID]
    FOREIGN KEY ([DepartamentoID])
      REFERENCES [Departamento]([DepartamentoID])
);

-- Nombre es UNICO
CREATE TABLE [Distrito] (
  [DistritoID] int PRIMARY KEY IDENTITY(1,1),
  [ProvinciaID] int NOT NULL,
  [Nombre] varchar(32) UNIQUE NOT NULL,
  CONSTRAINT [FK_Distrito.ProvinciaID]
    FOREIGN KEY ([ProvinciaID])
      REFERENCES [Provincia]([ProvinciaID])
);

CREATE TABLE [Direccion] (
  [DireccionID] int PRIMARY KEY IDENTITY(1,1),
  [DistritoID] int NOT NULL,
  [Nombre] varchar(64) NOT NULL,
  [Referencia] varchar(64),
  CONSTRAINT [FK_Direccion.DistritoID]
    FOREIGN KEY ([DistritoID])
      REFERENCES [Distrito]([DistritoID])
);

-- Nombre como "ciclo 31"
-- Nombre es UNICO
CREATE TABLE [CicloFacturacion] (
  [CicloFacturacionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(20) UNIQUE NOT NULL,
  [DiaCiclico] int NOT NULL,
  [DiasAdicionalVencimiento] int NOT NULL,
  [DiasCorte] int NOT NULL
);

CREATE TABLE [Cliente] (
  [ClienteID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(50) NOT NULL,
  [ApPaterno] varchar(50) NOT NULL,
  [ApMaterno] varchar(50) NOT NULL,
  [FechaNacimiento] date,
  [TelefonoFijo] varchar(10),
  [Correo] varchar(64)
);

-- dni, visa, ce, ruc10, ruc20
-- Numero es UNICO
CREATE TABLE [TipoDocumentoIdentidad] (
  [TipoDocumentoIdentidadID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(128) UNIQUE NOT NULL
);

-- Numero es UNICO
-- ClienteID, TipoDocumentoIdentidadID - compose UNIQUE
CREATE TABLE [DocumentoIdentidad] (
  [DocumentoIdentidadID] int PRIMARY KEY IDENTITY(1,1),
  [TipoDocumentoIdentidadID] int NOT NULL,
  [ClienteID] int NOT NULL,
  [Numero] varchar(20) UNIQUE NOT NULL,
  CONSTRAINT [FK_DocumentoIdentidad.uq_ClienteID_TipoDocumentoIdentidadID]
    UNIQUE ([ClienteID],[TipoDocumentoIdentidadID]),
  CONSTRAINT [FK_DocumentoIdentidad.TipoDocumentoIdentidadID]
    FOREIGN KEY ([TipoDocumentoIdentidadID])
      REFERENCES [TipoDocumentoIdentidad]([TipoDocumentoIdentidadID]),
  CONSTRAINT [FK_DocumentoIdentidad.ClienteID]
    FOREIGN KEY ([ClienteID])
      REFERENCES [Cliente]([ClienteID])
);

-- Nombre es UNICO 
-- Cambio nombre de 'Plan' a 'PlanSuscripcion' para evitar conflicto con palabra reservada
CREATE TABLE [PlanSuscripcion] (
  [PlanSuscripcionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) UNIQUE NOT NULL,
  [PrecioCalculado] decimal(10,2) NOT NULL
);

-- Nombre es UNICO 
CREATE TABLE [Producto] (
  [ProductoID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) UNIQUE NOT NULL,
  [Descripcion] varchar(128) ,
  [Precio] decimal(6,2) NOT NULL
);

CREATE TABLE [DetallePlan] (
  [DetallePlanID] int PRIMARY KEY IDENTITY(1,1),
  [PlanSuscripcionID] int NOT NULL,
  [ProductoID] int NOT NULL,
  CONSTRAINT [FK_DetallePlan.ProductoID]
    FOREIGN KEY ([ProductoID])
      REFERENCES [Producto]([ProductoID]),
  CONSTRAINT [FK_DetallePlan.PlanSuscripcionID]
    FOREIGN KEY ([PlanSuscripcionID])
      REFERENCES [PlanSuscripcion]([PlanSuscripcionID])
);

-- 1:1 con CicloFacturacionID
-- 1:1 con DireccionID
CREATE TABLE [Suscripcion] (
  [SuscripcionID] int PRIMARY KEY IDENTITY(1,1),
  [DocumentoIdentidadID] int NOT NULL,
  [PlanSuscripcionID] int NOT NULL,
  [DireccionID] int UNIQUE NOT NULL,
  [CicloFacturacionID] int UNIQUE NOT NULL,
  [FechaVenta] date,
  [FechaInstalacion] date,
  CONSTRAINT [FK_Suscripcion.DireccionID]
    FOREIGN KEY ([DireccionID])
      REFERENCES [Direccion]([DireccionID]),
  CONSTRAINT [FK_Suscripcion.CicloFacturacionID]
    FOREIGN KEY ([CicloFacturacionID])
      REFERENCES [CicloFacturacion]([CicloFacturacionID]),
  CONSTRAINT [FK_Suscripcion.PlanSuscripcionID]
    FOREIGN KEY ([PlanSuscripcionID])
      REFERENCES [PlanSuscripcion]([PlanSuscripcionID]),
  CONSTRAINT [FK_Suscripcion.DocumentoIdentidadID]
    FOREIGN KEY ([DocumentoIdentidadID])
      REFERENCES [DocumentoIdentidad]([DocumentoIdentidadID])
);

-- estado suscrip
CREATE TABLE [EstadoSuscripcion] (
  [EstadoSuscripcionID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int UNIQUE,
  [Activo] bit DEFAULT 1,
  [FechaHora] datetime2(0) NOT NULL,
  CONSTRAINT [FK_EstadoSuscripcion.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID])
);

CREATE TABLE [Factura] (
  [FacturaID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int NOT NULL,
  [DiaInicio] date NOT NULL,
  [DiaFin] date NOT NULL,
  [DiaVencimiento] date NOT NULL,
  [FechaHoraEmision] datetime2(0) NOT NULL,
  [MontoCalculado] decimal(10,2) NOT NULL,
  CONSTRAINT [FK_Factura.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID])
);

CREATE TABLE [DetalleFactura] (
  [DetalleFacturaID] int PRIMARY KEY IDENTITY(1,1),
  [FacturaID] int NOT NULL,
  [ProductoID] int NOT NULL,
  [Precio] decimal(6,2) NOT NULL,
  [DiaInicio] date NOT NULL,
  [DiaFin] date NOT NULL,
  CONSTRAINT [FK_DetalleFactura.FacturaID]
    FOREIGN KEY ([FacturaID])
      REFERENCES [Factura]([FacturaID]),
  CONSTRAINT [FK_DetalleFactura.ProductoID]
    FOREIGN KEY ([ProductoID])
      REFERENCES [Producto]([ProductoID])
);

-- RELACION 1:N Factura-Pago porque pueden haber caso extremo de pagos parciales
CREATE TABLE [Pago] (
  [PagoID] int PRIMARY KEY IDENTITY(1,1),
  [FacturaID] int NOT NULL,
  [FechaHora] datetime2(0) NOT NULL,
  [MontoPago] decimal(10,2) NOT NULL,
  CONSTRAINT [FK_Pago.FacturaID]
    FOREIGN KEY ([FacturaID])
      REFERENCES [Factura]([FacturaID])
);

-- Nombre es UNICO 
CREATE TABLE [TipoComunicacion] (
  [TipoComunicacionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(128) UNIQUE NOT NULL,
  [Descripcion] varchar(128)
);

CREATE TABLE [Comunicacion] (
  [ComunicacionID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int NOT NULL,
  [TipoComunicacionID] int NOT NULL,
  [Mensaje] varchar(1024) NOT NULL,
  [FechaHora] datetime2(0) NOT NULL,
  CONSTRAINT [FK_Comunicacion.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID]),
  CONSTRAINT [FK_Comunicacion.TipoComunicacionID]
    FOREIGN KEY ([TipoComunicacionID])
      REFERENCES [TipoComunicacion]([TipoComunicacionID])
);

-- Recurso (nombre de tablas): producto, plan, cicloFacturacion.
-- Nombre es UNICO 
CREATE TABLE [Recurso] (
  [RecursoID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) UNIQUE NOT NULL
);

-- Operacion: crear, leer, actualizar, eliminar
CREATE TABLE [Operacion] (
  [OperacionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) UNIQUE NOT NULL
);

-- Rol: gerente, administrador, empleado.
-- Nombre es UNICO 
CREATE TABLE [Rol] (
  [RolID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) UNIQUE NOT NULL,
  [Descripcion] varchar(128)
);

CREATE TABLE [Permiso] (
  [PermisoID] int PRIMARY KEY IDENTITY(1,1),
  [OperacionID] int NOT NULL,
  [RolID] int NOT NULL,
  [RecursoID] int NOT NULL,
  CONSTRAINT [FK_Permiso.OperacionID]
    FOREIGN KEY ([OperacionID])
      REFERENCES [Operacion]([OperacionID]),
  CONSTRAINT [FK_Permiso.RecursoID]
    FOREIGN KEY ([RecursoID])
      REFERENCES [Recurso]([RecursoID]),
  CONSTRAINT [FK_Permiso.RolID]
    FOREIGN KEY ([RolID])
      REFERENCES [Rol]([RolID])
);

CREATE TABLE [Usuario] (
  [UsuarioID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(50) NOT NULL,
  [ApPaterno] varchar(50) NOT NULL,
  [ApMaterno] varchar(50) NOT NULL,
  [Correo] varchar(64) NOT NULL,
  [ContrasenaHash] varchar(128) NOT NULL
);

CREATE TABLE [EstadoUsuario] (
  [EstadoUsuarioID] int PRIMARY KEY IDENTITY(1,1),
  [UsuarioID] int UNIQUE NOT NULL,
  [Activo] bit DEFAULT 1,
  CONSTRAINT [FK_EstadoUsuario.UsuarioID]
    FOREIGN KEY ([UsuarioID])
      REFERENCES [Usuario]([UsuarioID])
);

-- Asigna un rol a cada cuenta para que pueda definir permisos de acceso a recursos
-- 1:1 con Usuario
CREATE TABLE [UsuarioRol] (
  [UsuarioRolID] int PRIMARY KEY IDENTITY(1,1),
  [UsuarioID] int NOT NULL,
  [RolID] int NOT NULL,
  CONSTRAINT [FK_UsuarioRol.RolID]
    FOREIGN KEY ([RolID])
      REFERENCES [Rol]([RolID]),
  CONSTRAINT [FK_UsuarioRol.UsuarioID]
    FOREIGN KEY ([UsuarioID])
      REFERENCES [Usuario]([UsuarioID])
);

-- 1:1 SuscripcionID 
CREATE TABLE [DetalleRouter] (
  [DetalleRouterID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int UNIQUE NOT NULL,
  [DireccionIP] varchar(128),
  [Usuario] varchar(32),
  [Contrasena] varchar(64),
  [VLAN] varchar(32),
  [NombreEquipo] varchar(32),
  [Marca] varchar(32),
  [Modelo] varchar(32),
  [MAC] varchar(20),
  [NumeroCajaNAP] varchar(16),
  CONSTRAINT [FK_DetalleRouter.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID])
);

-- Numero de Celular es UNIQUE
CREATE TABLE [Celular] (
  [CelularID] int PRIMARY KEY IDENTITY(1,1),
  [ClienteID] int NOT NULL,
  [Numero] varchar(15) UNIQUE NOT NULL,
  CONSTRAINT [FK_Celular.ClienteID]
    FOREIGN KEY ([ClienteID])
      REFERENCES [Cliente]([ClienteID])
);

-- Nombre es UNICO 
CREATE TABLE [CategoriaBitacoraAtencion] (
  [CategoriaBitacoraAtencionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(128) UNIQUE NOT NULL,
  [Descripcion] varchar(128)
);

CREATE TABLE [BitacoraAtencion] (
  [BitacoraAtencionID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int NOT NULL,
  [CategoriaBitacoraID] int NOT NULL,
  [Detalle] varchar(128),
  [UsuarioID] int NOT NULL,
  [FechaHora] datetime2(0) NOT NULL,
  CONSTRAINT [FK_BitacoraAtencion.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID]),
  CONSTRAINT [FK_BitacoraAtencion.CategoriaBitacoraID]
    FOREIGN KEY ([CategoriaBitacoraID])
      REFERENCES [CategoriaBitacoraAtencion]([CategoriaBitacoraAtencionID]),
  CONSTRAINT [FK_BitacoraAtencion.UsuarioID]
    FOREIGN KEY ([UsuarioID])
      REFERENCES [Usuario]([UsuarioID])
);
-- ok 16/05
-- TODO: Relaciones 1 a 1 y claves compuesta para evitar duplicados.
CREATE TABLE [Auditoria] (
  [AuditoriaID] int PRIMARY KEY IDENTITY(1,1),
  [FechaHora] datetime2(0) NOT NULL,
  [OperacionID] int NOT NULL,
  [UsuarioID] int NOT NULL,
  [NombreTabla] varchar(128),
  [IDTabla] int,
  [Descripcion] varchar(128),
  CONSTRAINT [FK_Auditoria.UsuarioID]
    FOREIGN KEY ([UsuarioID])
      REFERENCES [Usuario]([UsuarioID]),
  CONSTRAINT [FK_Auditoria.OperacionID]
    FOREIGN KEY ([OperacionID])
      REFERENCES [Operacion]([OperacionID])
);

-- 2. Inserts
USE DataGenius
GO
-- SET IDENTITY_INSERT.+ON 
SET IDENTITY_INSERT [dbo].[CategoriaBitacoraAtencion] ON 

INSERT [dbo].[CategoriaBitacoraAtencion] ([CategoriaBitacoraAtencionID], [Nombre], [Descripcion]) VALUES (1, N'Consulta deuda', N'Solicitud de información sobre el saldo pendiente o montos adeudados por el cliente')
INSERT [dbo].[CategoriaBitacoraAtencion] ([CategoriaBitacoraAtencionID], [Nombre], [Descripcion]) VALUES (2, N'Intento de baja', N'Contacto del cliente con la intención de cancelar el servicio, aunque no se concreta')
INSERT [dbo].[CategoriaBitacoraAtencion] ([CategoriaBitacoraAtencionID], [Nombre], [Descripcion]) VALUES (3, N'Baja del servicio', N'Proceso de cancelación definitiva del servicio contratado')
INSERT [dbo].[CategoriaBitacoraAtencion] ([CategoriaBitacoraAtencionID], [Nombre], [Descripcion]) VALUES (4, N'Actualización de datos personales', N'Solicitud para cambiar o actualizar información personal del cliente')
INSERT [dbo].[CategoriaBitacoraAtencion] ([CategoriaBitacoraAtencionID], [Nombre], [Descripcion]) VALUES (5, N'Consulta de facturación', N'Preguntas sobre la factura emitida, detalles de cobro, fechas de vencimiento, etc')
INSERT [dbo].[CategoriaBitacoraAtencion] ([CategoriaBitacoraAtencionID], [Nombre], [Descripcion]) VALUES (6, N'Problemas de conexión', N'Reportes sobre dificultades para conectarse a internet o interrupciones en el servicio')
INSERT [dbo].[CategoriaBitacoraAtencion] ([CategoriaBitacoraAtencionID], [Nombre], [Descripcion]) VALUES (7, N'Consulta sobre promociones', N'Preguntas sobre ofertas, descuentos o promociones vigentes')
INSERT [dbo].[CategoriaBitacoraAtencion] ([CategoriaBitacoraAtencionID], [Nombre], [Descripcion]) VALUES (8, N'Solicita soporte técnico', NULL)
SET IDENTITY_INSERT [dbo].[CategoriaBitacoraAtencion] OFF
GO
SET IDENTITY_INSERT [dbo].[CicloFacturacion] ON 

INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (1, N'ciclo 5', 6, 15, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (2, N'ciclo 17', 18, 15, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (3, N'ciclo 31', 1, 17, 5)
SET IDENTITY_INSERT [dbo].[CicloFacturacion] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoDocumentoIdentidad] ON 

INSERT [dbo].[TipoDocumentoIdentidad] ([TipoDocumentoIdentidadID], [Nombre]) VALUES (1, N'DNI')
INSERT [dbo].[TipoDocumentoIdentidad] ([TipoDocumentoIdentidadID], [Nombre]) VALUES (2, N'CE')
INSERT [dbo].[TipoDocumentoIdentidad] ([TipoDocumentoIdentidadID], [Nombre]) VALUES (3, N'RUC10')
INSERT [dbo].[TipoDocumentoIdentidad] ([TipoDocumentoIdentidadID], [Nombre]) VALUES (4, N'RUC20')
SET IDENTITY_INSERT [dbo].[TipoDocumentoIdentidad] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoComunicacion] ON 

INSERT [dbo].[TipoComunicacion] ([TipoComunicacionID], [Nombre], [Descripcion]) VALUES (1, N'SMS', N'Servicio de mensajería de texto que permite el intercambio de mensajes de texto ')
INSERT [dbo].[TipoComunicacion] ([TipoComunicacionID], [Nombre], [Descripcion]) VALUES (2, N'Correo', N'Correo electronico')
SET IDENTITY_INSERT [dbo].[TipoComunicacion] OFF
GO
SET IDENTITY_INSERT [dbo].[Departamento] ON 

INSERT [dbo].[Departamento] ([DepartamentoID], [Nombre]) VALUES (1, N'Lima')
SET IDENTITY_INSERT [dbo].[Departamento] OFF
GO
SET IDENTITY_INSERT [dbo].[Provincia] ON 

INSERT [dbo].[Provincia] ([ProvinciaID], [DepartamentoID], [Nombre]) VALUES (1, 1, N'Lima')
SET IDENTITY_INSERT [dbo].[Provincia] OFF
GO
SET IDENTITY_INSERT [dbo].[Distrito] ON 

INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (1, 1, N'Ancón');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (2, 1, N'Ate');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (3, 1, N'Barranco');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (4, 1, N'Breña');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (5, 1, N'Carabayllo');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (6, 1, N'Chaclacayo');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (7, 1, N'Chorrillos');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (8, 1, N'Cieneguilla');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (9, 1, N'Comas');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (10, 1, N'El Agustino');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (11, 1, N'Independencia');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (12, 1, N'Jesús María');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (13, 1, N'La Molina');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (14, 1, N'La Victoria');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (15, 1, N'Lima');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (16, 1, N'Lince');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (17, 1, N'Los Olivos');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (18, 1, N'Lurigancho');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (19, 1, N'Lurín');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (20, 1, N'Magdalena del Mar');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (21, 1, N'Miraflores');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (22, 1, N'Pachacámac');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (23, 1, N'Pucusana');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (24, 1, N'Pueblo Libre');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (25, 1, N'Puente Piedra');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (26, 1, N'Punta Hermosa');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (27, 1, N'Punta Negra');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (28, 1, N'Rímac');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (29, 1, N'San Bartolo');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (30, 1, N'San Borja');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (31, 1, N'San Isidro');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (32, 1, N'San Juan de Lurigancho');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (33, 1, N'San Juan de Miraflores');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (34, 1, N'San Luis');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (35, 1, N'San Martín de Porres');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (36, 1, N'San Miguel');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (37, 1, N'Santa Anita');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (38, 1, N'Santa María del Mar');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (39, 1, N'Santa Rosa');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (40, 1, N'Santiago de Surco');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (41, 1, N'Surquillo');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (42, 1, N'Villa El Salvador');
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (43, 1, N'Villa María del Triunfo');

SET IDENTITY_INSERT [dbo].[Distrito] OFF
GO

SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([RolID], [Nombre], [Descripcion]) VALUES (1, N'Administrador', N'Configura, mantiene y asegura el software.')
INSERT [dbo].[Rol] ([RolID], [Nombre], [Descripcion]) VALUES (2, N'Empleado', N'Usa el software para gestionar clientes y resolver consultas.')
SET IDENTITY_INSERT [dbo].[Rol] OFF
GO

SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (1, N'Adrian', N'Zevallos', N'Caceres', CAST(N'2000-03-01' AS Date), NULL, N'azevallos43@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (2, N'Alonso', N'Campos', N'Noriega', CAST(N'1997-08-14' AS Date), N'352384', N'camposnor97@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (3, N'Belen', N'Perez', N'Borja', CAST(N'2003-10-23' AS Date), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO

SET IDENTITY_INSERT [dbo].[Celular] ON 

INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (1, 1, N'902314788')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (2, 1, N'911111111')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (3, 2, N'911122222')
SET IDENTITY_INSERT [dbo].[Celular] OFF
GO
SET IDENTITY_INSERT [dbo].[DocumentoIdentidad] ON 

INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (1, 1, 1, N'75392782')
SET IDENTITY_INSERT [dbo].[DocumentoIdentidad] OFF
GO
-- operac
SET IDENTITY_INSERT [dbo].[Operacion] ON 

INSERT [dbo].[Operacion] ([OperacionID], [Nombre]) VALUES (3, N'Actualizar')
INSERT [dbo].[Operacion] ([OperacionID], [Nombre]) VALUES (1, N'Crear')
INSERT [dbo].[Operacion] ([OperacionID], [Nombre]) VALUES (4, N'Eliminar')
INSERT [dbo].[Operacion] ([OperacionID], [Nombre]) VALUES (2, N'Leer')
SET IDENTITY_INSERT [dbo].[Operacion] OFF
GO
-- recurso
SET IDENTITY_INSERT [dbo].[Recurso] ON 
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (1, N'EstadoUsuario');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (2, N'UsuarioRol');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (3, N'Auditoria');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (4, N'DetalleRouter');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (5, N'Celular');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (6, N'CategoriaBitacoraAtencion');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (7, N'BitacoraAtencion');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (8, N'Departamento');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (9, N'Provincia');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (10, N'Distrito');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (11, N'Direccion');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (12, N'CicloFacturacion');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (13, N'Cliente');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (14, N'TipoDocumentoIdentidad');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (15, N'DocumentoIdentidad');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (16, N'PlanSuscripcion');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (17, N'Producto');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (18, N'DetallePlan');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (19, N'Suscripcion');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (20, N'Factura');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (21, N'DetalleFactura');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (22, N'Pago');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (23, N'TipoComunicacion');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (24, N'Comunicacion');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (25, N'Recurso');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (26, N'Operacion');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (27, N'Rol');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (28, N'Permiso');
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (29, N'Usuario');

SET IDENTITY_INSERT [dbo].[Recurso] OFF
GO
-- permiso
SET IDENTITY_INSERT [dbo].[Permiso] ON 
-- EMPLEADO
-- Empleado puede Leer todos recursos excepto: Comunicacion, Recurso, Operacion, Rol, Permiso, Usuario
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (1, 2, 2, 1)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (2, 2, 2, 2)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (3, 2, 2, 3)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (4, 2, 2, 4)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (5, 2, 2, 5)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (6, 2, 2, 6)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (7, 2, 2, 7)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (8, 2, 2, 8)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (9, 2, 2, 9)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (10, 2, 2, 10)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (11, 2, 2, 11)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (12, 2, 2, 12)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (13, 2, 2, 13)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (14, 2, 2, 14)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (15, 2, 2, 15)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (16, 2, 2, 16)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (17, 2, 2, 17)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (18, 2, 2, 18)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (19, 2, 2, 19)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (20, 2, 2, 20)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (21, 2, 2, 21)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (22, 2, 2, 22)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (23, 2, 2, 23)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (24, 2, 2, 24)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (25, 2, 2, 25)
-- Crear: 1,5,6,8,12,14,16,20,25
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (26, 1, 2, 1)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (27, 1, 2, 5)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (28, 1, 2, 6)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (29, 1, 2, 8)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (30, 1, 2, 12)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (31, 1, 2, 14)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (32, 1, 2, 16)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (33, 1, 2, 20)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (34, 1, 2, 25)
-- Actualizar: 1,5,6,8,12,14,16,20,25
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (35, 3, 2, 1)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (36, 3, 2, 5)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (37, 3, 2, 6)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (38, 3, 2, 8)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (39, 3, 2, 12)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (40, 3, 2, 14)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (41, 3, 2, 16)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (42, 3, 2, 20)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (43, 3, 2, 25)
SET IDENTITY_INSERT [dbo].[Permiso] OFF
GO
-- usuario
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (1, N'Deivtel', N'Deivtel', N'Deivtel', N'deivtel@gmail.com', N'$2a$12$F/tJ/AOGqtV3bjrBE/k4i.2YFAMY566Ynj3my1gn6UWCt2h69qAoe')
INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (2, N'Fabian', N'Ocrospoma', N'Guzman', N'focrospoma@gmail.com', N'$2a$12$TPvxH4AwOIm6KoFnCOF1vufobCuZY9bMV3QTkWJEl0pdysH8NMpNS')
INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (4, N'Liam', N'Quiñones', N'Carhuaz', N'lquinones@gmail.com', N'$2a$12$TPvxH4AwOIm6KoFnCOF1vufobCuZY9bMV3QTkWJEl0pdysH8NMpNS')
INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (3, N'Piero', N'Cruz', N'Laos', N'pcruz@gmail.com', N'$2a$12$TPvxH4AwOIm6KoFnCOF1vufobCuZY9bMV3QTkWJEl0pdysH8NMpNS')
INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (5, N'Alex', N'Vargas', N'Tapia', N'avargas@gmail.com', N'$2a$12$TPvxH4AwOIm6KoFnCOF1vufobCuZY9bMV3QTkWJEl0pdysH8NMpNS')
INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (6, N'Fabian', N'Yataco', N'Pulido', N'fyataco@gmail.com', N'$2a$12$TPvxH4AwOIm6KoFnCOF1vufobCuZY9bMV3QTkWJEl0pdysH8NMpNS')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
-- usuario rol
SET IDENTITY_INSERT [dbo].[UsuarioRol] ON 

INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (1, 1, 1)
INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (2, 2, 2)
INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (3, 3, 2)
INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (5, 4, 2)
INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (6, 5, 2)
INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (7, 6, 2)
SET IDENTITY_INSERT [dbo].[UsuarioRol] OFF
GO
-- estado usuario
SET IDENTITY_INSERT [dbo].[EstadoUsuario] ON 

INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (1, 4, 0)
INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (2, 1, 1)
INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (3, 2, 1)
INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (4, 5, 1)
INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (5, 6, 1)
SET IDENTITY_INSERT [dbo].[EstadoUsuario] OFF
GO
-- productos
SET IDENTITY_INSERT [dbo].[Producto] ON 

INSERT [dbo].[Producto] ([ProductoID], [Nombre], [Descripcion], [Precio]) VALUES (1, N'TV 35', NULL, CAST(35.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([ProductoID], [Nombre], [Descripcion], [Precio]) VALUES (2, N'Internet 70 MB', NULL, CAST(50.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([ProductoID], [Nombre], [Descripcion], [Precio]) VALUES (3, N'Internet 50 MB', NULL, CAST(34.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([ProductoID], [Nombre], [Descripcion], [Precio]) VALUES (4, N'TV 10', NULL, CAST(10.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([ProductoID], [Nombre], [Descripcion], [Precio]) VALUES (5, N'Internet 80 MB', NULL, CAST(79.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([ProductoID], [Nombre], [Descripcion], [Precio]) VALUES (6, N'Internet 100 MB', NULL, CAST(99.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([ProductoID], [Nombre], [Descripcion], [Precio]) VALUES (7, N'TV 20', NULL, CAST(20.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([ProductoID], [Nombre], [Descripcion], [Precio]) VALUES (8, N'Internet 150 MB', NULL, CAST(129.00 AS Decimal(6, 2)))
INSERT [dbo].[Producto] ([ProductoID], [Nombre], [Descripcion], [Precio]) VALUES (9, N'Internet 200 MB', NULL, CAST(179.00 AS Decimal(6, 2)))
SET IDENTITY_INSERT [dbo].[Producto] OFF
GO
-- plan
SET IDENTITY_INSERT [dbo].[PlanSuscripcion] ON 

INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (1, N'Mono TV', CAST(35.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (2, N'Internet 70 MB', CAST(50.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (3, N'Duo 50 MB', CAST(69.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (4, N'Internet 80 MB', CAST(79.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (5, N'Duo 80 MB', CAST(89.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (6, N'Internet 100 MB', CAST(99.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (7, N'Duo 100 MB', CAST(119.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (8, N'Internet 150 MB', CAST(129.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (9, N'Duo 150 MB', CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (10, N'Internet 200 MB', CAST(179.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (11, N'Duo 200 MB', CAST(199.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[PlanSuscripcion] OFF
GO
-- detalle plan
SET IDENTITY_INSERT [dbo].[DetallePlan] ON 

INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (1, 1, 1)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (2, 2, 2)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (3, 3, 1)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (4, 3, 3)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (5, 4, 5)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (6, 5, 4)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (7, 5, 5)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (8, 6, 6)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (9, 7, 6)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (10, 7, 7)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (11, 8, 8)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (12, 9, 8)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (13, 9, 7)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (14, 10, 9)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (15, 11, 9)
INSERT [dbo].[DetallePlan] ([DetallePlanID], [PlanSuscripcionID], [ProductoID]) VALUES (16, 11, 7)
SET IDENTITY_INSERT [dbo].[DetallePlan] OFF
GO
-- direccion
SET IDENTITY_INSERT [dbo].[Direccion] ON 

INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (1, 32, N'Av. Las Flores 1234, Apt. 567, Canto Rey', N'A 1 cuadra del grifo Primax')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (2, 32, N'Jirón Las Lomas 456, Canto Grande', N'Detrás del centro comercial')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (3, 32, N'Av. Las Flores de Primavera 123, Canto Grande', N'Al costado del banco, casa 3 pisos, fachada Blanca')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (4, 32, N'Calle Los Jardines 120, Canto Grande', N'Cerca del colegio')
SET IDENTITY_INSERT [dbo].[Direccion] OFF
GO
-- suscrip
SET IDENTITY_INSERT [dbo].[Suscripcion] ON 

INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (1, 1, 9, 1, 1, CAST(N'2024-01-01' AS Date), CAST(N'2024-01-05' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (2, 1, 4, 2, 3, CAST(N'2024-04-15' AS Date), CAST(N'2023-10-24' AS Date))
SET IDENTITY_INSERT [dbo].[Suscripcion] OFF
GO
-- estado suscrip
SET IDENTITY_INSERT [dbo].[EstadoSuscripcion] ON 

INSERT [dbo].[EstadoSuscripcion] ([EstadoSuscripcionID], [SuscripcionID], [Activo], [FechaHora]) VALUES (1, 1, 1, CAST(N'2024-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EstadoSuscripcion] ([EstadoSuscripcionID], [SuscripcionID], [Activo], [FechaHora]) VALUES (2, 2, 1, CAST(N'2024-04-15T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[EstadoSuscripcion] OFF
GO
-- detalle router
SET IDENTITY_INSERT [dbo].[DetalleRouter] ON 

INSERT [dbo].[DetalleRouter] ([DetalleRouterID], [SuscripcionID], [DireccionIP], [Usuario], [Contrasena], [VLAN], [NombreEquipo], [Marca], [Modelo], [MAC], [NumeroCajaNAP]) VALUES (1, 1, N'192.168.111.251', N'AdrianZevallos', N'12344321', N'111', NULL, N'Fibertronics', N'FT-504XWC', N'6C02E00A0207', N'C5-Z22')
SET IDENTITY_INSERT [dbo].[DetalleRouter] OFF
GO
-- factura
SET IDENTITY_INSERT [dbo].[Factura] ON 

INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (1, 1, CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date), CAST(N'2024-02-21' AS Date), CAST(N'2024-01-09T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Factura] OFF
GO
-- detalle factura
SET IDENTITY_INSERT [dbo].[DetalleFactura] ON 

INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (1, 1, 7, CAST(20.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (2, 1, 8, CAST(129.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
SET IDENTITY_INSERT [dbo].[DetalleFactura] OFF
GO
-- comunicac
SET IDENTITY_INSERT [dbo].[Comunicacion] ON 

INSERT [dbo].[Comunicacion] ([ComunicacionID], [SuscripcionID], [TipoComunicacionID], [Mensaje], [FechaHora]) VALUES (1, 1, 2, N'Estimado/a Adrian Zevallos, su recibo vence el 21-02-2024. Monto: S/ 149.00. Evite suspensión, pague a tiempo. - DEIVTEL', CAST(N'2024-01-10T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Comunicacion] OFF
GO
-- pago
SET IDENTITY_INSERT [dbo].[Pago] ON 

INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (1, 1, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Pago] OFF
GO
-- bitacora atx
SET IDENTITY_INSERT [dbo].[BitacoraAtencion] ON 

INSERT [dbo].[BitacoraAtencion] ([BitacoraAtencionID], [SuscripcionID], [CategoriaBitacoraID], [Detalle], [UsuarioID], [FechaHora]) VALUES (1, 1, 1, N'Consulta deuda', 2, CAST(N'2024-02-12T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[BitacoraAtencion] OFF
GO
-- auditoria
SET IDENTITY_INSERT [dbo].[Auditoria] ON 

INSERT [dbo].[Auditoria] ([AuditoriaID], [FechaHora], [OperacionID], [UsuarioID], [NombreTabla], [IDTabla], [Descripcion]) VALUES (1, CAST(N'2024-02-10T00:00:00.0000000' AS DateTime2), 3, 2, N'Cliente', 1, N'Empleado actualizo info del cl.')
SET IDENTITY_INSERT [dbo].[Auditoria] OFF
GO

-- 3. Indices
-- Nomenclatura: IX_MyTable_MyColumn_AnotherColumn 
USE DataGenius
GO
CREATE NONCLUSTERED INDEX IX_DocumentoIdentidad_Numero ON
[dbo].[DocumentoIdentidad](Numero);
GO
CREATE NONCLUSTERED INDEX IX_Usuario_Correo ON
[dbo].[Usuario](Correo);
GO
CREATE NONCLUSTERED INDEX IX_Usuario_Nombre ON
[dbo].[CicloFacturacion](Nombre);
GO
CREATE NONCLUSTERED INDEX IX_Celular_Numero ON
[dbo].[Celular](Numero);
GO

-- 4. Vistas
USE DataGenius
GO
CREATE VIEW v_PermisoDetalle
AS
SELECT P.[PermisoID]
      ,O.Nombre AS Operacion
      ,RO.Nombre AS Rol
      ,RE.Nombre AS Recurso
  FROM [DataGenius].[dbo].[Permiso] P
  JOIN Operacion O ON O.OperacionID=P.OperacionID
  JOIN Rol RO ON RO.RolID = P.RolID
  JOIN Recurso RE ON RE.RecursoID = P.RecursoID
GO

CREATE VIEW v_DetallePlanProducto
AS
SELECT DP.DetallePlanID,
PL.Nombre 'Plan',
PL.PrecioCalculado 'Plan precio',
PR.Nombre 'Producto',
PR.Precio 'Producto precio'
FROM DetallePlan DP
JOIN [dbo].[PlanSuscripcion] PL ON PL.PlanSuscripcionID=DP.PlanSuscripcionID
JOIN [dbo].[Producto] PR ON PR.ProductoID=DP.ProductoID
GO

CREATE VIEW v_SuscripcionDetalle
AS
SELECT SU.SuscripcionID,
TDOC.Nombre Documento,
DI.Numero NumeroDocumento,
CONCAT(CL.Nombre, CL.ApPaterno, CL.ApMaterno) Cliente,
PL.Nombre PlanNombre,
PL.PrecioCalculado Precio,
DIR.Nombre Direccion,
CF.Nombre CicloFacturacion,
SU.FechaVenta,
SU.FechaInstalacion
FROM Suscripcion SU
JOIN DocumentoIdentidad DI ON DI.DocumentoIdentidadID = SU.DocumentoIdentidadID
JOIN Cliente CL ON CL.ClienteID = DI.ClienteID
JOIN TipoDocumentoIdentidad TDOC ON TDOC.TipoDocumentoIdentidadID=DI.TipoDocumentoIdentidadID
JOIN PlanSuscripcion PL ON PL.PlanSuscripcionID = SU.PlanSuscripcionID
JOIN Direccion DIR ON DIR.DireccionID = SU.DireccionID
JOIN CicloFacturacion CF ON CF.CicloFacturacionID = SU.CicloFacturacionID
GO
CREATE VIEW v_AuditoriaDetalle
AS
SELECT AU.AuditoriaID, 
AU.FechaHora, 
OP.Nombre,
CONCAT(US.Nombre, US.ApPaterno, US.ApMaterno) Usuario,
AU.NombreTabla,
AU.IDTabla,
AU.Descripcion
FROM Auditoria AU
JOIN Operacion OP ON OP.OperacionID = AU.OperacionID
JOIN Usuario US ON US.UsuarioID = AU.UsuarioID
GO