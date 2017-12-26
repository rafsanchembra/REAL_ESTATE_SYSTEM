USE [RealEstateManagementSystemDataBase]

/*--FLAT SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_BuildingFloorsSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BuildingFloorsSELECT] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_BuildingFloorsSELECT] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN
	
	SELECT 
	[dbo].[APP_BuildingFloors].ID ,
	[dbo].[APP_BuildingFloors].BuildingID ,
	[dbo].[APP_BuildingFloors].FloorName ,
	[dbo].[APP_BuildingFloors].FloorNo 
	FROM [APP_BuildingFloors]
	WHERE [dbo].[APP_BuildingFloors].BuildingID = @ID 
	COMMIT
GO

/*END*/

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------