Imports System.IO
Imports Telerik.Web.UI

Public Class FlatManagement
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SessionCreater()
            loadSiteMap()
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
        _root2.Text = "Real Estate"
        _root2.Value = "2"
        _root2.NavigateUrl = "~/Forms/Pages/RealEstate.aspx"
        _radSiteMap.Nodes.Add(_root2)

        Dim _root3 As New RadSiteMapNode
        _root3.Text = "Flat"
        _root3.Value = "3"
        _root3.Enabled = False
        _radSiteMap.Nodes.Add(_root3)
    End Sub
    Private Sub SessionCreater()
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)
        Session("UserID") = _currentUserID
    End Sub

    Private Sub removeSession()
        Session.Remove("UserID")
    End Sub

    Private Sub ClearData()
        FlatProvinceComboBox.ClearSelection()
        FlatProvinceComboBox.Items.Clear()
        FlatProvinceComboBox.DataBind()

        FlatCityComboBox.ClearSelection()
        FlatCityComboBox.Items.Clear()

        FlatVillageComboBox.ClearSelection()
        FlatVillageComboBox.Items.Clear()

        FlatNameRadTextBox.Text = ""
        FlatOfficalNameRadTextBox.Text = ""
        FlatCompanyNameRadTextBox.Text = ""
        FlatRentPriceRadTextBox.Text = ""
        FlatPlaceRadTExtBox.Text = ""
        FlatMemoRadTextBox.Text = ""

        FlatBathRoomTypeComboBox.ClearSelection()
        FlatBathRoomTypeComboBox.Items.Clear()
        FlatBathRoomTypeComboBox.DataBind()

        FlatRoomNoTextBox.Text = Nothing
        FlatBathroomNoTextBox.Text = Nothing


        removeSession()
    End Sub
    Protected Sub AddnewProvince_Click(sender As Object, e As EventArgs)
        AddBasicData_model.VisibleOnPageLoad = True
        AddBasicData_model.Height = 220
        AddBasicData_model.NavigateUrl = "~/Forms/RealEstate/AddProvinceWindow.aspx"
        RadWindowManager_modalPopup.Windows.Add(AddBasicData_model)
    End Sub

    Protected Sub AddnewCity_Click(sender As Object, e As EventArgs)
        AddBasicData_model.VisibleOnPageLoad = True
        AddBasicData_model.Height = 300
        AddBasicData_model.NavigateUrl = "~/Forms/RealEstate/AddNewCityWindow.aspx"
        RadWindowManager_modalPopup.Windows.Add(AddBasicData_model)
    End Sub

    Protected Sub addnewVillage_Click(sender As Object, e As EventArgs)
        AddBasicData_model.VisibleOnPageLoad = True
        AddBasicData_model.Height = 400
        AddBasicData_model.NavigateUrl = "~/Forms/RealEstate/AddNewVillagewindow.aspx"
        RadWindowManager_modalPopup.Windows.Add(AddBasicData_model)
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        If Not Check_Name_Exists() Then
            Exit Sub
        End If

        Dim _newFlatID
        Try
            Dim _newFlat As New APP_Flat
            With _newFlat
                .FlatName = FlatNameRadTextBox.Text.Trim
                .FlatOfficialName = FlatOfficalNameRadTextBox.Text.Trim
                .FlatCompanyName = FlatCompanyNameRadTextBox.Text.Trim
                .FlatRentingPrice = FlatRentPriceRadTextBox.Text.Trim
                .FlatProvince = FlatProvinceComboBox.SelectedValue
                .FlatCity = FlatCityComboBox.SelectedValue
                .FlatVillage = FlatVillageComboBox.SelectedValue
                .FlatPlace = FlatPlaceRadTExtBox.Text.Trim
                .FlatMemo = FlatMemoRadTextBox.Text.Trim
                .FlatRoomNumber = FlatRoomNoTextBox.Text.Trim
                .FlatBathroomNumber = FlatBathroomNoTextBox.Text.Trim
                .FlatBathroomType = FlatBathRoomTypeComboBox.SelectedValue
                .FlatAddedBy = Session("UserID")
                .FlatAddedDate = Now
            End With
            DB.APP_Flats.InsertOnSubmit(_newFlat)
            DB.SubmitChanges()

            _newFlatID = _newFlat.ID
            _newFlat = Nothing

            SaveTransactionAttachment(_newFlatID)
            ClearData()
            FlatradGrid.DataBind()
        Catch ex As Exception
            PopMsg.ShowErrorMessage("Error Found On The System. Please Contact The Administrator.")
        End Try
    End Sub

    Private Sub SaveTransactionAttachment(_flatID As String)
        
        Dim AttachmentPath As String = "~/Attachments/Flat/" + _flatID.ToString + "/"

        If Not Directory.Exists(Server.MapPath(AttachmentPath)) Then
            Directory.CreateDirectory(Server.MapPath(AttachmentPath))
        End If

        If Not FlatAttachmentUpload.UploadedFiles.Count = 0 Then
            Dim _targetFolder As String = Server.MapPath(AttachmentPath)
            Dim _count = 1
            For Each validFile As UploadedFile In FlatAttachmentUpload.UploadedFiles
                Dim _fileName As String = _flatID + "-" + _count.ToString
                Dim FileToBeSaved As String = _fileName & validFile.GetExtension
                Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                If File.Exists(FullPath) Then
                    File.Delete(FullPath)
                End If
                validFile.SaveAs(FullPath, True)
                Try
                    Dim _newFlatAttachment As New APP_FlatAttachment
                    With _newFlatAttachment
                        .FlatID = _flatID
                        .FlatAttachmentName = FileToBeSaved
                        .FlatAttachment = AttachmentPath
                    End With
                    DB.APP_FlatAttachments.InsertOnSubmit(_newFlatAttachment)
                    DB.SubmitChanges()
                Catch ex As Exception
                    PopMsg.ShowErrorMessage("Error in File Uploading.")
                End Try

                _count = _count + 1
            Next
        End If


    End Sub

    Protected Sub RadAjaxManagerMain_AjaxRequest(sender As Object, e As Telerik.Web.UI.AjaxRequestEventArgs)
        If e.Argument = "Province" Then
            FlatProvinceComboBox.Items.Clear()
            FlatProvinceComboBox.ClearSelection()
            FlatProvinceComboBox.DataBind()
        End If
    End Sub
    Protected Sub FlatProvinceComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        FlatCityComboBox.ClearSelection()
        FlatCityComboBox.Items.Clear()
        FlatCityComboBox.DataBind()

        FlatVillageComboBox.ClearSelection()
        FlatVillageComboBox.Items.Clear()
    End Sub
    Protected Sub FlatCityComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        FlatVillageComboBox.ClearSelection()
        FlatVillageComboBox.Items.Clear()
        FlatVillageComboBox.DataBind()
    End Sub
    Private Function Check_Name_Exists() As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Flats Select sd.FlatName
            If _info.Contains(FlatNameRadTextBox.Text.Trim) Then
                RadAjaxManagerMain.Alert("Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Protected Sub FlatradGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_Flat") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub FlatradGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "EditData"
                Dim _gridDataItem As GridDataItem = e.Item  ' To Get All The Data From Selected Row

                Flat_model.VisibleOnPageLoad = True
                Flat_model.NavigateUrl = "~/Forms/RealEstate/FlatManagement/FlatManagementWindow.aspx?ID=" + _gridDataItem("ID").Text
                RadWindowManager_modalPopup.Windows.Add(Flat_model)
            Case "Photos"
                Dim _gridDataItem As GridDataItem = e.Item

                Flat_model.VisibleOnPageLoad = True
                Flat_model.NavigateUrl = "~/Forms/RealEstate/FlatManagement/FlatManagementAttachmentWindow.aspx?ID=" + _gridDataItem("ID").Text
                RadWindowManager_modalPopup.Windows.Add(Flat_model)
                Exit Select
        End Select
    End Sub
End Class