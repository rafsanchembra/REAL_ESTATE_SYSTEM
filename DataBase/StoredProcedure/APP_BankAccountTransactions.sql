USE [RealEstateManagementSystemDataBase]

/*---BANK ACCOUNT TRANSCATION SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_BankAccountTransactionsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BankAccountTransactionsSELECTALL] 
END 
GO

CREATE PROC [dbo].[PROC_APP_BankAccountTransactionsSELECTALL] 
	@UserID uniqueidentifier
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_BankAccountTransactions].[ID], 
	[dbo].[APP_BankAccountTransactions].[TransactionBankID], [dbo].[APP_BankAccountTransactions].[TransactionBankAccountID], 
	[dbo].[APP_BankAccountTransactions].[TransactionDocumentType], [dbo].[APP_BankAccountTransactions].[TransactionDocumentNumber], 
	[dbo].[APP_BankAccountTransactions].[TransactionAmount], [dbo].[APP_BankAccountTransactions].[TransactionDocumentDate],
	[dbo].[APP_BankAccountTransactions].[TransactionAttachment], [dbo].[APP_BankAccountTransactions].[TransactionMemo], 
	[dbo].[APP_BankAccountTransactions].[TransactionStatus], [dbo].[APP_BankAccountTransactions].[TransactionType],
	CASE	
		WHEN  [dbo].[APP_BankAccountTransactions].[TransactionStatus] = 1 THEN 'Active'
		ELSE 'Freezed'
	END AS [TransactionStatusName],
	[dbo].[APP_BankAccountTransactions].[TransactionAmount] + [dbo].[APP_UserProfiles].[UserTreasurerSalesAccount] AS [TreasurerSalesAccount], 
	CASE	
		WHEN [dbo].[APP_UserProfiles].[UserTreasurerSalesAccount] < 0 THEN [dbo].[APP_BankAccountTransactions].[TransactionAmount]
		ELSE ([dbo].[APP_BankAccountTransactions].[TransactionAmount] + [dbo].[APP_UserProfiles].[UserTreasurerSalesAccount])
	END AS [MaxTreasurerSalesAccount],
	[dbo].[APP_Banks].[BankEnglishName], [dbo].[APP_BankAccounts].[BankAccountEnglishName],
	[dbo].[APP_BankAccountTransactions].[TransactionAddedBy], [dbo].[APP_BankAccountTransactions].[TransactionAddedDate], 
	[dbo].[APP_BankAccountTransactions].[TransactionUpdatedBy], [dbo].[APP_BankAccountTransactions].[TransactionUpdatedDate]
	FROM   [dbo].[APP_BankAccountTransactions]
	LEFT JOIN [dbo].[APP_UserProfiles] ON [dbo].[APP_UserProfiles].[UserId] = @UserID
	LEFT JOIN [dbo].[APP_Banks] ON [dbo].[APP_Banks].[ID] = [dbo].[APP_BankAccountTransactions].[TransactionBankID]
	LEFT JOIN [dbo].[APP_BankAccounts] ON [dbo].[APP_BankAccounts].[ID] = [dbo].[APP_BankAccountTransactions].[TransactionBankAccountID]
	WHERE [dbo].[APP_BankAccountTransactions].[TransactionAddedBy] = @UserID

	COMMIT


GO

/*---END---*/
/*---BANK ACCOUNT TRANSACTIONS UPDATE---*/

IF OBJECT_ID('[dbo].[PROC_APP_BankAccountTransactionsUPDATE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BankAccountTransactionsUPDATE] 
END 
GO


CREATE PROC [dbo].[PROC_APP_BankAccountTransactionsUPDATE] 
    @ID bigint,
    @TransactionBankID bigint,
    @TransactionBankAccountID bigint,
    @TransactionDocumentType nvarchar(30),
    @TransactionDocumentNumber nvarchar(30),
    @TransactionAmount money,
	@TransactionType nvarchar(10),
    @TransactionDocumentDate date,
    @TransactionAttachment nvarchar(MAX),
    @TransactionMemo nvarchar(MAX),
    @TransactionStatus bit,
    @TransactionUpdatedBy uniqueidentifier,
    @TransactionUpdatedDate datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[APP_BankAccountTransactions]
	SET    [TransactionBankID] = @TransactionBankID, 
	[TransactionBankAccountID] = @TransactionBankAccountID, 
	[TransactionDocumentType] = @TransactionDocumentType, 
	[TransactionDocumentNumber] = @TransactionDocumentNumber, 
	[TransactionAmount] = @TransactionAmount, 
	[TransactionType] = @TransactionType,
	[TransactionDocumentDate] = @TransactionDocumentDate, 
	[TransactionAttachment] = @TransactionAttachment, 
	[TransactionMemo] = @TransactionMemo, 
	[TransactionStatus] = @TransactionStatus, 
	[TransactionUpdatedBy] = @TransactionUpdatedBy, 
	[TransactionUpdatedDate] = @TransactionUpdatedDate
	WHERE  [dbo].[APP_BankAccountTransactions].[ID] = @ID
	

	COMMIT


GO
/*---END---*/