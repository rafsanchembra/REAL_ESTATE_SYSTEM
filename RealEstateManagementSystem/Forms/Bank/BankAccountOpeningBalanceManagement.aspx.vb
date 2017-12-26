Public Class BankAccountOpeningBalanceManagement
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            GetBankAccountDetails()
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

    Private Sub GetBankAccountDetails()
        Try
            Dim _AccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Request.QueryString("BankID"))).ToList()(0)
            With _AccountInfo
                If Not String.IsNullOrEmpty(.BankAccountOpeningBalanceMemo) Then OldBankAccountOpeningBalanceMemoTextBox.Text = .BankAccountOpeningBalanceMemo.Trim
                If .BankAccountOpeningBalance Is Nothing Then
                    OldOpeningBalanceTextBox.Value = 0
                Else
                    OldOpeningBalanceTextBox.Value = .BankAccountOpeningBalance
                End If
            End With
            _AccountInfo = Nothing
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub

    Protected Sub OpeningBalanceSubmitButton_Click(sender As Object, e As EventArgs)
        Try
            Dim _currentUser As MembershipUser = Membership.GetUser
            Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

            Dim _userDetails = (From sd In DB.APP_UserProfiles Where sd.UserId = _currentUserID).SingleOrDefault

            If Not _userDetails.UserSignature.Trim = OpeningBalanceUserSignatureTextBox.Text.Trim Then
                RadAjaxManagerMain.Alert("User Signature Does Not Matching. Please Try Again.")
                Exit Sub
            End If

            ManageBankAccountOpeningBalance(_currentUser.UserName.Trim, _currentUserID)
        Catch ex As Exception
            RadAjaxManagerMain.Alert(ex.ToString)
            Exit Sub
        End Try
        System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(System.Web.UI.Page), "Script", "CloseAndRebind();", True)
    End Sub

    Private Sub ManageBankAccountOpeningBalance(_currentUserName As String, _currentUserID As Guid)
        Try
            Dim _Report As String = NewBankAccountOpeningBalanceMemoTextBox.Text.Trim + Environment.NewLine
            Dim _OldOpeningBalance As Decimal = 0
            Dim _BankAccountID As Int64 = Convert.ToInt64(Request.QueryString("BankID"))

            Dim _AccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = _BankAccountID).ToList()(0)
            With _AccountInfo
                If .BankAccountOpeningBalanceAddedDate.HasValue Then
                    _OldOpeningBalance = .BankAccountOpeningBalance

                    Select Case _OldOpeningBalance
                        Case Is = 0
                            .BankAccountTotalBalance += NewOpeningBalanceTextBox.Value
                        Case Is > NewOpeningBalanceTextBox.Value
                            .BankAccountTotalBalance -= (_OldOpeningBalance - NewOpeningBalanceTextBox.Value)
                        Case Is < NewOpeningBalanceTextBox.Value
                            .BankAccountTotalBalance += (NewOpeningBalanceTextBox.Value - _OldOpeningBalance)
                    End Select

                    _Report += String.Format("Old Opening Balance = {0:RO 0.000}{1}", _OldOpeningBalance, Environment.NewLine)
                    _Report += String.Format("New Opening Balance =  {0:RO 0.000}{1}", NewOpeningBalanceTextBox.Value, Environment.NewLine)
                    _Report += String.Format("Updated By: {0}{1}", _currentUserName, Environment.NewLine)
                    _Report += String.Format("Updated On: {0}{1}", Now, Environment.NewLine)

                    .BankAccountOpeningBalanceUpdatedBy = _currentUserID
                    .BankAccountOpeningBalanceUpdatedDate = Now
                Else
                    _Report += String.Format("New Opening Balance =  {0:RO 0.000}{1}", NewOpeningBalanceTextBox.Value, Environment.NewLine)
                    _Report += String.Format("Added By: {0}{1}", _currentUserName, Environment.NewLine)
                    _Report += String.Format("Added On: {0}{1}", Now, Environment.NewLine)

                    .BankAccountOpeningBalanceAddedBy = _currentUserID
                    .BankAccountOpeningBalanceAddedDate = Now
                    .BankAccountTotalBalance += NewOpeningBalanceTextBox.Value
                End If
                _Report += String.Format("***********************************{0}{1}{2}", Environment.NewLine, Environment.NewLine, Environment.NewLine)

                .BankAccountOpeningBalanceMemo += _Report
                .BankAccountOpeningBalance = NewOpeningBalanceTextBox.Value

            End With
            DB.SubmitChanges()
            _AccountInfo = Nothing

            ClearData()
            Exit Sub
        Catch ex As Exception

        End Try
    End Sub

    Private Sub ClearData()
        OldBankAccountOpeningBalanceMemoTextBox.Text = ""
        OldOpeningBalanceTextBox.Value = 0
        NewBankAccountOpeningBalanceMemoTextBox.Text = ""
        NewOpeningBalanceTextBox.Value = 0
        OpeningBalanceUserSignatureTextBox.Text = ""

        GetBankAccountDetails()
    End Sub

End Class