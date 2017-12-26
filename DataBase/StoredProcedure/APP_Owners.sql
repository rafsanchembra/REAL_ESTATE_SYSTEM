USE [RealEstateManagementSystemDataBase]

/*--OWNER SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_OwnersSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_OwnersSELECTALL] 
END 
GO
CREATE PROC [dbo].[PROC_APP_OwnersSELECTALL] 
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_Owners].[ID], 
	[dbo].[APP_Owners].[OwnerContactID], 
	[dbo].[APP_Owners].[OwnerstaffName1], 
	[dbo].[APP_Owners].[OwnerstaffName2], 
	[dbo].[APP_Owners].[OwnerstaffName1GSM], 
	[dbo].[APP_Owners].[OwnerstaffName2GSM], 
	[dbo].[APP_Owners].[OwnerDocument], 
	[dbo].[APP_Owners].[OwnerMemo], 
	[dbo].[APP_Owners].[OwnerAddedBy], 
	[dbo].[APP_Owners].[OwnerAddedDate], 
	[dbo].[APP_Owners].[OwnerUpdatedBy], 
	[dbo].[APP_Owners].[OwnerUpdatedDate], 
	[dbo].[APP_Owners].[Ownerstatus], 
	[dbo].[APP_Contacts].[ContactNickName] + '  ' + [dbo].[APP_Contacts].[ContactName] AS [ContactName], 
	[dbo].[APP_Contacts].[ContactGSM1],
	CASE	
		WHEN [dbo].[APP_Owners].[Ownerstatus] = '1' THEN 'Active'
		ELSE 'Freezed'
	END AS [OwnerstatusName],
	Adder.[UserName] AS [AddedBy], Updater.[UserName] AS [UpdatedBy]
	FROM   [dbo].[APP_Owners] 
	LEFT JOIN [dbo].[APP_Contacts] ON [dbo].[APP_Owners].[OwnerContactID] = [dbo].[APP_Contacts].[ID]
	LEFT JOIN [dbo].[Users] AS Adder ON [dbo].[APP_Owners].[OwnerAddedBy] = Adder.[UserId]
	LEFT JOIN [dbo].[Users] AS Updater ON [dbo].[APP_Owners].[OwnerUpdatedBy] = Updater.[UserId]

	COMMIT


GO



/*END*/



/*--OWNER UPDATE ---*/

IF OBJECT_ID('[dbo].[PROC_APP_OwnersUPDATE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_OwnersUPDATE] 
END 
GO

CREATE PROC [dbo].[PROC_APP_OwnersUPDATE] 
    @ID bigint,
    @OwnerContactID bigint,
    @OwnerstaffName1 nvarchar(50),
    @OwnerstaffName2 nvarchar(50),
    @OwnerstaffName1GSM nvarchar(20),
    @OwnerstaffName2GSM nvarchar(20),
    @OwnerDocument nvarchar(120),
    @OwnerMemo nvarchar(MAX),
    @OwnerUpdatedBy uniqueidentifier,
    @OwnerUpdatedDate datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[APP_Owners]
	SET    [OwnerContactID] = @OwnerContactID, [OwnerstaffName1] = @OwnerstaffName1, [OwnerstaffName2] = @OwnerstaffName2, [OwnerstaffName1GSM] = @OwnerstaffName1GSM, [OwnerstaffName2GSM] = @OwnerstaffName2GSM, [OwnerDocument] = @OwnerDocument, [OwnerMemo] = @OwnerMemo, [OwnerUpdatedBy] = @OwnerUpdatedBy, [OwnerUpdatedDate] = @OwnerUpdatedDate
	WHERE  [ID] = @ID
	
	-- Begin Return Select <- do not remove
	SELECT [ID], [OwnerContactID], [OwnerstaffName1], [OwnerstaffName2], [OwnerstaffName1GSM], [OwnerstaffName2GSM], [OwnerDocument], [OwnerMemo], [OwnerAddedBy], [OwnerAddedDate], [OwnerUpdatedBy], [OwnerUpdatedDate], [Ownerstatus]
	FROM   [dbo].[APP_Owners]
	WHERE  [ID] = @ID	
	-- End Return Select <- do not remove

	COMMIT


GO

/*END*/

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------