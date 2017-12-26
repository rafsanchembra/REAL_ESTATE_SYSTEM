USE [RealEstateManagementSystemDataBase]

IF OBJECT_ID('[dbo].[PROC_APP_BanksSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BanksSELECT] 
END 
GO
CREATE PROC [dbo].[PROC_APP_BanksSELECT] 
    @ID BIGINT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_Banks].[ID], 
	[dbo].[APP_Banks].[BankArabicName], 
	[dbo].[APP_Banks].[BankEnglishName], 
	[dbo].[APP_Banks].[BankSwiftCode], 
	[dbo].[APP_Banks].[BankIBANCode], 
	[dbo].[APP_Banks].[BankLatitudeCoordinates], 
	[dbo].[APP_Banks].[BankLongitudeCoordinates], 
	[dbo].[APP_Banks].[BankURLMap], 
	[dbo].[APP_Banks].[BankWebsite], 
	[dbo].[APP_Banks].[BankOnlineBankingURL], 
	[dbo].[APP_Banks].[BankDescription], 
	[dbo].[APP_Banks].[BankAddedBy], 
	[dbo].[APP_Banks].[BankAddedDate], 
	[dbo].[APP_Banks].[BankUpdatedBy], 
	[dbo].[APP_Banks].[BankUpdatedDate] 
	FROM   [dbo].[APP_Banks] 
	WHERE  ([ID] = @ID OR @ID IS NULL) 

	COMMIT
GO
IF OBJECT_ID('[dbo].[PROC_APP_BanksSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BanksSELECTALL] 
END 
GO
CREATE PROC [dbo].[PROC_APP_BanksSELECTALL] 
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_Banks].[ID], 
	[dbo].[APP_Banks].[BankArabicName], 
	[dbo].[APP_Banks].[BankEnglishName], 
	[dbo].[APP_Banks].[BankSwiftCode], 
	[dbo].[APP_Banks].[BankIBANCode], 
	[dbo].[APP_Banks].[BankLatitudeCoordinates], 
	[dbo].[APP_Banks].[BankLongitudeCoordinates], 
	[dbo].[APP_Banks].[BankURLMap], 
	[dbo].[APP_Banks].[BankWebsite], 
	[dbo].[APP_Banks].[BankOnlineBankingURL], 
	[dbo].[APP_Banks].[BankDescription], 
	[dbo].[APP_Banks].[BankAddedBy], 
	[dbo].[APP_Banks].[BankAddedDate], 
	[dbo].[APP_Banks].[BankUpdatedBy], 
	[dbo].[APP_Banks].[BankUpdatedDate],
	Adder.[UserName] AS [AddedBy], 
	Updater.[UserName] AS [UpdatedBy]
	FROM   [dbo].[APP_Banks]
	LEFT JOIN [dbo].[Users] AS Adder ON [dbo].[APP_Banks].[BankAddedBy] = Adder.[UserId]
	LEFT JOIN [dbo].[Users] AS Updater ON [dbo].[APP_Banks].[BankUpdatedBy] = Updater.[UserId]
	ORDER BY [dbo].[APP_Banks].[BankEnglishName]

	COMMIT
GO
IF OBJECT_ID('[dbo].[PROC_APP_BanksINSERT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BanksINSERT] 
END 
GO
CREATE PROC [dbo].[PROC_APP_BanksINSERT] 
    @BankArabicName nvarchar(30),
    @BankEnglishName nvarchar(30),
    @BankSwiftCode nvarchar(30),
    @BankIBANCode nvarchar(30),
    @BankLatitudeCoordinates nvarchar(15),
    @BankLongitudeCoordinates nvarchar(15),
    @BankURLMap nvarchar(60),
    @BankWebsite nvarchar(30),
    @BankOnlineBankingURL nvarchar(60),
    @BankDescription nvarchar(MAX),
    @BankAddedBy uniqueidentifier
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[APP_Banks] ([BankArabicName], [BankEnglishName], [BankSwiftCode], [BankIBANCode], [BankLatitudeCoordinates], [BankLongitudeCoordinates], [BankURLMap], [BankWebsite], [BankOnlineBankingURL], [BankDescription], [BankAddedBy])
	SELECT @BankArabicName, @BankEnglishName, @BankSwiftCode, @BankIBANCode, @BankLatitudeCoordinates, @BankLongitudeCoordinates, @BankURLMap, @BankWebsite, @BankOnlineBankingURL, @BankDescription, @BankAddedBy
	         
	COMMIT
GO
IF OBJECT_ID('[dbo].[PROC_APP_BanksUPDATE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BanksUPDATE] 
END 
GO
CREATE PROC [dbo].[PROC_APP_BanksUPDATE] 
    @ID bigint,
    @BankArabicName nvarchar(30),
    @BankEnglishName nvarchar(30),
    @BankSwiftCode nvarchar(30),
    @BankIBANCode nvarchar(30),
    @BankLatitudeCoordinates nvarchar(15),
    @BankLongitudeCoordinates nvarchar(15),
    @BankURLMap nvarchar(60),
    @BankWebsite nvarchar(30),
    @BankOnlineBankingURL nvarchar(60),
    @BankDescription nvarchar(MAX),
    @BankUpdatedBy uniqueidentifier,
    @BankUpdatedDate datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[APP_Banks]
	SET    [BankArabicName] = @BankArabicName, 
	[BankEnglishName] = @BankEnglishName, 
	[BankSwiftCode] = @BankSwiftCode, 
	[BankIBANCode] = @BankIBANCode, 
	[BankLatitudeCoordinates] = @BankLatitudeCoordinates, 
	[BankLongitudeCoordinates] = @BankLongitudeCoordinates, 
	[BankURLMap] = @BankURLMap, 
	[BankWebsite] = @BankWebsite, 
	[BankOnlineBankingURL] = @BankOnlineBankingURL, 
	[BankDescription] = @BankDescription, 
	[BankUpdatedBy] = @BankUpdatedBy, 
	[BankUpdatedDate] = @BankUpdatedDate
	WHERE  [ID] = @ID
	
	COMMIT
GO
IF OBJECT_ID('[dbo].[PROC_APP_BanksDELETE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BanksDELETE] 
END 
GO

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------