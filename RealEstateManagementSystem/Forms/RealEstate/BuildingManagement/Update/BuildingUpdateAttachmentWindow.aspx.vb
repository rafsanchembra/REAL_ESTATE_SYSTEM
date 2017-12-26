Imports System.IO
Imports Telerik.Web.UI
Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Drawing.Drawing2D
Imports Telerik.Web.UI.ImageEditor

Public Class BuildingUpdateAttachmentWindow
    Inherits System.Web.UI.Page
    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SessionCreater()
            LoadData()
        End If

    End Sub

    Private Sub SessionCreater()
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)
        Session("UserID") = _currentUserID
        AttachmentType.Value = Page.RouteData.Values("Type").ToString
    End Sub


    Private Sub LoadData()
        If Page.RouteData.Values("Status") = "Edit" Then
            ViewHyperLink.Visible = True
            If (Page.RouteData.Values("Type") = "General") Then
                Dim _buildingAttachment = (From sd In DB.APP_MultiFloorBuildingAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault
                AttachmentNameTextBox.Text = _buildingAttachment.BuildingAttachmentName
                ViewHyperLink.NavigateUrl = _buildingAttachment.BuildingAttachment
                ViewState("AttachmentName") = _buildingAttachment.BuildingAttachmentName
            End If
            If (Page.RouteData.Values("Type") = "Flat") Then
                Dim _flatAttachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault
                AttachmentNameTextBox.Text = _flatAttachment.BuildingAttachmentName
                ViewHyperLink.NavigateUrl = _flatAttachment.BuildingAttachment
                ViewState("AttachmentName") = _flatAttachment.BuildingAttachmentName
            End If
            If (Page.RouteData.Values("Type") = "Shop") Then
                Dim _shopAttachment = (From sd In DB.APP_MultiFloorBuildingShopAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault
                AttachmentNameTextBox.Text = _shopAttachment.BuildingAttachmentName
                ViewHyperLink.NavigateUrl = _shopAttachment.BuildingAttachment
                ViewState("AttachmentName") = _shopAttachment.BuildingAttachmentName
            End If
            If (Page.RouteData.Values("Type") = "Office") Then
                Dim _officeAttachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault
                AttachmentNameTextBox.Text = _officeAttachment.BuildingAttachmentName
                ViewHyperLink.NavigateUrl = _officeAttachment.BuildingAttachment
                ViewState("AttachmentName") = _officeAttachment.BuildingAttachmentName
            End If
        End If
    End Sub

    Private Sub GeneralAttachmentSave(sender As Object, e As ImageEditorSavingEventArgs)

        Try
            If Page.RouteData.Values("Status") = "Add" Then
                If Not (Check_MFBAttachmentName_Exists(AttachmentNameTextBox.Text)) Then
                    e.Argument = "0"
                    e.Cancel = True
                    Exit Sub
                End If

                SaveImageAttachment(sender, e)

                Dim _attachment As New APP_MultiFloorBuildingAttachment
                With _attachment
                    .BuildingID = Convert.ToInt64(Page.RouteData.Values("BuildingID"))
                    .BuildingAttachmentName = AttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.APP_MultiFloorBuildingAttachments.InsertOnSubmit(_attachment)
                DB.SubmitChanges()
                _attachment = Nothing
            ElseIf Page.RouteData.Values("Status") = "Edit" Then

                If Not ViewState("AttachmentName") = AttachmentNameTextBox.Text Then
                    If Not (Check_MFBAttachmentName_Exists(AttachmentNameTextBox.Text)) Then
                        e.Argument = "0"
                        e.Cancel = True
                        Exit Sub
                    End If
                End If

                Dim _attachment = (From sd In DB.APP_MultiFloorBuildingAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault

                If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                    File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                End If

                SaveImageAttachment(sender, e)

                With _attachment
                    .BuildingAttachmentName = AttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.SubmitChanges()
                _attachment = Nothing
            End If

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

    End Sub

    Private Sub FlatAttachmentSave(sender As Object, e As ImageEditorSavingEventArgs)
        Try
            If Page.RouteData.Values("Status") = "Add" Then
                If Not (Check_MFBFlatAttachmentName_Exists(AttachmentNameTextBox.Text)) Then
                    e.Argument = "0"
                    e.Cancel = True
                    Exit Sub
                End If

                SaveImageAttachment(sender, e)

                Dim _attachment As New APP_MultiFloorBuildingFlatAttachment
                With _attachment
                    .UserID = Session("UserID")
                    .BuildingAttachmentName = AttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.APP_MultiFloorBuildingFlatAttachments.InsertOnSubmit(_attachment)
                DB.SubmitChanges()
                _attachment = Nothing
            ElseIf Page.RouteData.Values("Status") = "Edit" Then
                If Not ViewState("AttachmentName") = AttachmentNameTextBox.Text Then
                    If Not (Check_MFBFlatAttachmentName_Exists(AttachmentNameTextBox.Text)) Then
                        e.Argument = "0"
                        e.Cancel = True
                        Exit Sub
                    End If
                End If

                Dim _attachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault

                If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                    File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                End If

                SaveImageAttachment(sender, e)

                With _attachment
                    .BuildingAttachmentName = AttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.SubmitChanges()
                _attachment = Nothing
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub ShopAttachmentSave(sender As Object, e As ImageEditorSavingEventArgs)

        Try
            If Page.RouteData.Values("Status") = "Add" Then
                If Not (Check_MFBShopAttachmentName_Exists(AttachmentNameTextBox.Text)) Then
                    e.Argument = "0"
                    e.Cancel = True
                    Exit Sub
                End If

                SaveImageAttachment(sender, e)

                Dim _attachment As New APP_MultiFloorBuildingShopAttachment
                With _attachment
                    .UserID = Session("UserID")
                    .BuildingAttachmentName = AttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.APP_MultiFloorBuildingShopAttachments.InsertOnSubmit(_attachment)
                DB.SubmitChanges()
                _attachment = Nothing

            ElseIf Page.RouteData.Values("Status") = "Edit" Then

                If Not ViewState("AttachmentName") = AttachmentNameTextBox.Text Then
                    If Not (Check_MFBShopAttachmentName_Exists(AttachmentNameTextBox.Text)) Then
                        e.Argument = "0"
                        e.Cancel = True
                        Exit Sub
                    End If
                End If

                Dim _attachment = (From sd In DB.APP_MultiFloorBuildingShopAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault

                If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                    File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                End If

                SaveImageAttachment(sender, e)

                With _attachment
                    .BuildingAttachmentName = AttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.SubmitChanges()
                _attachment = Nothing
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub

    Private Sub OfficeAttachmentSave(sender As Object, e As ImageEditorSavingEventArgs)

        Try
            If Page.RouteData.Values("Status") = "Add" Then
                If Not (Check_MFBOfficeAttachmentName_Exists(AttachmentNameTextBox.Text)) Then
                    e.Argument = "0"
                    e.Cancel = True
                    Exit Sub
                End If

                SaveImageAttachment(sender, e)

                Dim _attachment As New APP_MultiFloorBuildingOfficeAttachment
                With _attachment

                    .UserID = Session("UserID")
                    .BuildingAttachmentName = AttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.APP_MultiFloorBuildingOfficeAttachments.InsertOnSubmit(_attachment)
                DB.SubmitChanges()
                _attachment = Nothing

            ElseIf Page.RouteData.Values("Status") = "Edit" Then

                If Not ViewState("AttachmentName") = AttachmentNameTextBox.Text Then
                    If Not (Check_MFBOfficeAttachmentName_Exists(AttachmentNameTextBox.Text)) Then
                        e.Argument = "0"
                        e.Cancel = True
                        Exit Sub
                    End If
                End If

                Dim _attachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault

                If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                    File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                End If

                SaveImageAttachment(sender, e)

                With _attachment
                    .BuildingAttachmentName = AttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.SubmitChanges()
                _attachment = Nothing
            End If

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub


    Private Function GeneralAttachmentSave() As Boolean
        Dim _status As Boolean = True
        Try
            If Page.RouteData.Values("Status") = "Add" Then
                If Not (Check_MFBAttachmentName_Exists(DocAttachmentNameTextBox.Text)) Then
                    _status = False
                    Exit Try
                End If

                SaveAttachment()

                Dim _attachment As New APP_MultiFloorBuildingAttachment
                With _attachment
                    .BuildingID = Convert.ToInt64(Page.RouteData.Values("BuildingID"))
                    .BuildingAttachmentName = DocAttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.APP_MultiFloorBuildingAttachments.InsertOnSubmit(_attachment)
                DB.SubmitChanges()
                _attachment = Nothing
            ElseIf Page.RouteData.Values("Status") = "Edit" Then

                If Not ViewState("AttachmentName") = DocAttachmentNameTextBox.Text Then
                    If Not (Check_MFBAttachmentName_Exists(DocAttachmentNameTextBox.Text)) Then
                        _status = False
                        Exit Try
                    End If
                End If

                Dim _attachment = (From sd In DB.APP_MultiFloorBuildingAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault

                If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                    File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                End If

                SaveAttachment()

                With _attachment
                    .BuildingAttachmentName = DocAttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.SubmitChanges()
                _attachment = Nothing
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
        Return _status
    End Function

    Private Function FlatAttachmentSave() As Boolean
        Dim _status As Boolean = True

        Try
            If Page.RouteData.Values("Status") = "Add" Then
                If Not (Check_MFBFlatAttachmentName_Exists(DocAttachmentNameTextBox.Text)) Then
                    _status = False
                    Exit Try
                End If

                SaveAttachment()

                Dim _attachment As New APP_MultiFloorBuildingFlatAttachment
                With _attachment
                    .UserID = Session("UserID")
                    .BuildingAttachmentName = DocAttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.APP_MultiFloorBuildingFlatAttachments.InsertOnSubmit(_attachment)
                DB.SubmitChanges()
                _attachment = Nothing
            ElseIf Page.RouteData.Values("Status") = "Edit" Then
                If Not ViewState("AttachmentName") = DocAttachmentNameTextBox.Text Then
                    If Not (Check_MFBFlatAttachmentName_Exists(DocAttachmentNameTextBox.Text)) Then
                        _status = False
                        Exit Try
                    End If
                End If

                Dim _attachment = (From sd In DB.APP_MultiFloorBuildingFlatAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault

                If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                    File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                End If

                SaveAttachment()

                With _attachment
                    .BuildingAttachmentName = DocAttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.SubmitChanges()
                _attachment = Nothing
            End If




        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Function ShopAttachmentSave() As Boolean
        Dim _status As Boolean = True
        Try
            If Page.RouteData.Values("Status") = "Add" Then
                If Not (Check_MFBShopAttachmentName_Exists(DocAttachmentNameTextBox.Text)) Then
                    _status = False
                    Exit Try
                End If

                SaveAttachment()

                Dim _attachment As New APP_MultiFloorBuildingShopAttachment
                With _attachment
                    .UserID = Session("UserID")
                    .BuildingAttachmentName = DocAttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.APP_MultiFloorBuildingShopAttachments.InsertOnSubmit(_attachment)
                DB.SubmitChanges()
                _attachment = Nothing

            ElseIf Page.RouteData.Values("Status") = "Edit" Then

                If Not ViewState("AttachmentName") = DocAttachmentNameTextBox.Text Then
                    If Not (Check_MFBShopAttachmentName_Exists(DocAttachmentNameTextBox.Text)) Then
                        _status = False
                        Exit Try
                    End If
                End If

                Dim _attachment = (From sd In DB.APP_MultiFloorBuildingShopAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault

                If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                    File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                End If

                SaveAttachment()

                With _attachment
                    .BuildingAttachmentName = DocAttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.SubmitChanges()
                _attachment = Nothing
            End If
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Function OfficeAttachmentSave() As Boolean
        Dim _status As Boolean = True
        Try
            If Page.RouteData.Values("Status") = "Add" Then
                If Not (Check_MFBOfficeAttachmentName_Exists(DocAttachmentNameTextBox.Text)) Then
                    _status = False
                    Exit Try
                End If

                SaveAttachment()

                Dim _attachment As New APP_MultiFloorBuildingOfficeAttachment
                With _attachment
                    .UserID = Session("UserID")
                    .BuildingAttachmentName = DocAttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.APP_MultiFloorBuildingOfficeAttachments.InsertOnSubmit(_attachment)
                DB.SubmitChanges()
                _attachment = Nothing

            ElseIf Page.RouteData.Values("Status") = "Edit" Then

                If Not ViewState("AttachmentName") = DocAttachmentNameTextBox.Text Then
                    If Not (Check_MFBOfficeAttachmentName_Exists(DocAttachmentNameTextBox.Text)) Then
                        _status = False
                        Exit Try
                    End If
                End If

                Dim _attachment = (From sd In DB.APP_MultiFloorBuildingOfficeAttachments Where sd.ID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd).SingleOrDefault

                If File.Exists(Server.MapPath(_attachment.BuildingAttachment)) Then
                    File.Delete(Server.MapPath(_attachment.BuildingAttachment))
                End If

                SaveAttachment()

                With _attachment
                    .BuildingAttachmentName = DocAttachmentNameTextBox.Text.Trim
                    .BuildingAttachment = ViewState("AttachmentPath")
                End With
                DB.SubmitChanges()
                _attachment = Nothing
            End If

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function



    Private Function Check_MFBAttachmentName_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True

        Try

            Dim _info = (From sd In DB.APP_MultiFloorBuildingAttachments Where sd.BuildingID = Convert.ToInt64(Page.RouteData.Values("BuildingID")) Select sd.BuildingAttachmentName).ToList

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Attachment Name Already Exists")
                _status = False
            End If

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Function Check_MFBFlatAttachmentName_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True

        Try

            Dim _info = (From sd In DB.APP_MultiFloorBuildingFlatAttachments Where sd.UserID = Session("UserID") Select sd.BuildingAttachmentName).ToList

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Attachment Name Already Exists")
                _status = False
            End If

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Function Check_MFBShopAttachmentName_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True

        Try

            Dim _info = (From sd In DB.APP_MultiFloorBuildingShopAttachments Where sd.UserID = Session("UserID") Select sd.BuildingAttachmentName).ToList

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Attachment Name Already Exists")
                _status = False
            End If

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function

    Private Function Check_MFBOfficeAttachmentName_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True

        Try

            Dim _info = (From sd In DB.APP_MultiFloorBuildingOfficeAttachments Where sd.UserID = Session("UserID") Select sd.BuildingAttachmentName).ToList

            If _info.Contains(_Name) Then
                PopMsg.ShowErrorMessage("Attachment Name Already Exists")
                _status = False
            End If

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

        Return _status
    End Function


    Private Sub SaveAttachment()
        Try
            ViewState("AttachmentPath") = "NULL"
            Dim _attachmentPath As String
            If (Page.RouteData.Values("Type") = "General") Then
                _attachmentPath = "~/Attachments/Building/" + Page.RouteData.Values("BuildingID").ToString + "/" + Page.RouteData.Values("Type").ToString + "/"
                If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                    Directory.CreateDirectory(Server.MapPath(_attachmentPath))
                End If
            Else
                _attachmentPath = "~/Attachments/Building/" + Page.RouteData.Values("BuildingID").ToString + "/" + Page.RouteData.Values("Type").ToString + "/Temp/" + Session("UserID").ToString + "/"
                If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                    Directory.CreateDirectory(Server.MapPath(_attachmentPath))
                End If
            End If

            If Not DocAttachmentUpload.UploadedFiles.Count = 0 Then
                Dim _targetFolder As String = Server.MapPath(_attachmentPath)
                For Each validFile As UploadedFile In DocAttachmentUpload.UploadedFiles
                    Dim FileToBeSaved As String = DocAttachmentNameTextBox.Text.Trim & validFile.GetExtension
                    Dim FullPath As String = Path.Combine(_targetFolder, FileToBeSaved)
                    If File.Exists(FullPath) Then
                        File.Delete(FullPath)
                    End If
                    validFile.SaveAs(FullPath, True)
                    ViewState("AttachmentPath") = _attachmentPath + FileToBeSaved
                Next
            End If

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

    End Sub


    Protected Sub AttachmentUpload_FileUploaded(sender As Object, e As FileUploadedEventArgs)
        AttachmentImageEditor.ResetChanges()
        Context.Cache.Remove(Session.SessionID + "UploadedFile")
        Using stream As Stream = e.File.InputStream
            Dim imgData As Byte() = New Byte(stream.Length) {}
            stream.Read(imgData, 0, imgData.Length)
            Dim ms As New MemoryStream()
            ms.Write(imgData, 0, imgData.Length)

            Context.Cache.Insert(Session.SessionID + "UploadedFile", ms, Nothing, DateTime.Now.AddMinutes(20), TimeSpan.Zero)
        End Using
        AttachmentImageEditor.Enabled = True
    End Sub



    Protected Sub AttachmentImageEditor_ImageLoading(sender As Object, e As ImageEditorLoadingEventArgs)

        If Not [Object].Equals(Context.Cache.[Get](Session.SessionID + "UploadedFile"), Nothing) Then
            Using image As New EditableImage(DirectCast(Context.Cache.[Remove](Session.SessionID + "UploadedFile"), MemoryStream))
                e.Image = image.Clone()
                e.Cancel = True
            End Using
        End If
    End Sub

    Protected Sub AttachmentImageEditor_ImageSaving(sender As Object, e As ImageEditorSavingEventArgs)
        Try
            If AttachmentNameTextBox.Text = "" Then
                PopMsg.ShowErrorMessage("Please Enter Attachment Name")
                Exit Sub
            End If

            If (Page.RouteData.Values("Type") = "General") Then
                GeneralAttachmentSave(sender, e)

            ElseIf (Page.RouteData.Values("Type") = "Flat") Then
                FlatAttachmentSave(sender, e)

            ElseIf (Page.RouteData.Values("Type") = "Shop") Then
                ShopAttachmentSave(sender, e)

            ElseIf (Page.RouteData.Values("Type") = "Office") Then
                OfficeAttachmentSave(sender, e)
            End If

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

    End Sub

    Private Sub SaveImageAttachment(sender As Object, e As ImageEditorSavingEventArgs)
        Try
            ViewState("AttachmentPath") = "NULL"
            Dim _attachmentPath As String
            If (Page.RouteData.Values("Type") = "General") Then
                _attachmentPath = "~/Attachments/Building/" + Page.RouteData.Values("BuildingID").ToString + "/" + Page.RouteData.Values("Type").ToString + "/"
                If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                    Directory.CreateDirectory(Server.MapPath(_attachmentPath))
                End If
            Else
                _attachmentPath = "~/Attachments/Building/" + Page.RouteData.Values("BuildingID").ToString + "/" + Page.RouteData.Values("Type").ToString + "/Temp/" + Session("UserID").ToString + "/"
                If Not Directory.Exists(Server.MapPath(_attachmentPath)) Then
                    Directory.CreateDirectory(Server.MapPath(_attachmentPath))
                End If
            End If

            Dim img As Telerik.Web.UI.ImageEditor.EditableImage = e.Image
            Dim parameters As New EncoderParameters(1)
            Dim _test = ImageRating.Value * 10
            parameters.Param(0) = New EncoderParameter(System.Drawing.Imaging.Encoder.Quality, Convert.ToByte(ImageRating.Value * 10))


            Dim fullPath As String = _attachmentPath
            Dim fileName As String = AttachmentNameTextBox.Text.Trim + "." + img.Format
            fullPath = Path.Combine(fullPath, fileName)


            img.Image.Save(Server.MapPath(fullPath), GetCodecInfo("image/jpeg"), parameters)
            ViewState("AttachmentPath") = fullPath


            e.Argument = "1"
            e.Cancel = True

        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try

    End Sub

    Private Shared Function GetCodecInfo(ByVal mimeType As String) As ImageCodecInfo
        For Each encoder As ImageCodecInfo In ImageCodecInfo.GetImageEncoders()
            If encoder.MimeType = mimeType Then
                Return encoder
            End If
        Next encoder
        Throw New ArgumentOutOfRangeException(String.Format("'{0}' not supported", mimeType))
    End Function
    Protected Sub DocUploadButton_Click(sender As Object, e As EventArgs)
        Try
            If DocAttachmentNameTextBox.Text = "" Then
                PopMsg.ShowErrorMessage("Please Enter Attachment Name")
                Exit Sub
            End If

            If DocAttachmentUpload.UploadedFiles.Count = 0 Then
                PopMsg.ShowErrorMessage("Please Upload Attachment")
                Exit Sub
            End If

            If (Page.RouteData.Values("Type") = "General") Then
                If Not (GeneralAttachmentSave()) Then
                    Exit Sub
                End If

            ElseIf (Page.RouteData.Values("Type") = "Flat") Then
                If Not (FlatAttachmentSave()) Then
                    Exit Sub
                End If

            ElseIf (Page.RouteData.Values("Type") = "Shop") Then
                If Not (ShopAttachmentSave()) Then
                    Exit Sub
                End If

            ElseIf (Page.RouteData.Values("Type") = "Office") Then
                If Not (OfficeAttachmentSave()) Then
                    Exit Sub
                End If

            End If


            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(System.Web.UI.Page), "Script", "CloseAndRebind();", True)
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
    End Sub
End Class