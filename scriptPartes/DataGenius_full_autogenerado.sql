USE [master]
GO
/****** Object:  Database [DataGenius]    Script Date: 02/07/2024 05:47:07 p.m. ******/
CREATE DATABASE [DataGenius]
GO
ALTER DATABASE [DataGenius] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DataGenius].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DataGenius] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DataGenius] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DataGenius] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DataGenius] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DataGenius] SET ARITHABORT OFF 
GO
ALTER DATABASE [DataGenius] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DataGenius] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DataGenius] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DataGenius] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DataGenius] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DataGenius] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DataGenius] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DataGenius] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DataGenius] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DataGenius] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DataGenius] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DataGenius] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DataGenius] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DataGenius] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DataGenius] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DataGenius] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DataGenius] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DataGenius] SET RECOVERY FULL 
GO
ALTER DATABASE [DataGenius] SET  MULTI_USER 
GO
ALTER DATABASE [DataGenius] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DataGenius] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DataGenius] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DataGenius] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DataGenius] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DataGenius] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DataGenius', N'ON'
GO
ALTER DATABASE [DataGenius] SET QUERY_STORE = ON
GO
ALTER DATABASE [DataGenius] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DataGenius]
GO
/****** Object:  User [Empleado]    Script Date: 02/07/2024 05:47:07 p.m. ******/
CREATE USER [Empleado] FOR LOGIN [Empleado] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [AdministradorDB]    Script Date: 02/07/2024 05:47:07 p.m. ******/
CREATE USER [AdministradorDB] FOR LOGIN [AdministradorDB] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [AdministradorDB]
GO
/****** Object:  Table [dbo].[Recurso]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recurso](
	[RecursoID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RecursoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Operacion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Operacion](
	[OperacionID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OperacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[RolID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](32) NOT NULL,
	[Descripcion] [varchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[RolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permiso]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permiso](
	[PermisoID] [int] IDENTITY(1,1) NOT NULL,
	[OperacionID] [int] NOT NULL,
	[RolID] [int] NOT NULL,
	[RecursoID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PermisoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_PermisoDetalle]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_PermisoDetalle]
AS
SELECT 
    P.PermisoID,
    O.Nombre AS Operacion,
    RO.Nombre AS Rol,
    RE.Nombre AS Recurso
FROM 
    Permiso P
JOIN 
    Operacion O ON O.OperacionID = P.OperacionID
JOIN 
    Rol RO ON RO.RolID = P.RolID
JOIN 
    Recurso RE ON RE.RecursoID = P.RecursoID;
GO
/****** Object:  Table [dbo].[PlanSuscripcion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlanSuscripcion](
	[PlanSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](32) NOT NULL,
	[PrecioCalculado] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PlanSuscripcionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producto](
	[ProductoID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](32) NOT NULL,
	[Descripcion] [varchar](128) NULL,
	[Precio] [decimal](6, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetallePlan]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetallePlan](
	[DetallePlanID] [int] IDENTITY(1,1) NOT NULL,
	[PlanSuscripcionID] [int] NOT NULL,
	[ProductoID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DetallePlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_PlanProductoDetalle]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_PlanProductoDetalle]
AS
SELECT 
    DP.DetallePlanID,
    PL.Nombre AS 'Plan',
    PL.PrecioCalculado AS 'Plan precio',
    PR.Nombre AS 'Producto',
    PR.Precio AS 'Producto precio'
FROM 
    DetallePlan DP
JOIN 
    PlanSuscripcion PL ON PL.PlanSuscripcionID = DP.PlanSuscripcionID
JOIN 
    Producto PR ON PR.ProductoID = DP.ProductoID;
GO
/****** Object:  Table [dbo].[Direccion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direccion](
	[DireccionID] [int] IDENTITY(1,1) NOT NULL,
	[DistritoID] [int] NOT NULL,
	[Nombre] [varchar](64) NOT NULL,
	[Referencia] [varchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[DireccionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CicloFacturacion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CicloFacturacion](
	[CicloFacturacionID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](20) NOT NULL,
	[DiaCiclico] [int] NOT NULL,
	[DiasAdicionalVencimiento] [int] NOT NULL,
	[DiasCorte] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CicloFacturacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[ClienteID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ApPaterno] [varchar](50) NOT NULL,
	[ApMaterno] [varchar](50) NOT NULL,
	[FechaNacimiento] [date] NULL,
	[TelefonoFijo] [varchar](10) NULL,
	[Correo] [varchar](64) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClienteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoDocumentoIdentidad]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoDocumentoIdentidad](
	[TipoDocumentoIdentidadID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TipoDocumentoIdentidadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentoIdentidad]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentoIdentidad](
	[DocumentoIdentidadID] [int] IDENTITY(1,1) NOT NULL,
	[TipoDocumentoIdentidadID] [int] NOT NULL,
	[ClienteID] [int] NOT NULL,
	[Numero] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DocumentoIdentidadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suscripcion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suscripcion](
	[SuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[DocumentoIdentidadID] [int] NOT NULL,
	[PlanSuscripcionID] [int] NOT NULL,
	[DireccionID] [int] NOT NULL,
	[CicloFacturacionID] [int] NOT NULL,
	[FechaVenta] [date] NULL,
	[FechaInstalacion] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[SuscripcionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_SuscripcionDetalle]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_SuscripcionDetalle]
AS
SELECT 
    SU.SuscripcionID,
    TDOC.Nombre AS Documento,
    DI.Numero AS NumeroDocumento,
    CONCAT(CL.Nombre, ' ', CL.ApPaterno, ' ', CL.ApMaterno) AS Cliente,
    PL.Nombre AS PlanNombre,
    PL.PrecioCalculado AS Precio,
    DIR.Nombre AS Direccion,
    CF.Nombre AS CicloFacturacion,
    SU.FechaVenta,
    SU.FechaInstalacion
FROM 
    Suscripcion SU
JOIN 
    DocumentoIdentidad DI ON DI.DocumentoIdentidadID = SU.DocumentoIdentidadID
JOIN 
    Cliente CL ON CL.ClienteID = DI.ClienteID
JOIN 
    TipoDocumentoIdentidad TDOC ON TDOC.TipoDocumentoIdentidadID = DI.TipoDocumentoIdentidadID
JOIN 
    PlanSuscripcion PL ON PL.PlanSuscripcionID = SU.PlanSuscripcionID
JOIN 
    Direccion DIR ON DIR.DireccionID = SU.DireccionID
JOIN 
    CicloFacturacion CF ON CF.CicloFacturacionID = SU.CicloFacturacionID;
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[UsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[ApPaterno] [varchar](50) NOT NULL,
	[ApMaterno] [varchar](50) NOT NULL,
	[Correo] [varchar](64) NOT NULL,
	[ContrasenaHash] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Auditoria]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Auditoria](
	[AuditoriaID] [int] IDENTITY(1,1) NOT NULL,
	[FechaHora] [datetime2](0) NOT NULL,
	[OperacionID] [int] NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[NombreTabla] [varchar](128) NULL,
	[IDTabla] [int] NULL,
	[Descripcion] [varchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[AuditoriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_AuditoriaDetalle]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_AuditoriaDetalle]
AS
SELECT 
    AU.AuditoriaID, 
    AU.FechaHora, 
    OP.Nombre AS Operacion,
    CONCAT(US.Nombre, ' ', US.ApPaterno, ' ', US.ApMaterno) AS Usuario,
    AU.NombreTabla,
    AU.IDTabla,
    AU.Descripcion
FROM 
    Auditoria AU
JOIN 
    Operacion OP ON OP.OperacionID = AU.OperacionID
JOIN 
    Usuario US ON US.UsuarioID = AU.UsuarioID;
GO
/****** Object:  Table [dbo].[TipoComunicacion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoComunicacion](
	[TipoComunicacionID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](128) NOT NULL,
	[Descripcion] [varchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[TipoComunicacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comunicacion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comunicacion](
	[ComunicacionID] [int] IDENTITY(1,1) NOT NULL,
	[SuscripcionID] [int] NOT NULL,
	[TipoComunicacionID] [int] NOT NULL,
	[Mensaje] [varchar](1024) NOT NULL,
	[FechaHora] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ComunicacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_ComunicacionDetalle]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_ComunicacionDetalle]
AS
SELECT 
    CO.ComunicacionID, 
    CONCAT(CL.Nombre, ' ', CL.ApPaterno, ' ', CL.ApMaterno) AS Cliente,
    CL.Correo, 
    TC.Nombre AS TipoComunicacion,
    CO.Mensaje,
    CO.FechaHora
FROM 
    Comunicacion CO
JOIN 
    TipoComunicacion TC ON TC.TipoComunicacionID = CO.TipoComunicacionID
JOIN 
    Suscripcion SU ON SU.SuscripcionID = CO.SuscripcionID
JOIN 
    DocumentoIdentidad DI ON DI.DocumentoIdentidadID = SU.DocumentoIdentidadID
JOIN 
    Cliente CL ON CL.ClienteID = DI.ClienteID;
GO
/****** Object:  Table [dbo].[CategoriaBitacoraAtencion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriaBitacoraAtencion](
	[CategoriaBitacoraAtencionID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](128) NOT NULL,
	[Descripcion] [varchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoriaBitacoraAtencionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BitacoraAtencion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BitacoraAtencion](
	[BitacoraAtencionID] [int] IDENTITY(1,1) NOT NULL,
	[SuscripcionID] [int] NOT NULL,
	[CategoriaBitacoraID] [int] NOT NULL,
	[Detalle] [varchar](128) NULL,
	[UsuarioID] [int] NOT NULL,
	[FechaHora] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BitacoraAtencionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_BitacoraAtencionDetalle]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_BitacoraAtencionDetalle]
AS
SELECT 
    BA.BitacoraAtencionID, 
    BA.SuscripcionID, 
    CBA.Nombre AS Categoria,
    BA.Detalle,
    CONCAT(US.Nombre, ' ', US.ApPaterno, ' ', US.ApMaterno) AS Usuario
FROM 
    BitacoraAtencion BA
JOIN 
    Usuario US ON US.UsuarioID = BA.UsuarioID
JOIN 
    CategoriaBitacoraAtencion CBA ON CBA.CategoriaBitacoraAtencionID = BA.CategoriaBitacoraID;
GO
/****** Object:  Table [dbo].[EstadoUsuario]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoUsuario](
	[EstadoUsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[Activo] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[EstadoUsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioRol]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioRol](
	[UsuarioRolID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[RolID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioRolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_UsuarioDetalle]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_UsuarioDetalle]
AS
SELECT 
    US.UsuarioID, 
    CONCAT(US.Nombre, ' ', US.ApPaterno, ' ', US.ApMaterno) AS Usuario,
    US.Correo,
    RO.Nombre AS Rol,
    CASE 
        WHEN EUS.Activo = 1 THEN 'Activo' 
        ELSE 'Inactivo' 
    END AS Estado
FROM 
    Usuario US
JOIN 
    UsuarioRol UR ON UR.UsuarioID = US.UsuarioID
JOIN 
    Rol RO ON RO.RolID = UR.RolID
LEFT JOIN 
    EstadoUsuario EUS ON EUS.UsuarioID = US.UsuarioID;
GO
/****** Object:  Table [dbo].[Departamento]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departamento](
	[DepartamentoID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartamentoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provincia](
	[ProvinciaID] [int] IDENTITY(1,1) NOT NULL,
	[DepartamentoID] [int] NOT NULL,
	[Nombre] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProvinciaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Distrito]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Distrito](
	[DistritoID] [int] IDENTITY(1,1) NOT NULL,
	[ProvinciaID] [int] NOT NULL,
	[Nombre] [varchar](32) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DistritoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_DireccionDetalle]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_DireccionDetalle]
AS
SELECT 
    DIR.DireccionID,
    DIR.Nombre,
    DIR.Referencia,
    DIS.Nombre AS Distrito,
    PROV.Nombre AS Provincia,
    DEP.Nombre AS Departamento
FROM 
    Direccion DIR
JOIN 
    Distrito DIS ON DIS.DistritoID = DIR.DistritoID
JOIN 
    Provincia PROV ON PROV.ProvinciaID = DIS.ProvinciaID
JOIN 
    Departamento DEP ON DEP.DepartamentoID = PROV.DepartamentoID;
GO
/****** Object:  Table [dbo].[DetalleRouter]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleRouter](
	[DetalleRouterID] [int] IDENTITY(1,1) NOT NULL,
	[SuscripcionID] [int] NOT NULL,
	[DireccionIP] [varchar](128) NULL,
	[Usuario] [varchar](32) NULL,
	[Contrasena] [varchar](64) NULL,
	[VLAN] [varchar](32) NULL,
	[NombreEquipo] [varchar](32) NULL,
	[Marca] [varchar](32) NULL,
	[Modelo] [varchar](32) NULL,
	[MAC] [varchar](20) NULL,
	[NumeroCajaNAP] [varchar](16) NULL,
PRIMARY KEY CLUSTERED 
(
	[DetalleRouterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_DetalleRouter]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_DetalleRouter]
AS
SELECT 
    * 
FROM 
    DetalleRouter;
GO
/****** Object:  Table [dbo].[Celular]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Celular](
	[CelularID] [int] IDENTITY(1,1) NOT NULL,
	[ClienteID] [int] NOT NULL,
	[Numero] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CelularID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DetalleFactura]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleFactura](
	[DetalleFacturaID] [int] IDENTITY(1,1) NOT NULL,
	[FacturaID] [int] NOT NULL,
	[ProductoID] [int] NOT NULL,
	[Precio] [decimal](6, 2) NOT NULL,
	[DiaInicio] [date] NOT NULL,
	[DiaFin] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DetalleFacturaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadoSuscripcion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoSuscripcion](
	[EstadoSuscripcionID] [int] IDENTITY(1,1) NOT NULL,
	[SuscripcionID] [int] NULL,
	[Activo] [bit] NULL,
	[FechaHora] [datetime2](0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EstadoSuscripcionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Factura]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](
	[FacturaID] [int] IDENTITY(1,1) NOT NULL,
	[SuscripcionID] [int] NOT NULL,
	[DiaInicio] [date] NOT NULL,
	[DiaFin] [date] NOT NULL,
	[DiaVencimiento] [date] NOT NULL,
	[FechaHoraEmision] [datetime2](0) NOT NULL,
	[MontoCalculado] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FacturaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pago]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pago](
	[PagoID] [int] IDENTITY(1,1) NOT NULL,
	[FacturaID] [int] NOT NULL,
	[FechaHora] [datetime2](0) NOT NULL,
	[MontoPago] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PagoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Auditoria] ON 

INSERT [dbo].[Auditoria] ([AuditoriaID], [FechaHora], [OperacionID], [UsuarioID], [NombreTabla], [IDTabla], [Descripcion]) VALUES (1, CAST(N'2024-02-10T00:00:00.0000000' AS DateTime2), 3, 2, N'Cliente', 1, N'Empleado actualizo info del cl.')
SET IDENTITY_INSERT [dbo].[Auditoria] OFF
GO
SET IDENTITY_INSERT [dbo].[BitacoraAtencion] ON 

INSERT [dbo].[BitacoraAtencion] ([BitacoraAtencionID], [SuscripcionID], [CategoriaBitacoraID], [Detalle], [UsuarioID], [FechaHora]) VALUES (1, 1, 1, N'Consulta deuda', 2, CAST(N'2024-02-12T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[BitacoraAtencion] OFF
GO
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
SET IDENTITY_INSERT [dbo].[Celular] ON 

INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (1, 1, N'902314788')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (2, 1, N'911111111')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (3, 2, N'911122222')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (4, 2, N'911133333')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (5, 3, N'911144444')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (6, 3, N'911155555')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (7, 4, N'911166666')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (8, 4, N'911177777')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (9, 5, N'911188888')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (10, 5, N'911199999')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (11, 6, N'911200000')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (12, 6, N'911211111')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (13, 7, N'911222222')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (14, 7, N'911233333')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (15, 8, N'911244444')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (16, 8, N'911255555')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (17, 9, N'911266666')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (18, 9, N'911277777')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (19, 10, N'911288888')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (20, 10, N'911299999')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (21, 11, N'911300000')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (22, 11, N'911311111')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (23, 12, N'911322222')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (24, 12, N'911333333')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (25, 13, N'911344444')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (26, 13, N'911355555')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (27, 14, N'911366666')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (28, 14, N'911377777')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (29, 15, N'911388888')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (30, 15, N'911399999')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (31, 16, N'911400000')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (32, 16, N'911411111')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (33, 17, N'911422222')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (34, 17, N'911433333')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (35, 18, N'911444444')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (36, 18, N'911455555')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (37, 19, N'911466666')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (38, 19, N'911477777')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (39, 20, N'911488888')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (40, 20, N'911499999')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (41, 21, N'911500000')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (42, 21, N'911511111')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (43, 22, N'911522222')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (44, 22, N'911533333')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (45, 23, N'911544444')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (46, 23, N'911555555')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (47, 24, N'911566666')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (48, 24, N'911577777')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (49, 25, N'911588888')
INSERT [dbo].[Celular] ([CelularID], [ClienteID], [Numero]) VALUES (50, 25, N'911599999')
SET IDENTITY_INSERT [dbo].[Celular] OFF
GO
SET IDENTITY_INSERT [dbo].[CicloFacturacion] ON 

INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (1, N'ciclo 5', 6, 15, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (2, N'ciclo 17', 18, 15, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (3, N'ciclo 31', 1, 17, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (4, N'ciclo 10', 11, 12, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (5, N'ciclo 12', 13, 14, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (6, N'ciclo 14', 15, 16, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (7, N'ciclo 16', 17, 18, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (8, N'ciclo 18', 19, 20, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (9, N'ciclo 20', 21, 22, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (10, N'ciclo 22', 23, 24, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (11, N'ciclo 24', 25, 26, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (12, N'ciclo 26', 27, 28, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (13, N'ciclo 28', 29, 30, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (14, N'ciclo 30', 31, 32, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (15, N'ciclo 32', 1, 33, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (16, N'ciclo 34', 3, 34, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (17, N'ciclo 36', 5, 35, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (18, N'ciclo 38', 7, 36, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (19, N'ciclo 40', 9, 37, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (20, N'ciclo 42', 11, 38, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (21, N'ciclo 44', 13, 39, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (22, N'ciclo 46', 15, 40, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (23, N'ciclo 48', 17, 41, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (24, N'ciclo 50', 19, 42, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (25, N'ciclo 52', 21, 43, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (26, N'ciclo 54', 23, 44, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (27, N'ciclo 56', 25, 45, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (28, N'ciclo 58', 27, 46, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (29, N'ciclo 60', 29, 47, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (30, N'ciclo 62', 31, 48, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (31, N'ciclo 64', 2, 49, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (32, N'ciclo 66', 4, 50, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (33, N'ciclo 68', 6, 51, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (34, N'ciclo 70', 8, 52, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (35, N'ciclo 72', 10, 53, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (36, N'ciclo 74', 12, 54, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (37, N'ciclo 76', 14, 55, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (38, N'ciclo 78', 16, 56, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (39, N'ciclo 80', 18, 57, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (40, N'ciclo 82', 20, 58, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (41, N'ciclo 84', 22, 59, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (42, N'ciclo 86', 24, 60, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (43, N'ciclo 88', 26, 61, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (44, N'ciclo 90', 28, 62, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (45, N'ciclo 92', 30, 63, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (46, N'ciclo 94', 1, 64, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (47, N'ciclo 96', 3, 65, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (48, N'ciclo 98', 5, 66, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (49, N'ciclo 100', 7, 67, 5)
INSERT [dbo].[CicloFacturacion] ([CicloFacturacionID], [Nombre], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (50, N'ciclo 102', 9, 68, 5)
SET IDENTITY_INSERT [dbo].[CicloFacturacion] OFF
GO
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (1, N'Adrian', N'Zevallos', N'Caceres', CAST(N'2000-03-01' AS Date), NULL, N'azevallos43@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (2, N'Alonso', N'Campos', N'Noriega', CAST(N'1997-08-14' AS Date), N'352384', N'camposnor97@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (3, N'Belen', N'Perez', N'Borja', CAST(N'2003-10-23' AS Date), NULL, NULL)
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (4, N'Carlos', N'Gomez', N'Martinez', CAST(N'1990-05-21' AS Date), N'485293', N'cgomez90@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (5, N'Diana', N'Flores', N'Lopez', CAST(N'1988-12-11' AS Date), NULL, N'dflores88@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (6, N'Elena', N'Ramos', N'Mendoza', CAST(N'1995-06-07' AS Date), N'284937', N'eramos95@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (7, N'Fernando', N'Castro', N'Vega', CAST(N'1992-04-15' AS Date), NULL, N'fcastro92@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (8, N'Gabriela', N'Ruiz', N'Torres', CAST(N'1999-09-27' AS Date), N'657384', N'gruiz99@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (9, N'Hector', N'Sanchez', N'Paredes', CAST(N'1985-01-03' AS Date), NULL, N'hsanchez85@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (10, N'Isabel', N'Martinez', N'Guzman', CAST(N'1993-11-19' AS Date), N'492857', N'imartinez93@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (11, N'Javier', N'Vargas', N'Morales', CAST(N'1980-07-30' AS Date), NULL, N'jvargas80@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (12, N'Karen', N'Guzman', N'Rojas', CAST(N'1987-02-22' AS Date), N'948372', N'kguzman87@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (13, N'Luis', N'Paredes', N'Herrera', CAST(N'1991-10-13' AS Date), NULL, N'lparedes91@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (14, N'Mariana', N'Torres', N'Silva', CAST(N'2000-12-05' AS Date), N'573829', N'mtorres00@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (15, N'Nicolas', N'Lopez', N'Mendez', CAST(N'1998-08-09' AS Date), NULL, N'nlopez98@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (16, N'Olga', N'Jimenez', N'Chavez', CAST(N'1975-03-14' AS Date), N'293857', N'ojimenez75@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (17, N'Pablo', N'Mendoza', N'Romero', CAST(N'1994-07-18' AS Date), NULL, N'pmendoza94@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (18, N'Quintin', N'Castillo', N'Iglesias', CAST(N'1986-11-23' AS Date), N'384756', N'qcastillo86@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (19, N'Raquel', N'Soto', N'Fernandez', CAST(N'1997-01-07' AS Date), NULL, N'rsoto97@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (20, N'Sebastian', N'Vela', N'Campos', CAST(N'1996-06-12' AS Date), N'584736', N'svela96@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (21, N'Tatiana', N'Bravo', N'Nieves', CAST(N'2002-04-28' AS Date), NULL, N'tbravo02@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (22, N'Ulises', N'Carranza', N'Quispe', CAST(N'1989-05-17' AS Date), N'695738', N'ucarranza89@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (23, N'Valeria', N'Fernandez', N'Cruz', CAST(N'1992-09-04' AS Date), NULL, N'vfernandez92@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (24, N'Walter', N'Herrera', N'Saavedra', CAST(N'1995-02-20' AS Date), N'472839', N'wherrera95@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (25, N'Ximena', N'Iglesias', N'Velarde', CAST(N'1983-12-15' AS Date), NULL, N'xiglesias83@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (26, N'Yolanda', N'Juarez', N'Zambrano', CAST(N'1990-08-29' AS Date), N'283945', N'yjuarez90@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (27, N'Zoe', N'Kim', N'Murillo', CAST(N'2001-11-06' AS Date), NULL, N'zkim01@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (28, N'Ana', N'Martinez', N'Jimenez', CAST(N'1994-09-10' AS Date), NULL, N'amartinez94@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (29, N'Benjamin', N'Gonzalez', N'Sanchez', CAST(N'1998-07-25' AS Date), N'627485', N'bgonzalez98@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (30, N'Catalina', N'Rivera', N'Garcia', CAST(N'1989-04-18' AS Date), NULL, N'crivera89@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (31, N'Diego', N'Hernandez', N'Rodriguez', CAST(N'1996-11-03' AS Date), N'485739', N'dhernandez96@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (32, N'Estela', N'Molina', N'Luna', CAST(N'1987-08-22' AS Date), NULL, N'emolina87@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (33, N'Felipe', N'Valencia', N'Dominguez', CAST(N'1992-03-15' AS Date), N'573829', N'fvalencia92@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (34, N'Gloria', N'Gutierrez', N'Ortega', CAST(N'1985-12-08' AS Date), NULL, N'ggutierrez85@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (35, N'Hugo', N'Moreno', N'Velasquez', CAST(N'1991-10-27' AS Date), N'695738', N'hmoreno91@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (36, N'Ines', N'Santos', N'Rojas', CAST(N'1999-05-14' AS Date), NULL, N'isantos99@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (37, N'Jorge', N'Peralta', N'Flores', CAST(N'1983-02-07' AS Date), N'284937', N'jperalta83@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (38, N'Karina', N'Cruz', N'Ramirez', CAST(N'1997-09-30' AS Date), NULL, N'kcruz97@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (39, N'Luisa', N'Mendoza', N'Castillo', CAST(N'1988-06-23' AS Date), N'384756', N'lmendoza88@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (40, N'Marco', N'Ortega', N'Guerra', CAST(N'1995-04-12' AS Date), NULL, N'mortega95@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (41, N'Natalia', N'Fernandez', N'Chavez', CAST(N'1984-01-05' AS Date), N'472839', N'nfernandez84@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (42, N'Oscar', N'Rios', N'Vargas', CAST(N'1993-08-18' AS Date), NULL, N'orios93@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (43, N'Paola', N'Gomez', N'Salazar', CAST(N'1990-05-09' AS Date), N'293857', N'pgomez90@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (44, N'Quirino', N'Jimenez', N'Perez', CAST(N'1986-12-29' AS Date), NULL, N'qjimenez86@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (45, N'Rocio', N'Sanchez', N'Cabrera', CAST(N'1998-11-16' AS Date), N'283945', N'rsanchez98@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (46, N'Santiago', N'Vega', N'Martinez', CAST(N'1987-10-07' AS Date), NULL, N'svega87@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (47, N'Teresa', N'Lopez', N'Gutierrez', CAST(N'1994-07-21' AS Date), N'911222', N'tlopez94@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (48, N'Uriel', N'Fernandez', N'Moreno', CAST(N'1989-04-14' AS Date), NULL, N'uflores89@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (49, N'Vanessa', N'Perez', N'Velazquez', CAST(N'1996-01-27' AS Date), N'657384', N'vperez96@gmail.com')
INSERT [dbo].[Cliente] ([ClienteID], [Nombre], [ApPaterno], [ApMaterno], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (50, N'Walter', N'Ramirez', N'Soto', CAST(N'1983-08-18' AS Date), NULL, N'wramirez83@gmail.com')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[Comunicacion] ON 

INSERT [dbo].[Comunicacion] ([ComunicacionID], [SuscripcionID], [TipoComunicacionID], [Mensaje], [FechaHora]) VALUES (1, 1, 2, N'Estimado/a Adrian Zevallos, su recibo vence el 21-02-2024. Monto: S/ 149.00. Evite suspensión, pague a tiempo. - DEIVTEL', CAST(N'2024-01-10T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[Comunicacion] OFF
GO
SET IDENTITY_INSERT [dbo].[Departamento] ON 

INSERT [dbo].[Departamento] ([DepartamentoID], [Nombre]) VALUES (1, N'Lima')
SET IDENTITY_INSERT [dbo].[Departamento] OFF
GO
SET IDENTITY_INSERT [dbo].[DetalleFactura] ON 

INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (1, 1, 7, CAST(20.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (2, 2, 6, CAST(99.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (3, 3, 8, CAST(129.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (4, 4, 9, CAST(179.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (5, 5, 1, CAST(35.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (6, 6, 2, CAST(50.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (7, 7, 3, CAST(34.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (8, 8, 4, CAST(10.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (9, 9, 5, CAST(79.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (10, 10, 6, CAST(99.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (11, 11, 7, CAST(20.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (12, 12, 8, CAST(129.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (13, 13, 9, CAST(179.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (14, 14, 1, CAST(35.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (15, 15, 2, CAST(50.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (16, 16, 3, CAST(34.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (17, 17, 4, CAST(10.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (18, 18, 5, CAST(79.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (19, 19, 6, CAST(99.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (20, 20, 7, CAST(20.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (21, 21, 8, CAST(129.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (22, 22, 9, CAST(179.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (23, 23, 1, CAST(35.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (24, 24, 2, CAST(50.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (25, 25, 3, CAST(34.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (26, 26, 4, CAST(10.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (27, 27, 5, CAST(79.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (28, 28, 6, CAST(99.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (29, 29, 7, CAST(20.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (30, 30, 8, CAST(129.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (31, 31, 9, CAST(179.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (32, 32, 1, CAST(35.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (33, 33, 2, CAST(50.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (34, 34, 3, CAST(34.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (35, 35, 4, CAST(10.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (36, 36, 5, CAST(79.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (37, 37, 6, CAST(99.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (38, 38, 7, CAST(20.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (39, 39, 8, CAST(129.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (40, 40, 9, CAST(179.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (41, 41, 1, CAST(35.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (42, 42, 2, CAST(50.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (43, 43, 3, CAST(34.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
INSERT [dbo].[DetalleFactura] ([DetalleFacturaID], [FacturaID], [ProductoID], [Precio], [DiaInicio], [DiaFin]) VALUES (44, 44, 4, CAST(10.00 AS Decimal(6, 2)), CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date))
SET IDENTITY_INSERT [dbo].[DetalleFactura] OFF
GO
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
SET IDENTITY_INSERT [dbo].[DetalleRouter] ON 

INSERT [dbo].[DetalleRouter] ([DetalleRouterID], [SuscripcionID], [DireccionIP], [Usuario], [Contrasena], [VLAN], [NombreEquipo], [Marca], [Modelo], [MAC], [NumeroCajaNAP]) VALUES (1, 1, N'192.168.111.251', N'AdrianZevallos', N'12344321', N'111', N'XOPU ONU CON CATV', N'Fibertronics', N'FT-504XWC', N'6C02E00A0207', N'C5-Z22')
SET IDENTITY_INSERT [dbo].[DetalleRouter] OFF
GO
SET IDENTITY_INSERT [dbo].[Direccion] ON 

INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (1, 32, N'Av. Las Flores 1234, Apt. 567, Canto Rey', N'A 1 cuadra del grifo Primax')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (2, 32, N'Jirón Las Lomas 456, Canto Grande', N'Detrás del centro comercial')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (3, 32, N'Av. Las Flores de Primavera 123, Canto Grande', N'Al costado del banco, casa 3 pisos, fachada Blanca')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (4, 32, N'Calle Los Jardines 120, Canto Grande', N'Cerca del colegio')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (5, 32, N'Calle Los Pinos 789, Canto Grande', N'Frente al parque central')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (6, 32, N'Av. Los Álamos 555, Canto Rey', N'A 2 cuadras del mercado')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (7, 32, N'Jirón Los Rosales 890, Canto Rey', N'Cerca del hospital')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (8, 32, N'Av. Los Cedros 321, Apt. 101, Canto Rey', N'En el segundo piso')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (9, 32, N'Calle Las Magnolias 456, Canto Rey', N'A la vuelta de la farmacia')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (10, 32, N'Jirón Las Begonias 789, Canto Rey', N'Frente al parque de diversiones')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (11, 32, N'Av. Los Girasoles 123, Apt. 203, Canto Rey', N'A un lado del supermercado')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (12, 32, N'Calle Las Orquídeas 456, Canto Rey', N'Casa con puerta roja')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (13, 32, N'Jirón Los Lirios 789, Canto Rey', N'Edificio color beige')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (14, 32, N'Av. Las Palmeras 321, Canto Rey', N'Cerca del estadio municipal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (15, 32, N'Calle Los Tulipanes 555, Canto Rey', N'Al costado del parque infantil')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (16, 32, N'Jirón Las Hortensias 890, Canto Rey', N'Detrás del centro médico')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (17, 32, N'Av. Los Sauces 678, Canto Rey', N'A la vuelta del colegio')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (18, 32, N'Calle Las Azucenas 456, Canto Rey', N'Frente al parque de los bomberos')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (19, 32, N'Jirón Las Dalias 789, Canto Rey', N'A 2 cuadras del centro cultural')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (20, 32, N'Av. Las Violetas 123, Apt. 404, Canto Rey', N'En el cuarto piso')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (21, 32, N'Av. Los Cipreses 567, Canto Grande', N'Cerca del mercado principal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (22, 32, N'Calle Los Abedules 890, Canto Grande', N'Frente a la plaza central')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (23, 32, N'Jirón Las Acacias 234, Canto Grande', N'Al lado del paradero de buses')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (24, 32, N'Av. Los Eucaliptos 789, Canto Grande', N'En la esquina con la avenida principal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (25, 32, N'Calle Los Robles 567, Canto Grande', N'Frente al centro educativo')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (26, 32, N'Jirón Las Margaritas 890, Canto Grande', N'A 3 cuadras del centro de salud')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (27, 32, N'Av. Las Begonias 234, Canto Grande', N'Junto al parque recreacional')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (28, 32, N'Calle Las Orquídeas 789, Canto Grande', N'En la zona residencial')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (29, 32, N'Jirón Los Girasoles 567, Canto Grande', N'Cerca del centro comunal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (30, 32, N'Av. Las Violetas 890, Canto Grande', N'Frente al campo deportivo')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (31, 32, N'Calle Las Azucenas 234, Canto Grande', N'Junto al mercado de abastos')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (32, 32, N'Jirón Las Dalias 789, Canto Grande', N'En la avenida principal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (33, 32, N'Av. Los Lirios 567, Canto Grande', N'Al costado de la estación de policía')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (34, 32, N'Calle Las Rosas 890, Canto Grande', N'Frente al parque industrial')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (35, 32, N'Jirón Las Magnolias 234, Canto Grande', N'Junto a la iglesia principal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (36, 32, N'Av. Los Sauces 789, Canto Grande', N'En el centro de la urbanización')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (37, 32, N'Calle Las Acacias 567, Canto Grande', N'Al lado del centro de eventos')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (38, 32, N'Jirón Los Girasoles 890, Canto Grande', N'En la avenida principal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (39, 32, N'Av. Las Begonias 234, Canto Grande', N'Frente al centro comercial')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (40, 32, N'Calle Los Lirios 789, Canto Grande', N'Junto al parque')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (41, 32, N'Jirón Las Rosas 567, Canto Grande', N'En la esquina con la avenida principal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (42, 32, N'Av. Los Jazmines 890, Canto Grande', N'Al costado del colegio')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (43, 32, N'Calle Las Orquídeas 234, Canto Grande', N'Cerca del hospital')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (44, 32, N'Jirón Los Cedros 789, Canto Grande', N'En el centro de la ciudad')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (45, 32, N'Av. Las Margaritas 567, Canto Grande', N'Frente al mercado municipal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (46, 32, N'Calle Los Eucaliptos 890, Canto Grande', N'A un lado del parque central')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (47, 32, N'Jirón Las Violetas 234, Canto Grande', N'En la esquina con la avenida principal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (48, 32, N'Av. Los Robles 789, Canto Grande', N'Junto a la plaza principal')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (49, 32, N'Calle Las Begonias 567, Canto Grande', N'Cerca del parque recreativo')
INSERT [dbo].[Direccion] ([DireccionID], [DistritoID], [Nombre], [Referencia]) VALUES (50, 32, N'Jirón Las Acacias 890, Canto Grande', N'Al lado del centro educativo')
SET IDENTITY_INSERT [dbo].[Direccion] OFF
GO
SET IDENTITY_INSERT [dbo].[Distrito] ON 

INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (1, 1, N'Ancón')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (2, 1, N'Ate')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (3, 1, N'Barranco')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (4, 1, N'Breña')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (5, 1, N'Carabayllo')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (6, 1, N'Chaclacayo')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (7, 1, N'Chorrillos')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (8, 1, N'Cieneguilla')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (9, 1, N'Comas')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (10, 1, N'El Agustino')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (11, 1, N'Independencia')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (12, 1, N'Jesús María')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (13, 1, N'La Molina')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (14, 1, N'La Victoria')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (15, 1, N'Lima')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (16, 1, N'Lince')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (17, 1, N'Los Olivos')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (18, 1, N'Lurigancho')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (19, 1, N'Lurín')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (20, 1, N'Magdalena del Mar')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (21, 1, N'Miraflores')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (22, 1, N'Pachacámac')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (23, 1, N'Pucusana')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (24, 1, N'Pueblo Libre')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (25, 1, N'Puente Piedra')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (26, 1, N'Punta Hermosa')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (27, 1, N'Punta Negra')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (28, 1, N'Rímac')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (29, 1, N'San Bartolo')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (30, 1, N'San Borja')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (31, 1, N'San Isidro')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (32, 1, N'San Juan de Lurigancho')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (33, 1, N'San Juan de Miraflores')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (34, 1, N'San Luis')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (35, 1, N'San Martín de Porres')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (36, 1, N'San Miguel')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (37, 1, N'Santa Anita')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (38, 1, N'Santa María del Mar')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (39, 1, N'Santa Rosa')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (40, 1, N'Santiago de Surco')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (41, 1, N'Surquillo')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (42, 1, N'Villa El Salvador')
INSERT [dbo].[Distrito] ([DistritoID], [ProvinciaID], [Nombre]) VALUES (43, 1, N'Villa María del Triunfo')
SET IDENTITY_INSERT [dbo].[Distrito] OFF
GO
SET IDENTITY_INSERT [dbo].[DocumentoIdentidad] ON 

INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (1, 1, 1, N'75392782')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (2, 1, 2, N'84659123')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (3, 1, 3, N'92137465')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (4, 1, 4, N'65428197')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (5, 1, 5, N'37816492')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (6, 1, 6, N'51973648')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (7, 1, 7, N'64782913')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (8, 1, 8, N'23897461')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (9, 1, 9, N'94617238')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (10, 1, 10, N'18263749')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (11, 1, 11, N'47382916')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (12, 1, 12, N'56927481')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (13, 1, 13, N'83719462')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (14, 1, 14, N'67193824')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (15, 1, 15, N'29468173')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (16, 1, 16, N'51827936')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (17, 1, 17, N'72638491')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (18, 1, 18, N'39487261')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (19, 1, 19, N'61839274')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (20, 1, 20, N'83164927')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (21, 1, 21, N'45712983')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (22, 1, 22, N'68294713')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (23, 1, 23, N'51923746')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (24, 1, 24, N'92731846')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (25, 1, 25, N'64279318')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (26, 1, 26, N'83746219')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (27, 1, 27, N'21984736')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (28, 1, 28, N'73649281')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (29, 1, 29, N'48192376')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (30, 1, 30, N'62837194')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (31, 1, 31, N'94763218')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (32, 1, 32, N'36192748')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (33, 1, 33, N'71983624')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (34, 1, 34, N'57283649')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (35, 1, 35, N'68471932')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (36, 1, 36, N'42973186')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (37, 1, 37, N'27618493')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (38, 1, 38, N'83912746')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (39, 1, 39, N'47192638')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (40, 1, 40, N'61873924')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (41, 1, 41, N'81927364')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (42, 1, 42, N'51872936')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (43, 1, 43, N'72684913')
INSERT [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID], [TipoDocumentoIdentidadID], [ClienteID], [Numero]) VALUES (44, 1, 44, N'39478261')
SET IDENTITY_INSERT [dbo].[DocumentoIdentidad] OFF
GO
SET IDENTITY_INSERT [dbo].[EstadoSuscripcion] ON 

INSERT [dbo].[EstadoSuscripcion] ([EstadoSuscripcionID], [SuscripcionID], [Activo], [FechaHora]) VALUES (1, 1, 1, CAST(N'2024-01-01T00:00:00.0000000' AS DateTime2))
INSERT [dbo].[EstadoSuscripcion] ([EstadoSuscripcionID], [SuscripcionID], [Activo], [FechaHora]) VALUES (2, 2, 1, CAST(N'2024-04-15T00:00:00.0000000' AS DateTime2))
SET IDENTITY_INSERT [dbo].[EstadoSuscripcion] OFF
GO
SET IDENTITY_INSERT [dbo].[EstadoUsuario] ON 

INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (1, 4, 0)
INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (2, 1, 1)
INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (3, 2, 1)
INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (4, 5, 1)
INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (5, 6, 1)
INSERT [dbo].[EstadoUsuario] ([EstadoUsuarioID], [UsuarioID], [Activo]) VALUES (6, 3, 0)
SET IDENTITY_INSERT [dbo].[EstadoUsuario] OFF
GO
SET IDENTITY_INSERT [dbo].[Factura] ON 

INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (1, 1, CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date), CAST(N'2024-02-21' AS Date), CAST(N'2024-01-09T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (2, 2, CAST(N'2024-02-06' AS Date), CAST(N'2024-03-05' AS Date), CAST(N'2024-03-21' AS Date), CAST(N'2024-02-09T00:00:00.0000000' AS DateTime2), CAST(159.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (3, 3, CAST(N'2024-03-06' AS Date), CAST(N'2024-04-05' AS Date), CAST(N'2024-04-21' AS Date), CAST(N'2024-03-09T00:00:00.0000000' AS DateTime2), CAST(179.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (4, 4, CAST(N'2024-04-06' AS Date), CAST(N'2024-05-05' AS Date), CAST(N'2024-05-21' AS Date), CAST(N'2024-04-09T00:00:00.0000000' AS DateTime2), CAST(199.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (5, 5, CAST(N'2024-05-06' AS Date), CAST(N'2024-06-05' AS Date), CAST(N'2024-06-21' AS Date), CAST(N'2024-05-09T00:00:00.0000000' AS DateTime2), CAST(219.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (6, 6, CAST(N'2024-06-06' AS Date), CAST(N'2024-07-05' AS Date), CAST(N'2024-07-21' AS Date), CAST(N'2024-06-09T00:00:00.0000000' AS DateTime2), CAST(239.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (7, 7, CAST(N'2024-07-06' AS Date), CAST(N'2024-08-05' AS Date), CAST(N'2024-08-21' AS Date), CAST(N'2024-07-09T00:00:00.0000000' AS DateTime2), CAST(259.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (8, 8, CAST(N'2024-08-06' AS Date), CAST(N'2024-09-05' AS Date), CAST(N'2024-09-21' AS Date), CAST(N'2024-08-09T00:00:00.0000000' AS DateTime2), CAST(279.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (9, 9, CAST(N'2024-09-06' AS Date), CAST(N'2024-10-05' AS Date), CAST(N'2024-10-21' AS Date), CAST(N'2024-09-09T00:00:00.0000000' AS DateTime2), CAST(299.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (10, 10, CAST(N'2024-10-06' AS Date), CAST(N'2024-11-05' AS Date), CAST(N'2024-11-21' AS Date), CAST(N'2024-10-09T00:00:00.0000000' AS DateTime2), CAST(319.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (11, 11, CAST(N'2024-11-06' AS Date), CAST(N'2024-12-05' AS Date), CAST(N'2024-12-21' AS Date), CAST(N'2024-11-09T00:00:00.0000000' AS DateTime2), CAST(339.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (12, 12, CAST(N'2024-12-06' AS Date), CAST(N'2025-01-05' AS Date), CAST(N'2025-01-21' AS Date), CAST(N'2024-12-09T00:00:00.0000000' AS DateTime2), CAST(359.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (13, 13, CAST(N'2025-01-06' AS Date), CAST(N'2025-02-05' AS Date), CAST(N'2025-02-21' AS Date), CAST(N'2025-01-09T00:00:00.0000000' AS DateTime2), CAST(379.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (14, 14, CAST(N'2025-02-06' AS Date), CAST(N'2025-03-05' AS Date), CAST(N'2025-03-21' AS Date), CAST(N'2025-02-09T00:00:00.0000000' AS DateTime2), CAST(399.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (15, 15, CAST(N'2025-03-06' AS Date), CAST(N'2025-04-05' AS Date), CAST(N'2025-04-21' AS Date), CAST(N'2025-03-09T00:00:00.0000000' AS DateTime2), CAST(419.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (16, 16, CAST(N'2025-04-06' AS Date), CAST(N'2025-05-05' AS Date), CAST(N'2025-05-21' AS Date), CAST(N'2025-04-09T00:00:00.0000000' AS DateTime2), CAST(439.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (17, 17, CAST(N'2025-05-06' AS Date), CAST(N'2025-06-05' AS Date), CAST(N'2025-06-21' AS Date), CAST(N'2025-05-09T00:00:00.0000000' AS DateTime2), CAST(489.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (18, 18, CAST(N'2025-06-06' AS Date), CAST(N'2025-07-05' AS Date), CAST(N'2025-07-21' AS Date), CAST(N'2025-06-09T00:00:00.0000000' AS DateTime2), CAST(459.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (19, 19, CAST(N'2025-07-06' AS Date), CAST(N'2025-08-05' AS Date), CAST(N'2025-08-21' AS Date), CAST(N'2025-07-09T00:00:00.0000000' AS DateTime2), CAST(479.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (20, 20, CAST(N'2025-08-06' AS Date), CAST(N'2025-09-05' AS Date), CAST(N'2025-09-21' AS Date), CAST(N'2025-08-09T00:00:00.0000000' AS DateTime2), CAST(499.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (21, 21, CAST(N'2025-09-06' AS Date), CAST(N'2025-10-05' AS Date), CAST(N'2025-10-21' AS Date), CAST(N'2025-09-09T00:00:00.0000000' AS DateTime2), CAST(519.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (22, 22, CAST(N'2025-10-06' AS Date), CAST(N'2025-11-05' AS Date), CAST(N'2025-11-21' AS Date), CAST(N'2025-10-09T00:00:00.0000000' AS DateTime2), CAST(539.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (23, 23, CAST(N'2025-11-06' AS Date), CAST(N'2025-12-05' AS Date), CAST(N'2025-12-21' AS Date), CAST(N'2025-11-09T00:00:00.0000000' AS DateTime2), CAST(559.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (24, 24, CAST(N'2025-12-06' AS Date), CAST(N'2026-01-05' AS Date), CAST(N'2026-01-21' AS Date), CAST(N'2025-12-09T00:00:00.0000000' AS DateTime2), CAST(579.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (25, 25, CAST(N'2026-01-06' AS Date), CAST(N'2026-02-05' AS Date), CAST(N'2026-02-21' AS Date), CAST(N'2026-01-09T00:00:00.0000000' AS DateTime2), CAST(599.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (26, 26, CAST(N'2026-02-06' AS Date), CAST(N'2026-03-05' AS Date), CAST(N'2026-03-21' AS Date), CAST(N'2026-02-09T00:00:00.0000000' AS DateTime2), CAST(619.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (27, 27, CAST(N'2026-03-06' AS Date), CAST(N'2026-04-05' AS Date), CAST(N'2026-04-21' AS Date), CAST(N'2026-03-09T00:00:00.0000000' AS DateTime2), CAST(639.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (28, 28, CAST(N'2026-04-06' AS Date), CAST(N'2026-05-05' AS Date), CAST(N'2026-05-21' AS Date), CAST(N'2026-04-09T00:00:00.0000000' AS DateTime2), CAST(659.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (29, 29, CAST(N'2026-05-06' AS Date), CAST(N'2026-06-05' AS Date), CAST(N'2026-06-21' AS Date), CAST(N'2026-05-09T00:00:00.0000000' AS DateTime2), CAST(679.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (30, 30, CAST(N'2026-06-06' AS Date), CAST(N'2026-07-05' AS Date), CAST(N'2026-07-21' AS Date), CAST(N'2026-06-09T00:00:00.0000000' AS DateTime2), CAST(699.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (31, 31, CAST(N'2026-07-06' AS Date), CAST(N'2026-08-05' AS Date), CAST(N'2026-08-21' AS Date), CAST(N'2026-07-09T00:00:00.0000000' AS DateTime2), CAST(719.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (32, 32, CAST(N'2026-08-06' AS Date), CAST(N'2026-09-05' AS Date), CAST(N'2026-09-21' AS Date), CAST(N'2026-08-09T00:00:00.0000000' AS DateTime2), CAST(739.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (33, 33, CAST(N'2026-09-06' AS Date), CAST(N'2026-10-05' AS Date), CAST(N'2026-10-21' AS Date), CAST(N'2026-09-09T00:00:00.0000000' AS DateTime2), CAST(759.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (34, 34, CAST(N'2026-10-06' AS Date), CAST(N'2026-11-05' AS Date), CAST(N'2026-11-21' AS Date), CAST(N'2026-10-09T00:00:00.0000000' AS DateTime2), CAST(779.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (35, 35, CAST(N'2026-11-06' AS Date), CAST(N'2026-12-05' AS Date), CAST(N'2026-12-21' AS Date), CAST(N'2026-11-09T00:00:00.0000000' AS DateTime2), CAST(799.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (36, 36, CAST(N'2026-12-06' AS Date), CAST(N'2027-01-05' AS Date), CAST(N'2027-01-21' AS Date), CAST(N'2026-12-09T00:00:00.0000000' AS DateTime2), CAST(819.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (37, 37, CAST(N'2027-01-06' AS Date), CAST(N'2027-02-05' AS Date), CAST(N'2027-02-21' AS Date), CAST(N'2027-01-09T00:00:00.0000000' AS DateTime2), CAST(839.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (38, 38, CAST(N'2027-02-06' AS Date), CAST(N'2027-03-05' AS Date), CAST(N'2027-03-21' AS Date), CAST(N'2027-02-09T00:00:00.0000000' AS DateTime2), CAST(859.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (39, 39, CAST(N'2027-03-06' AS Date), CAST(N'2027-04-05' AS Date), CAST(N'2027-04-21' AS Date), CAST(N'2027-03-09T00:00:00.0000000' AS DateTime2), CAST(879.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (40, 40, CAST(N'2027-04-06' AS Date), CAST(N'2027-05-05' AS Date), CAST(N'2027-05-21' AS Date), CAST(N'2027-04-09T00:00:00.0000000' AS DateTime2), CAST(899.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (41, 41, CAST(N'2027-05-06' AS Date), CAST(N'2027-06-05' AS Date), CAST(N'2027-06-21' AS Date), CAST(N'2027-05-09T00:00:00.0000000' AS DateTime2), CAST(919.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (42, 42, CAST(N'2027-06-06' AS Date), CAST(N'2027-07-05' AS Date), CAST(N'2027-07-21' AS Date), CAST(N'2027-06-09T00:00:00.0000000' AS DateTime2), CAST(939.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (43, 43, CAST(N'2027-07-06' AS Date), CAST(N'2027-08-05' AS Date), CAST(N'2027-08-21' AS Date), CAST(N'2027-07-09T00:00:00.0000000' AS DateTime2), CAST(959.00 AS Decimal(10, 2)))
INSERT [dbo].[Factura] ([FacturaID], [SuscripcionID], [DiaInicio], [DiaFin], [DiaVencimiento], [FechaHoraEmision], [MontoCalculado]) VALUES (44, 44, CAST(N'2027-08-06' AS Date), CAST(N'2027-09-05' AS Date), CAST(N'2027-09-21' AS Date), CAST(N'2027-08-09T00:00:00.0000000' AS DateTime2), CAST(979.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Factura] OFF
GO
SET IDENTITY_INSERT [dbo].[Operacion] ON 

INSERT [dbo].[Operacion] ([OperacionID], [Nombre]) VALUES (3, N'Actualizar')
INSERT [dbo].[Operacion] ([OperacionID], [Nombre]) VALUES (1, N'Crear')
INSERT [dbo].[Operacion] ([OperacionID], [Nombre]) VALUES (4, N'Eliminar')
INSERT [dbo].[Operacion] ([OperacionID], [Nombre]) VALUES (2, N'Leer')
SET IDENTITY_INSERT [dbo].[Operacion] OFF
GO
SET IDENTITY_INSERT [dbo].[Pago] ON 

INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (1, 1, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (2, 2, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (3, 3, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (4, 4, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (5, 5, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (6, 6, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (7, 7, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (8, 8, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (9, 9, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (10, 10, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (11, 11, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (12, 12, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (13, 13, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (14, 14, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (15, 15, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (16, 16, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (17, 17, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (18, 18, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (19, 19, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (20, 20, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (21, 21, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (22, 22, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (23, 23, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (24, 24, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (25, 25, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (26, 26, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (27, 27, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (28, 28, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (29, 29, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (30, 30, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (31, 31, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (32, 32, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(50.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (33, 33, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(34.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (34, 34, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(10.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (35, 35, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(79.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (36, 36, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(99.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (37, 37, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (38, 38, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(129.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (39, 39, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(179.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (40, 40, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(20.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (41, 41, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (42, 42, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (43, 43, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
INSERT [dbo].[Pago] ([PagoID], [FacturaID], [FechaHora], [MontoPago]) VALUES (44, 44, CAST(N'2024-02-15T00:00:00.0000000' AS DateTime2), CAST(149.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Pago] OFF
GO
SET IDENTITY_INSERT [dbo].[Permiso] ON 

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
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (26, 1, 2, 1)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (27, 1, 2, 5)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (28, 1, 2, 6)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (29, 1, 2, 8)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (30, 1, 2, 12)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (31, 1, 2, 14)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (32, 1, 2, 16)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (33, 1, 2, 20)
INSERT [dbo].[Permiso] ([PermisoID], [OperacionID], [RolID], [RecursoID]) VALUES (34, 1, 2, 25)
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
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (12, N'Internet 250 MB', CAST(219.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (13, N'Duo 250 MB', CAST(249.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (14, N'Internet 300 MB', CAST(279.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (15, N'Duo 300 MB', CAST(299.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (16, N'Internet 350 MB', CAST(319.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (17, N'Duo 350 MB', CAST(349.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (18, N'Internet 400 MB', CAST(379.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (19, N'Duo 400 MB', CAST(399.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (20, N'Internet 450 MB', CAST(429.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (21, N'Duo 450 MB', CAST(449.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (22, N'Internet 500 MB', CAST(479.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (23, N'Duo 500 MB', CAST(499.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (24, N'Internet 550 MB', CAST(529.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (25, N'Duo 550 MB', CAST(549.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (26, N'Internet 600 MB', CAST(579.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (27, N'Duo 600 MB', CAST(599.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (28, N'Internet 650 MB', CAST(629.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (29, N'Duo 650 MB', CAST(649.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (30, N'Internet 700 MB', CAST(679.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (31, N'Duo 700 MB', CAST(699.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (32, N'Internet 750 MB', CAST(729.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (33, N'Duo 750 MB', CAST(749.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (34, N'Internet 800 MB', CAST(779.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (35, N'Duo 800 MB', CAST(799.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (36, N'Internet 850 MB', CAST(829.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (37, N'Duo 850 MB', CAST(849.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (38, N'Internet 900 MB', CAST(879.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (39, N'Duo 900 MB', CAST(899.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (40, N'Internet 950 MB', CAST(929.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (41, N'Duo 950 MB', CAST(949.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (42, N'Internet 1000 MB', CAST(979.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (43, N'Duo 1000 MB', CAST(999.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (44, N'Internet 1050 MB', CAST(1029.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (45, N'Duo 1050 MB', CAST(1049.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (46, N'Internet 1100 MB', CAST(1079.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (47, N'Duo 1100 MB', CAST(1099.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (48, N'Internet 1150 MB', CAST(1129.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (49, N'Duo 1150 MB', CAST(1149.00 AS Decimal(10, 2)))
INSERT [dbo].[PlanSuscripcion] ([PlanSuscripcionID], [Nombre], [PrecioCalculado]) VALUES (50, N'Internet 1200 MB', CAST(1179.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[PlanSuscripcion] OFF
GO
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
SET IDENTITY_INSERT [dbo].[Provincia] ON 

INSERT [dbo].[Provincia] ([ProvinciaID], [DepartamentoID], [Nombre]) VALUES (1, 1, N'Lima')
SET IDENTITY_INSERT [dbo].[Provincia] OFF
GO
SET IDENTITY_INSERT [dbo].[Recurso] ON 

INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (3, N'Auditoria')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (7, N'BitacoraAtencion')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (6, N'CategoriaBitacoraAtencion')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (5, N'Celular')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (12, N'CicloFacturacion')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (13, N'Cliente')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (24, N'Comunicacion')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (8, N'Departamento')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (21, N'DetalleFactura')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (18, N'DetallePlan')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (4, N'DetalleRouter')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (11, N'Direccion')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (10, N'Distrito')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (15, N'DocumentoIdentidad')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (1, N'EstadoUsuario')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (20, N'Factura')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (26, N'Operacion')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (22, N'Pago')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (28, N'Permiso')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (16, N'PlanSuscripcion')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (17, N'Producto')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (9, N'Provincia')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (25, N'Recurso')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (27, N'Rol')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (19, N'Suscripcion')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (23, N'TipoComunicacion')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (14, N'TipoDocumentoIdentidad')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (29, N'Usuario')
INSERT [dbo].[Recurso] ([RecursoID], [Nombre]) VALUES (2, N'UsuarioRol')
SET IDENTITY_INSERT [dbo].[Recurso] OFF
GO
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([RolID], [Nombre], [Descripcion]) VALUES (1, N'Administrador', N'Configura, mantiene y asegura el software.')
INSERT [dbo].[Rol] ([RolID], [Nombre], [Descripcion]) VALUES (2, N'Empleado', N'Usa el software para gestionar clientes y resolver consultas.')
SET IDENTITY_INSERT [dbo].[Rol] OFF
GO
SET IDENTITY_INSERT [dbo].[Suscripcion] ON 

INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (1, 1, 1, 1, 1, CAST(N'2024-01-01' AS Date), CAST(N'2024-01-05' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (2, 2, 2, 2, 2, CAST(N'2024-04-15' AS Date), CAST(N'2023-10-24' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (3, 3, 3, 3, 3, CAST(N'2024-05-10' AS Date), CAST(N'2024-05-15' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (4, 4, 4, 4, 4, CAST(N'2024-06-01' AS Date), CAST(N'2024-06-15' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (5, 5, 5, 5, 5, CAST(N'2024-06-02' AS Date), CAST(N'2024-06-16' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (6, 6, 6, 6, 6, CAST(N'2024-06-03' AS Date), CAST(N'2024-06-17' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (7, 7, 7, 7, 7, CAST(N'2024-06-04' AS Date), CAST(N'2024-06-18' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (8, 8, 8, 8, 8, CAST(N'2024-06-05' AS Date), CAST(N'2024-06-19' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (9, 9, 9, 9, 9, CAST(N'2024-06-06' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (10, 10, 10, 10, 10, CAST(N'2024-06-07' AS Date), CAST(N'2024-06-21' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (11, 11, 11, 11, 11, CAST(N'2024-06-08' AS Date), CAST(N'2024-06-22' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (12, 12, 12, 12, 12, CAST(N'2024-06-09' AS Date), CAST(N'2024-06-23' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (13, 13, 13, 13, 13, CAST(N'2024-06-10' AS Date), CAST(N'2024-06-24' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (14, 14, 14, 14, 14, CAST(N'2024-06-11' AS Date), CAST(N'2024-06-25' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (15, 15, 15, 15, 15, CAST(N'2024-06-12' AS Date), CAST(N'2024-06-26' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (16, 16, 16, 16, 16, CAST(N'2024-06-13' AS Date), CAST(N'2024-06-27' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (17, 17, 17, 17, 17, CAST(N'2024-06-14' AS Date), CAST(N'2024-06-28' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (18, 18, 18, 18, 18, CAST(N'2024-06-15' AS Date), CAST(N'2024-06-29' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (19, 19, 19, 19, 19, CAST(N'2024-06-16' AS Date), CAST(N'2024-06-30' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (20, 20, 20, 20, 20, CAST(N'2024-06-17' AS Date), CAST(N'2024-07-01' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (21, 21, 21, 21, 21, CAST(N'2024-06-18' AS Date), CAST(N'2024-07-02' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (22, 22, 22, 22, 22, CAST(N'2024-06-19' AS Date), CAST(N'2024-07-03' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (23, 23, 23, 23, 23, CAST(N'2024-06-20' AS Date), CAST(N'2024-07-04' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (24, 24, 24, 24, 24, CAST(N'2024-06-21' AS Date), CAST(N'2024-07-05' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (25, 25, 25, 25, 25, CAST(N'2024-06-22' AS Date), CAST(N'2024-07-06' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (26, 26, 26, 26, 26, CAST(N'2024-06-23' AS Date), CAST(N'2024-07-07' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (27, 27, 27, 27, 27, CAST(N'2024-06-24' AS Date), CAST(N'2024-07-08' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (28, 28, 28, 28, 28, CAST(N'2024-06-25' AS Date), CAST(N'2024-07-09' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (29, 29, 29, 29, 29, CAST(N'2024-06-26' AS Date), CAST(N'2024-07-10' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (30, 30, 30, 30, 30, CAST(N'2024-06-27' AS Date), CAST(N'2024-07-11' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (31, 31, 31, 31, 31, CAST(N'2024-06-28' AS Date), CAST(N'2024-07-12' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (32, 32, 32, 32, 32, CAST(N'2024-06-29' AS Date), CAST(N'2024-07-13' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (33, 33, 33, 33, 33, CAST(N'2024-06-30' AS Date), CAST(N'2024-07-14' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (34, 34, 34, 34, 34, CAST(N'2024-07-01' AS Date), CAST(N'2024-07-15' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (35, 35, 35, 35, 35, CAST(N'2024-07-02' AS Date), CAST(N'2024-07-16' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (36, 36, 36, 36, 36, CAST(N'2024-07-03' AS Date), CAST(N'2024-07-17' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (37, 37, 37, 37, 37, CAST(N'2024-07-04' AS Date), CAST(N'2024-07-18' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (38, 38, 38, 38, 38, CAST(N'2024-07-05' AS Date), CAST(N'2024-07-19' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (39, 39, 39, 39, 39, CAST(N'2024-07-06' AS Date), CAST(N'2024-07-20' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (40, 40, 40, 40, 40, CAST(N'2024-07-07' AS Date), CAST(N'2024-07-21' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (41, 41, 41, 41, 41, CAST(N'2024-07-08' AS Date), CAST(N'2024-07-22' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (42, 42, 42, 42, 42, CAST(N'2024-07-09' AS Date), CAST(N'2024-07-23' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (43, 43, 43, 43, 43, CAST(N'2024-07-10' AS Date), CAST(N'2024-07-24' AS Date))
INSERT [dbo].[Suscripcion] ([SuscripcionID], [DocumentoIdentidadID], [PlanSuscripcionID], [DireccionID], [CicloFacturacionID], [FechaVenta], [FechaInstalacion]) VALUES (44, 44, 44, 44, 44, CAST(N'2024-07-11' AS Date), CAST(N'2024-07-25' AS Date))
SET IDENTITY_INSERT [dbo].[Suscripcion] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoComunicacion] ON 

INSERT [dbo].[TipoComunicacion] ([TipoComunicacionID], [Nombre], [Descripcion]) VALUES (1, N'SMS', N'Servicio de mensajería de texto que permite el intercambio de mensajes de texto ')
INSERT [dbo].[TipoComunicacion] ([TipoComunicacionID], [Nombre], [Descripcion]) VALUES (2, N'Correo', N'Correo electronico')
SET IDENTITY_INSERT [dbo].[TipoComunicacion] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoDocumentoIdentidad] ON 

INSERT [dbo].[TipoDocumentoIdentidad] ([TipoDocumentoIdentidadID], [Nombre]) VALUES (2, N'CE')
INSERT [dbo].[TipoDocumentoIdentidad] ([TipoDocumentoIdentidadID], [Nombre]) VALUES (1, N'DNI')
INSERT [dbo].[TipoDocumentoIdentidad] ([TipoDocumentoIdentidadID], [Nombre]) VALUES (3, N'RUC10')
INSERT [dbo].[TipoDocumentoIdentidad] ([TipoDocumentoIdentidadID], [Nombre]) VALUES (4, N'RUC20')
SET IDENTITY_INSERT [dbo].[TipoDocumentoIdentidad] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (1, N'Deivtel', N'Deivtel', N'Deivtel', N'deivtel@gmail.com', N'$2a$12$F/tJ/AOGqtV3bjrBE/k4i.2YFAMY566Ynj3my1gn6UWCt2h69qAoe')
INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (2, N'Fabian', N'Ocrospoma', N'Guzman', N'focrospoma@gmail.com', N'$2a$12$TPvxH4AwOIm6KoFnCOF1vufobCuZY9bMV3QTkWJEl0pdysH8NMpNS')
INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (3, N'Piero', N'Cruz', N'Laos', N'pcruz@gmail.com', N'$2a$12$TPvxH4AwOIm6KoFnCOF1vufobCuZY9bMV3QTkWJEl0pdysH8NMpNS')
INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (4, N'Liam', N'Quiñones', N'Carhuaz', N'lquinones@gmail.com', N'$2a$12$TPvxH4AwOIm6KoFnCOF1vufobCuZY9bMV3QTkWJEl0pdysH8NMpNS')
INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (5, N'Alex', N'Vargas', N'Tapia', N'avargas@gmail.com', N'$2a$12$TPvxH4AwOIm6KoFnCOF1vufobCuZY9bMV3QTkWJEl0pdysH8NMpNS')
INSERT [dbo].[Usuario] ([UsuarioID], [Nombre], [ApPaterno], [ApMaterno], [Correo], [ContrasenaHash]) VALUES (6, N'Fabian', N'Yataco', N'Pulido', N'fyataco@gmail.com', N'$2a$12$TPvxH4AwOIm6KoFnCOF1vufobCuZY9bMV3QTkWJEl0pdysH8NMpNS')
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET IDENTITY_INSERT [dbo].[UsuarioRol] ON 

INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (1, 1, 1)
INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (2, 2, 2)
INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (3, 3, 2)
INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (5, 4, 2)
INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (6, 5, 2)
INSERT [dbo].[UsuarioRol] ([UsuarioRolID], [UsuarioID], [RolID]) VALUES (7, 6, 2)
SET IDENTITY_INSERT [dbo].[UsuarioRol] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Categori__75E3EFCF41200C52]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[CategoriaBitacoraAtencion] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Celular__7E532BC688A234EB]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[Celular] ADD UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Celular_Numero]    Script Date: 02/07/2024 05:47:07 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_Celular_Numero] ON [dbo].[Celular]
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__CicloFac__75E3EFCFAE632F36]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[CicloFacturacion] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Usuario_Nombre]    Script Date: 02/07/2024 05:47:07 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_Usuario_Nombre] ON [dbo].[CicloFacturacion]
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Departam__75E3EFCF91289C6E]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[Departamento] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__DetalleR__814D768A89952171]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[DetalleRouter] ADD UNIQUE NONCLUSTERED 
(
	[SuscripcionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Distrito__75E3EFCF9842A3F9]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[Distrito] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [FK_DocumentoIdentidad.uq_ClienteID_TipoDocumentoIdentidadID]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[DocumentoIdentidad] ADD  CONSTRAINT [FK_DocumentoIdentidad.uq_ClienteID_TipoDocumentoIdentidadID] UNIQUE NONCLUSTERED 
(
	[ClienteID] ASC,
	[TipoDocumentoIdentidadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Document__7E532BC65CA24A34]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[DocumentoIdentidad] ADD UNIQUE NONCLUSTERED 
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_DocumentoIdentidad_Numero]    Script Date: 02/07/2024 05:47:07 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_DocumentoIdentidad_Numero] ON [dbo].[DocumentoIdentidad]
(
	[Numero] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__EstadoSu__814D768A083C98D6]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[EstadoSuscripcion] ADD UNIQUE NONCLUSTERED 
(
	[SuscripcionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__EstadoUs__2B3DE799F9EA4835]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[EstadoUsuario] ADD UNIQUE NONCLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Operacio__75E3EFCFF263AFE6]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[Operacion] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__PlanSusc__75E3EFCF47E6F82D]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[PlanSuscripcion] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Producto__75E3EFCFB0E5A567]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[Producto] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Provinci__75E3EFCF91464151]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[Provincia] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Recurso__75E3EFCF2AF7F5B9]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[Recurso] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Rol__75E3EFCF27199CE6]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[Rol] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Suscripc__68906D45621CF532]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[Suscripcion] ADD UNIQUE NONCLUSTERED 
(
	[DireccionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Suscripc__FC54FA66BAFD74F8]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[Suscripcion] ADD UNIQUE NONCLUSTERED 
(
	[CicloFacturacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TipoComu__75E3EFCF86FE4A62]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[TipoComunicacion] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__TipoDocu__75E3EFCF9BAD4251]    Script Date: 02/07/2024 05:47:07 p.m. ******/
ALTER TABLE [dbo].[TipoDocumentoIdentidad] ADD UNIQUE NONCLUSTERED 
(
	[Nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Usuario_Correo]    Script Date: 02/07/2024 05:47:07 p.m. ******/
CREATE NONCLUSTERED INDEX [IX_Usuario_Correo] ON [dbo].[Usuario]
(
	[Correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EstadoSuscripcion] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[EstadoUsuario] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Auditoria]  WITH CHECK ADD  CONSTRAINT [FK_Auditoria.OperacionID] FOREIGN KEY([OperacionID])
REFERENCES [dbo].[Operacion] ([OperacionID])
GO
ALTER TABLE [dbo].[Auditoria] CHECK CONSTRAINT [FK_Auditoria.OperacionID]
GO
ALTER TABLE [dbo].[Auditoria]  WITH CHECK ADD  CONSTRAINT [FK_Auditoria.UsuarioID] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuario] ([UsuarioID])
GO
ALTER TABLE [dbo].[Auditoria] CHECK CONSTRAINT [FK_Auditoria.UsuarioID]
GO
ALTER TABLE [dbo].[BitacoraAtencion]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraAtencion.CategoriaBitacoraID] FOREIGN KEY([CategoriaBitacoraID])
REFERENCES [dbo].[CategoriaBitacoraAtencion] ([CategoriaBitacoraAtencionID])
GO
ALTER TABLE [dbo].[BitacoraAtencion] CHECK CONSTRAINT [FK_BitacoraAtencion.CategoriaBitacoraID]
GO
ALTER TABLE [dbo].[BitacoraAtencion]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraAtencion.SuscripcionID] FOREIGN KEY([SuscripcionID])
REFERENCES [dbo].[Suscripcion] ([SuscripcionID])
GO
ALTER TABLE [dbo].[BitacoraAtencion] CHECK CONSTRAINT [FK_BitacoraAtencion.SuscripcionID]
GO
ALTER TABLE [dbo].[BitacoraAtencion]  WITH CHECK ADD  CONSTRAINT [FK_BitacoraAtencion.UsuarioID] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuario] ([UsuarioID])
GO
ALTER TABLE [dbo].[BitacoraAtencion] CHECK CONSTRAINT [FK_BitacoraAtencion.UsuarioID]
GO
ALTER TABLE [dbo].[Celular]  WITH CHECK ADD  CONSTRAINT [FK_Celular.ClienteID] FOREIGN KEY([ClienteID])
REFERENCES [dbo].[Cliente] ([ClienteID])
GO
ALTER TABLE [dbo].[Celular] CHECK CONSTRAINT [FK_Celular.ClienteID]
GO
ALTER TABLE [dbo].[Comunicacion]  WITH CHECK ADD  CONSTRAINT [FK_Comunicacion.SuscripcionID] FOREIGN KEY([SuscripcionID])
REFERENCES [dbo].[Suscripcion] ([SuscripcionID])
GO
ALTER TABLE [dbo].[Comunicacion] CHECK CONSTRAINT [FK_Comunicacion.SuscripcionID]
GO
ALTER TABLE [dbo].[Comunicacion]  WITH CHECK ADD  CONSTRAINT [FK_Comunicacion.TipoComunicacionID] FOREIGN KEY([TipoComunicacionID])
REFERENCES [dbo].[TipoComunicacion] ([TipoComunicacionID])
GO
ALTER TABLE [dbo].[Comunicacion] CHECK CONSTRAINT [FK_Comunicacion.TipoComunicacionID]
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_DetalleFactura.FacturaID] FOREIGN KEY([FacturaID])
REFERENCES [dbo].[Factura] ([FacturaID])
GO
ALTER TABLE [dbo].[DetalleFactura] CHECK CONSTRAINT [FK_DetalleFactura.FacturaID]
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_DetalleFactura.ProductoID] FOREIGN KEY([ProductoID])
REFERENCES [dbo].[Producto] ([ProductoID])
GO
ALTER TABLE [dbo].[DetalleFactura] CHECK CONSTRAINT [FK_DetalleFactura.ProductoID]
GO
ALTER TABLE [dbo].[DetallePlan]  WITH CHECK ADD  CONSTRAINT [FK_DetallePlan.PlanSuscripcionID] FOREIGN KEY([PlanSuscripcionID])
REFERENCES [dbo].[PlanSuscripcion] ([PlanSuscripcionID])
GO
ALTER TABLE [dbo].[DetallePlan] CHECK CONSTRAINT [FK_DetallePlan.PlanSuscripcionID]
GO
ALTER TABLE [dbo].[DetallePlan]  WITH CHECK ADD  CONSTRAINT [FK_DetallePlan.ProductoID] FOREIGN KEY([ProductoID])
REFERENCES [dbo].[Producto] ([ProductoID])
GO
ALTER TABLE [dbo].[DetallePlan] CHECK CONSTRAINT [FK_DetallePlan.ProductoID]
GO
ALTER TABLE [dbo].[DetalleRouter]  WITH CHECK ADD  CONSTRAINT [FK_DetalleRouter.SuscripcionID] FOREIGN KEY([SuscripcionID])
REFERENCES [dbo].[Suscripcion] ([SuscripcionID])
GO
ALTER TABLE [dbo].[DetalleRouter] CHECK CONSTRAINT [FK_DetalleRouter.SuscripcionID]
GO
ALTER TABLE [dbo].[Direccion]  WITH CHECK ADD  CONSTRAINT [FK_Direccion.DistritoID] FOREIGN KEY([DistritoID])
REFERENCES [dbo].[Distrito] ([DistritoID])
GO
ALTER TABLE [dbo].[Direccion] CHECK CONSTRAINT [FK_Direccion.DistritoID]
GO
ALTER TABLE [dbo].[Distrito]  WITH CHECK ADD  CONSTRAINT [FK_Distrito.ProvinciaID] FOREIGN KEY([ProvinciaID])
REFERENCES [dbo].[Provincia] ([ProvinciaID])
GO
ALTER TABLE [dbo].[Distrito] CHECK CONSTRAINT [FK_Distrito.ProvinciaID]
GO
ALTER TABLE [dbo].[DocumentoIdentidad]  WITH CHECK ADD  CONSTRAINT [FK_DocumentoIdentidad.ClienteID] FOREIGN KEY([ClienteID])
REFERENCES [dbo].[Cliente] ([ClienteID])
GO
ALTER TABLE [dbo].[DocumentoIdentidad] CHECK CONSTRAINT [FK_DocumentoIdentidad.ClienteID]
GO
ALTER TABLE [dbo].[DocumentoIdentidad]  WITH CHECK ADD  CONSTRAINT [FK_DocumentoIdentidad.TipoDocumentoIdentidadID] FOREIGN KEY([TipoDocumentoIdentidadID])
REFERENCES [dbo].[TipoDocumentoIdentidad] ([TipoDocumentoIdentidadID])
GO
ALTER TABLE [dbo].[DocumentoIdentidad] CHECK CONSTRAINT [FK_DocumentoIdentidad.TipoDocumentoIdentidadID]
GO
ALTER TABLE [dbo].[EstadoSuscripcion]  WITH CHECK ADD  CONSTRAINT [FK_EstadoSuscripcion.SuscripcionID] FOREIGN KEY([SuscripcionID])
REFERENCES [dbo].[Suscripcion] ([SuscripcionID])
GO
ALTER TABLE [dbo].[EstadoSuscripcion] CHECK CONSTRAINT [FK_EstadoSuscripcion.SuscripcionID]
GO
ALTER TABLE [dbo].[EstadoUsuario]  WITH CHECK ADD  CONSTRAINT [FK_EstadoUsuario.UsuarioID] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuario] ([UsuarioID])
GO
ALTER TABLE [dbo].[EstadoUsuario] CHECK CONSTRAINT [FK_EstadoUsuario.UsuarioID]
GO
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura.SuscripcionID] FOREIGN KEY([SuscripcionID])
REFERENCES [dbo].[Suscripcion] ([SuscripcionID])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Factura.SuscripcionID]
GO
ALTER TABLE [dbo].[Pago]  WITH CHECK ADD  CONSTRAINT [FK_Pago.FacturaID] FOREIGN KEY([FacturaID])
REFERENCES [dbo].[Factura] ([FacturaID])
GO
ALTER TABLE [dbo].[Pago] CHECK CONSTRAINT [FK_Pago.FacturaID]
GO
ALTER TABLE [dbo].[Permiso]  WITH CHECK ADD  CONSTRAINT [FK_Permiso.OperacionID] FOREIGN KEY([OperacionID])
REFERENCES [dbo].[Operacion] ([OperacionID])
GO
ALTER TABLE [dbo].[Permiso] CHECK CONSTRAINT [FK_Permiso.OperacionID]
GO
ALTER TABLE [dbo].[Permiso]  WITH CHECK ADD  CONSTRAINT [FK_Permiso.RecursoID] FOREIGN KEY([RecursoID])
REFERENCES [dbo].[Recurso] ([RecursoID])
GO
ALTER TABLE [dbo].[Permiso] CHECK CONSTRAINT [FK_Permiso.RecursoID]
GO
ALTER TABLE [dbo].[Permiso]  WITH CHECK ADD  CONSTRAINT [FK_Permiso.RolID] FOREIGN KEY([RolID])
REFERENCES [dbo].[Rol] ([RolID])
GO
ALTER TABLE [dbo].[Permiso] CHECK CONSTRAINT [FK_Permiso.RolID]
GO
ALTER TABLE [dbo].[Provincia]  WITH CHECK ADD  CONSTRAINT [FK_Provincia.DepartamentoID] FOREIGN KEY([DepartamentoID])
REFERENCES [dbo].[Departamento] ([DepartamentoID])
GO
ALTER TABLE [dbo].[Provincia] CHECK CONSTRAINT [FK_Provincia.DepartamentoID]
GO
ALTER TABLE [dbo].[Suscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Suscripcion.CicloFacturacionID] FOREIGN KEY([CicloFacturacionID])
REFERENCES [dbo].[CicloFacturacion] ([CicloFacturacionID])
GO
ALTER TABLE [dbo].[Suscripcion] CHECK CONSTRAINT [FK_Suscripcion.CicloFacturacionID]
GO
ALTER TABLE [dbo].[Suscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Suscripcion.DireccionID] FOREIGN KEY([DireccionID])
REFERENCES [dbo].[Direccion] ([DireccionID])
GO
ALTER TABLE [dbo].[Suscripcion] CHECK CONSTRAINT [FK_Suscripcion.DireccionID]
GO
ALTER TABLE [dbo].[Suscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Suscripcion.DocumentoIdentidadID] FOREIGN KEY([DocumentoIdentidadID])
REFERENCES [dbo].[DocumentoIdentidad] ([DocumentoIdentidadID])
GO
ALTER TABLE [dbo].[Suscripcion] CHECK CONSTRAINT [FK_Suscripcion.DocumentoIdentidadID]
GO
ALTER TABLE [dbo].[Suscripcion]  WITH CHECK ADD  CONSTRAINT [FK_Suscripcion.PlanSuscripcionID] FOREIGN KEY([PlanSuscripcionID])
REFERENCES [dbo].[PlanSuscripcion] ([PlanSuscripcionID])
GO
ALTER TABLE [dbo].[Suscripcion] CHECK CONSTRAINT [FK_Suscripcion.PlanSuscripcionID]
GO
ALTER TABLE [dbo].[UsuarioRol]  WITH CHECK ADD  CONSTRAINT [FK_UsuarioRol.RolID] FOREIGN KEY([RolID])
REFERENCES [dbo].[Rol] ([RolID])
GO
ALTER TABLE [dbo].[UsuarioRol] CHECK CONSTRAINT [FK_UsuarioRol.RolID]
GO
ALTER TABLE [dbo].[UsuarioRol]  WITH CHECK ADD  CONSTRAINT [FK_UsuarioRol.UsuarioID] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuario] ([UsuarioID])
GO
ALTER TABLE [dbo].[UsuarioRol] CHECK CONSTRAINT [FK_UsuarioRol.UsuarioID]
GO
/****** Object:  StoredProcedure [dbo].[sp_ActualizarCliente]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ActualizarCliente]
    @EmpleadoID INT,
    @ClienteID INT,
    @Nombre VARCHAR(50),
    @ApPaterno VARCHAR(50),
    @ApMaterno VARCHAR(50),
    @FechaNacimiento DATE,
    @TelefonoFijo VARCHAR(10),
    @Correo VARCHAR(64)
AS
BEGIN
    -- Actualizar información del cliente
    UPDATE Cliente
    SET Nombre = @Nombre,
        ApPaterno = @ApPaterno,
        ApMaterno = @ApMaterno,
        FechaNacimiento = @FechaNacimiento,
        TelefonoFijo = @TelefonoFijo,
        Correo = @Correo
    WHERE ClienteID = @ClienteID;
    
    -- Insertar registro de auditoría
    INSERT INTO Auditoria (FechaHora, OperacionID, UsuarioID, NombreTabla, IDTabla, Descripcion)
    VALUES (GETDATE(), (SELECT OperacionID FROM Operacion WHERE Nombre = 'Actualizar'), @EmpleadoID, 'Cliente', @ClienteID, 'Se actualizó la información del cliente');
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_AgregarCliente]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_AgregarCliente]
    @EmpleadoID INT,
    @Nombre VARCHAR(50),
    @ApPaterno VARCHAR(50),
    @ApMaterno VARCHAR(50),
    @FechaNacimiento DATE,
    @TelefonoFijo VARCHAR(10),
    @Correo VARCHAR(64)
AS
BEGIN
    DECLARE @ClienteID INT;
    
    -- Insertar nuevo cliente
    INSERT INTO Cliente (Nombre, ApPaterno, ApMaterno, FechaNacimiento, TelefonoFijo, Correo)
    VALUES (@Nombre, @ApPaterno, @ApMaterno, @FechaNacimiento, @TelefonoFijo, @Correo);

    -- Obtener ID del cliente recién insertado
    SET @ClienteID = SCOPE_IDENTITY();
    
    -- Insertar registro de auditoría
    INSERT INTO Auditoria (FechaHora, OperacionID, UsuarioID, NombreTabla, IDTabla, Descripcion)
    VALUES (GETDATE(), (SELECT OperacionID FROM Operacion WHERE Nombre = 'Crear'), @EmpleadoID, 'Cliente', @ClienteID, 'Se agregó un nuevo cliente');
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_CrearSuscripcion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_CrearSuscripcion]
    @EmpleadoID INT,
    @DocumentoIdentidadID INT,
    @PlanSuscripcionID INT,
    @DireccionID INT,
    @CicloFacturacionID INT,
    @FechaVenta DATE,
    @FechaInstalacion DATE
AS
BEGIN
    DECLARE @SuscripcionID INT;

    -- Insertar nueva suscripción
    INSERT INTO Suscripcion (DocumentoIdentidadID, PlanSuscripcionID, DireccionID, CicloFacturacionID, FechaVenta, FechaInstalacion)
    VALUES (@DocumentoIdentidadID, @PlanSuscripcionID, @DireccionID, @CicloFacturacionID, @FechaVenta, @FechaInstalacion);

    -- Obtener ID de la suscripción recién insertada
    SET @SuscripcionID = SCOPE_IDENTITY();

    -- Insertar registro de auditoría
    INSERT INTO Auditoria (FechaHora, OperacionID, UsuarioID, NombreTabla, IDTabla, Descripcion)
    VALUES (GETDATE(), (SELECT OperacionID FROM Operacion WHERE Nombre = 'Crear'), @EmpleadoID, 'Suscripcion', @SuscripcionID, 'Se creó una nueva suscripción');
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_RealizarPago]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RealizarPago]
    @EmpleadoID INT,
    @FacturaID INT,
    @MontoPago DECIMAL(10, 2)
AS
BEGIN
    DECLARE @PagoID INT;

    -- Insertar nuevo pago
    INSERT INTO Pago (FacturaID, FechaHora, MontoPago)
    VALUES (@FacturaID, GETDATE(), @MontoPago);

    -- Obtener ID del pago recién insertado
    SET @PagoID = SCOPE_IDENTITY();

    -- Insertar registro de auditoría
    INSERT INTO Auditoria (FechaHora, OperacionID, UsuarioID, NombreTabla, IDTabla, Descripcion)
    VALUES (GETDATE(), (SELECT OperacionID FROM Operacion WHERE Nombre = 'Crear'), @EmpleadoID, 'Pago', @PagoID, 'Se realizó un pago');
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_RegistrarComunicacion]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RegistrarComunicacion]
    @EmpleadoID INT,
    @SuscripcionID INT,
    @TipoComunicacionID INT,
    @Mensaje VARCHAR(1024)
AS
BEGIN
    DECLARE @ComunicacionID INT;

    -- Insertar nueva comunicación
    INSERT INTO Comunicacion (SuscripcionID, TipoComunicacionID, Mensaje, FechaHora)
    VALUES (@SuscripcionID, @TipoComunicacionID, @Mensaje, GETDATE());

    -- Obtener ID de la comunicación recién insertada
    SET @ComunicacionID = SCOPE_IDENTITY();

    -- Insertar registro de auditoría
    INSERT INTO Auditoria (FechaHora, OperacionID, UsuarioID, NombreTabla, IDTabla, Descripcion)
    VALUES (GETDATE(), (SELECT OperacionID FROM Operacion WHERE Nombre = 'Crear'), @EmpleadoID, 'Comunicacion', @ComunicacionID, 'Se registró una comunicación');
END;

GO
/****** Object:  Trigger [dbo].[t_DeleteAuditoria]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[t_DeleteAuditoria]
ON [dbo].[Auditoria]
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR ('No se permite la eliminación de registros en la tabla Auditoria.', 16, 1);
END;
GO
ALTER TABLE [dbo].[Auditoria] ENABLE TRIGGER [t_DeleteAuditoria]
GO
/****** Object:  Trigger [dbo].[t_VerificarDetalleFactura]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[t_VerificarDetalleFactura]
ON [dbo].[DetalleFactura]
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM deleted D
        INNER JOIN Pago P ON D.FacturaID = P.FacturaID
        WHERE P.PagoID IS NOT NULL
    )
    BEGIN
        RAISERROR ('No se puede eliminar la factura porque existen pagos asociados.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;
GO
ALTER TABLE [dbo].[DetalleFactura] ENABLE TRIGGER [t_VerificarDetalleFactura]
GO
/****** Object:  Trigger [dbo].[t_RestriccionPermiso]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[t_RestriccionPermiso]
ON [dbo].[Permiso]
AFTER DELETE
AS
BEGIN
    RAISERROR ('No se permite eliminar este permiso.', 16, 1);
    ROLLBACK TRANSACTION;
END;
GO
ALTER TABLE [dbo].[Permiso] ENABLE TRIGGER [t_RestriccionPermiso]
GO
/****** Object:  Trigger [dbo].[t_EliminacionProducto]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[t_EliminacionProducto]
ON [dbo].[Producto]
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM DetallePlan DP
        INNER JOIN deleted D ON DP.ProductoID = D.ProductoID
    )
    BEGIN
        RAISERROR ('No se puede eliminar el producto porque tiene detalles de planes de suscripción asociados.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM Producto
        WHERE ProductoID IN (SELECT ProductoID FROM deleted);
    END
END;
GO
ALTER TABLE [dbo].[Producto] ENABLE TRIGGER [t_EliminacionProducto]
GO
/****** Object:  Trigger [dbo].[t_PrevenirEliminacionUsuario]    Script Date: 02/07/2024 05:47:07 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[t_PrevenirEliminacionUsuario]
ON [dbo].[Usuario]
INSTEAD OF DELETE
AS
BEGIN
    RAISERROR ('No se permite eliminar usuarios de esta tabla.', 16, 1);
    ROLLBACK TRANSACTION;
END;
GO
ALTER TABLE [dbo].[Usuario] ENABLE TRIGGER [t_PrevenirEliminacionUsuario]
GO
USE [master]
GO
ALTER DATABASE [DataGenius] SET  READ_WRITE 
GO
