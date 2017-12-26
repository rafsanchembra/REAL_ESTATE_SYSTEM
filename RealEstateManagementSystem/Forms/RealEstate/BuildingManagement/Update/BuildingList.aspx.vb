Imports Telerik.Web.UI

Public Class BuildingList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SessionCreater()
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
        _root2.Text = "Multi Floor Building Management"
        _root2.Value = "1"
        _root2.NavigateUrl = "~/Administrator/RealEstate/BuildingManagement"
        _radSiteMap.Nodes.Add(_root2)


        Dim _root3 As New RadSiteMapNode
        _root3.Text = "Multi Floor Building List"
        _root3.Value = "2"
        _root3.Enabled = False
        _radSiteMap.Nodes.Add(_root3)
    End Sub
    Private Sub SessionCreater()
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)
        Session("UserID") = _currentUserID
    End Sub

    Protected Sub BuildingRadGrid_ItemDataBound(sender As Object, e As GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_BuildingList") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub BuildingRadGrid_ItemCommand(sender As Object, e As GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "Edit"
                e.Canceled = True
                Dim _gridDataItem As GridDataItem = e.Item
                Response.Redirect("~/Administrator/RealEstate/BuildingManagement/Update/" + _gridDataItem("ID").Text)
                Exit Sub
        End Select
    End Sub
End Class