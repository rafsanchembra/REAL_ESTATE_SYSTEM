Public Class BuldingFlatAttachmentWindow
    Inherits System.Web.UI.Page

    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ImageLoader()
    End Sub
    Private Sub ImageLoader()
        Dim _path As String
        'Try
        '    Dim _BuildingFlatattach = (From sd In DB.APP_MultiFloorBuildingAttachments Where sd.MultiFloorBuildingFlatID = Convert.ToInt64(Request.QueryString("ID")) Select sd).ToList()(0)
        '    With _BuildingFlatattach
        '        If Not .BuildingFlatAttachment.Length = 0 Then
        '            _path = .BuildingFlatAttachment
        '        End If
        '    End With
        '    BuildingFlatRadImage.ImagesFolderPath = _path
        'Catch ex As Exception
        '    PopMsg.ShowErrorMessage("no image to load")
        'End Try
    End Sub
End Class