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