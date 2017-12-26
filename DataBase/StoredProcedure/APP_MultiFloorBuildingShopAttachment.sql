USE [RealEstateManagementSystemDataBase]


/*---BUILDING SHOP ATTACHMENT TEMP SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingShopAttachmentTempsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingShopAttachmentTempsSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingShopAttachmentTempsSELECTALL] 
	@UserID as uniqueidentifier,
	@ShopTempID as bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingShopAttachmentTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingShopAttachmentTemps].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingShopAttachmentTemps].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingShopAttachmentTemps]  
	WHERE [APP_MultiFloorBuildingShopAttachmentTemps].[UserID]  = @UserID 
	AND [APP_MultiFloorBuildingShopAttachmentTemps].[BuildingShopID]  = @ShopTempID  
	
	COMMIT

GO


/*---BUILDING SHOP ATTACHMENT TEMP SELECT ---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingShopAttachmentTempsSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingShopAttachmentTempsSELECT] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingShopAttachmentTempsSELECT] 
	@ShopID AS BIGINT
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingShopAttachmentTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingShopAttachmentTemps].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingShopAttachmentTemps].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingShopAttachmentTemps]  
	WHERE [APP_MultiFloorBuildingShopAttachmentTemps].[BuildingShopID]  = @ShopID 
	
	COMMIT

GO

/*---BUILDING FLAT ATTACHMENT TEMP DELETE---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingShopAttachmentTempsDELETE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingShopAttachmentTempsDELETE] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingShopAttachmentTempsDELETE] 
	@ID AS bigint
	
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	DELETE 
	FROM  [dbo].[APP_MultiFloorBuildingShopAttachmentTemps]  
	WHERE [dbo].[APP_MultiFloorBuildingShopAttachmentTemps].[ID] = @ID 
	
	COMMIT

GO


/*END*/



/*---BUILDING SHOP ATTACHMENT SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingShopAttachmentsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingShopAttachmentsSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingShopAttachmentsSELECTALL] 
	@UserID as uniqueidentifier
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingShopAttachments].[ID] ,
	[dbo].[APP_MultiFloorBuildingShopAttachments].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingShopAttachments].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingShopAttachments]  
	WHERE [APP_MultiFloorBuildingShopAttachments].[UserID]  = @UserID 
	
	COMMIT

GO


/*---BUILDING SHOP ATTACHMENT SELECT ---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingShopAttachmentsSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingShopAttachmentsSELECT] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingShopAttachmentsSELECT] 
	@ShopID AS BIGINT
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingShopAttachments].[ID] ,
	[dbo].[APP_MultiFloorBuildingShopAttachments].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingShopAttachments].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingShopAttachments]  
	WHERE [APP_MultiFloorBuildingShopAttachments].[BuildingShopID]  = @ShopID 
	
	COMMIT

GO

/*---BUILDING FLAT ATTACHMENT TEMP DELETE---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingShopAttachmentsDELETE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingShopAttachmentsDELETE] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingShopAttachmentsDELETE] 
	@ID AS bigint
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	DELETE 
	FROM  [dbo].[APP_MultiFloorBuildingShopAttachments]  
	WHERE [dbo].[APP_MultiFloorBuildingShopAttachments].[ID] = @ID 
	
	COMMIT

GO


/*END*/
