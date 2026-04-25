/* 1. CREATE DATABASE & SCHEMAS */
IF DB_ID('DBVLM') IS NULL
BEGIN
    CREATE DATABASE DBVLM;
END
GO

USE DBVLM;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'core')
    EXEC('CREATE SCHEMA core');
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'hr')
    EXEC('CREATE SCHEMA hr');
GO

/* 2. MASTER TABLES */
CREATE TABLE core.Division (
    DivisionId INT IDENTITY(1,1) PRIMARY KEY,
    DivisionName NVARCHAR(100) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE core.Department (
    DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
    DivisionId INT NOT NULL,
    DepartmentName NVARCHAR(100) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Department_Division FOREIGN KEY (DivisionId) REFERENCES core.Division(DivisionId)
);

CREATE TABLE core.Designation (
    DesignationId INT IDENTITY(1,1) PRIMARY KEY,
    DesignationName NVARCHAR(100) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE core.Perspective (
    PerspectiveId INT IDENTITY(1,1) PRIMARY KEY,
    PerspectiveName NVARCHAR(100) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

/* 3. INSERT MASTER DATA */
INSERT INTO core.Division (DivisionName)
VALUES ('Sales'), ('IT'), ('HR'), ('Finance');

INSERT INTO core.Department (DivisionId, DepartmentName)
VALUES (1, 'Sales Operations'),
       (1, 'Marketing'),
       (2, 'Software Development'),
       (1, 'Retail Sales'),
       (2, 'IT Support'),
       (3, 'Recruitment'),
       (4, 'Accounts Payable'),
       (4, 'Financial Planning');

INSERT INTO core.Designation (DesignationName)
VALUES ('Software Engineer'),
       ('Senior Software Engineer'),
       ('Junior Software Engineer'),
       ('QA Engineer'),
       ('System Administrator'),
       ('Network Engineer'),
       ('HR Executive'),
       ('HR Manager'),
       ('Accountant'),
       ('Senior Accountant'),
       ('Finance Manager'),
       ('Sales Executive'),
       ('Marketing Executive'),
       ('Business Analyst');

INSERT INTO core.Perspective (PerspectiveName)
VALUES ('Financial'), ('People'), ('Customer'), ('Internal Process');
GO

/* 4. SEQUENCES (CACHE 500) */
CREATE SEQUENCE hr.Seq_Requisition
    START WITH 1000
    INCREMENT BY 1
    CACHE 500;

CREATE SEQUENCE hr.Seq_RequisitionDetail
    START WITH 1
    INCREMENT BY 1
    CACHE 500;
GO

/* 5. REQUISITION & REQUISITION DETAIL TABLES */
CREATE TABLE hr.Requisition (
    RequisitionId BIGINT NOT NULL CONSTRAINT DF_Requisition_ID DEFAULT NEXT VALUE FOR hr.Seq_Requisition,
    RequisitionNo NVARCHAR(50) NOT NULL,
    ReqDate DATE NOT NULL,
    DivisionId INT NOT NULL,
    DepartmentId INT NOT NULL,
    DesignationId INT NOT NULL,
    Vacancy INT NOT NULL,
    Status NVARCHAR(20) NOT NULL CONSTRAINT DF_Requisition_Status DEFAULT 'DRAFT',
    Description NVARCHAR(500) NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT PK_Requisition PRIMARY KEY CLUSTERED (RequisitionId) WITH (OPTIMIZE_FOR_SEQUENTIAL_KEY = ON),
    CONSTRAINT UQ_Requisition_RequisitionNo UNIQUE (RequisitionNo),
    CONSTRAINT FK_Requisition_Division FOREIGN KEY (DivisionId) REFERENCES core.Division(DivisionId),
    CONSTRAINT FK_Requisition_Department FOREIGN KEY (DepartmentId) REFERENCES core.Department(DepartmentId),
    CONSTRAINT FK_Requisition_Designation FOREIGN KEY (DesignationId) REFERENCES core.Designation(DesignationId)
);
GO

CREATE TABLE hr.RequisitionDetail (
    RequisitionDetailId BIGINT NOT NULL CONSTRAINT DF_RequisitionDetail_ID DEFAULT NEXT VALUE FOR hr.Seq_RequisitionDetail,
    RequisitionId BIGINT NOT NULL,
    PerspectiveId INT NOT NULL,
    Objective NVARCHAR(500) NOT NULL,
    KPI NVARCHAR(200) NULL,
    WeightagePercentage DECIMAL(5,2) NULL,
    Remarks NVARCHAR(500) NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT PK_RequisitionDetail PRIMARY KEY CLUSTERED (RequisitionDetailId) WITH (OPTIMIZE_FOR_SEQUENTIAL_KEY = ON),
    CONSTRAINT FK_RequisitionDetail_Requisition FOREIGN KEY (RequisitionId) REFERENCES hr.Requisition(RequisitionId) ON DELETE CASCADE,
    CONSTRAINT FK_RequisitionDetail_Perspective FOREIGN KEY (PerspectiveId) REFERENCES core.Perspective(PerspectiveId)
);
GO

/* 6. INDEXES */
CREATE NONCLUSTERED INDEX IX_Requisition_Status ON hr.Requisition (Status);
CREATE NONCLUSTERED INDEX IX_Requisition_Department ON hr.Requisition (DepartmentId);
CREATE NONCLUSTERED INDEX IX_RequisitionDetail_RequisitionId ON hr.RequisitionDetail (RequisitionId);
CREATE NONCLUSTERED INDEX IX_RequisitionDetail_PerspectiveId ON hr.RequisitionDetail (PerspectiveId);
GO