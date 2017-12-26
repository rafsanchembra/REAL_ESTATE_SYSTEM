Imports System.IO
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Public Class FreeLandManagement
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
        _root3.Text = "Free Land"
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
        FreelandProvinceComboBox.ClearSelection()
        FreelandProvinceComboBox.Items.Clear()
        FreelandProvinceComboBox.DataBind()
        FreelandCityComboBox.ClearSelection()
        FreelandCityComboBox.Items.Clear()
        FreelandVillageComboBox.ClearSelection()
        FreelandVillageComboBox.Items.Clear()
        FreeLandNameRadTextBox.Text = ""
        FreeLandOfficalNameRadTextBox.Text = ""
        FreeLandCompanyNameRadTextBox.Text = ""
        FreeLandRentingPriceTextBox.Text = ""
        FreelandPlaceRadTExtBox.Text = ""
        FreelandMemoRadTextBox.Text = ""
        removeSession()
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        If Not Check_Name_Exists(FreeLandNameRadTextBox.Text.Trim) Then
            Exit Sub
        End If
        Dim _FreelandID
        Try
            Dim _newFreeLand As New APP_FreeLand
            With _newFreeLand
                .FreeLandName = FreeLandNameRadTextBox.Text.Trim
                .FreeLandOfficialName = FreeLandOfficalNameRadTextBox.Text.Trim
                .FreeLandCompanyName = FreeLandCompanyNameRadTextBox.Text.Trim
                .FreeLandRentingPrice = FreeLandRentingPriceTextBox.Text.Trim
                .FreeLandProvince = FreelandProvinceComboBox.SelectedValue
                .FreeLandCity = FreelandCityComboBox.SelectedValue
                .FreeLandVillage = FreelandVillageComboBox.SelectedValue
                .FreeLandPlace = FreelandPlaceRadTExtBox.Text.Trim
                .FreeLandMemo = FreelandMemoRadTextBox.Text.Trim
                .FreeLandAddedDate = Now
                .FreeLandAddedBy = Session("UserID")
            End With
            DB.APP_FreeLands.InsertOnSubmit(_newFreeLand)
            DB.SubmitChanges()

            _FreelandID = _newFreeLand.ID
            _newFreeLand = Nothing
            SaveTransactionAttachment(_FreelandID)
            freeLandradGrid.DataBind()
            ClearData()
            PopMsg.ShowSuccessMessage("data Inserted SucessFully")
        Catch ex As Exception
            PopMsg.ShowErrorMessage("Error Found On The System. Please Check Valid Fields.")
        End Try
    End Sub

    Private Sub SaveTransactionAttachment(_freeLandID As String)
        Dim AttachmentPath As String = "~/Attachments/Freeland/" + _freeLandID.ToString + "/"

        If Not Directory.Exists(Server.MapPath(AttachmentPath)) Then
            Directory.CreateDirectory(Server.MapPath(AttachmentPath))
        End If

        If Not FreeLandAttachmentUpload.UploadedFiles.Count = 0 Then
            Dim _targetFolder As String = Server.MapPath(AttachmentPath)

            Dim _count = 1

            For Each validFile As UploadedFile In FreeLandAttachmentUpload.UploadedFiles
                Dim _fileName As String =   _freeLandID + "-" + _count.ToString
                Dim FileToBeSaved As String = _fileName & validFile.GetExtension
                Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                If File.Exists(FullPath) Then
                    File.Delete(FullPath)
                End If

                validFile.SaveAs(FullPath, True)

                Try
                    Dim _newFreeLandAttachment As New APP_FreeLandAttachment
                    With _newFreeLandAttachment
                        .FreeLandID = _freeLandID
                        .FreeLandAttachmentName = FileToBeSaved
                        .FreeLandAttachment = AttachmentPath
                    End With
                    DB.APP_FreeLandAttachments.InsertOnSubmit(_newFreeLandAttachment)
                    DB.SubmitChanges()
                Catch ex As Exception
                    PopMsg.ShowErrorMessage("Error in File Uploading.")
                End Try

                _count = _count + 1
            Next
        End If


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

    Protected Sub RadAjaxManagerMain_AjaxRequest(sender As Object, e As Telerik.Web.UI.AjaxRequestEventArgs)
        If e.Argument = "Province" Then
            FreelandProvinceComboBox.Items.Clear()
            FreelandProvinceComboBox.ClearSelection()
            FreelandProvinceComboBox.DataBind()
        End If
    End Sub

    Protected Sub FreelandProvinceComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        FreelandCityComboBox.ClearSelection()
        FreelandCityComboBox.Items.Clear()
        FreelandCityComboBox.DataBind()

        FreelandVillageComboBox.ClearSelection()
        FreelandVillageComboBox.Items.Clear()
    End Sub

    Protected Sub FreelandCityComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        FreelandVillageComboBox.ClearSelection()
        FreelandVillageComboBox.Items.Clear()
        FreelandVillageComboBox.DataBind()
    End Sub

    Private Function Check_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_FreeLands Select sd.FreeLandName

            If _info.Contains(_Name) Then
                RadAjaxManagerMain.Alert("Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Protected Sub freeLandradGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_FreeLand") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub freeLandradGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "EditData"
                Dim _gridDataItem As GridDataItem = e.Item  ' To Get All The Data From Selected Row

                FreeLand_model.VisibleOnPageLoad = True
                FreeLand_model.NavigateUrl = "~/Forms/RealEstate/FreeLandManagement/FreeLandManagementWindow.aspx?ID=" + _gridDataItem("ID").Text
                RadWindowManager_modalPopup.Windows.Add(FreeLand_model)

            Case "Photos"
                Dim _gridDataItem As GridDataItem = e.Item

                FreeLand_model.VisibleOnPageLoad = True
                FreeLand_model.NavigateUrl = "~/Forms/RealEstate/FreeLandManagement/FreeLandManagementAttachmentWindow.aspx?ID=" + _gridDataItem("ID").Text
                RadWindowManager_modalPopup.Windows.Add(FreeLand_model)

                Exit Select
        End Select
    End Sub

End Class