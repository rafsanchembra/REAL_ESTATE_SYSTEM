Imports Telerik.Web.UI
Imports System.IO

Public Class BuildingUpdateManagement
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
    Private Sub LoadData()
        Dim _mfBuildingInfo = (From sd In DB.APP_MultiFloorBuildings Where sd.ID = Convert.ToInt64(Page.RouteData.Values("ID")) Select sd).SingleOrDefault
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
            ViewState("BuildingID") = _mfBuildingInfo.ID
            ViewState("BuildingName") = _mfBuildingInfo.MFBuildingName
        End If

        Dim _flatCount = (From sd In DB.APP_MultiFloorBuildingFlats Where sd.MultiFloorBuildingID = Convert.ToInt64(Page.RouteData.Values("ID")) Select sd).ToList
        BuildingFlatNoRadTextBox.MinValue = _flatCount.Count
        Dim _shopCount = (From sd In DB.APP_MultiFloorBuildingShops Where sd.MultiFloorBuildingID = Convert.ToInt64(Page.RouteData.Values("ID")) Select sd).ToList
        BuildingShopNoRadTextBox.MinValue = _shopCount.Count
        Dim _officeCount = (From sd In DB.APP_MultiFloorBuildingOffices Where sd.MultiFloorBuildingID = Convert.ToInt64(Page.RouteData.Values("ID")) Select sd).ToList
        BuildingOfficeNoTextBox.MinValue = _officeCount.Count

    End Sub

#Region "General"
    Protected Sub BuildingAddressLink_Click(sender As Object, e As EventArgs)
        Building_modal.Width = 1065
        Building_modal.Height = 785
        Building_modal.NavigateUrl = "~/MapLocator"
        Building_modal.VisibleOnPageLoad = True
        RadWindowManager_modalPopup.Windows.Add(Building_modal)
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


    Protected Sub DownloadButton_Click(sender As Object, e As EventArgs)
        newTabURLHiddenField.Value = Request.ApplicationPath + "/Administrator/RealEstate/Attachment/Download/Main/General/" + Convert.ToString(ViewState("BuildingID"))
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "myFunction", "myFunction();", True)
    End Sub

    Protected Sub SelectDownloadButton_Click(sender As Object, e As EventArgs)

        Dim Button As RadButton = DirectCast(sender, RadButton)

        Dim SelectedItemList As New StringBuilder

        For Each _selectedItem As GridItem In BuildingAttachmentRadGrid.MasterTableView.Items
            Dim _gridDataItem As GridDataItem = DirectCast(_selectedItem, GridDataItem)
            Dim cell As TableCell = _gridDataItem("Download")
            Dim checkBox As CheckBox = DirectCast(cell.Controls(0), CheckBox)
            If checkBox.Checked Then
                SelectedItemList.Append(_gridDataItem.GetDataKeyValue("ID"))
                SelectedItemList.Append(",")
            End If
        Next
        newTabURLHiddenField.Value = Request.ApplicationPath + "/Administrator/RealEstate/Attachment/SelectedDownload/Main/General/" + Convert.ToString(ViewState("BuildingID")) + "/" + SelectedItemList.ToString


        BuildingAttachmentRadGrid.SelectedIndexes.Clear()

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "myFunction", "myFunction();", True)
    End Sub

    Protected Sub BuildingAttachmentRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_BuildingAttachments") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub BuildingAttachmentRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "InitInsert"
                e.Canceled = True

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/Update/AttachmentWindow/Add/General/" + Page.RouteData.Values("ID").ToString + "/NULL"

                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/Update/AttachmentWindow/Edit/General/" + Page.RouteData.Values("ID").ToString + "/" + _gridDataItem("ID").Text

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

    Protected Sub FlatRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_Flats") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub
    Protected Sub FlatRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)

        Select Case (e.CommandName.ToString)
            Case "Delete"

                Dim _gridDataItem As GridDataItem = e.Item
                Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachments Where sd.BuildingFlatID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).ToList
                For Each _items In _flatAttachment

                    If File.Exists(Server.MapPath(_items.BuildingAttachment)) Then
                        File.Delete(Server.MapPath(_items.BuildingAttachment))
                    End If
                    DB.APP_MultiFloorBuildingFlatAttachments.DeleteOnSubmit(_items)
                    DB.SubmitChanges()
                Next
                Dim _flat = (From sd In DB.APP_MultiFloorBuildingFlats Where sd.ID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).SingleOrDefault
                DB.APP_MultiFloorBuildingFlats.DeleteOnSubmit(_flat)
                DB.SubmitChanges()
                Exit Sub
        End Select
    End Sub
    Protected Sub FlatAttachmentRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)

        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_FlatAttachments") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub FlatAttachmentRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "InitInsert"
                e.Canceled = True

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/Update/AttachmentWindow/Add/Flat/" + Page.RouteData.Values("ID").ToString + "/NULL"
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

                Building_modal.Width = 550
                Building_modal.Height = 292
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/Update/AttachmentWindow/Edit/Flat/" + Page.RouteData.Values("ID").ToString + "/" + _gridDataItem("ID").Text

                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub


            Case "View"

                Exit Sub
        End Select
    End Sub
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
            If Not Flat_Name_Exists(FlatNameTextBox.Text.Trim) Then
                Exit Sub
            End If

            If Not Flat_Number_Exists(FlatNumberTextBox.Text.Trim) Then
                Exit Sub
            End If

            Dim _flatCount = (From sd In DB.APP_MultiFloorBuildingFlats Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID")) Select sd).ToList
            If BuildingFlatNoRadTextBox.Text.Trim <= _flatCount.Count Then
                PopMsg.ShowErrorMessage("You Cannot Add New Flat Under This Building. Please Update Building Flat Count To Add New Flat..!!")
                Exit Sub
            End If

            Dim _flatID As Long

            Dim _flatInfo As New APP_MultiFloorBuildingFlat
            With _flatInfo
                .MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID"))
                .FlatFloorNo = FlatFloorComboBox.SelectedValue
                .FlatName = FlatNameTextBox.Text.Trim
                .FlatNumber = FlatNumberTextBox.Text.Trim
                .FlatDescription = FlatDescriptionEditor.Content
            End With
            DB.APP_MultiFloorBuildingFlats.InsertOnSubmit(_flatInfo)
            DB.SubmitChanges()
            _flatID = _flatInfo.ID
            _flatInfo = Nothing

            Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachments Where sd.UserID = Session("UserID") Select sd).ToList

            For Each _items In _flatAttachment
                Dim _destination = "~/Attachments/Building/" + ViewState("BuildingID").ToString + "/Flat/" + _flatID.ToString + "/"

                If Not Directory.Exists(Server.MapPath(_destination)) Then
                    Directory.CreateDirectory(Server.MapPath(_destination))
                End If

                Dim _destinationPath = "~/Attachments/Building/" + ViewState("BuildingID").ToString + "/Flat/" + _flatID.ToString + "/" + Path.GetFileName(Server.MapPath(_items.BuildingAttachment))

                File.Move(Server.MapPath(_items.BuildingAttachment), Server.MapPath(_destinationPath))
                _items.UserID = Nothing
                _items.BuildingAttachment = _destinationPath
                _items.BuildingFlatID = _flatID
                DB.SubmitChanges()
            Next

            ClearFlatData()
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

    Private Function Flat_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingFlats Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID")) Select sd.FlatName

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
            Dim _info = From sd In DB.APP_MultiFloorBuildingFlats Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID")) Select sd.FlatNumber

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Flat Number Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Sub ClearFlatData()
        FlatNameTextBox.Text = ""
        FlatNumberTextBox.Text = ""
        FlatDescriptionEditor.Content = ""
        FlatAttachmentRadGrid.DataBind()
        FlatRadGrid.DataBind()
    End Sub

#End Region

#Region "Shop"
 
    Protected Sub ShopRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)

        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_Shops") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If

    End Sub

    Protected Sub ShopRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)

        Select Case (e.CommandName.ToString)
            Case "Delete"

                Dim _gridDataItem As GridDataItem = e.Item
                Dim _shopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachments Where sd.BuildingShopID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).ToList
                For Each _items In _shopAttachment

                    If File.Exists(Server.MapPath(_items.BuildingAttachment)) Then
                        File.Delete(Server.MapPath(_items.BuildingAttachment))
                    End If
                    DB.APP_MultiFloorBuildingShopAttachments.DeleteOnSubmit(_items)
                    DB.SubmitChanges()
                Next
                Dim _shop = (From sd In DB.APP_MultiFloorBuildingShops Where sd.ID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).SingleOrDefault
                DB.APP_MultiFloorBuildingShops.DeleteOnSubmit(_shop)
                DB.SubmitChanges()
                Exit Sub
        End Select
    End Sub

    Protected Sub ShopAttachmentRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_ShopAttachments") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub ShopAttachmentRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)

        Select Case Convert.ToString(e.CommandName)
            Case "InitInsert"
                e.Canceled = True

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/Update/AttachmentWindow/Add/Shop/" + Page.RouteData.Values("ID").ToString + "/NULL"
                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item

                Building_modal.Width = 550
                Building_modal.Height = 292
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/Update/AttachmentWindow/Edit/Shop/" + Page.RouteData.Values("ID").ToString + "/" + _gridDataItem("ID").Text

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
            If Not Shop_Name_Exists(ShopNameTextBox.Text.Trim) Then
                Exit Sub
            End If

            If Not Shop_Number_Exists(ShopNumberTextBox.Text.Trim) Then
                Exit Sub
            End If

            Dim _ShopCount = (From sd In DB.APP_MultiFloorBuildingShops Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID")) Select sd).ToList
            If BuildingShopNoRadTextBox.Text.Trim <= _ShopCount.Count Then
                PopMsg.ShowErrorMessage("You Cannot Add New Shop Under This Building. Please Update Building Shop Count To Add New Shop..!!")
                Exit Sub
            End If

            Dim _ShopID As Long

            Dim _ShopInfo As New APP_MultiFloorBuildingShop
            With _ShopInfo
                .MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID"))
                .ShopFloorNo = ShopFloorComboBox.SelectedValue
                .ShopName = ShopNameTextBox.Text.Trim
                .ShopNumber = ShopNumberTextBox.Text.Trim
                .ShopDescription = ShopDescriptionEditor.Content
            End With
            DB.APP_MultiFloorBuildingShops.InsertOnSubmit(_ShopInfo)
            DB.SubmitChanges()
            _ShopID = _ShopInfo.ID
            _ShopInfo = Nothing


            Dim _ShopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachments Where sd.UserID = Session("UserID") Select sd).ToList

            For Each _items In _ShopAttachment
                Dim _destination = "~/Attachments/Building/" + ViewState("BuildingID").ToString + "/Shop/" + _ShopID.ToString + "/"

                If Not Directory.Exists(Server.MapPath(_destination)) Then
                    Directory.CreateDirectory(Server.MapPath(_destination))
                End If

                Dim _destinationPath = "~/Attachments/Building/" + ViewState("BuildingID").ToString + "/Shop/" + _ShopID.ToString + "/" + Path.GetFileName(Server.MapPath(_items.BuildingAttachment))

                File.Move(Server.MapPath(_items.BuildingAttachment), Server.MapPath(_destinationPath))
                _items.UserID = Nothing
                _items.BuildingAttachment = _destinationPath
                _items.BuildingShopID = _ShopID
                DB.SubmitChanges()
            Next

            ClearShopData()
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

   
    Private Function Shop_Number_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingShops Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID")) Select sd.ShopNumber

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Shop Number Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Function Shop_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingShops Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID")) Select sd.ShopName

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Shop Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Sub ClearShopData()
        ShopNameTextBox.Text = ""
        ShopNumberTextBox.Text = ""
        ShopDescriptionEditor.Content = ""
        ShopAttachmentRadGrid.DataBind()
        ShopRadGrid.DataBind()
    End Sub
  
  
#End Region

#Region "Office"

   
    Protected Sub OfficeSubmitButton_Click(sender As Object, e As EventArgs)
        Try
            If Not Office_Name_Exists(OfficeNameTextBox.Text.Trim) Then
                Exit Sub
            End If

            If Not Office_Number_Exists(OfficeNumberTextBox.Text.Trim) Then
                Exit Sub
            End If

            Dim _OfficeCount = (From sd In DB.APP_MultiFloorBuildingOffices Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID")) Select sd).ToList
            If BuildingOfficeNoTextBox.Text.Trim <= _OfficeCount.Count Then
                PopMsg.ShowErrorMessage("You Cannot Add New Office Under This Building. Please Update Building Office Count To Add New Office..!!")
                Exit Sub
            End If

            Dim _OfficeID As Long

            Dim _OfficeInfo As New APP_MultiFloorBuildingOffice
            With _OfficeInfo
                .MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID"))
                .OfficeFloorNo = OfficeFloorComboBox.SelectedValue
                .OfficeName = OfficeNameTextBox.Text.Trim
                .OfficeNumber = OfficeNumberTextBox.Text.Trim
                .OfficeDescription = OfficeDescriptionEditor.Content
            End With
            DB.APP_MultiFloorBuildingOffices.InsertOnSubmit(_OfficeInfo)
            DB.SubmitChanges()
            _OfficeID = _OfficeInfo.ID
            _OfficeInfo = Nothing


            Dim _OfficeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachments Where sd.UserID = Session("UserID") Select sd).ToList

            For Each _items In _OfficeAttachment
                Dim _destination = "~/Attachments/Building/" + ViewState("BuildingID").ToString + "/Office/" + _OfficeID.ToString + "/"

                If Not Directory.Exists(Server.MapPath(_destination)) Then
                    Directory.CreateDirectory(Server.MapPath(_destination))
                End If

                Dim _destinationPath = "~/Attachments/Building/" + ViewState("BuildingID").ToString + "/Office/" + _OfficeID.ToString + "/" + Path.GetFileName(Server.MapPath(_items.BuildingAttachment))

                File.Move(Server.MapPath(_items.BuildingAttachment), Server.MapPath(_destinationPath))
                _items.UserID = Nothing
                _items.BuildingAttachment = _destinationPath
                _items.BuildingOfficeID = _OfficeID
                DB.SubmitChanges()
            Next

            ClearOfficeData()
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub


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

    Protected Sub OfficeRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)

        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_Offices") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub


    Protected Sub OfficeRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case (e.CommandName.ToString)
            Case "Delete"
                Dim _gridDataItem As GridDataItem = e.Item
                Dim _OfficeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachments Where sd.BuildingOfficeID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).ToList
                For Each _items In _OfficeAttachment

                    If File.Exists(Server.MapPath(_items.BuildingAttachment)) Then
                        File.Delete(Server.MapPath(_items.BuildingAttachment))
                    End If
                    DB.APP_MultiFloorBuildingOfficeAttachments.DeleteOnSubmit(_items)
                    DB.SubmitChanges()
                Next
                Dim _Office = (From sd In DB.APP_MultiFloorBuildingOffices Where sd.ID = Convert.ToInt64(_gridDataItem("ID").Text) Select sd).SingleOrDefault
                DB.APP_MultiFloorBuildingOffices.DeleteOnSubmit(_Office)
                DB.SubmitChanges()
                Exit Sub
        End Select
    End Sub

    Private Function Office_Number_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingOffices Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID")) Select sd.OfficeNumber

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Office Number Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Function Office_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True
        Try
            Dim _info = From sd In DB.APP_MultiFloorBuildingOffices Where sd.MultiFloorBuildingID = Convert.ToInt64(ViewState("BuildingID")) Select sd.OfficeName

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Office Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

   
    Protected Sub OfficeAttachmentRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)

        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_OfficeAttachments") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub OfficeAttachmentRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "InitInsert"
                e.Canceled = True

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/Update/AttachmentWindow/Add/Office/" + Page.RouteData.Values("ID").ToString + "/NULL"
                Building_modal.VisibleOnPageLoad = True
                RadWindowManager_modalPopup.Windows.Add(Building_modal)
                Exit Sub
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item

                Building_modal.Width = 1110
                Building_modal.Height = 1035
                Building_modal.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement/Update/AttachmentWindow/Edit/Office/" + Page.RouteData.Values("ID").ToString + "/" + _gridDataItem("ID").Text

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

    Private Sub ClearOfficeData()
        OfficeNameTextBox.Text = ""
        OfficeNumberTextBox.Text = ""
        OfficeDescriptionEditor.Content = ""
        OfficeAttachmentRadGrid.DataBind()
        OfficeRadGrid.DataBind()
    End Sub
#End Region

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        Try

            If BuildingFlatNoRadTextBox.Value < FlatRadGrid.Items.Count Then
                PopMsg.ShowErrorMessage("You Have Added " + (BuildingFlatNoRadTextBox.Value - FlatRadGrid.Items.Count) + " Flat More Than Flat Count Specified.")
                Exit Sub
            ElseIf BuildingShopNoRadTextBox.Value < ShopRadGrid.Items.Count Then
                PopMsg.ShowErrorMessage("You Have Added " + (BuildingShopNoRadTextBox.Value - ShopRadGrid.Items.Count) + " Shop More Than Shop Count Specified.")
                Exit Sub
            ElseIf BuildingOfficeNoTextBox.Value < OfficeRadGrid.Items.Count Then
                PopMsg.ShowErrorMessage("You Have Added " + (BuildingOfficeNoTextBox.Value - OfficeRadGrid.Items.Count) + " Office More Than Office Count Specified.")
                Exit Sub
            End If


            Dim _mfBuildingInfo = (From sd In DB.APP_MultiFloorBuildings Where sd.ID = Convert.ToInt64(ViewState("BuildingID")) Select sd).SingleOrDefault

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

            End If

            Response.Redirect("~/Administrator/RealEstate/BuildingManagement/List")

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

   
End Class