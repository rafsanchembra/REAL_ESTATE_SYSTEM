Imports System.IO
Imports Telerik.Web.UI

Public Class FreeLandManagementWindow
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            LoadData()
            SessionCreater()
        End If

    End Sub

    Private Sub LoadData()
        Dim _freeLandInfo = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault

        EditFreeLandNameRadTextBox.Text = _freeLandInfo.FreeLandName
        EditFreeLandOfficalNameRadTextBox.DisplayText = _freeLandInfo.FreeLandOfficialName
        EditFreeLandCompanyNameRadTextBox.Text = _freeLandInfo.FreeLandCompanyName
        EditFreeLandRentingPriceTextBox.Text = _freeLandInfo.FreeLandRentingPrice
        EditFreeLandProvinceComboBox.SelectedValue = _freeLandInfo.FreeLandProvince

        EditFreeLandCityComboBox.DataBind()
        EditFreeLandCityComboBox.SelectedValue = _freeLandInfo.FreeLandCity

        EditFreeLandVillageComboBox.DataBind()
        EditFreeLandVillageComboBox.SelectedValue = _freeLandInfo.FreeLandVillage

        EditFreeLandPlaceRadTExtBox.Text = _freeLandInfo.FreeLandPlace
        EditFreeLandMemoRadTextBox.Text = _freeLandInfo.FreeLandMemo



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

    Private Sub SessionCreater()
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)
        Session("UserID") = _currentUserID
        Session("OldFreeLandName") = EditFreeLandNameRadTextBox.Text.Trim
        Session("OldFreeLandOfficalName") = EditFreeLandOfficalNameRadTextBox.Text.Trim
        Session("OldFreeLandCompanyName") = EditFreeLandCompanyNameRadTextBox.Text.Trim
        Session("OldFreeLandRentingPrice") = EditFreeLandRentingPriceTextBox.Text.Trim
        Session("OldFreeLandProvince") = EditFreeLandProvinceComboBox.Text.Trim
        Session("OldFreeLandCity") = EditFreeLandCityComboBox.Text.Trim
        Session("OldFreeLandVillage") = EditFreeLandVillageComboBox.Text.Trim
        Session("OldFreeLandPlace") = EditFreeLandPlaceRadTExtBox.Text.Trim
        Session("OldFreeLandMemo") = EditFreeLandMemoRadTextBox.Text.Trim


    End Sub

    Private Sub removeSession()
        Session.Remove("UserID")
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)

        Dim _oldFreelandName As String = Session("OldFreeLandName")
        Dim _oldFreelandOfficalName As String = Session("OldFreeLandOfficalName")
        Dim _oldFreelandCompanyName As String = Session("OldFreeLandCompanyName")
        Dim _oldFreelandRentingPrice As Integer = Session("OldFreeLandRentingPrice")
        Dim _oldFreelandProvince As String = Session("OldFreeLandProvince")
        Dim _oldFreelandCity As String = Session("OldFreeLandCity")
        Dim _oldFreelandVillage As String = Session("OldFreeLandVillage")
        Dim _oldFreelandPlace As String = Session("OldFreeLandPlace")
        Dim _oldFreelandMemo As String = Session("OldFreeLandMemo")

        Try

            If Not _oldFreelandName = EditFreeLandNameRadTextBox.Text.Trim Then
                If Check_Name_Exists(EditFreeLandNameRadTextBox.Text.Trim) Then
                    Dim _updateFreeland = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                    With _updateFreeland
                        .FreeLandName = EditFreeLandNameRadTextBox.Text.Trim
                    End With
                    DB.SubmitChanges()
                Else
                    Exit Sub
                End If
            End If

            If Not _oldFreelandOfficalName = EditFreeLandOfficalNameRadTextBox.Text.Trim Then
                Dim _updateFreeland = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFreeland
                    .FreeLandOfficialName = EditFreeLandOfficalNameRadTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFreelandCompanyName = EditFreeLandCompanyNameRadTextBox.Text.Trim Then
                Dim _updateFreeland = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFreeland
                    .FreeLandCompanyName = EditFreeLandCompanyNameRadTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFreelandRentingPrice = EditFreeLandRentingPriceTextBox.Value Then
                Dim _updateFreeland = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFreeland
                    .FreeLandRentingPrice = EditFreeLandRentingPriceTextBox.Value
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFreelandProvince = EditFreeLandProvinceComboBox.SelectedValue Then
                Dim _updateFreeland = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFreeland
                    .FreeLandProvince = EditFreeLandProvinceComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFreelandCity = EditFreeLandCityComboBox.SelectedValue Then
                Dim _updateFreeland = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFreeland
                    .FreeLandCity = EditFreeLandCityComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFreelandVillage = EditFreeLandVillageComboBox.SelectedValue Then
                Dim _updateFreeland = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFreeland
                    .FreeLandVillage = EditFreeLandVillageComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFreelandPlace = EditFreeLandPlaceRadTExtBox.Text.Trim Then
                Dim _updateFreeland = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFreeland
                    .FreeLandPlace = EditFreeLandPlaceRadTExtBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFreelandMemo = EditFreeLandMemoRadTextBox.Text.Trim Then
                Dim _updateFreeland = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFreeland
                    .FreeLandMemo = EditFreeLandMemoRadTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            Dim _freelandId As String
            Dim _updateFreelandadded = (From sd In DB.APP_FreeLands Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
            With _updateFreelandadded
                .FreeLandUpdatedBy = Session("UserID")
                .FreeLandUpdatedDate = Now
                _freelandId = .ID
            End With
            DB.SubmitChanges()
            SaveTransactionAttachment(_freelandId)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(System.Web.UI.Page), "Script", "CloseAndRebind();", True)

        Catch ex As Exception

        End Try
    End Sub

    Private Sub SaveTransactionAttachment(_freeLandID As String)
        Dim AttachmentPath As String = "~/Attachments/Freeland/" + _freeLandID.ToString + "/"

        If Not Directory.Exists(Server.MapPath(AttachmentPath)) Then
            Directory.CreateDirectory(Server.MapPath(AttachmentPath))
        End If

        If Not EditFreeLandAttachmentUpload.UploadedFiles.Count = 0 Then
            Dim _targetFolder As String = Server.MapPath(AttachmentPath)

            Dim _count = 1

            For Each validFile As UploadedFile In EditFreeLandAttachmentUpload.UploadedFiles
                Dim _fileName As String = _freeLandID + "-Edit-" + _count.ToString
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


    Protected Sub RadAjaxManagerMain_AjaxRequest(sender As Object, e As Telerik.Web.UI.AjaxRequestEventArgs)
        If e.Argument = "Province" Then
            EditFreeLandProvinceComboBox.Items.Clear()
            EditFreeLandProvinceComboBox.ClearSelection()
            EditFreeLandProvinceComboBox.DataBind()
        End If
    End Sub
    Protected Sub FreelandProvinceComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        EditFreeLandCityComboBox.ClearSelection()
        EditFreeLandCityComboBox.Items.Clear()
        EditFreeLandCityComboBox.DataBind()

        EditFreeLandVillageComboBox.ClearSelection()
        EditFreeLandVillageComboBox.Items.Clear()
    End Sub
    Protected Sub FreelandCityComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        EditFreeLandVillageComboBox.ClearSelection()
        EditFreeLandVillageComboBox.Items.Clear()
        EditFreeLandVillageComboBox.DataBind()
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

    Protected Sub FreeLandUploadedLink_Click(sender As Object, e As EventArgs)
        Dim _freelanduploadedInfo = (From sd In DB.APP_FreeLandAttachments Where sd.FreeLandID = Convert.ToInt64(Request.QueryString("ID"))).FirstOrDefault
        If _freelanduploadedInfo IsNot Nothing Then
            ImageView_model.VisibleOnPageLoad = True
            ImageView_model.NavigateUrl = "~/Forms/RealEstate/FreeLandManagement/FreeLandManagementAttachmentWindow.aspx?ID=" + Request.QueryString("ID")
            RadWindowManager_modalPopup.Windows.Add(ImageView_model)
        Else
            PopMsg.ShowErrorMessage("No image To load")
        End If
    End Sub
End Class
