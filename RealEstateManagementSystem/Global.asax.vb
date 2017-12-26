Imports System.Web.Routing
Imports System.Web.Optimization

Public Class Global_asax
    Inherits HttpApplication

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application is started
        BundleConfig.RegisterBundles(BundleTable.Bundles)
        AuthConfig.RegisterOpenAuth()
        'RouteConfig.RegisterRoutes(RouteTable.Routes)

        RegisterRoutes(RouteTable.Routes)

    End Sub


    Shared Sub RegisterRoutes(ByVal routes As RouteCollection)
        routes.Add("Home", New Route("", New SGRoute("~/Forms/Default.aspx")))
        routes.Add("Login", New Route("Login", New SGRoute("~/Forms/Account/Login.aspx")))
        routes.Add("Test", New Route("Test", New SGRoute("~/Forms/Others/Test.aspx")))

        'Adminstrator Page Routes
        routes.Add("UserRegister", New Route("Administrator/UserRegister", New SGRoute("~/Forms/Account/Register.aspx")))
        routes.Add("UserPermission", New Route("Administrator/UserPermission", New SGRoute("~/Forms/Account/ManageUser.aspx")))
        routes.Add("ChangeUserName", New Route("Administrator/ChangeUserName", New SGRoute("~/Forms/Account/ChangeUserName.aspx")))
        routes.Add("ChangePassword", New Route("Administrator/ChangePassword", New SGRoute("~/Forms/Account/ResetPassword.aspx")))
        routes.Add("LockUser", New Route("Administrator/LockUser", New SGRoute("~/Forms/Account/ActivateFreezeUser.aspx")))
        routes.Add("ChangeSiganture", New Route("Administrator/ChangeSiganture", New SGRoute("~/Forms/Account/ChangeUserSignature.aspx")))

        routes.Add("BankManagement", New Route("Administrator/Bank/BankManagement", New SGRoute("~/Forms/Bank/BankManagement.aspx")))
        routes.Add("AdvanceBankManagement", New Route("Administrator/Bank/Advance/BankManagement", New SGRoute("~/Forms/Bank/BankAdvanceManagement.aspx")))
        routes.Add("BankAccountManagement", New Route("Administrator/Bank/Account/{BankID}", New SGRoute("~/Forms/Bank/BankAccountManagement.aspx")))
        routes.Add("BankAccountAddWindow", New Route("Administrator/Bank/Account/{BankID}/Add", New SGRoute("~/Form/Bank/BankAccountManagementWindow.aspx")))
        routes.Add("BankAdvanceAccountManagement", New Route("Administrator/Bank/Advance/BankAccountManagement/{BankID}", New SGRoute("~/Form/Bank/BankAccountAdvanceManagement.aspx")))
        routes.Add("BankAdvanceAccountOpeningBalance", New Route("Administrator/Bank/Advance/OpeningBalance/{AccID}", New SGRoute("~/Form/Bank/BankAccountOpeningBalanceManagement.aspx")))
        routes.Add("BankAdvanceAccountStatus", New Route("Administrator/Bank/Advance/AccountStatus/{AccID}", New SGRoute("~/Form/Bank/BankAccountUpdateStatusManagement.aspx")))

        routes.Add("BankAccountTranscation", New Route("Administrator/Bank/BankService/BankAccountTranscation", New SGRoute("~/Forms/BankServices/BankAccountTransaction.aspx")))
        routes.Add("TransactionBetweenBankAccount", New Route("Administrator/Bank/BankService/TransactionBetweenBankAccount", New SGRoute("~/Forms/BankServices/TransferCashBetweenBankAccounts.aspx")))



        ' PublicRelation Routes
        routes.Add("ContactManagement", New Route("Administrator/PublicRelation/ContactManagement", New SGRoute("~/Forms/PublicRelation/Client/ClientManagement.aspx")))
        routes.Add("ContactManagementWindow", New Route("Administrator/PublicRelation/ContactWindow", New SGRoute("~/Form/PublicRelation/Contact/ContactManagementWindow.aspx")))
        routes.Add("ClientManagement", New Route("Administrator/PublicRelation/ClientManagement", New SGRoute("~/Forms/PublicRelation/Contact/ContactManagement.aspx")))
        routes.Add("SupplierManagement", New Route("Administrator/PublicRelation/SupplierManagement", New SGRoute("~/Forms/PublicRelation/Supplier/SupplierManagement.aspx")))
        routes.Add("OwnerManagement", New Route("Administrator/PublicRelation/OwnerManagement", New SGRoute("~/Forms/PublicRelation/Owner/OwnerManagement.aspx")))

        ' RealEstate Routes


        routes.Add("FreeLandManagement", New Route("Administrator/RealEstate/FreeLandManagement", New SGRoute("~/Forms/RealEstate/FreeLandManagement/FreeLandManagement.aspx")))
        routes.Add("VillaManagement", New Route("Administrator/RealEstate/VillaManagement", New SGRoute("~/Forms/RealEstate/VillaManagement/VillaManagement.aspx")))
        routes.Add("FlatManagement", New Route("Administrator/RealEstate/FlatManagement", New SGRoute("~/Forms/RealEstate/FlatManagement/FlatManagement.aspx")))
        routes.Add("BuildingManagement", New Route("Administrator/RealEstate/BuildingManagement", New SGRoute("~/Forms/Pages/RealEstate/Building.aspx")))


        'Multi Building Routes
        routes.Add("BuildingAdd", New Route("Administrator/RealEstate/BuildingManagement/Add", New SGRoute("~/Forms/RealEstate/BuildingManagement/Add/BuildingManagement.aspx")))
        routes.Add("BuildingList", New Route("Administrator/RealEstate/BuildingManagement/List", New SGRoute("~/Forms/RealEstate/BuildingManagement/Update/BuildingList.aspx")))
        routes.Add("BuildingUpdate", New Route("Administrator/RealEstate/BuildingManagement/Update/{ID}", New SGRoute("~/Forms/RealEstate/BuildingManagement/Update/BuildingUpdateManagement.aspx")))
        routes.Add("BuildingAttachmentWindow", New Route("Administrator/RealEstate/BuildingManagement/AttachmentWindow/{Status}/{Type}/{BuildingTempID}/{TypeID}/{ID}", New SGRoute("~/Forms/RealEstate/BuildingManagement/Add/BuildingAttachmentWindow.aspx")))
        routes.Add("BuildingUpdateAttachmentWindow", New Route("Administrator/RealEstate/BuildingManagement/Update/AttachmentWindow/{Status}/{Type}/{BuildingID}/{ID}", New SGRoute("~/Forms/RealEstate/BuildingManagement/Update/BuildingUpdateAttachmentWindow.aspx")))

        ' Map Locator Routes
        routes.Add("MapLocator", New Route("MapLocator", New SGRoute("~/Forms/Others/MapLocator.aspx")))
        routes.Add("MapLocatorTest", New Route("MapLocatorTest", New SGRoute("~/Forms/Others/MapLocator_Test.aspx")))

        ' Downlaod Routes
        routes.Add("DownloadAll", New Route("Administrator/RealEstate/Attachment/Download/{Status}/{Type}/{TypeID}", New SGRoute("~/Forms/Others/Download/DownloadAttachment.aspx")))
        routes.Add("DownloadSelected", New Route("Administrator/RealEstate/Attachment/SelectedDownload/{Status}/{Type}/{TypeID}/{SelectedItems}", New SGRoute("~/Forms/Others/Download/DownloadSelectedAttachment.aspx")))
    End Sub
    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires at the beginning of each request
    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires upon attempting to authenticate the use
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when an error occurs
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application ends
    End Sub
End Class