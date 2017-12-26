Imports System.Net
Imports System.IO
Imports System.Threading.Tasks
Imports System.Net.Mime
Imports System.Globalization
Imports System.Threading
Imports System.Drawing
Imports System.Drawing.Imaging
Imports Telerik.Windows.Zip
Imports Telerik.Web.UI

Public Class DownloadAttachment
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            LoadData()
            Download()
        End If
    End Sub

    Private Sub Download()
        If (Page.RouteData.Values("Status") = "Main") Then
            If (Page.RouteData.Values("Type") = "General") Then

                Dim _buildingAttachment = (From sd In DB.APP_MultiFloorBuildingAttachments Where sd.BuildingID = Convert.ToInt64(Page.RouteData.Values("TypeID")) Select sd).FirstOrDefault

                Dim folderPath As String = Path.GetDirectoryName(Server.MapPath(_buildingAttachment.BuildingAttachment))

                ' Create Zip folder

                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(folderPath, TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()

            ElseIf (Page.RouteData.Values("Type") = "Flat") Then


            ElseIf (Page.RouteData.Values("Type") = "Shop") Then


            ElseIf (Page.RouteData.Values("Type") = "Office") Then


            End If
        Else
            If (Page.RouteData.Values("Type") = "General") Then

                Dim _buildingAttachment = (From sd In DB.APP_MultiFloorBuildingAttachmentTemps Where sd.UserID = Session("UserID") Select sd).FirstOrDefault

                Dim folderPath As String = Path.GetDirectoryName(Server.MapPath(_buildingAttachment.BuildingAttachment))

                ' Create Zip folder

                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(folderPath, TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()

            ElseIf (Page.RouteData.Values("Type") = "Flat") Then

                Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachmentTemps Where sd.BuildingFlatID = Convert.ToString(Page.RouteData.Values("TypeID")) Select sd).FirstOrDefault

                Dim folderPath As String = Path.GetDirectoryName(Server.MapPath(_flatAttachment.BuildingAttachment))

                ' Create Zip folder

                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(folderPath, TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()

            ElseIf (Page.RouteData.Values("Type") = "Shop") Then

                Dim _shopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachmentTemps Where sd.BuildingShopID = Convert.ToString(Page.RouteData.Values("TypeID")) Select sd).FirstOrDefault

                Dim folderPath As String = Path.GetDirectoryName(Server.MapPath(_shopAttachment.BuildingAttachment))

                ' Create Zip folder

                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(folderPath, TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()

            ElseIf (Page.RouteData.Values("Type") = "Office") Then

                Dim _officeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachmentTemps Where sd.BuildingOfficeID = Convert.ToString(Page.RouteData.Values("TypeID")) Select sd).FirstOrDefault

                Dim folderPath As String = Path.GetDirectoryName(Server.MapPath(_officeAttachment.BuildingAttachment))

                ' Create Zip folder

                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(folderPath, TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()
            End If
        End If

        

    End Sub
    Private Sub LoadData()
        Dim _currentUser As MembershipUser = Membership.GetUser()
        If _currentUser Is Nothing Then
            Session.Abandon()
            FormsAuthentication.SignOut()
            FormsAuthentication.RedirectToLoginPage()
            Exit Sub
        End If

        Dim _currentUserId As Guid = CType(_currentUser.ProviderUserKey, Guid)
        Session("UserID") = _currentUserId
    End Sub

End Class