USE [RealEstateManagementSystemDataBase]

/*--FLAT SELECT ALL---*/

IF OBJECT_ID('[dbo].[PROC_APP_FlatSELECTALL]') IS NOT NULL
BEGIN 
    DROP PROC [dbo].[PROC_APP_FlatSELECTALL] 
END 
GO
CREATE PROCEDURE [dbo].[PROC_APP_FlatSELECTALL] 
	-- Add the parameters for the stored procedure here
	
AS
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


    -- Insert statements for procedure here
	SELECT [dbo].[APP_Flats].ID ,
	[dbo].[APP_Flats].FlatName ,
	[dbo].[APP_Flats].FlatCompanyName ,
	[dbo].[APP_Flats].FlatOfficialName ,
	[dbo].[APP_Flats].FlatRentingPrice ,
	[dbo].[APP_Flats].FlatProvince ,
	[dbo].[APP_Flats].FlatCity ,
	[dbo].[APP_Flats].FlatVillage ,
	[dbo].[APP_Flats].FlatPlace ,
	[dbo].[APP_Flats].FlatMemo ,
	[dbo].[APP_Flats].FlatRoomNumber ,
	[dbo].[APP_Flats].FlatBathroomNumber ,
	[dbo].[APP_Flats].FlatBathroomType ,
	[dbo].[APP_Flats].FlatAddedBy ,
	[dbo].[APP_Flats].FlatAddedDate ,
	[dbo].[APP_Flats].FlatUpdatedBy ,
	[dbo].[APP_Flats].FlatUpdatedDate ,
	[dbo].[APP_Provinces].[ProvinceName],
	[dbo].[APP_Cities].[CityName] ,
	[dbo].[APP_Villages].[VillageName],
	Adder.[UserName] AS [AddedBy],
	Updater.[UserName] AS [UpdatedBy]
	FROM [dbo].[APP_Flats] 
	LEFT JOIN [dbo].[Users] AS Adder ON [dbo].[APP_Flats].[FlatAddedBy] = Adder.[UserId]
	LEFT JOIN [dbo].[Users] AS Updater ON [dbo].[APP_Flats].[FlatUpdatedBy] = Updater.[UserId]
	LEFT JOIN [dbo].[APP_Provinces] ON [dbo].[APP_Provinces].[ID] = [dbo].[APP_Flats].[FlatProvince]
	LEFT JOIN [dbo].[APP_Cities] ON [dbo].[APP_Cities].[ID] = [dbo].[APP_Flats].[FlatCity]  
	LEFT JOIN [dbo].[APP_Villages] ON [dbo].[APP_Villages].[ID] = [dbo].[APP_Flats].[FlatVillage]
	ORDER BY [FlatName]
	
	COMMIT 

GO


/*END*/

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------