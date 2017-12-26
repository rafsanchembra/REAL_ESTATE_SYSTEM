Imports Telerik.Web.UI

Public Class Register
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("UserName").Focus()
            Me.Form.DefaultButton = RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("CreateUser").UniqueID
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
        _root4.Text = "Register"
        _root4.Value = "4"
        _root4.Enabled = False
        _radSiteMap.Nodes.Add(_root4)

    End Sub

    Protected Sub RegisterUser_CreateUserError(sender As Object, e As CreateUserErrorEventArgs)
        Select Case Convert.ToString(e.CreateUserError)
            Case MembershipCreateStatus.DuplicateEmail
                PopMsg.ShowWarningMessage("Email Already Exists.")
                Exit Select
            Case MembershipCreateStatus.DuplicateUserName
                PopMsg.ShowWarningMessage("Username Already Exists.")
                Exit Select
        End Select
    End Sub

    Protected Sub RegisterUser_CreatedUser(sender As Object, e As EventArgs)
        Try
            Dim _createdUser As MembershipUser = Membership.GetUser(RegisterUser.UserName)
            Dim _createdUserID As Guid = CType(_createdUser.ProviderUserKey, Guid)

            Dim _UserProfile As New APP_UserProfile
            With _UserProfile
                .UserId = _createdUserID
                .UserSignature = RegisterUser.UserName
                .UserTreasurerExpensesAccount = 0.0
                .UserTreasurerSalesAccount = 0.0
                .UserAccountantExpensesAccount = 0.0
                .UserAccountantSalesAccount = 0.0
            End With
            DB.APP_UserProfiles.InsertOnSubmit(_UserProfile)
            DB.SubmitChanges()
            _UserProfile = Nothing
        Catch ex As Exception
            PopMsg.ShowErrorMessage("Error While Updating User Signature. Please Contact With Administrator.")
            Exit Sub
        End Try
    End Sub
End Class