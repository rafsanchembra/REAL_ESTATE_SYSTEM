Imports Telerik.Web.UI

Public Class ChangeUserSignature
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        BindUsersToUserList()
        If Not IsPostBack Then
            Me.Form.DefaultButton = ChangeUserSignatureButton.UniqueID
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
        _root4.Text = "change user signature"
        _root4.Value = "4"
        _root4.Enabled = False
        _radSiteMap.Nodes.Add(_root4)

    End Sub
    Private Sub BindUsersToUserList()
        UserNameList.Items.Clear()
        Dim _Users As MembershipUserCollection = Membership.GetAllUsers()
        Dim _CurrentUser As MembershipUser = Membership.GetUser()
        _Users.Remove(_CurrentUser.UserName.Trim)
        UserNameList.DataSource = _Users
        UserNameList.DataBind()
    End Sub

    Protected Sub ChangeUserSignatureButton_Click(sender As Object, e As EventArgs) Handles ChangeUserSignatureButton.Click
        If NewUserSignature.Text.Trim = "" Then
            Exit Sub
        End If
        If Not NewUserSignature.Text.Trim = ConfirmNewUserSignature.Text.Trim Then
            Exit Sub
        End If

        Dim _SelecetedUserName As String = UserNameList.Text.Trim
        Dim _CurrentUser As MembershipUser = Membership.GetUser(_SelecetedUserName)
        Dim _CurrentUserId As Guid = CType(_CurrentUser.ProviderUserKey, Guid)

        Dim Info = (From sd In DB.APP_UserProfiles Where sd.UserId = _CurrentUserId).ToList()(0)
        With Info
            .UserSignature = NewUserSignature.Text.Trim
        End With
        DB.SubmitChanges()
        Info = Nothing

        NewUserSignature.Text = ""
        ConfirmNewUserSignature.Text = ""
    End Sub
End Class