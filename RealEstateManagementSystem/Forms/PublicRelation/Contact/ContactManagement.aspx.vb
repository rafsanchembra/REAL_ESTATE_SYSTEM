Imports System.IO
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Public Class ContactManagement
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim _TempPath = "~/AttachmentTemp/Contact/Identity"

            If Not Directory.Exists(Server.MapPath(_TempPath)) Then
                Directory.CreateDirectory(Server.MapPath(_TempPath))
            End If

            _TempPath = "~/AttachmentTemp/Contact/CommercialRegister"

            If Not Directory.Exists(Server.MapPath(_TempPath)) Then
                Directory.CreateDirectory(Server.MapPath(_TempPath))
            End If

            ContactNameTextBox.Focus()
            Me.Form.DefaultButton = SubmitButton.UniqueID
            loadSiteMap()
        End If
    End Sub

    Private Sub loadSiteMap()
        Dim _radSiteMap As RadSiteMap = CType(Master.FindControl("BreadCrumbSiteMapMasterPage"), RadSiteMap)

        Dim _root1 As New RadSiteMapNode
        _root1.Text = "Home"
        _root1.Value = "1"
        _root1.NavigateUrl = "~/Forms/Default.aspx"
        _radSiteMap.Nodes.Add(_root1)

        Dim _root2 As New RadSiteMapNode
        _root2.Text = "Public Relation"
        _root2.Value = "2"
        _root2.NavigateUrl = "~/Forms/Pages/PublicRelation.aspx"
        _radSiteMap.Nodes.Add(_root2)

        Dim _root3 As New RadSiteMapNode
        _root3.Text = "Contact Management"
        _root3.Value = "3"
        _root3.Enabled = False
        _radSiteMap.Nodes.Add(_root3)
    End Sub
   
    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        If ContactNameTextBox.Text.Trim = "" Or ContactGSM1TextBox.Text.Trim = "" Then
            Exit Sub
        End If

        If Not Check_ContactName_Exists(ContactNameTextBox.Text.Trim) Then
            Exit Sub
        End If

        If Not ContactIdentityNumberTextBox.Text.Trim = "" Then
            If Not Check_ContactIdentityNumber_Exists(ContactIdentityNumberTextBox.Text.Trim) Then
                Exit Sub
            End If
        End If

        If Not Check_ContactGSM1_Exists(ContactGSM1TextBox.Text.Trim, ContactGSM1ContryCodeCombobox.SelectedValue) Then
            Exit Sub
        End If

        If Not ContactEmailTextBox.Text.Trim = "" Then
            If Not Check_ContactEmail_Exists(ContactEmailTextBox.Text.Trim) Then
                Exit Sub
            End If
        End If

        Try
            Dim _ContactID As String

            Dim _currentUser As MembershipUser = Membership.GetUser()
            Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

            Dim _NewContact As New APP_Contact
            With _NewContact
                .ContactName = ContactNameTextBox.Text.Trim
                .ContactNickName = ContactNickNameComboBox.SelectedValue
                .ContactIdentityNumber = ContactIdentityNumberTextBox.Text.Trim
                .ContactGSM1CountryCode = ContactGSM1ContryCodeCombobox.SelectedValue
                .ContactGSM1 = ContactGSM1TextBox.Text.Trim
                If Not ContactGSM2TextBox.Text.Trim = "" Then
                    .ContactGSM2CountryCode = ContactGSM2ContryCodeCombobox.SelectedValue
                    .ContactGSM2 = ContactGSM2TextBox.Text.Trim
                End If
                .ContactCommercialRegisterNumber = ContactCommercialRegisterNumberTextBox.Text.Trim
                .ContactEmail = ContactEmailTextBox.Text.Trim
                .ContactOfficePhone = ContactOfficePhoneTextBox.Text.Trim
                .ContactOfficeFax = ContactOfficeFaxTextBox.Text.Trim
                .ContactWebsite = ContactWebsiteTextBox.Text.Trim
                .ContactPOBox = ContactPOBoxTextBox.Text.Trim
                .ContactPostalCode = ContactPostalCodeTextBox.Text.Trim
                .ContactLatitudeCoordinates = ContactLatitudeCoordinatesTextBox.Text.Trim
                .ContactLongitudeCoordinates = ContactLongitudeCoordinatesTextBox.Text.Trim
                .ContactURLMap = ContactURLMapTextBox.Text.Trim
                .ContactMemo = ContactMemoTextBox.Text.Trim
                .ContactAddedBy = _currentUserID
                .ContactAddedDate = Now
            End With
            DB.APP_Contacts.InsertOnSubmit(_NewContact)
            DB.SubmitChanges()
            _ContactID = _NewContact.ID
            Session("ContactID") = _NewContact.ID
            _NewContact = Nothing

            SaveIdentityAttachment(_ContactID)
            SaveCommercialRegisterAttachment(_ContactID)

            Dim _UpdateIdentityAttachment = From sd In DB.APP_Contacts Where sd.ID = _ContactID Select sd

            For Each _item In _UpdateIdentityAttachment
                _item.ContactIdentityAttachment = Session("ContactIdentityAttachment")
                _item.ContactCommercialRegisterAttachment = Session("ContactCommercialRegisterAttachment")
            Next
            DB.SubmitChanges()

            ClearData()
            ContactRadGrid.Rebind()

        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Private Sub ClearData()
        ContactNameTextBox.Text = ""
        ContactNickNameComboBox.ClearSelection()
        ContactIdentityNumberTextBox.Text = ""
        ContactGSM1ContryCodeCombobox.ClearSelection()
        ContactGSM1TextBox.Text = ""
        ContactGSM2ContryCodeCombobox.ClearSelection()
        ContactGSM2TextBox.Text = ""
        ContactCommercialRegisterNumberTextBox.Text = ""
        ContactEmailTextBox.Text = ""
        ContactOfficePhoneTextBox.Text = ""
        ContactOfficeFaxTextBox.Text = ""
        ContactWebsiteTextBox.Text = ""
        ContactPOBoxTextBox.Text = ""
        ContactPostalCodeTextBox.Text = ""
        ContactLatitudeCoordinatesTextBox.Text = ""
        ContactLongitudeCoordinatesTextBox.Text = ""
        ContactURLMapTextBox.Text = ""
        ContactMemoTextBox.Text = ""
        ContactNameTextBox.Focus()
    End Sub

    Private Sub SaveIdentityAttachment(_ContactID As String)
        Session("ContactIdentityAttachment") = ""

        Try
            Dim _attachmentPath = "~/Attachments/Contact/Identity/" + _ContactID + "/"

            If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                Directory.CreateDirectory(Server.MapPath(_attachmentPath))
            End If

            If Not ContactIdentityUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                Dim FileToBeSaved As String
                For Each validFile As UploadedFile In ContactIdentityUpload.UploadedFiles
                    Dim filename As String = _ContactID
                    FileToBeSaved = filename & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                Next
                Session("ContactIdentityAttachment") = _attachmentPath + FileToBeSaved
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Private Sub SaveCommercialRegisterAttachment(_ContactID As String)
        Session("ContactCommercialRegisterAttachment") = ""

        Try
            Dim _attachmentPath = "~/Attachments/Contact/CommercialRegister/" + _ContactID + "/"

            If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                Directory.CreateDirectory(Server.MapPath(_attachmentPath))
            End If

            If Not ContactCommercialRegisterUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                Dim FileToBeSaved As String
                For Each validFile As UploadedFile In ContactCommercialRegisterUpload.UploadedFiles
                    Dim filename As String = _ContactID
                    FileToBeSaved = filename & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                Next
                Session("ContactCommercialRegisterAttachment") = _attachmentPath + FileToBeSaved
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Protected Sub ContactRadGrid_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "Edit"
                e.Item.OwnerTableView.IsItemInserted = False
                Exit Select
        End Select
    End Sub

    Protected Sub ContactRadGrid_EditCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Session("ContactID") = e.Item.Cells(3).Text.Trim
        Session("_ContactName") = e.Item.Cells(4).Text.Trim
        Session("_ContactIdentityNumber") = e.Item.Cells(6).Text.Trim
        Session("_ContactGSM1") = e.Item.Cells(8).Text.Trim
        Session("_ContactEmail") = e.Item.Cells(11).Text.Trim
    End Sub

    Protected Sub ContactRadGrid_UpdateCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Dim editItem As GridEditFormItem = CType(e.Item, GridEditFormItem)
        Dim _contactId As String = editItem("ID").Text

        Dim _editedItem As GridEditableItem = TryCast(e.Item, GridEditableItem) 
        Dim _ContactName As RadTextBox = DirectCast(_editedItem.FindControl("ContactNameGridTextBox"), RadTextBox)
        Dim _ContactIdentityNumber As RadTextBox = DirectCast(_editedItem.FindControl("ContactIdentityNumberGridTextBox"), RadTextBox)
        Dim _ContactGSM1 As RadTextBox = DirectCast(_editedItem.FindControl("ContactGSM1GridTextBox"), RadTextBox)
        Dim _ContactGSMCountryCode As RadComboBox = DirectCast(_editedItem.FindControl("ContactGSM1ContryCodeGridCombobox"), RadComboBox)
        Dim _ContactEmail As RadTextBox = DirectCast(_editedItem.FindControl("ContactEmailGridTextBox"), RadTextBox)

        Dim _OldContactName As String = Session("_ContactName")
        Dim _OldContactIdentityNumber As String = Session("_ContactIdentityNumber")
        Dim _OldContactGSM1 As String = Session("_ContactGSM1")
        Dim _OldContactEmail As String = Session("_ContactEmail")

        Dim _NewContactGSM1 As String = _ContactGSMCountryCode.SelectedValue + "" + _ContactGSM1.Text.Trim

        If Not _ContactName.Text.Trim = _OldContactName.Trim Then
            If Not Check_ContactName_Exists(_ContactName.Text.Trim) Then
                e.Canceled = True
                Exit Sub
            End If
        End If

        If Not _ContactIdentityNumber.Text = "" Then
            If Not _ContactIdentityNumber.Text.Trim = _OldContactIdentityNumber.Trim Then
                If Not Check_ContactIdentityNumber_Exists(_ContactIdentityNumber.Text.Trim) Then
                    e.Canceled = True
                    Exit Sub
                End If
            End If
        End If

        If Not _NewContactGSM1.Trim = _OldContactGSM1.Trim Then
            If Not Check_ContactGSM1_Exists(_ContactGSM1.Text.Trim, _ContactGSMCountryCode.SelectedValue) Then
                e.Canceled = True
                Exit Sub
            End If
        End If

        If Not _ContactEmail.Text.Trim = "" Then
            If Not _ContactEmail.Text.Trim = _OldContactEmail Then
                If Not Check_ContactEmail_Exists(_ContactEmail.Text.Trim) Then
                    e.Canceled = True
                    Exit Sub
                End If
            End If
        End If

        SaveIdentityGridAttachment(_editedItem, _contactId)
        SaveCommercialRegisterGridAttachment(_editedItem, _contactId)
    End Sub

#Region "Check Data items"

    Private Function Check_ContactName_Exists(_ContactName As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Contacts Select sd.ContactName.Trim

            If _info.Contains(_ContactName.Trim) Then
                RadAjaxManagerMain.Alert("Contact Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Private Function Check_ContactIdentityNumber_Exists(_ContactIdentityNumber As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Contacts Select sd.ContactIdentityNumber.Trim

            If _info.Contains(_ContactIdentityNumber.Trim) Then
                RadAjaxManagerMain.Alert("Contact Identity Number Already Exixts")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Private Function Check_ContactGSM1_Exists(_ContactGSM1 As String, _CountryCode As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Contacts Select sd.ContactGSM1CountryCode + "" + sd.ContactGSM1.Trim

            If _info.Contains(_CountryCode + "" + _ContactGSM1.Trim) Then
                RadAjaxManagerMain.Alert("Contact GSM 1 Already Exists")
                _status = False
            End If

        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Private Function Check_ContactEmail_Exists(_ContactEmail As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Contacts Select sd.ContactEmail.Trim

            If _info.Contains(_ContactEmail.Trim) Then
                RadAjaxManagerMain.Alert("Contant Email Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

#End Region

#Region "Save Attachments"

    Private Sub SaveIdentityGridAttachment(_editedItem As GridEditableItem, _contactId As String)
        Session("ContactIdentityGridAttachment") = "NULL"
        Dim _ContactIdentityGridUpload As RadAsyncUpload = DirectCast(_editedItem.FindControl("ContactIdentityGridUpload"), RadAsyncUpload)

        Try
            Dim _attachmentPath = "~/Attachments/Contact/Identity/" + _contactId + "/"

            If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                Directory.CreateDirectory(Server.MapPath(_attachmentPath))
            End If

            If Not _ContactIdentityGridUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                Dim FileToBeSaved As String
                For Each validFile As UploadedFile In _ContactIdentityGridUpload.UploadedFiles
                    Dim filename As String = _contactId
                    FileToBeSaved = filename & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                Next
                Session("ContactIdentityGridAttachment") = _attachmentPath + FileToBeSaved
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

    End Sub

    Private Sub SaveCommercialRegisterGridAttachment(_editedItem As GridEditableItem, _contactId As String)
        Session("ContactCommercialRegisterGridAttachment") = "NULL"

        Dim _ContactCommercialRegisterGridUpload As RadAsyncUpload = DirectCast(_editedItem.FindControl("ContactCommercialRegisterGridUpload"), RadAsyncUpload)

        Try
            Dim _attachmentPath = "~/Attachments/Contact/CommercialRegister/" + _contactId + "/"

            If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                Directory.CreateDirectory(Server.MapPath(_attachmentPath))
            End If

            If Not _ContactCommercialRegisterGridUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                Dim FileToBeSaved As String
                For Each validFile As UploadedFile In _ContactCommercialRegisterGridUpload.UploadedFiles
                    Dim filename As String = _contactId
                    FileToBeSaved = filename & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                Next
                Session("ContactCommercialRegisterGridAttachment") = _attachmentPath + FileToBeSaved
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

    End Sub

#End Region

    Protected Sub SqlDataSource_ContactList_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource_ContactList.Updating
        Try
            e.Command.Parameters("@ContactUpdatedDate").Value = Now
            If Not Session("ContactIdentityGridAttachment") = "NULL" Then
                e.Command.Parameters("@ContactIdentityAttachment").Value = Session("ContactIdentityGridAttachment")
            End If
            If Not Session("ContactCommercialRegisterGridAttachment") = "NULL" Then
                e.Command.Parameters("@ContactCommercialRegisterAttachment").Value = Session("ContactCommercialRegisterGridAttachment")
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Protected Sub SqlDataSource_ContactList_OnUpdating(sender As Object, e As SqlDataSourceCommandEventArgs)
        Dim _UpdatedBy As New SqlParameter("@ContactUpdatedBy", SqlDbType.UniqueIdentifier)
        _UpdatedBy.Direction = ParameterDirection.Input

        Dim _CurrentUser As MembershipUser = Membership.GetUser
        Dim _CurrentUserId As Guid = CType(_CurrentUser.ProviderUserKey, Guid)
        _UpdatedBy.Value = _CurrentUserId
        e.Command.Parameters.Add(_UpdatedBy)
    End Sub

    Protected Sub ContactRadGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_ContactList") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

End Class