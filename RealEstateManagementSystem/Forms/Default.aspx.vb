Imports Telerik.Web.UI

Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Dim _currentUser As MembershipUser = Membership.GetUser
            If _currentUser Is Nothing Then
                Response.Redirect("~/Login")
            End If

            Dim _radSiteMap As RadSiteMap = CType(Master.FindControl("BreadCrumbSiteMapMasterPage"), RadSiteMap)

            _radSiteMap.Visible = False

            CheckForRoles()
        End If
        'registerLi.Visible = False
        'SupplierLi.Visible = False
    End Sub
    Private Sub CheckForRoles()
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _userRoles = Roles.GetRolesForUser(_currentUser.UserName)

        If Not _userRoles.Contains("BuildingManagement") Then
            BuildingLink.Visible = False
        Else

        End If
    End Sub
 Private Sub ShowPopMsg()
        PopMsg.ShowWarningMessage("You Don't Have Permission To Access This Page.")
    End Sub

   
End Class