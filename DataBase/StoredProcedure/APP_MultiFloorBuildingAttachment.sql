USE [RealEstateManagementSystemDataBase]


/*---BUILDING ATTACHMENT TEMP SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingAttachmentTempsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingAttachmentTempsSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingAttachmentTempsSELECTALL] 
	@UserID as uniqueidentifier
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingAttachmentTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingAttachmentTemps].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingAttachmentTemps].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingAttachmentTemps]  
	WHERE [APP_MultiFloorBuildingAttachmentTemps].[UserID]  = @UserID 
	
	COMMIT

GO

/*---BUILDING ATTACHMENT TEMP DELETE---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingAttachmentTempsDELETE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingAttachmentTempsDELETE] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingAttachmentTempsDELETE] 
	@ID AS bigint
	
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	DELETE 
	FROM  [dbo].[APP_MultiFloorBuildingAttachmentTemps]  
	WHERE [dbo].[APP_MultiFloorBuildingAttachmentTemps].[ID] = @ID 
	
	COMMIT

GO

/*END*/



/*---BUILDING ATTACHMENT SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingAttachmentsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingAttachmentsSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingAttachmentsSELECTALL] 
	@BuildingID AS BIGINT
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingAttachments].[ID] ,
	[dbo].[APP_MultiFloorBuildingAttachments].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingAttachments].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingAttachments]  
	WHERE [APP_MultiFloorBuildingAttachments].[BuildingID]  = @BuildingID
	
	COMMIT

GO

/*---BUILDING ATTACHMENT TEMP DELETE---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingAttachmentsDELETE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingAttachmentsDELETE] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingAttachmentsDELETE] 
	@ID AS bigint
	
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	DELETE 
	FROM  [dbo].[APP_MultiFloorBuildingAttachments]  
	WHERE [dbo].[APP_MultiFloorBuildingAttachments].[ID] = @ID 
	
	COMMIT

GO

/*END*/
