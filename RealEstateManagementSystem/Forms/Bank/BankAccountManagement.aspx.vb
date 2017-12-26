Imports Telerik.Web.UI
Imports System.Data.SqlClient

Public Class BankAccountManagement
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
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
        _root4.Text = "Bank Add/Update"
        _root4.Value = "4"
        _root4.NavigateUrl = "~/Forms/Bank/BankManagement.aspx"
        _radSiteMap.Nodes.Add(_root4)

        Dim _root5 As New RadSiteMapNode
        _root5.Text = "Account Management"
        _root5.Value = "5"
        _root5.Enabled = False
        _radSiteMap.Nodes.Add(_root5)


    End Sub
    

    Protected Sub BankAccountRadGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_BankAccountList") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub BankAccountRadGrid_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "Edit"
                e.Item.OwnerTableView.IsItemInserted = False
                Exit Select
        End Select
    End Sub

    Protected Sub BankAccountRadGrid_EditCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Dim _gridDataItem As GridDataItem = DirectCast(e.Item, GridDataItem)

        Session("_BankAccountNumber") = _gridDataItem("BankAccountNumber").Text.Trim
        Session("_BankAccountArabicName") = _gridDataItem("BankAccountArabicName").Text.Trim
        Session("_BankAccountEnglishName") = _gridDataItem("BankAccountEnglishName").Text.Trim
    End Sub

    Protected Sub BankAccountRadGrid_UpdateCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Dim _EditedItem As GridEditableItem = TryCast(e.Item, GridEditableItem)

        Dim _BankAccountNumber As RadTextBox = DirectCast(_EditedItem.FindControl("BankAccountNumberGridTextBox"), RadTextBox)
        Dim _BankAccountArabicName As RadTextBox = DirectCast(_EditedItem.FindControl("BankAccountArabicNameGridTextBox"), RadTextBox)
        Dim _BankAccountEnglishName As RadTextBox = DirectCast(_EditedItem.FindControl("BankAccountEnglishNameGridTextBox"), RadTextBox)

        Dim _OldBankAccountNumber As String = Session("_BankAccountNumber").ToString
        Dim _OldBankAccountArabicName As String = Session("_BankAccountArabicName").ToString
        Dim _OldBankAccountEnglishName As String = Session("_BankAccountEnglishName").ToString

        If Not _BankAccountNumber.Text.Trim = _OldBankAccountNumber.Trim Then
            If Not Check_BankAccountNumber_Exists(_BankAccountNumber.Text.Trim) Then
                e.Canceled = True
                Exit Sub
            End If
        End If

        If Not _BankAccountArabicName.Text.Trim = _OldBankAccountArabicName.Trim Then
            If Not Check_BankAccountArabicName_Exists(_BankAccountArabicName.Text.Trim) Then
                e.Canceled = True
                Exit Sub
            End If
        End If

        If Not _BankAccountEnglishName.Text.Trim = _OldBankAccountEnglishName.Trim Then
            If Not Check_BankAccountEnglishName_Exists(_BankAccountEnglishName.Text.Trim) Then
                e.Canceled = True
                Exit Sub
            End If
        End If
    End Sub

    Protected Sub SqlDataSource_BankAccountList_Updating(sender As Object, e As SqlDataSourceCommandEventArgs) Handles SqlDataSource_BankAccountList.Updating
        Try
            e.Command.Parameters("@BankAccountUpdatedDate").Value = Now
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub SqlDataSource_BankAccountList_OnUpdating(sender As Object, e As SqlDataSourceCommandEventArgs)
        Dim _UpdatedBy As New SqlParameter("@BankAccountUpdatedBy", SqlDbType.UniqueIdentifier)
        _UpdatedBy.Direction = ParameterDirection.Input

        Dim _CurrentUser As MembershipUser = Membership.GetUser
        Dim _CurrentUserId As Guid = CType(_CurrentUser.ProviderUserKey, Guid)
        _UpdatedBy.Value = _CurrentUserId
        e.Command.Parameters.Add(_UpdatedBy)
    End Sub

#Region "Check Data Exists"

    Private Function Check_BankAccountNumber_Exists(_BankAccountNumber As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_BankAccounts Where sd.BankID = Convert.ToInt64(Page.RouteData.Values("BankID")) Select sd.BankAccountNumber.Trim

            If _info.Contains(_BankAccountNumber.Trim) Then
                PopMsg.ShowWarningMessage("Bank Account Number Already Exists For This Bank.")
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
            Dim _info = From sd In DB.APP_BankAccounts Select sd.BankAccountArabicName.Trim

            If _info.Contains(_BankAccountArabicName.Trim) Then
                PopMsg.ShowWarningMessage("Bank Arabic Name Already Exists.")
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
            Dim _info = From sd In DB.APP_BankAccounts Select sd.BankAccountEnglishName.Trim

            If _info.Contains(_BankAccountEnglishName.Trim) Then
                PopMsg.ShowWarningMessage("Bank English Name Already Exists.")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

#End Region

    Protected Sub CreateBankAccountButton_Click(sender As Object, e As EventArgs)
        modalPopup_BankAccount.VisibleOnPageLoad = True
        modalPopup_BankAccount.NavigateUrl = "~/Forms/Bank/BankAccountManagementWindow.aspx?BankID=" + Request.QueryString("ID")

        RadWindowManager_modalPopup.Windows.Add(modalPopup_BankAccount)
    End Sub

End Class