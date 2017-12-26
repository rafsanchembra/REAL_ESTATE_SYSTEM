Public Class BankAccountUpdateStatusManagement
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            GetAccountStatus()
        End If
    End Sub

    Private Sub CheckUserRoles()
        Dim _currentUser As MembershipUser = Membership.GetUser
        If _currentUser Is Nothing Then
            Response.Redirect("~/Login")
        End If
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)
        Session("UserID") = _currentUserID

        Dim _userRoles = Roles.GetRolesForUser(_currentUser.UserName)

        If Not _userRoles.Contains("Administrator") Then
            FormsAuthentication.SignOut()
            FormsAuthentication.RedirectToLoginPage()
        End If
    End Sub

    Private Sub GetAccountStatus()
        Dim _accountDetails = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Request.QueryString("BankID"))).SingleOrDefault

        ' BankAccountStatusComboBox.SelectedValue = _accountDetails.BankAccountStatus
    End Sub

    Protected Sub AccountStatusSubmitButton_Click(sender As Object, e As EventArgs)
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)
        Dim _userSignature = (From sd In DB.APP_UserProfiles Where sd.UserId = _currentUserID).SingleOrDefault

        If Not UserSignatureTextBox.Text.Trim = _userSignature.UserSignature.Trim Then
            RadAjaxManagerMain.Alert("User Signature Does Not Matching. Please Try Again.")
            Exit Sub
        End If

        Dim _accountDetails = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Request.QueryString("BankID"))).SingleOrDefault

        If _accountDetails.BankAccountStatus = Convert.ToBoolean(BankAccountStatusComboBox.SelectedValue) Then
            RadAjaxManagerMain.Alert("Please Change Bank Account Status.")
            Exit Sub
        End If

        Try
            Dim _BankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Request.QueryString("BankID")) Select sd).ToList()(0)
            If _BankAccount.BankAccountStatus = True And BankAccountStatusComboBox.SelectedValue = False Then
                If _BankAccount.BankAccountTotalBalance <> 0 Then
                    RadAjaxManagerMain.Alert("The Bank Account Balance Should Be Zero Before Freezing The Account.")
                    Exit Sub
                End If
            End If

            With _BankAccount
                .BankAccountStatus = Convert.ToBoolean(BankAccountStatusComboBox.SelectedValue)
                .BankAccountUpdatedBy = _currentUserID
                .BankAccountUpdatedDate = Now
            End With
            DB.SubmitChanges()

            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(System.Web.UI.Page), "Script", "CloseAndRebind();", True)
        Catch ex As Exception
            RadAjaxManagerMain.Alert("Change Bank Account Status Failed.")
            Exit Sub
        End Try
    End Sub
End Class