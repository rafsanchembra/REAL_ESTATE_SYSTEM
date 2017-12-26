Imports Telerik.Web.UI
Imports System.IO
Imports System.Data.SqlClient

Public Class TransferCashBetweenBankAccounts
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            CheckUserRoles()
            ClearData()
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
        _root3.Text = "Bank Managment"
        _root3.Value = "3"
        _root3.NavigateUrl = "~/Forms/Pages/Administrator/Bank.aspx"
        _radSiteMap.Nodes.Add(_root3)


        Dim _root4 As New RadSiteMapNode
        _root4.Text = "Bank Services"
        _root4.Value = "4"
        _root4.NavigateUrl = "~/Forms/Pages/Administrator/bankServices.aspx"
        _radSiteMap.Nodes.Add(_root4)


        Dim _root5 As New RadSiteMapNode
        _root5.Text = "Transfer Cash Between Banks"
        _root5.Value = "5"
        _root5.Enabled = False
        _radSiteMap.Nodes.Add(_root5)

    End Sub

    Private Sub CheckUserRoles()
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)
        Session("UserID") = _currentUserID

        Dim _userRoles = Roles.GetRolesForUser(_currentUser.UserName)

        If Not _userRoles.Contains("BankTransactionBetweenAccounts") Then
            FormsAuthentication.SignOut()
            FormsAuthentication.RedirectToLoginPage()
        End If
    End Sub

   
    Private Sub RemoveSession()
        Session.Remove("SenderBankID")
        Session.Remove("RecieveBankID")
        Session.Remove("SenderBankAccountID")
        Session.Remove("TransactionCopy")
        Session.Remove("TransactionID")
        Session.Remove("OldSenderBank")
        Session.Remove("OldSenderBankAccount")
        Session.Remove("OldRecieveBank")
        Session.Remove("OldRecieveBankAccount")
        Session.Remove("OldTransactionAmount")
        Session.Remove("OldDocumentNumber")
        Session.Remove("OldTransactionStatus")
        Session.Remove("NewTransactionStatus")
        Session.Remove("NewTransactionAmount")
        Session.Remove("NewSenderBankAccount")
        Session.Remove("NewRecieveBankAccount")
    End Sub

    Private Sub ClearData()
        TransactionSenderBankComboBox.ClearSelection()
        TransactionSenderBankComboBox.Items.Clear()
        TransactionSenderBankComboBox.DataBind()

        TransactionSenderBankAccountComboBox.ClearSelection()
        TransactionSenderBankAccountComboBox.Items.Clear()

        TransactionRecieveBankComboBox.ClearSelection()
        TransactionRecieveBankComboBox.Items.Clear()
        TransactionRecieveBankComboBox.DataBind()

        TransactionRecieveBankAccountComboBox.ClearSelection()
        TransactionRecieveBankAccountComboBox.Items.Clear()

        TransactionDocumentDateDatePicker.SelectedDate = Today

        TransactionDocumentTypeComboBox.ClearSelection()
        TransactionDocumentNumberTextBox.Text = ""
        TransactionAmountTextBox.Value = 0
        TransactionMemoTextBox.Text = ""

        SenderBankAccountTotalTextBox.Value = 0
        RecieveBankAccountTotalTextBox.Value = 0

        TransactionBetweenBankAccountsRadGrid.DataBind()

        RemoveSession()
    End Sub

    Protected Sub TransactionSenderBankComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Session("SenderBankID") = e.Value

        TransactionSenderBankAccountComboBox.ClearSelection()
        TransactionSenderBankAccountComboBox.Items.Clear()
        TransactionSenderBankAccountComboBox.DataBind()
    End Sub

    Protected Sub TransactionSenderBankAccountComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim _SenderBankAccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(e.Value)).SingleOrDefault
        SenderBankAccountTotalTextBox.Value = _SenderBankAccountInfo.BankAccountTotalBalance

        Session("SenderBankAccountID") = e.Value

        TransactionRecieveBankComboBox.ClearSelection()
        TransactionRecieveBankComboBox.Items.Clear()
        TransactionRecieveBankComboBox.DataBind()

        TransactionRecieveBankAccountComboBox.ClearSelection()
        TransactionRecieveBankAccountComboBox.Items.Clear()
    End Sub

    Protected Sub TransactionRecieveBankComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Session("RecieveBankID") = e.Value

        TransactionRecieveBankAccountComboBox.ClearSelection()
        TransactionRecieveBankAccountComboBox.Items.Clear()
        TransactionRecieveBankAccountComboBox.DataBind()
    End Sub

    Protected Sub TransactionRecieveBankAccountComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim _RecieveBankAccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(e.Value)).SingleOrDefault
        RecieveBankAccountTotalTextBox.Value = _RecieveBankAccountInfo.BankAccountTotalBalance
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        If TransactionAmountTextBox.Value <= 0 Then
            PopMsg.ShowWarningMessage("Please Enter The Transaction Amount.")
            Exit Sub
        End If

        Dim _treasurerInfo = (From sd In DB.APP_UserProfiles Where sd.UserId = Session("UserID")).SingleOrDefault()

        If Not _treasurerInfo Is Nothing Then
            If Not TreasurerSignatureTextBox.Text = _treasurerInfo.UserSignature Then
                PopMsg.ShowWarningMessage("Treasurer Signature Not Matching Please Try Again.")
                Exit Sub
            End If
        Else
            PopMsg.ShowErrorMessage("Error Found On The System. Please Contact The Administrator.")
            Exit Sub
        End If

        Dim _transactionNumbertInfo = From sd In DB.APP_BankAccountTransactions
                               Where sd.APP_BankAccount.BankID = Convert.ToInt64(TransactionSenderBankComboBox.SelectedValue)
                               Select sd.TransactionDocumentNumber.Trim

        If _transactionNumbertInfo.Contains(TransactionDocumentNumberTextBox.Text.Trim) Then
            PopMsg.ShowWarningMessage("Document Number Already Exists With Sender Bank.")
            Exit Sub
        End If

        Try
            Dim _TransactionID

            Dim _NewBankTransactionBetweenAccount As New APP_BankTransactionBetweenAccount
            With _NewBankTransactionBetweenAccount
                .TransactionSenderBankAccountID = Convert.ToInt64(TransactionSenderBankAccountComboBox.SelectedValue)
                .TransactionReceiveBankAccountID = Convert.ToInt64(TransactionRecieveBankAccountComboBox.SelectedValue)
                .TransactionAmount = TransactionAmountTextBox.Value
                .TransactionDocumentType = TransactionDocumentTypeComboBox.SelectedValue
                .TransactionDocumentDate = TransactionDocumentDateDatePicker.SelectedDate
                .TransactionDocumentNumber = TransactionDocumentNumberTextBox.Text.Trim
                .TransactionMemo = TransactionMemoTextBox.Text.Trim
                .TransactionStatus = True
                .TransactionAddedBy = Session("UserID")
                .TransactionAddedDate = Now
            End With
            DB.APP_BankTransactionBetweenAccounts.InsertOnSubmit(_NewBankTransactionBetweenAccount)
            DB.SubmitChanges()
            _TransactionID = _NewBankTransactionBetweenAccount.ID
            _NewBankTransactionBetweenAccount = Nothing

            Dim _updateSenderBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(TransactionSenderBankAccountComboBox.SelectedValue)).SingleOrDefault
            With _updateSenderBankAccount
                .BankAccountTotalBalance -= TransactionAmountTextBox.Value
            End With
            DB.SubmitChanges()

            Dim _updateReceiveBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(TransactionRecieveBankAccountComboBox.SelectedValue)).SingleOrDefault
            With _updateReceiveBankAccount
                .BankAccountTotalBalance += TransactionAmountTextBox.Value
            End With
            DB.SubmitChanges()

            SaveTransactionAttachment(_TransactionID)

            If Not Session("TransactionCopy") = "NULL" Then
                Dim _UpdateBankTransactionBetweenAccount = (From sd In DB.APP_BankTransactionBetweenAccounts Where sd.ID = Convert.ToInt64(_TransactionID)).ToList()(0)
                With _UpdateBankTransactionBetweenAccount
                    .TransactionAttachment = Session("TransactionCopy")
                End With
                DB.SubmitChanges()
            End If

            ClearData()
        Catch ex As Exception
            PopMsg.ShowErrorMessage("Error Found On The System. Please Contact The Administrator.")
            Exit Sub
        End Try
    End Sub

    Private Sub SaveTransactionAttachment(_transactionID As String)
        Session("TransactionCopy") = "NULL"

        Dim AttachmentPath As String = "~/Attachments/Treasurer/BankTransactionBetweenAccount/"

        If Not Directory.Exists(Server.MapPath(AttachmentPath)) Then
            Directory.CreateDirectory(Server.MapPath(AttachmentPath))
        End If

        If Not TransactionAttachmentUpload.UploadedFiles.Count = 0 Then
            Dim _targetFolder As String = Server.MapPath(AttachmentPath)
            For Each validFile As UploadedFile In TransactionAttachmentUpload.UploadedFiles
                Dim FileToBeSaved As String = _transactionID & validFile.GetExtension
                Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                If File.Exists(FullPath) Then
                    File.Delete(FullPath)
                End If
                validFile.SaveAs(FullPath, True)
                Session("TransactionCopy") = AttachmentPath + FileToBeSaved
            Next
        End If
    End Sub

    Protected Sub TransactionBetweenBankAccountsRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_TransactionBetweenBankAccounts") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If

        If TypeOf e.Item Is GridEditableItem AndAlso e.Item.IsInEditMode Then
            Dim _editedItem As GridEditableItem = TryCast(e.Item, GridEditableItem)

            Dim _SenderBankAccount As RadComboBox = DirectCast(_editedItem.FindControl("TransactionSenderBankAccountGridComboBox"), RadComboBox)
            Session("SenderBankID") = Session("OldSenderBank")
            _SenderBankAccount.ClearSelection()
            _SenderBankAccount.Items.Clear()
            _SenderBankAccount.DataBind()
            _SenderBankAccount.SelectedValue = Session("OldSenderBankAccount")
            Session("SenderBankAccountID") = _SenderBankAccount.SelectedValue
            Dim _SenderBankAccountTotal As RadNumericTextBox = DirectCast(_editedItem.FindControl("SenderBankAccountTotalGridTextBox"), RadNumericTextBox)
            Dim _SenderBankAccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_SenderBankAccount.SelectedValue)).SingleOrDefault
            _SenderBankAccountTotal.Value = _SenderBankAccountInfo.BankAccountTotalBalance

            Dim _RecieveBank As RadComboBox = DirectCast(_editedItem.FindControl("TransactionRecieveBankGridComboBox"), RadComboBox)
            _RecieveBank.ClearSelection()
            _RecieveBank.Items.Clear()
            _RecieveBank.DataBind()
            _RecieveBank.SelectedValue = Session("OldRecieveBank")
            Session("RecieveBankID") = _RecieveBank.SelectedValue
            Dim _RecieveBankAccount As RadComboBox = DirectCast(_editedItem.FindControl("TransactionRecieveBankAccountGridComboBox"), RadComboBox)
            _RecieveBankAccount.ClearSelection()
            _RecieveBankAccount.Items.Clear()
            _RecieveBankAccount.DataBind()
            _RecieveBankAccount.SelectedValue = Session("OldRecieveBankAccount")
            Dim _RecieveBankAccountTotal As RadNumericTextBox = DirectCast(_editedItem.FindControl("RecieveBankAccountTotalGridTextBox"), RadNumericTextBox)
            Dim _RecieveBankAccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_RecieveBankAccount.SelectedValue)).SingleOrDefault
            _RecieveBankAccountTotal.Value = _RecieveBankAccountInfo.BankAccountTotalBalance
        End If
    End Sub

    Protected Sub TransactionBetweenBankAccountsRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "Edit"
                RemoveSession()
                e.Item.OwnerTableView.IsItemInserted = False
                Exit Select
        End Select
    End Sub

    Protected Sub TransactionSenderBankGridComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim _BankAccount As RadComboBox = DirectCast(DirectCast(DirectCast(sender, RadComboBox).NamingContainer, GridEditFormItem).FindControl("TransactionSenderBankAccountGridComboBox"), RadComboBox)

        Session("SenderBankID") = e.Value

        _BankAccount.ClearSelection()
        _BankAccount.Items.Clear()
        _BankAccount.DataBind()
    End Sub

    Protected Sub TransactionSenderBankAccountGridComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim _SenderBankAccountTotal As RadNumericTextBox = DirectCast(DirectCast(DirectCast(sender, RadComboBox).NamingContainer, GridEditFormItem).FindControl("SenderBankAccountTotalGridTextBox"), RadNumericTextBox)
        Dim _RecieveBank As RadComboBox = DirectCast(DirectCast(DirectCast(sender, RadComboBox).NamingContainer, GridEditFormItem).FindControl("TransactionRecieveBankGridComboBox"), RadComboBox)
        Dim _RecieveBankAccount As RadComboBox = DirectCast(DirectCast(DirectCast(sender, RadComboBox).NamingContainer, GridEditFormItem).FindControl("TransactionRecieveBankAccountGridComboBox"), RadComboBox)

        Dim _SenderBankAccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(e.Value)).SingleOrDefault
        _SenderBankAccountTotal.Value = _SenderBankAccountInfo.BankAccountTotalBalance

        Session("SenderBankAccountID") = e.Value

        _RecieveBank.ClearSelection()
        _RecieveBank.Items.Clear()
        _RecieveBank.DataBind()

        _RecieveBankAccount.ClearSelection()
        _RecieveBankAccount.Items.Clear()
    End Sub

    Protected Sub TransactionRecieveBankGridComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim _BankAccount As RadComboBox = DirectCast(DirectCast(DirectCast(sender, RadComboBox).NamingContainer, GridEditFormItem).FindControl("TransactionRecieveBankAccountGridComboBox"), RadComboBox)

        Session("RecieveBankID") = e.Value

        _BankAccount.ClearSelection()
        _BankAccount.Items.Clear()
        _BankAccount.DataBind()
    End Sub

    Protected Sub TransactionRecieveBankAccountGridComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim _RecieveBankAccountTotal As RadNumericTextBox = DirectCast(DirectCast(DirectCast(sender, RadComboBox).NamingContainer, GridEditFormItem).FindControl("RecieveBankAccountTotalGridTextBox"), RadNumericTextBox)

        Dim _SenderBankAccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(e.Value)).SingleOrDefault
        _RecieveBankAccountTotal.Value = _SenderBankAccountInfo.BankAccountTotalBalance
    End Sub

    Protected Sub TransactionBetweenBankAccountsRadGrid_EditCommand(sender As Object, e As GridCommandEventArgs)
        Dim _gridDataItem As GridDataItem = DirectCast(e.Item, GridDataItem)

        Session("TransactionID") = _gridDataItem("ID").Text
        Session("OldSenderBank") = _gridDataItem("TransactionSenderBankID").Text
        Session("OldSenderBankAccount") = _gridDataItem("TransactionSenderBankAccountID").Text
        Session("OldRecieveBank") = _gridDataItem("TransactionReceiveBankID").Text
        Session("OldRecieveBankAccount") = _gridDataItem("TransactionReceiveBankAccountID").Text
        Session("OldTransactionAmount") = _gridDataItem("TransactionAmount").Text
        Session("OldDocumentNumber") = _gridDataItem("TransactionDocumentNumber").Text
        Session("OldTransactionType") = _gridDataItem("TransactionDocumentType").Text
        Session("OldTransactionStatus") = _gridDataItem("TransactionStatusName").Text
    End Sub

    Protected Sub TransactionBetweenBankAccountsRadGrid_UpdateCommand(sender As Object, e As GridCommandEventArgs)
        Dim _editedItem As GridEditableItem = TryCast(e.Item, GridEditableItem)

        Dim _treasurerSignature As RadTextBox = DirectCast(_editedItem.FindControl("TreasurerSignatureGridTextBox"), RadTextBox)
        Dim _transactionStatus As RadComboBox = DirectCast(_editedItem.FindControl("TransactionStatusGridComboBox"), RadComboBox)

        Dim _newSenderBank As RadComboBox = DirectCast(_editedItem.FindControl("TransactionSenderBankGridComboBox"), RadComboBox)
        Dim _newRecieveBank As RadComboBox = DirectCast(_editedItem.FindControl("TransactionRecieveBankGridComboBox"), RadComboBox)

        Dim _newSenderBankAccount As RadComboBox = DirectCast(_editedItem.FindControl("TransactionSenderBankAccountGridComboBox"), RadComboBox)
        Dim _newRecieveBankAccount As RadComboBox = DirectCast(_editedItem.FindControl("TransactionRecieveBankAccountGridComboBox"), RadComboBox)

        Dim _newDocumentNumber As RadTextBox = DirectCast(_editedItem.FindControl("TransactionDocumentNumberGridTextBox"), RadTextBox)
        Dim _transactionAmount As RadNumericTextBox = DirectCast(_editedItem.FindControl("TransactionAmountGridTextBox"), RadNumericTextBox)

        Session("NewRecieveBank") = _newRecieveBank.SelectedValue

        If _transactionAmount.Value <= 0 Then
            PopMsg.ShowWarningMessage("The Transaction Amount Should Be Greater Than Zero (0).")
            e.Canceled = True
            Exit Sub
        End If

        Dim _oldDocumentNumber = Session("OldDocumentNumber")
        Dim _oldSenderBank = Session("OldSenderBank")

        If _oldSenderBank = _newSenderBank.SelectedValue And Not _oldDocumentNumber = _newDocumentNumber.Text.Trim Then
            Dim _transactionNumbertInfo = From sd In DB.APP_BankTransactionBetweenAccounts
                                   Where sd.APP_BankAccount1.BankID = Convert.ToInt64(_oldSenderBank)
                                   Select sd.TransactionDocumentNumber.Trim

            If _transactionNumbertInfo.Contains(TransactionDocumentNumberTextBox.Text.Trim) Then
                PopMsg.ShowWarningMessage("Document Number Already Exists To This Bank.")
                Exit Sub
            End If
        End If

        Dim _treasurerInfo = (From sd In DB.APP_UserProfiles Where sd.UserId = Session("UserID")).SingleOrDefault

        If Not _treasurerInfo Is Nothing Then
            If Not _treasurerSignature.Text = _treasurerInfo.UserSignature Then
                PopMsg.ShowWarningMessage("Treasurer Signature Not Matching Please Try Again.")
                e.Canceled = True
                Exit Sub
            End If
        Else
            PopMsg.ShowErrorMessage("Error Found On The System. Please Contact The Administrator.")
            e.Canceled = True
            Exit Sub
        End If

        Dim _newTransactionStatus
        Dim _oldTransactionStatus = Session("OldTransactionStatus")

        If _transactionStatus.SelectedValue = True Then _newTransactionStatus = "Active" Else _newTransactionStatus = "Freezed"
        Session("NewTransactionStatus") = _newTransactionStatus
        Session("NewTransactionAmount") = _transactionAmount.Value

        Session("NewSenderBankAccount") = _newSenderBankAccount.SelectedValue
        Session("NewRecieveBankAccount") = _newRecieveBankAccount.SelectedValue

        GridSaveTransactionAttachment(_editedItem, Session("TransactionID").ToString)
    End Sub

    Private Sub TransactionBetweenBankAccountsRadGrid_ItemUpdated(sender As Object, e As GridUpdatedEventArgs) Handles TransactionBetweenBankAccountsRadGrid.ItemUpdated
        Try
            Dim _OldTransactionAmount As Decimal = Convert.ToDecimal(Session("OldTransactionAmount"))
            Dim _NewTransactionAmount As Decimal = Convert.ToDecimal(Session("NewTransactionAmount"))

            Dim _newTransactionStatus = Session("NewTransactionStatus")
            Dim _oldTransactionStatus = Session("OldTransactionStatus")

            Dim _oldSenderBankAccount = Session("OldSenderBankAccount")
            Dim _oldRecieveBankAccount = Session("OldRecieveBankAccount")

            Dim _newSenderBankAccount = Session("NewSenderBankAccount")
            Dim _newRecieveBankAccount = Session("NewRecieveBankAccount")

            If _newTransactionStatus = "Active" And _oldTransactionStatus = "Active" Then
                If Not _oldSenderBankAccount = _newSenderBankAccount Then
                    Dim _updateOldSenderBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_oldSenderBankAccount)).SingleOrDefault
                    With _updateOldSenderBankAccount
                        .BankAccountTotalBalance += _OldTransactionAmount
                    End With
                    DB.SubmitChanges()

                    Dim _updateNewSenderBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_newSenderBankAccount)).SingleOrDefault
                    With _updateNewSenderBankAccount
                        .BankAccountTotalBalance -= _NewTransactionAmount
                    End With
                    DB.SubmitChanges()
                End If

                If Not _oldRecieveBankAccount = _newRecieveBankAccount Then
                    Dim _updateOldRecieveBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_oldRecieveBankAccount)).SingleOrDefault
                    With _updateOldRecieveBankAccount
                        .BankAccountTotalBalance -= _OldTransactionAmount
                    End With
                    DB.SubmitChanges()

                    Dim _updateNewRecieveBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_newRecieveBankAccount)).SingleOrDefault
                    With _updateNewRecieveBankAccount
                        .BankAccountTotalBalance += _NewTransactionAmount
                    End With
                    DB.SubmitChanges()
                End If

                If _oldSenderBankAccount = _newSenderBankAccount And _oldRecieveBankAccount = _newRecieveBankAccount Then
                    Dim _balanceAmount = _NewTransactionAmount - _OldTransactionAmount

                    Dim _updateSenderBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_oldSenderBankAccount)).SingleOrDefault
                    With _updateSenderBankAccount
                        .BankAccountTotalBalance -= _balanceAmount
                    End With
                    DB.SubmitChanges()

                    Dim _updateRecieveBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_newRecieveBankAccount)).SingleOrDefault
                    With _updateRecieveBankAccount
                        .BankAccountTotalBalance += _balanceAmount
                    End With
                    DB.SubmitChanges()
                End If
            Else
                If _oldTransactionStatus = "Active" And _newTransactionStatus = "Freezed" Then
                    Dim _updateSenderBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_oldSenderBankAccount)).SingleOrDefault
                    With _updateSenderBankAccount
                        .BankAccountTotalBalance += _OldTransactionAmount
                    End With
                    DB.SubmitChanges()

                    Dim _updateRecieveBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_oldRecieveBankAccount)).SingleOrDefault
                    With _updateRecieveBankAccount
                        .BankAccountTotalBalance -= _OldTransactionAmount
                    End With
                    DB.SubmitChanges()
                ElseIf _oldTransactionStatus = "Freezed" And _newTransactionStatus = "Active" Then
                    Dim _updateSenderBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_newSenderBankAccount)).SingleOrDefault
                    With _updateSenderBankAccount
                        .BankAccountTotalBalance -= _NewTransactionAmount
                    End With
                    DB.SubmitChanges()

                    Dim _updateRecieveBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_newRecieveBankAccount)).SingleOrDefault
                    With _updateRecieveBankAccount
                        .BankAccountTotalBalance += _OldTransactionAmount
                    End With
                    DB.SubmitChanges()
                End If
            End If

            ClearData()
        Catch ex As Exception
            PopMsg.ShowErrorMessage("Error Found On The System. Please Contact The Administrator.")
            Exit Sub
        End Try
    End Sub

    Private Sub GridSaveTransactionAttachment(_editedItem As GridEditableItem, _transactionID As String)
        Session("UpdateTransactionCopy") = "NULL"

        Dim _transactionAttachment As RadAsyncUpload = DirectCast(_editedItem.FindControl("TransactionAttachmentGridUpload"), RadAsyncUpload)

        Dim AttachmentPath As String = "~/Attachments/Treasurer/BankTransactionBetweenAccount/"

        If Not Directory.Exists(Server.MapPath(AttachmentPath)) Then
            Directory.CreateDirectory(Server.MapPath(AttachmentPath))
        End If

        If Not _transactionAttachment.UploadedFiles.Count = 0 Then
            Dim _targetFolder As String = Server.MapPath(AttachmentPath)
            For Each validFile As UploadedFile In _transactionAttachment.UploadedFiles
                Dim FileToBeSaved As String = _transactionID & validFile.GetExtension
                Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                If File.Exists(FullPath) Then
                    File.Delete(FullPath)
                End If
                validFile.SaveAs(FullPath, True)
                Session("UpdateTransactionCopy") = AttachmentPath + FileToBeSaved
            Next
        End If
    End Sub

    Protected Sub SqlDataSource_TransactionBetweenBankAccounts_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource_TransactionBetweenBankAccounts.Updating
        Try
            e.Command.Parameters("@TransactionUpdatedDate").Value = Now
            e.Command.Parameters("@TransactionSenderBankAccountID").Value = Convert.ToInt64(Session("NewSenderBankAccount"))
            e.Command.Parameters("@TransactionReceiveBankAccountID").Value = Convert.ToInt64(Session("NewRecieveBankAccount"))
            e.Command.Parameters("@TransactionReceiveBankID").Value = Convert.ToInt64(Session("NewRecieveBank"))
            If Not Session("UpdateTransactionCopy") = "NULL" Then
                e.Command.Parameters("@TransactionAttachment").Value = Session("UpdateTransactionCopy")
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Protected Sub SqlDataSource_TransactionBetweenBankAccounts_OnUpdating(sender As Object, e As SqlDataSourceCommandEventArgs)
        Dim _UpdatedBy As New SqlParameter("@TransactionUpdatedBy", SqlDbType.UniqueIdentifier)
        _UpdatedBy.Direction = ParameterDirection.Input

        _UpdatedBy.Value = Session("UserID")
        e.Command.Parameters.Add(_UpdatedBy)
    End Sub

End Class