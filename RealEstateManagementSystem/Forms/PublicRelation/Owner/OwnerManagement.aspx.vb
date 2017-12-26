Imports Telerik.Web.UI
Imports System.IO
Imports System.Data.SqlClient

Public Class OwnerManagement
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim _TempPath = "~/AttachmentTemp/Owner"

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
        _root3.Text = "Owner Management"
        _root3.Value = "3"
        _root3.Enabled = False
        _radSiteMap.Nodes.Add(_root3)
    End Sub
    Protected Sub OwnerRadGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_OwnerList") Then
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

        Dim _OwnerID As String

        Dim _currentUser As MembershipUser = Membership.GetUser()
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

        Dim _NewOwner As New APP_Owner
        With _NewOwner
            .OwnerContactID = Convert.ToInt64(ContactNameComboBox.SelectedValue)
            .OwnerStaffName1 = OwnerStaffName1TextBox.Text.Trim
            .OwnerStaffName1GSM = OwnerStaffName1GSMTextBox.Text.Trim
            .OwnerStaffName2 = OwnerStaffName2TextBox.Text.Trim
            .OwnerStaffName2GSM = OwnerStaffName2GSMTextBox.Text.Trim
            .OwnerMemo = OwnerMemoTextBox.Text.Trim
            .OwnerStatus = True
            .OwnerAddedBy = _currentUserID
            .OwnerAddedDate = Now
        End With
        DB.APP_Owners.InsertOnSubmit(_NewOwner)
        DB.SubmitChanges()
        _OwnerID = _NewOwner.ID
        _NewOwner = Nothing

        SaveOwnerDocument(_OwnerID)

        Dim _updateData = From sd In DB.APP_Owners Where sd.ID = _OwnerID Select sd

        For Each _item In _updateData
            _item.OwnerDocument = Session("OwnerDocument")
        Next
        DB.SubmitChanges()

        ClearData()
        OwnerRadGrid.Rebind()
    End Sub

    Private Sub SaveOwnerDocument(_OwnerID As String)

        Session("OwnerDocument") = ""
        Try
            Dim _attachmentPath = "~/Attachments/Owner/" + _OwnerID + "/"

            If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                Directory.CreateDirectory(Server.MapPath(_attachmentPath))
            End If

            If Not OwnerDocumentUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                Dim FileToBeSaved As String
                For Each validFile As UploadedFile In OwnerDocumentUpload.UploadedFiles
                    Dim filename As String = _OwnerID
                    FileToBeSaved = filename & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                Next
                Session("OwnerDocument") = _attachmentPath + FileToBeSaved
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

    End Sub

    Protected Sub OwnerRadGrid_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "Edit"
                If e.Item.Cells(10).Text.Trim = "Freezed" Then
                    RadAjaxManagerMain.Alert("You Can't Edit The Owner. Please Activete The Owner.")
                    e.Canceled = True
                    Exit Sub
                End If
                e.Item.OwnerTableView.IsItemInserted = False
                Exit Select
            Case "Freeze"
                Dim _UpdateInfo = From sd In DB.APP_Owners Where sd.ID = Convert.ToInt64(e.Item.Cells(3).Text) Select sd

                For Each _item In _UpdateInfo
                    _item.OwnerStatus = False
                Next
                DB.SubmitChanges()

                OwnerRadGrid.Rebind()
                Exit Select
            Case "Activate"
                Dim _UpdateInfo = From sd In DB.APP_Owners Where sd.ID = Convert.ToInt64(e.Item.Cells(3).Text) Select sd

                For Each _item In _UpdateInfo
                    _item.OwnerStatus = True
                Next
                DB.SubmitChanges()

                OwnerRadGrid.Rebind()
                Exit Select
        End Select
    End Sub

    Protected Sub OwnerRadGrid_EditCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Session("_OwnerID") = e.Item.Cells(3).Text
        Session("_OwnerContactID") = e.Item.Cells(4).Text
    End Sub

    Protected Sub OwnerRadGrid_UpdateCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Dim editItem As GridEditFormItem = CType(e.Item, GridEditFormItem)
        Dim _OwnerID As String = editItem("ID").Text

        Dim _editedItem As GridEditableItem = TryCast(e.Item, GridEditableItem)

        Dim _OwnerContactID As RadComboBox = DirectCast(_editedItem.FindControl("ContactNameGridComboBox"), RadComboBox)

        Dim _OldOwnerContactID As String = Session("_OwnerContactID").ToString.Trim

        If Not _OwnerContactID.SelectedValue.Trim = _OldOwnerContactID.Trim Then
            If Not Check_ContactName_Exists(_OwnerContactID.SelectedValue.Trim) Then
                e.Canceled = True
                Exit Sub
            End If
        End If

        SaveOwnerGridDocument(_editedItem, _OwnerID)
    End Sub

    Private Sub SaveOwnerGridDocument(_editedItem As GridEditableItem, _OwnerID As String)
        Session("OwnerGridDocument") = "NULL"
        Dim _OwnerDocumentGridUpload As RadAsyncUpload = DirectCast(_editedItem.FindControl("OwnerDocumentGridUpload"), RadAsyncUpload)
        Try
            Dim _attachmentPath = "~/Attachments/Owner/" + _OwnerID + "/"

            If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                Directory.CreateDirectory(Server.MapPath(_attachmentPath))
            End If

            If Not _OwnerDocumentGridUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                Dim FileToBeSaved As String
                For Each validFile As UploadedFile In _OwnerDocumentGridUpload.UploadedFiles
                    Dim filename As String = _OwnerID
                    FileToBeSaved = filename & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                Next
                Session("OwnerGridDocument") = _attachmentPath + FileToBeSaved
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

    End Sub

    Private Function Check_ContactName_Exists(_OwnerContactID As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Owners Select sd.OwnerContactID

            If _info.Contains(_OwnerContactID.Trim) Then
                RadAjaxManagerMain.Alert("Contact Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Protected Sub SqlDataSource_OwnerList_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource_OwnerList.Updating
        Try
            e.Command.Parameters("@OwnerUpdatedDate").Value = Now
            If Not Session("OwnerGridDocument") = "NULL" Then
                e.Command.Parameters("@OwnerDocument").Value = Session("OwnerGridDocument")
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Protected Sub SqlDataSource_OwnerList_OnUpdating(sender As Object, e As SqlDataSourceCommandEventArgs)
        Dim _UpdatedBy As New SqlParameter("@OwnerUpdatedBy", SqlDbType.UniqueIdentifier)
        _UpdatedBy.Direction = ParameterDirection.Input

        Dim _CurrentUser As MembershipUser = Membership.GetUser
        Dim _CurrentUserId As Guid = CType(_CurrentUser.ProviderUserKey, Guid)
        _UpdatedBy.Value = _CurrentUserId
        e.Command.Parameters.Add(_UpdatedBy)
    End Sub

    Protected Sub OwnerDocumentGridUpload_FileUploaded(sender As Object, e As FileUploadedEventArgs)
        Dim _OwnerDocumentLink As HyperLink = DirectCast(DirectCast(DirectCast(sender, RadAsyncUpload).NamingContainer, GridEditableItem).FindControl("OwnerDocumentGridLink"), HyperLink)
        _OwnerDocumentLink.NavigateUrl = "~/AttachmentTemp/Owner/" + e.File.FileName
    End Sub

    Private Sub ClearData()
        ContactNameComboBox.Text = ""
        OwnerStaffName1TextBox.Text = ""
        OwnerStaffName1GSMTextBox.Text = ""
        OwnerStaffName2TextBox.Text = ""
        OwnerStaffName2GSMTextBox.Text = ""
        OwnerMemoTextBox.Text = ""
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