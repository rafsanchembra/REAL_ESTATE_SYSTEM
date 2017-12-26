USE [RealEstateManagementSystemDataBase]

/*---BANK ACCOUNT TRANSCATION BETWEEN ACCOUNTS SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_BankTransactionBetweenAccountsSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BankTransactionBetweenAccountsSELECTALL] 
END 
GO

CREATE PROC [dbo].[PROC_APP_BankTransactionBetweenAccountsSELECTALL]
	@UserID uniqueidentifier
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_BankTransactionBetweenAccounts].[ID],
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionSenderBankID], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionSenderBankAccountID], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionReceiveBankID], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionReceiveBankAccountID], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionAmount], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionDocumentType], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionDocumentDate], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionDocumentNumber], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionAttachment], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionMemo], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionStatus], 
	CASE
		WHEN [dbo].[APP_BankTransactionBetweenAccounts].[TransactionStatus] = 1 THEN 'Active'
		ELSE 'Freezed'
	END AS [TransactionStatusName],
	SenderBank.[BankEnglishName] AS [SenderBank],
	SenderBankAccount.[BankAccountEnglishName] AS [SenderAccount],
	ReceiveBank.[BankEnglishName] AS [RecieveBank], 
	ReceiveBankAccount.[BankAccountEnglishName] AS [RecieveAccount],
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionAddedBy], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionAddedDate], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionUpdatedBy], 
	[dbo].[APP_BankTransactionBetweenAccounts].[TransactionUpdatedDate] 
	FROM   [dbo].[APP_BankTransactionBetweenAccounts]
	LEFT JOIN [dbo].[APP_Banks] AS SenderBank ON SenderBank.[ID] = [dbo].[APP_BankTransactionBetweenAccounts].[TransactionSenderBankID]
	LEFT JOIN [dbo].[APP_BankAccounts] AS SenderBankAccount ON SenderBankAccount.[ID] = [dbo].[APP_BankTransactionBetweenAccounts].[TransactionSenderBankAccountID]
	LEFT JOIN [dbo].[APP_Banks] AS ReceiveBank ON ReceiveBank.[ID] = [dbo].[APP_BankTransactionBetweenAccounts].[TransactionReceiveBankID]
	LEFT JOIN [dbo].[APP_BankAccounts] AS ReceiveBankAccount ON ReceiveBankAccount.[ID] = [dbo].[APP_BankTransactionBetweenAccounts].[TransactionReceiveBankAccountID]
	WHERE [dbo].[APP_BankTransactionBetweenAccounts].[TransactionAddedBy] = @UserID

	COMMIT


GO


/*---END---*/
/*---BANK ACCOUNT TRANSCATION BETWEEN ACCOUNTS UPDATE---*/

IF OBJECT_ID('[dbo].[PROC_APP_BankTransactionBetweenAccountsUPDATE]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_BankTransactionBetweenAccountsUPDATE] 
END 
GO


CREATE PROC [dbo].[PROC_APP_BankTransactionBetweenAccountsUPDATE] 
    @ID bigint,
    @TransactionSenderBankID bigint,
    @TransactionSenderBankAccountID bigint,
    @TransactionReceiveBankID bigint,
    @TransactionReceiveBankAccountID bigint,
    @TransactionAmount money,
    @TransactionDocumentType nvarchar(10),
    @TransactionDocumentDate date,
    @TransactionDocumentNumber nvarchar(30),
    @TransactionAttachment nvarchar(120),
    @TransactionMemo nvarchar(MAX),
    @TransactionStatus bit,
    @TransactionUpdatedBy uniqueidentifier,
    @TransactionUpdatedDate datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[APP_BankTransactionBetweenAccounts]
	SET    [TransactionSenderBankID] = @TransactionSenderBankID, 
	[TransactionSenderBankAccountID] = @TransactionSenderBankAccountID, 
	[TransactionReceiveBankID] = @TransactionReceiveBankID,
	[TransactionReceiveBankAccountID] = @TransactionReceiveBankAccountID, 
	[TransactionAmount] = @TransactionAmount, 
	[TransactionDocumentType] = @TransactionDocumentType, 
	[TransactionDocumentDate] = @TransactionDocumentDate, 
	[TransactionDocumentNumber] = @TransactionDocumentNumber, 
	[TransactionAttachment] = @TransactionAttachment, 
	[TransactionMemo] = @TransactionMemo, 
	[TransactionStatus] = @TransactionStatus, 
	[TransactionUpdatedBy] = @TransactionUpdatedBy, 
	[TransactionUpdatedDate] = @TransactionUpdatedDate
	WHERE  [dbo].[APP_BankTransactionBetweenAccounts].[ID] = @ID
	
	COMMIT


GO
/*---END---*/