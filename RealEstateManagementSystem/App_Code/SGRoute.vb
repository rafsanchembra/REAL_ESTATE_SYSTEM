Imports System.Web.Routing
Imports System.Web.Compilation

Public Class SGRoute
    Implements IRouteHandler

    Private _virtualPath As String

    Public Sub New(ByVal vPath As String)
        _virtualPath = vPath
    End Sub

    Public Property VirtualPath() As String
        Get
            Return _virtualPath
        End Get
        Private Set(ByVal value As String)
            _virtualPath = value
        End Set
    End Property

    Public Function GetHttpHandler(ByVal _requestContext As RequestContext) As System.Web.IHttpHandler Implements IRouteHandler.GetHttpHandler
        Dim _redirectPage As IHttpHandler

        If UrlAuthorizationModule.CheckUrlAccessForPrincipal(_virtualPath, _requestContext.HttpContext.User, _requestContext.HttpContext.Request.HttpMethod) Then
            If _virtualPath IsNot Nothing Then
                _redirectPage = BuildManager.CreateInstanceFromVirtualPath(VirtualPath, GetType(Page))
            End If
        Else
            _redirectPage = BuildManager.CreateInstanceFromVirtualPath("~/Forms/Account/Login.aspx", GetType(Page))
        End If

        Return _redirectPage
    End Function

End Class