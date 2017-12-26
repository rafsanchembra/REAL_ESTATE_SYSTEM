Imports System.IO
Imports Telerik.Web.UI
Imports System.Data.SqlClient

Public Class BankAccountTransaction
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ClearData()
            CheckUserRoles()
            SetComboBox()
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
        _root5.Text = "Bank account transaction"
        _root5.Value = "5"
        _root5.Enabled = False
        _radSiteMap.Nodes.Add(_root5)

    End Sub
    Private Sub CheckUserRoles()
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)
        Session("UserID") = _currentUserID

        Dim _userRoles = Roles.GetRolesForUser(_currentUser.UserName)

        If Not _userRoles.Contains("BankAccountTransactionIN") And Not _userRoles.Contains("BankAccountTransactionOUT") Then
            FormsAuthentication.SignOut()
            FormsAuthentication.RedirectToLoginPage()
        End If
    End Sub

    Private Sub SetComboBox()
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _userRoles = Roles.GetRolesForUser(_currentUser.UserName)

        Dim _x As New RadComboBoxItem
        _x.Value = "In"
        _x.Text = "In"
        If Not _userRoles.Contains("BankAccountTransactionIN") Then
            _x.Enabled = False
        End If
        Dim _y As New RadComboBoxItem
        _y.Value = "Out"
        _y.Text = "Out"
        If Not _userRoles.Contains("BankAccountTransactionOUT") Then
            _y.Enabled = False
        End If

        TransactionTypeComboBox.Items.Add(_x)
        TransactionTypeComboBox.Items.Add(_y)
    End Sub

  

    Private Sub RemoveSession()
        Session.Remove("TransactionCopy")
        Session.Remove("TransactionID")
        Session.Remove("OldBank")
        Session.Remove("BankID")
        Session.Remove("OldBankAccount")
        Session.Remove("OldDocumentNumber")
        Session.Remove("OldTransactionStatus")
        Session.Remove("TransactionType")
    End Sub

    Private Sub ClearData()
        TransactionBankComboBox.ClearSelection()
        TransactionBankComboBox.Items.Clear()
        TransactionBankComboBox.DataBind()

        TransactionBankAccountComboBox.ClearSelection()
        TransactionBankAccountComboBox.Items.Clear()

        TransactionTypeComboBox.ClearSelection()
        TransactionDocumentNumberTextBox.Text = ""
        BankAccountTotalTextBox.Value = 0
        TransactionAmountTextBox.Value = 0

        TransactionDocumentDateDatePicker.SelectedDate = Today
        TransactionTypeComboBox.ClearSelection()

        TransactionMemoTextBox.Text = ""

        BankAccountTransactionRadGrid.DataBind()

        RemoveSession()
    End Sub

    Protected Sub TransactionBankComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        Session("BankID") = e.Value

        TransactionBankAccountComboBox.ClearSelection()
        TransactionBankAccountComboBox.Items.Clear()
        TransactionBankAccountComboBox.DataBind()
    End Sub

    Protected Sub TransactionBankAccountComboBox_SelectedIndexChanged(sender As Object, e As Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs)
        Dim _bankAccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(e.Value)).SingleOrDefault

        BankAccountTotalTextBox.Value = _bankAccountInfo.BankAccountTotalBalance
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        If TransactionAmountTextBox.Value <= 0 Then
            PopMsg.ShowWarningMessage("Please Enter The Transaction Amount.")
            Exit Sub
        End If

        Dim _treasurerInfo = (From sd In DB.APP_UserProfiles Where sd.UserId = Session("UserID")).Single

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
                               Where sd.APP_BankAccount.BankID = Convert.ToInt64(TransactionBankComboBox.SelectedValue)
                               Select sd.TransactionDocumentNumber.Trim

        If _transactionNumbertInfo.Contains(TransactionDocumentNumberTextBox.Text.Trim) Then
            PopMsg.ShowWarningMessage("Document Number Already Exists To This Bank.")
            Exit Sub
        End If

        Try
            Dim _TransactionID

            Dim _NewBankAccountTransaction As New APP_BankAccountTransaction
            With _NewBankAccountTransaction
                .TransactionBankAccountID = Convert.ToInt64(TransactionBankAccountComboBox.SelectedValue)
                .TransactionDocumentType = TransactionDocumentTypeComboBox.SelectedValue
                .TransactionType = TransactionTypeComboBox.SelectedValue
                .TransactionDocumentNumber = TransactionDocumentNumberTextBox.Text.Trim
                .TransactionAmount = TransactionAmountTextBox.Value
                .TransactionDocumentDate = TransactionDocumentDateDatePicker.SelectedDate
                .TransactionMemo = TransactionMemoTextBox.Text.Trim
                .TransactionStatus = True
                .TransactionAddedBy = Session("UserID")
                .TransactionAddedDate = Now
            End With
            DB.APP_BankAccountTransactions.InsertOnSubmit(_NewBankAccountTransaction)
            DB.SubmitChanges()
            _TransactionID = _NewBankAccountTransaction.ID
            _NewBankAccountTransaction = Nothing

            Dim _updateBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(TransactionBankAccountComboBox.SelectedValue)).SingleOrDefault
            With _updateBankAccount
                If TransactionTypeComboBox.SelectedValue = "In" Then .BankAccountTotalBalance += TransactionAmountTextBox.Value Else .BankAccountTotalBalance -= TransactionAmountTextBox.Value
            End With
            DB.SubmitChanges()

            SaveTransactionAttachment(_TransactionID)

            If Not Session("TransactionCopy") = "NULL" Then
                Dim _UpdateExpenseTransaction = (From sd In DB.APP_BankAccountTransactions Where sd.ID = Convert.ToInt64(_TransactionID)).ToList()(0)
                With _UpdateExpenseTransaction
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

        Dim AttachmentPath As String = "~/Attachments/Treasurer/BankAccountTransaction/" + _transactionID + "/"

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

    Protected Sub BankAccountTransactionRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_BankAccountTransaction") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If

        If TypeOf e.Item Is GridEditableItem AndAlso e.Item.IsInEditMode Then
            Dim _editedItem As GridEditableItem = TryCast(e.Item, GridEditableItem)

            Dim _BankAccount As RadComboBox = DirectCast(_editedItem.FindControl("TransactionBankAccountGridComboBox"), RadComboBox)

            Session("BankID") = Session("OldBank")

            _BankAccount.ClearSelection()
            _BankAccount.Items.Clear()
            _BankAccount.DataBind()

            _BankAccount.SelectedValue = Session("OldBankAccount")

            Dim _TotalAmount As RadNumericTextBox = DirectCast(_editedItem.FindControl("BankAccountTotalGridTextBox"), RadNumericTextBox)

            Dim _bankAccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(_BankAccount.SelectedValue)).SingleOrDefault

            _TotalAmount.Value = _bankAccountInfo.BankAccountTotalBalance
        End If
    End Sub

    Protected Sub TransactionBankGridComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim _BankAccount As RadComboBox = DirectCast(DirectCast(DirectCast(sender, RadComboBox).NamingContainer, GridEditFormItem).FindControl("TransactionBankAccountGridComboBox"), RadComboBox)

        _BankAccount.ClearSelection()
        _BankAccount.Items.Clear()

        Session("BankID") = e.Value

        _BankAccount.DataBind()
    End Sub

    Protected Sub TransactionBankAccountGridComboBox_SelectedIndexChanged(sender As Object, e As RadComboBoxSelectedIndexChangedEventArgs)
        Dim _TotalAmount As RadNumericTextBox = DirectCast(DirectCast(DirectCast(sender, RadComboBox).NamingContainer, GridEditFormItem).FindControl("BankAccountTotalGridTextBox"), RadNumericTextBox)

        Dim _bankAccountInfo = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(e.Value)).SingleOrDefault

        _TotalAmount.Value = _bankAccountInfo.BankAccountTotalBalance
    End Sub

    Protected Sub BankAccountTransactionRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "Edit"
                RemoveSession()
                e.Item.OwnerTableView.IsItemInserted = False
                Exit Select
        End Select
    End Sub

    Protected Sub BankAccountTransactionRadGrid_EditCommand(sender As Object, e As GridCommandEventArgs)
        Dim _gridDataItem As GridDataItem = DirectCast(e.Item, GridDataItem)

        Session("TransactionID") = _gridDataItem("ID").Text
        Session("OldBank") = _gridDataItem("TransactionBankID").Text
        Session("OldBankAccount") = _gridDataItem("TransactionBankAccountID").Text
        Session("OldTransactionAmount") = _gridDataItem("TransactionAmountValue").Text
        Session("OldDocumentNumber") = _gridDataItem("TransactionDocumentNumber").Text
        Session("OldTransactionType") = _gridDataItem("TransactionType").Text
        Session("OldTransactionStatus") = _gridDataItem("TransactionStatusName").Text
    End Sub

    Protected Sub BankAccountTransactionRadGrid_UpdateCommand(sender As Object, e As GridCommandEventArgs)
        Dim _editedItem As GridEditableItem = TryCast(e.Item, GridEditableItem)

        Dim _treasurerSignature As RadTextBox = DirectCast(_editedItem.FindControl("TreasurerSignatureGridTextBox"), RadTextBox)
        Dim _transactionStatus As RadComboBox = DirectCast(_editedItem.FindControl("TransactionStatusGridComboBox"), RadComboBox)
        Dim _newBank As RadComboBox = DirectCast(_editedItem.FindControl("TransactionBankGridComboBox"), RadComboBox)
        Dim _transactionType As RadComboBox = DirectCast(_editedItem.FindControl("TransactionTypeGridComboBox"), RadComboBox)
        Dim _newBankAccount As RadComboBox = DirectCast(_editedItem.FindControl("TransactionBankAccountGridComboBox"), RadComboBox)
        Dim _newDocumentNumber As RadTextBox = DirectCast(_editedItem.FindControl("TransactionDocumentNumberGridTextBox"), RadTextBox)
        Dim _transactionAmount As RadNumericTextBox = DirectCast(_editedItem.FindControl("TransactionAmountGridTextBox"), RadNumericTextBox)

        If _transactionAmount.Value <= 0 Then
            PopMsg.ShowWarningMessage("The Transaction Amount Should Be Greater Than Zero (0).")
            e.Canceled = True
            Exit Sub
        End If

        Dim _oldDocumentNumber = Session("OldDocumentNumber")
        Dim _oldBank = Session("OldBank")

        If _oldBank = _newBank.SelectedValue And Not _oldDocumentNumber = _newDocumentNumber.Text.Trim Then
            Dim _transactionNumbertInfo = From sd In DB.APP_BankAccountTransactions
                                   Where sd.APP_BankAccount.BankID = Convert.ToInt64(_oldBank)
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
        Session("NewBankAccount") = _newBankAccount.SelectedValue
        Session("NewTransactionType") = _transactionType.SelectedValue

        GridSaveTransactionAttachment(_editedItem, Session("TransactionID").ToString)
    End Sub

    Private Sub BankAccountTransactionRadGrid_ItemUpdated(sender As Object, e As GridUpdatedEventArgs) Handles BankAccountTransactionRadGrid.ItemUpdated
        Try
            Dim _OldTransactionAmount As Decimal = Convert.ToDecimal(Session("OldTransactionAmount"))
            Dim _NewTransactionAmount As Decimal = Convert.ToDecimal(Session("NewTransactionAmount"))

            Dim _newTransactionStatus = Session("NewTransactionStatus")
            Dim _oldTransactionStatus = Session("OldTransactionStatus")

            Dim _oldBankAccount = Session("OldBankAccount")
            Dim _newBankAccount = Session("NewBankAccount")

            Dim _newTransactionType = Session("NewTransactionType")
            Dim _oldTransactionType = Session("OldTransactionType")

            If _newTransactionStatus = "Active" And _oldTransactionStatus = "Active" Then
                If Not _oldBankAccount = _newBankAccount Then
                    Dim _updateOldBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Session("OldBankAccount"))).SingleOrDefault
                    With _updateOldBankAccount
                        If _oldTransactionType = "In" Then .BankAccountTotalBalance -= _OldTransactionAmount Else .BankAccountTotalBalance += _OldTransactionAmount
                    End With
                    DB.SubmitChanges()

                    Dim _updateNewBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Session("NewBankAccount"))).SingleOrDefault
                    With _updateNewBankAccount
                        If _newTransactionType = "In" Then .BankAccountTotalBalance += _NewTransactionAmount Else .BankAccountTotalBalance -= _NewTransactionAmount
                    End With
                    DB.SubmitChanges()
                Else
                    Dim _balaceAmount = _NewTransactionAmount - _OldTransactionAmount

                    If _oldTransactionType = "In" And _newTransactionType = "In" Then
                        Dim _updateOldBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Session("OldBankAccount"))).SingleOrDefault
                        With _updateOldBankAccount
                            .BankAccountTotalBalance += _balaceAmount
                        End With
                        DB.SubmitChanges()
                    ElseIf _oldTransactionType = "Out" And _newTransactionType = "Out" Then
                        Dim _updateOldBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Session("OldBankAccount"))).SingleOrDefault
                        With _updateOldBankAccount
                            .BankAccountTotalBalance -= _balaceAmount
                        End With
                        DB.SubmitChanges()
                    Else
                        If _oldTransactionType = "In" And _newTransactionType = "Out" Then
                            Dim _updateOldBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Session("OldBankAccount"))).SingleOrDefault
                            With _updateOldBankAccount
                                .BankAccountTotalBalance -= _NewTransactionAmount + _balaceAmount
                            End With
                            DB.SubmitChanges()
                        ElseIf _oldTransactionType = "Out" And _newTransactionType = "In" Then
                            Dim _updateOldBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Session("OldBankAccount"))).SingleOrDefault
                            With _updateOldBankAccount
                                .BankAccountTotalBalance += _NewTransactionAmount + _balaceAmount
                            End With
                            DB.SubmitChanges()
                        End If
                    End If
                End If
            Else
                If _oldTransactionStatus = "Active" And _newTransactionStatus = "Freezed" Then
                    Dim _updateOldBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Session("OldBankAccount"))).SingleOrDefault
                    With _updateOldBankAccount
                        If _oldTransactionType.SelectedValue = "In" Then .BankAccountTotalBalance -= _OldTransactionAmount Else .BankAccountTotalBalance += _OldTransactionAmount
                    End With
                    DB.SubmitChanges()
                ElseIf _oldTransactionStatus = "Freezed" And _newTransactionStatus = "Active" Then
                    Dim _updateOldBankAccount = (From sd In DB.APP_BankAccounts Where sd.ID = Convert.ToInt64(Session("OldBankAccount"))).SingleOrDefault
                    With _updateOldBankAccount
                        If _oldTransactionType.SelectedValue = "In" Then .BankAccountTotalBalance += _OldTransactionAmount Else .BankAccountTotalBalance -= _OldTransactionAmount
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

        Dim AttachmentPath As String = "~/Attachments/Treasurer/BankAccountTransaction/" + _transactionID + "/"
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

    Protected Sub SqlDataSource_BankAccountTransaction_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource_BankAccountTransaction.Updating
        Try
            e.Command.Parameters("@TransactionUpdatedDate").Value = Now
            e.Command.Parameters("@TransactionBankAccountID").Value = Convert.ToInt64(Session("NewBankAccount"))
            If Not Session("UpdateTransactionCopy") = "NULL" Then
                e.Command.Parameters("@TransactionAttachment").Value = Session("UpdateTransactionCopy")
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
    End Sub

    Protected Sub SqlDataSource_BankAccountTransaction_OnUpdating(sender As Object, e As SqlDataSourceCommandEventArgs)
        Dim _UpdatedBy As New SqlParameter("@TransactionUpdatedBy", SqlDbType.UniqueIdentifier)
        _UpdatedBy.Direction = ParameterDirection.Input

        _UpdatedBy.Value = Session("UserID")
        e.Command.Parameters.Add(_UpdatedBy)
    End Sub

End Class