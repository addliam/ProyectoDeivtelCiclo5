USE [master]
GO
/****** Object:  Database [DataGeniusETL]    Script Date: 04/07/2024 02:59:56 p.m. ******/
CREATE DATABASE [DataGeniusETL]
GO
ALTER DATABASE [DataGeniusETL] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DataGeniusETL].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DataGeniusETL] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DataGeniusETL] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DataGeniusETL] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DataGeniusETL] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DataGeniusETL] SET ARITHABORT OFF 
GO
ALTER DATABASE [DataGeniusETL] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DataGeniusETL] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DataGeniusETL] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DataGeniusETL] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DataGeniusETL] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DataGeniusETL] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DataGeniusETL] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DataGeniusETL] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DataGeniusETL] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DataGeniusETL] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DataGeniusETL] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DataGeniusETL] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DataGeniusETL] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DataGeniusETL] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DataGeniusETL] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DataGeniusETL] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DataGeniusETL] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DataGeniusETL] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DataGeniusETL] SET  MULTI_USER 
GO
ALTER DATABASE [DataGeniusETL] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DataGeniusETL] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DataGeniusETL] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DataGeniusETL] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DataGeniusETL] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DataGeniusETL] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DataGeniusETL', N'ON'
GO
ALTER DATABASE [DataGeniusETL] SET QUERY_STORE = ON
GO
ALTER DATABASE [DataGeniusETL] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DataGeniusETL]
GO
/****** Object:  Table [dbo].[DIM_CICLO_FACTURACION]    Script Date: 04/07/2024 02:59:56 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIM_CICLO_FACTURACION](
	[CicloFacturacionID] [int] NOT NULL,
	[NombreCiclo] [nvarchar](20) NULL,
	[DiaCiclico] [int] NULL,
	[DiasAdicionalVencimiento] [int] NULL,
	[DiasCorte] [int] NULL,
 CONSTRAINT [PKCICL] PRIMARY KEY CLUSTERED 
(
	[CicloFacturacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIM_CLIENTE]    Script Date: 04/07/2024 02:59:56 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIM_CLIENTE](
	[ClienteID] [int] NOT NULL,
	[NombreCliente] [nvarchar](50) NULL,
	[FechaNacimiento] [date] NULL,
	[TelefonoFijo] [nvarchar](10) NULL,
	[Correo] [nvarchar](64) NULL,
 CONSTRAINT [PKCLIENT] PRIMARY KEY CLUSTERED 
(
	[ClienteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIM_DIRECCION]    Script Date: 04/07/2024 02:59:56 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIM_DIRECCION](
	[DireccionID] [int] NOT NULL,
	[Nombre] [nvarchar](64) NULL,
	[Referencia] [nvarchar](64) NULL,
 CONSTRAINT [PKDIREC] PRIMARY KEY CLUSTERED 
(
	[DireccionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIM_PLAN]    Script Date: 04/07/2024 02:59:56 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIM_PLAN](
	[DetallePlanID] [int] NOT NULL,
	[Precio] [numeric](6, 2) NULL,
	[Nombre] [nvarchar](32) NULL,
 CONSTRAINT [PKPL] PRIMARY KEY CLUSTERED 
(
	[DetallePlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIM_TIEMPO]    Script Date: 04/07/2024 02:59:56 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIM_TIEMPO](
	[SuscripcionID] [int] NOT NULL,
	[FechaVenta] [date] NULL,
	[FechaInstalacion] [date] NULL,
 CONSTRAINT [PKTIEM] PRIMARY KEY CLUSTERED 
(
	[SuscripcionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[H_VENTAS]    Script Date: 04/07/2024 02:59:56 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[H_VENTAS](
	[DiaInicio] [date] NULL,
	[DiaFin] [date] NULL,
	[DiaVencimiento] [date] NULL,
	[MontoCalculado] [numeric](10, 2) NULL,
	[ClienteID] [int] NULL,
	[CicloFacturacionID] [int] NULL,
	[DetallePlanID] [int] NULL,
	[DireccionID] [int] NULL,
	[SuscripcionID] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (1, N'ciclo 5', 6, 15, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (2, N'ciclo 17', 18, 15, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (3, N'ciclo 31', 1, 17, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (4, N'ciclo 10', 11, 12, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (5, N'ciclo 12', 13, 14, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (6, N'ciclo 14', 15, 16, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (7, N'ciclo 16', 17, 18, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (8, N'ciclo 18', 19, 20, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (9, N'ciclo 20', 21, 22, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (10, N'ciclo 22', 23, 24, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (11, N'ciclo 24', 25, 26, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (12, N'ciclo 26', 27, 28, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (13, N'ciclo 28', 29, 30, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (14, N'ciclo 30', 31, 32, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (15, N'ciclo 32', 1, 33, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (16, N'ciclo 34', 3, 34, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (17, N'ciclo 36', 5, 35, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (18, N'ciclo 38', 7, 36, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (19, N'ciclo 40', 9, 37, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (20, N'ciclo 42', 11, 38, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (21, N'ciclo 44', 13, 39, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (22, N'ciclo 46', 15, 40, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (23, N'ciclo 48', 17, 41, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (24, N'ciclo 50', 19, 42, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (25, N'ciclo 52', 21, 43, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (26, N'ciclo 54', 23, 44, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (27, N'ciclo 56', 25, 45, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (28, N'ciclo 58', 27, 46, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (29, N'ciclo 60', 29, 47, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (30, N'ciclo 62', 31, 48, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (31, N'ciclo 64', 2, 49, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (32, N'ciclo 66', 4, 50, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (33, N'ciclo 68', 6, 51, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (34, N'ciclo 70', 8, 52, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (35, N'ciclo 72', 10, 53, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (36, N'ciclo 74', 12, 54, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (37, N'ciclo 76', 14, 55, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (38, N'ciclo 78', 16, 56, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (39, N'ciclo 80', 18, 57, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (40, N'ciclo 82', 20, 58, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (41, N'ciclo 84', 22, 59, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (42, N'ciclo 86', 24, 60, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (43, N'ciclo 88', 26, 61, 5)
INSERT [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID], [NombreCiclo], [DiaCiclico], [DiasAdicionalVencimiento], [DiasCorte]) VALUES (44, N'ciclo 90', 28, 62, 5)
GO
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (1, N'Adrian', CAST(N'2000-03-01' AS Date), NULL, N'azevallos43@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (2, N'Alonso', CAST(N'1997-08-14' AS Date), N'352384', N'camposnor97@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (3, N'Belen', CAST(N'2003-10-23' AS Date), NULL, NULL)
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (4, N'Carlos', CAST(N'1990-05-21' AS Date), N'485293', N'cgomez90@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (5, N'Diana', CAST(N'1988-12-11' AS Date), NULL, N'dflores88@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (6, N'Elena', CAST(N'1995-06-07' AS Date), N'284937', N'eramos95@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (7, N'Fernando', CAST(N'1992-04-15' AS Date), NULL, N'fcastro92@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (8, N'Gabriela', CAST(N'1999-09-27' AS Date), N'657384', N'gruiz99@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (9, N'Hector', CAST(N'1985-01-03' AS Date), NULL, N'hsanchez85@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (10, N'Isabel', CAST(N'1993-11-19' AS Date), N'492857', N'imartinez93@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (11, N'Javier', CAST(N'1980-07-30' AS Date), NULL, N'jvargas80@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (12, N'Karen', CAST(N'1987-02-22' AS Date), N'948372', N'kguzman87@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (13, N'Luis', CAST(N'1991-10-13' AS Date), NULL, N'lparedes91@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (14, N'Mariana', CAST(N'2000-12-05' AS Date), N'573829', N'mtorres00@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (15, N'Nicolas', CAST(N'1998-08-09' AS Date), NULL, N'nlopez98@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (16, N'Olga', CAST(N'1975-03-14' AS Date), N'293857', N'ojimenez75@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (17, N'Pablo', CAST(N'1994-07-18' AS Date), NULL, N'pmendoza94@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (18, N'Quintin', CAST(N'1986-11-23' AS Date), N'384756', N'qcastillo86@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (19, N'Raquel', CAST(N'1997-01-07' AS Date), NULL, N'rsoto97@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (20, N'Sebastian', CAST(N'1996-06-12' AS Date), N'584736', N'svela96@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (21, N'Tatiana', CAST(N'2002-04-28' AS Date), NULL, N'tbravo02@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (22, N'Ulises', CAST(N'1989-05-17' AS Date), N'695738', N'ucarranza89@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (23, N'Valeria', CAST(N'1992-09-04' AS Date), NULL, N'vfernandez92@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (24, N'Walter', CAST(N'1995-02-20' AS Date), N'472839', N'wherrera95@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (25, N'Ximena', CAST(N'1983-12-15' AS Date), NULL, N'xiglesias83@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (26, N'Yolanda', CAST(N'1990-08-29' AS Date), N'283945', N'yjuarez90@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (27, N'Zoe', CAST(N'2001-11-06' AS Date), NULL, N'zkim01@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (28, N'Ana', CAST(N'1994-09-10' AS Date), NULL, N'amartinez94@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (29, N'Benjamin', CAST(N'1998-07-25' AS Date), N'627485', N'bgonzalez98@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (30, N'Catalina', CAST(N'1989-04-18' AS Date), NULL, N'crivera89@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (31, N'Diego', CAST(N'1996-11-03' AS Date), N'485739', N'dhernandez96@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (32, N'Estela', CAST(N'1987-08-22' AS Date), NULL, N'emolina87@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (33, N'Felipe', CAST(N'1992-03-15' AS Date), N'573829', N'fvalencia92@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (34, N'Gloria', CAST(N'1985-12-08' AS Date), NULL, N'ggutierrez85@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (35, N'Hugo', CAST(N'1991-10-27' AS Date), N'695738', N'hmoreno91@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (36, N'Ines', CAST(N'1999-05-14' AS Date), NULL, N'isantos99@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (37, N'Jorge', CAST(N'1983-02-07' AS Date), N'284937', N'jperalta83@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (38, N'Karina', CAST(N'1997-09-30' AS Date), NULL, N'kcruz97@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (39, N'Luisa', CAST(N'1988-06-23' AS Date), N'384756', N'lmendoza88@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (40, N'Marco', CAST(N'1995-04-12' AS Date), NULL, N'mortega95@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (41, N'Natalia', CAST(N'1984-01-05' AS Date), N'472839', N'nfernandez84@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (42, N'Oscar', CAST(N'1993-08-18' AS Date), NULL, N'orios93@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (43, N'Paola', CAST(N'1990-05-09' AS Date), N'293857', N'pgomez90@gmail.com')
INSERT [dbo].[DIM_CLIENTE] ([ClienteID], [NombreCliente], [FechaNacimiento], [TelefonoFijo], [Correo]) VALUES (44, N'Quirino', CAST(N'1986-12-29' AS Date), NULL, N'qjimenez86@gmail.com')
GO
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (1, N'Av. Las Flores 1234, Apt. 567, Canto Rey', N'A 1 cuadra del grifo Primax')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (2, N'Jirón Las Lomas 456, Canto Grande', N'Detrás del centro comercial')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (3, N'Av. Las Flores de Primavera 123, Canto Grande', N'Al costado del banco, casa 3 pisos, fachada Blanca')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (4, N'Calle Los Jardines 120, Canto Grande', N'Cerca del colegio')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (5, N'Calle Los Pinos 789, Canto Grande', N'Frente al parque central')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (6, N'Av. Los Álamos 555, Canto Rey', N'A 2 cuadras del mercado')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (7, N'Jirón Los Rosales 890, Canto Rey', N'Cerca del hospital')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (8, N'Av. Los Cedros 321, Apt. 101, Canto Rey', N'En el segundo piso')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (9, N'Calle Las Magnolias 456, Canto Rey', N'A la vuelta de la farmacia')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (10, N'Jirón Las Begonias 789, Canto Rey', N'Frente al parque de diversiones')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (11, N'Av. Los Girasoles 123, Apt. 203, Canto Rey', N'A un lado del supermercado')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (12, N'Calle Las Orquídeas 456, Canto Rey', N'Casa con puerta roja')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (13, N'Jirón Los Lirios 789, Canto Rey', N'Edificio color beige')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (14, N'Av. Las Palmeras 321, Canto Rey', N'Cerca del estadio municipal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (15, N'Calle Los Tulipanes 555, Canto Rey', N'Al costado del parque infantil')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (16, N'Jirón Las Hortensias 890, Canto Rey', N'Detrás del centro médico')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (17, N'Av. Los Sauces 678, Canto Rey', N'A la vuelta del colegio')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (18, N'Calle Las Azucenas 456, Canto Rey', N'Frente al parque de los bomberos')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (19, N'Jirón Las Dalias 789, Canto Rey', N'A 2 cuadras del centro cultural')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (20, N'Av. Las Violetas 123, Apt. 404, Canto Rey', N'En el cuarto piso')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (21, N'Av. Los Cipreses 567, Canto Grande', N'Cerca del mercado principal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (22, N'Calle Los Abedules 890, Canto Grande', N'Frente a la plaza central')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (23, N'Jirón Las Acacias 234, Canto Grande', N'Al lado del paradero de buses')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (24, N'Av. Los Eucaliptos 789, Canto Grande', N'En la esquina con la avenida principal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (25, N'Calle Los Robles 567, Canto Grande', N'Frente al centro educativo')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (26, N'Jirón Las Margaritas 890, Canto Grande', N'A 3 cuadras del centro de salud')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (27, N'Av. Las Begonias 234, Canto Grande', N'Junto al parque recreacional')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (28, N'Calle Las Orquídeas 789, Canto Grande', N'En la zona residencial')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (29, N'Jirón Los Girasoles 567, Canto Grande', N'Cerca del centro comunal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (30, N'Av. Las Violetas 890, Canto Grande', N'Frente al campo deportivo')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (31, N'Calle Las Azucenas 234, Canto Grande', N'Junto al mercado de abastos')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (32, N'Jirón Las Dalias 789, Canto Grande', N'En la avenida principal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (33, N'Av. Los Lirios 567, Canto Grande', N'Al costado de la estación de policía')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (34, N'Calle Las Rosas 890, Canto Grande', N'Frente al parque industrial')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (35, N'Jirón Las Magnolias 234, Canto Grande', N'Junto a la iglesia principal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (36, N'Av. Los Sauces 789, Canto Grande', N'En el centro de la urbanización')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (37, N'Calle Las Acacias 567, Canto Grande', N'Al lado del centro de eventos')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (38, N'Jirón Los Girasoles 890, Canto Grande', N'En la avenida principal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (39, N'Av. Las Begonias 234, Canto Grande', N'Frente al centro comercial')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (40, N'Calle Los Lirios 789, Canto Grande', N'Junto al parque')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (41, N'Jirón Las Rosas 567, Canto Grande', N'En la esquina con la avenida principal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (42, N'Av. Los Jazmines 890, Canto Grande', N'Al costado del colegio')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (43, N'Calle Las Orquídeas 234, Canto Grande', N'Cerca del hospital')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (44, N'Jirón Los Cedros 789, Canto Grande', N'En el centro de la ciudad')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (45, N'Av. Las Margaritas 567, Canto Grande', N'Frente al mercado municipal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (46, N'Calle Los Eucaliptos 890, Canto Grande', N'A un lado del parque central')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (47, N'Jirón Las Violetas 234, Canto Grande', N'En la esquina con la avenida principal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (48, N'Av. Los Robles 789, Canto Grande', N'Junto a la plaza principal')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (49, N'Calle Las Begonias 567, Canto Grande', N'Cerca del parque recreativo')
INSERT [dbo].[DIM_DIRECCION] ([DireccionID], [Nombre], [Referencia]) VALUES (50, N'Jirón Las Acacias 890, Canto Grande', N'Al lado del centro educativo')
GO
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (1, CAST(35.00 AS Numeric(6, 2)), N'TV 35')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (2, CAST(50.00 AS Numeric(6, 2)), N'Internet 70 MB')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (3, CAST(35.00 AS Numeric(6, 2)), N'TV 35')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (4, CAST(34.00 AS Numeric(6, 2)), N'Internet 50 MB')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (5, CAST(79.00 AS Numeric(6, 2)), N'Internet 80 MB')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (6, CAST(10.00 AS Numeric(6, 2)), N'TV 10')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (7, CAST(79.00 AS Numeric(6, 2)), N'Internet 80 MB')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (8, CAST(99.00 AS Numeric(6, 2)), N'Internet 100 MB')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (9, CAST(99.00 AS Numeric(6, 2)), N'Internet 100 MB')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (10, CAST(20.00 AS Numeric(6, 2)), N'TV 20')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (11, CAST(129.00 AS Numeric(6, 2)), N'Internet 150 MB')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (12, CAST(129.00 AS Numeric(6, 2)), N'Internet 150 MB')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (13, CAST(20.00 AS Numeric(6, 2)), N'TV 20')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (14, CAST(179.00 AS Numeric(6, 2)), N'Internet 200 MB')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (15, CAST(179.00 AS Numeric(6, 2)), N'Internet 200 MB')
INSERT [dbo].[DIM_PLAN] ([DetallePlanID], [Precio], [Nombre]) VALUES (16, CAST(20.00 AS Numeric(6, 2)), N'TV 20')
GO
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (1, CAST(N'2024-01-01' AS Date), CAST(N'2024-01-05' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (2, CAST(N'2024-04-15' AS Date), CAST(N'2023-10-24' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (3, CAST(N'2024-05-10' AS Date), CAST(N'2024-05-15' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (4, CAST(N'2024-06-01' AS Date), CAST(N'2024-06-15' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (5, CAST(N'2024-06-02' AS Date), CAST(N'2024-06-16' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (6, CAST(N'2024-06-03' AS Date), CAST(N'2024-06-17' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (7, CAST(N'2024-06-04' AS Date), CAST(N'2024-06-18' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (8, CAST(N'2024-06-05' AS Date), CAST(N'2024-06-19' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (9, CAST(N'2024-06-06' AS Date), CAST(N'2024-06-20' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (10, CAST(N'2024-06-07' AS Date), CAST(N'2024-06-21' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (11, CAST(N'2024-06-08' AS Date), CAST(N'2024-06-22' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (12, CAST(N'2024-06-09' AS Date), CAST(N'2024-06-23' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (13, CAST(N'2024-06-10' AS Date), CAST(N'2024-06-24' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (14, CAST(N'2024-06-11' AS Date), CAST(N'2024-06-25' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (15, CAST(N'2024-06-12' AS Date), CAST(N'2024-06-26' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (16, CAST(N'2024-06-13' AS Date), CAST(N'2024-06-27' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (17, CAST(N'2024-06-14' AS Date), CAST(N'2024-06-28' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (18, CAST(N'2024-06-15' AS Date), CAST(N'2024-06-29' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (19, CAST(N'2024-06-16' AS Date), CAST(N'2024-06-30' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (20, CAST(N'2024-06-17' AS Date), CAST(N'2024-07-01' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (21, CAST(N'2024-06-18' AS Date), CAST(N'2024-07-02' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (22, CAST(N'2024-06-19' AS Date), CAST(N'2024-07-03' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (23, CAST(N'2024-06-20' AS Date), CAST(N'2024-07-04' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (24, CAST(N'2024-06-21' AS Date), CAST(N'2024-07-05' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (25, CAST(N'2024-06-22' AS Date), CAST(N'2024-07-06' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (26, CAST(N'2024-06-23' AS Date), CAST(N'2024-07-07' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (27, CAST(N'2024-06-24' AS Date), CAST(N'2024-07-08' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (28, CAST(N'2024-06-25' AS Date), CAST(N'2024-07-09' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (29, CAST(N'2024-06-26' AS Date), CAST(N'2024-07-10' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (30, CAST(N'2024-06-27' AS Date), CAST(N'2024-07-11' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (31, CAST(N'2024-06-28' AS Date), CAST(N'2024-07-12' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (32, CAST(N'2024-06-29' AS Date), CAST(N'2024-07-13' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (33, CAST(N'2024-06-30' AS Date), CAST(N'2024-07-14' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (34, CAST(N'2024-07-01' AS Date), CAST(N'2024-07-15' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (35, CAST(N'2024-07-02' AS Date), CAST(N'2024-07-16' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (36, CAST(N'2024-07-03' AS Date), CAST(N'2024-07-17' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (37, CAST(N'2024-07-04' AS Date), CAST(N'2024-07-18' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (38, CAST(N'2024-07-05' AS Date), CAST(N'2024-07-19' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (39, CAST(N'2024-07-06' AS Date), CAST(N'2024-07-20' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (40, CAST(N'2024-07-07' AS Date), CAST(N'2024-07-21' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (41, CAST(N'2024-07-08' AS Date), CAST(N'2024-07-22' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (42, CAST(N'2024-07-09' AS Date), CAST(N'2024-07-23' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (43, CAST(N'2024-07-10' AS Date), CAST(N'2024-07-24' AS Date))
INSERT [dbo].[DIM_TIEMPO] ([SuscripcionID], [FechaVenta], [FechaInstalacion]) VALUES (44, CAST(N'2024-07-11' AS Date), CAST(N'2024-07-25' AS Date))
GO
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-01-06' AS Date), CAST(N'2024-02-05' AS Date), CAST(N'2024-02-21' AS Date), CAST(149.00 AS Numeric(10, 2)), 1, 1, NULL, 1, 1)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-02-06' AS Date), CAST(N'2024-03-05' AS Date), CAST(N'2024-03-21' AS Date), CAST(159.00 AS Numeric(10, 2)), 2, 2, NULL, 2, 2)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-03-06' AS Date), CAST(N'2024-04-05' AS Date), CAST(N'2024-04-21' AS Date), CAST(179.00 AS Numeric(10, 2)), 3, 3, NULL, 3, 3)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-04-06' AS Date), CAST(N'2024-05-05' AS Date), CAST(N'2024-05-21' AS Date), CAST(199.00 AS Numeric(10, 2)), 4, 4, NULL, 4, 4)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-05-06' AS Date), CAST(N'2024-06-05' AS Date), CAST(N'2024-06-21' AS Date), CAST(219.00 AS Numeric(10, 2)), 5, 5, NULL, 5, 5)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-06-06' AS Date), CAST(N'2024-07-05' AS Date), CAST(N'2024-07-21' AS Date), CAST(239.00 AS Numeric(10, 2)), 6, 6, NULL, 6, 6)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-07-06' AS Date), CAST(N'2024-08-05' AS Date), CAST(N'2024-08-21' AS Date), CAST(259.00 AS Numeric(10, 2)), 7, 7, NULL, 7, 7)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-08-06' AS Date), CAST(N'2024-09-05' AS Date), CAST(N'2024-09-21' AS Date), CAST(279.00 AS Numeric(10, 2)), 8, 8, NULL, 8, 8)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-09-06' AS Date), CAST(N'2024-10-05' AS Date), CAST(N'2024-10-21' AS Date), CAST(299.00 AS Numeric(10, 2)), 9, 9, NULL, 9, 9)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-10-06' AS Date), CAST(N'2024-11-05' AS Date), CAST(N'2024-11-21' AS Date), CAST(319.00 AS Numeric(10, 2)), 10, 10, NULL, 10, 10)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-11-06' AS Date), CAST(N'2024-12-05' AS Date), CAST(N'2024-12-21' AS Date), CAST(339.00 AS Numeric(10, 2)), 11, 11, NULL, 11, 11)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2024-12-06' AS Date), CAST(N'2025-01-05' AS Date), CAST(N'2025-01-21' AS Date), CAST(359.00 AS Numeric(10, 2)), 12, 12, NULL, 12, 12)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-01-06' AS Date), CAST(N'2025-02-05' AS Date), CAST(N'2025-02-21' AS Date), CAST(379.00 AS Numeric(10, 2)), 13, 13, NULL, 13, 13)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-02-06' AS Date), CAST(N'2025-03-05' AS Date), CAST(N'2025-03-21' AS Date), CAST(399.00 AS Numeric(10, 2)), 14, 14, NULL, 14, 14)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-03-06' AS Date), CAST(N'2025-04-05' AS Date), CAST(N'2025-04-21' AS Date), CAST(419.00 AS Numeric(10, 2)), 15, 15, NULL, 15, 15)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-04-06' AS Date), CAST(N'2025-05-05' AS Date), CAST(N'2025-05-21' AS Date), CAST(439.00 AS Numeric(10, 2)), 16, 16, NULL, 16, 16)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-05-06' AS Date), CAST(N'2025-06-05' AS Date), CAST(N'2025-06-21' AS Date), CAST(489.00 AS Numeric(10, 2)), 17, 17, NULL, 17, 17)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-06-06' AS Date), CAST(N'2025-07-05' AS Date), CAST(N'2025-07-21' AS Date), CAST(459.00 AS Numeric(10, 2)), 18, 18, NULL, 18, 18)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-07-06' AS Date), CAST(N'2025-08-05' AS Date), CAST(N'2025-08-21' AS Date), CAST(479.00 AS Numeric(10, 2)), 19, 19, NULL, 19, 19)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-08-06' AS Date), CAST(N'2025-09-05' AS Date), CAST(N'2025-09-21' AS Date), CAST(499.00 AS Numeric(10, 2)), 20, 20, NULL, 20, 20)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-09-06' AS Date), CAST(N'2025-10-05' AS Date), CAST(N'2025-10-21' AS Date), CAST(519.00 AS Numeric(10, 2)), 21, 21, NULL, 21, 21)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-10-06' AS Date), CAST(N'2025-11-05' AS Date), CAST(N'2025-11-21' AS Date), CAST(539.00 AS Numeric(10, 2)), 22, 22, NULL, 22, 22)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-11-06' AS Date), CAST(N'2025-12-05' AS Date), CAST(N'2025-12-21' AS Date), CAST(559.00 AS Numeric(10, 2)), 23, 23, NULL, 23, 23)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2025-12-06' AS Date), CAST(N'2026-01-05' AS Date), CAST(N'2026-01-21' AS Date), CAST(579.00 AS Numeric(10, 2)), 24, 24, NULL, 24, 24)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-01-06' AS Date), CAST(N'2026-02-05' AS Date), CAST(N'2026-02-21' AS Date), CAST(599.00 AS Numeric(10, 2)), 25, 25, NULL, 25, 25)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-02-06' AS Date), CAST(N'2026-03-05' AS Date), CAST(N'2026-03-21' AS Date), CAST(619.00 AS Numeric(10, 2)), 26, 26, NULL, 26, 26)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-03-06' AS Date), CAST(N'2026-04-05' AS Date), CAST(N'2026-04-21' AS Date), CAST(639.00 AS Numeric(10, 2)), 27, 27, NULL, 27, 27)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-04-06' AS Date), CAST(N'2026-05-05' AS Date), CAST(N'2026-05-21' AS Date), CAST(659.00 AS Numeric(10, 2)), 28, 28, NULL, 28, 28)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-05-06' AS Date), CAST(N'2026-06-05' AS Date), CAST(N'2026-06-21' AS Date), CAST(679.00 AS Numeric(10, 2)), 29, 29, NULL, 29, 29)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-06-06' AS Date), CAST(N'2026-07-05' AS Date), CAST(N'2026-07-21' AS Date), CAST(699.00 AS Numeric(10, 2)), 30, 30, NULL, 30, 30)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-07-06' AS Date), CAST(N'2026-08-05' AS Date), CAST(N'2026-08-21' AS Date), CAST(719.00 AS Numeric(10, 2)), 31, 31, NULL, 31, 31)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-08-06' AS Date), CAST(N'2026-09-05' AS Date), CAST(N'2026-09-21' AS Date), CAST(739.00 AS Numeric(10, 2)), 32, 32, NULL, 32, 32)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-09-06' AS Date), CAST(N'2026-10-05' AS Date), CAST(N'2026-10-21' AS Date), CAST(759.00 AS Numeric(10, 2)), 33, 33, NULL, 33, 33)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-10-06' AS Date), CAST(N'2026-11-05' AS Date), CAST(N'2026-11-21' AS Date), CAST(779.00 AS Numeric(10, 2)), 34, 34, NULL, 34, 34)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-11-06' AS Date), CAST(N'2026-12-05' AS Date), CAST(N'2026-12-21' AS Date), CAST(799.00 AS Numeric(10, 2)), 35, 35, NULL, 35, 35)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2026-12-06' AS Date), CAST(N'2027-01-05' AS Date), CAST(N'2027-01-21' AS Date), CAST(819.00 AS Numeric(10, 2)), 36, 36, NULL, 36, 36)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2027-01-06' AS Date), CAST(N'2027-02-05' AS Date), CAST(N'2027-02-21' AS Date), CAST(839.00 AS Numeric(10, 2)), 37, 37, NULL, 37, 37)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2027-02-06' AS Date), CAST(N'2027-03-05' AS Date), CAST(N'2027-03-21' AS Date), CAST(859.00 AS Numeric(10, 2)), 38, 38, NULL, 38, 38)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2027-03-06' AS Date), CAST(N'2027-04-05' AS Date), CAST(N'2027-04-21' AS Date), CAST(879.00 AS Numeric(10, 2)), 39, 39, NULL, 39, 39)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2027-04-06' AS Date), CAST(N'2027-05-05' AS Date), CAST(N'2027-05-21' AS Date), CAST(899.00 AS Numeric(10, 2)), 40, 40, NULL, 40, 40)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2027-05-06' AS Date), CAST(N'2027-06-05' AS Date), CAST(N'2027-06-21' AS Date), CAST(919.00 AS Numeric(10, 2)), 41, 41, NULL, 41, 41)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2027-06-06' AS Date), CAST(N'2027-07-05' AS Date), CAST(N'2027-07-21' AS Date), CAST(939.00 AS Numeric(10, 2)), 42, 42, NULL, 42, 42)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2027-07-06' AS Date), CAST(N'2027-08-05' AS Date), CAST(N'2027-08-21' AS Date), CAST(959.00 AS Numeric(10, 2)), 43, 43, NULL, 43, 43)
INSERT [dbo].[H_VENTAS] ([DiaInicio], [DiaFin], [DiaVencimiento], [MontoCalculado], [ClienteID], [CicloFacturacionID], [DetallePlanID], [DireccionID], [SuscripcionID]) VALUES (CAST(N'2027-08-06' AS Date), CAST(N'2027-09-05' AS Date), CAST(N'2027-09-21' AS Date), CAST(979.00 AS Numeric(10, 2)), 44, 44, NULL, 44, 44)
GO
ALTER TABLE [dbo].[H_VENTAS]  WITH NOCHECK ADD  CONSTRAINT [fk1] FOREIGN KEY([ClienteID])
REFERENCES [dbo].[DIM_CLIENTE] ([ClienteID])
GO
ALTER TABLE [dbo].[H_VENTAS] CHECK CONSTRAINT [fk1]
GO
ALTER TABLE [dbo].[H_VENTAS]  WITH NOCHECK ADD  CONSTRAINT [fk2] FOREIGN KEY([CicloFacturacionID])
REFERENCES [dbo].[DIM_CICLO_FACTURACION] ([CicloFacturacionID])
GO
ALTER TABLE [dbo].[H_VENTAS] CHECK CONSTRAINT [fk2]
GO
ALTER TABLE [dbo].[H_VENTAS]  WITH NOCHECK ADD  CONSTRAINT [fk3] FOREIGN KEY([DetallePlanID])
REFERENCES [dbo].[DIM_PLAN] ([DetallePlanID])
GO
ALTER TABLE [dbo].[H_VENTAS] CHECK CONSTRAINT [fk3]
GO
ALTER TABLE [dbo].[H_VENTAS]  WITH NOCHECK ADD  CONSTRAINT [fk4] FOREIGN KEY([DireccionID])
REFERENCES [dbo].[DIM_DIRECCION] ([DireccionID])
GO
ALTER TABLE [dbo].[H_VENTAS] CHECK CONSTRAINT [fk4]
GO
ALTER TABLE [dbo].[H_VENTAS]  WITH NOCHECK ADD  CONSTRAINT [fk5] FOREIGN KEY([SuscripcionID])
REFERENCES [dbo].[DIM_TIEMPO] ([SuscripcionID])
GO
ALTER TABLE [dbo].[H_VENTAS] CHECK CONSTRAINT [fk5]
GO
USE [master]
GO
ALTER DATABASE [DataGeniusETL] SET  READ_WRITE 
GO
