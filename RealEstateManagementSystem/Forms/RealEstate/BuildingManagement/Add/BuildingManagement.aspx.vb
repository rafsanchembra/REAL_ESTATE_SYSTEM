Imports Telerik.Web.UI
Imports System.IO

Public Class BuildingManagement
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SessionCreater()
            loadSiteMap()
            LoadData()
        End If

    End Sub

    Private Sub loadSiteMap()
        Dim _radSiteMap As RadSiteMap = CType(Master.FindControl("BreadCrumbSiteMapMasterPage"), RadSiteMap)

        Dim _root1 As New RadSiteMapNode
        _root1.Text = "Home"
        _root1.Value = "1"
        _root1.NavigateUrl = "~/"
        _radSiteMap.Nodes.Add(_root1)


        Dim _root2 As New RadSiteMapNode
        _root2.Text = "Multi Floor Building"
        _root2.Value = "2"
        _root2.Enabled = False
        _radSiteMap.Nodes.Add(_root2)
    End Sub
    Private Sub SessionCreater()
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)
        Session("UserID") = _currentUserID
    End Sub
    Private Sub ClearData()
        BuildingNameRadTextBox.Text = ""
        BuildingOfficalNameRadTextBox.Text = ""
        BuildingOwnerComboBox.ClearSelection()
        BuildingOwnerComboBox.Items.Clear()
        BuildingOwnerComboBox.DataBind()
        BuildingCurrencyTypeComboBox.ClearSelection()
        BuildingCurrencyTypeComboBox.Items.Clear()
        BuildingCurrencyTypeComboBox.DataBind()
        BuildingRentPriceRadTextBox.Value = Nothing
        BuildingContactStaffNameTextBox.Text = ""

        BuildingContactStaffGSMContryCodeCombobox.ClearSelection()
        BuildingContactStaffGSMContryCodeCombobox.Items.Clear()
        BuildingContactStaffGSMContryCodeCombobox.DataBind()

        BuildingContactStaffGSMTextBox.Text = ""
        BuildingAddressTextBox.Text = ""
        BuildingGPSTextBox.Text = ""
        BuildingMapUrlTextBox.Text = ""
        BuildingFloorNoRadTextBox.Text = ""
        BuildingFlatNoRadTextBox.Text = 0
        BuildingShopNoRadTextBox.Text = 0
        BuildingOfficeNoTextBox.Text = 0
        BuildingMemoRadTextBox.Text = ""

        BuildingCurrencyTypeComboBox.SelectedValue = "OMR"
        BuildingRentPriceRadTextBox.NumberFormat.PositivePattern = " +n OMR"
        BuildingRentPriceRadTextBox.NumberFormat.NegativePattern = " -n OMR"
        ViewState("BuildingTempID") = Nothing

    End Sub

    Private Sub LoadData()
        Dim _mfBuildingInfo = (From sd In DB.APP_MultiFloorBuildingTemps Where sd.UserID = Session("UserID") Select sd).SingleOrDefault
        If Not IsNothing(_mfBuildingInfo) Then
            BuildingNameRadTextBox.Text = _mfBuildingInfo.MFBuildingName
            BuildingOfficalNameRadTextBox.Text = _mfBuildingInfo.MFBuildingName
            BuildingOwnerComboBox.SelectedValue = _mfBuildingInfo.MFBuildingOwnerID
            BuildingCurrencyTypeComboBox.SelectedValue = _mfBuildingInfo.MFCurrencyTypeCountryCodeID
            BuildingRentPriceRadTextBox.Value = _mfBuildingInfo.MFBuildingRentingPrice
            BuildingContactStaffNameTextBox.Text = _mfBuildingInfo.MFBuildingContactName
            If Not IsNothing(_mfBuildingInfo.MFBuildingContactGSMCountryCodeID) Then
                BuildingContactStaffGSMContryCodeCombobox.SelectedValue = _mfBuildingInfo.MFBuildingContactGSMCountryCodeID
            End If
            BuildingContactStaffGSMTextBox.Text = _mfBuildingInfo.MFBuildingContactGSM
            BuildingAddressTextBox.Text = _mfBuildingInfo.MFBuildingAddress
            BuildingGPSTextBox.Text = _mfBuildingInfo.MFBuildingGPS
            BuildingMapUrlTextBox.Text = _mfBuildingInfo.MFBuildingMapUrl
            BuildingFloorNoRadTextBox.Text = _mfBuildingInfo.MFBuildingFloorCount
            BuildingFlatNoRadTextBox.Text = _mfBuildingInfo.MFBuildingFlatCount
            BuildingShopNoRadTextBox.Text = _mfBuildingInfo.MFBuildingShopCount
            BuildingOfficeNoTextBox.Text = _mfBuildingInfo.MFBuildingOfficeCount
            BuildingMemoRadTextBox.Text = _mfBuildingInfo.MFBuildingMemo
            ViewState("BuildingTempID") = _mfBuildingInfo.ID
            ViewState("BuildingName") = _mfBuildingInfo.MFBuildingName
        Else
            ViewState("BuildingTempID") = 0
            BuildingCurrencyTypeComboBox.SelectedValue = "OMR"
            BuildingRentPriceRadTextBox.NumberFormat.PositivePattern = " +n OMR"
            BuildingRentPriceRadTextBox.NumberFormat.NegativePattern = " -n OMR"
        End If
       
    End Sub

    Protected Sub ClearTabButton_Click(sender As Object, e As EventArgs)
        Select Case BuildingTabStrip.SelectedTab.Value.ToString
            Case "GeneralDetails"
                ClearAllData()
                Exit Sub
            Case "FlatDetails"
                Dim _flatInfo = (From sd In DB.APP_MultiFloorBuildingFlatTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd).ToList

                If Not IsNothing(_flatInfo) Then
                    For Each _items In _flatInfo

                        Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachmentTemps Where sd.BuildingFlatID = Convert.ToInt64(_items.ID) Select sd).ToList

                        For Each _attachment In _flatAttachment
                            If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                                File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                            End If
                            DB.APP_MultiFloorBuildingFlatAttachmentTemps.DeleteOnSubmit(_attachment)
                        Next
                    Next
                    DB.APP_MultiFloorBuildingFlatTemps.DeleteAllOnSubmit(_flatInfo)
                End If
                DB.SubmitChanges()
                ClearFlatData()
                Exit Sub
            Case "ShopDetails"
                Dim _shopInfo = (From sd In DB.APP_MultiFloorBuildingShopTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd).ToList

                If Not IsNothing(_shopInfo) Then
                    For Each _items In _shopInfo

                        Dim _ShopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachmentTemps Where sd.BuildingShopID = Convert.ToInt64(_items.ID) Select sd).ToList

                        For Each _attachment In _ShopAttachment
                            If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                                File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                            End If
                            DB.APP_MultiFloorBuildingShopAttachmentTemps.DeleteOnSubmit(_attachment)
                        Next
                    Next
                    DB.APP_MultiFloorBuildingShopTemps.DeleteAllOnSubmit(_shopInfo)
                End If
                DB.SubmitChanges()
                ClearShopData()
                Exit Sub
            Case "OfficeDetails"
                Dim _officeInfo = (From sd In DB.APP_MultiFloorBuildingOfficeTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd).ToList

                If Not IsNothing(_officeInfo) Then
                    For Each _items In _officeInfo

                        Dim _OfficeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachmentTemps Where sd.BuildingOfficeID = Convert.ToInt64(_items.ID) Select sd).ToList

                        For Each _attachment In _OfficeAttachment
                            If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                                File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                            End If
                            DB.APP_MultiFloorBuildingOfficeAttachmentTemps.DeleteOnSubmit(_attachment)
                        Next
                    Next
                    DB.APP_MultiFloorBuildingOfficeTemps.DeleteAllOnSubmit(_officeInfo)
                End If
                DB.SubmitChanges()
                ClearOfficeData()
                Exit Sub

        End Select
    End Sub

    Protected Sub ClearAllButton_Click(sender As Object, e As EventArgs)
        Try

            ClearAllData()

            Dim _TabCurrent As RadTab = BuildingTabStrip.FindTabByValue(BuildingTabStrip.SelectedTab.Value.ToString)
            _TabCurrent.Enabled = False

            Dim _Tab As RadTab = BuildingTabStrip.FindTabByValue("GeneralDetails")
            _Tab.Enabled = True
            _Tab.Selected = True


            Dim _PageView As RadPageView = BuildingMultiPage.FindPageViewByID("GeneralPageView")
            If _PageView Is Nothing Then
                _PageView = New RadPageView()
                _PageView.ID = "GeneralDetails"
                BuildingMultiPage.PageViews.Add(_PageView)
            End If
            _PageView.Selected = True
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

    End Sub

    Private Sub ClearAllData()
        Dim _buildingInfo = (From sd In DB.APP_MultiFloorBuildingTemps Where sd.UserID = Session("UserID") Select sd).SingleOrDefault

        Dim _generalAttachment = (From sd In DB.APP_MultiFloorBuildingAttachmentTemps Where sd.UserID = Session("UserID") Select sd).ToList

        For Each _items In _generalAttachment
            If File.Exists(Server.MapPath(_items.BuildingAttachment)) Then
                File.Delete(Server.MapPath(_items.BuildingAttachment))
            End If
            DB.APP_MultiFloorBuildingAttachmentTemps.DeleteOnSubmit(_items)
        Next

        If Not IsNothing(_buildingInfo) Then

            Dim _flatInfo = (From sd In DB.APP_MultiFloorBuildingFlatTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(_buildingInfo.ID) Select sd).ToList

            If Not IsNothing(_flatInfo) Then
                For Each _items In _flatInfo

                    Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachmentTemps Where sd.BuildingFlatID = Convert.ToInt64(_items.ID) Select sd).ToList

                    For Each _attachment In _flatAttachment
                        If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                            File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                        End If
                        DB.APP_MultiFloorBuildingFlatAttachmentTemps.DeleteOnSubmit(_attachment)
                    Next
                Next
                DB.APP_MultiFloorBuildingFlatTemps.DeleteAllOnSubmit(_flatInfo)
            End If




            Dim _shopInfo = (From sd In DB.APP_MultiFloorBuildingShopTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(_buildingInfo.ID) Select sd).ToList

            If Not IsNothing(_shopInfo) Then
                For Each _items In _shopInfo

                    Dim _shopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachmentTemps Where sd.BuildingShopID = Convert.ToInt64(_items.ID) Select sd).ToList

                    For Each _attachment In _shopAttachment
                        If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                            File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                        End If
                        DB.APP_MultiFloorBuildingShopAttachmentTemps.DeleteOnSubmit(_attachment)
                    Next
                Next
                DB.APP_MultiFloorBuildingShopTemps.DeleteAllOnSubmit(_shopInfo)

            End If


            Dim _officeInfo = (From sd In DB.APP_MultiFloorBuildingOfficeTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(_buildingInfo.ID) Select sd).ToList

            If Not IsNothing(_officeInfo) Then
                For Each _items In _officeInfo

                    Dim _officeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachmentTemps Where sd.BuildingOfficeID = Convert.ToInt64(_items.ID) Select sd).ToList

                    For Each _attachment In _officeAttachment
                        If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                            File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                        End If
                        DB.APP_MultiFloorBuildingOfficeAttachmentTemps.DeleteOnSubmit(_attachment)
                    Next
                Next
                DB.APP_MultiFloorBuildingOfficeTemps.DeleteAllOnSubmit(_officeInfo)
            End If

            DB.APP_MultiFloorBuildingTemps.DeleteOnSubmit(_buildingInfo)
        End If

        DB.SubmitChanges()

        ClearData()

        BuildingAttachmentTempRadGrid.DataBind()
    End Sub
    Protected Sub ClearLinkButton_Click(sender As Object, e As EventArgs)
       

    End Sub

#Region "General"
    Protected Sub BuildingAddressLink_Click(sender As Object, e As EventArgs)
        Building_modal.Width = 1065
        Building_modal.Height = 785
        Building_modal.NavigateUrl = "~/MapLocator"
        Building_modal.VisibleOnPageLoad = True
        RadWindowManager_modalPopup.Windows.Add(Building_modal)
    End Sub

    Protected Sub BuildingCurrencyTypeComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim _currencyCode = (From sd In DB.APP_Countries Where sd.ID = e.Value Select sd.CurrencyCode).SingleOrDefault
        BuildingRentPriceRadTextBox.NumberFormat.NegativePattern = "-n " + _currencyCode.ToString
        BuildingRentPriceRadTextBox.NumberFormat.PositivePattern = "n " + _currencyCode.ToString
    End Sub

    Protected Sub GeneralSubmitButton_Click(sender As Object, e As EventArgs)
        Try
            Dim _mfBuildingInfo = (From sd In DB.APP_MultiFloorBuildingTemps Where sd.UserID = Session("UserID") Select sd).SingleOrDefault

            If Not IsNothing(_mfBuildingInfo) Then

                If Not BuildingNameRadTextBox.Text.Trim = ViewState("BuildingName") Then
                    If Not Building_Name_Exists(BuildingNameRadTextBox.Text.Trim) Then
                        Exit Sub
                    End If
                End If

                With _mfBuildingInfo
                    .MFBuildingName = BuildingNameRadTextBox.Text.Trim
                    .MFBuildingOfficialName = BuildingOfficalNameRadTextBox.Text.Trim
                    .MFBuildingOwnerID = BuildingOwnerComboBox.SelectedValue
                    .MFCurrencyTypeCountryCodeID = BuildingCurrencyTypeComboBox.SelectedValue
                    .MFBuildingRentingPrice = BuildingRentPriceRadTextBox.Value
                    .MFBuildingContactName = BuildingContactStaffNameTextBox.Text.Trim
                    If Not BuildingContactStaffGSMContryCodeCombobox.SelectedValue = "" Then
                        .MFBuildingContactGSMCountryCodeID = BuildingContactStaffGSMContryCodeCombobox.SelectedValue
                        .MFBuildingContactGSM = BuildingContactStaffGSMTextBox.Text.Trim
                    End If
                    .MFBuildingContactGSM = BuildingContactStaffGSMTextBox.Text.Trim
                    .MFBuildingAddress = BuildingAddressTextBox.Text.Trim
                    .MFBuildingGPS = BuildingGPSTextBox.Text.Trim
                    .MFBuildingMapUrl = BuildingMapUrlTextBox.Text.Trim
                    .MFBuildingFloorCount = BuildingFloorNoRadTextBox.Value
                    .MFBuildingFlatCount = BuildingFlatNoRadTextBox.Value
                    .MFBuildingShopCount = BuildingShopNoRadTextBox.Value
                    .MFBuildingOfficeCount = BuildingOfficeNoTextBox.Value
                    .MFBuildingMemo = BuildingMemoRadTextBox.Text.Trim
                End With
                DB.SubmitChanges()

            Else
                If Not Building_Name_Exists(BuildingNameRadTextBox.Text.Trim) Then
                    Exit Sub
                End If

                Dim _mfBuildingID As Long

                Dim _mfBuilding As New APP_MultiFloorBuildingTemp
                With _mfBuilding
                    .UserID = Session("UserID")
                    .MFBuildingName = BuildingNameRadTextBox.Text.Trim
                    .MFBuildingOfficialName = BuildingOfficalNameRadTextBox.Text.Trim
                    .MFBuildingOwnerID = BuildingOwnerComboBox.SelectedValue
                    .MFCurrencyTypeCountryCodeID = BuildingCurrencyTypeComboBox.SelectedValue
                    .MFBuildingRentingPrice = BuildingRentPriceRadTextBox.Value
                    .MFBuildingContactName = BuildingContactStaffNameTextBox.Text.Trim
                    If Not BuildingContactStaffGSMContryCodeCombobox.SelectedValue = "" Then
                        .MFBuildingContactGSMCountryCodeID = BuildingContactStaffGSMContryCodeCombobox.SelectedValue
                        .MFBuildingContactGSM = BuildingContactStaffGSMTextBox.Text.Trim
                    End If
                    .MFBuildingAddress = BuildingAddressTextBox.Text.Trim
                    .MFBuildingGPS = BuildingGPSTextBox.Text.Trim
                    .MFBuildingMapUrl = BuildingMapUrlTextBox.Text.Trim
                    .MFBuildingFloorCount = BuildingFloorNoRadTextBox.Text.Trim
                    .MFBuildingShopCount = BuildingShopNoRadTextBox.Text.Trim
                    .MFBuildingFlatCount = BuildingFlatNoRadTextBox.Text.Trim
                    .MFBuildingOfficeCount = BuildingOfficeNoTextBox.Text.Trim
                    .MFBuildingMemo = BuildingMemoRadTextBox.Text.Trim

                End With
                DB.APP_MultiFloorBuildingTemps.InsertOnSubmit(_mfBuilding)
                DB.SubmitChanges()
                _mfBuildingID = _mfBuilding.ID
                ViewState("BuildingTempID") = _mfBuilding.ID
                ViewState("BuildingName") = _mfBuilding.MFBuildingName
                _mfBuilding = Nothing

               
            End If

            Dim _generalAttachment = (From sd In DB.APP_MultiFloorBuildingAttachmentTemps Where sd.UserID = Session("UserID") Select sd).ToList

            For Each _items In _generalAttachment
                Dim _destination = "~/AttachmentTemp/Building/" + ViewState("BuildingTempID").ToString + "/General/"

                If Not Directory.Exists(Server.MapPath(_destination)) Then
                    Directory.CreateDirectory(Server.MapPath(_destination))
                End If

                Dim _destinationPath = "~/AttachmentTemp/Building/" + ViewState("BuildingTempID").ToString + "/General/" + Path.GetFileName(Server.MapPath(_items.BuildingAttachment))

                File.Move(Server.MapPath(_items.BuildingAttachment), Server.MapPath(_destinationPath))
                _items.BuildingAttachment = _destinationPath
                DB.SubmitChanges()
            Next

            ClearFlatData()



            Dim _Tab As RadTab = BuildingTabStrip.FindTabByValue("FlatDetails")
            _Tab.Enabled = True
            _Tab.Selected = True

            Dim _TabCurrent As RadTab = BuildingTabStrip.FindTabByValue("GeneralDetails")
            _TabCurrent.Enabled = False

            Dim _PageView As RadPageView = BuildingMultiPage.FindPageViewByID("FlatPageView")
            If _PageView Is Nothing Then
                _PageView = New RadPageView()
                _PageView.ID = "FlatPageView"
                BuildingMultiPage.PageViews.Add(_PageView)
            End If
            _PageView.Selected = True

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

    End Sub

    Private Function Building_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildings Select sd.MFBuildingName

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Building Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Protected Sub BuildingAttachmentTempRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_BuildingAttachmentTemp") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub BuildingAttachmentTempRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "InitInsert"
                e.Canceled = True

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/AttachmentWindow/Add/General/" + ViewState("BuildingTempID").ToString + "/NULL/NULL"

                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/AttachmentWindow/Edit/General/" + ViewState("BuildingTempID").ToString + "/NULL/" + _gridDataItem("ID").Text

                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub
            Case "Delete"
                Dim _gridDataItem As GridDataItem = e.Item

                Dim _path = _gridDataItem("BuildingAttachment").Text
                If File.Exists(Server.MapPath(_path)) Then
                    File.Delete(Server.MapPath(_path))
                End If
                Exit Sub
            Case "View"

                Exit Sub
        End Select
    End Sub

 

#End Region

#Region "Flat"
   
    Protected Sub FloorFlatComboBox_ItemsRequested(sender As Object, e As RadComboBoxItemsRequestedEventArgs)
        Try
            For value As Integer = 0 To BuildingFloorNoRadTextBox.Value - 1
                If value = 0 Then
                    FlatFloorComboBox.Items.Add(New RadComboBoxItem("Ground Floor", value))
                Else
                    FlatFloorComboBox.Items.Add(New RadComboBoxItem(value.ToString + " Floor", value))
                End If
            Next
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub FlatSubmitButton_Click(sender As Object, e As EventArgs)
        Try
            Dim _flatID As Long
            Select Case FlatSubmitButton.CommandName.ToString
                Case "Submit"
                    If Not Flat_Name_Exists(FlatNameTextBox.Text.Trim) Then
                        Exit Sub
                    End If

                    If Not Flat_Number_Exists(FlatNumberTextBox.Text.Trim) Then
                        Exit Sub
                    End If

                    Dim _flatTempInfo = (From sd In DB.APP_MultiFloorBuildingFlatTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd).ToList
                    If BuildingFlatNoRadTextBox.Text.Trim <= _flatTempInfo.Count Then
                        PopMsg.ShowErrorMessage("You Cannot Add New Flat Under This Building. Please Update Building Flat Count To Add New Flat..!!")
                        Exit Sub
                    End If


                    Dim _flatInfo As New APP_MultiFloorBuildingFlatTemp
                    With _flatInfo
                        .MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID"))
                        .FlatFloorNo = FlatFloorComboBox.SelectedValue
                        .FlatName = FlatNameTextBox.Text.Trim
                        .FlatNumber = FlatNumberTextBox.Text.Trim
                        .FlatDescription = FlatDescriptionEditor.Content
                    End With
                    DB.APP_MultiFloorBuildingFlatTemps.InsertOnSubmit(_flatInfo)
                    DB.SubmitChanges()
                    _flatID = _flatInfo.ID
                    _flatInfo = Nothing

                    Exit Select
                Case "Update"

                    If Not ViewState("FlatName") = FlatNameTextBox.Text Then
                        If Not Flat_Name_Exists(FlatNameTextBox.Text.Trim) Then
                            Exit Sub
                        End If
                    End If

                    If Not ViewState("FlatNumber") = FlatNumberTextBox.Text Then
                        If Not Flat_Number_Exists(FlatNumberTextBox.Text.Trim) Then
                            Exit Sub
                        End If
                    End If

                    Dim _flatTemp = (From sd In DB.APP_MultiFloorBuildingFlatTemps Where sd.ID = Convert.ToInt64(ViewState("FlatTempID")) Select sd).SingleOrDefault
                    With _flatTemp
                        .FlatName = FlatNameTextBox.Text
                        .FlatNumber = FlatNumberTextBox.Text
                        .FlatDescription = FlatDescriptionEditor.Content
                        .FlatFloorNo = FlatFloorComboBox.SelectedValue
                    End With
                    DB.SubmitChanges()
                    _flatID = _flatTemp.ID
                    _flatTemp = Nothing
                    Exit Select
            End Select

            Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachmentTemps Where sd.UserID = Session("UserID") And sd.BuildingFlatID = Convert.ToInt64(ViewState("FlatTempID")) Select sd).ToList

            For Each _items In _flatAttachment
                Dim _destination = "~/AttachmentTemp/Building/" + ViewState("BuildingTempID").ToString + "/Flat/" + _flatID.ToString + "/"

                If Not Directory.Exists(Server.MapPath(_destination)) Then
                    Directory.CreateDirectory(Server.MapPath(_destination))
                End If

                Dim _destinationPath = "~/AttachmentTemp/Building/" + ViewState("BuildingTempID").ToString + "/Flat/" + _flatID.ToString + "/" + Path.GetFileName(Server.MapPath(_items.BuildingAttachment))

                File.Move(Server.MapPath(_items.BuildingAttachment), Server.MapPath(_destinationPath))
                _items.BuildingAttachment = _destinationPath
                _items.BuildingFlatID = _flatID
                DB.SubmitChanges()
            Next

            ClearFlatData()

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub ClearFlatData()
        FlatNameTextBox.Text = ""
        FlatNumberTextBox.Text = ""
        FlatDescriptionEditor.Content = ""

        FlatSubmitButton.CommandName = "Submit"
        FlatSubmitButton.Text = "Submit"
        FlatHeaderLabel.Text = "Flat Add"
        ViewState("FlatTempID") = 0
        ViewState("FlatName") = Nothing
        ViewState("FlatNumber") = Nothing

        FlatAttachmentTempRadGrid.DataBind()
        FlatTempRadGrid.DataBind()
    End Sub

    Protected Sub FlatTempRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_FlatTemp") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub FlatTempRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case (e.CommandName.ToString)
            Case "Delete"

                Dim _gridDataItem As GridDataItem = e.Item
                Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachmentTemps Where sd.BuildingFlatID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).ToList
                For Each _items In _flatAttachment

                    If File.Exists(Server.MapPath(_items.BuildingAttachment)) Then
                        File.Delete(Server.MapPath(_items.BuildingAttachment))
                    End If
                    DB.APP_MultiFloorBuildingFlatAttachmentTemps.DeleteOnSubmit(_items)
                    DB.SubmitChanges()
                Next
                Dim _flat = (From sd In DB.APP_MultiFloorBuildingFlatTemps Where sd.ID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).SingleOrDefault
                DB.APP_MultiFloorBuildingFlatTemps.DeleteOnSubmit(_flat)
                DB.SubmitChanges()
                Exit Sub
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item
                ViewState("FlatTempID") = Convert.ToInt64(_gridDataItem("ID").Text)
                ViewState("FlatName") = _gridDataItem("FlatName").Text
                ViewState("FlatNumber") = _gridDataItem("FlatNumber").Text
                FlatSubmitButton.CommandName = "Update"
                FlatSubmitButton.Text = "Update"
                FlatHeaderLabel.Text = "Flat Update"

                Dim _flatTemp = (From sd In DB.APP_MultiFloorBuildingFlatTemps Where sd.ID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).SingleOrDefault
                FlatFloorComboBox.ClearSelection()
                FlatFloorComboBox.Items.Clear()
                FlatFloorComboBox.DataBind()

                FloorFlatComboBox_ItemsRequested(FlatFloorComboBox, Nothing)
                FlatFloorComboBox.SelectedValue = _flatTemp.FlatFloorNo
                FlatNameTextBox.Text = _flatTemp.FlatName
                FlatNumberTextBox.Text = _flatTemp.FlatNumber
                FlatDescriptionEditor.Content = _flatTemp.FlatDescription
                FlatAttachmentTempRadGrid.DataBind()
                Exit Sub
        End Select
    End Sub

    Protected Sub SqlDataSource_FlatTemp_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs)
        Try
            e.Command.Parameters("@BuildingTempID").Value = ViewState("BuildingTempID")
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub SqlDataSource_FlatAttachmentTemp_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs)
        Try
            e.Command.Parameters("@FlatTempID").Value = ViewState("FlatTempID")
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

#Region "Attachment"
    Protected Sub FlatAttachmentTempRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_FlatAttachmentTemp") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub FlatAttachmentTempRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "InitInsert"
                e.Canceled = True

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/AttachmentWindow/Add/Flat/" + ViewState("BuildingTempID").ToString + "/" + ViewState("FlatTempID").ToString + "/NULL"
                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub
            Case "Delete"
                Dim _gridDataItem As GridDataItem = e.Item

                Dim _path = _gridDataItem("BuildingAttachment").Text
                If File.Exists(Server.MapPath(_path)) Then
                    File.Delete(Server.MapPath(_path))
                End If
                Exit Sub
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/AttachmentWindow/Edit/Flat/" + ViewState("BuildingTempID").ToString + "/" + ViewState("FlatTempID").ToString + "/" + _gridDataItem("ID").Text

                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub


            Case "View"

                Exit Sub
        End Select


    End Sub

   
#End Region

    Private Function Flat_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingFlatTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd.FlatName

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Flat Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Function Flat_Number_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingFlatTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd.FlatNumber

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Flat Number Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Protected Sub FlatNextButton_Click(sender As Object, e As EventArgs)

        ClearShopData()

        Dim _Tab As RadTab = BuildingTabStrip.FindTabByValue("ShopDetails")
        _Tab.Enabled = True
        _Tab.Selected = True

        Dim _TabCurrent As RadTab = BuildingTabStrip.FindTabByValue("FlatDetails")
        _TabCurrent.Enabled = False

        Dim _PageView As RadPageView = BuildingMultiPage.FindPageViewByID("ShopPageView")
        If _PageView Is Nothing Then
            _PageView = New RadPageView()
            _PageView.ID = "ShopPageView"
            BuildingMultiPage.PageViews.Add(_PageView)
        End If
        _PageView.Selected = True
    End Sub

#End Region

#Region "Shop"

    Protected Sub ShopFloorComboBox_ItemsRequested(sender As Object, e As RadComboBoxItemsRequestedEventArgs)
        Try
            For value As Integer = 0 To BuildingFloorNoRadTextBox.Value - 1
                If value = 0 Then
                    ShopFloorComboBox.Items.Add(New RadComboBoxItem("Ground Floor", value))
                Else
                    ShopFloorComboBox.Items.Add(New RadComboBoxItem(value.ToString + " Floor", value))
                End If
            Next
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub ShopSubmitButton_Click(sender As Object, e As EventArgs)
        Try
            Dim _ShopID As Long
            Select Case ShopSubmitButton.CommandName.ToString
                Case "Submit"
                    If Not Shop_Name_Exists(ShopNameTextBox.Text.Trim) Then
                        Exit Sub
                    End If

                    If Not Shop_Number_Exists(ShopNumberTextBox.Text.Trim) Then
                        Exit Sub
                    End If

                    Dim _ShopTempInfo = (From sd In DB.APP_MultiFloorBuildingShopTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd).ToList
                    If BuildingShopNoRadTextBox.Text.Trim <= _ShopTempInfo.Count Then
                        PopMsg.ShowErrorMessage("You Cannot Add New Shop Under This Building. Please Update Building Shop Count To Add New Shop..!!")
                        Exit Sub
                    End If



                    Dim _ShopInfo As New APP_MultiFloorBuildingShopTemp
                    With _ShopInfo
                        .MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID"))
                        .ShopFloorNo = ShopFloorComboBox.SelectedValue
                        .ShopName = ShopNameTextBox.Text.Trim
                        .ShopNumber = ShopNumberTextBox.Text.Trim
                        .ShopDescription = ShopDescriptionEditor.Content
                    End With
                    DB.APP_MultiFloorBuildingShopTemps.InsertOnSubmit(_ShopInfo)
                    DB.SubmitChanges()
                    _ShopID = _ShopInfo.ID
                    _ShopInfo = Nothing

                    Exit Select
                Case "Update"

                    If Not ViewState("ShopName") = ShopNameTextBox.Text Then
                        If Not Shop_Name_Exists(ShopNameTextBox.Text.Trim) Then
                            Exit Sub
                        End If
                    End If

                    If Not ViewState("ShopNumber") = ShopNumberTextBox.Text Then
                        If Not Shop_Number_Exists(ShopNumberTextBox.Text.Trim) Then
                            Exit Sub
                        End If
                    End If

                    Dim _ShopTemp = (From sd In DB.APP_MultiFloorBuildingShopTemps Where sd.ID = Convert.ToInt64(ViewState("ShopTempID")) Select sd).SingleOrDefault
                    With _ShopTemp
                        .ShopName = ShopNameTextBox.Text
                        .ShopNumber = ShopNumberTextBox.Text
                        .ShopDescription = ShopDescriptionEditor.Content
                        .ShopFloorNo = ShopFloorComboBox.SelectedValue
                    End With
                    DB.SubmitChanges()
                    _ShopID = _ShopTemp.ID
                    Exit Select
            End Select
            Dim _ShopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachmentTemps Where sd.UserID = Session("UserID") And sd.BuildingShopID = Convert.ToInt64(ViewState("ShopTempID")) Select sd).ToList

            For Each _items In _ShopAttachment
                Dim _destination = "~/AttachmentTemp/Building/" + ViewState("BuildingTempID").ToString + "/Shop/" + _ShopID.ToString + "/"

                If Not Directory.Exists(Server.MapPath(_destination)) Then
                    Directory.CreateDirectory(Server.MapPath(_destination))
                End If

                Dim _destinationPath = "~/AttachmentTemp/Building/" + ViewState("BuildingTempID").ToString + "/Shop/" + _ShopID.ToString + "/" + Path.GetFileName(Server.MapPath(_items.BuildingAttachment))

                File.Move(Server.MapPath(_items.BuildingAttachment), Server.MapPath(_destinationPath))
                _items.BuildingAttachment = _destinationPath
                _items.BuildingShopID = _ShopID
                DB.SubmitChanges()
            Next
            ClearShopData()

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub


    Private Sub ClearShopData()
        ShopNameTextBox.Text = ""
        ShopNumberTextBox.Text = ""
        ShopDescriptionEditor.Content = ""

        ShopSubmitButton.CommandName = "Submit"
        ShopSubmitButton.Text = "Submit"
        ShopHeaderLabel.Text = "Shop Add"
        ViewState("ShopTempID") = 0
        ViewState("ShopName") = Nothing
        ViewState("ShopNumber") = Nothing

        ShopAttachmentTempRadGrid.DataBind()
        ShopTempRadGrid.DataBind()
    End Sub

    Protected Sub ShopTempRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_ShopTemp") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub ShopTempRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case (e.CommandName.ToString)
            Case "Delete"

                Dim _gridDataItem As GridDataItem = e.Item
                Dim _ShopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachmentTemps Where sd.BuildingShopID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).ToList
                For Each _items In _ShopAttachment

                    If File.Exists(Server.MapPath(_items.BuildingAttachment)) Then
                        File.Delete(Server.MapPath(_items.BuildingAttachment))
                    End If
                    DB.APP_MultiFloorBuildingShopAttachmentTemps.DeleteOnSubmit(_items)
                    DB.SubmitChanges()
                Next
                Dim _Shop = (From sd In DB.APP_MultiFloorBuildingShopTemps Where sd.ID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).SingleOrDefault
                DB.APP_MultiFloorBuildingShopTemps.DeleteOnSubmit(_Shop)
                DB.SubmitChanges()
                Exit Sub
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item
                ViewState("ShopTempID") = Convert.ToInt64(_gridDataItem("ID").Text)
                ViewState("ShopName") = _gridDataItem("ShopName").Text
                ViewState("ShopNumber") = _gridDataItem("ShopNumber").Text
                ShopSubmitButton.CommandName = "Update"
                ShopSubmitButton.Text = "Update"
                ShopHeaderLabel.Text = "Shop Update"

                Dim _ShopTemp = (From sd In DB.APP_MultiFloorBuildingShopTemps Where sd.ID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).SingleOrDefault
                ShopFloorComboBox.ClearSelection()
                ShopFloorComboBox.Items.Clear()
                ShopFloorComboBox.DataBind()

                ShopFloorComboBox_ItemsRequested(ShopFloorComboBox, Nothing)
                ShopFloorComboBox.SelectedValue = _ShopTemp.ShopFloorNo
                ShopNameTextBox.Text = _ShopTemp.ShopName
                ShopNumberTextBox.Text = _ShopTemp.ShopNumber
                ShopDescriptionEditor.Content = _ShopTemp.ShopDescription
                ShopAttachmentTempRadGrid.DataBind()
                Exit Sub
        End Select
    End Sub

    Protected Sub SqlDataSource_ShopTemp_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs)
        Try
            e.Command.Parameters("@BuildingTempID").Value = ViewState("BuildingTempID")
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub SqlDataSource_ShopAttachmentTemp_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs)
        Try
            e.Command.Parameters("@ShopTempID").Value = ViewState("ShopTempID")
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

#Region "Attachment"
    Protected Sub ShopAttachmentTempRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_ShopAttachmentTemp") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub ShopAttachmentTempRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "InitInsert"
                e.Canceled = True

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/AttachmentWindow/Add/Shop/" + ViewState("BuildingTempID").ToString + "/" + ViewState("ShopTempID").ToString + "/NULL"
                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub
            Case "Delete"
                Dim _gridDataItem As GridDataItem = e.Item

                Dim _path = _gridDataItem("BuildingAttachment").Text
                If File.Exists(Server.MapPath(_path)) Then
                    File.Delete(Server.MapPath(_path))
                End If
                Exit Sub
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/AttachmentWindow/Edit/Shop/" + ViewState("BuildingTempID").ToString + "/" + ViewState("ShopTempID").ToString + "/" + _gridDataItem("ID").Text

                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub


            Case "View"

                Exit Sub
        End Select


    End Sub


#End Region

    Private Function Shop_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingShopTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd.ShopName

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Shop Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Function Shop_Number_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingShopTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd.ShopNumber

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Shop Number Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Protected Sub ShopNextButton_Click(sender As Object, e As EventArgs)

        ClearOfficeData()

        Dim _Tab As RadTab = BuildingTabStrip.FindTabByValue("OfficeDetails")
        _Tab.Enabled = True
        _Tab.Selected = True

        Dim _TabCurrent As RadTab = BuildingTabStrip.FindTabByValue("ShopDetails")
        _TabCurrent.Enabled = False

        Dim _PageView As RadPageView = BuildingMultiPage.FindPageViewByID("OfficePageView")
        If _PageView Is Nothing Then
            _PageView = New RadPageView()
            _PageView.ID = "ShopPageView"
            BuildingMultiPage.PageViews.Add(_PageView)
        End If
        _PageView.Selected = True
    End Sub

#End Region

#Region "Office"

    Protected Sub OfficeFloorComboBox_ItemsRequested(sender As Object, e As RadComboBoxItemsRequestedEventArgs)
        Try
            For value As Integer = 0 To BuildingFloorNoRadTextBox.Value - 1
                If value = 0 Then
                    OfficeFloorComboBox.Items.Add(New RadComboBoxItem("Ground Floor", value))
                Else
                    OfficeFloorComboBox.Items.Add(New RadComboBoxItem(value.ToString + " Floor", value))
                End If
            Next
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub OfficeSubmitButton_Click(sender As Object, e As EventArgs)
        Try
            Dim _OfficeID As Long

            Select Case OfficeSubmitButton.CommandName.ToString
                Case "Submit"
                    If Not Office_Name_Exists(OfficeNameTextBox.Text.Trim) Then
                        Exit Sub
                    End If

                    If Not Office_Number_Exists(OfficeNumberTextBox.Text.Trim) Then
                        Exit Sub
                    End If

                    Dim _OfficeTempInfo = (From sd In DB.APP_MultiFloorBuildingOfficeTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd).ToList
                    If BuildingOfficeNoTextBox.Text.Trim <= _OfficeTempInfo.Count Then
                        PopMsg.ShowErrorMessage("You Cannot Add New Office Under This Building. Please Update Building Office Count To Add New Office..!!")
                        Exit Sub
                    End If

                    Dim _OfficeInfo As New APP_MultiFloorBuildingOfficeTemp
                    With _OfficeInfo
                        .MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID"))
                        .OfficeFloorNo = OfficeFloorComboBox.SelectedValue
                        .OfficeName = OfficeNameTextBox.Text.Trim
                        .OfficeNumber = OfficeNumberTextBox.Text.Trim
                        .OfficeDescription = OfficeDescriptionEditor.Content
                    End With
                    DB.APP_MultiFloorBuildingOfficeTemps.InsertOnSubmit(_OfficeInfo)
                    DB.SubmitChanges()
                    _OfficeID = _OfficeInfo.ID
                    _OfficeInfo = Nothing

                    Exit Select
                Case "Update"

                    If Not ViewState("OfficeName") = OfficeNameTextBox.Text Then
                        If Not Office_Name_Exists(OfficeNameTextBox.Text.Trim) Then
                            Exit Sub
                        End If
                    End If

                    If Not ViewState("OfficeNumber") = OfficeNumberTextBox.Text Then
                        If Not Office_Number_Exists(OfficeNumberTextBox.Text.Trim) Then
                            Exit Sub
                        End If
                    End If

                    Dim _OfficeTemp = (From sd In DB.APP_MultiFloorBuildingOfficeTemps Where sd.ID = Convert.ToInt64(ViewState("OfficeTempID")) Select sd).SingleOrDefault
                    With _OfficeTemp
                        .OfficeName = OfficeNameTextBox.Text
                        .OfficeNumber = OfficeNumberTextBox.Text
                        .OfficeDescription = OfficeDescriptionEditor.Content
                        .OfficeFloorNo = OfficeFloorComboBox.SelectedValue
                    End With
                    DB.SubmitChanges()
                    _OfficeID = _OfficeTemp.ID
                    Exit Select
            End Select

            Dim _OfficeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachmentTemps Where sd.UserID = Session("UserID") And sd.BuildingOfficeID = Convert.ToInt64(ViewState("OfficeTempID")) Select sd).ToList

            For Each _items In _OfficeAttachment
                Dim _destination = "~/AttachmentTemp/Building/" + ViewState("BuildingTempID").ToString + "/Office/" + _OfficeID.ToString + "/"

                If Not Directory.Exists(Server.MapPath(_destination)) Then
                    Directory.CreateDirectory(Server.MapPath(_destination))
                End If

                Dim _destinationPath = "~/AttachmentTemp/Building/" + ViewState("BuildingTempID").ToString + "/Office/" + _OfficeID.ToString + "/" + Path.GetFileName(Server.MapPath(_items.BuildingAttachment))

                File.Move(Server.MapPath(_items.BuildingAttachment), Server.MapPath(_destinationPath))
                _items.BuildingAttachment = _destinationPath
                _items.BuildingOfficeID = _OfficeID
                DB.SubmitChanges()
            Next

            ClearOfficeData()

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub


    Private Sub ClearOfficeData()
        OfficeNameTextBox.Text = ""
        OfficeNumberTextBox.Text = ""
        OfficeDescriptionEditor.Content = ""

        OfficeSubmitButton.CommandName = "Submit"
        OfficeSubmitButton.Text = "Submit"
        OfficeHeaderLabel.Text = "Office Add"
        ViewState("OfficeTempID") = 0
        ViewState("OfficeName") = Nothing
        ViewState("OfficeNumber") = Nothing

        OfficeAttachmentTempRadGrid.DataBind()
        OfficeTempRadGrid.DataBind()
    End Sub

    Protected Sub OfficeTempRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_OfficeTemp") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub OfficeTempRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case (e.CommandName.ToString)
            Case "Delete"

                Dim _gridDataItem As GridDataItem = e.Item
                Dim _OfficeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachmentTemps Where sd.BuildingOfficeID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).ToList
                For Each _items In _OfficeAttachment

                    If File.Exists(Server.MapPath(_items.BuildingAttachment)) Then
                        File.Delete(Server.MapPath(_items.BuildingAttachment))
                    End If
                    DB.APP_MultiFloorBuildingOfficeAttachmentTemps.DeleteOnSubmit(_items)
                    DB.SubmitChanges()
                Next
                Dim _Office = (From sd In DB.APP_MultiFloorBuildingOfficeTemps Where sd.ID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).SingleOrDefault
                DB.APP_MultiFloorBuildingOfficeTemps.DeleteOnSubmit(_Office)
                DB.SubmitChanges()
                Exit Sub
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item
                ViewState("OfficeTempID") = Convert.ToInt64(_gridDataItem("ID").Text)
                ViewState("OfficeName") = _gridDataItem("OfficeName").Text
                ViewState("OfficeNumber") = _gridDataItem("OfficeNumber").Text
                OfficeSubmitButton.CommandName = "Update"
                OfficeSubmitButton.Text = "Update"
                OfficeHeaderLabel.Text = "Office Update"

                Dim _OfficeTemp = (From sd In DB.APP_MultiFloorBuildingOfficeTemps Where sd.ID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).SingleOrDefault
                OfficeFloorComboBox.ClearSelection()
                OfficeFloorComboBox.Items.Clear()
                OfficeFloorComboBox.DataBind()

                OfficeFloorComboBox_ItemsRequested(OfficeFloorComboBox, Nothing)
                OfficeFloorComboBox.SelectedValue = _OfficeTemp.OfficeFloorNo
                OfficeNameTextBox.Text = _OfficeTemp.OfficeName
                OfficeNumberTextBox.Text = _OfficeTemp.OfficeNumber
                OfficeDescriptionEditor.Content = _OfficeTemp.OfficeDescription
                OfficeAttachmentTempRadGrid.DataBind()
                Exit Sub
        End Select
    End Sub

    Protected Sub SqlDataSource_OfficeTemp_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs)
        Try
            e.Command.Parameters("@BuildingTempID").Value = ViewState("BuildingTempID")
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

    Protected Sub SqlDataSource_OfficeAttachmentTemp_Selecting(sender As Object, e As SqlDataSourceSelectingEventArgs)
        Try
            e.Command.Parameters("@OfficeTempID").Value = ViewState("OfficeTempID")
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

#Region "Attachment"
    Protected Sub OfficeAttachmentTempRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_OfficeAttachmentTemp") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub OfficeAttachmentTempRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "InitInsert"
                e.Canceled = True

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/AttachmentWindow/Add/Office/" + ViewState("BuildingTempID").ToString + "/" + ViewState("OfficeTempID").ToString + "/NULL"
                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub
            Case "Delete"
                Dim _gridDataItem As GridDataItem = e.Item

                Dim _path = _gridDataItem("BuildingAttachment").Text
                If File.Exists(Server.MapPath(_path)) Then
                    File.Delete(Server.MapPath(_path))
                End If
                Exit Sub
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/AttachmentWindow/Edit/Office/" + ViewState("BuildingTempID").ToString + "/" + ViewState("OfficeTempID").ToString + "/" + _gridDataItem("ID").Text

                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub


            Case "View"

                Exit Sub
        End Select


    End Sub


#End Region

    Private Function Office_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingOfficeTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd.OfficeName

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Office Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Function Office_Number_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingOfficeTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd.OfficeNumber

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Office Number Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Protected Sub OfficeNextButton_Click(sender As Object, e As EventArgs)
        Try

            Dim _buildingID, _flatID, _shopID, _officeID As Long
            DB.PROC_APP_MultiFloorBuildingCopyFromTemp(Convert.ToInt64(ViewState("BuildingTempID")), _buildingID)

            Dim _generalAttachment = (From sd In DB.APP_MultiFloorBuildingAttachmentTemps Where sd.UserID = Session("UserID") Select sd).ToList

            For Each _items In _generalAttachment
                Dim _destination = "~/Attachments/Building/" + _buildingID.ToString + "/General/"

                If Not Directory.Exists(Server.MapPath(_destination)) Then
                    Directory.CreateDirectory(Server.MapPath(_destination))
                End If

                Dim _destinationPath = "~/Attachments/Building/" + _buildingID.ToString + "/General/" + Path.GetFileName(Server.MapPath(_items.BuildingAttachment))

                File.Move(Server.MapPath(_items.BuildingAttachment), Server.MapPath(_destinationPath))

                Dim _newAttachment As New APP_MultiFloorBuildingAttachment
                With _newAttachment
                    .BuildingID = _buildingID
                    .BuildingAttachmentName = _items.BuildingAttachmentName
                    .BuildingAttachment = _destinationPath
                End With
                DB.APP_MultiFloorBuildingAttachments.InsertOnSubmit(_newAttachment)
                DB.SubmitChanges()
            Next
            DB.APP_MultiFloorBuildingAttachmentTemps.DeleteAllOnSubmit(_generalAttachment)
            DB.SubmitChanges()

            Dim _buildingInfo = (From sd In DB.APP_MultiFloorBuildingTemps Where sd.UserID = Session("UserID") Select sd).SingleOrDefault
            If Not IsNothing(_buildingInfo) Then
                Dim _flatInfo = (From sd In DB.APP_MultiFloorBuildingFlatTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd).ToList

                If Not IsNothing(_flatInfo) Then
                    For Each _items In _flatInfo
                        DB.PROC_APP_MultiFloorBuildingFlatCopyFromTemp(Convert.ToInt64(_items.ID), Convert.ToInt64(_buildingID), _flatID)

                        Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachmentTemps Where sd.BuildingFlatID = Convert.ToInt64(_items.ID) Select sd).ToList

                        For Each _attachment In _flatAttachment
                            Dim _destination = "~/Attachments/Building/" + _buildingID.ToString + "/Flat/" + _flatID.ToString + "/"
                            If Not Directory.Exists(Server.MapPath(_destination)) Then
                                Directory.CreateDirectory(Server.MapPath(_destination))
                            End If

                            Dim _destinationPath = "~/Attachments/Building/" + _buildingID.ToString + "/Flat/" + _flatID.ToString + "/" + Path.GetFileName(Server.MapPath(_attachment.BuildingAttachment))

                            File.Move(Server.MapPath(_attachment.BuildingAttachment), Server.MapPath(_destinationPath))

                            Dim _newAttachment As New APP_MultiFloorBuildingFlatAttachment
                            With _newAttachment
                                .BuildingFlatID = _flatID
                                .BuildingAttachmentName = _attachment.BuildingAttachmentName
                                .BuildingAttachment = _destinationPath
                            End With
                            DB.APP_MultiFloorBuildingFlatAttachments.InsertOnSubmit(_newAttachment)
                            DB.SubmitChanges()
                        Next
                        DB.APP_MultiFloorBuildingFlatAttachmentTemps.DeleteAllOnSubmit(_flatAttachment)
                        DB.SubmitChanges()
                    Next

                    DB.APP_MultiFloorBuildingFlatTemps.DeleteAllOnSubmit(_flatInfo)
                    DB.SubmitChanges()
                End If


                Dim _ShopInfo = (From sd In DB.APP_MultiFloorBuildingShopTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd).ToList

                If Not IsNothing(_ShopInfo) Then
                    For Each _items In _ShopInfo
                        DB.PROC_APP_MultiFloorBuildingShopCopyFromTemp(Convert.ToInt64(_items.ID), Convert.ToInt64(_buildingID), _shopID)

                        Dim _ShopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachmentTemps Where sd.BuildingShopID = Convert.ToInt64(_items.ID) Select sd).ToList

                        For Each _attachment In _ShopAttachment
                            Dim _destination = "~/Attachments/Building/" + _buildingID.ToString + "/Shop/" + _shopID.ToString + "/"
                            If Not Directory.Exists(Server.MapPath(_destination)) Then
                                Directory.CreateDirectory(Server.MapPath(_destination))
                            End If

                            Dim _destinationPath = "~/Attachments/Building/" + _buildingID.ToString + "/Shop/" + _shopID.ToString + "/" + Path.GetFileName(Server.MapPath(_attachment.BuildingAttachment))

                            File.Move(Server.MapPath(_attachment.BuildingAttachment), Server.MapPath(_destinationPath))

                            Dim _newAttachment As New APP_MultiFloorBuildingShopAttachment
                            With _newAttachment
                                .BuildingShopID = _shopID
                                .BuildingAttachmentName = _attachment.BuildingAttachmentName
                                .BuildingAttachment = _destinationPath
                            End With
                            DB.APP_MultiFloorBuildingShopAttachments.InsertOnSubmit(_newAttachment)
                            DB.SubmitChanges()
                        Next
                        DB.APP_MultiFloorBuildingShopAttachmentTemps.DeleteAllOnSubmit(_ShopAttachment)
                        DB.SubmitChanges()
                    Next

                    DB.APP_MultiFloorBuildingShopTemps.DeleteAllOnSubmit(_ShopInfo)
                    DB.SubmitChanges()
                End If


                Dim _OfficeInfo = (From sd In DB.APP_MultiFloorBuildingOfficeTemps Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingTempID")) Select sd).ToList

                If Not IsNothing(_OfficeInfo) Then
                    For Each _items In _OfficeInfo
                        DB.PROC_APP_MultiFloorBuildingOfficeCopyFromTemp(Convert.ToInt64(_items.ID), Convert.ToInt64(_buildingID), _officeID)

                        Dim _OfficeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachmentTemps Where sd.BuildingOfficeID = Convert.ToInt64(_items.ID) Select sd).ToList

                        For Each _attachment In _OfficeAttachment
                            Dim _destination = "~/Attachments/Building/" + _buildingID.ToString + "/Office/" + _officeID.ToString + "/"
                            If Not Directory.Exists(Server.MapPath(_destination)) Then
                                Directory.CreateDirectory(Server.MapPath(_destination))
                            End If

                            Dim _destinationPath = "~/Attachments/Building/" + _buildingID.ToString + "/Office/" + _officeID.ToString + "/" + Path.GetFileName(Server.MapPath(_attachment.BuildingAttachment))

                            File.Move(Server.MapPath(_attachment.BuildingAttachment), Server.MapPath(_destinationPath))

                            Dim _newAttachment As New APP_MultiFloorBuildingOfficeAttachment
                            With _newAttachment
                                .BuildingOfficeID = _officeID
                                .BuildingAttachmentName = _attachment.BuildingAttachmentName
                                .BuildingAttachment = _destinationPath
                            End With
                            DB.APP_MultiFloorBuildingOfficeAttachments.InsertOnSubmit(_newAttachment)
                            DB.SubmitChanges()
                        Next
                        DB.APP_MultiFloorBuildingOfficeAttachmentTemps.DeleteAllOnSubmit(_OfficeAttachment)
                        DB.SubmitChanges()
                    Next

                    DB.APP_MultiFloorBuildingOfficeTemps.DeleteAllOnSubmit(_OfficeInfo)
                    DB.SubmitChanges()
                End If

                DB.APP_MultiFloorBuildingTemps.DeleteOnSubmit(_buildingInfo)
                DB.SubmitChanges()
            End If

            ClearData()

            BuildingAttachmentTempRadGrid.DataBind()

            Dim _TabCurrent As RadTab = BuildingTabStrip.FindTabByValue(BuildingTabStrip.SelectedTab.Value.ToString)
            _TabCurrent.Enabled = False

            Dim _Tab As RadTab = BuildingTabStrip.FindTabByValue("GeneralDetails")
            _Tab.Enabled = True
            _Tab.Selected = True


            Dim _PageView As RadPageView = BuildingMultiPage.FindPageViewByID("GeneralPageView")
            If _PageView Is Nothing Then
                _PageView = New RadPageView()
                _PageView.ID = "GeneralDetails"
                BuildingMultiPage.PageViews.Add(_PageView)
            End If
            _PageView.Selected = True

        Catch ex As Exception

        End Try
    End Sub

#End Region

    Protected Sub GeneralDownloadButton_Click(sender As Object, e As EventArgs)
        newTabURLHiddenField.Value = Request.ApplicationPath + "/Administrator/RealEstate/Attachment/Download/Temp/General/" + Convert.ToString(ViewState("BuildingTempID"))
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "myFunction", "myFunction();", True)
    End Sub

    Protected Sub GeneralSelectDownloadButton_Click(sender As Object, e As EventArgs)
        Dim Button As RadButton = DirectCast(sender, RadButton)

        Dim SelectedItemList As New StringBuilder

        For Each _selectedItem As GridItem In BuildingAttachmentTempRadGrid.MasterTableView.Items
            Dim _gridDataItem As GridDataItem = DirectCast(_selectedItem, GridDataItem)
            Dim cell As TableCell = _gridDataItem("Download")
            Dim checkBox As CheckBox = DirectCast(cell.Controls(0), CheckBox)
            If checkBox.Checked Then
                SelectedItemList.Append(_gridDataItem.GetDataKeyValue("ID"))
                SelectedItemList.Append(",")
            End If
        Next
        newTabURLHiddenField.Value = Request.ApplicationPath + "/Administrator/RealEstate/Attachment/SelectedDownload/Temp/General/" + Convert.ToString(ViewState("BuildingTempID")) + "/" + SelectedItemList.ToString


        BuildingAttachmentTempRadGrid.SelectedIndexes.Clear()

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "myFunction", "myFunction();", True)
    End Sub

   
    Protected Sub FlatDownloadButton_Click(sender As Object, e As EventArgs)
        newTabURLHiddenField.Value = Request.ApplicationPath + "/Administrator/RealEstate/Attachment/Download/Temp/Flat/" + Convert.ToString(ViewState("FlatTempID"))
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "myFunction", "myFunction();", True)
    End Sub

    Protected Sub FlatSelectDownloadButton_Click(sender As Object, e As EventArgs)
        Dim Button As RadButton = DirectCast(sender, RadButton)

        Dim SelectedItemList As New StringBuilder

        For Each _selectedItem As GridItem In FlatAttachmentTempRadGrid.MasterTableView.Items
            Dim _gridDataItem As GridDataItem = DirectCast(_selectedItem, GridDataItem)
            Dim cell As TableCell = _gridDataItem("Download")
            Dim checkBox As CheckBox = DirectCast(cell.Controls(0), CheckBox)
            If checkBox.Checked Then
                SelectedItemList.Append(_gridDataItem.GetDataKeyValue("ID"))
                SelectedItemList.Append(",")
            End If
        Next
        newTabURLHiddenField.Value = Request.ApplicationPath + "/Administrator/RealEstate/Attachment/SelectedDownload/Temp/Flat/" + Convert.ToString(ViewState("FlatTempID")) + "/" + SelectedItemList.ToString


        FlatAttachmentTempRadGrid.SelectedIndexes.Clear()

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "myFunction", "myFunction();", True)
    End Sub

    Protected Sub ShopDownloadButton_Click(sender As Object, e As EventArgs)
        newTabURLHiddenField.Value = Request.ApplicationPath + "/Administrator/RealEstate/Attachment/Download/Temp/Shop/" + Convert.ToString(ViewState("ShopTempID"))
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "myFunction", "myFunction();", True)
    End Sub

    Protected Sub ShopSelectDownloadButton_Click(sender As Object, e As EventArgs)
        Dim Button As RadButton = DirectCast(sender, RadButton)

        Dim SelectedItemList As New StringBuilder

        For Each _selectedItem As GridItem In ShopAttachmentTempRadGrid.MasterTableView.Items
            Dim _gridDataItem As GridDataItem = DirectCast(_selectedItem, GridDataItem)
            Dim cell As TableCell = _gridDataItem("Download")
            Dim checkBox As CheckBox = DirectCast(cell.Controls(0), CheckBox)
            If checkBox.Checked Then
                SelectedItemList.Append(_gridDataItem.GetDataKeyValue("ID"))
                SelectedItemList.Append(",")
            End If
        Next
        newTabURLHiddenField.Value = Request.ApplicationPath + "/Administrator/RealEstate/Attachment/SelectedDownload/Temp/Shop/" + Convert.ToString(ViewState("ShopTempID")) + "/" + SelectedItemList.ToString


        ShopAttachmentTempRadGrid.SelectedIndexes.Clear()

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "myFunction", "myFunction();", True)
    End Sub

    Protected Sub OfficeDownloadButton_Click(sender As Object, e As EventArgs)
        newTabURLHiddenField.Value = Request.ApplicationPath + "/Administrator/RealEstate/Attachment/Download/Temp/Office/" + Convert.ToString(ViewState("OfficeTempID"))
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "myFunction", "myFunction();", True)
    End Sub

    Protected Sub OfficeSelectDownloadButton_Click(sender As Object, e As EventArgs)
        Dim Button As RadButton = DirectCast(sender, RadButton)

        Dim SelectedItemList As New StringBuilder

        For Each _selectedItem As GridItem In OfficeAttachmentTempRadGrid.MasterTableView.Items
            Dim _gridDataItem As GridDataItem = DirectCast(_selectedItem, GridDataItem)
            Dim cell As TableCell = _gridDataItem("Download")
            Dim checkBox As CheckBox = DirectCast(cell.Controls(0), CheckBox)
            If checkBox.Checked Then
                SelectedItemList.Append(_gridDataItem.GetDataKeyValue("ID"))
                SelectedItemList.Append(",")
            End If
        Next
        newTabURLHiddenField.Value = Request.ApplicationPath + "/Administrator/RealEstate/Attachment/SelectedDownload/Temp/Office/" + Convert.ToString(ViewState("OfficeTempID")) + "/" + SelectedItemList.ToString


        OfficeAttachmentTempRadGrid.SelectedIndexes.Clear()

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "myFunction", "myFunction();", True)
    End Sub
End Class