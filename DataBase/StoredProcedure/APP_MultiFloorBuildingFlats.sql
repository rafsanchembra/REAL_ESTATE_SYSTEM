USE [RealEstateManagementSystemDataBase]


/*---BUILDING FLATS TEMP SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingFlatTempsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingFlatTempsSELECTALL]
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingFlatTempsSELECTALL] 
	@BuildingTempID bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingFlatTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingFlatTemps].[FlatName] ,
	[dbo].[APP_MultiFloorBuildingFlatTemps].[FlatNumber],
	[dbo].[APP_MultiFloorBuildingFlatTemps].[FlatFloorNo] ,
	CASE 
		WHEN [dbo].[APP_MultiFloorBuildingFlatTemps].[FlatFloorNo] = '0' THEN 'Ground Floor'
		ELSE CAST([dbo].[APP_MultiFloorBuildingFlatTemps].[FlatFloorNo] AS NVARCHAR(10))  +  ' Floor'
	END AS [FloorName]
	FROM [dbo].[APP_MultiFloorBuildingFlatTemps]  
	WHERE [dbo].[APP_MultiFloorBuildingFlatTemps].[MultiFloorBuildingID] = @BuildingTempID
	
	
	COMMIT

GO

/*---FLAT COPY FROM TEMP---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingFlatCopyFromTemp]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingFlatCopyFromTemp] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingFlatCopyFromTemp] 
	@FlatTempID BIGINT,
	@BuildingID BIGINT ,
	@FlatID BIGINT OUTPUT
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	INSERT INTO [dbo].[APP_MultiFloorBuildingFlats]([MultiFloorBuildingID], [FlatFloorNo], [FlatName], [FlatNumber], [FlatDescription])
	SELECT 	@BuildingID,
	[dbo].[APP_MultiFloorBuildingFlatTemps].[FlatFloorNo],
	[dbo].[APP_MultiFloorBuildingFlatTemps].[FlatName],
	[dbo].[APP_MultiFloorBuildingFlatTemps].[FlatNumber],
	[dbo].[APP_MultiFloorBuildingFlatTemps].[FlatDescription]
	FROM [dbo].[APP_MultiFloorBuildingFlatTemps]
	WHERE [dbo].[APP_MultiFloorBuildingFlatTemps].[ID] = @FlatTempID 
	
	SELECT @FlatID = SCOPE_IDENTITY()
	
	--DELETE 
	--FROM [dbo].[APP_MultiFloorBuildingFlatTemps]
	--WHERE [dbo].[APP_MultiFloorBuildingFlatTemps].[ID] = @FlatTempID
	
	
	COMMIT

GO

/*END*/



/*---BUILDING FLATS SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingFlatsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingFlatsSELECTALL]
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingFlatsSELECTALL] 
	@BuildingID bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingFlats].[ID] ,
	[dbo].[APP_MultiFloorBuildingFlats].[FlatName] ,
	[dbo].[APP_MultiFloorBuildingFlats].[FlatNumber],
	[dbo].[APP_MultiFloorBuildingFlats].[FlatFloorNo] ,
	CASE 
		WHEN [dbo].[APP_MultiFloorBuildingFlats].[FlatFloorNo] = '0' THEN 'Ground Floor'
		ELSE CAST([dbo].[APP_MultiFloorBuildingFlats].[FlatFloorNo] AS NVARCHAR(10))  +  ' Floor'
	END AS [FloorName]
	FROM [dbo].[APP_MultiFloorBuildingFlats]  
	WHERE [dbo].[APP_MultiFloorBuildingFlats].[MultiFloorBuildingID] = @BuildingID
	
	
	COMMIT

GO