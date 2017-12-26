Imports Telerik.Web.UI

Public Class ActivateFreezeUser
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Me.Form.DefaultButton = ChangeUserNameButton.UniqueID
            BindUsersToUserList()
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
        _root4.Text = "Manage user"
        _root4.Value = "4"
        _root4.Enabled = False
        _radSiteMap.Nodes.Add(_root4)

    End Sub
    Private Sub BindUsersToUserList()
        UserNameList.Items.Clear()

        Dim _Users As MembershipUserCollection = Membership.GetAllUsers
        Dim _CurrentsUser As MembershipUser = Membership.GetUser
        _Users.Remove(_CurrentsUser.UserName.Trim)
        UserNameList.DataSource = _Users
        UserNameList.DataBind()
    End Sub

    Protected Sub UserNameList_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles UserNameList.SelectedIndexChanged
        Dim _SelectedUserName As String = e.Text.Trim
        Dim _CurrentUser As MembershipUser = Membership.GetUser(_SelectedUserName)
        txt_CurrentUserName.Text = _CurrentUser.UserName
        If _CurrentUser.IsApproved = True Then
            cmb_UserStatus.SelectedValue = "Active"
        Else
            cmb_UserStatus.SelectedValue = "Freezed"
        End If
    End Sub

    Protected Sub ChangeUserNameButton_Click(sender As Object, e As EventArgs) Handles ChangeUserNameButton.Click
        If txt_CurrentUserName.Text.Trim = "" Then
            RadAjaxManagerMain.Alert("Please Select A User.")
            Exit Sub
        End If
        If Not String.IsNullOrEmpty(txt_CurrentUserName.Text.Trim) Then
            Dim _SelectedUserName As String = txt_CurrentUserName.Text.Trim
            Dim _CurrentUser As MembershipUser = Membership.GetUser(_SelectedUserName)
            Dim _CurrentUserId As Guid = CType(_CurrentUser.ProviderUserKey, Guid)
            If cmb_UserStatus.SelectedValue = "Active" Then
                _CurrentUser.IsApproved = True
            Else
                _CurrentUser.IsApproved = False
            End If
            Membership.UpdateUser(_CurrentUser)
            txt_CurrentUserName.Text = ""
            BindUsersToUserList()
            cmb_UserStatus.Text = "Active"
        End If
    End Sub

End Class