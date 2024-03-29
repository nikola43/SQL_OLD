
CREATE DATABASE [Flamenco]
 
GO
USE [Flamenco]
GO
/****** Object:  Table [dbo].[F_Actua]    Script Date: 04/02/2015 22:14:35 ******/

GO
CREATE TABLE [dbo].[F_Actua](
	[Cod_Penha] [char](3) NOT NULL,
	[Cod_Cantaor] [char](4) NOT NULL,
	[Num] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [smalldatetime] NULL,
 CONSTRAINT [PK_Actua] PRIMARY KEY (Num)
)

GO

CREATE TABLE [dbo].[F_Cantaores](
	[Codigo] [char](4) NOT NULL,
	[Nombre] [varchar](15) NULL,
	[Apellidos] [varchar](25) NULL,
	[Nombre_Artistico] [varchar](30) NOT NULL,
	[Localidad] [varchar](20) NULL,
	[Cod_Provincia] [char](2) NULL,
	[Anno] [smallint] NULL,
	[Sexo] [char](1) NULL,
 CONSTRAINT [PK_Cantaores] PRIMARY KEY (Codigo)
)

GO

CREATE TABLE [dbo].[F_Festivales](
	[Cod] [char](3) NOT NULL,
	[Denominacion] [varchar](30) NULL,
	[Localidad] [varchar](20) NULL,
	[Provincia] [char](2) NULL,
PRIMARY KEY (Cod)
) 


GO
CREATE TABLE [dbo].[F_Festivales_Cantaores](
	[Cod_Festival] [char](3) NOT NULL,
	[Cod_Cantaor] [char](4) NOT NULL,
	[Edicion] [int] NOT NULL,
 CONSTRAINT [PK_F_Festivales_Cantaores] PRIMARY KEY (Cod_Festival,Cod_Cantaor,Edicion)
) 


GO
CREATE TABLE [dbo].[F_Palos](
	[Cod_Palo] [char](2) NOT NULL,
	[Palo] [varchar](20) NULL,
 CONSTRAINT [PK_Palos] PRIMARY KEY (Cod_Palo)
 )

GO
CREATE TABLE [dbo].[F_Palos_Cantaor](
	[Cod_cantaor] [char](4) NOT NULL,
	[Cod_Palo] [char](2) NOT NULL,
 CONSTRAINT [PK_Palos_Cantaor] PRIMARY KEY (Cod_cantaor,Cod_Palo)
)
GO
CREATE TABLE [dbo].[F_Penhas](
	[Codigo] [char](3) NOT NULL,
	[Nombre] [varchar](30) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Fecha_fundacion] [smalldatetime] NULL,
	[Direccion] [varchar](30) NULL,
	[Localidad] [varchar](20) NULL,
	[Cod_provincia] [char](2) NULL,
	[Telefono] [char](15) NULL,
 CONSTRAINT [PK_Penhas] PRIMARY KEY (Codigo)
)


GO
CREATE TABLE [dbo].[F_Provincias](
	[Cod_Provincia] [char](2) NOT NULL,
	[Provincia] [varchar](15) NULL,
 CONSTRAINT [PK_Provincias] PRIMARY KEY (Cod_Provincia)
) 

GO
SET DateFormat 'YMD'
GO
SET IDENTITY_INSERT [dbo].[F_Actua] ON 

GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0001', 1, CAST(N'2004-12-31 03:48:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0005', 2, CAST(N'2004-07-25 16:42:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0009', 3, CAST(N'2001-08-22 06:08:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0011', 4, CAST(N'1988-10-19 04:05:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0017', 5, CAST(N'2004-04-27 12:18:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0038', 6, CAST(N'2011-02-08 03:27:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0039', 7, CAST(N'2006-02-07 21:53:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0057', 8, CAST(N'2003-03-06 16:30:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0078', 9, CAST(N'1994-11-23 23:25:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0088', 10, CAST(N'1987-04-19 18:20:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0094', 11, CAST(N'2008-08-06 22:31:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0111', 12, CAST(N'1999-05-09 19:15:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0123', 13, CAST(N'1992-10-07 23:20:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0144', 14, CAST(N'2014-04-30 21:20:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0158', 15, CAST(N'2000-07-05 04:48:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0197', 16, CAST(N'2006-12-02 23:16:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0198', 17, CAST(N'2008-06-09 08:04:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0206', 18, CAST(N'1994-11-27 19:54:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0209', 19, CAST(N'1988-10-30 18:45:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0226', 20, CAST(N'1987-10-07 18:34:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0234', 21, CAST(N'2008-07-20 12:32:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0236', 22, CAST(N'2009-08-23 21:33:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0246', 23, CAST(N'1987-10-24 13:23:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'001', N'0250', 24, CAST(N'1996-08-14 08:28:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0001', 25, CAST(N'1990-02-11 20:24:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0005', 26, CAST(N'1999-09-24 05:36:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0009', 27, CAST(N'1994-12-17 06:59:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0011', 28, CAST(N'1987-12-03 16:23:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0017', 29, CAST(N'2011-04-03 16:09:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0038', 30, CAST(N'1990-10-01 20:39:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0039', 31, CAST(N'1999-04-20 17:32:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0057', 32, CAST(N'2009-11-10 22:27:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0078', 33, CAST(N'2013-09-24 22:25:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0088', 34, CAST(N'2003-07-08 08:45:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0094', 35, CAST(N'1997-09-08 16:49:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0111', 36, CAST(N'2005-05-14 11:54:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0123', 37, CAST(N'2011-09-21 10:53:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0144', 38, CAST(N'2010-08-04 22:53:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0158', 39, CAST(N'1987-06-12 04:38:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0197', 40, CAST(N'2011-12-08 19:36:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0198', 41, CAST(N'1997-08-07 19:25:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0206', 42, CAST(N'2001-06-17 07:43:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0209', 43, CAST(N'2003-09-04 14:37:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0226', 44, CAST(N'1989-12-21 05:02:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0234', 45, CAST(N'1995-10-08 17:37:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0236', 46, CAST(N'2004-12-16 09:40:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0246', 47, CAST(N'1998-11-04 16:49:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'007', N'0250', 48, CAST(N'1996-02-26 19:36:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0001', 49, CAST(N'2006-11-12 13:21:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0005', 50, CAST(N'1999-03-01 00:28:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0009', 51, CAST(N'2005-08-29 12:36:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0011', 52, CAST(N'2002-08-10 07:14:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0017', 53, CAST(N'1990-10-06 19:00:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0038', 54, CAST(N'1989-11-19 14:25:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0039', 55, CAST(N'2005-09-29 12:06:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0057', 56, CAST(N'1996-12-03 21:33:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0078', 57, CAST(N'1994-07-14 21:19:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0088', 58, CAST(N'2008-04-13 08:48:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0094', 59, CAST(N'1992-07-14 07:11:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0111', 60, CAST(N'2003-12-28 21:41:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0123', 61, CAST(N'2000-08-21 16:13:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0144', 62, CAST(N'1989-07-27 07:58:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0158', 63, CAST(N'2009-02-28 16:03:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0197', 64, CAST(N'1992-12-19 15:17:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0198', 65, CAST(N'1991-11-18 18:54:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0206', 66, CAST(N'2001-07-15 14:09:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0209', 67, CAST(N'1987-09-24 23:54:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0226', 68, CAST(N'1988-10-26 11:12:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0234', 69, CAST(N'2011-03-25 15:40:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0236', 70, CAST(N'1987-08-11 07:18:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0246', 71, CAST(N'1987-11-06 00:08:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'010', N'0250', 72, CAST(N'2013-07-14 03:55:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0001', 73, CAST(N'2004-11-16 20:44:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0005', 74, CAST(N'2001-06-20 00:13:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0009', 75, CAST(N'1991-04-25 22:25:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0011', 76, CAST(N'1989-05-13 19:57:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0017', 77, CAST(N'1987-12-27 23:29:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0038', 78, CAST(N'2007-03-08 03:22:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0039', 79, CAST(N'2008-03-22 17:21:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0057', 80, CAST(N'2007-05-15 12:28:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0078', 81, CAST(N'1988-08-04 01:11:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0088', 82, CAST(N'2011-05-20 04:10:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0094', 83, CAST(N'1996-12-24 18:59:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0111', 84, CAST(N'2008-09-24 17:35:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0123', 85, CAST(N'1998-12-09 01:43:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0144', 86, CAST(N'2004-05-06 23:35:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0158', 87, CAST(N'1995-12-20 13:39:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0197', 88, CAST(N'2008-04-01 03:08:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0198', 89, CAST(N'2009-09-29 19:24:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0206', 90, CAST(N'1995-05-18 03:48:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0209', 91, CAST(N'1996-08-14 09:41:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0226', 92, CAST(N'2003-08-30 07:25:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0234', 93, CAST(N'2007-08-08 08:46:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0236', 94, CAST(N'2002-03-30 01:29:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0246', 95, CAST(N'1993-10-06 22:19:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'013', N'0250', 96, CAST(N'1992-11-10 11:00:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0001', 97, CAST(N'1989-02-04 10:42:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0005', 98, CAST(N'1998-06-25 03:36:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0009', 99, CAST(N'1993-02-09 09:28:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0011', 100, CAST(N'1999-05-27 20:18:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0017', 101, CAST(N'1991-01-25 02:52:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0038', 102, CAST(N'2002-03-10 10:48:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0039', 103, CAST(N'1988-06-28 23:25:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0057', 104, CAST(N'2009-01-04 13:06:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0078', 105, CAST(N'1991-10-28 19:15:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0088', 106, CAST(N'2012-12-02 16:06:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0094', 107, CAST(N'2006-03-24 04:00:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0111', 108, CAST(N'1993-06-01 03:37:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0123', 109, CAST(N'1989-10-03 21:18:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0144', 110, CAST(N'2003-08-29 01:55:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0158', 111, CAST(N'1994-06-16 15:27:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0197', 112, CAST(N'2001-05-30 16:06:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0198', 113, CAST(N'1996-06-08 22:45:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0206', 114, CAST(N'1998-07-28 15:58:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0209', 115, CAST(N'2008-10-28 19:30:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0226', 116, CAST(N'2004-04-22 17:53:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0234', 117, CAST(N'2014-04-18 22:41:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0236', 118, CAST(N'2004-02-19 12:33:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0246', 119, CAST(N'1988-01-07 17:21:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'014', N'0250', 120, CAST(N'1998-09-06 17:27:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0001', 121, CAST(N'2009-03-24 10:22:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0005', 122, CAST(N'1988-11-23 05:34:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0009', 123, CAST(N'1997-12-30 06:55:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0011', 124, CAST(N'1992-06-12 01:20:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0017', 125, CAST(N'2006-11-10 19:18:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0038', 126, CAST(N'1993-05-08 14:04:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0039', 127, CAST(N'2013-02-27 17:10:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0057', 128, CAST(N'1994-12-16 00:07:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0078', 129, CAST(N'1998-04-07 21:01:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0088', 130, CAST(N'1989-11-21 22:37:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0094', 131, CAST(N'1999-07-31 02:34:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0111', 132, CAST(N'1992-11-11 23:36:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0123', 133, CAST(N'2011-09-07 09:40:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0144', 134, CAST(N'1990-09-24 01:48:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0158', 135, CAST(N'2000-04-06 04:31:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0197', 136, CAST(N'2003-12-10 01:14:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0198', 137, CAST(N'2004-10-16 04:05:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0206', 138, CAST(N'1996-11-16 07:11:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0209', 139, CAST(N'2011-11-25 08:44:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0226', 140, CAST(N'1995-07-12 00:41:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0234', 141, CAST(N'1999-04-06 23:31:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0236', 142, CAST(N'1988-02-27 21:21:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0246', 143, CAST(N'2004-02-21 22:16:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'022', N'0250', 144, CAST(N'1996-02-25 03:33:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0001', 145, CAST(N'2012-03-01 19:06:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0005', 146, CAST(N'1990-08-12 07:29:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0009', 147, CAST(N'2014-04-03 15:22:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0011', 148, CAST(N'1990-10-16 01:46:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0017', 149, CAST(N'2000-08-28 09:45:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0038', 150, CAST(N'1988-06-22 23:46:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0039', 151, CAST(N'2012-09-05 20:44:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0057', 152, CAST(N'1990-07-29 16:48:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0078', 153, CAST(N'1988-11-25 22:24:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0088', 154, CAST(N'1990-11-29 08:55:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0094', 155, CAST(N'1990-05-15 16:32:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0111', 156, CAST(N'1990-10-08 14:07:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0123', 157, CAST(N'1990-01-07 01:45:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0144', 158, CAST(N'1988-05-04 14:10:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0158', 159, CAST(N'1987-03-08 17:12:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0197', 160, CAST(N'1988-07-13 10:58:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0198', 161, CAST(N'2004-06-27 18:33:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0206', 162, CAST(N'2010-01-27 17:09:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0209', 163, CAST(N'2005-10-24 03:07:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0226', 164, CAST(N'2003-08-06 10:43:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0234', 165, CAST(N'2000-12-18 04:11:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0236', 166, CAST(N'1987-08-05 12:40:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0246', 167, CAST(N'2012-08-27 21:43:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'028', N'0250', 168, CAST(N'1987-02-03 21:00:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0001', 169, CAST(N'1989-06-18 08:14:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0005', 170, CAST(N'2014-02-26 03:33:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0009', 171, CAST(N'1991-12-30 05:31:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0011', 172, CAST(N'2006-06-09 21:09:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0017', 173, CAST(N'1999-04-22 10:29:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0038', 174, CAST(N'2013-12-25 01:51:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0039', 175, CAST(N'2010-06-07 01:02:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0057', 176, CAST(N'1996-08-27 16:04:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0078', 177, CAST(N'1989-10-10 13:00:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0088', 178, CAST(N'2010-09-04 08:13:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0094', 179, CAST(N'2000-07-10 14:14:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0111', 180, CAST(N'2008-04-25 08:14:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0123', 181, CAST(N'1994-10-24 17:43:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0144', 182, CAST(N'2001-09-11 01:56:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0158', 183, CAST(N'2011-01-03 11:58:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0197', 184, CAST(N'2010-10-22 21:03:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0198', 185, CAST(N'1998-05-13 13:39:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0206', 186, CAST(N'1999-10-24 02:12:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0209', 187, CAST(N'2013-01-17 05:20:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0226', 188, CAST(N'1991-04-24 18:18:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0234', 189, CAST(N'2012-09-09 20:10:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0236', 190, CAST(N'2011-02-27 11:57:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0246', 191, CAST(N'2014-01-12 14:27:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'031', N'0250', 192, CAST(N'2010-06-22 07:21:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0001', 193, CAST(N'1994-12-26 11:29:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0005', 194, CAST(N'1992-05-23 16:24:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0009', 195, CAST(N'2004-03-29 12:14:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0011', 196, CAST(N'2001-10-28 06:48:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0017', 197, CAST(N'1995-11-07 11:41:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0038', 198, CAST(N'2005-08-16 21:44:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0039', 199, CAST(N'2002-09-21 11:38:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0057', 200, CAST(N'2007-06-28 16:58:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0078', 201, CAST(N'1987-05-13 22:54:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0088', 202, CAST(N'1996-02-01 08:26:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0094', 203, CAST(N'2006-08-21 08:43:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0111', 204, CAST(N'1987-09-15 07:11:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0123', 205, CAST(N'1987-01-30 02:58:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0144', 206, CAST(N'1999-01-22 17:24:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0158', 207, CAST(N'1995-06-19 10:35:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0197', 208, CAST(N'1989-06-26 04:28:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0198', 209, CAST(N'1995-02-16 09:30:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0206', 210, CAST(N'2009-01-16 05:25:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0209', 211, CAST(N'1995-04-18 00:28:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0226', 212, CAST(N'1995-06-16 13:58:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0234', 213, CAST(N'2006-04-02 02:05:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0236', 214, CAST(N'1991-03-23 03:05:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0246', 215, CAST(N'2004-11-02 03:30:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'036', N'0250', 216, CAST(N'2013-07-30 07:58:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0001', 217, CAST(N'2005-09-15 04:45:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0005', 218, CAST(N'2010-11-17 18:48:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0009', 219, CAST(N'2001-12-22 12:59:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0011', 220, CAST(N'1993-05-31 03:30:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0017', 221, CAST(N'1998-01-03 12:13:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0038', 222, CAST(N'2010-12-12 18:15:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0039', 223, CAST(N'1987-04-26 14:47:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0057', 224, CAST(N'2009-01-19 08:47:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0078', 225, CAST(N'2003-04-01 13:17:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0088', 226, CAST(N'2002-03-14 08:32:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0094', 227, CAST(N'1998-04-04 19:20:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0111', 228, CAST(N'1998-07-15 16:50:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0123', 229, CAST(N'1988-04-20 12:19:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0144', 230, CAST(N'1996-05-14 19:48:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0158', 231, CAST(N'1992-11-25 05:55:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0197', 232, CAST(N'2001-06-30 11:50:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0198', 233, CAST(N'1994-10-25 21:15:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0206', 234, CAST(N'1991-01-30 20:11:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0209', 235, CAST(N'1990-05-18 02:24:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0226', 236, CAST(N'1991-09-29 17:47:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0234', 237, CAST(N'1996-11-09 12:20:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0236', 238, CAST(N'1998-11-09 18:15:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0246', 239, CAST(N'1997-04-01 22:21:00' AS SmallDateTime))
GO
INSERT [dbo].[F_Actua] ([Cod_Penha], [Cod_Cantaor], [Num], [Fecha]) VALUES (N'055', N'0250', 240, CAST(N'2008-03-16 02:43:00' AS SmallDateTime))
GO
SET IDENTITY_INSERT [dbo].[F_Actua] OFF
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0001', N'José', N'Benítez Monge', N'El niño de la era', N'Jerez', N'CA', 1985, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0005', N'Juana', N'Heredia Martínez', N'Juana la de la fragua', N'Dos Hermanas', N'SE', 1962, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0009', N'Josefa', N'López Montoya', N'Pepi de Utrera', N'Utrera', N'SE', 1970, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0011', N'Enrique', N'García', N'El Hornillero', N'Jerez', N'CA', 1988, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0017', N'María', N'Asencio Vidal', N'La Tremenda', N'Jerez', N'CA', 1971, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0038', N'Eladio', N'Vargas Reyes', N'El Arriero', N'Ayamonte', N'H ', 1962, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0039', N'Carmen', N'Fuentes Alegre', N'La Perla', N'Santa Olaya', N'H ', 1980, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0057', N'Vicente', N'Chávez Dorado', N'El Jeta', N'Lebrija', N'SE', 1971, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0078', N'Jennifer', N'López Heredia', N'La rubia', N'Almonaster', N'H ', 1969, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0088', N'Eva', N'Negrín Suárez', N'La niña del colmao', N'Aznalcóyar', N'SE', 1980, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0094', N'Miguel', N'Toro Bravo', N'El guindilla', N'Las Cabezas', N'SE', 1977, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0111', N'Luisa', N'Ruiz Palma', N'La traviesa', N'San Fernando', N'CA', 1985, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0123', N'Mercedes', N'Grande Carro', N'La Patosa', N'Cortegana', N'H ', 1976, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0144', N'Benita', N'Heredia Rodríguez', N'La bruja', N'Lebrija', N'SE', 1972, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0158', N'Juan', N'Banderas Rojas', N'El tato', N'Puerto de Sta María', N'CA', 1976, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0197', N'Alfonso', N'Hornos ', N'El trasto', N'Rota', N'CA', 1968, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0198', N'Antonio', N'Flores del Campo', N'El Junlay', N'Morón', N'SE', 1960, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0206', N'Dolores', N'Santos Guerra', N'Loli la espelucá', N'Lebrija', N'SE', 1975, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0209', N'Antonio', N'Vargas Heredia', N'El Quiyo', N'Lepe', N'H ', 1980, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0226', N'Esteban', N'Quero Flores', N'El Pajolero', N'Morón', N'SE', 1959, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0234', N'Fernando', N'Gómez Cantalejo', N'El chacho', N'Coria del Río', N'SE', 1988, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0236', N'Juan', N'Rios Seco', N'Niño del Palancón', N'Montilla', N'CO', 1979, N'H')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0246', N'María', N'Reyes Puerta', N'La Pinguita', N'Fuenteovejuna', N'CO', 1970, N'M')
GO
INSERT [dbo].[F_Cantaores] ([Codigo], [Nombre], [Apellidos], [Nombre_Artistico], [Localidad], [Cod_Provincia], [Anno], [Sexo]) VALUES (N'0250', N'Juan', N'Altas Peñas', N'Tío del trabuco', N'Aroche', N'H ', 1978, N'H')
GO
INSERT [dbo].[F_Festivales] ([Cod], [Denominacion], [Localidad], [Provincia]) VALUES (N'001', N'Juan Talega', N'Dos Hermanas', N'SE')
GO
INSERT [dbo].[F_Festivales] ([Cod], [Denominacion], [Localidad], [Provincia]) VALUES (N'002', N'Caracolá', N'Lebrija', N'SE')
GO
INSERT [dbo].[F_Festivales] ([Cod], [Denominacion], [Localidad], [Provincia]) VALUES (N'003', N'Potaje Gitano', N'Utrera', N'SE')
GO
INSERT [dbo].[F_Festivales] ([Cod], [Denominacion], [Localidad], [Provincia]) VALUES (N'004', N'Gazpacho flamenco', N'Morón', N'SE')
GO
INSERT [dbo].[F_Festivales] ([Cod], [Denominacion], [Localidad], [Provincia]) VALUES (N'005', N'Arranque roteño', N'Rota', N'CA')
GO
INSERT [dbo].[F_Festivales] ([Cod], [Denominacion], [Localidad], [Provincia]) VALUES (N'006', N'Jaleo', N'Jerez', N'CA')
GO
INSERT [dbo].[F_Festivales] ([Cod], [Denominacion], [Localidad], [Provincia]) VALUES (N'007', N'Churrasco', N'Aroche', N'H ')
GO
INSERT [dbo].[F_Festivales] ([Cod], [Denominacion], [Localidad], [Provincia]) VALUES (N'008', N'Cante de las minas', N'La Unión', N'MU')
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0017', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0017', 2007)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0038', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0038', 2013)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0039', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0039', 2007)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0057', 2013)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0088', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0088', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0094', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0094', 2004)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0111', 2012)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0123', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0144', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0198', 2011)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'001', N'0246', 2008)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0005', 2013)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0011', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0011', 2005)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0039', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0057', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0078', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0094', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0111', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0123', 2006)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0123', 2012)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0144', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0206', 2011)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0209', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0246', 2004)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0250', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'002', N'0250', 2008)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0001', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0005', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0009', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0009', 2009)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0011', 2007)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0039', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0039', 2007)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0057', 2010)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0078', 2011)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0111', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0144', 2005)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0144', 2006)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0197', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0197', 2013)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0198', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0206', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0209', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0209', 2012)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'003', N'0226', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0005', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0009', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0009', 2013)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0011', 2012)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0039', 2005)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0039', 2008)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0057', 2010)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0094', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0144', 2005)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0144', 2011)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0197', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0198', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0198', 2008)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0206', 2006)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0209', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0209', 2004)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0226', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0236', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'004', N'0236', 2007)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0005', 2010)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0009', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0011', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0011', 2006)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0039', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0039', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0088', 2013)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0111', 2011)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0123', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0144', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0197', 2004)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0198', 2007)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0206', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0209', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0209', 2008)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0226', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0236', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0236', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'005', N'0250', 2004)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0001', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0001', 2006)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0001', 2007)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0005', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0005', 2006)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0009', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0011', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0038', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0039', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0039', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0094', 2010)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0123', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0144', 2005)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0144', 2008)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0197', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0209', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0209', 2013)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0226', 2012)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'006', N'0236', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0001', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0005', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0005', 2011)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0009', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0011', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0039', 2000)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0039', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0078', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0111', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0144', 2001)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0197', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0197', 2009)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0198', 2006)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0198', 2012)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0209', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0209', 2003)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0226', 2002)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0236', 2011)
GO
INSERT [dbo].[F_Festivales_Cantaores] ([Cod_Festival], [Cod_Cantaor], [Edicion]) VALUES (N'007', N'0246', 2001)
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'AL', N'Alegrías')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'BA', N'Bambera')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'BU', N'Bulerías')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'CA', N'Cantiñas')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'CR', N'Caracoles')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'FH', N'Fandangos de Huelva')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'MA', N'Malagueñas')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'MR', N'Marianas')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'MT', N'Martinetes')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'PO', N'Polo')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'PT', N'Peteneras')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'RU', N'Rumbas')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'SA', N'Saeta')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'SE', N'Sevillanas')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'SG', N'Seguiriyas')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'SO', N'Soleares')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'TI', N'Tientos')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'TJ', N'Tangos de Jerez')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'TL', N'Tanguillos')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'TN', N'Tangos')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'TP', N'Tangos del Piyayo')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'TR', N'Taranta')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'TT', N'Tientos-Tangos')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'VE', N'Verdiales')
GO
INSERT [dbo].[F_Palos] ([Cod_Palo], [Palo]) VALUES (N'VI', N'Villancicos')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0001', N'SO')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0001', N'TN')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0001', N'TP')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0005', N'AL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0005', N'TN')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0009', N'BA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0009', N'TP')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0011', N'AL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0011', N'RU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0011', N'SO')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0011', N'TN')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0011', N'TT')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0017', N'CA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0017', N'FH')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0017', N'TT')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0038', N'AL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0038', N'BU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0038', N'FH')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0038', N'RU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0038', N'SA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0039', N'BA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0039', N'BU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0039', N'CA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0039', N'CR')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0039', N'SG')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0057', N'BU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0057', N'CR')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0057', N'FH')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0057', N'MA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0057', N'RU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0057', N'SE')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0057', N'TI')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0057', N'TT')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0057', N'VE')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0078', N'AL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0078', N'BU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0078', N'SO')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0078', N'TP')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0088', N'BU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0088', N'FH')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0088', N'MA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0088', N'SG')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0088', N'TI')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0088', N'TL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0088', N'TN')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0088', N'VI')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0094', N'AL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0094', N'FH')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0094', N'TR')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0111', N'BU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0111', N'CA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0111', N'FH')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0111', N'MA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0111', N'PT')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0111', N'SG')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0111', N'SO')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0111', N'TI')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0111', N'TL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0111', N'TR')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0123', N'CA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0123', N'FH')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0123', N'MA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0123', N'RU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0123', N'SO')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0144', N'BU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0158', N'AL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0158', N'BU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0197', N'AL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0197', N'CA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0197', N'SO')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0197', N'TN')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0197', N'TT')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0198', N'BU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0198', N'SA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0198', N'TN')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0206', N'AL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0206', N'BU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0206', N'FH')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0206', N'MA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0206', N'SG')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0206', N'SO')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0206', N'TI')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0206', N'TL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0206', N'TR')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0209', N'MA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0226', N'SG')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0226', N'SO')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0226', N'TI')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0226', N'TR')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0226', N'VI')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0234', N'AL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0234', N'BA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0234', N'MA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0234', N'MT')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0234', N'SO')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0236', N'MA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0246', N'VE')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0250', N'AL')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0250', N'CA')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0250', N'FH')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0250', N'RU')
GO
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0250', N'SG')
INSERT [dbo].[F_Palos_Cantaor] ([Cod_cantaor], [Cod_Palo]) VALUES (N'0250', N'TT')
INSERT INTO F_Palos_Cantaor (Cod_Cantaor,Cod_Palo) VALUES
	('0039','PT')
	,('0234','PT')
	,('0088','PT')
	,('0094','PT')
GO
INSERT [dbo].[F_Penhas] ([Codigo], [Nombre], [Descripcion], [Fecha_fundacion], [Direccion], [Localidad], [Cod_provincia], [Telefono]) VALUES (N'001', N'La Fragua', N'Peña de Bellavista', CAST(N'1956-02-14 00:00:00' AS SmallDateTime), N'C/Hipío, 14', N'Sevilla', N'SE', N'954697815      ')
GO
INSERT [dbo].[F_Penhas] ([Codigo], [Nombre], [Descripcion], [Fecha_fundacion], [Direccion], [Localidad], [Cod_provincia], [Telefono]) VALUES (N'007', N'El castillo', NULL, CAST(N'1948-06-11 00:00:00' AS SmallDateTime), N'C/Alta, 33', N'Alcalá de Guadaira', N'SE', N'954974502      ')
GO
INSERT [dbo].[F_Penhas] ([Codigo], [Nombre], [Descripcion], [Fecha_fundacion], [Direccion], [Localidad], [Cod_provincia], [Telefono]) VALUES (N'010', N'El fandango', NULL, CAST(N'1966-11-25 00:00:00' AS SmallDateTime), N'C/Plata, 15', N'Alosno', N'H ', N'955368741      ')
GO
INSERT [dbo].[F_Penhas] ([Codigo], [Nombre], [Descripcion], [Fecha_fundacion], [Direccion], [Localidad], [Cod_provincia], [Telefono]) VALUES (N'013', N'El duende', NULL, CAST(N'1932-04-14 00:00:00' AS SmallDateTime), N'Plaza del emigrante, 5', N'Lebrija', N'SE', N'954852004      ')
GO
INSERT [dbo].[F_Penhas] ([Codigo], [Nombre], [Descripcion], [Fecha_fundacion], [Direccion], [Localidad], [Cod_provincia], [Telefono]) VALUES (N'014', N'Juan Talega', NULL, CAST(N'1975-05-20 00:00:00' AS SmallDateTime), N'Av. de la Constitución, 86', N'Utrera', N'SE', N'954726633      ')
GO
INSERT [dbo].[F_Penhas] ([Codigo], [Nombre], [Descripcion], [Fecha_fundacion], [Direccion], [Localidad], [Cod_provincia], [Telefono]) VALUES (N'022', N'Sol naciente', NULL, CAST(N'1970-09-15 00:00:00' AS SmallDateTime), N'Mitsubishi Biru, mod. 25', N'Yokohama', NULL, N'+81 3 529863147')
GO
INSERT [dbo].[F_Penhas] ([Codigo], [Nombre], [Descripcion], [Fecha_fundacion], [Direccion], [Localidad], [Cod_provincia], [Telefono]) VALUES (N'028', N'Niño Ricardo', N'Peña castiza y con solera', CAST(N'1977-02-28 00:00:00' AS SmallDateTime), N'Plaza de la Mina, 6', N'Sevilla', N'SE', N'954338215      ')
GO
INSERT [dbo].[F_Penhas] ([Codigo], [Nombre], [Descripcion], [Fecha_fundacion], [Direccion], [Localidad], [Cod_provincia], [Telefono]) VALUES (N'031', N'El compás', N'Arte gitano en su pura esencia', CAST(N'1961-08-05 00:00:00' AS SmallDateTime), N'C/Revuelo, 49', N'Jerez', N'CA', N'956001147      ')
GO
INSERT [dbo].[F_Penhas] ([Codigo], [Nombre], [Descripcion], [Fecha_fundacion], [Direccion], [Localidad], [Cod_provincia], [Telefono]) VALUES (N'036', N'Antonio Mairena', N'A la memoria del maestro de maestros', CAST(N'1983-07-22 00:00:00' AS SmallDateTime), N'Plaza Nueva, 4', N'Mairena del Alcor', N'SE', N'954663008      ')
GO
INSERT [dbo].[F_Penhas] ([Codigo], [Nombre], [Descripcion], [Fecha_fundacion], [Direccion], [Localidad], [Cod_provincia], [Telefono]) VALUES (N'055', N'Chocolate', NULL, CAST(N'1968-10-19 00:00:00' AS SmallDateTime), N'C/ Corredera, 15', N'Fuenteovejuna', N'CO', N'958774004      ')
GO
INSERT [dbo].[F_Provincias] ([Cod_Provincia], [Provincia]) VALUES (N'AL', N'Almería')
GO
INSERT [dbo].[F_Provincias] ([Cod_Provincia], [Provincia]) VALUES (N'BA', N'Badajoz')
GO
INSERT [dbo].[F_Provincias] ([Cod_Provincia], [Provincia]) VALUES (N'CA', N'Cádiz')
GO
INSERT [dbo].[F_Provincias] ([Cod_Provincia], [Provincia]) VALUES (N'CO', N'Córdoba')
GO
INSERT [dbo].[F_Provincias] ([Cod_Provincia], [Provincia]) VALUES (N'GR', N'Granada')
GO
INSERT [dbo].[F_Provincias] ([Cod_Provincia], [Provincia]) VALUES (N'H ', N'Huelva')
GO
INSERT [dbo].[F_Provincias] ([Cod_Provincia], [Provincia]) VALUES (N'J ', N'Jaén')
GO
INSERT [dbo].[F_Provincias] ([Cod_Provincia], [Provincia]) VALUES (N'MA', N'Málaga')
GO
INSERT [dbo].[F_Provincias] ([Cod_Provincia], [Provincia]) VALUES (N'MU', N'Murcia')
GO
INSERT [dbo].[F_Provincias] ([Cod_Provincia], [Provincia]) VALUES (N'SE', N'Sevilla')
GO
ALTER TABLE [dbo].[F_Actua]  WITH CHECK ADD  CONSTRAINT [FK_F_Actua_F_Cantaores] FOREIGN KEY([Cod_Cantaor])
REFERENCES [dbo].[F_Cantaores] ([Codigo])
GO
ALTER TABLE [dbo].[F_Actua] CHECK CONSTRAINT [FK_F_Actua_F_Cantaores]
GO
ALTER TABLE [dbo].[F_Actua]  WITH CHECK ADD  CONSTRAINT [FK_F_Penhas_F_Festivales] FOREIGN KEY([Cod_Penha])
REFERENCES [dbo].[F_Penhas] ([Codigo])
GO
ALTER TABLE [dbo].[F_Actua] CHECK CONSTRAINT [FK_F_Penhas_F_Festivales]
GO
ALTER TABLE [dbo].[F_Cantaores]  WITH CHECK ADD  CONSTRAINT [FK_CantaoresProvincias] FOREIGN KEY([Cod_Provincia])
REFERENCES [dbo].[F_Provincias] ([Cod_Provincia])
GO
ALTER TABLE [dbo].[F_Cantaores] CHECK CONSTRAINT [FK_CantaoresProvincias]
GO
ALTER TABLE [dbo].[F_Festivales]  WITH CHECK ADD  CONSTRAINT [FK_FestivalesProvincias] FOREIGN KEY([Provincia])
REFERENCES [dbo].[F_Provincias] ([Cod_Provincia])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[F_Festivales] CHECK CONSTRAINT [FK_FestivalesProvincias]
GO
ALTER TABLE [dbo].[F_Festivales_Cantaores]  WITH CHECK ADD  CONSTRAINT [FK_F_Festivales_Cantaores_F_Cantaores] FOREIGN KEY([Cod_Cantaor])
REFERENCES [dbo].[F_Cantaores] ([Codigo])
GO
ALTER TABLE [dbo].[F_Festivales_Cantaores] CHECK CONSTRAINT [FK_F_Festivales_Cantaores_F_Cantaores]
GO
ALTER TABLE [dbo].[F_Festivales_Cantaores]  WITH CHECK ADD  CONSTRAINT [FK_F_Festivales_Cantaores_F_Festivales] FOREIGN KEY([Cod_Festival])
REFERENCES [dbo].[F_Festivales] ([Cod])
GO
ALTER TABLE [dbo].[F_Festivales_Cantaores] CHECK CONSTRAINT [FK_F_Festivales_Cantaores_F_Festivales]
GO
ALTER TABLE [dbo].[F_Palos_Cantaor]  WITH CHECK ADD  CONSTRAINT [FK_PalosCantaor_Cantaor] FOREIGN KEY([Cod_cantaor])
REFERENCES [dbo].[F_Cantaores] ([Codigo])
GO
ALTER TABLE [dbo].[F_Palos_Cantaor] CHECK CONSTRAINT [FK_PalosCantaor_Cantaor]
GO
ALTER TABLE [dbo].[F_Palos_Cantaor]  WITH CHECK ADD  CONSTRAINT [FK_PalosCantaorPalos] FOREIGN KEY([Cod_Palo])
REFERENCES [dbo].[F_Palos] ([Cod_Palo])
GO
ALTER TABLE [dbo].[F_Palos_Cantaor] CHECK CONSTRAINT [FK_PalosCantaorPalos]
GO
ALTER TABLE [dbo].[F_Penhas]  WITH CHECK ADD  CONSTRAINT [FK_Penhas_Provincias] FOREIGN KEY([Cod_provincia])
REFERENCES [dbo].[F_Provincias] ([Cod_Provincia])
GO
ALTER TABLE [dbo].[F_Penhas] CHECK CONSTRAINT [FK_Penhas_Provincias]
GO
ALTER TABLE [dbo].[F_Penhas]  WITH CHECK ADD CHECK  (([Fecha_fundacion]<getdate()))
GO
USE [master]
GO
ALTER DATABASE [Flamenco] SET  READ_WRITE 
GO
