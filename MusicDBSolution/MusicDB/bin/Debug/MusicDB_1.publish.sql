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
PRINT N'Rename refactoring operation with key 65fb98ee-99d5-4750-98b1-fc5cb18d246c is skipped, element [dbo].[Record].[Id] (SqlSimpleColumn) will not be renamed to RecordID';


GO
PRINT N'Rename refactoring operation with key 77310387-da3e-44cd-aeb5-67e098140423 is skipped, element [dbo].[Interest].[Id] (SqlSimpleColumn) will not be renamed to InterestCode';


GO
PRINT N'Rename refactoring operation with key d4e645f3-5d49-4bdd-b7cf-791ddf22cf53 is skipped, element [dbo].[Customer].[Id] (SqlSimpleColumn) will not be renamed to CustNo';


GO
PRINT N'Rename refactoring operation with key bc5c118a-c699-4f3e-b8e2-5ed83463ec91 is skipped, element [dbo].[Sale].[Id] (SqlSimpleColumn) will not be renamed to CustNo';


GO
PRINT N'Creating [dbo].[Customer1119]...';


GO
CREATE TABLE [dbo].[Customer1119] (
    [CustNo]       INT            NOT NULL,
    [CustName]     NVARCHAR (50)  NULL,
    [CustAddr]     NVARCHAR (MAX) NULL,
    [CustPostCode] NUMERIC (18)   NULL,
    [InterestCode] NCHAR (10)     NULL,
    PRIMARY KEY CLUSTERED ([CustNo] ASC)
);


GO
PRINT N'Creating [dbo].[Interest1119]...';


GO
CREATE TABLE [dbo].[Interest1119] (
    [InterestCode] NCHAR (10)    NOT NULL,
    [InterestDesc] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([InterestCode] ASC)
);


GO
PRINT N'Creating [dbo].[Record1119]...';


GO
CREATE TABLE [dbo].[Record1119] (
    [RecordID]  NCHAR (10)    NOT NULL,
    [Title]     NVARCHAR (50) NULL,
    [Performer] NVARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([RecordID] ASC)
);


GO
PRINT N'Creating [dbo].[Sale1119]...';


GO
CREATE TABLE [dbo].[Sale1119] (
    [CustNo]   INT           NOT NULL,
    [RecordID] NCHAR (10)    NOT NULL,
    [Date]     NVARCHAR (50) NOT NULL,
    [Price]    MONEY         NULL,
    PRIMARY KEY CLUSTERED ([CustNo] ASC, [RecordID] ASC, [Date] ASC)
);


GO
PRINT N'Creating unnamed constraint on [dbo].[Customer1119]...';


GO
ALTER TABLE [dbo].[Customer1119] WITH NOCHECK
    ADD FOREIGN KEY ([InterestCode]) REFERENCES [dbo].[Interest1119] ([InterestCode]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Sale1119]...';


GO
ALTER TABLE [dbo].[Sale1119] WITH NOCHECK
    ADD FOREIGN KEY ([CustNo]) REFERENCES [dbo].[Customer1119] ([CustNo]);


GO
PRINT N'Creating unnamed constraint on [dbo].[Sale1119]...';


GO
ALTER TABLE [dbo].[Sale1119] WITH NOCHECK
    ADD FOREIGN KEY ([RecordID]) REFERENCES [dbo].[Record1119] ([RecordID]);


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
