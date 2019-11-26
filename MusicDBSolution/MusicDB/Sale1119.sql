CREATE TABLE [dbo].[Sale1119]
(
	[CustNo] INT NOT NULL foreign key references Customer1119, 
    [RecordID] NCHAR(10) NOT NULL Foreign Key references Record1119 , 
    [Date] NVARCHAR(50) NOT NULL , 
    [Price] MONEY NOT NULL,
	Primary key(CustNo,RecordID,Date),
	

)
