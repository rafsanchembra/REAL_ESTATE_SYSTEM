Imports Telerik.Web.UI

Public Class FlatBuildingManagement
    Inherits System.Web.UI.Page

    Private DB As RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            FlatNameLabel.Text = Request.QueryString("ID")
        End If
    End Sub

    Private Sub ClearData()
        FlatNameRadTextBox.Text = ""
        FlatNumberRadTextBox.Text = ""
        FlatRoomNoRadTextBox.Text = ""
        FlatBathNoRadTextBox.Text = ""
        FlatBathRoomTypeComboBox.ClearSelection()
        FlatFloorComboBox.ClearSelection()

    End Sub
    Protected Sub FlatRadGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_FlatList") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub FlatRadGrid_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "EditData"
                Dim _gridDataItem As GridDataItem = e.Item  ' To Get All The Data From Selected Row

                FlatEdit_model.VisibleOnPageLoad = True
                FlatEdit_model.NavigateUrl = "" + _gridDataItem("ID").Text
                RadWindowManager_modalPopup.Windows.Add(FlatEdit_model)
                Exit Select
        End Select
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

        Try
         

            Dim _flatInsert As New APP_BuildingFlat
            With _flatInsert
                .BuildingID = Convert.ToInt64(Request.QueryString("ID"))
                .FloorID = Convert.ToInt64(FlatFloorComboBox.SelectedValue)
                .FlatName = FlatNameRadTextBox.Text.Trim
                .FlatNumber = FlatNumberRadTextBox.Text.Trim
                .FlatRoomNo = FlatRoomNoRadTextBox.Text.Trim
                .FlatBathRoomNo = FlatBathNoRadTextBox.Text.Trim
                .FlatBathRoomType = FlatBathRoomTypeComboBox.SelectedValue
                .FlatAddedBy = _currentUserID
                .FlatAddedDate = Now
            End With
            DB.APP_BuildingFlats.InsertOnSubmit(_flatInsert)
            DB.SubmitChanges()
            ClearData()
            FlatRadGrid.DataBind()
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try
       
    End Sub

    Private Function Check_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_BuildingFlats Select sd.FlatName

            If _info.Contains(_Name) Then
                RadAjaxManagerMain.Alert("Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function
    Private Function Check_ShopIdentityNo_Exists(_ID As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_BuildingFlats Select sd.FlatNumber

            If _info.Contains(_ID) Then
                RadAjaxManagerMain.Alert("Flat Number Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
        Return _ID
    End Function
End Class