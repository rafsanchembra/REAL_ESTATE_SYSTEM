USE [RealEstateManagementSystemDataBase]  
GO
/****** Object:  StoredProcedure [dbo].[PROC_APP_CountriesSELECTALL]    Script Date: 10/10/2016 3:11:32 PM ******/
IF OBJECT_ID('[dbo].[PROC_APP_CountriesSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_CountriesSELECTALL]  
END 
GO
CREATE PROC [dbo].[PROC_APP_CountriesSELECTALL]  
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT [dbo].[APP_Countries].[ID], 
	[dbo].[APP_Countries].[ISO], 
	[dbo].[APP_Countries].[Name], 
	[dbo].[APP_Countries].[PhoneCode], 
	[dbo].[APP_Countries].[Flag],
	CONVERT(NVARCHAR(50),[dbo].[APP_Countries].[PhoneCode]) + '-' + [dbo].[APP_Countries].[ISO]  + '-' + [dbo].[APP_Countries].[Name] AS [CountryCode] ,
	CONVERT(NVARCHAR(50),[dbo].[APP_Countries].[CurrencyCode]) + '-' + [dbo].[APP_Countries].[Name] AS [CurrencyCodeName] ,
	[dbo].[APP_Countries].[CurrencyCode]
	FROM   [dbo].[APP_Countries] 
	WHERE [dbo].[APP_Countries].CurrencyCode <> 'NULL'

	COMMIT
