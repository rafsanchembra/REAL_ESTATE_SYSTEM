USE [RealEstateManagementSystemDataBase]

/*--CITIES SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_CitySELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_CitySELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_CitySELECTALL] 
	-- Add the parameters for the stored procedure here
	@ID BIGINT
AS
	SET NOCOUNT ON
	SET XACT_ABORT ON  

	BEGIN TRAN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	

    -- Insert statements for procedure here
	SELECT [dbo].[APP_Cities].ID ,
	[dbo].[APP_Cities].ProvinceId ,
	[dbo].[APP_Cities].CityName 
	FROM [dbo].[APP_Cities] 
	WHERE [dbo].[APP_Cities].ProvinceId = @ID 
	
	COMMIT
GO

/*END*/

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------