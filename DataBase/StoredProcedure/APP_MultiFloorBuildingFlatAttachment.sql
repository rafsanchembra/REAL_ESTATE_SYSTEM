USE [RealEstateManagementSystemDataBase]


/*---BUILDING FlAT ATTACHMENT TEMP SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingFlatAttachmentTempsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingFlatAttachmentTempsSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingFlatAttachmentTempsSELECTALL] 
	@UserID as uniqueidentifier,
	@FlatTempID as bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingFlatAttachmentTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingFlatAttachmentTemps].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingFlatAttachmentTemps].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingFlatAttachmentTemps]  
	WHERE [APP_MultiFloorBuildingFlatAttachmentTemps].[UserID]  = @UserID 
	AND [APP_MultiFloorBuildingFlatAttachmentTemps].[BuildingFlatID]   = @FlatTempID 
	
	COMMIT

GO

/*---BUILDING FlAT ATTACHMENT TEMP SELECT---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingFlatAttachmentTempsSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingFlatAttachmentTempsSELECT] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingFlatAttachmentTempsSELECT] 
	@FlatID AS BIGINT
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingFlatAttachmentTemps].[ID] ,
	[dbo].[APP_MultiFloorBuildingFlatAttachmentTemps].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingFlatAttachmentTemps].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingFlatAttachmentTemps]  
	WHERE [APP_MultiFloorBuildingFlatAttachmentTemps].[BuildingFlatID]   = @FlatID 
	
	COMMIT

GO

/*---BUILDING FLAT ATTACHMENT TEMP DELETE---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingFlatAttachmentTempsDELETE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingFlatAttachmentTempsDELETE] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingFlatAttachmentTempsDELETE] 
	@ID AS bigint
	
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	DELETE 
	FROM  [dbo].[APP_MultiFloorBuildingFlatAttachmentTemps]  
	WHERE [dbo].[APP_MultiFloorBuildingFlatAttachmentTemps].[ID] = @ID 
	
	COMMIT

GO


/*END*/


/*---BUILDING FlAT ATTACHMENT SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingFlatAttachmentsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingFlatAttachmentsSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingFlatAttachmentsSELECTALL] 
	@UserID AS UNIQUEIDENTIFIER 
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingFlatAttachments].[ID] ,
	[dbo].[APP_MultiFloorBuildingFlatAttachments].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingFlatAttachments].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingFlatAttachments]  
	WHERE [APP_MultiFloorBuildingFlatAttachments].[UserID]  = @UserID
	
	COMMIT

GO


/*---BUILDING FlAT ATTACHMENT SELECT ---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingFlatAttachmentsSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingFlatAttachmentsSELECT] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingFlatAttachmentsSELECT] 
	@FlatID AS BIGINT 
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_MultiFloorBuildingFlatAttachments].[ID] ,
	[dbo].[APP_MultiFloorBuildingFlatAttachments].[BuildingAttachmentName] ,
	[dbo].[APP_MultiFloorBuildingFlatAttachments].[BuildingAttachment]  
	FROM [dbo].[APP_MultiFloorBuildingFlatAttachments]  
	WHERE [APP_MultiFloorBuildingFlatAttachments].[BuildingFlatID]  = @FlatID
	
	COMMIT

GO

/*---BUILDING FLAT ATTACHMENT DELETE---*/

IF OBJECT_ID('[dbo].[PROC_APP_MFBuildingFlatAttachmentsDELETE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_MFBuildingFlatAttachmentsDELETE] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_MFBuildingFlatAttachmentsDELETE] 
	@ID AS bigint
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	DELETE 
	FROM  [dbo].[APP_MultiFloorBuildingFlatAttachments]  
	WHERE [dbo].[APP_MultiFloorBuildingFlatAttachments].[ID] = @ID 
	
	COMMIT

GO


/*END*/
