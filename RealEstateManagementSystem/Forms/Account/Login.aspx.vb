Imports Telerik.Web.UI
Imports System.IO




Public Class Login
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Me.Form.DefaultButton = UserLogin.FindControl("LoginButton").UniqueID
            UserLogin.FindControl("UserName").Focus()
        End If
    End Sub

    Protected Sub UserLogin_LoginError(sender As Object, e As EventArgs)
        Dim _currentUser As MembershipUser = Membership.GetUser(UserLogin.UserName)
        If _currentUser Is Nothing Then
            PopMsg.ShowWarningMessage("Invalid UserName. Please Try Again.")
        Else
            If _currentUser.IsApproved = False Then
                PopMsg.ShowWarningMessage("Your Account Has Not Yet Been Approved By An Administrator.")
            ElseIf _currentUser.IsLockedOut = True Then
                PopMsg.ShowWarningMessage("You Have Been Locked Out, Please Contact Administrator.")
            Else
                PopMsg.ShowWarningMessage("Invalid Password. Please Try Again.")
            End If
        End If
    End Sub

    Protected Sub UserLogin_LoggedIn(sender As Object, e As EventArgs)
        Dim _currentUser As MembershipUser = Membership.GetUser(UserLogin.UserName)
        If Not _currentUser Is Nothing Then
            Response.Redirect("~/", True)
        End If
    End Sub

    Private Sub ClearAllData()

        DB.PROC_ClearAllData()

        Dim UsersInRoles = From sd In DB.UsersInRoles Select sd
        DB.UsersInRoles.DeleteAllOnSubmit(UsersInRoles)
        DB.SubmitChanges()
        UsersInRoles = Nothing

        ' Table Name : Memberships
        Dim _members As MembershipUserCollection = Membership.GetAllUsers

        For Each _member As MembershipUser In _members
            Membership.DeleteUser(_member.UserName)
        Next

        ' Table Name : Users
        Dim Users = From sd In DB.Users Select sd
        DB.Users.DeleteAllOnSubmit(Users)
        DB.SubmitChanges()
        Users = Nothing

        Dim _createStatus As MembershipCreateStatus

        Dim passwordQuestion As String = "NULL"
        Dim passwordAnswer As String = "NULL"

        If Membership.RequiresQuestionAndAnswer Then
            passwordQuestion = "Your Favourite Vehicle?"
            passwordAnswer = "ALL NEW BMW X5 2014"
        End If

        Dim _NewUser As MembershipUser = Membership.CreateUser("admin", "admin", "mohammed.chembra@samad-global.com", passwordQuestion, passwordAnswer, True, _createStatus)

        Select Case _createStatus
            Case MembershipCreateStatus.Success
                Dim _NewUserID As Guid = CType(_NewUser.ProviderUserKey, Guid)

                Dim _applicationName = System.Web.Security.Membership.ApplicationName

                Dim _applicationID As Guid

                DB.PROC_GetApplicationID(_applicationName, _applicationID)

                Dim _Roles = From sd In DB.Roles

                For Each _Role In _Roles
                    Dim _NewUsersInRole As New UsersInRole
                    With _NewUsersInRole
                        .UserId = _NewUserID
                        .RoleId = _Role.RoleId
                    End With
                    DB.UsersInRoles.InsertOnSubmit(_NewUsersInRole)
                    DB.SubmitChanges()
                    _NewUsersInRole = Nothing
                Next

                Dim _NewUserProfile As New APP_UserProfile
                With _NewUserProfile
                    .UserId = _NewUserID
                    .UserSignature = "admin"
                    .UserTreasurerExpensesAccount = 0.0
                    .UserTreasurerSalesAccount = 0.0
                    .UserAccountantExpensesAccount = 0.0
                    .UserAccountantSalesAccount = 0.0
                End With
                DB.APP_UserProfiles.InsertOnSubmit(_NewUserProfile)
                DB.SubmitChanges()

                Dim _systemDetail As New SystemDetail
                With _systemDetail
                    .ApplicationID = _applicationID
                End With
                DB.SystemDetails.InsertOnSubmit(_systemDetail)
                DB.SubmitChanges()

                Try
                    Dim _FolderList As New List(Of String)
                    _FolderList.Add("~/Attachment")
                    _FolderList.Add("~/AttachmentTemp")

                    For Each _item In _FolderList
                        Dim _CurrentFolder As DirectoryInfo = New DirectoryInfo(Server.MapPath(_item))
                        If _CurrentFolder.Exists Then
                            _CurrentFolder.Delete(True)
                        End If
                    Next
                Catch ex As Exception
                    PopMsg.ShowErrorMessage(ex.Message)
                End Try
        End Select

        FormsAuthentication.SignOut()
        FormsAuthentication.RedirectToLoginPage()
    End Sub

    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        ClearAllData()
    End Sub
End Class