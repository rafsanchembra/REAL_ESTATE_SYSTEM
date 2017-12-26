Public Class VillaManagementAttachmentWindow
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ImageLoader()
    End Sub
    Private Sub ImageLoader()
        Dim _path As String
        Try
            Dim _villaattach = (From sd In DB.APP_VillaAttachments Where sd.VillaID = Convert.ToInt64(Request.QueryString("ID")) Select sd).ToList()(0)
            With _villaattach
                If Not .VillaAttachment.Length = 0 Then
                    _path = .VillaAttachment
                End If
            End With
            VillaRadImage.ImagesFolderPath = _path
        Catch ex As Exception
            PopMsg.ShowErrorMessage("no image to load")
        End Try
    End Sub
End Class