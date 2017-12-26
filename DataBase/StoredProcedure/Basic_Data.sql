USE [RealEstateManagementSystemDataBase]


/*--GET APPLICATION ID---*/

IF OBJECT_ID('[dbo].[PROC_GetApplicationID]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_GetApplicationID] 
END 
GO
CREATE PROC [dbo].[PROC_GetApplicationID]
	@ApplicationName nvarchar(MAX),
	@ApplicationID uniqueidentifier OUTPUT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT @ApplicationID = [dbo].[Applications].[ApplicationId]
	FROM [dbo].[Applications]
	WHERE [dbo].[Applications].[ApplicationName] = @ApplicationName

	SELECT @ApplicationID

	COMMIT
GO

/*END*/

/*--CLEAR DATA---*/

IF OBJECT_ID('[dbo].[PROC_ClearAllData]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_ClearAllData] 
END 
GO
CREATE PROC [dbo].[PROC_ClearAllData] 
AS 
	TRUNCATE TABLE [dbo].[APP_BankAccounts]
	TRUNCATE TABLE [dbo].[APP_BankAccountTransactions]
	TRUNCATE TABLE [dbo].[APP_Banks]
	TRUNCATE TABLE [dbo].[APP_BankTransactionBetweenAccounts]
	TRUNCATE TABLE [dbo].[APP_BuildingAttachments]
	TRUNCATE TABLE [dbo].[APP_BuildingFlatAttachments]
	TRUNCATE TABLE [dbo].[APP_BuildingFlats]
	TRUNCATE TABLE [dbo].[APP_BuildingFloors]
	TRUNCATE TABLE [dbo].[APP_Buildings]
	TRUNCATE TABLE [dbo].[APP_BuildingShops]
	TRUNCATE TABLE [dbo].[APP_Cities]
	TRUNCATE TABLE [dbo].[APP_Clients]
	TRUNCATE TABLE [dbo].[APP_Contacts]
	TRUNCATE TABLE [dbo].[APP_FlatAttachments]
	TRUNCATE TABLE [dbo].[APP_Flats]
	TRUNCATE TABLE [dbo].[APP_FloorAttachments]
	TRUNCATE TABLE [dbo].[APP_FreeLandAttachments]
	TRUNCATE TABLE [dbo].[APP_FreeLands]
	TRUNCATE TABLE [dbo].[APP_Owners]
	TRUNCATE TABLE [dbo].[APP_Provinces]
	TRUNCATE TABLE [dbo].[APP_ShopAttachments]
	TRUNCATE TABLE [dbo].[APP_Suppliers]
	TRUNCATE TABLE [dbo].[APP_UserProfiles]
	TRUNCATE TABLE [dbo].[APP_VillaAttachments]
	TRUNCATE TABLE [dbo].[APP_Villages]
	TRUNCATE TABLE [dbo].[APP_Villas]

/*END*/
---------------------------------------