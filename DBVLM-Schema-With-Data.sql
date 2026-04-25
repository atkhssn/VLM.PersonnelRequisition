USE [DBVLM]
GO
ALTER TABLE [hr].[RequisitionDetail] DROP CONSTRAINT [FK_RequisitionDetail_Requisition]
GO
ALTER TABLE [hr].[RequisitionDetail] DROP CONSTRAINT [FK_RequisitionDetail_Perspective]
GO
ALTER TABLE [hr].[Requisition] DROP CONSTRAINT [FK_Requisition_Division]
GO
ALTER TABLE [hr].[Requisition] DROP CONSTRAINT [FK_Requisition_Designation]
GO
ALTER TABLE [hr].[Requisition] DROP CONSTRAINT [FK_Requisition_Department]
GO
ALTER TABLE [core].[Department] DROP CONSTRAINT [FK_Department_Division]
GO
ALTER TABLE [hr].[RequisitionDetail] DROP CONSTRAINT [DF__Requisiti__Creat__66603565]
GO
ALTER TABLE [hr].[RequisitionDetail] DROP CONSTRAINT [DF_RequisitionDetail_ID]
GO
ALTER TABLE [hr].[Requisition] DROP CONSTRAINT [DF__Requisiti__Creat__5FB337D6]
GO
ALTER TABLE [hr].[Requisition] DROP CONSTRAINT [DF_Requisition_Status]
GO
ALTER TABLE [hr].[Requisition] DROP CONSTRAINT [DF_Requisition_ID]
GO
ALTER TABLE [core].[Perspective] DROP CONSTRAINT [DF__Perspecti__Creat__5812160E]
GO
ALTER TABLE [core].[Perspective] DROP CONSTRAINT [DF__Perspecti__IsAct__571DF1D5]
GO
ALTER TABLE [core].[Division] DROP CONSTRAINT [DF__Division__Create__4BAC3F29]
GO
ALTER TABLE [core].[Division] DROP CONSTRAINT [DF__Division__IsActi__4AB81AF0]
GO
ALTER TABLE [core].[Designation] DROP CONSTRAINT [DF__Designati__Creat__5441852A]
GO
ALTER TABLE [core].[Designation] DROP CONSTRAINT [DF__Designati__IsAct__534D60F1]
GO
ALTER TABLE [core].[Department] DROP CONSTRAINT [DF__Departmen__Creat__4F7CD00D]
GO
ALTER TABLE [core].[Department] DROP CONSTRAINT [DF__Departmen__IsAct__4E88ABD4]
GO
/****** Object:  Index [IX_RequisitionDetail_RequisitionId]    Script Date: 4/25/2026 11:56:15 AM ******/
DROP INDEX [IX_RequisitionDetail_RequisitionId] ON [hr].[RequisitionDetail]
GO
/****** Object:  Index [IX_RequisitionDetail_PerspectiveId]    Script Date: 4/25/2026 11:56:15 AM ******/
DROP INDEX [IX_RequisitionDetail_PerspectiveId] ON [hr].[RequisitionDetail]
GO
/****** Object:  Index [IX_Requisition_Status]    Script Date: 4/25/2026 11:56:15 AM ******/
DROP INDEX [IX_Requisition_Status] ON [hr].[Requisition]
GO
/****** Object:  Index [IX_Requisition_Department]    Script Date: 4/25/2026 11:56:15 AM ******/
DROP INDEX [IX_Requisition_Department] ON [hr].[Requisition]
GO
/****** Object:  Index [UQ_Requisition_RequisitionNo]    Script Date: 4/25/2026 11:56:15 AM ******/
ALTER TABLE [hr].[Requisition] DROP CONSTRAINT [UQ_Requisition_RequisitionNo]
GO
/****** Object:  Table [hr].[RequisitionDetail]    Script Date: 4/25/2026 11:56:15 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[hr].[RequisitionDetail]') AND type in (N'U'))
DROP TABLE [hr].[RequisitionDetail]
GO
/****** Object:  Table [hr].[Requisition]    Script Date: 4/25/2026 11:56:15 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[hr].[Requisition]') AND type in (N'U'))
DROP TABLE [hr].[Requisition]
GO
/****** Object:  Table [core].[Perspective]    Script Date: 4/25/2026 11:56:15 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[core].[Perspective]') AND type in (N'U'))
DROP TABLE [core].[Perspective]
GO
/****** Object:  Table [core].[Division]    Script Date: 4/25/2026 11:56:15 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[core].[Division]') AND type in (N'U'))
DROP TABLE [core].[Division]
GO
/****** Object:  Table [core].[Designation]    Script Date: 4/25/2026 11:56:15 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[core].[Designation]') AND type in (N'U'))
DROP TABLE [core].[Designation]
GO
/****** Object:  Table [core].[Department]    Script Date: 4/25/2026 11:56:15 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[core].[Department]') AND type in (N'U'))
DROP TABLE [core].[Department]
GO
USE [DBVLM]
GO
/****** Object:  Sequence [hr].[Seq_RequisitionDetail]    Script Date: 4/25/2026 11:56:15 AM ******/
DROP SEQUENCE [hr].[Seq_RequisitionDetail]
GO
USE [DBVLM]
GO
/****** Object:  Sequence [hr].[Seq_Requisition]    Script Date: 4/25/2026 11:56:15 AM ******/
DROP SEQUENCE [hr].[Seq_Requisition]
GO
/****** Object:  Schema [hr]    Script Date: 4/25/2026 11:56:15 AM ******/
DROP SCHEMA [hr]
GO
/****** Object:  Schema [core]    Script Date: 4/25/2026 11:56:15 AM ******/
DROP SCHEMA [core]
GO
USE [master]
GO
/****** Object:  Database [DBVLM]    Script Date: 4/25/2026 11:56:15 AM ******/
DROP DATABASE [DBVLM]
GO
/****** Object:  Database [DBVLM]    Script Date: 4/25/2026 11:56:15 AM ******/
CREATE DATABASE [DBVLM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBVLM', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\DBVLM.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBVLM_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\DBVLM_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DBVLM] SET COMPATIBILITY_LEVEL = 170
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBVLM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBVLM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBVLM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBVLM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBVLM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBVLM] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBVLM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBVLM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBVLM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBVLM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBVLM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBVLM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBVLM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBVLM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBVLM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBVLM] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBVLM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBVLM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBVLM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBVLM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBVLM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBVLM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBVLM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBVLM] SET RECOVERY FULL 
GO
ALTER DATABASE [DBVLM] SET  MULTI_USER 
GO
ALTER DATABASE [DBVLM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBVLM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBVLM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBVLM] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBVLM] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBVLM] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [DBVLM] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DBVLM] SET QUERY_STORE = ON
GO
ALTER DATABASE [DBVLM] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DBVLM]
GO
/****** Object:  Schema [core]    Script Date: 4/25/2026 11:56:16 AM ******/
CREATE SCHEMA [core]
GO
/****** Object:  Schema [hr]    Script Date: 4/25/2026 11:56:16 AM ******/
CREATE SCHEMA [hr]
GO
USE [DBVLM]
GO
/****** Object:  Sequence [hr].[Seq_Requisition]    Script Date: 4/25/2026 11:56:16 AM ******/
CREATE SEQUENCE [hr].[Seq_Requisition] 
 AS [bigint]
 START WITH 1000
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE  500 
GO
USE [DBVLM]
GO
/****** Object:  Sequence [hr].[Seq_RequisitionDetail]    Script Date: 4/25/2026 11:56:16 AM ******/
CREATE SEQUENCE [hr].[Seq_RequisitionDetail] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE  500 
GO
/****** Object:  Table [core].[Department]    Script Date: 4/25/2026 11:56:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[Department](
	[DepartmentId] [int] IDENTITY(1,1) NOT NULL,
	[DivisionId] [int] NOT NULL,
	[DepartmentName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[Designation]    Script Date: 4/25/2026 11:56:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[Designation](
	[DesignationId] [int] IDENTITY(1,1) NOT NULL,
	[DesignationName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DesignationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[Division]    Script Date: 4/25/2026 11:56:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[Division](
	[DivisionId] [int] IDENTITY(1,1) NOT NULL,
	[DivisionName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DivisionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [core].[Perspective]    Script Date: 4/25/2026 11:56:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [core].[Perspective](
	[PerspectiveId] [int] IDENTITY(1,1) NOT NULL,
	[PerspectiveName] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PerspectiveId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hr].[Requisition]    Script Date: 4/25/2026 11:56:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hr].[Requisition](
	[RequisitionId] [bigint] NOT NULL,
	[RequisitionNo] [nvarchar](50) NOT NULL,
	[ReqDate] [date] NOT NULL,
	[DivisionId] [int] NOT NULL,
	[DepartmentId] [int] NOT NULL,
	[DesignationId] [int] NOT NULL,
	[Vacancy] [int] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_Requisition] PRIMARY KEY CLUSTERED 
(
	[RequisitionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [hr].[RequisitionDetail]    Script Date: 4/25/2026 11:56:16 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [hr].[RequisitionDetail](
	[RequisitionDetailId] [bigint] NOT NULL,
	[RequisitionId] [bigint] NOT NULL,
	[PerspectiveId] [int] NOT NULL,
	[Objective] [nvarchar](500) NOT NULL,
	[KPI] [nvarchar](200) NULL,
	[WeightagePercentage] [decimal](5, 2) NULL,
	[Remarks] [nvarchar](500) NULL,
	[CreatedAt] [datetime] NOT NULL,
 CONSTRAINT [PK_RequisitionDetail] PRIMARY KEY CLUSTERED 
(
	[RequisitionDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [core].[Department] ON 

INSERT [core].[Department] ([DepartmentId], [DivisionId], [DepartmentName], [IsActive], [CreatedAt]) VALUES (1, 1, N'Sales Operations', 1, CAST(N'2026-04-19T20:00:36.077' AS DateTime))
INSERT [core].[Department] ([DepartmentId], [DivisionId], [DepartmentName], [IsActive], [CreatedAt]) VALUES (2, 1, N'Marketing', 1, CAST(N'2026-04-19T20:00:36.077' AS DateTime))
INSERT [core].[Department] ([DepartmentId], [DivisionId], [DepartmentName], [IsActive], [CreatedAt]) VALUES (3, 2, N'Software Development', 1, CAST(N'2026-04-19T20:00:36.077' AS DateTime))
INSERT [core].[Department] ([DepartmentId], [DivisionId], [DepartmentName], [IsActive], [CreatedAt]) VALUES (4, 1, N'Retail Sales', 1, CAST(N'2026-04-21T20:36:47.790' AS DateTime))
INSERT [core].[Department] ([DepartmentId], [DivisionId], [DepartmentName], [IsActive], [CreatedAt]) VALUES (5, 2, N'IT Support', 1, CAST(N'2026-04-21T20:36:47.790' AS DateTime))
INSERT [core].[Department] ([DepartmentId], [DivisionId], [DepartmentName], [IsActive], [CreatedAt]) VALUES (6, 3, N'Recruitment', 1, CAST(N'2026-04-21T20:36:47.790' AS DateTime))
INSERT [core].[Department] ([DepartmentId], [DivisionId], [DepartmentName], [IsActive], [CreatedAt]) VALUES (7, 4, N'Accounts Payable', 1, CAST(N'2026-04-21T20:36:47.790' AS DateTime))
INSERT [core].[Department] ([DepartmentId], [DivisionId], [DepartmentName], [IsActive], [CreatedAt]) VALUES (8, 4, N'Financial Planning', 1, CAST(N'2026-04-21T20:36:47.790' AS DateTime))
SET IDENTITY_INSERT [core].[Department] OFF
GO
SET IDENTITY_INSERT [core].[Designation] ON 

INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (1, N'Software Engineer', 1, CAST(N'2026-04-19T20:00:36.080' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (2, N'Senior Software Engineer', 1, CAST(N'2026-04-19T20:00:36.080' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (3, N'Junior Software Engineer', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (4, N'QA Engineer', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (5, N'System Administrator', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (6, N'Network Engineer', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (7, N'HR Executive', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (8, N'HR Manager', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (9, N'Accountant', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (10, N'Senior Accountant', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (11, N'Finance Manager', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (12, N'Sales Executive', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (13, N'Marketing Executive', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
INSERT [core].[Designation] ([DesignationId], [DesignationName], [IsActive], [CreatedAt]) VALUES (14, N'Business Analyst', 1, CAST(N'2026-04-21T20:36:35.107' AS DateTime))
SET IDENTITY_INSERT [core].[Designation] OFF
GO
SET IDENTITY_INSERT [core].[Division] ON 

INSERT [core].[Division] ([DivisionId], [DivisionName], [IsActive], [CreatedAt]) VALUES (1, N'Sales', 1, CAST(N'2026-04-19T20:00:36.073' AS DateTime))
INSERT [core].[Division] ([DivisionId], [DivisionName], [IsActive], [CreatedAt]) VALUES (2, N'IT', 1, CAST(N'2026-04-19T20:00:36.073' AS DateTime))
INSERT [core].[Division] ([DivisionId], [DivisionName], [IsActive], [CreatedAt]) VALUES (3, N'HR', 1, CAST(N'2026-04-19T20:00:36.073' AS DateTime))
INSERT [core].[Division] ([DivisionId], [DivisionName], [IsActive], [CreatedAt]) VALUES (4, N'Finance', 1, CAST(N'2026-04-19T20:00:36.073' AS DateTime))
SET IDENTITY_INSERT [core].[Division] OFF
GO
SET IDENTITY_INSERT [core].[Perspective] ON 

INSERT [core].[Perspective] ([PerspectiveId], [PerspectiveName], [IsActive], [CreatedAt]) VALUES (1, N'Financial', 1, CAST(N'2026-04-19T20:00:36.080' AS DateTime))
INSERT [core].[Perspective] ([PerspectiveId], [PerspectiveName], [IsActive], [CreatedAt]) VALUES (2, N'People', 1, CAST(N'2026-04-19T20:00:36.080' AS DateTime))
INSERT [core].[Perspective] ([PerspectiveId], [PerspectiveName], [IsActive], [CreatedAt]) VALUES (3, N'Customer', 1, CAST(N'2026-04-19T20:00:36.080' AS DateTime))
INSERT [core].[Perspective] ([PerspectiveId], [PerspectiveName], [IsActive], [CreatedAt]) VALUES (4, N'Internal Process', 1, CAST(N'2026-04-19T20:00:36.080' AS DateTime))
SET IDENTITY_INSERT [core].[Perspective] OFF
GO
INSERT [hr].[Requisition] ([RequisitionId], [RequisitionNo], [ReqDate], [DivisionId], [DepartmentId], [DesignationId], [Vacancy], [Status], [Description], [CreatedAt]) VALUES (1016, N'R260421-0001', CAST(N'2026-04-21' AS Date), 2, 3, 2, 1, N'SUBMITTED', N'This is test entry', CAST(N'2026-04-21T23:28:02.160' AS DateTime))
INSERT [hr].[Requisition] ([RequisitionId], [RequisitionNo], [ReqDate], [DivisionId], [DepartmentId], [DesignationId], [Vacancy], [Status], [Description], [CreatedAt]) VALUES (1018, N'R260422-0001', CAST(N'2026-04-22' AS Date), 2, 3, 2, 1, N'SUBMITTED', NULL, CAST(N'2026-04-22T09:18:11.253' AS DateTime))
INSERT [hr].[Requisition] ([RequisitionId], [RequisitionNo], [ReqDate], [DivisionId], [DepartmentId], [DesignationId], [Vacancy], [Status], [Description], [CreatedAt]) VALUES (1020, N'R260423-0002', CAST(N'2026-04-23' AS Date), 3, 6, 9, 2, N'SUBMITTED', NULL, CAST(N'2026-04-23T11:55:46.007' AS DateTime))
INSERT [hr].[Requisition] ([RequisitionId], [RequisitionNo], [ReqDate], [DivisionId], [DepartmentId], [DesignationId], [Vacancy], [Status], [Description], [CreatedAt]) VALUES (1021, N'R260423-0003', CAST(N'2026-04-23' AS Date), 2, 5, 14, 1, N'SUBMITTED', N'test', CAST(N'2026-04-23T11:56:19.213' AS DateTime))
INSERT [hr].[Requisition] ([RequisitionId], [RequisitionNo], [ReqDate], [DivisionId], [DepartmentId], [DesignationId], [Vacancy], [Status], [Description], [CreatedAt]) VALUES (1022, N'R260425-0001', CAST(N'2026-04-25' AS Date), 3, 6, 14, 2, N'DRAFT', N'test', CAST(N'2026-04-25T00:17:21.327' AS DateTime))
INSERT [hr].[Requisition] ([RequisitionId], [RequisitionNo], [ReqDate], [DivisionId], [DepartmentId], [DesignationId], [Vacancy], [Status], [Description], [CreatedAt]) VALUES (1023, N'R260425-0002', CAST(N'2026-04-25' AS Date), 1, 4, 14, 1, N'DRAFT', NULL, CAST(N'2026-04-25T00:17:39.957' AS DateTime))
INSERT [hr].[Requisition] ([RequisitionId], [RequisitionNo], [ReqDate], [DivisionId], [DepartmentId], [DesignationId], [Vacancy], [Status], [Description], [CreatedAt]) VALUES (1024, N'R260425-0003', CAST(N'2026-04-25' AS Date), 2, 3, 2, 1, N'SUBMITTED', N'This is test entry ', CAST(N'2026-04-25T00:20:50.997' AS DateTime))
GO
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (17, 1016, 1, N'Financial 1', N'Financial KPI 1', CAST(10.00 AS Decimal(5, 2)), N'test Financial 1', CAST(N'2026-04-21T23:28:02.217' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (18, 1016, 1, N'Financial 2', N'Financial KPI 2', CAST(10.00 AS Decimal(5, 2)), N'test Financial 2', CAST(N'2026-04-21T23:28:02.230' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (19, 1016, 2, N'People', N'People KPI', CAST(10.00 AS Decimal(5, 2)), N'from Draft', CAST(N'2026-04-21T23:28:02.233' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (20, 1016, 4, N'Internal Process', N'Internal Process KPI', CAST(60.00 AS Decimal(5, 2)), N'ok', CAST(N'2026-04-21T23:28:02.233' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (21, 1016, 3, N'Customer', N'Customer KPI', CAST(10.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-21T23:34:35.400' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (22, 1018, 1, N'fsdd', N'fgdgfdf', CAST(10.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-22T09:18:11.310' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (23, 1018, 2, N'ggf', N'fthg', CAST(90.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-22T09:18:11.327' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (25, 1021, 1, N'test ', N'test kpi', CAST(10.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-25T00:12:41.547' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (26, 1021, 2, N'test people ', N'test people kpi', CAST(90.00 AS Decimal(5, 2)), N'', CAST(N'2026-04-25T00:12:41.553' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (27, 1020, 1, N'test', N'test', CAST(10.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-25T00:16:18.120' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (28, 1020, 2, N'test', N'test', CAST(70.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-25T00:16:18.123' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (29, 1020, 4, N'test', N'test', CAST(20.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-25T00:16:45.560' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (30, 1022, 1, N'test', N'12', CAST(100.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-25T00:17:21.343' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (31, 1024, 1, N'test 1', N'test kpi 1', CAST(10.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-25T00:20:51.003' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (32, 1024, 1, N'test 2', N'test kpi 2', CAST(10.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-25T00:20:51.007' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (33, 1024, 2, N'Test people 1', N'Test people kpi 1', CAST(70.00 AS Decimal(5, 2)), NULL, CAST(N'2026-04-25T00:20:51.007' AS DateTime))
INSERT [hr].[RequisitionDetail] ([RequisitionDetailId], [RequisitionId], [PerspectiveId], [Objective], [KPI], [WeightagePercentage], [Remarks], [CreatedAt]) VALUES (34, 1024, 4, N'test process', N'kpi', CAST(10.00 AS Decimal(5, 2)), N'ok', CAST(N'2026-04-25T00:21:25.907' AS DateTime))
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Requisition_RequisitionNo]    Script Date: 4/25/2026 11:56:16 AM ******/
ALTER TABLE [hr].[Requisition] ADD  CONSTRAINT [UQ_Requisition_RequisitionNo] UNIQUE NONCLUSTERED 
(
	[RequisitionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Requisition_Department]    Script Date: 4/25/2026 11:56:16 AM ******/
CREATE NONCLUSTERED INDEX [IX_Requisition_Department] ON [hr].[Requisition]
(
	[DepartmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Requisition_Status]    Script Date: 4/25/2026 11:56:16 AM ******/
CREATE NONCLUSTERED INDEX [IX_Requisition_Status] ON [hr].[Requisition]
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RequisitionDetail_PerspectiveId]    Script Date: 4/25/2026 11:56:16 AM ******/
CREATE NONCLUSTERED INDEX [IX_RequisitionDetail_PerspectiveId] ON [hr].[RequisitionDetail]
(
	[PerspectiveId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_RequisitionDetail_RequisitionId]    Script Date: 4/25/2026 11:56:16 AM ******/
CREATE NONCLUSTERED INDEX [IX_RequisitionDetail_RequisitionId] ON [hr].[RequisitionDetail]
(
	[RequisitionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [core].[Department] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [core].[Department] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [core].[Designation] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [core].[Designation] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [core].[Division] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [core].[Division] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [core].[Perspective] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [core].[Perspective] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [hr].[Requisition] ADD  CONSTRAINT [DF_Requisition_ID]  DEFAULT (NEXT VALUE FOR [hr].[Seq_Requisition]) FOR [RequisitionId]
GO
ALTER TABLE [hr].[Requisition] ADD  CONSTRAINT [DF_Requisition_Status]  DEFAULT ('Draft') FOR [Status]
GO
ALTER TABLE [hr].[Requisition] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [hr].[RequisitionDetail] ADD  CONSTRAINT [DF_RequisitionDetail_ID]  DEFAULT (NEXT VALUE FOR [hr].[Seq_RequisitionDetail]) FOR [RequisitionDetailId]
GO
ALTER TABLE [hr].[RequisitionDetail] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [core].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Division] FOREIGN KEY([DivisionId])
REFERENCES [core].[Division] ([DivisionId])
GO
ALTER TABLE [core].[Department] CHECK CONSTRAINT [FK_Department_Division]
GO
ALTER TABLE [hr].[Requisition]  WITH CHECK ADD  CONSTRAINT [FK_Requisition_Department] FOREIGN KEY([DepartmentId])
REFERENCES [core].[Department] ([DepartmentId])
GO
ALTER TABLE [hr].[Requisition] CHECK CONSTRAINT [FK_Requisition_Department]
GO
ALTER TABLE [hr].[Requisition]  WITH CHECK ADD  CONSTRAINT [FK_Requisition_Designation] FOREIGN KEY([DesignationId])
REFERENCES [core].[Designation] ([DesignationId])
GO
ALTER TABLE [hr].[Requisition] CHECK CONSTRAINT [FK_Requisition_Designation]
GO
ALTER TABLE [hr].[Requisition]  WITH CHECK ADD  CONSTRAINT [FK_Requisition_Division] FOREIGN KEY([DivisionId])
REFERENCES [core].[Division] ([DivisionId])
GO
ALTER TABLE [hr].[Requisition] CHECK CONSTRAINT [FK_Requisition_Division]
GO
ALTER TABLE [hr].[RequisitionDetail]  WITH CHECK ADD  CONSTRAINT [FK_RequisitionDetail_Perspective] FOREIGN KEY([PerspectiveId])
REFERENCES [core].[Perspective] ([PerspectiveId])
GO
ALTER TABLE [hr].[RequisitionDetail] CHECK CONSTRAINT [FK_RequisitionDetail_Perspective]
GO
ALTER TABLE [hr].[RequisitionDetail]  WITH CHECK ADD  CONSTRAINT [FK_RequisitionDetail_Requisition] FOREIGN KEY([RequisitionId])
REFERENCES [hr].[Requisition] ([RequisitionId])
ON DELETE CASCADE
GO
ALTER TABLE [hr].[RequisitionDetail] CHECK CONSTRAINT [FK_RequisitionDetail_Requisition]
GO
USE [master]
GO
ALTER DATABASE [DBVLM] SET  READ_WRITE 
GO
