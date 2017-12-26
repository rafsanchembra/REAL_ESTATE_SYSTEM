Public Class FreeLandManagementAttachmentWindow
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ImageLoader()
    End Sub
    Private Sub ImageLoader()
        Dim _path As String
        Try
            Dim _Freelandattach = (From sd In DB.APP_FreeLandAttachments Where sd.FreeLandID = Convert.ToInt64(Request.QueryString("ID")) Select sd).ToList()(0)
            With _Freelandattach
                If Not .FreeLandAttachment.Length = 0 Then
                    _path = .FreeLandAttachment
                End If
            End With
            FreelandRadImage.ImagesFolderPath = _path
        Catch ex As Exception
            PopMsg.ShowErrorMessage("no image to load")
        End Try
    End Sub
End Class