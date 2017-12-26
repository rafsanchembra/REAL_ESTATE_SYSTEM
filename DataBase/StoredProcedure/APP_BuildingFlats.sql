USE [RealEstateManagementSystemDataBase]




/*---BUILDING FLAT SELECT---*/

IF OBJECT_ID('[dbo].[PROC_APP_BuildingFlatSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BuildingFlatSELECT] 
END 
GO

CREATE PROCEDURE [dbo].[PROC_APP_BuildingFlatSELECT] 
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN
	SELECT [dbo].[APP_BuildingFlats].ID ,
	[dbo].[APP_BuildingFlats].BuildingID ,
	[dbo].[APP_BuildingFlats].FloorID ,
	[dbo].[APP_BuildingFlats].FlatName ,
	[dbo].[APP_BuildingFlats].FlatNumber ,
	[dbo].[APP_BuildingFlats].FlatRoomNo ,
	[dbo].[APP_BuildingFlats].FlatBathRoomNo ,
	[dbo].[APP_BuildingFlats].FlatBathRoomType ,
	[dbo].[APP_BuildingFloors].FloorName 
	FROM [dbo].[APP_BuildingFlats] 
	LEFT JOIN [dbo].[APP_BuildingFloors] ON [dbo].[APP_BuildingFloors].ID = [dbo].[APP_BuildingFlats].FloorID
	WHERE [dbo].[APP_BuildingFlats].BuildingID  = @ID 
	COMMIT

GO

/*END*/