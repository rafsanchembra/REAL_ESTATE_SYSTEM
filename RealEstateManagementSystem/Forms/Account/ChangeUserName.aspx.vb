Imports Telerik.Web.UI

Public Class ChangeUserName
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Me.Form.DefaultButton = ChangeUsernameButton.UniqueID
            BindUsersToUserList()
            UsersListComboBox.ClearSelection()
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
        _root4.Text = "Change User Name"
        _root4.Value = "4"
        _root4.Enabled = False
        _radSiteMap.Nodes.Add(_root4)

    End Sub
    Private Sub BindUsersToUserList()
        UsersListComboBox.Items.Clear()
        Dim Users As MembershipUserCollection = Membership.GetAllUsers()
        Dim CurrentUser As MembershipUser = Membership.GetUser()
        Users.Remove(CurrentUser.UserName.Trim)
        UsersListComboBox.DataSource = Users
        UsersListComboBox.DataBind()
    End Sub

    Protected Sub UsersListComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        Dim _SelectedUserName As String = e.Text.Trim
        Dim _CurrentUser As MembershipUser = Membership.GetUser(_SelectedUserName)
        SelectedUserTextBox.Text = _CurrentUser.UserName
    End Sub

    Protected Sub ChangeUsernameButton_Click(sender As Object, e As EventArgs)
        If NewUserName.Text.Trim = ConfirmNewUserName.Text.Trim Then
            If Not LCase(SelectedUserTextBox.Text.Trim) = LCase(NewUserName.Text.Trim) Then
                If Not IsNothing(Membership.GetUser(NewUserName.Text.Trim)) Then
                    PopMsg.ShowWarningMessage("User Name Already Exists.")
                    Exit Sub
                End If
            End If

            Try
                Dim _SelectedUserName As String = SelectedUserTextBox.Text.Trim
                Dim _CurrentUser As MembershipUser = Membership.GetUser(_SelectedUserName)
                Dim _CurrentUserId As Guid = CType(_CurrentUser.ProviderUserKey, Guid)

                Dim Info = (From sd In DB.Users Where sd.UserId = _CurrentUserId).ToList()(0)
                With Info
                    .UserName = NewUserName.Text.Trim
                End With
                DB.SubmitChanges()
                Info = Nothing
                SelectedUserTextBox.Text = ""
                NewUserName.Text = ""
                ConfirmNewUserName.Text = ""

                UsersListComboBox.ClearSelection()
                BindUsersToUserList()
            Catch ex As Exception
                PopMsg.ShowErrorMessage("Change Username Failed.")
                Exit Sub
            End Try
        End If
    End Sub
End Class