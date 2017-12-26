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

Public Class DownloadSelectedAttachment
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            LoadData()
            Download()
        End If
    End Sub

    Private Sub Download()
        Dim _attachmentPath As String = "~/AttachmentsTemp/BuildingAttachmentDownload/" + Convert.ToString(Session("UserID")) + "/"
        If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
            Directory.CreateDirectory(Server.MapPath(_attachmentPath))
        Else
            For Each _file As String In Directory.GetFiles(Server.MapPath(_attachmentPath))
                File.Delete(_file)
            Next
        End If

        Dim _selectedItems = Convert.ToString(Page.RouteData.Values("SelectedItems"))

        Dim _items As String() = _selectedItems.Split(New Char() {","})

        If (Page.RouteData.Values("Status") = "Main") Then

            If (Page.RouteData.Values("Type") = "General") Then

                Dim _buildingAttachment = (From sd In DB.APP_MultiFloorBuildingAttachments Where sd.BuildingID = Convert.ToInt64(Page.RouteData.Values("TypeID")) Select sd).ToList
                For Each x In _items
                    For Each y In _buildingAttachment
                        If Not x = "" Then
                            If (y.ID = x) Then
                                Dim _destination = _attachmentPath + Path.GetFileName(Server.MapPath(y.BuildingAttachment))
                                If (File.Exists(Server.MapPath(y.BuildingAttachment))) Then
                                    File.Copy(Server.MapPath(y.BuildingAttachment), Server.MapPath(_destination))
                                End If
                            End If
                        End If
                    Next
                Next

                ' Create Zip folder
                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(Server.MapPath(_attachmentPath), TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()

            ElseIf (Page.RouteData.Values("Type") = "Flat") Then

                Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachments Where sd.BuildingFlatID = Convert.ToInt64(Page.RouteData.Values("TypeID")) Select sd).ToList
                For Each x In _items
                    For Each y In _flatAttachment
                        If Not x = "" Then
                            If (y.ID = x) Then
                                Dim _destination = _attachmentPath + Path.GetFileName(Server.MapPath(y.BuildingAttachment))
                                If (File.Exists(Server.MapPath(y.BuildingAttachment))) Then
                                    File.Copy(Server.MapPath(y.BuildingAttachment), Server.MapPath(_destination))
                                End If
                            End If
                        End If
                    Next
                Next

                ' Create Zip folder
                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(Server.MapPath(_attachmentPath), TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()

            ElseIf (Page.RouteData.Values("Type") = "Shop") Then
                Dim _shopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachments Where sd.BuildingShopID = Convert.ToInt64(Page.RouteData.Values("TypeID")) Select sd).ToList
                For Each x In _items
                    For Each y In _shopAttachment
                        If Not x = "" Then
                            If (y.ID = x) Then
                                Dim _destination = _attachmentPath + Path.GetFileName(Server.MapPath(y.BuildingAttachment))
                                If (File.Exists(Server.MapPath(y.BuildingAttachment))) Then
                                    File.Copy(Server.MapPath(y.BuildingAttachment), Server.MapPath(_destination))
                                End If
                            End If
                        End If
                    Next
                Next

                ' Create Zip folder
                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(Server.MapPath(_attachmentPath), TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()

            ElseIf (Page.RouteData.Values("Type") = "Office") Then

                Dim _officeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachmentTemps Where sd.BuildingOfficeID = Convert.ToInt64(Page.RouteData.Values("TypeID")) Select sd).ToList
                For Each x In _items
                    For Each y In _officeAttachment
                        If Not x = "" Then
                            If (y.ID = x) Then
                                Dim _destination = _attachmentPath + Path.GetFileName(Server.MapPath(y.BuildingAttachment))
                                If (File.Exists(Server.MapPath(y.BuildingAttachment))) Then
                                    File.Copy(Server.MapPath(y.BuildingAttachment), Server.MapPath(_destination))
                                End If
                            End If
                        End If
                    Next
                Next

                ' Create Zip folder
                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(Server.MapPath(_attachmentPath), TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()

            End If
        Else
            If (Page.RouteData.Values("Type") = "General") Then

                Dim _buildingAttachment = (From sd In DB.APP_MultiFloorBuildingAttachmentTemps Where sd.UserID = Session("UserID") Select sd).ToList
                For Each x In _items
                    For Each y In _buildingAttachment
                        If Not x = "" Then
                            If (y.ID = x) Then
                                Dim _destination = _attachmentPath + Path.GetFileName(Server.MapPath(y.BuildingAttachment))
                                If (File.Exists(Server.MapPath(y.BuildingAttachment))) Then
                                    File.Copy(Server.MapPath(y.BuildingAttachment), Server.MapPath(_destination))
                                End If
                            End If
                        End If
                    Next
                Next

                ' Create Zip folder
                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(Server.MapPath(_attachmentPath), TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()


            ElseIf (Page.RouteData.Values("Type") = "Flat") Then

                Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachmentTemps Where sd.BuildingFlatID = Convert.ToInt64(Page.RouteData.Values("TypeID")) Select sd).ToList
                For Each x In _items
                    For Each y In _flatAttachment
                        If Not x = "" Then
                            If (y.ID = x) Then
                                Dim _destination = _attachmentPath + Path.GetFileName(Server.MapPath(y.BuildingAttachment))
                                If (File.Exists(Server.MapPath(y.BuildingAttachment))) Then
                                    File.Copy(Server.MapPath(y.BuildingAttachment), Server.MapPath(_destination))
                                End If
                            End If
                        End If
                    Next
                Next

                ' Create Zip folder
                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(Server.MapPath(_attachmentPath), TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()

            ElseIf (Page.RouteData.Values("Type") = "Shop") Then

                Dim _shopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachmentTemps Where sd.BuildingShopID = Convert.ToInt64(Page.RouteData.Values("TypeID")) Select sd).ToList
                For Each x In _items
                    For Each y In _shopAttachment
                        If Not x = "" Then
                            If (y.ID = x) Then
                                Dim _destination = _attachmentPath + Path.GetFileName(Server.MapPath(y.BuildingAttachment))
                                If (File.Exists(Server.MapPath(y.BuildingAttachment))) Then
                                    File.Copy(Server.MapPath(y.BuildingAttachment), Server.MapPath(_destination))
                                End If
                            End If
                        End If
                    Next
                Next

                ' Create Zip folder
                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(Server.MapPath(_attachmentPath), TempFile)

                ' Download Zip folder
                Response.Buffer = False
                Response.Clear()
                Response.AddHeader("content-disposition", "attachment;filename=" + Convert.ToString(Page.RouteData.Values("TypeID")) + ".zip")
                Response.ContentType = "Application/zip"
                Response.TransmitFile(TempFile)
                Response.End()

            ElseIf (Page.RouteData.Values("Type") = "Office") Then

                Dim _officeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachmentTemps Where sd.BuildingOfficeID = Convert.ToInt64(Page.RouteData.Values("TypeID")) Select sd).ToList
                For Each x In _items
                    For Each y In _officeAttachment
                        If Not x = "" Then
                            If (y.ID = x) Then
                                Dim _destination = _attachmentPath + Path.GetFileName(Server.MapPath(y.BuildingAttachment))
                                If (File.Exists(Server.MapPath(y.BuildingAttachment))) Then
                                    File.Copy(Server.MapPath(y.BuildingAttachment), Server.MapPath(_destination))
                                End If
                            End If
                        End If
                    Next
                Next

                ' Create Zip folder
                Dim TempFile = System.IO.Path.GetTempFileName() + ".zip"
                System.IO.Compression.ZipFile.CreateFromDirectory(Server.MapPath(_attachmentPath), TempFile)

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