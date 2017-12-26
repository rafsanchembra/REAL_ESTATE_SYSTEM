Imports Telerik.Web.UI
Imports System.Data.SqlClient

Public Class BankManagement
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BankArabicNameTextBox.Focus()
            Me.Form.DefaultButton = SubmitButton.UniqueID
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
        _root3.Text = "Bank Managment"
        _root3.Value = "3"
        _root3.NavigateUrl = "~/Forms/Pages/Administrator/Bank.aspx"
        _radSiteMap.Nodes.Add(_root3)


        Dim _root4 As New RadSiteMapNode
        _root4.Text = "Bank Add/Update"
        _root4.Value = "4"
        _root4.Enabled = False
        _radSiteMap.Nodes.Add(_root4)

    End Sub

    Protected Sub BankRadGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_BankList") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        If BankArabicNameTextBox.Text.Trim = "" Or BankEnglishNameTextBox.Text.Trim = "" Then
            Exit Sub
        End If

        'If Not Check_BankArabicName_Exists(BankArabicNameTextBox.Text.Trim) Then
        '    Exit Sub
        'End If

        If Not Check_BankEnglishName_Exists(BankEnglishNameTextBox.Text.Trim) Then
            Exit Sub
        End If

        If Not BankSwiftCodeTextBox.Text.Trim = "" Then
            If Not Check_BankSwiftCode_Exists(BankSwiftCodeTextBox.Text.Trim) Then
                Exit Sub
            End If
        End If

        If Not BankIBANCodeTextBox.Text.Trim = "" Then
            If Not Check_BankIBANCode_Exists(BankIBANCodeTextBox.Text.Trim) Then
                Exit Sub
            End If
        End If

        Try
            Dim _currentUser As MembershipUser = Membership.GetUser()
            Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

            Try
                Dim _NewBankData As New APP_Bank
                With _NewBankData
                    .BankArabicName = BankArabicNameTextBox.Text.Trim
                    .BankEnglishName = BankEnglishNameTextBox.Text.Trim
                    .BankSwiftCode = BankSwiftCodeTextBox.Text.Trim
                    .BankIBANCode = BankIBANCodeTextBox.Text.Trim
                    .BankLatitudeCoordinates = BankLatitudeCoordinatesTextBox.Text.Trim
                    .BankLongitudeCoordinates = BankLongitudeCoordinatesTextBox.Text.Trim
                    .BankURLMap = BankURLMapTextBox.Text.Trim
                    .BankWebsite = BankWebsiteTextBox.Text.Trim
                    .BankOnlineBankingURL = BankOnlineBankingURLTextBox.Text.Trim
                    .BankDescription = BankDescriptionTextBox.Text.Trim
                    .BankAddedBy = _currentUserID
                    .BankAddedDate = Now
                End With
                DB.APP_Banks.InsertOnSubmit(_NewBankData)
                DB.SubmitChanges()
                _NewBankData = Nothing
            Catch ex As SqlException
                If ex.Message.Contains("IX_APP_Banks_ArabicName") Then
                    PopMsg.ShowWarningMessage("Bank Arabic Name Already Exists.")
                End If


            End Try

            
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.ToString)
            Exit Sub
        End Try

        ClearData()
        BankRadGrid.DataBind()
    End Sub

    Protected Sub BankRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "Edit"
                e.Item.OwnerTableView.IsItemInserted = False
                Exit Select
        End Select
    End Sub

    Protected Sub BankRadGrid_EditCommand(sender As Object, e As GridCommandEventArgs)
        Dim _gridDataItem As GridDataItem = DirectCast(e.Item, GridDataItem)

        Session("_BankArabicName") = _gridDataItem("BankArabicName").Text.Trim
        Session("_BankEnglishName") = _gridDataItem("BankEnglishName").Text.Trim
        Session("_BankSwiftCode") = _gridDataItem("BankSwiftCode").Text.Trim
        Session("_BankIBANCode") = _gridDataItem("BankIBANCode").Text.Trim
    End Sub

    Protected Sub BankRadGrid_UpdateCommand(sender As Object, e As GridCommandEventArgs)
        Dim _EditedItem As GridEditableItem = TryCast(e.Item, GridEditableItem)

        Dim _BankArabicName As RadTextBox = DirectCast(_EditedItem.FindControl("BankArabicNameGridTextBox"), RadTextBox)
        Dim _BankEnglishName As RadTextBox = DirectCast(_EditedItem.FindControl("BankEnglishNameGridTextBox"), RadTextBox)
        Dim _BankSwiftCode As RadTextBox = DirectCast(_EditedItem.FindControl("BankSwiftCodeGridTextBox"), RadTextBox)
        Dim _BankIBANCode As RadTextBox = DirectCast(_EditedItem.FindControl("BankIBANCodeGridTextBox"), RadTextBox)

        Dim _OldBankArabicName As String = Session("_BankArabicName").ToString
        Dim _OldBankEnglishName As String = Session("_BankEnglishName").ToString
        Dim _OldBankSwiftCode As String = Session("_BankSwiftCode").ToString
        Dim _OldBankIBANCode As String = Session("_BankIBANCode").ToString

        If Not _BankArabicName.Text.Trim = _OldBankArabicName.Trim Then
            If Not Check_BankArabicName_Exists(_BankArabicName.Text.Trim) Then
                e.Canceled = True
                Exit Sub
            End If
        End If

        If Not _BankEnglishName.Text.Trim = _OldBankEnglishName.Trim Then
            If Not Check_BankEnglishName_Exists(_BankEnglishName.Text.Trim) Then
                e.Canceled = True
                Exit Sub
            End If
        End If

        If Not _BankSwiftCode.Text.Trim = "" Then
            If Not _BankSwiftCode.Text.Trim = _OldBankSwiftCode.Trim Then
                If Not Check_BankSwiftCode_Exists(_BankSwiftCode.Text.Trim) Then
                    e.Canceled = True
                    Exit Sub
                End If
            End If
        End If

        If Not _BankIBANCode.Text.Trim = "" Then
            If Not _BankIBANCode.Text.Trim = _OldBankIBANCode.Trim Then
                If Not Check_BankIBANCode_Exists(_BankIBANCode.Text.Trim) Then
                    e.Canceled = True
                    Exit Sub
                End If
            End If
        End If
    End Sub

#Region "Check Data Exists"

    Private Function Check_BankArabicName_Exists(_BankArabicName As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Banks Select sd.BankArabicName.Trim

            If _info.Contains(_BankArabicName.Trim) Then
                PopMsg.ShowWarningMessage("Bank Arabic Name Already Exists.")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Private Function Check_BankEnglishName_Exists(_BankEnglishName As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Banks Select sd.BankEnglishName.Trim

            If _info.Contains(_BankEnglishName.Trim) Then
                PopMsg.ShowWarningMessage("Bank English Name Already Exists.")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Private Function Check_BankSwiftCode_Exists(_BankSwiftCode As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Banks Select sd.BankSwiftCode.Trim

            If _info.Contains(_BankSwiftCode.Trim) Then
                PopMsg.ShowWarningMessage("Bank Swift Code Name Already Exists.")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Private Function Check_BankIBANCode_Exists(_BankIBANCode As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_Banks Select sd.BankIBANCode.Trim

            If _info.Contains(_BankIBANCode.Trim) Then
                PopMsg.ShowWarningMessage("Bank IBAN Code Name Already Exists.")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

#End Region

    Protected Sub SqlDataSource_BankList_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource_BankList.Updating
        Try
            e.Command.Parameters("@BankUpdatedDate").Value = Now
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub SqlDataSource_BankList_OnUpdating(sender As Object, e As SqlDataSourceCommandEventArgs)
        Dim _UpdatedBy As New SqlParameter("@BankUpdatedBy", SqlDbType.UniqueIdentifier)
        _UpdatedBy.Direction = ParameterDirection.Input

        Dim _CurrentUser As MembershipUser = Membership.GetUser
        Dim _CurrentUserId As Guid = CType(_CurrentUser.ProviderUserKey, Guid)
        _UpdatedBy.Value = _CurrentUserId
        e.Command.Parameters.Add(_UpdatedBy)
    End Sub

    Private Sub ClearData()
        BankArabicNameTextBox.Text = ""
        BankEnglishNameTextBox.Text = ""
        BankSwiftCodeTextBox.Text = ""
        BankIBANCodeTextBox.Text = ""
        BankLatitudeCoordinatesTextBox.Text = ""
        BankLongitudeCoordinatesTextBox.Text = ""
        BankURLMapTextBox.Text = ""
        BankWebsiteTextBox.Text = ""
        BankOnlineBankingURLTextBox.Text = ""
        BankDescriptionTextBox.Text = ""
    End Sub
End Class