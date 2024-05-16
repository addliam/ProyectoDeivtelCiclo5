-- Creacion de la BaseDatos
CREATE DATABASE DataGenius
GO
USE DataGenius
-- Tablas
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

-- Nombre como "ciclo 31"
CREATE TABLE [CicloFacturacion] (
  [CicloFacturacionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(20) NOT NULL,
  [DiaCiclico] int NOT NULL,
  [DiasAdicionalVencimiento] int NOT NULL,
  [DiasCorte] int NOT NULL
);

CREATE TABLE [Persona] (
  [PersonaID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(50) NOT NULL,
  [ApPaterno] varchar(50) NOT NULL,
  [ApMaterno] varchar(50) NOT NULL
);

CREATE TABLE [Cliente] (
  [ClienteID] int PRIMARY KEY IDENTITY(1,1),
  [PersonaID] int,
  [FechaNacimiento] date,
  [Correo] varchar(64),
  CONSTRAINT [FK_Cliente.PersonaID]
    FOREIGN KEY ([PersonaID])
      REFERENCES [Persona]([PersonaID])
);

-- dni, visa, ce, ruc10, ruc20
CREATE TABLE [TipoDocumentoIdentidad] (
  [TipoDocumentoIdentidadID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(128) NOT NULL
);

CREATE TABLE [DocumentoIdentidad] (
  [DocumentoIdentidadID] int PRIMARY KEY IDENTITY(1,1),
  [TipoDocumentoIdentidadID] int,
  [ClienteID] int,
  [Numero] varchar(20) NOT NULL,
  CONSTRAINT [FK_DocumentoIdentidad.TipoDocumentoIdentidadID]
    FOREIGN KEY ([TipoDocumentoIdentidadID])
      REFERENCES [TipoDocumentoIdentidad]([TipoDocumentoIdentidadID]),
  CONSTRAINT [FK_DocumentoIdentidad.ClienteID]
    FOREIGN KEY ([ClienteID])
      REFERENCES [Cliente]([ClienteID])
);
CREATE TABLE [Plan] (
  [PlanID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) NOT NULL,
  [PrecioCalculado] decimal(10,2) NOT NULL
);

CREATE TABLE [Producto] (
  [ProductoID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) NOT NULL,
  [Descripcion] varchar(128) ,
  [Precio] decimal(6,2) NOT NULL
);

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

CREATE TABLE [Suscripcion] (
  [SuscripcionID] int PRIMARY KEY IDENTITY(1,1),
  [DocumentoIdentidadID] int,
  [PlanID] int,
  [DireccionID] int,
  [CicloFacturacionID] int,
  [FechaVenta] date,
  [FechaInstalacion] date,
  CONSTRAINT [FK_Suscripcion.DireccionID]
    FOREIGN KEY ([DireccionID])
      REFERENCES [Direccion]([DireccionID]),
  CONSTRAINT [FK_Suscripcion.CicloFacturacionID]
    FOREIGN KEY ([CicloFacturacionID])
      REFERENCES [CicloFacturacion]([CicloFacturacionID]),
  CONSTRAINT [FK_Suscripcion.PlanID]
    FOREIGN KEY ([PlanID])
      REFERENCES [Plan]([PlanID]),
  CONSTRAINT [FK_Suscripcion.DocumentoIdentidadID]
    FOREIGN KEY ([DocumentoIdentidadID])
      REFERENCES [DocumentoIdentidad]([DocumentoIdentidadID])
);

CREATE TABLE [Factura] (
  [FacturaID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int,
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
  [FacturaID] int,
  [ProductoID] int,
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
  [FacturaID] int,
  [FechaHora] datetime2(0) NOT NULL,
  [MontoPago] decimal(10,2) NOT NULL,
  CONSTRAINT [FK_Pago.FacturaID]
    FOREIGN KEY ([FacturaID])
      REFERENCES [Factura]([FacturaID])
);

CREATE TABLE [TipoComunicacion] (
  [TipoComunicacionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(128) NOT NULL,
  [Descripcion] varchar(128)
);

CREATE TABLE [Comunicacion] (
  [ComunicacionID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int,
  [TipoComunicacionID] int,
  [Mensaje] varchar(255),
  [FechaHora] datetime2(0) NOT NULL,
  CONSTRAINT [FK_Comunicacion.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID]),
  CONSTRAINT [FK_Comunicacion.TipoComunicacionID]
    FOREIGN KEY ([TipoComunicacionID])
      REFERENCES [TipoComunicacion]([TipoComunicacionID])
);
-- Recurso (nombre de tablas): producto, plan, cicloFacturacion.
CREATE TABLE [Recurso] (
  [RecursoID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) UNIQUE
);

-- Operacion: crear, leer, actualizar, eliminar
CREATE TABLE [Operacion] (
  [OperacionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) UNIQUE
);

-- Rol: gerente, administrador, empleado.
CREATE TABLE [Rol] (
  [RolID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(32) NOT NULL,
  [Descripcion] varchar(128)
);

CREATE TABLE [Permiso] (
  [PermisoID] int PRIMARY KEY IDENTITY(1,1),
  [OperacionID] int,
  [RolID] int,
  [RecursoID] int,
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

-- Usuario se refiere a la cuenta, que tiene "username" y "password"
CREATE TABLE [Usuario] (
  [UsuarioID] int PRIMARY KEY IDENTITY(1,1),
  [NombreUsuario] varchar(100) NOT NULL,
  [ContrasenaHash] varchar(64) NOT NULL
);

-- Asigna un rol a cada cuenta para que pueda definir permisos de acceso a recursos
-- Clave primaria compuesta
CREATE TABLE [UsuarioRol] (
  [UsuarioID] int,
  [RolID] int,
  CONSTRAINT [PK_UsuarioRol.UsuarioID_RolID]
    PRIMARY KEY ([UsuarioID], [RolID]),
  CONSTRAINT [FK_UsuarioRol.RolID]
    FOREIGN KEY ([RolID])
      REFERENCES [Rol]([RolID]),
  CONSTRAINT [FK_UsuarioRol.UsuarioID]
    FOREIGN KEY ([UsuarioID])
      REFERENCES [Usuario]([UsuarioID])
);

CREATE TABLE [Empleado] (
  [EmpleadoID] int PRIMARY KEY IDENTITY(1,1),
  [PersonaID] int,
  [UsuarioID] int,
  [Estado] bit DEFAULT 1,
  CONSTRAINT [FK_Empleado.PersonaID]
    FOREIGN KEY ([PersonaID])
      REFERENCES [Persona]([PersonaID]),
  CONSTRAINT [FK_Empleado.UsuarioID]
    FOREIGN KEY ([UsuarioID])
      REFERENCES [Usuario]([UsuarioID])
);

CREATE TABLE [CategoriaAuditoria] (
  [CategoriaAuditoriaID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(128) NOT NULL,
  [Descripcion] varchar(128)
);

CREATE TABLE [Auditoria] (
  [AuditoriaID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int,
  [EmpleadoID] int,
  [CategoriaAuditoriaID] int,
  [FechaHora] datetime2(0) NOT NULL,
  CONSTRAINT [FK_Auditoria.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID]),
  CONSTRAINT [FK_Auditoria.CategoriaAuditoriaID]
    FOREIGN KEY ([CategoriaAuditoriaID])
      REFERENCES [CategoriaAuditoria]([CategoriaAuditoriaID]),
  CONSTRAINT [FK_Auditoria.EmpleadoID]
    FOREIGN KEY ([EmpleadoID])
      REFERENCES [Empleado]([EmpleadoID])
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

-- Numero de Celular es UNIQUE
CREATE TABLE [Celular] (
  [CelularID] int PRIMARY KEY IDENTITY(1,1),
  [PersonaID] int,
  [Numero] varchar(15) UNIQUE NOT NULL,
  CONSTRAINT [FK_Celular.PersonaID]
    FOREIGN KEY ([PersonaID])
      REFERENCES [Persona]([PersonaID])
);

CREATE TABLE [CategoriaBitacoraAtencion] (
  [CategoriaBitacoraAtencionID] int PRIMARY KEY IDENTITY(1,1),
  [Nombre] varchar(128) NOT NULL,
  [Descripcion] varchar(128)
);

CREATE TABLE [BitacoraAtencion] (
  [BitacoraAtencionID] int PRIMARY KEY IDENTITY(1,1),
  [SuscripcionID] int,
  [CategoriaBitacoraID] int,
  [Detalle] varchar(128),
  [EmpleadoID] int,
  [FechaHora] datetime2(0) NOT NULL,
  CONSTRAINT [FK_BitacoraAtencion.SuscripcionID]
    FOREIGN KEY ([SuscripcionID])
      REFERENCES [Suscripcion]([SuscripcionID]),
  CONSTRAINT [FK_BitacoraAtencion.CategoriaBitacoraID]
    FOREIGN KEY ([CategoriaBitacoraID])
      REFERENCES [CategoriaBitacoraAtencion]([CategoriaBitacoraAtencionID]),
  CONSTRAINT [FK_BitacoraAtencion.EmpleadoID]
    FOREIGN KEY ([EmpleadoID])
      REFERENCES [Empleado]([EmpleadoID])
);
-- ok 16/05
-- TODO: Relaciones 1 a 1 y claves compuesta para evitar duplicados.