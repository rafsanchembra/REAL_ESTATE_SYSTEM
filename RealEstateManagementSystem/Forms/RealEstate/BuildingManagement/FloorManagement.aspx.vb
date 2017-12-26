Imports Telerik.Web.UI

Public Class FloorManagement
    Inherits System.Web.UI.Page
    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

        End If
    End Sub


    Private Sub ClearData()
        FloorNameRadTextBox.Text = ""
        FloorNumberRadTextBox.Text = ""
    End Sub

    Protected Sub SubmitButton_Click(sender As Object, e As EventArgs)
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

        If Not Check_Name_Exists(FloorNameRadTextBox.Text.Trim) Then
            If Not Check_Number_Exists(FloorNumberRadTextBox.Text.Trim) Then
                Exit Sub
            End If
        End If


        Dim _FloorInfo As New APP_BuildingFloor
        With _FloorInfo
            .BuildingID = Convert.ToInt64(Request.QueryString("ID"))
            .FloorName = FloorNameRadTextBox.Text.Trim
            .FloorNo = FloorNumberRadTextBox.Text.Trim
            .FloorAddedBy = _currentUserID
            .FloorAddeddate = Now
        End With
        DB.APP_BuildingFloors.InsertOnSubmit(_FloorInfo)
        DB.SubmitChanges()
        ClearData()
        FloorRadGrid.DataBind()
    End Sub
    Private Function Check_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_BuildingFloors Select sd.FloorName

            If _info.Contains(_Name) Then
                RadAjaxManagerMain.Alert("Name Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Private Function Check_Number_Exists(_Number As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_BuildingFloors Select sd.FloorNo

            If _info.Contains(_Number) Then
                RadAjaxManagerMain.Alert("Floor Number Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try

        Return _status
    End Function

    Protected Sub FloorRadGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_Floors") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub FloorRadGrid_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "EditData"
                Dim _gridDataItem As GridDataItem = e.Item  ' To Get All The Data From Selected Row

                FloorEdit_model.VisibleOnPageLoad = True
                FloorEdit_model.NavigateUrl = "~/Forms/RealEstate/BuildingManagement/FloorManagementWindow.aspx?ID=" + _gridDataItem("ID").Text
                RadWindowManager_modalPopup.Windows.Add(FloorEdit_model)
                Exit Select
        End Select
    End Sub
End Class