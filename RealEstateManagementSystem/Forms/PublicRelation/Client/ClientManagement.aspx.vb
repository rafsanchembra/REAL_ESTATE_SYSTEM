Imports Telerik.Web.UI
Imports System.IO
Imports System.Data.SqlClient

Public Class ClientManagement
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim _TempPath = "~/AttachmentTemp/Client"

            If Not Directory.Exists(Server.MapPath(_TempPath)) Then
                Directory.CreateDirectory(Server.MapPath(_TempPath))
            End If

            ContactNameComboBox.Focus()
            Me.Form.DefaultButton = SubmitButton.UniqueID
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
        _root2.Text = "Public Relation"
        _root2.Value = "2"
        _root2.NavigateUrl = "~/Forms/Pages/PublicRelation.aspx"
        _radSiteMap.Nodes.Add(_root2)

        Dim _root3 As New RadSiteMapNode
        _root3.Text = "Client Management"
        _root3.Value = "3"
        _root3.Enabled = False
        _radSiteMap.Nodes.Add(_root3)
    End Sub

    Protected Sub ClientRadGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_ClientList") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString

            Dim _GridDataItem As GridDataItem = e.Item

            Dim _imageButton As ImageButton = DirectCast(_GridDataItem("Freeze").Controls(0), ImageButton)
            If e.Item.Cells(10).Text = "Active" Then
                _imageButton.ImageUrl = "~/Content/css/MeStyle/Grid/Denied.png"
                _imageButton.ToolTip = "Freeze Bill"
                _imageButton.CommandName = "Freeze"
            Else
                _imageButton.ImageUrl = "~/Content/css/MeStyle/Grid/Approve.png"
                _imageButton.ToolTip = "Activate Bill"
                _imageButton.CommandName = "Activate"
            End If
        End If
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        If ContactNameComboBox.SelectedIndex = -1 Then
            Exit Sub
        End If

        If Not Check_ContactName_Exists(Convert.ToInt64(ContactNameComboBox.SelectedValue)) Then
            Exit Sub
        End If

        Dim _ClientID As String

        Dim _currentUser As MembershipUser = Membership.GetUser()
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

        Dim _NewClient As New APP_Client
        With _NewClient
            .ClientContactID = Convert.ToInt64(ContactNameComboBox.SelectedValue)
            .ClientStaffName1 = ClientStaffName1TextBox.Text.Trim
            .ClientStaffName1GSM = ClientStaffName1GSMTextBox.Text.Trim
            .ClientStaffName2 = ClientStaffName2TextBox.Text.Trim
            .ClientStaffName2GSM = ClientStaffName2GSMTextBox.Text.Trim
            .ClientMemo = ClientMemoTextBox.Text.Trim
            .ClientStatus = True
            .ClientAddedBy = _currentUserID
            .ClientAddedDate = Now
        End With
        DB.APP_Clients.InsertOnSubmit(_NewClient)
        DB.SubmitChanges()
        _ClientID = _NewClient.ID
        _NewClient = Nothing

        SaveClientDocument(_ClientID)

        Dim _updateData = From sd In DB.APP_Clients Where sd.ID = _ClientID Select sd

        For Each _item In _updateData
            _item.ClientDocument = Session("ClientDocument")
        Next
        DB.SubmitChanges()

        ClearData()
        ClientRadGrid.Rebind()
    End Sub

    Private Sub SaveClientDocument(_ClientID As String)
        Session("ClientDocument") = ""
        Try
            Dim _attachmentPath = "~/Attachments/Client/" + _ClientID + "/"

            If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                Directory.CreateDirectory(Server.MapPath(_attachmentPath))
            End If

            If Not ClientDocumentUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                Dim FileToBeSaved As String
                For Each validFile As UploadedFile In ClientDocumentUpload.UploadedFiles
                    Dim filename As String = _ClientID
                    FileToBeSaved = filename & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                Next
                Session("ClientDocument") = _attachmentPath + FileToBeSaved
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Protected Sub ClientRadGrid_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "Edit"
                e.Item.OwnerTableView.IsItemInserted = False
                Exit Select
            Case "Freeze"
                Dim _UpdateInfo = From sd In DB.APP_Clients Where sd.ID = Convert.ToInt64(e.Item.Cells(3).Text) Select sd

                For Each _item In _UpdateInfo
                    _item.ClientStatus = False
                Next
                DB.SubmitChanges()

                ClientRadGrid.Rebind()
                Exit Select
            Case "Activate"
                Dim _UpdateInfo = From sd In DB.APP_Clients Where sd.ID = Convert.ToInt64(e.Item.Cells(3).Text) Select sd

                For Each _item In _UpdateInfo
                    _item.ClientStatus = True
                Next
                DB.SubmitChanges()

                ClientRadGrid.Rebind()
                Exit Select
        End Select
    End Sub

    Protected Sub ClientRadGrid_EditCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Session("_ClientID") = e.Item.Cells(3).Text
        Session("_ClientContactID") = e.Item.Cells(4).Text
    End Sub

    Protected Sub ClientRadGrid_UpdateCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Dim editItem As GridEditFormItem = CType(e.Item, GridEditFormItem)
        Dim _clientId As String = editItem("ID").Text

        Dim _editedItem As GridEditableItem = TryCast(e.Item, GridEditableItem)

        Dim _ClientContactID As RadComboBox = DirectCast(_editedItem.FindControl("ContactNameGridComboBox"), RadComboBox)

        Dim _OldClientContactID As String = Session("_ClientContactID").ToString.Trim

        If Not _ClientContactID.SelectedValue.Trim = _OldClientContactID.Trim Then
            If Not Check_ContactName_Exists(_ClientContactID.SelectedValue.Trim) Then
                e.Canceled = True
                Exit Sub
            End If
        End If

        SaveClientGridDocument(_editedItem, _clientId)
    End Sub

    Private Sub SaveClientGridDocument(_editedItem As GridEditableItem, _clientId As String)

        Session("ClientDocument") = "NULL"
        Dim _ClientDocumentGridUpload As RadAsyncUpload = DirectCast(_editedItem.FindControl("ClientDocumentGridUpload"), RadAsyncUpload)
        Try
            Dim _attachmentPath = "~/Attachments/Client/" + _clientId + "/"

            If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                Directory.CreateDirectory(Server.MapPath(_attachmentPath))
            End If

            If Not _ClientDocumentGridUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                Dim FileToBeSaved As String
                For Each validFile As UploadedFile In _ClientDocumentGridUpload.UploadedFiles
                    Dim filename As String = _clientId
                    FileToBeSaved = filename & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                Next
                Session("ClientDocument") = _attachmentPath + FileToBeSaved
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
        
    End Sub

    Private Function Check_ContactName_Exists(_ClientContactID As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Clients Select sd.ClientContactID

            If _info.Contains(_ClientContactID.Trim) Then
                RadAjaxManagerMain.Alert("Contact Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Protected Sub SqlDataSource_ClientList_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource_ClientList.Updating
        Try
            e.Command.Parameters("@ClientUpdatedDate").Value = Now
            e.Command.Parameters("@ClientDocument").Value = Session("ClientDocument")
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Protected Sub SqlDataSource_ClientList_OnUpdating(sender As Object, e As SqlDataSourceCommandEventArgs)
        Dim _UpdatedBy As New SqlParameter("@ClientUpdatedBy", SqlDbType.UniqueIdentifier)
        _UpdatedBy.Direction = ParameterDirection.Input

        Dim _CurrentUser As MembershipUser = Membership.GetUser
        Dim _CurrentUserId As Guid = CType(_CurrentUser.ProviderUserKey, Guid)
        _UpdatedBy.Value = _CurrentUserId
        e.Command.Parameters.Add(_UpdatedBy)
    End Sub

    Protected Sub ClientDocumentGridUpload_FileUploaded(sender As Object, e As FileUploadedEventArgs)
        Dim _ClientDocumentLink As HyperLink = DirectCast(DirectCast(DirectCast(sender, RadAsyncUpload).NamingContainer, GridEditableItem).FindControl("ClientDocumentGridLink"), HyperLink)
        _ClientDocumentLink.NavigateUrl = "~/AttachmentTemp/Client/" + e.File.FileName
    End Sub

    Private Sub ClearData()
        ContactNameComboBox.Text = ""
        ClientStaffName1TextBox.Text = ""
        ClientStaffName1GSMTextBox.Text = ""
        ClientStaffName2TextBox.Text = ""
        ClientStaffName2GSMTextBox.Text = ""
        ClientMemoTextBox.Text = ""
        ContactNameComboBox.ClearSelection()
    End Sub

    Protected Sub AddNewContactLink_Click(sender As Object, e As EventArgs)
        modalPopup.VisibleOnPageLoad = True
        RadWindowManager_modalPopup.Windows.Add(modalPopup)
    End Sub

    Protected Sub RadAjaxManagerMain_AjaxRequest(sender As Object, e As AjaxRequestEventArgs)
        ContactNameComboBox.ClearSelection()
        ContactNameComboBox.Items.Clear()
        ContactNameComboBox.DataBind()
    End Sub

End Class