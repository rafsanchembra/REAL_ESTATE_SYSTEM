USE [RealEstateManagementSystemDataBase]

/*--CLIENT SELECT ALL---*/
IF OBJECT_ID('[dbo].[PROC_APP_ClientsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_ClientsSELECTALL]
END 
GO
CREATE PROC [dbo].[PROC_APP_ClientsSELECTALL] 
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_Clients].[ID], 
	[dbo].[APP_Clients].[ClientContactID], 
	[dbo].[APP_Clients].[ClientStaffName1], 
	[dbo].[APP_Clients].[ClientStaffName2], 
	[dbo].[APP_Clients].[ClientStaffName1GSM], 
	[dbo].[APP_Clients].[ClientStaffName2GSM], 
	[dbo].[APP_Clients].[ClientDocument], 
	[dbo].[APP_Clients].[ClientMemo], 
	[dbo].[APP_Clients].[ClientAddedBy], 
	[dbo].[APP_Clients].[ClientAddedDate], 
	[dbo].[APP_Clients].[ClientUpdatedBy], 
	[dbo].[APP_Clients].[ClientUpdatedDate], 
	[dbo].[APP_Clients].[ClientStatus] , 
	[dbo].[APP_Contacts].[ContactNickName] + '  ' + [dbo].[APP_Contacts].[ContactName] AS [ContactName],
	CASE 
		WHEN [dbo].[APP_Clients].[ClientStatus] = '1' THEN 'Active'
		ELSE 'Freezed'
	END AS [ClientStatusName],
	Adder.[UserName] AS [AddedBy],
	Updater.[UserName] AS [UpdatedBy]
	FROM   [dbo].[APP_Clients] 
	LEFT JOIN [dbo].[APP_Contacts] ON [dbo].[APP_Clients].[ClientContactID] = [dbo].[APP_Contacts].[ID]
	LEFT JOIN [dbo].[Users] AS Adder ON [dbo].[APP_Clients].[ClientAddedBy] = Adder.[UserId]
	LEFT JOIN [dbo].[Users] AS Updater ON [dbo].[APP_Clients].[ClientUpdatedBy] = Updater.[UserId]
	ORDER BY [ClientContactID]

	COMMIT


GO



/*END*/

/*--CLIENT SELECT---*/
IF OBJECT_ID('[dbo].[PROC_APP_ClientsSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_ClientsSELECT]
END 
GO
CREATE PROC [dbo].[PROC_APP_ClientsSELECT] 
    @ID BIGINT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [ID], [ClientContactID], 
	[ClientStaffName1], [ClientStaffName2], 
	[ClientStaffName1GSM], [ClientStaffName2GSM], 
	[ClientDocument], [ClientMemo], [ClientAddedBy], 
	[ClientAddedDate], [ClientUpdatedBy], 
	[ClientUpdatedDate], 
	[ClientStatus] 
	FROM   [dbo].[APP_Clients] 
	WHERE  ([ID] = @ID) 

	COMMIT


GO

/*END*/


/*---CLIENT UPDATE---*/

IF OBJECT_ID('[dbo].[PROC_APP_ClientsUPDATE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_ClientsUPDATE]
END 
GO
CREATE PROC [dbo].[PROC_APP_ClientsUPDATE] 
    @ID bigint,
    @ClientContactID bigint,
    @ClientStaffName1 nvarchar(50),
    @ClientStaffName2 nvarchar(50),
    @ClientStaffName1GSM nvarchar(20),
    @ClientStaffName2GSM nvarchar(20),
    @ClientDocument nvarchar(120),
    @ClientMemo nvarchar(MAX),
    @ClientUpdatedBy uniqueidentifier,
    @ClientUpdatedDate datetime,
    @ClientStatus nvarchar(8)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[APP_Clients]
	SET    [ClientContactID] = @ClientContactID, [ClientStaffName1] = @ClientStaffName1, [ClientStaffName2] = @ClientStaffName2, [ClientStaffName1GSM] = @ClientStaffName1GSM, [ClientStaffName2GSM] = @ClientStaffName2GSM, [ClientDocument] = @ClientDocument, [ClientMemo] = @ClientMemo, [ClientUpdatedBy] = @ClientUpdatedBy, [ClientUpdatedDate] = @ClientUpdatedDate, [ClientStatus] = @ClientStatus
	WHERE  [ID] = @ID
	
	-- Begin Return Select <- do not remove
	SELECT [ID], [ClientContactID], [ClientStaffName1], [ClientStaffName2], [ClientStaffName1GSM], [ClientStaffName2GSM], [ClientDocument], [ClientMemo], [ClientAddedBy], [ClientAddedDate], [ClientUpdatedBy], [ClientUpdatedDate], [ClientStatus]
	FROM   [dbo].[APP_Clients]
	WHERE  [ID] = @ID	
	-- End Return Select <- do not remove

	COMMIT


GO


/*END*/


/*---CLIENT INSERT ---*/
IF OBJECT_ID('[dbo].[PROC_APP_ClientsINSERT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_ClientsINSERT]
END 
GO


CREATE PROC [dbo].[PROC_APP_ClientsINSERT] 
    @ClientContactID bigint,
    @ClientStaffName1 nvarchar(50),
    @ClientStaffName2 nvarchar(50),
    @ClientStaffName1GSM nvarchar(20),
    @ClientStaffName2GSM nvarchar(20),
    @ClientDocument nvarchar(120),
    @ClientMemo nvarchar(MAX),
    @ClientAddedBy uniqueidentifier
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[APP_Clients] ([ClientContactID], [ClientStaffName1], [ClientStaffName2], [ClientStaffName1GSM], [ClientStaffName2GSM], [ClientDocument], [ClientMemo], [ClientAddedBy])
	SELECT @ClientContactID, @ClientStaffName1, @ClientStaffName2, @ClientStaffName1GSM, @ClientStaffName2GSM, @ClientDocument, @ClientMemo, @ClientAddedBy
	
	UPDATE [dbo].[APP_Clients]
	SET [ClientStatus] = '1'
	WHERE [ID] = SCOPE_IDENTITY()

	-- Begin Return Select <- do not remove
	SELECT [ID], [ClientContactID], [ClientStaffName1], [ClientStaffName2], [ClientStaffName1GSM], [ClientStaffName2GSM], [ClientDocument], [ClientMemo], [ClientAddedBy], [ClientAddedDate], [ClientUpdatedBy], [ClientUpdatedDate], [ClientStatus]
	FROM   [dbo].[APP_Clients]
	WHERE  [ID] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT


GO


/*END*/


/*--CLIENT ACTIVE SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_ClientsActiveSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_ClientsActiveSELECTALL]
END 
GO
CREATE PROC [dbo].[PROC_APP_ClientsActiveSELECTALL] 
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_Clients].[ID], [dbo].[APP_Clients].[ClientContactID], [dbo].[APP_Clients].[ClientStaffName1], [dbo].[APP_Clients].[ClientStaffName2], 
	[dbo].[APP_Clients].[ClientStaffName1GSM], [dbo].[APP_Clients].[ClientStaffName2GSM], [dbo].[APP_Clients].[ClientDocument], 
	[dbo].[APP_Clients].[ClientMemo], [dbo].[APP_Clients].[ClientAddedBy], [dbo].[APP_Clients].[ClientAddedDate], [dbo].[APP_Clients].[ClientUpdatedBy], 
	[dbo].[APP_Clients].[ClientUpdatedDate], [dbo].[APP_Clients].[ClientStatus], [dbo].[APP_Contacts].[ContactNickName] + '  ' + [dbo].[APP_Contacts].[ContactName] AS [ContactName], [dbo].[APP_Contacts].[ContactGSM1],
	Adder.[UserName] AS [AddedBy], Updater.[UserName] AS [UpdatedBy]
	FROM   [dbo].[APP_Clients] 
	LEFT JOIN [dbo].[APP_Contacts] ON [dbo].[APP_Clients].[ClientContactID] = [dbo].[APP_Contacts].[ID]
	LEFT JOIN [dbo].[Users] AS Adder ON [dbo].[APP_Clients].[ClientAddedBy] = Adder.[UserId]
	LEFT JOIN [dbo].[Users] AS Updater ON [dbo].[APP_Clients].[ClientUpdatedBy] = Updater.[UserId]
	WHERE [dbo].[APP_Clients].[ClientStatus] = '1'

	COMMIT


GO

/*END*/


----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------