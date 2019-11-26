CREATE TABLE [dbo].[Customer1119]
(
	[CustNo] INT NOT NULL PRIMARY KEY, 
    [CustName] NVARCHAR(50) NOT NULL, 
    [CustAddr] NVARCHAR(MAX) NOT NULL, 
    [CustPostCode] NUMERIC NOT NULL, 
    [InterestCode] NCHAR(10) NOT NULL FOREIGN KEY References Interest1119
)
