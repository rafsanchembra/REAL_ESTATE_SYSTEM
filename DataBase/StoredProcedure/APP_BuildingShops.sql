USE [RealEstateManagementSystemDataBase]

/*--BUILDING SHOP SELECT---*/

IF OBJECT_ID('[dbo].[PROC_APP_BuildingShopsSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BuildingShopsSELECT] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_BuildingShopsSELECT]
	-- Add the parameters for the stored procedure here
	@ID bigint
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN
	SELECT [dbo].[APP_BuildingShops].ID ,
	[dbo].[APP_BuildingShops].FloorID ,
	[dbo].[APP_BuildingShops].BuildingID ,
	[dbo].[APP_BuildingShops].ShopName ,
	[dbo].[APP_BuildingShops].ShopNumber ,
	[dbo].[APP_BuildingShops].ShopCapacity ,
	[dbo].[APP_BuildingFloors].FloorName 
	FROM [dbo].[APP_BuildingShops]
	LEFT JOIN [dbo].[APP_BuildingFloors] ON [dbo].[APP_BuildingFloors].ID = [dbo].[APP_BuildingShops].FloorID
	WHERE [dbo].[APP_BuildingShops].BuildingID  = @ID 
	
	COMMIT
GO



/*END*/


------------------------------------------------------------------