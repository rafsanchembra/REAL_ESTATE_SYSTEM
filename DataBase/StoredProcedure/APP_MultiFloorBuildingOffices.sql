USE [RealEstateManagementSystemDataBase]


/*---BUILDING OFFICE TEMP SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingOfficeTempsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingOfficeTempsSELECTALL]
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingOfficeTempsSELECTALL] 
	@BuildingTempID bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingOfficeTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingOfficeTemps].[OfficeName] ,
	[dbo].[APP_MultiFloorBuildingOfficeTemps].[OfficeNumber],
	[dbo].[APP_MultiFloorBuildingOfficeTemps].[OfficeFloorNo] ,
	CASE 
		WHEN [dbo].[APP_MultiFloorBuildingOfficeTemps].[OfficeFloorNo] = '0' THEN 'Ground Floor'
		ELSE CAST([dbo].[APP_MultiFloorBuildingOfficeTemps].[OfficeFloorNo] AS NVARCHAR(10))  +  ' Floor'
	END AS [FloorName]
	FROM [dbo].[APP_MultiFloorBuildingOfficeTemps]  
	WHERE [dbo].[APP_MultiFloorBuildingOfficeTemps].[MultiFloorBuildingID] = @BuildingTempID
	
	
	COMMIT

GO

/*END*/

/*---OFFICE COPY FROM TEMP---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingOfficeCopyFromTemp]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingOfficeCopyFromTemp] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingOfficeCopyFromTemp] 
	@OfficeTempID BIGINT,
	@BuildingID BIGINT ,
	@OfficeID BIGINT OUTPUT
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	INSERT INTO [dbo].[APP_MultiFloorBuildingOffices]([MultiFloorBuildingID], [OfficeFloorNo], [OfficeName], [OfficeNumber], [OfficeDescription])
	SELECT 	@BuildingID,
	[dbo].[APP_MultiFloorBuildingOfficeTemps].[OfficeFloorNo],
	[dbo].[APP_MultiFloorBuildingOfficeTemps].[OfficeName],
	[dbo].[APP_MultiFloorBuildingOfficeTemps].[OfficeNumber],
	[dbo].[APP_MultiFloorBuildingOfficeTemps].[OfficeDescription]
	FROM [dbo].[APP_MultiFloorBuildingOfficeTemps]
	WHERE [dbo].[APP_MultiFloorBuildingOfficeTemps].[ID] = @OfficeTempID 
	
	SELECT @OfficeID = SCOPE_IDENTITY()
	
	--DELETE 
	--FROM [dbo].[APP_MultiFloorBuildingOfficeTemps]
	--WHERE [dbo].[APP_MultiFloorBuildingOfficeTemps].[ID] = @OfficeTempID
	
	
	COMMIT

GO


/*---BUILDING OFFICE  SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingOfficesSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingOfficesSELECTALL]
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingOfficesSELECTALL] 
	@BuildingID bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingOffices].[ID] ,
	[dbo].[APP_MultiFloorBuildingOffices].[OfficeName] ,
	[dbo].[APP_MultiFloorBuildingOffices].[OfficeNumber],
	[dbo].[APP_MultiFloorBuildingOffices].[OfficeFloorNo] ,
	CASE 
		WHEN [dbo].[APP_MultiFloorBuildingOffices].[OfficeFloorNo] = '0' THEN 'Ground Floor'
		ELSE CAST([dbo].[APP_MultiFloorBuildingOffices].[OfficeFloorNo] AS NVARCHAR(10))  +  ' Floor'
	END AS [FloorName]
	FROM [dbo].[APP_MultiFloorBuildingOffices]  
	WHERE [dbo].[APP_MultiFloorBuildingOffices].[MultiFloorBuildingID] = @BuildingID
	
	
	COMMIT

GO

/*END*/