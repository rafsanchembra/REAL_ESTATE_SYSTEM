Imports System.IO
Imports Telerik.Web.UI

Public Class VillaManagementWindow
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            LoadData()
            SessionCreater()
        End If
    End Sub
    Private Sub LoadData()
        Dim _VillaInfo = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault

        VillaNameRadTextBox.Text = _VillaInfo.VillaName
        VillaOfficalNameRadTextBox.DisplayText = _VillaInfo.VillaOfficialName
        VillaCompanyNameRadTextBox.Text = _VillaInfo.VillaCompanyName
        VillaRentPriceRadTextBox.Value = _VillaInfo.VillaRentingPrice
        VillaProvinceComboBox.SelectedValue = _VillaInfo.VillaProvince

        VillaCityComboBox.DataBind()
        VillaCityComboBox.SelectedValue = _VillaInfo.VillaCity

        VillaVillageComboBox.DataBind()
        VillaVillageComboBox.SelectedValue = _VillaInfo.VillaVillage

        VillaPlaceRadTExtBox.Text = _VillaInfo.VillaPlace
        VillaMemoRadTextBox.Text = _VillaInfo.VillaMemo
        VillaRoomNoTextBox.Text = _VillaInfo.VillaRoomNumber
        VillaBathroomNoTextBox.Text = _VillaInfo.VillaBathroomNumber
        VillaFloorNoTextBox.Text = _VillaInfo.VillaFloorNumber
        VillaBathRoomTypeComboBox.SelectedValue = _VillaInfo.VillaBathroomType
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
        Session("OldVillaName") = VillaNameRadTextBox.Text.Trim
        Session("OldVillaOfficalName") = VillaOfficalNameRadTextBox.Text.Trim
        Session("OldVillaCompanyName") = VillaCompanyNameRadTextBox.Text.Trim
        Session("OldVillaRentingPrice") = VillaRentPriceRadTextBox.Value
        Session("OldVillaProvince") = VillaProvinceComboBox.Text.Trim
        Session("OldVillaCity") = VillaCityComboBox.Text.Trim
        Session("OldVillaVillage") = VillaVillageComboBox.Text.Trim
        Session("OldVillaPlace") = VillaPlaceRadTExtBox.Text.Trim
        Session("OldVillaMemo") = VillaMemoRadTextBox.Text.Trim
        Session("OldVillaRoomNo") = VillaRoomNoTextBox.Text.Trim
        Session("OldVillaBathNo") = VillaBathroomNoTextBox.Text.Trim
        Session("OldVillaBathType") = VillaBathRoomTypeComboBox.SelectedValue
        Session("OldVillaFloorNo") = VillaFloorNoTextBox.Text.Trim


    End Sub

    Private Sub removeSession()
        Session.Remove("UserID")
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)

        Dim _oldVillaName As String = Session("OldVillaName")
        Dim _oldVillaOfficalName As String = Session("OldVillaOfficalName")
        Dim _oldVillaCompanyName As String = Session("OldVillaCompanyName")
        Dim _oldVillaRentingPrice As Integer = Session("OldVillaRentingPrice")
        Dim _oldVillaProvince As String = Session("OldVillaProvince")
        Dim _oldVillaCity As String = Session("OldVillaCity")
        Dim _oldVillaVillage As String = Session("OldVillaVillage")
        Dim _oldVillaPlace As String = Session("OldVillaPlace")
        Dim _oldVillaMemo As String = Session("OldVillaMemo")
        Dim _oldVillaRoomNo As String = Session("OldVillaRoomNo")
        Dim _oldVillaBathNo As String = Session("OldVillaBathNo")
        Dim _oldVillaBathtype As String = Session("OldVillaBathType")
        Dim _oldVillaFloorNo As String = Session("OldVillaFloorNo")

        Try

            If Not _oldVillaName = VillaNameRadTextBox.Text.Trim Then
                If Check_Name_Exists(VillaNameRadTextBox.Text.Trim) Then
                    Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                    With _updateVilla
                        .VillaName = VillaNameRadTextBox.Text.Trim
                    End With
                    DB.SubmitChanges()
                Else
                    Exit Sub
                End If
            End If

            If Not _oldVillaOfficalName = VillaOfficalNameRadTextBox.Text.Trim Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaOfficialName = VillaOfficalNameRadTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaCompanyName = VillaCompanyNameRadTextBox.Text.Trim Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaCompanyName = VillaCompanyNameRadTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaRentingPrice = VillaRentPriceRadTextBox.Value Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaRentingPrice = VillaRentPriceRadTextBox.Value
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaProvince = VillaProvinceComboBox.SelectedValue Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaProvince = VillaProvinceComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaCity = VillaCityComboBox.SelectedValue Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaCity = VillaCityComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaVillage = VillaVillageComboBox.SelectedValue Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaVillage = VillaVillageComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaPlace = VillaPlaceRadTExtBox.Text.Trim Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaPlace = VillaPlaceRadTExtBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaMemo = VillaMemoRadTextBox.Text.Trim Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaMemo = VillaMemoRadTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaRoomNo = VillaRoomNoTextBox.Text.Trim Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaRoomNumber = VillaRoomNoTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaBathNo = VillaBathroomNoTextBox.Text.Trim Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaBathroomNumber = VillaBathroomNoTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaBathtype = VillaBathRoomTypeComboBox.SelectedValue Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaBathroomType = VillaBathRoomTypeComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If

            If Not _oldVillaFloorNo = VillaFloorNoTextBox.Text.Trim Then
                Dim _updateVilla = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateVilla
                    .VillaFloorNumber = VillaFloorNoTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            Dim _villaId As String
            Dim _updateVillaadded = (From sd In DB.APP_Villas Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
            With _updateVillaadded
                .VillaUpdatedBy = Session("UserID")
                .VillaUpdatedDate = Now
                _villaId = .ID
            End With
            DB.SubmitChanges()
            SaveTransactionAttachment(_villaId)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(System.Web.UI.Page), "Script", "CloseAndRebind();", True)

        Catch ex As Exception

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

                Dim filename As String = _VillaID + "-Edit-" + _count.ToString
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

    Private Function Check_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Villas Select sd.VillaName

            If _info.Contains(_Name) Then
                RadAjaxManagerMain.Alert("Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Protected Sub VillaUploadedLink_Click(sender As Object, e As EventArgs)
        Dim _VillauploadedInfo = (From sd In DB.APP_VillaAttachments Where sd.VillaID = Convert.ToInt64(Request.QueryString("ID"))).FirstOrDefault
        If _VillauploadedInfo IsNot Nothing Then
            ImageView_model.VisibleOnPageLoad = True
            ImageView_model.NavigateUrl = "~/Forms/RealEstate/VillaManagement/VillaManagementAttachmentWindow.aspx?ID=" + Request.QueryString("ID")
            RadWindowManager_modalPopup.Windows.Add(ImageView_model)
        Else
            PopMsg.ShowErrorMessage("No image To load")
        End If
    End Sub
End Class