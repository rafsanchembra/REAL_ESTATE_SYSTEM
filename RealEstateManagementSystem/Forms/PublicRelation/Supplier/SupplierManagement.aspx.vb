Imports Telerik.Web.UI
Imports System.IO
Imports System.Data.SqlClient

Public Class SupplierManagement
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim _TempPath = "~/AttachmentTemp/Supplier"

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
        _root3.Text = "Supplier Management"
        _root3.Value = "3"
        _root3.Enabled = False
        _radSiteMap.Nodes.Add(_root3)
    End Sub
    Protected Sub SupplierRadGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_SupplierList") Then
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

        Dim _SupplierID As String

        Dim _currentUser As MembershipUser = Membership.GetUser()
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

        Dim _NewSupplier As New APP_Supplier
        With _NewSupplier
            .SupplierContactID = Convert.ToInt64(ContactNameComboBox.SelectedValue)
            .SupplierStaffName1 = SupplierStaffName1TextBox.Text.Trim
            .SupplierStaffName1GSM = SupplierStaffName1GSMTextBox.Text.Trim
            .SupplierStaffName2 = SupplierStaffName2TextBox.Text.Trim
            .SupplierStaffName2GSM = SupplierStaffName2GSMTextBox.Text.Trim
            .SupplierMemo = SupplierMemoTextBox.Text.Trim
            .SupplierStatus = True
            .SupplierAddedBy = _currentUserID
            .SupplierAddedDate = Now
        End With
        DB.APP_Suppliers.InsertOnSubmit(_NewSupplier)
        DB.SubmitChanges()
        _SupplierID = _NewSupplier.ID
        _NewSupplier = Nothing

        SaveSupplierDocument(_SupplierID)

        Dim _updateData = From sd In DB.APP_Suppliers Where sd.ID = _SupplierID Select sd

        For Each _item In _updateData
            _item.SupplierDocument = Session("SupplierDocument")
        Next
        DB.SubmitChanges()

        ClearData()
        SupplierRadGrid.Rebind()
    End Sub

    Private Sub SaveSupplierDocument(_SupplierID As String)

        Session("SupplierDocument") = ""
        Try
            Dim _attachmentPath = "~/Attachments/Supplier/" + _SupplierID + "/"

            If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                Directory.CreateDirectory(Server.MapPath(_attachmentPath))
            End If

            If Not SupplierDocumentUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                Dim FileToBeSaved As String
                For Each validFile As UploadedFile In SupplierDocumentUpload.UploadedFiles
                    Dim filename As String = _SupplierID
                    FileToBeSaved = filename & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                Next
                Session("SupplierDocument") = _attachmentPath + FileToBeSaved
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

    End Sub

    Protected Sub SupplierRadGrid_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "Edit"
                If e.Item.Cells(10).Text.Trim = "Freezed" Then
                    RadAjaxManagerMain.Alert("You Can't Edit The Supplier. Please Activete The Supplier.")
                    e.Canceled = True
                    Exit Sub
                End If
                e.Item.OwnerTableView.IsItemInserted = False
                Exit Select
            Case "Freeze"
                Dim _UpdateInfo = From sd In DB.APP_Suppliers Where sd.ID = Convert.ToInt64(e.Item.Cells(3).Text) Select sd

                For Each _item In _UpdateInfo
                    _item.SupplierStatus = False
                Next
                DB.SubmitChanges()

                SupplierRadGrid.Rebind()
                Exit Select
            Case "Activate"
                Dim _UpdateInfo = From sd In DB.APP_Suppliers Where sd.ID = Convert.ToInt64(e.Item.Cells(3).Text) Select sd

                For Each _item In _UpdateInfo
                    _item.SupplierStatus = True
                Next
                DB.SubmitChanges()

                SupplierRadGrid.Rebind()
                Exit Select
        End Select
    End Sub

    Protected Sub SupplierRadGrid_EditCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Session("_SupplierID") = e.Item.Cells(3).Text
        Session("_SupplierContactID") = e.Item.Cells(4).Text
    End Sub

    Protected Sub SupplierRadGrid_UpdateCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Dim editItem As GridEditFormItem = CType(e.Item, GridEditFormItem)
        Dim _SupplierID As String = editItem("ID").Text

        Dim _editedItem As GridEditableItem = TryCast(e.Item, GridEditableItem)

        Dim _SupplierContactID As RadComboBox = DirectCast(_editedItem.FindControl("ContactNameGridComboBox"), RadComboBox)

        Dim _OldSupplierContactID As String = Session("_SupplierContactID").ToString.Trim

        If Not _SupplierContactID.SelectedValue.Trim = _OldSupplierContactID.Trim Then
            If Not Check_ContactName_Exists(_SupplierContactID.SelectedValue.Trim) Then
                e.Canceled = True
                Exit Sub
            End If
        End If

        SaveSupplierGridDocument(_editedItem, _SupplierID)
    End Sub

    Private Sub SaveSupplierGridDocument(_editedItem As GridEditableItem, _SupplierID As String)

        Session("SupplierGridDocument") = "NULL"
        Dim _SupplierDocumentGridUpload As RadAsyncUpload = DirectCast(_editedItem.FindControl("SupplierDocumentGridUpload"), RadAsyncUpload)
        Try
            Dim _attachmentPath = "~/Attachments/Supplier/" + _SupplierID + "/"

            If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                Directory.CreateDirectory(Server.MapPath(_attachmentPath))
            End If

            If Not _SupplierDocumentGridUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                Dim FileToBeSaved As String
                For Each validFile As UploadedFile In _SupplierDocumentGridUpload.UploadedFiles
                    Dim filename As String = _SupplierID
                    FileToBeSaved = filename & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                Next
                Session("SupplierGridDocument") = _attachmentPath + FileToBeSaved
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Private Function Check_ContactName_Exists(_SupplierContactID As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Suppliers Select sd.SupplierContactID

            If _info.Contains(_SupplierContactID.Trim) Then
                RadAjaxManagerMain.Alert("Contact Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Protected Sub SqlDataSource_SupplierList_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource_SupplierList.Updating
        Try
            e.Command.Parameters("@SupplierUpdatedDate").Value = Now
            If Not Session("SupplierGridDocument") = "NULL" Then
                e.Command.Parameters("@SupplierDocument").Value = Session("SupplierGridDocument")
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Protected Sub SqlDataSource_SupplierList_OnUpdating(sender As Object, e As SqlDataSourceCommandEventArgs)
        Dim _UpdatedBy As New SqlParameter("@SupplierUpdatedBy", SqlDbType.UniqueIdentifier)
        _UpdatedBy.Direction = ParameterDirection.Input

        Dim _CurrentUser As MembershipUser = Membership.GetUser
        Dim _CurrentUserId As Guid = CType(_CurrentUser.ProviderUserKey, Guid)
        _UpdatedBy.Value = _CurrentUserId
        e.Command.Parameters.Add(_UpdatedBy)
    End Sub

    Protected Sub SupplierDocumentGridUpload_FileUploaded(sender As Object, e As FileUploadedEventArgs)
        Dim _SupplierDocumentLink As HyperLink = DirectCast(DirectCast(DirectCast(sender, RadAsyncUpload).NamingContainer, GridEditableItem).FindControl("SupplierDocumentGridLink"), HyperLink)
        _SupplierDocumentLink.NavigateUrl = "~/AttachmentTemp/Supplier/" + e.File.FileName
    End Sub

    Private Sub ClearData()
        ContactNameComboBox.Text = ""
        SupplierStaffName1TextBox.Text = ""
        SupplierStaffName1GSMTextBox.Text = ""
        SupplierStaffName2TextBox.Text = ""
        SupplierStaffName2GSMTextBox.Text = ""
        SupplierMemoTextBox.Text = ""
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