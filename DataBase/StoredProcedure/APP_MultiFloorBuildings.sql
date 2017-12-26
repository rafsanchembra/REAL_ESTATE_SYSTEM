USE [RealEstateManagementSystemDataBase]


/*---BUILDING SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingsSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingsSELECTALL] 
	-- Add the parameters for the stored procedure here
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildings].[ID] ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingName] ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingOfficialName] ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingRentingPrice] ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingContactName] ,
	CAST([dbo].[APP_Countries].[PhoneCode] AS NVARCHAR(10)) + [dbo].[APP_MultiFloorBuildings].[MFBuildingContactGSM] AS [ContactGSM],
	[dbo].[APP_MultiFloorBuildings].[MFBuildingMemo] ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingFloorCount]  ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingFlatCount]   ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingShopCount]  ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingOfficeCount]   ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingAddedBy] ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingAddedDate] ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingUpdatedBy] ,
	[dbo].[APP_MultiFloorBuildings].[MFBuildingUpdatedDate] ,
	Adder.[UserName] AS [AddedBy],
	Updater.[UserName] AS [UpdatedBy],
	[dbo].[APP_Contacts].[ContactName]  AS [OwnerName] 
	FROM [dbo].[APP_MultiFloorBuildings]  
	LEFT JOIN [dbo].[Users] AS Adder ON [dbo].[APP_MultiFloorBuildings].[MFBuildingAddedBy] = Adder.[UserId]
	LEFT JOIN [dbo].[Users] AS Updater ON [dbo].[APP_MultiFloorBuildings].[MFBuildingUpdatedBy] = Updater.[UserId]	
	LEFT JOIN [dbo].[APP_Countries] ON [dbo].[APP_MultiFloorBuildings].[MFBuildingContactGSMCountryCodeID] = [dbo].[APP_Countries].[ID]
	LEFT JOIN [dbo].[APP_Owners] ON [dbo].[APP_MultiFloorBuildings].[MFBuildingOwnerID] = [dbo].[APP_Owners].[ID]
	LEFT JOIN [dbo].[APP_Contacts] ON [dbo].[APP_Contacts].[ID] = [dbo].[APP_Owners].[OwnerContactID]
	ORDER BY [MFBuildingName]
	
	COMMIT

GO

/*END*/
 

/*---BUILDING COPY FROM TEMP---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingCopyFromTemp]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingCopyFromTemp] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingCopyFromTemp] 
	@BuildingTempID BIGINT,
	@BuildingID BIGINT OUTPUT
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	INSERT INTO [dbo].[APP_MultiFloorBuildings]([MFBuildingName], [MFBuildingOfficialName], [MFBuildingOwnerID], [MFBuildingContactName], 
				[MFBuildingContactGSMCountryCodeID] ,[MFBuildingContactGSM] ,[MFCurrencyTypeCountryCodeID],[MFBuildingRentingPrice],
				[MFBuildingAddress],[MFBuildingGPS],[MFBuildingMapUrl],[MFBuildingMemo],[MFBuildingFloorCount],[MFBuildingShopCount],
				[MFBuildingFlatCount],[MFBuildingOfficeCount])
	SELECT 
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingName],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingOfficialName],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingOwnerID],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingContactName],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingContactGSMCountryCodeID],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingContactGSM],
	[dbo].[APP_MultiFloorBuildingTemps].[MFCurrencyTypeCountryCodeID],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingRentingPrice],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingAddress],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingGPS],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingMapUrl],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingMemo],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingFloorCount],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingShopCount],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingFlatCount],
	[dbo].[APP_MultiFloorBuildingTemps].[MFBuildingOfficeCount]
	FROM [dbo].[APP_MultiFloorBuildingTemps]
	WHERE [dbo].[APP_MultiFloorBuildingTemps].[ID] = @BuildingTempID 
	
	SELECT @BuildingID = SCOPE_IDENTITY()
	
	--DELETE 
	--FROM [dbo].[APP_MultiFloorBuildingTemps]
	--WHERE [dbo].[APP_MultiFloorBuildingTemps].[ID] = @BuildingTempID
	
	
	COMMIT

GO

/*END*/
