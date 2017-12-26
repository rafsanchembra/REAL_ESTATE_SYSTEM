USE [RealEstateManagementSystemDataBase]


/*--VILLAGE SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_VillageSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_VillageSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_VillageSELECTALL] 
	-- Add the parameters for the stored procedure here
		@ID BIGINT
AS
		SET NOCOUNT ON
		SET XACT_ABORT ON  

		BEGIN TRAN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [dbo].[APP_Villages].ID ,
	[dbo].[APP_Villages] .CityId ,
	[dbo].[APP_Villages].VillageName 
	FROM [dbo].[APP_Villages] 
	
	WHERE [dbo].[APP_Villages].CityId = @ID 
	COMMIT


GO


/*END*/
---------------------------------------