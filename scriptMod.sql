-- Creacion de la BaseDatos
CREATE DATABASE DataGenius
GO
USE DataGenius
-- Valor por defecto en 0 (FALSE)
CREATE TABLE [Permiso] (
  [PermisoID] int PRIMARY KEY IDENTITY(1,1),
  [PuedeCrearUsuario] bit DEFAULT 0,
  [PuedeCrearPlan] bit DEFAULT 0,
  [PuedeCrearProducto] bit DEFAULT 0,
  [PuedeCrearCicloFacturacion] bit DEFAULT 0,
  [PuedeCrearUbicacionGeografica] bit DEFAULT 0
);

-- Relacion 1:1 Rol-Permiso
CREATE TABLE [Rol] (
  [RolID] int PRIMARY KEY IDENTITY(1,1),
  [PermisoID] int UNIQUE,
  [Nombre] varchar(32) NOT NULL,
    CONSTRAINT [FK_Rol.PermisoID]
    FOREIGN KEY ([PermisoID])
      REFERENCES [Permiso]([PermisoID])
);

CREATE TABLE [Usuario] (
  [UsuarioID] int PRIMARY KEY IDENTITY(1,1),
  [RolID] int,
  [Nombre] varchar(50) NOT NULL,
  [ApPaterno] varchar(50) NOT NULL,
  [ApMaterno] varchar(50) NOT NULL,
  [Celular] varchar(15),
  [Correo] varchar(64) NOT NULL,
  [ContrasenaHash] varchar(100) NULL,
  CONSTRAINT [FK_Usuario.RolID]
    FOREIGN KEY ([RolID])
      REFERENCES [Rol]([RolID])
);

-- OK 1
CREATE TABLE [Cliente] (
  [ClienteID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(50) NOT NULL,
  [ApPaterno] varchar(50) NOT NULL,
  [ApMaterno] varchar(50) NOT NULL,
  [Celular] varchar(15),
  [Correo] varchar(64)
);

-- 1:N Cliente-Celular
-- Numero de Celular es UNIQUE
CREATE TABLE [Celular] (
  [CelularID] int PRIMARY KEY IDENTITY(1,1),
  [ClienteID] int,
  [Numero] varchar(15) UNIQUE NOT NULL,
  CONSTRAINT [FK_Celular.ClienteID]
    FOREIGN KEY ([ClienteID])
      REFERENCES [Cliente]([ClienteID])
);

CREATE TABLE [DocumentoIdentidad] (
  [DocumentoIdentidadID] int PRIMARY KEY IDENTITY(1,1),
  [ClienteId] int,
  [Nombre] varchar(128) NOT NULL,
  [Valor] varchar(20) NOT NULL,
  CONSTRAINT [FK_DocumentoIdentidad.ClienteId]
    FOREIGN KEY ([ClienteId])
      REFERENCES [Cliente]([ClienteID])
);

-- OK 2
CREATE TABLE [CicloFacturacion] (
  [CicloFacturacionID] int PRIMARY KEY IDENTITY(1,1),
  [DiaCiclico] int NOT NULL,
  [DiasAdicionalVencimiento] int NOT NULL,
  [DiasCorte] int NOT NULL
);

CREATE TABLE [Departamento] (
  [DepartamentoID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) NOT NULL
);

CREATE TABLE [Provincia] (
  [ProvinciaID] int PRIMARY KEY IDENTITY(1,1),
  [DepartamentoID] int,
  [Nombre] varchar(32) NOT NULL,
  CONSTRAINT [FK_Provincia.DepartamentoID]
    FOREIGN KEY ([DepartamentoID])
      REFERENCES [Departamento]([DepartamentoID])
);

CREATE TABLE [PropsInternet] (
  [PropsInternetID] int PRIMARY KEY IDENTITY(1,1),
  [Velocidad] int NOT NULL,
  [TipoConexion] varchar(16) NOT NULL,
  [AnchoBanda] int NULL
);

-- OK 3
CREATE TABLE [PropsCable] (
  [PropsCableID] int PRIMARY KEY IDENTITY(1,1),
  [CantidadCanales] int NULL,
  [TipoConexion] varchar(16) NOT NULL,
  [CalidadImagen] varchar(16) NULL
);

CREATE TABLE [Plan] (
  [PlanID] int PRIMARY KEY IDENTITY(1,1),
  [DetallePlanID] int,
  [Nombre] varchar(32) NOT NULL
);
-- OK 4
CREATE TABLE [Producto] (
  [ProductoID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) NOT NULL,
  [Precio] decimal(6,2) NOT NULL,
  [PropsInternetID] int NULL,
  [PropsCableID] int NULL,
  CONSTRAINT [FK_Producto.PropsInternetID]
    FOREIGN KEY ([PropsInternetID])
      REFERENCES [PropsInternet]([PropsInternetID]),
  CONSTRAINT [FK_Producto.PropsCableID]
    FOREIGN KEY ([PropsCableID])
      REFERENCES [PropsCable]([PropsCableID])
);
-- OK 5
CREATE TABLE [DetallePlan] (
  [DetallePlanID] int PRIMARY KEY IDENTITY(1,1),
  [PlanID] int,
  [ProductoID] int,
  CONSTRAINT [FK_DetallePlan.ProductoID]
    FOREIGN KEY ([ProductoID])
      REFERENCES [Producto]([ProductoID]),
  CONSTRAINT [FK_DetallePlan.PlanID]
    FOREIGN KEY ([PlanID])
      REFERENCES [Plan]([PlanID])
);
-- OK 6
CREATE TABLE [Distrito] (
  [DistritoID] int PRIMARY KEY IDENTITY(1,1),
  [ProvinciaID] int,
  [Nombre] varchar(32) NOT NULL,
  CONSTRAINT [FK_Distrito.ProvinciaID]
    FOREIGN KEY ([ProvinciaID])
      REFERENCES [Provincia]([ProvinciaID])
);

CREATE TABLE [Direccion] (
  [DireccionID] int PRIMARY KEY IDENTITY(1,1),
  [DistritoID] int,
  [Nombre] varchar(64) NOT NULL,
  [Referencia] varchar(64),
  CONSTRAINT [FK_Direccion.DistritoID]
    FOREIGN KEY ([DistritoID])
      REFERENCES [Distrito]([DistritoID])
);

-- OK 7
CREATE TABLE [Suscripcion] (
  [SuscripcionID] int PRIMARY KEY IDENTITY(1,1),
  [DocumentoIdentidadID] int,
  [PlanID] int,
  [DireccionID] int,
  [CicloFacturacionID] int,
  CONSTRAINT [FK_Suscripcion.DocumentoIdentidadID]
    FOREIGN KEY ([DocumentoIdentidadID])
      REFERENCES [DocumentoIdentidad]([DocumentoIdentidadID]),
  CONSTRAINT [FK_Suscripcion.DireccionID]
    FOREIGN KEY ([DireccionID])
      REFERENCES [Direccion]([DireccionID]),
  CONSTRAINT [FK_Suscripcion.PlanID]
    FOREIGN KEY ([PlanID])
      REFERENCES [Plan]([PlanID]),
  CONSTRAINT [FK_Suscripcion.CicloFacturacionID]
    FOREIGN KEY ([CicloFacturacionID])
      REFERENCES [CicloFacturacion]([CicloFacturacionID])
);

CREATE TABLE [DetalleRouter] (
  [DetalleRouterID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int,
  [DireccionIP] varchar(128),
  [Usuario] varchar(32),
  [Contrasena] varchar(64),
  [VLAN] varchar(32),
  [NombreEquipo] varchar(32),
  [Marca] varchar(32),
  [Modelo] varchar(32),
  [MAC] varchar(16),
  [NumeroCajaNAP] varchar(16),
  CONSTRAINT [FK_DetalleRouter.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID])
);

CREATE TABLE [Factura] (
  [FacturaID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int UNIQUE,
  [DiaInicio] date NOT NULL,
  [DiaFin] date NOT NULL,
  [DiaVencimiento] date NOT NULL,
  [FechaHoraEmision] datetime2(0) NOT NULL,
  [MontoCalculado] decimal(10,2) NOT NULL,
  CONSTRAINT [FK_Factura.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID])
);

-- RELACION 1:N Factura-Pago porque pueden haber caso extremo de pagos parciales
CREATE TABLE [Pago] (
  [PagoID] int PRIMARY KEY IDENTITY(1,1),
  [FacturaID] int,
  [FechaHora] datetime2(0) NOT NULL,
  [MontoPago] decimal(10,2) NOT NULL,
  CONSTRAINT [FK_Pago.FacturaID]
    FOREIGN KEY ([FacturaID])
      REFERENCES [Factura]([FacturaID])
);
-- OK

CREATE TABLE [CategoriaBitacoraAtencion] (
  [CategoriaBitacoraAtencionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(128),
  [Descripcion] varchar(128)
);

CREATE TABLE [BitacoraAtencion] (
  [BitacoraAtencionID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int,
  [CategoriaBitacoraID] int,
  [Detalle] varchar(128),
  [UsuarioID] int,
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
-- PEND
CREATE TABLE [CategoriaAuditoria] (
  [CategoriaAuditoriaID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(128),
  [Descripcion] varchar(128)
);

CREATE TABLE [Auditoria] (
  [AuditoriaID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int,
  [UsuarioID] int,
  [CategoriaAuditoriaID] int,
  [FechaHora] datetime2(0) NOT NULL,
  CONSTRAINT [FK_Auditoria.CategoriaAuditoriaID]
    FOREIGN KEY ([CategoriaAuditoriaID])
      REFERENCES [CategoriaAuditoria]([CategoriaAuditoriaID]),
  CONSTRAINT [FK_Auditoria.UsuarioID]
    FOREIGN KEY ([UsuarioID])
      REFERENCES [Usuario]([UsuarioID]),
  CONSTRAINT [FK_Auditoria.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID])
);
-- PEND
CREATE TABLE [TipoComunicacion] (
  [TipoComunicacionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(128),
  [Descripcion] varchar(128)
);

CREATE TABLE [Comunicacion] (
  [ComunicacionID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int,
  [TipoComunicacionID] int,
  [Mensaje] varchar(255),
  [FechaHora] datetime2(0) NOT NULL,
  CONSTRAINT [FK_Comunicacion.TipoComunicacionID]
    FOREIGN KEY ([TipoComunicacionID])
      REFERENCES [TipoComunicacion]([TipoComunicacionID]),
  CONSTRAINT [FK_Comunicacion.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID])
);
-- ALL OK 01/05
-- Control de roles y permisos
