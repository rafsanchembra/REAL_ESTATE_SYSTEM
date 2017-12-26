USE [RealEstateManagementSystemDataBase]

/*--FREELAND SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_FreeLandSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_FreeLandSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_FreeLandSELECTALL] 
	-- Add the parameters for the stored procedure here
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_FreeLands].ID ,
	[dbo].[APP_FreeLands].FreeLandName ,
	[dbo].[APP_FreeLands].FreeLandCompanyName ,
	[dbo].[APP_FreeLands].FreeLandOfficialName ,
	[dbo].[APP_FreeLands].FreeLandRentingPrice ,
	[dbo].[APP_FreeLands].FreeLandProvince ,
	[dbo].[APP_FreeLands].FreeLandCity ,
	[dbo].[APP_FreeLands].FreeLandVillage ,
	[dbo].[APP_FreeLands].FreeLandPlace ,
	[dbo].[APP_FreeLands].FreeLandMemo ,
	[dbo].[APP_FreeLands].FreeLandAddedBy ,
	[dbo].[APP_FreeLands].FreeLandAddedDate ,
	[dbo].[APP_FreeLands].FreeLandUpdatedBy ,
	[dbo].[APP_FreeLands].FreeLandUpdatedDate ,
	[dbo].[APP_Provinces].[ProvinceName],
	[dbo].[APP_Cities].[CityName] ,
	[dbo].[APP_Villages].[VillageName] ,
	Adder.[UserName] AS [AddedBy],
	Updater.[UserName] AS [UpdatedBy]
	FROM [dbo].[APP_FreeLands]
	LEFT JOIN [dbo].[Users] AS Adder ON [dbo].[APP_FreeLands].[FreeLandAddedBy] = Adder.[UserId]
	LEFT JOIN [dbo].[Users] AS Updater ON [dbo].[APP_FreeLands].[FreeLandUpdatedBy] = Updater.[UserId]
	LEFT JOIN [dbo].[APP_Provinces] ON [dbo].[APP_Provinces].[ID] = [dbo].[APP_FreeLands].[FreeLandProvince]
	LEFT JOIN [dbo].[APP_Cities] ON [dbo].[APP_Cities].[ID] = [dbo].[APP_FreeLands].[FreeLandCity] 
	LEFT JOIN [dbo].[APP_Villages] ON [dbo].[APP_Villages].[ID] = [dbo].[APP_FreeLands].[FreeLandVillage]  
	ORDER BY [FreeLandName]
	
	COMMIT 
GO


/*END*/

/*--FREELAND SELECT ---*/

IF OBJECT_ID('[dbo].[PROC_APP_FreeLandSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_FreeLandSELECT] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_FreeLandSELECT] 
	-- Add the parameters for the stored procedure here
	@ID bigint 
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN
    -- Insert statements for procedure here
	SELECT [dbo].[APP_FreeLands].ID ,
	[dbo].[APP_FreeLands].FreeLandName ,
	[dbo].[APP_FreeLands].FreeLandCompanyName ,
	[dbo].[APP_FreeLands].FreeLandOfficialName ,
	[dbo].[APP_FreeLands].FreeLandRentingPrice ,
	[dbo].[APP_FreeLands].FreeLandProvince ,
	[dbo].[APP_FreeLands].FreeLandCity ,
	[dbo].[APP_FreeLands].FreeLandVillage ,
	[dbo].[APP_FreeLands].FreeLandPlace ,
	[dbo].[APP_FreeLands].FreeLandMemo ,
	[dbo].[APP_FreeLands].FreeLandAddedBy ,
	[dbo].[APP_FreeLands].FreeLandAddedDate ,
	[dbo].[APP_FreeLands].FreeLandUpdatedBy ,
	[dbo].[APP_FreeLands].FreeLandUpdatedDate 
	FROM [dbo].[APP_FreeLands]
	WHERE [dbo].[APP_FreeLands].[ID] = @ID
	
	COMMIT

GO


/*END*/


/*--FREELAND UPDATE ---*/

IF OBJECT_ID('[dbo].[PROC_APP_FreeLandUPDATE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_FreeLandUPDATE] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_FreeLandUPDATE] 
	-- Add the parameters for the stored procedure here
	@ID bigint ,
	@FreeLandName nvarchar(150),
	@FreeLandOfficialName nvarchar(150),
	@FreeLandCompanyName nvarchar(150),
	@FreeLandRentingPrice money,
	@FreeLandProvince bigint,
	@FreeLandCity bigint,
	@FreeLandVillage bigint,
	@FreeLandPlace nvarchar(50),
	@FreeLandMemo nvarchar(MAX),
	@FreeLandUpdatedBy uniqueidentifier,
	@FreeLandUpdatedDate datetime
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[APP_FreeLands] 
	SET 
	[dbo].[APP_FreeLands].FreeLandName = @FreeLandName ,
	[dbo].[APP_FreeLands].FreeLandOfficialName = @FreeLandOfficialName ,
	[dbo].[APP_FreeLands].FreeLandCompanyName = @FreeLandCompanyName ,
	[dbo].[APP_FreeLands].FreeLandRentingPrice = @FreeLandRentingPrice ,
	[dbo].[APP_FreeLands].FreeLandProvince = @FreeLandProvince ,
	[dbo].[APP_FreeLands].FreeLandCity = @FreeLandCity ,
	[dbo].[APP_FreeLands].FreeLandVillage = @FreeLandVillage ,
	[dbo].[APP_FreeLands].FreeLandPlace = @FreeLandPlace ,
	[dbo].[APP_FreeLands].FreeLandMemo = @FreeLandMemo ,
	[dbo].[APP_FreeLands].FreeLandUpdatedBy = @FreeLandUpdatedBy ,
	[dbo].[APP_FreeLands].FreeLandUpdatedDate = @FreeLandUpdatedDate 
	WHERE [dbo].[APP_FreeLands].ID = @ID
	
	COMMIT
GO

/*END*/

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------