USE [RealEstateManagementSystemDataBase]


/*---BANK ACCOUNT ACTIVE SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_BankAccountsActiveSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BankAccountsActiveSELECTALL] 
END 
GO
CREATE PROC [dbo].[PROC_APP_BankAccountsActiveSELECTALL] 
	@BankID BIGINT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_BankAccounts].[ID], 
	[dbo].[APP_BankAccounts].[BankID], 
	[dbo].[APP_BankAccounts].[BankAccountNumber], 
	[dbo].[APP_BankAccounts].[BankAccountArabicName], 
	[dbo].[APP_BankAccounts].[BankAccountEnglishName], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalance], 
	[dbo].[APP_BankAccounts].[BankAccountTotalBalance], 
	[dbo].[APP_BankAccounts].[BankAccountMemo], 
	[dbo].[APP_BankAccounts].[BankAccountStatus], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceMemo], 
	[dbo].[APP_BankAccounts].[BankAccountAddedBy], 
	[dbo].[APP_BankAccounts].[BankAccountAddedDate], 
	[dbo].[APP_BankAccounts].[BankAccountUpdatedBy], 
	[dbo].[APP_BankAccounts].[BankAccountUpdatedDate], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceAddedBy], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceAddedDate], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceUpdatedBy], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceUpdatedDate],
	CASE
		WHEN [dbo].[APP_BankAccounts].[BankAccountStatus] = 1 THEN 'Active'
		ELSE 'Freezed'
	END AS [BankAccountStatusName]
	FROM   [dbo].[APP_BankAccounts] 
	WHERE [dbo].[APP_BankAccounts].[BankID] = @BankID

	COMMIT

GO

/*---END---*/

/*---BANK ACCOUNT RECIVE ATCIVESELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_BankAccountsRecieveActiveSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BankAccountsRecieveActiveSELECTALL] 
END 
GO
CREATE PROC [dbo].[PROC_APP_BankAccountsRecieveActiveSELECTALL] 
	@BankID BIGINT,
	@BankAccountID BIGINT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_BankAccounts].[ID], 
	[dbo].[APP_BankAccounts].[BankID], 
	[dbo].[APP_BankAccounts].[BankAccountNumber], 
	[dbo].[APP_BankAccounts].[BankAccountArabicName], 
	[dbo].[APP_BankAccounts].[BankAccountEnglishName], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalance], 
	[dbo].[APP_BankAccounts].[BankAccountTotalBalance], 
	[dbo].[APP_BankAccounts].[BankAccountMemo], 
	[dbo].[APP_BankAccounts].[BankAccountStatus], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceMemo], 
	[dbo].[APP_BankAccounts].[BankAccountAddedBy], 
	[dbo].[APP_BankAccounts].[BankAccountAddedDate], 
	[dbo].[APP_BankAccounts].[BankAccountUpdatedBy], 
	[dbo].[APP_BankAccounts].[BankAccountUpdatedDate], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceAddedBy], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceAddedDate], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceUpdatedBy], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceUpdatedDate],
	CASE
		WHEN [dbo].[APP_BankAccounts].[BankAccountStatus] = 1 THEN 'Active'
		ELSE 'Freezed'
	END AS [BankAccountStatusName]
	FROM   [dbo].[APP_BankAccounts] 
	WHERE [dbo].[APP_BankAccounts].[BankID] = @BankID
	AND [dbo].[APP_BankAccounts].[ID] <> @BankAccountID

	COMMIT
GO
/*---END---*/


/*---BANK ACCOUNT SELECT ALL---*/


IF OBJECT_ID('[dbo].[PROC_APP_BankAccountsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BankAccountsSELECTALL] 
END 
GO
CREATE PROC [dbo].[PROC_APP_BankAccountsSELECTALL] 
	@BankID BIGINT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_BankAccounts].[ID], 
	[dbo].[APP_BankAccounts].[BankID],
    [dbo].[APP_BankAccounts].[BankAccountNumber], 
	[dbo].[APP_BankAccounts].[BankAccountArabicName],
	[dbo].[APP_BankAccounts].[BankAccountEnglishName], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalance], 
	[dbo].[APP_BankAccounts].[BankAccountTotalBalance], 
	[dbo].[APP_BankAccounts].[BankAccountMemo], 
	[dbo].[APP_BankAccounts].[BankAccountStatus], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceMemo], 
	[dbo].[APP_BankAccounts].[BankAccountAddedBy], 
	[dbo].[APP_BankAccounts].[BankAccountAddedDate], 
	[dbo].[APP_BankAccounts].[BankAccountUpdatedBy],
	[dbo].[APP_BankAccounts].[BankAccountUpdatedDate], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceAddedBy], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceAddedDate], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceUpdatedBy], 
	[dbo].[APP_BankAccounts].[BankAccountOpeningBalanceUpdatedDate],
	CASE
		WHEN [dbo].[APP_BankAccounts].[BankAccountStatus] = 1 THEN 'Active'
		ELSE 'Freezed'
	END AS [BankAccountStatusName]
	FROM   [dbo].[APP_BankAccounts] 
	WHERE [dbo].[APP_BankAccounts].[BankID] = @BankID
	COMMIT


GO
/*---END---*/

/*---BANK ACCOUNT SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_BankAccountsUPDATE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BankAccountsUPDATE] 
END 
GO

CREATE PROC [dbo].[PROC_APP_BankAccountsUPDATE] 
    @ID bigint,
    @BankAccountNumber nvarchar(40),
    @BankAccountArabicName nvarchar(30),
    @BankAccountEnglishName nvarchar(30),
    @BankAccountMemo nvarchar(MAX),
    @BankAccountUpdatedBy uniqueidentifier,
    @BankAccountUpdatedDate datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[APP_BankAccounts]
	SET    [BankAccountNumber] = @BankAccountNumber, 
	[BankAccountArabicName] = @BankAccountArabicName, 
	[BankAccountEnglishName] = @BankAccountEnglishName, 
	[BankAccountMemo] = @BankAccountMemo, 
	[BankAccountUpdatedBy] = @BankAccountUpdatedBy, 
	[BankAccountUpdatedDate] = @BankAccountUpdatedDate
	WHERE  [ID] = @ID

	COMMIT


GO
/*---END---*/
