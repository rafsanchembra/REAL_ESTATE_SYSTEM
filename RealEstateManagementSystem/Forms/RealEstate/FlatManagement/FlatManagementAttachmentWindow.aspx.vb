﻿Public Class FlatManagementAttachmentWindow
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ImageLoader()
    End Sub
    Private Sub ImageLoader()
        Dim _path As String
        Try
            Dim _Freelandattach = (From sd In DB.APP_FlatAttachments Where sd.FlatID = Convert.ToInt64(Request.QueryString("ID")) Select sd).ToList()(0)
            With _Freelandattach
                If Not .FlatAttachment.Length = 0 Then
                    _path = .FlatAttachment
                End If
            End With
            FlatRadImage.ImagesFolderPath = _path
        Catch ex As Exception
            PopMsg.ShowErrorMessage("no image to load")
        End Try
    End Sub
End Class