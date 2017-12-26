Imports Telerik.Web.UI

Public Class BankAccountAdvanceManagement
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
        _root4.Text = "Advance Bank Management"
        _root4.Value = "4"
        _root4.NavigateUrl = "~/Forms/Bank/BankAdvanceManagement.aspx"
        _radSiteMap.Nodes.Add(_root4)

        Dim _root5 As New RadSiteMapNode
        _root5.Text = "Advance Bank Account Management"
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

    Protected Sub BankAccountRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "OpeningBalace"
                Dim _gridDataItem As GridDataItem = DirectCast(e.Item, GridDataItem)

                Dim _ID = _gridDataItem("ID").Text

                modalPopup_BankAccountOpeningBalance.VisibleOnPageLoad = True
                modalPopup_BankAccountOpeningBalance.NavigateUrl = "~/Forms/Bank/BankAccountOpeningBalanceManagement.aspx?BankID=" + _ID
                RadWindowManager_modalPopup.Windows.Add(modalPopup_BankAccountOpeningBalance)
                Exit Select
            Case "AccountStatus"
                Dim _gridDataItem As GridDataItem = DirectCast(e.Item, GridDataItem)

                Dim _ID = _gridDataItem("ID").Text

                modalPopup_BankAccountStatus.VisibleOnPageLoad = True
                modalPopup_BankAccountStatus.NavigateUrl = "~/Forms/Bank/BankAccountUpdateStatusManagement.aspx?BankID=" + _ID
                RadWindowManager_modalPopup.Windows.Add(modalPopup_BankAccountStatus)
                Exit Select
        End Select
    End Sub
End Class