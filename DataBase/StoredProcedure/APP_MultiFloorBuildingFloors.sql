USE [RealEstateManagementSystemDataBase]


/*---BUILDING FLOOR TEMP SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MultiFloorBuildingFloorTempsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MultiFloorBuildingFloorTempsSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MultiFloorBuildingFloorTempsSELECTALL] 
	@BuildingTempID bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingFloorTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingFloorTemps].[FloorName] ,
	[dbo].[APP_MultiFloorBuildingFloorTemps].[FloorNo] ,
	[dbo].[APP_MultiFloorBuildingFloorTemps].[FloorNo]  + '-' + [dbo].[APP_MultiFloorBuildingFloorTemps].[FloorName] AS [FloorSearchName] 
	FROM [dbo].[APP_MultiFloorBuildingFloorTemps]  
	WHERE [dbo].[APP_MultiFloorBuildingFloorTemps].[MultiFloorBuildingTempID] = @BuildingTempID
	
	
	COMMIT

GO

/*END*/
