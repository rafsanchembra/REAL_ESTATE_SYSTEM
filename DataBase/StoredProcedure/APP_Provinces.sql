USE [RealEstateManagementSystemDataBase]

/*--PROVINCES SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_ProvincesSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_ProvincesSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_ProvincesSELECTALL]
	-- Add the parameters for the stored procedure here
	
AS
	SET NOCOUNT ON;
	SET XACT_ABORT ON
	
	BEGIN TRAN
	
	SELECT [dbo].[APP_Provinces].ID ,
	[dbo].[APP_Provinces].ProvinceName
	
	FROM [dbo].[APP_Provinces]
	
	COMMIT 

GO


/*END*/


------------------------------------------------------------------