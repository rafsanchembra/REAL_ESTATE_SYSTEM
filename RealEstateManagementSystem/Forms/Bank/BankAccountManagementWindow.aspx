<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/WindowMaster.Master" CodeBehind="BankAccountManagementWindow.aspx.vb" Inherits="RealEstateManagementSystem.BankAccountManagementWindow" %>
<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolder" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManagerMain" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Master_Div">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Master_Div" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <div id="Master_Div">
        <div class="wrapper">
            <div class="sg-blockcontent">
                <div class="col-10 sg-header">
                    <asp:Label ID="createBankAccountHeaderLabel" runat="server" Text="Bank Account Details" />
                </div>
                <div class="col-row">
                    <div class="col-5">
                        <div class="sg-blockcontent_right">
                            <div class="col-10 sg-label">
                                <asp:Label ID="BankAccountNumberLabel" runat="server" AssociatedControlID="BankAccountNumberTextBox" Text="Account Number" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="BankAccountNumberTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank Account Number" />
                                <asp:RequiredFieldValidator ID="BankAccountNumberRequired" runat="server" ControlToValidate="BankAccountNumberTextBox" ValidationGroup="SubmitButton" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="BankAccountArabicNameLabel" runat="server" AssociatedControlID="BankAccountArabicNameTextBox" Text="Account Arabic Name" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="BankAccountArabicNameTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank Account Arabic Name" onpaste="onTextPaste()">
                                    <ClientEvents OnKeyPress="keyPressed" />
                                </telerik:RadTextBox>
                                <asp:RequiredFieldValidator ID="BankAccountArabicNameRequired" runat="server" ControlToValidate="BankAccountArabicNameTextBox" ValidationGroup="SubmitButton" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="BankAccountEnglishNameLabel" runat="server" AssociatedControlID="BankAccountEnglishNameTextBox" Text="Account English Name" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="BankAccountEnglishNameTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank Account English Name" />
                                <asp:RequiredFieldValidator ID="BankAccountEnglishNameRequired" runat="server" ControlToValidate="BankAccountEnglishNameTextBox" ValidationGroup="SubmitButton" EnableClientScript="true" />
                            </div>
                        </div>
                    </div>
                    <div class="col-5">
                        <div class="sg-blockcontent_left">
                            <div class="col-10 sg-label">
                                <asp:Label ID="BankAccountMemoLabel" runat="server" AssociatedControlID="BankAccountMemoTextBox" Text="Memo" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="BankAccountMemoTextBox" runat="server" TextMode="MultiLine" Height="160px" Width="100%" ToolTip="Bank Account Memo" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-10 sg-button-right">
                    <telerik:RadButton ID="CancelButton" runat="server" Width="100px" Text="Close" CssClass="sg-button-submit" AutoPostBack="false" OnClientClicked="CloseWindow" UseSubmitBehavior="false" />
                    <telerik:RadButton ID="SubmitButton" runat="server" Width="100px" Text="Submit" CssClass="sg-button-submit" ValidationGroup="SubmitButton" OnClick="SubmitButton_Click" UseSubmitBehavior="false" OnClientClicked="ValidateOnSubmit" />
                </div>
            </div>
        </div>
    </div>

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script>
            function CloseAndRebind() {
                var oWindow = GetRadWindow();
                oWindow.BrowserWindow.refreshGrid();
                oWindow.argument = null;
                oWindow.close();
                oWindow.BrowserWindow.closeRadWindow();
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.radWindow;
                else if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow;
                return oWindow;
            }

            function CloseWindow() {
                var oWindow = GetRadWindow();
                oWindow.argument = null;
                oWindow.close();
                return false;
            }

            function ValidateOnSubmit() {
                var val = Page_ClientValidate();
                if (!val) {
                    var i = 0;
                    for (; i < Page_Validators.length; i++) {
                        if (!Page_Validators[i].isvalid) {
                            var _control = $find(Page_Validators[i].controltovalidate);
                            _control.get_styles().EnabledStyle[0] += "border-color: red;";
                            _control.updateCssClass();
                        }
                        else {
                            var _control = $find(Page_Validators[i].controltovalidate);
                            if (Page_Validators[i].controltovalidate.search("BankAccountNumberTextBox") != -1) {
                                _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                _control.updateCssClass();
                            }
                            else if (Page_Validators[i].controltovalidate.search("BankAccountArabicNameTextBox") != -1) {
                                _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                _control.updateCssClass();
                            }
                            else if (Page_Validators[i].controltovalidate.search("BankAccountEnglishNameTextBox") != -1) {
                                _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                _control.updateCssClass();
                            }
                        }
                    }
                }
                return val;
            }

            function keyPressed(sender, args) {
                if (args.get_keyCode() > 64 && args.get_keyCode() < 123) {
                    args.set_cancel(true);
                    alert("Only Arabic letters allowed");
                }
            }

            var currentText;

            function onTextPaste() {
                currentText = $find("<%= BankAccountArabicNameTextBox.ClientID%>").get_textBoxValue();
                setTimeout(checkText, 1);
            }

            function checkText() {
                var totalText = $find("<%= BankAccountArabicNameTextBox.ClientID%>").get_textBoxValue();
                for (var i = 0; i < totalText.length; i++) {
                    if (totalText.charCodeAt(i) > 64 && totalText.charCodeAt(i) < 123) {
                        $find("<%= BankAccountArabicNameTextBox.ClientID%>").set_textBoxValue(currentText);
                        alert("Text contains Non-Arabic letters");
                        break;
                    }
                }
            }
        </script>
    </telerik:RadCodeBlock>
</asp:Content>