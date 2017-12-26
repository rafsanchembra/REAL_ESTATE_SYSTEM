Imports Telerik.Web.UI

Public Class ShopManagement
    Inherits System.Web.UI.Page
    Private DB As New RealDataDataContext
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

        End If
    End Sub

    Private Sub cleardata()
        ShopNameRadTextBox.Text = ""
        ShopNumberRadTextBox.Text = ""
        ShopCapacityRadTextBox.Text = ""
        ShopFloorComboBox.ClearSelection()

    End Sub

    Protected Sub ShopButton_Click(sender As Object, e As EventArgs)
        Dim _currentUser As MembershipUser = Membership.GetUser
        Dim _currentUserID As Guid = CType(_currentUser.ProviderUserKey, Guid)

        Try
            If Not Check_Name_Exists(ShopNameRadTextBox.Text.Trim) Then
                Exit Sub
            End If

            If Not Check_ShopIdentityNo_Exists(ShopNumberRadTextBox.Text.Trim) Then
                Exit Sub
            End If

            Dim _shopInsert As New APP_BuildingShop
            With _shopInsert
                .BuildingID = Convert.ToInt64(Request.QueryString("ID"))
                .FloorID = ShopFloorComboBox.SelectedValue
                .ShopName = ShopNameRadTextBox.Text.Trim
                .ShopNumber = ShopNumberRadTextBox.Text.Trim
                .ShopCapacity = ShopCapacityRadTextBox.Text.Trim
                .ShopAddedDate = Now
                .ShopAddedBy = _currentUserID
            End With
            DB.APP_BuildingShops.InsertOnSubmit(_shopInsert)
            DB.SubmitChanges()
            cleardata()
            ShopRadGrid.DataBind()
        Catch ex As Exception
            PopMsg.ShowErrorMessage(ex.Message)
        End Try



    End Sub
    Private Function Check_Name_Exists(_Name As String) As Boolean
        Dim _status As Boolean = True

        Try
            Dim _info = From sd In DB.APP_BuildingShops Select sd.ShopName

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
            Dim _info = From sd In DB.APP_BuildingShops Select sd.ShopNumber

            If _info.Contains(_ID) Then
                RadAjaxManagerMain.Alert("Shop Number Already Exists")
                _status = False
            End If
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
        Return _ID
    End Function

    Protected Sub ShopRadGrid_ItemDataBound(sender As Object, e As Telerik.Web.UI.GridItemEventArgs)
        If (TypeOf e.Item Is GridDataItem AndAlso e.Item.OwnerTableView.DataSourceID = "SqlDataSource_ShopList") Then
            Dim _IDLabel As Label = CType(e.Item.FindControl("IDLabel"), Label)
            _IDLabel.Text = (e.Item.ItemIndex + 1).ToString
        End If
    End Sub

    Protected Sub ShopRadGrid_ItemCommand(sender As Object, e As Telerik.Web.UI.GridCommandEventArgs)
        Select Case Convert.ToString(e.CommandName)
            Case "EditData"
                Dim _gridDataItem As GridDataItem = e.Item  ' To Get All The Data From Selected Row

                ShopEdit_model.VisibleOnPageLoad = True
                ShopEdit_model.NavigateUrl = "~/Forms/RealEstate/BuildingManagement/ShopManagementWindow.aspx?ID=" + _gridDataItem("ID").Text
                RadWindowManager_modalPopup.Windows.Add(ShopEdit_model)
                Exit Select
        End Select
    End Sub
End Class