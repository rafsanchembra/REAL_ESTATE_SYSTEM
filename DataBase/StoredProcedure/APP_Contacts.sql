USE [RealEstateManagementSystemDataBase]

/*--CONTACT SELECT ALL---*/
IF OBJECT_ID('[dbo].[PROC_APP_ContactSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_ContactSELECTALL]
END 
GO

CREATE PROC [dbo].[PROC_APP_ContactSELECTALL] 
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT  [dbo].[APP_Contacts].[ID], 
	[dbo].[APP_Contacts].[ContactName], 
	[dbo].[APP_Contacts].[ContactNickName], 
	[dbo].[APP_Contacts].[ContactIdentityNumber], 
	[dbo].[APP_Contacts].[ContactIdentityAttachment], 
	[dbo].[APP_Contacts].[ContactGSM1CountryCode], 
	[dbo].[APP_Contacts].[ContactGSM1],
	CASE
		WHEN [dbo].[APP_Contacts].[ContactNickName] IS NULL THEN [dbo].[APP_Contacts].[ContactName]
		ELSE [dbo].[APP_Contacts].[ContactNickName] + ' ' + [dbo].[APP_Contacts].[ContactName]
	END AS [ContactFullName],
	[dbo].[APP_Contacts].[ContactGSM2CountryCode], 
	[dbo].[APP_Contacts].[ContactGSM2], 
	[dbo].[APP_Contacts].[ContactGSM1CountryCode] + [dbo].[APP_Contacts].[ContactGSM1] AS [CompleteContactGSM1],
	[dbo].[APP_Contacts].[ContactGSM2CountryCode] + [dbo].[APP_Contacts].[ContactGSM2] AS [CompleteContactGSM2],
	[dbo].[APP_Contacts].[ContactCommercialRegisterNumber], 
	[dbo].[APP_Contacts].[ContactCommercialRegisterAttachment], 
	[ContactEmail], [ContactOfficePhone], [ContactOfficeFax], 
	[dbo].[APP_Contacts].[ContactWebsite], 
	[dbo].[APP_Contacts].[ContactPOBox], 
	[dbo].[APP_Contacts].[ContactPostalCode], 
	[dbo].[APP_Contacts].[ContactLatitudeCoordinates], 
	[dbo].[APP_Contacts].[ContactLongitudeCoordinates],
	[dbo].[APP_Contacts]. [ContactURLMap], 
	[dbo].[APP_Contacts].[ContactMemo], 
	[dbo].[APP_Contacts].[ContactAddedBy], 
	[dbo].[APP_Contacts].[ContactAddedDate], 
	[dbo].[APP_Contacts].[ContactUpdatedBy], 
	[dbo].[APP_Contacts].[ContactUpdatedDate],
	Adder.[UserName] AS [AddedBy],
	Updater.[UserName] AS [UpdatedBy]
	FROM   [dbo].[APP_Contacts] 
	LEFT JOIN [dbo].[Users] AS Adder ON [dbo].[APP_Contacts].[ContactAddedBy] = Adder.[UserId]
	LEFT JOIN [dbo].[Users] AS Updater ON [dbo].[APP_Contacts].[ContactUpdatedBy] = Updater.[UserId]
	ORDER BY [ContactName]

	COMMIT


GO





/*END*/

/*--CONTACT SELECT---*/
IF OBJECT_ID('[dbo].[PROC_APP_ContactSELECT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_ContactSELECT]
END 
GO
CREATE PROC [dbo].[PROC_APP_ContactSELECT] 
    @ID BIGINT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_Contacts].[ID], 
	[dbo].[APP_Contacts].[ContactName], 
	[dbo].[APP_Contacts].[ContactNickName], [dbo].[APP_Contacts].[ContactIdentityNumber], 
	[dbo].[APP_Contacts].[ContactIdentityAttachment], [dbo].[APP_Contacts].[ContactGSM1CountryCode], 
	[dbo].[APP_Contacts].[ContactGSM1], [dbo].[APP_Contacts].[ContactGSM2CountryCode], 
	[dbo].[APP_Contacts].[ContactGSM2], [dbo].[APP_Contacts].[ContactCommercialRegisterNumber], 
	[dbo].[APP_Contacts].[ContactCommercialRegisterAttachment], [dbo].[APP_Contacts].[ContactEmail], 
	[dbo].[APP_Contacts].[ContactOfficePhone], [dbo].[APP_Contacts].[ContactOfficeFax], 
	[dbo].[APP_Contacts].[ContactWebsite],[dbo].[APP_Contacts].[ContactPOBox], 
	[dbo].[APP_Contacts].[ContactPostalCode], [dbo].[APP_Contacts].[ContactLatitudeCoordinates], 
	[dbo].[APP_Contacts].[ContactLongitudeCoordinates], [dbo].[APP_Contacts].[ContactURLMap], 
	[dbo].[APP_Contacts].[ContactMemo], [dbo].[APP_Contacts].[ContactAddedBy], 
	[dbo].[APP_Contacts].[ContactAddedDate], [dbo].[APP_Contacts].[ContactUpdatedBy], 
	[dbo].[APP_Contacts].[ContactUpdatedDate] 
	FROM   [dbo].[APP_Contacts] 
	WHERE  [dbo].[APP_Contacts].[ID] = @ID 

	COMMIT


GO


/*END*/


/*---CONTACT UPDATE---*/

IF OBJECT_ID('[dbo].[PROC_APP_ContactUPDATE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_ContactUPDATE]
END 
GO
CREATE PROC [dbo].[PROC_APP_ContactUPDATE] 
    @ID bigint,
    @ContactName nvarchar(50),
    @ContactNickName nvarchar(30),
    @ContactIdentityNumber nvarchar(20),
    @ContactIdentityAttachment nvarchar(120),
    @ContactGSM1CountryCode nvarchar(10),
    @ContactGSM1 nvarchar(20),
    @ContactGSM2CountryCode nvarchar(10),
    @ContactGSM2 nvarchar(20),
    @ContactCommercialRegisterNumber nvarchar(20),
    @ContactCommercialRegisterAttachment nvarchar(120),
    @ContactEmail nvarchar(50),
    @ContactOfficePhone nvarchar(20),
    @ContactOfficeFax nvarchar(20),
    @ContactWebsite nvarchar(40),
    @ContactPOBox nvarchar(15),
    @ContactPostalCode nvarchar(15),
    @ContactLatitudeCoordinates nvarchar(15),
    @ContactLongitudeCoordinates nvarchar(15),
    @ContactURLMap nvarchar(60),
    @ContactMemo nvarchar(MAX),
    @ContactUpdatedBy uniqueidentifier,
    @ContactUpdatedDate datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[APP_Contacts]
	SET    [ContactName] = @ContactName, [ContactNickName] = @ContactNickName, [ContactIdentityNumber] = @ContactIdentityNumber, [ContactIdentityAttachment] = @ContactIdentityAttachment, [ContactGSM1CountryCode] = @ContactGSM1CountryCode, [ContactGSM1] = @ContactGSM1, [ContactGSM2CountryCode] = @ContactGSM2CountryCode, [ContactGSM2] = @ContactGSM2, [ContactCommercialRegisterNumber] = @ContactCommercialRegisterNumber, [ContactCommercialRegisterAttachment] = @ContactCommercialRegisterAttachment, [ContactEmail] = @ContactEmail, [ContactOfficePhone] = @ContactOfficePhone, [ContactOfficeFax] = @ContactOfficeFax, [ContactWebsite] = @ContactWebsite, [ContactPOBox] = @ContactPOBox, [ContactPostalCode] = @ContactPostalCode, [ContactLatitudeCoordinates] = @ContactLatitudeCoordinates, [ContactLongitudeCoordinates] = @ContactLongitudeCoordinates, [ContactURLMap] = @ContactURLMap, [ContactMemo] = @ContactMemo, [ContactUpdatedBy] = @ContactUpdatedBy, [ContactUpdatedDate] = @ContactUpdatedDate
	WHERE  [ID] = @ID
	
	-- Begin Return Select <- do not remove
	SELECT [ID], [ContactName], [ContactNickName], [ContactIdentityNumber], [ContactIdentityAttachment], [ContactGSM1], [ContactGSM2], [ContactCommercialRegisterNumber], [ContactCommercialRegisterAttachment], [ContactEmail], [ContactOfficePhone], [ContactOfficeFax], [ContactWebsite], [ContactPOBox], [ContactPostalCode], [ContactLatitudeCoordinates], [ContactLongitudeCoordinates], [ContactURLMap], [ContactMemo], [ContactAddedBy], [ContactAddedDate], [ContactUpdatedBy], [ContactUpdatedDate]
	FROM   [dbo].[APP_Contacts]
	WHERE  [ID] = @ID	
	-- End Return Select <- do not remove

	COMMIT


GO


/*END*/


/*---CLIENT INSERT ---*/
IF OBJECT_ID('[dbo].[PROC_APP_ContactINSERT]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_ContactINSERT]
END 
GO


CREATE PROC [dbo].[PROC_APP_ContactINSERT] 
    @ContactName nvarchar(50),
    @ContactNickName nvarchar(30),
    @ContactIdentityNumber nvarchar(20),
    @ContactIdentityAttachment nvarchar(120),
    @ContactGSM1CountryCode nvarchar(10),
    @ContactGSM1 nvarchar(20),
    @ContactGSM2CountryCode nvarchar(10),
    @ContactGSM2 nvarchar(20),
    @ContactCommercialRegisterNumber nvarchar(20),
    @ContactCommercialRegisterAttachment nvarchar(120),
    @ContactEmail nvarchar(50),
    @ContactOfficePhone nvarchar(20),
    @ContactOfficeFax nvarchar(20),
    @ContactWebsite nvarchar(40),
    @ContactPOBox nvarchar(15),
    @ContactPostalCode nvarchar(15),
    @ContactLatitudeCoordinates nvarchar(15),
    @ContactLongitudeCoordinates nvarchar(15),
    @ContactURLMap nvarchar(60),
    @ContactMemo nvarchar(MAX),
    @ContactAddedBy uniqueidentifier
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[APP_Contacts] ([ContactName], [ContactNickName], [ContactIdentityNumber], [ContactIdentityAttachment], [ContactGSM1CountryCode], [ContactGSM1], [ContactGSM2CountryCode], [ContactGSM2], [ContactCommercialRegisterNumber], [ContactCommercialRegisterAttachment], [ContactEmail], [ContactOfficePhone], [ContactOfficeFax], [ContactWebsite], [ContactPOBox], [ContactPostalCode], [ContactLatitudeCoordinates], [ContactLongitudeCoordinates], [ContactURLMap], [ContactMemo], [ContactAddedBy])
	SELECT @ContactName, @ContactNickName, @ContactIdentityNumber, @ContactIdentityAttachment, @ContactGSM1CountryCode, @ContactGSM1, @ContactGSM2CountryCode, @ContactGSM2, @ContactCommercialRegisterNumber, @ContactCommercialRegisterAttachment, @ContactEmail, @ContactOfficePhone, @ContactOfficeFax, @ContactWebsite, @ContactPOBox, @ContactPostalCode, @ContactLatitudeCoordinates, @ContactLongitudeCoordinates, @ContactURLMap, @ContactMemo, @ContactAddedBy
	
	-- Begin Return Select <- do not remove
	SELECT [ID], [ContactName], [ContactNickName], [ContactIdentityNumber], [ContactIdentityAttachment], [ContactGSM1], [ContactGSM2], [ContactCommercialRegisterNumber], [ContactCommercialRegisterAttachment], [ContactEmail], [ContactOfficePhone], [ContactOfficeFax], [ContactWebsite], [ContactPOBox], [ContactPostalCode], [ContactLatitudeCoordinates], [ContactLongitudeCoordinates], [ContactURLMap], [ContactMemo], [ContactAddedBy], [ContactAddedDate], [ContactUpdatedBy], [ContactUpdatedDate]
	FROM   [dbo].[APP_Contacts]
	WHERE  [ID] = SCOPE_IDENTITY()
	-- End Return Select <- do not remove
               
	COMMIT


GO

/*END*/





----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------