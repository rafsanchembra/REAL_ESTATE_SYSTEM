Public Class messageBox
    Inherits System.Web.UI.UserControl

    Public Shared IconInfo, IconExc, IconQues, IconError, Iconsuccess As Object

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        IconInfo = "Show Information Icon"
        IconExc = "Show Warning Icon"
        IconQues = "Show Question icon and buttons"
        IconError = "Show Error Icon"
        Iconsuccess = "Show Success Icon"
    End Sub

    Public Sub ShowErrorMessage(ByVal Message As String)
        lblMsg.Text = Message
        image.ImageUrl = "messageBoxImages/error.png"
        CANCEL.Text = "Ok"
        lblTitle.Text = "RealEstate Management System"
        PopUp.Show()
    End Sub

    Public Sub ShowWarningMessage(ByVal Message As String)
        lblMsg.Text = Message
        image.ImageUrl = "messageBoxImages/exc.png"
        CANCEL.Text = "Ok"
        lblTitle.Text = "RealEstate Management System"
        PopUp.Show()
    End Sub

    Public Sub ShowSuccessMessage(ByVal Message As String)
        lblMsg.Text = Message
        image.ImageUrl = "messageBoxImages/success.png"
        CANCEL.Text = "Ok"
        lblTitle.Text = "RealEstate Management System"
        PopUp.Show()
    End Sub

    Public Sub ShowConfirmMessage(ByVal Message As String)
        lblMsg.Text = Message
        image.ImageUrl = "messageBoxImages/ques.png"
        CONFIRM.Visible = True
        CONFIRM.Text = "Yes"
        CANCEL.Text = "No"
        lblTitle.Text = "RealEstate Management System"
        PopUp.Show()
    End Sub

    Protected Sub CONFIRM_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles CONFIRM.Click
        PopUp.Hide()
    End Sub

End Class