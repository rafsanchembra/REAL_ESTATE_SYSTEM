USE [RealEstateManagementSystemDataBase]


/*---BUILDING ShopS TEMP SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingShopTempsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingShopTempsSELECTALL]
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingShopTempsSELECTALL] 
	@BuildingTempID bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingShopTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingShopTemps].[ShopName] ,
	[dbo].[APP_MultiFloorBuildingShopTemps].[ShopNumber],
	[dbo].[APP_MultiFloorBuildingShopTemps].[ShopFloorNo] ,
	CASE 
		WHEN [dbo].[APP_MultiFloorBuildingShopTemps].[ShopFloorNo] = '0' THEN 'Ground Floor'
		ELSE CAST([dbo].[APP_MultiFloorBuildingShopTemps].[ShopFloorNo] AS NVARCHAR(10))  +  ' Floor'
	END AS [FloorName]
	FROM [dbo].[APP_MultiFloorBuildingShopTemps]  
	WHERE [dbo].[APP_MultiFloorBuildingShopTemps].[MultiFloorBuildingID] = @BuildingTempID
	
	
	COMMIT

GO

/*END*/

/*---SHOP COPY FROM TEMP---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingShopCopyFromTemp]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingShopCopyFromTemp] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingShopCopyFromTemp] 
	@ShopTempID BIGINT,
	@BuildingID BIGINT ,
	@ShopID BIGINT OUTPUT
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	INSERT INTO [dbo].[APP_MultiFloorBuildingShops]([MultiFloorBuildingID], [ShopFloorNo], [ShopName], [ShopNumber], [ShopDescription])
	SELECT 	@BuildingID,
	[dbo].[APP_MultiFloorBuildingShopTemps].[ShopFloorNo],
	[dbo].[APP_MultiFloorBuildingShopTemps].[ShopName],
	[dbo].[APP_MultiFloorBuildingShopTemps].[ShopNumber],
	[dbo].[APP_MultiFloorBuildingShopTemps].[ShopDescription]
	FROM [dbo].[APP_MultiFloorBuildingShopTemps]
	WHERE [dbo].[APP_MultiFloorBuildingShopTemps].[ID] = @ShopTempID 
	
	SELECT @ShopID = SCOPE_IDENTITY()
	
	--DELETE 
	--FROM [dbo].[APP_MultiFloorBuildingShopTemps]
	--WHERE [dbo].[APP_MultiFloorBuildingShopTemps].[ID] = @ShopTempID
	
	
	COMMIT

GO

/*END*/


/*---BUILDING SHOP SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingShopsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingShopsSELECTALL]
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingShopsSELECTALL] 
	@BuildingID as  bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingShops].[ID] ,
	[dbo].[APP_MultiFloorBuildingShops].[ShopName] ,
	[dbo].[APP_MultiFloorBuildingShops].[ShopNumber],
	[dbo].[APP_MultiFloorBuildingShops].[ShopFloorNo] ,
	CASE 
		WHEN [dbo].[APP_MultiFloorBuildingShops].[ShopFloorNo] = '0' THEN 'Ground Floor'
		ELSE CAST([dbo].[APP_MultiFloorBuildingShops].[ShopFloorNo] AS NVARCHAR(10))  +  ' Floor'
	END AS [FloorName]
	FROM [dbo].[APP_MultiFloorBuildingShops]  
	WHERE [dbo].[APP_MultiFloorBuildingShops].[MultiFloorBuildingID] = @BuildingID
	
	
	COMMIT

GO

/*END*/