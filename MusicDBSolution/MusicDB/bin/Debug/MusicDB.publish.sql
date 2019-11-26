﻿/*
Deployment script for DADICTWEB425

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DADICTWEB425"
:setvar DefaultFilePrefix "DADICTWEB425"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
/*
The column [dbo].[CUSTOMER].[CUSTID] is being dropped, data loss could occur.

The column [dbo].[CUSTOMER].[SALES_YTD] is being dropped, data loss could occur.

The column [dbo].[CUSTOMER].[STATUS] is being dropped, data loss could occur.

The column [dbo].[Customer].[CustNo] on table [dbo].[Customer] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The type for column CustName in table [dbo].[Customer] is currently  NVARCHAR (100) NULL but is being changed to  NVARCHAR (50) NULL. Data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Customer])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
/*
The column [dbo].[SALE].[CUSTID] is being dropped, data loss could occur.

The column [dbo].[SALE].[PRODID] is being dropped, data loss could occur.

The column [dbo].[SALE].[QTY] is being dropped, data loss could occur.

The column [dbo].[SALE].[SALEDATE] is being dropped, data loss could occur.

The column [dbo].[SALE].[SALEID] is being dropped, data loss could occur.

The column [dbo].[Sale].[CustNo] on table [dbo].[Sale] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [dbo].[Sale].[Date] on table [dbo].[Sale] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.

The column [dbo].[Sale].[RecordID] on table [dbo].[Sale] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Sale])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Rename refactoring operation with key 65fb98ee-99d5-4750-98b1-fc5cb18d246c is skipped, element [dbo].[Record].[Id] (SqlSimpleColumn) will not be renamed to RecordID';


GO
PRINT N'Rename refactoring operation with key 77310387-da3e-44cd-aeb5-67e098140423 is skipped, element [dbo].[Interest].[Id] (SqlSimpleColumn) will not be renamed to InterestCode';


GO
PRINT N'Rename refactoring operation with key d4e645f3-5d49-4bdd-b7cf-791ddf22cf53 is skipped, element [dbo].[Customer].[Id] (SqlSimpleColumn) will not be renamed to CustNo';


GO
PRINT N'Rename refactoring operation with key bc5c118a-c699-4f3e-b8e2-5ed83463ec91 is skipped, element [dbo].[Sale].[Id] (SqlSimpleColumn) will not be renamed to CustNo';


GO
PRINT N'Dropping unnamed constraint on [dbo].[SALE]...';


GO
ALTER TABLE [dbo].[SALE] DROP CONSTRAINT [FK__SALE__CUSTID__5B78929E];


GO
PRINT N'Dropping unnamed constraint on [dbo].[SALE]...';


GO
ALTER TABLE [dbo].[SALE] DROP CONSTRAINT [FK__SALE__PRODID__5C6CB6D7];


GO
PRINT N'Starting rebuilding table [dbo].[Customer]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Customer] (
    [CustNo]       INT            NOT NULL,
    [CustName]     NVARCHAR (50)  NULL,
    [CustAddr]     NVARCHAR (MAX) NULL,
    [CustPostCode] NUMERIC (18)   NULL,
    [InterestCode] NCHAR (10)     NULL,
    PRIMARY KEY CLUSTERED ([CustNo] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[CUSTOMER])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Customer] ([CUSTNAME])
        SELECT [CUSTNAME]
        FROM   [dbo].[CUSTOMER];
    END

DROP TABLE [dbo].[CUSTOMER];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Customer]', N'Customer';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[Sale]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Sale] (
    [CustNo]   INT           NOT NULL,
    [RecordID] NCHAR (10)    NOT NULL,
    [Date]     NVARCHAR (50) NOT NULL,
    [Price]    MONEY         NULL,
    PRIMARY KEY CLUSTERED ([CustNo] ASC, [RecordID] ASC, [Date] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[SALE])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Sale] ([PRICE])
        SELECT [PRICE]
        FROM   [dbo].[SALE];
    END

DROP TABLE [dbo].[SALE];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Sale]', N'Sale';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[Interest]...';


GO
CREATE TABLE [dbo].[Interest] (
    [InterestCode] NCHAR (10)    NOT NULL,
    [InterestDesc] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([InterestCode] ASC)
);


GO
PRINT N'Creating [dbo].[Record]...';


GO
CREATE TABLE [dbo].[Record] (
    [RecordID]  NCHAR (10)    NOT NULL,
    [Title]     NVARCHAR (50) NULL,
    [Performer] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([RecordID] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Customer]...';


GO
ALTER TABLE [dbo].[Customer] WITH NOCHECK
    ADD FOREIGN KEY ([InterestCode]) REFERENCES [dbo].[Interest] ([InterestCode]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Sale]...';


GO
ALTER TABLE [dbo].[Sale] WITH NOCHECK
    ADD FOREIGN KEY ([CustNo]) REFERENCES [dbo].[Customer] ([CustNo]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Sale]...';


GO
ALTER TABLE [dbo].[Sale] WITH NOCHECK
    ADD FOREIGN KEY ([RecordID]) REFERENCES [dbo].[Record] ([RecordID]);


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '65fb98ee-99d5-4750-98b1-fc5cb18d246c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('65fb98ee-99d5-4750-98b1-fc5cb18d246c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '77310387-da3e-44cd-aeb5-67e098140423')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('77310387-da3e-44cd-aeb5-67e098140423')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd4e645f3-5d49-4bdd-b7cf-791ddf22cf53')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d4e645f3-5d49-4bdd-b7cf-791ddf22cf53')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'bc5c118a-c699-4f3e-b8e2-5ed83463ec91')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('bc5c118a-c699-4f3e-b8e2-5ed83463ec91')

GO

GO