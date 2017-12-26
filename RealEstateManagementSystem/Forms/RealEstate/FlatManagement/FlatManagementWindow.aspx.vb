Imports System.IO
Imports Telerik.Web.UI

Public Class FlatManagementWindow
    Inherits System.Web.UI.Page
    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            LoadData()
            SessionCreater()
        End If
    End Sub
    Private Sub LoadData()
        Dim _FlatInfo = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault

        FlatNameRadTextBox.Text = _FlatInfo.FlatName
        FlatOfficalNameRadTextBox.DisplayText = _FlatInfo.FlatOfficialName
        FlatCompanyNameRadTextBox.Text = _FlatInfo.FlatCompanyName
        FlatRentPriceRadTextBox.Value = _FlatInfo.FlatRentingPrice
        FlatProvinceComboBox.SelectedValue = _FlatInfo.FlatProvince

        FlatCityComboBox.DataBind()
        FlatCityComboBox.SelectedValue = _FlatInfo.FlatCity

        FlatVillageComboBox.DataBind()
        FlatVillageComboBox.SelectedValue = _FlatInfo.FlatVillage

        FlatPlaceRadTExtBox.Text = _FlatInfo.FlatPlace
        FlatMemoRadTextBox.Text = _FlatInfo.FlatMemo
        FlatRoomNoTextBox.Text = _FlatInfo.FlatRoomNumber
        FlatBathroomNoTextBox.Text = _FlatInfo.FlatBathroomNumber
        FlatBathRoomTypeComboBox.SelectedValue = _FlatInfo.FlatBathroomType
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
        Session("OldFlatName") = FlatNameRadTextBox.Text.Trim
        Session("OldFlatOfficalName") = FlatOfficalNameRadTextBox.Text.Trim
        Session("OldFlatCompanyName") = FlatCompanyNameRadTextBox.Text.Trim
        Session("OldFlatRentingPrice") = FlatRentPriceRadTextBox.Value
        Session("OldFlatProvince") = FlatProvinceComboBox.Text.Trim
        Session("OldFlatCity") = FlatCityComboBox.Text.Trim
        Session("OldFlatVillage") = FlatVillageComboBox.Text.Trim
        Session("OldFlatPlace") = FlatPlaceRadTExtBox.Text.Trim
        Session("OldFlatMemo") = FlatMemoRadTextBox.Text.Trim
        Session("OldFlatRoomNo") = FlatRoomNoTextBox.Text.Trim
        Session("OldFlatBathNo") = FlatBathroomNoTextBox.Text.Trim
        Session("OldFlatBathType") = FlatBathRoomTypeComboBox.SelectedValue

    End Sub

    Private Sub removeSession()
        Session.Remove("UserID")
    End Sub
    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)

        Dim _oldFlatName As String = Session("OldFlatName")
        Dim _oldFlatOfficalName As String = Session("OldFlatOfficalName")
        Dim _oldFlatCompanyName As String = Session("OldFlatCompanyName")
        Dim _oldFlatRentingPrice As Integer = Session("OldFlatRentingPrice")
        Dim _oldFlatProvince As String = Session("OldFlatProvince")
        Dim _oldFlatCity As String = Session("OldFlatCity")
        Dim _oldFlatVillage As String = Session("OldFlatVillage")
        Dim _oldFlatPlace As String = Session("OldFlatPlace")
        Dim _oldFlatMemo As String = Session("OldFlatMemo")
        Dim _oldFlatRoomNo As String = Session("OldFlatRoomNo")
        Dim _oldFlatBathNo As String = Session("OldFlatBathNo")
        Dim _oldFlatBathType As String = Session("OldFlatBathType")


        Try

            If Not _oldFlatName = FlatNameRadTextBox.Text.Trim Then
                If Check_Name_Exists(FlatNameRadTextBox.Text.Trim) Then
                    Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                    With _updateFlat
                        .FlatName = FlatNameRadTextBox.Text.Trim
                    End With
                    DB.SubmitChanges()
                Else
                    Exit Sub
                End If
            End If

            If Not _oldFlatOfficalName = FlatOfficalNameRadTextBox.Text.Trim Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatOfficialName = FlatOfficalNameRadTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFlatCompanyName = FlatCompanyNameRadTextBox.Text.Trim Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatCompanyName = FlatCompanyNameRadTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFlatRentingPrice = FlatRentPriceRadTextBox.Value Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatRentingPrice = FlatRentPriceRadTextBox.Value
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFlatProvince = FlatProvinceComboBox.SelectedValue Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatProvince = FlatProvinceComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFlatCity = FlatCityComboBox.SelectedValue Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatCity = FlatCityComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFlatVillage = FlatVillageComboBox.SelectedValue Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatVillage = FlatVillageComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFlatPlace = FlatPlaceRadTExtBox.Text.Trim Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatPlace = FlatPlaceRadTExtBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFlatMemo = FlatMemoRadTextBox.Text.Trim Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatMemo = FlatMemoRadTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFlatRoomNo = FlatRoomNoTextBox.Text.Trim Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatRoomNumber = FlatRoomNoTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If

            If Not _oldFlatBathNo = FlatBathroomNoTextBox.Text.Trim Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatBathroomNumber = FlatBathroomNoTextBox.Text.Trim
                End With
                DB.SubmitChanges()
            End If
            If Not _oldFlatBathType = FlatBathRoomTypeComboBox.SelectedValue Then
                Dim _updateFlat = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
                With _updateFlat
                    .FlatBathroomType = FlatBathRoomTypeComboBox.SelectedValue
                End With
                DB.SubmitChanges()
            End If
            Dim _flatId As String
            Dim _updateFlatadded = (From sd In DB.APP_Flats Where sd.ID = Convert.ToInt64(Request.QueryString("ID"))).SingleOrDefault
            With _updateFlatadded
                .FlatUpdatedBy = Session("UserID")
                .FlatUpdatedDate = Now
                _flatId = .ID
            End With
            DB.SubmitChanges()
            SaveTransactionAttachment(_flatId)
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(System.Web.UI.Page), "Script", "CloseAndRebind();", True)

        Catch ex As Exception

        End Try
    End Sub
    Private Sub SaveTransactionAttachment(_FlatID As String)
        Dim AttachmentPath As String = "~/Attachments/Flat/" + _FlatID.ToString + "/"

        If Not Directory.Exists(Server.MapPath(AttachmentPath)) Then
            Directory.CreateDirectory(Server.MapPath(AttachmentPath))
        End If

        If Not FlatAttachmentUpload.UploadedFiles.Count = 0 Then
            Dim _targetFolder As String = Server.MapPath(AttachmentPath)

            Dim _count = 1

            For Each validFile As UploadedFile In FlatAttachmentUpload.UploadedFiles
                Dim _fileName As String = _FlatID + "-Edit-" + _count.ToString
                Dim FileToBeSaved As String = _fileName & validFile.GetExtension
                Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                If File.Exists(FullPath) Then
                    File.Delete(FullPath)
                End If

                validFile.SaveAs(FullPath, True)

                Try
                    Dim _newFlatAttachment As New APP_FlatAttachment
                    With _newFlatAttachment
                        .FlatID = _FlatID
                        .FlatAttachment = FileToBeSaved
                        .FlatAttachmentName = AttachmentPath
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
    Private Function Check_Name_Exists(_name As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Flats Select sd.FlatName
            If _info.Contains(_name) Then
                RadAjaxManagerMain.Alert("Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Protected Sub FlatUploadedLink_Click(sender As Object, e As EventArgs)
        Dim _freelanduploadedInfo = (From sd In DB.APP_FlatAttachments Where sd.FlatID = Convert.ToInt64(Request.QueryString("ID"))).FirstOrDefault
        If _freelanduploadedInfo IsNot Nothing Then
            FlatEdit_model.VisibleOnPageLoad = True
            FlatEdit_model.NavigateUrl = "~/Forms/RealEstate/FlatManagement/FlatManagementAttachmentWindow.aspx?ID=" + Request.QueryString("ID")
            RadWindowManager_modalPopup.Windows.Add(FlatEdit_model)
        Else
            PopMsg.ShowErrorMessage("No image To load")
        End If
    End Sub
End Class