Imports System.IO
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Public Class VillaManagement
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
        _root3.Text = "Villa"
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
        VillaProvinceComboBox.ClearSelection()
        VillaProvinceComboBox.Items.Clear()
        VillaProvinceComboBox.DataBind()

        VillaCityComboBox.ClearSelection()
        VillaCityComboBox.Items.Clear()

        VillaVillageComboBox.ClearSelection()
        VillaVillageComboBox.Items.Clear()

        VillaNameRadTextBox.Text = ""
        VillaOfficalNameRadTextBox.Text = ""
        VillaCompanyNameRadTextBox.Text = ""
        VillaRentPriceRadTextBox.Text = ""
        VillaMemoRadTextBox.Text = ""
        VillaPlaceRadTExtBox.Text = ""

        VillaBathRoomTypeComboBox.ClearSelection()
        VillaBathRoomTypeComboBox.Items.Clear()
        VillaBathRoomTypeComboBox.DataBind()

        VillaRoomNoTextBox.Text = Nothing
        VillaBathroomNoTextBox.Text = Nothing
        VillaFloorNoTextBox.Text = Nothing

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

        Dim _newVillaID

        Try
            Dim _newVilla As New APP_Villa
            With _newVilla
                .VillaName = VillaNameRadTextBox.Text.Trim
                .VillaOfficialName = VillaOfficalNameRadTextBox.Text.Trim
                .VillaCompanyName = VillaOfficalNameRadTextBox.Text.Trim
                .VillaRentingPrice = VillaRentPriceRadTextBox.Text.Trim
                .VillaProvince = VillaProvinceComboBox.SelectedValue
                .VillaCity = VillaCityComboBox.SelectedValue
                .VillaVillage = VillaVillageComboBox.SelectedValue
                .VillaPlace = VillaPlaceRadTExtBox.Text.Trim
                .VillaMemo = VillaMemoRadTextBox.Text.Trim
                .VillaRoomNumber = VillaRoomNoTextBox.Text.Trim
                .VillaBathroomNumber = VillaBathroomNoTextBox.Text.Trim
                .VillaFloorNumber = VillaFloorNoTextBox.Text.Trim
                .VillaBathroomType = VillaBathRoomTypeComboBox.SelectedValue
                .VillaAddedBy = Session("UserID")
                .VillaAddedDate = Now
            End With
            DB.APP_Villas.InsertOnSubmit(_newVilla)
            DB.SubmitChanges()

            _newVillaID = _newVilla.ID
            _newVilla = Nothing
            SaveTransactionAttachment(_newVillaID)
            VillaradGrid.DataBind()
            ClearData()
        Catch ex As Exception
            PopMsg.ShowErrorMessage("Error Found On The System. Please Contact The Administrator.")
        End Try
    End Sub

    Private Sub SaveTransactionAttachment(_VillaID As String)
     
        Dim AttachmentPath As String = "~/Attachments/Villa/" + _VillaID + "/"

        If Not Directory.Exists(Server.MapPath(AttachmentPath)) Then
            Directory.CreateDirectory(Server.MapPath(AttachmentPath))
        End If

        If Not VillaAttachmentUpload.UploadedFiles.Count = 0 Then
            Dim _targetFolder As String = Server.MapPath(AttachmentPath)
            Dim _count = 1
            For Each validFile As UploadedFile In VillaAttachmentUpload.UploadedFiles

                Dim filename As String = _VillaID + "-" + _count.ToString
                Dim FileToBeSaved As String = filename & validFile.GetExtension
                Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                If File.Exists(FullPath) Then
                    File.Delete(FullPath)
                End If
                validFile.SaveAs(FullPath, True)
                Try
                    Dim _newVillaAttachment As New APP_VillaAttachment
                    With _newVillaAttachment
                        .VillaID = _VillaID
                        .VillaAttachmentName = FileToBeSaved
                        .VillaAttachment = AttachmentPath
                    End With
                    DB.APP_VillaAttachments.InsertOnSubmit(_newVillaAttachment)
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
            VillaProvinceComboBox.Items.Clear()
            VillaProvinceComboBox.ClearSelection()
            VillaProvinceComboBox.DataBind()
        End If
    End Sub

    Protected Sub VillaProvinceComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        VillaCityComboBox.ClearSelection()
        VillaCityComboBox.Items.Clear()
        VillaCityComboBox.DataBind()

        VillaVillageComboBox.ClearSelection()
        VillaVillageComboBox.Items.Clear()
    End Sub

    Protected Sub VillaCityComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        VillaVillageComboBox.ClearSelection()
        VillaVillageComboBox.Items.Clear()
        VillaVillageComboBox.DataBind()
    End Sub

    Private Function Check_Name_Exists() As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Villas Select sd.VillaName
            If _info.Contains(VillaNameRadTextBox.Text.Trim) Then
                RadAjaxManagerMain.Alert("Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function



    Protected Sub VillaradGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "EditData"
                Dim _gridDataItem As GridDataItem = e.Item  ' To Get All The Data From Selected Row
                Villa_model.VisibleOnPageLoad = True
                Villa_model.NavigateUrl = "~/Forms/RealEstate/VillaManagement/VillaManagementWindow.aspx?ID=" + _gridDataItem("ID").Text
                RadWindowManager_modalPopup.Windows.Add(Villa_model)

            Case "Photos"
                Dim _gridDataItem As GridDataItem = e.Item

                Villa_model.VisibleOnPageLoad = True
                Villa_model.NavigateUrl = "~/Forms/RealEstate/VillaManagement/VillaManagementAttachmentWindow.aspx?ID=" + _gridDataItem("ID").Text
                RadWindowManager_modalPopup.Windows.Add(Villa_model)
                Exit Select
        End Select
    End Sub


    Protected Sub VillaradGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_Villa") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub
End Class