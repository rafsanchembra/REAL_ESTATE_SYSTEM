USE [RealEstateManagementSystemDataBase]


/*--SUPPLIER SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_SuppliersSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_SuppliersSELECTALL] 
END 
GO
CREATE PROC [dbo].[PROC_APP_SuppliersSELECTALL] 
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_Suppliers].[ID], [dbo].[APP_Suppliers].[SupplierContactID], [dbo].[APP_Suppliers].[SupplierStaffName1], [dbo].[APP_Suppliers].[SupplierStaffName2], 
	[dbo].[APP_Suppliers].[SupplierStaffName1GSM], [dbo].[APP_Suppliers].[SupplierStaffName2GSM], [dbo].[APP_Suppliers].[SupplierDocument], 
	[dbo].[APP_Suppliers].[SupplierMemo], [dbo].[APP_Suppliers].[SupplierAddedBy], [dbo].[APP_Suppliers].[SupplierAddedDate], [dbo].[APP_Suppliers].[SupplierUpdatedBy], 
	[dbo].[APP_Suppliers].[SupplierUpdatedDate], [dbo].[APP_Suppliers].[SupplierStatus], [dbo].[APP_Contacts].[ContactNickName] + '  ' + [dbo].[APP_Contacts].[ContactName] AS [ContactName], [dbo].[APP_Contacts].[ContactGSM1],
	CASE	
		WHEN [dbo].[APP_Suppliers].[SupplierStatus] = '1' THEN 'Active'
		ELSE 'Freezed'
	END AS [SupplierStatusName],
	Adder.[UserName] AS [AddedBy], Updater.[UserName] AS [UpdatedBy]
	FROM   [dbo].[APP_Suppliers] 
	LEFT JOIN [dbo].[APP_Contacts] ON [dbo].[APP_Suppliers].[SupplierContactID] = [dbo].[APP_Contacts].[ID]
	LEFT JOIN [dbo].[Users] AS Adder ON [dbo].[APP_Suppliers].[SupplierAddedBy] = Adder.[UserId]
	LEFT JOIN [dbo].[Users] AS Updater ON [dbo].[APP_Suppliers].[SupplierUpdatedBy] = Updater.[UserId]

	COMMIT


GO


/*END*/

/*--SUPPLIER UPDATE---*/

IF OBJECT_ID('[dbo].[PROC_APP_SuppliersUPDATE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_SuppliersUPDATE] 
END 
GO

CREATE PROC [dbo].[PROC_APP_SuppliersUPDATE] 
    @ID bigint,
    @SupplierContactID bigint,
    @SupplierStaffName1 nvarchar(50),
    @SupplierStaffName2 nvarchar(50),
    @SupplierStaffName1GSM nvarchar(20),
    @SupplierStaffName2GSM nvarchar(20),
    @SupplierDocument nvarchar(120),
    @SupplierMemo nvarchar(MAX),
    @SupplierUpdatedBy uniqueidentifier,
    @SupplierUpdatedDate datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[APP_Suppliers]
	SET    [SupplierContactID] = @SupplierContactID, [SupplierStaffName1] = @SupplierStaffName1, [SupplierStaffName2] = @SupplierStaffName2, [SupplierStaffName1GSM] = @SupplierStaffName1GSM, [SupplierStaffName2GSM] = @SupplierStaffName2GSM, [SupplierDocument] = @SupplierDocument, [SupplierMemo] = @SupplierMemo, [SupplierUpdatedBy] = @SupplierUpdatedBy, [SupplierUpdatedDate] = @SupplierUpdatedDate
	WHERE  [ID] = @ID
	
	-- Begin Return Select <- do not remove
	SELECT [ID], [SupplierContactID], [SupplierStaffName1], [SupplierStaffName2], [SupplierStaffName1GSM], [SupplierStaffName2GSM], [SupplierDocument], [SupplierMemo], [SupplierAddedBy], [SupplierAddedDate], [SupplierUpdatedBy], [SupplierUpdatedDate], [SupplierStatus]
	FROM   [dbo].[APP_Suppliers]
	WHERE  [ID] = @ID	
	-- End Return Select <- do not remove

	COMMIT


GO

/*END*/


------------------------------------------------------------------