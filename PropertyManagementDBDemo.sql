USE [master]
GO
/****** Object:  Database [PropertyDemo]    Script Date: 7/1/2024 4:37:15 PM ******/
CREATE DATABASE [PropertyDemo]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PropertyDemo', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PropertyDemo.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PropertyDemo_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PropertyDemo_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PropertyDemo] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PropertyDemo].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PropertyDemo] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PropertyDemo] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PropertyDemo] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PropertyDemo] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PropertyDemo] SET ARITHABORT OFF 
GO
ALTER DATABASE [PropertyDemo] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PropertyDemo] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PropertyDemo] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PropertyDemo] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PropertyDemo] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PropertyDemo] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PropertyDemo] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PropertyDemo] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PropertyDemo] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PropertyDemo] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PropertyDemo] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PropertyDemo] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PropertyDemo] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PropertyDemo] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PropertyDemo] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PropertyDemo] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PropertyDemo] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PropertyDemo] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PropertyDemo] SET  MULTI_USER 
GO
ALTER DATABASE [PropertyDemo] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PropertyDemo] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PropertyDemo] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PropertyDemo] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PropertyDemo] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PropertyDemo] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PropertyDemo] SET QUERY_STORE = OFF
GO
USE [PropertyDemo]
GO
/****** Object:  Table [dbo].[HistoryInventory]    Script Date: 7/1/2024 4:37:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoryInventory](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[PropertyID] [int] NOT NULL,
	[PeriodID] [int] NOT NULL,
	[Auditor] [int] NOT NULL,
	[DeviceName] [nvarchar](50) NOT NULL,
	[InventoryTime] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_HistoryInventory] PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PeriodInventory]    Script Date: 7/1/2024 4:37:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeriodInventory](
	[PeriodID] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Description] [nvarchar](50) NOT NULL,
	[IsAction] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_PeriodInventory] PRIMARY KEY CLUSTERED 
(
	[PeriodID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Properties]    Script Date: 7/1/2024 4:37:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Properties](
	[PropertyID] [int] IDENTITY(1,1) NOT NULL,
	[PropertyCode] [nvarchar](50) NOT NULL,
	[PropertyName] [nvarchar](50) NOT NULL,
	[Supplier] [nvarchar](50) NOT NULL,
	[Image] [nvarchar](max) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_Property] PRIMARY KEY CLUSTERED 
(
	[PropertyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 7/1/2024 4:37:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/1/2024 4:37:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[RoleID] [int] NOT NULL,
	[IsAction] [bit] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Properties] ON 

INSERT [dbo].[Properties] ([PropertyID], [PropertyCode], [PropertyName], [Supplier], [Image], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'P00001', N'Máy in HP', N'Denso', N'Printer.jpg', 1, CAST(N'2024-06-24T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Properties] ([PropertyID], [PropertyCode], [PropertyName], [Supplier], [Image], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'P00002', N'TV', N'Samsung', N'OIP.jpg', 1, CAST(N'2024-06-24T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Properties] ([PropertyID], [PropertyCode], [PropertyName], [Supplier], [Image], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1002, N'P00003', N'Điện thoại bàn', N'Panasonic', N'd1125fcb-376e-4998-86dd-37dd6efdd2a0_download.jpg', 1, CAST(N'2024-06-27T10:55:59.943' AS DateTime), NULL, NULL)
INSERT [dbo].[Properties] ([PropertyID], [PropertyCode], [PropertyName], [Supplier], [Image], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1004, N'P00004', N'Bàn phím', N'Denso', N'6b64faa5-71a7-4003-b4e9-aba3cd3333bb_images.jpg', 1, CAST(N'2024-06-27T12:58:29.810' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Properties] OFF
GO
INSERT [dbo].[Roles] ([RoleID], [RoleName], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'Admin', 1, CAST(N'2024-06-22T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Roles] ([RoleID], [RoleName], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (2, N'Staff', 1, CAST(N'2024-06-22T00:00:00.000' AS DateTime), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [UserName], [Password], [RoleID], [IsAction], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (1, N'admin1', N'123', 1, 1, 1, CAST(N'2024-06-22T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Users] ([UserID], [UserName], [Password], [RoleID], [IsAction], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (5, N'dmvns6', N'123', 2, 0, 1, CAST(N'2024-06-22T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Users] ([UserID], [UserName], [Password], [RoleID], [IsAction], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (6, N'dmvns7', N'123', 2, 1, 1, CAST(N'2024-06-22T00:00:00.000' AS DateTime), NULL, NULL)
INSERT [dbo].[Users] ([UserID], [UserName], [Password], [RoleID], [IsAction], [CreatedBy], [CreatedOn], [ModifiedBy], [ModifiedOn]) VALUES (11, N'dmvns8', N'123', 2, 1, 1, CAST(N'2024-06-27T09:17:56.223' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[HistoryInventory]  WITH CHECK ADD  CONSTRAINT [FK_HistoryInventory_PeriodInventory] FOREIGN KEY([PeriodID])
REFERENCES [dbo].[PeriodInventory] ([PeriodID])
GO
ALTER TABLE [dbo].[HistoryInventory] CHECK CONSTRAINT [FK_HistoryInventory_PeriodInventory]
GO
ALTER TABLE [dbo].[HistoryInventory]  WITH CHECK ADD  CONSTRAINT [FK_HistoryInventory_Property] FOREIGN KEY([PropertyID])
REFERENCES [dbo].[Properties] ([PropertyID])
GO
ALTER TABLE [dbo].[HistoryInventory] CHECK CONSTRAINT [FK_HistoryInventory_Property]
GO
ALTER TABLE [dbo].[HistoryInventory]  WITH CHECK ADD  CONSTRAINT [FK_HistoryInventory_User] FOREIGN KEY([Auditor])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[HistoryInventory] CHECK CONSTRAINT [FK_HistoryInventory_User]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
USE [master]
GO
ALTER DATABASE [PropertyDemo] SET  READ_WRITE 
GO
