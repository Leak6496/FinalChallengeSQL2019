﻿/*
Deployment script for MusicDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "MusicDB"
:setvar DefaultFilePrefix "MusicDB"
:setvar DefaultDataPath "C:\Users\chhor\AppData\Local\Microsoft\VisualStudio\SSDT\MusicDBSolution"
:setvar DefaultLogPath "C:\Users\chhor\AppData\Local\Microsoft\VisualStudio\SSDT\MusicDBSolution"

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
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = AUTO, OPERATION_MODE = READ_WRITE) 
            WITH ROLLBACK IMMEDIATE;
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

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
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

/*
Delete from Sale1119;
Delete from Customer1119;
Delete from Interes1119;
Delete from Record1119;
*/


/*
INSERT INTO [dbo].[Interest1119]([InterestCode], [InterestDesc]) Values('RR','Rock and Roll');

Insert into [dbo].[Interest1119]([InterestCode],[InterestDesc]) Values('JA','Jazz');
Insert into [dbo].[Interest1119]([InterestCode],[InterestDesc]) Values('RB','Rhythm and Blues'); 


Insert into Customer1119(CustNo,CustName,CustAddr,CustPostCode,InterestCode) Values(123,'Jimmy Barnes','1 Sesame Street',3000,'RR');
Insert into Customer1119(CustNo,CustName,CustAddr,CustPostCode,InterestCode) Values(456,'Ian Moss','10 Downing Street',4000,'JA');
Insert into Customer1119(CustNo,CustName,CustAddr,CustPostCode,InterestCode) Values(789,'Don Walker','221B Baker Street',5000,'RB');
Insert into Customer1119(CustNo,CustName,CustAddr,CustPostCode,InterestCode) Values(234,'Steve Prestwich','LG1 College Cres, Parkville',6000,'RR');
Insert into Customer1119(CustNo,CustName,CustAddr,CustPostCode,InterestCode) Values(567,'Phil Small','1 Adelaide Avenue',7000,'RB')

Insert into Record1119(RecordID,Title,Performer) Values('PF002','The Dark Side of the Moon','Pink Floyd');
Insert into Record1119(RecordID,Title,Performer) Values('PF003','The Wall','Pink Floyd');
Insert into Record1119(RecordID,Title,Performer) Values('PF004','The Endless River','Pink Floyd');
Insert into Record1119(RecordID,Title,Performer) Values('PF006','Wish You Were Here','Pink Floyd');
Insert into Record1119(RecordID,Title,Performer) Values('PF007','The Division Bell','Pink Floyd');
Insert into Record1119(RecordID,Title,Performer) Values('IX002','Kick','INXS');
Insert into Record1119(RecordID,Title,Performer) Values('IX005','Shabooh Shoobah','INXS');
Insert into Record1119(RecordID,Title,Performer) Values('SP069','Never Mind the Bollocks','Sex Pistols');
Insert into Record1119(RecordID,Title,Performer) Values('SP070','Floggin a Dead Horse','Sex Pistols');
Insert into Record1119(RecordID,Title,Performer) Values('SP075','Agents of Anarchy','Sex Pistols');


insert into Sale1119(CustNo,RecordID,[Date],Price) Values(123,'PF003','1-Dec-2015',30.00);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(123,'IX002','1-Dec-2015',29.95);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(123,'SP069','2-Dec-2015',12.45);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(123,'IX002','5-Dec-2015',30.00);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(456,'PF002','1-Dec-2015',31.00);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(456,'IX005','3-Dec-2015',28.95);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(456,'SP070','6-Dec-2015',13.45);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(789,'PF004','2-Dec-2015',29.00);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(789,'IX002','5-Dec-2015',29.95);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(234,'PF006','1-Dec-2015',45.00);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(234,'SP075','4-Dec-2015',5.67);
insert into Sale1119(CustNo,RecordID,[Date],Price) Values(567,'PF007','03-Dec-15',9.95);
*/ 
GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
CREATE TABLE [#__checkStatus] (
    id           INT            IDENTITY (1, 1) PRIMARY KEY CLUSTERED,
    [Schema]     NVARCHAR (256),
    [Table]      NVARCHAR (256),
    [Constraint] NVARCHAR (256)
);

SET NOCOUNT ON;

DECLARE tableconstraintnames CURSOR LOCAL FORWARD_ONLY
    FOR SELECT SCHEMA_NAME([schema_id]),
               OBJECT_NAME([parent_object_id]),
               [name],
               0
        FROM   [sys].[objects]
        WHERE  [parent_object_id] IN (OBJECT_ID(N'dbo.Customer1119'), OBJECT_ID(N'dbo.Sale1119'))
               AND [type] IN (N'F', N'C')
                   AND [object_id] IN (SELECT [object_id]
                                       FROM   [sys].[check_constraints]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0
                                       UNION
                                       SELECT [object_id]
                                       FROM   [sys].[foreign_keys]
                                       WHERE  [is_not_trusted] <> 0
                                              AND [is_disabled] = 0);

DECLARE @schemaname AS NVARCHAR (256);

DECLARE @tablename AS NVARCHAR (256);

DECLARE @checkname AS NVARCHAR (256);

DECLARE @is_not_trusted AS INT;

DECLARE @statement AS NVARCHAR (1024);

BEGIN TRY
    OPEN tableconstraintnames;
    FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
    WHILE @@fetch_status = 0
        BEGIN
            PRINT N'Checking constraint: ' + @checkname + N' [' + @schemaname + N'].[' + @tablename + N']';
            SET @statement = N'ALTER TABLE [' + @schemaname + N'].[' + @tablename + N'] WITH ' + CASE @is_not_trusted WHEN 0 THEN N'CHECK' ELSE N'NOCHECK' END + N' CHECK CONSTRAINT [' + @checkname + N']';
            BEGIN TRY
                EXECUTE [sp_executesql] @statement;
            END TRY
            BEGIN CATCH
                INSERT  [#__checkStatus] ([Schema], [Table], [Constraint])
                VALUES                  (@schemaname, @tablename, @checkname);
            END CATCH
            FETCH tableconstraintnames INTO @schemaname, @tablename, @checkname, @is_not_trusted;
        END
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
END CATCH

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') >= 0
    CLOSE tableconstraintnames;

IF CURSOR_STATUS(N'LOCAL', N'tableconstraintnames') = -1
    DEALLOCATE tableconstraintnames;

SELECT N'Constraint verification failed:' + [Schema] + N'.' + [Table] + N',' + [Constraint]
FROM   [#__checkStatus];

IF @@ROWCOUNT > 0
    BEGIN
        DROP TABLE [#__checkStatus];
        RAISERROR (N'An error occurred while verifying constraints', 16, 127);
    END

SET NOCOUNT OFF;

DROP TABLE [#__checkStatus];


GO
PRINT N'Update complete.';


GO