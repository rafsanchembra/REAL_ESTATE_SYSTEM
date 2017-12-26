Imports System.IO

Public Class ContactManagementAddWindow
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim _TempPath = "~/AttachmentTemp/Contact"

            If Not Directory.Exists(Server.MapPath(_TempPath)) Then
                Directory.CreateDirectory(Server.MapPath(_TempPath))
            End If
        End If
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        If ContactNameTextBox.Text.Trim = "" Or ContactGSM1TextBox.Text.Trim = "" Then
            Exit Sub
        End If

        If Not Check_ContactName_Exists() Then
            Exit Sub
        End If

        Try
            Dim _ContactID As Long

            Dim _currentUser As MembershipUser = Membership.GetUser()
            Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

            Dim _NewContact As New APP_Contact
            With _NewContact
                .ContactName = ContactNameTextBox.Text.Trim
                .ContactNickName = ContactNickNameComboBox.SelectedValue
                .ContactGSM1CountryCode = ContactGSM1ContryCodeCombobox.SelectedValue
                .ContactGSM1 = ContactGSM1TextBox.Text.Trim             
                .ContactCommercialRegisterNumber = ContactCommercialRegisterNumberTextBox.Text.Trim
                .ContactAddedBy = _currentUserID
                .ContactAddedDate = Now
            End With
            DB.APP_Contacts.InsertOnSubmit(_NewContact)
            DB.SubmitChanges()
            _ContactID = _NewContact.ID
            _NewContact = Nothing

            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(System.Web.UI.Page), "Script", "CloseAndRebind();", True)
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

#Region "Check Data items"

    Private Function Check_ContactName_Exists() As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Contacts Select sd.ContactName.Trim

            If _info.Contains(ContactNameTextBox.Text.Trim) Then
                RadAjaxManagerMain.Alert("Contact Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Private Function Check_ContactGSM1_Exists() As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Contacts Select sd.ContactGSM1.Trim

            If _info.Contains(ContactGSM1TextBox.Text.Trim) Then
                RadAjaxManagerMain.Alert("Contact GSM 1 Already Exists")
                _status = False
            End If

        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function
#End Region

End Class