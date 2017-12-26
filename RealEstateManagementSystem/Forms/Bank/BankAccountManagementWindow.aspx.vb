Public Class BankAccountManagementWindow
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ' BankAccountNumberTextBox.Text = Request.QueryString("BankID")
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

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        If Not BankAccountNumberTextBox.Text.Trim = "" Or Not BankAccountArabicNameTextBox.Text.Trim = "" Or Not BankAccountEnglishNameTextBox.Text.Trim = "" Then
            Try
                If Not Check_BankAccountNumber_Exists(BankAccountNumberTextBox.Text.Trim) Then
                    Exit Sub
                End If

                If Not Check_BankAccountArabicName_Exists(BankAccountArabicNameTextBox.Text.Trim) Then
                    Exit Sub
                End If

                If Not Check_BankAccountEnglishName_Exists(BankAccountEnglishNameTextBox.Text.Trim) Then
                    Exit Sub
                End If

                Dim _currentUser As MembershipUser = Membership.GetUser
                Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

                Dim _NewBankAccount As New APP_BankAccount
                With _NewBankAccount
                    .BankID = Request.QueryString("BankID")
                    .BankAccountNumber = BankAccountNumberTextBox.Text.Trim
                    .BankAccountArabicName = BankAccountArabicNameTextBox.Text.Trim
                    .BankAccountEnglishName = BankAccountEnglishNameTextBox.Text.Trim
                    .BankAccountMemo = BankAccountMemoTextBox.Text.Trim
                    .BankAccountOpeningBalance = 0
                    .BankAccountTotalBalance = 0
                    .BankAccountStatus = True
                    .BankAccountAddedBy = _currentUserID
                    .BankAccountAddedDate = Now
                End With
                DB.APP_BankAccounts.InsertOnSubmit(_NewBankAccount)
                DB.SubmitChanges()
                _NewBankAccount = Nothing

                BankAccountNumberTextBox.Text = ""
                BankAccountArabicNameTextBox.Text = ""
                BankAccountEnglishNameTextBox.Text = ""
                BankAccountMemoTextBox.Text = ""

                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(System.Web.UI.Page), "Script", "CloseAndRebind();", True)
            Catch ex As Exception
                RadAjaxManagerMain.Alert("Create New Bank Account Has Been Failed.")
                Exit Sub
            End Try
        Else
            Exit Sub
        End If
    End Sub

#Region "Check Data Exists"

    Private Function Check_BankAccountNumber_Exists(_BankAccountNumber As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_BankAccounts Where sd.BankID = Convert.ToInt64(Page.RouteData.Values("BankID")) Select sd.BankAccountNumber.Trim

            If _info.Contains(_BankAccountNumber.Trim) Then
                RadAjaxManagerMain.Alert("Bank Account Number Already Exists For This Bank.")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Private Function Check_BankAccountArabicName_Exists(_BankAccountArabicName As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_BankAccounts Where sd.BankID = Convert.ToInt64(Page.RouteData.Values("BankID")) Select sd.BankAccountArabicName.Trim

            If _info.Contains(_BankAccountArabicName.Trim) Then
                RadAjaxManagerMain.Alert("Bank Account Arabic Name Already Exists.")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Private Function Check_BankAccountEnglishName_Exists(_BankAccountEnglishName As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_BankAccounts Where sd.BankID = Convert.ToInt64(Page.RouteData.Values("BankID")) Select sd.BankAccountEnglishName.Trim

            If _info.Contains(_BankAccountEnglishName.Trim) Then
                RadAjaxManagerMain.Alert("Bank English Name Already Exists.")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

#End Region

End Class