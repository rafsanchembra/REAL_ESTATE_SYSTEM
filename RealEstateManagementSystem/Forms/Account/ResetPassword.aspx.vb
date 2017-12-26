Imports Telerik.Web.UI

Public Class ResetPassword
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        BindUsersToUserList()
        loadSiteMap()
    End Sub

    Private Sub loadSiteMap()
        Dim _radSiteMap As RadSiteMap = CType(Master.FindControl("BreadCrumbSiteMapMasterPage"), RadSiteMap)

        Dim _root1 As New RadSiteMapNode
        _root1.Text = "Home"
        _root1.Value = "1"
        _root1.NavigateUrl = "~/"
        _radSiteMap.Nodes.Add(_root1)

        Dim _root2 As New RadSiteMapNode
        _root2.Text = "Administrator"
        _root2.Value = "2"
        _root2.NavigateUrl = "~/Forms/Pages/Administrator/Administrator.aspx"
        _radSiteMap.Nodes.Add(_root2)

        Dim _root3 As New RadSiteMapNode
        _root3.Text = "User Management"
        _root3.Value = "3"
        _root3.NavigateUrl = "~/Forms/Pages/Administrator/UserManagement.aspx"
        _radSiteMap.Nodes.Add(_root3)

        Dim _root4 As New RadSiteMapNode
        _root4.Text = "change Password"
        _root4.Value = "4"
        _root4.Enabled = False
        _radSiteMap.Nodes.Add(_root4)

    End Sub
    Private Sub BindUsersToUserList()
        UserNameList.Items.Clear()
        Dim Users As MembershipUserCollection = Membership.GetAllUsers()
        Dim CurrentUser As MembershipUser = Membership.GetUser()
        Users.Remove(CurrentUser.UserName.Trim)
        UserNameList.DataSource = Users
        UserNameList.DataBind()
    End Sub

    'Protected Sub UserNameList_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles UserNameList.SelectedIndexChanged
    '    Dim SelectedUserName As String = e.Text.Trim
    '    Dim CurrentUser As MembershipUser = Membership.GetUser(SelectedUserName)
    '    'CurrentPassword.Text = CurrentUser.ResetPassword()
    'End Sub

    Protected Sub button_ResetPassword_Click(sender As Object, e As EventArgs) Handles button_ResetPassword.Click
        'If CurrentPassword.Text.Trim = "" Then
        '    RadAjaxManagerMain.Alert("Please Select A User.")
        '    Exit Sub
        'End If
        If NewPassword.Text.Trim.Length < 4 Then
            RadAjaxManagerMain.Alert("Minimum Password Length = 4")
            Exit Sub
        End If

        Dim _SelectedUserName As String = UserNameList.Text.Trim
        Dim _CurrentUser As MembershipUser = Membership.GetUser(_SelectedUserName)
        Dim _CurrentUserID As Guid = CType(_CurrentUser.ProviderUserKey, Guid)
        Dim _CurrentPassword As String = _CurrentUser.ResetPassword()
        _CurrentUser.ChangePassword(_CurrentPassword.Trim, NewPassword.Text.Trim)
        Membership.UpdateUser(_CurrentUser)

        '  CurrentPassword.Text = ""
        NewPassword.Text = ""
        ConfirmPassword.Text = ""
        UserNameList.Text = ""
        BindUsersToUserList()
    End Sub
End Class