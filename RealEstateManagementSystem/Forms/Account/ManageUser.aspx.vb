Imports System
Imports Telerik.Web.UI

Public Class ManageUser
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BindUsersToUserList()
            Get_Roles()
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
        _root4.Text = "Change User Permissions"
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

    Private Sub Get_Roles()
        RoleList.Items.Clear()
        RoleList.ClearSelection()
        Dim _Roles() As String = Roles.GetAllRoles
        RoleList.DataSource = _Roles.ToList
        RoleList.DataBind()
    End Sub

    Protected Sub UserNameList_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs) Handles UserNameList.SelectedIndexChanged
        Get_Roles()

   

        Dim _selectedUserName As String = e.Text.Trim
        Dim _currentUser As MembershipUser = Membership.GetUser(_selectedUserName)
        Dim _currentUserId As Guid = CType(_currentUser.ProviderUserKey, Guid)

        Dim _rolesCollection As IList(Of RadComboBoxItem) = RoleList.Items
        For Each item As RadComboBoxItem In _rolesCollection
            If Roles.IsUserInRole(UserNameList.Text.Trim, item.Text.Trim) Then
                item.Checked = True
            End If
        Next
    End Sub

    Protected Sub ChangeUserPermissionButton_Click(sender As Object, e As EventArgs) Handles ChangeUserPermissionButton.Click
        Try
            If UserNameList.SelectedIndex = -1 Then
                RadAjaxManagerMain.Alert("Please Select The User")
                Exit Sub
            End If

            Dim _selectedUserName As String = UserNameList.Text.Trim
            Dim _currentUser As MembershipUser = Membership.GetUser(_selectedUserName)
            Dim _currentUserId As Guid = CType(_currentUser.ProviderUserKey, Guid)

            Dim Roles_Listt() As String = Roles.GetAllRoles()
            For Each R In Roles_Listt
                If Roles.IsUserInRole(UserNameList.Text.Trim, R) Then Roles.RemoveUserFromRole(UserNameList.Text.Trim, R)
            Next

            Dim RolesCollection As IList(Of RadComboBoxItem) = RoleList.CheckedItems

            Dim Admin As Boolean = False
            For Each item As RadComboBoxItem In RolesCollection
                If item.Text.Trim = "Administration" Then
                    Admin = True
                    Exit For
                End If
            Next

            If Admin = True Then
                Roles.AddUserToRoles(UserNameList.Text.Trim, Roles_Listt)
            Else
                For Each item As RadComboBoxItem In RolesCollection
                    Roles.AddUserToRole(UserNameList.Text.Trim, item.Text.Trim)
                Next
            End If

            'Dim _reset As New UserBranchXmlReset
            'Reset.ResetUserBranchXml()

            Get_Roles()
            UserNameList.ClearSelection()
            RoleList.ClearSelection()
        Catch ex As Exception
            PopMsg.ShowErrorMessage("Error In User Permission")
        End Try
    End Sub
End Class