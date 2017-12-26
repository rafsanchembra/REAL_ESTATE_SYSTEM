USE [RealEstateManagementSystemDataBase]


/*---BUILDING SHOP ATTACHMENT TEMP SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingOfficeAttachmentTempsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingOfficeAttachmentTempsSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingOfficeAttachmentTempsSELECTALL] 
	@UserID as uniqueidentifier,
	@OfficeTempID as bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingOfficeAttachmentTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingOfficeAttachmentTemps].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingOfficeAttachmentTemps].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingOfficeAttachmentTemps]  
	WHERE [APP_MultiFloorBuildingOfficeAttachmentTemps].[UserID]  = @UserID 
	AND [APP_MultiFloorBuildingOfficeAttachmentTemps].[BuildingOfficeID]   = @OfficeTempID  
	
	COMMIT

GO


/*---BUILDING SHOP ATTACHMENT TEMP SELECT ---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingOfficeAttachmentTempsSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingOfficeAttachmentTempsSELECT] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingOfficeAttachmentTempsSELECT] 
	@OfficeID AS BIGINT
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingOfficeAttachmentTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingOfficeAttachmentTemps].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingOfficeAttachmentTemps].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingOfficeAttachmentTemps]  
	WHERE [APP_MultiFloorBuildingOfficeAttachmentTemps].[BuildingOfficeID] = @OfficeID 
	
	COMMIT

GO

/*---BUILDING FLAT ATTACHMENT TEMP DELETE---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingOfficeAttachmentTempsDELETE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingOfficeAttachmentTempsDELETE] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingOfficeAttachmentTempsDELETE] 
	@ID AS bigint
	
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	DELETE 
	FROM  [dbo].[APP_MultiFloorBuildingOfficeAttachmentTemps]  
	WHERE [dbo].[APP_MultiFloorBuildingOfficeAttachmentTemps].[ID] = @ID 
	
	COMMIT

GO


/*END*/

/*---BUILDING SHOP ATTACHMENT SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingOfficeAttachmentsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingOfficeAttachmentsSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingOfficeAttachmentsSELECTALL] 
	@UserID as uniqueidentifier
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingOfficeAttachments].[ID] ,
	[dbo].[APP_MultiFloorBuildingOfficeAttachments].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingOfficeAttachments].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingOfficeAttachments]  
	WHERE [APP_MultiFloorBuildingOfficeAttachments].[UserID]  = @UserID 
	
	COMMIT

GO


/*---BUILDING SHOP ATTACHMENT SELECT ---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingOfficeAttachmentsSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingOfficeAttachmentsSELECT] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingOfficeAttachmentsSELECT] 
	@OfficeID AS BIGINT
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingOfficeAttachments].[ID] ,
	[dbo].[APP_MultiFloorBuildingOfficeAttachments].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingOfficeAttachments].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingOfficeAttachments]  
	WHERE [APP_MultiFloorBuildingOfficeAttachments].[BuildingOfficeID] = @OfficeID 
	
	COMMIT

GO

/*---BUILDING FLAT ATTACHMENT DELETE---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingOfficeAttachmentsDELETE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingOfficeAttachmentsDELETE] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingOfficeAttachmentsDELETE] 
	@ID AS bigint
	
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	DELETE 
	FROM  [dbo].[APP_MultiFloorBuildingOfficeAttachments]  
	WHERE [dbo].[APP_MultiFloorBuildingOfficeAttachments].[ID] = @ID 
	
	COMMIT

GO


/*END*/
