<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/WindowMaster.Master" CodeBehind="BankAccountOpeningBalanceManagement.aspx.vb" Inherits="RealEstateManagementSystem.BankAccountOpeningBalanceManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolder" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManagerMain" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel">
        <ClientEvents OnRequestStart="RequestStart" />
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
                <div class="col-10 sg-header-window">
                    <asp:Label ID="UpdateBankAccountOpeningBalanceLabel" runat="server" Text="Update Bank Account Opening Balance" />
                </div>
                <div class="col-row">
                    <div class="col-5">
                        <div class="sg-blockcontent-right">
                            <div class="col-10 sg-label">
                                <asp:Label ID="OldOpeningBalanceLabel" runat="server" AssociatedControlID="OldOpeningBalanceTextBox" Text="Old Opening Balance" />
                            </div>
                            <div class="col-10">
                                <telerik:RadNumericTextBox ID="OldOpeningBalanceTextBox" runat="server" ReadOnly="true" Type="Currency" Width="100%" ToolTip="Bank Account Old Opening Balance">
                                    <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                </telerik:RadNumericTextBox>
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="OldBankAccountOpeningBalanceMemoLabel" runat="server" AssociatedControlID="OldBankAccountOpeningBalanceMemoTextBox" Text="Description" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="OldBankAccountOpeningBalanceMemoTextBox" runat="server" TextMode="MultiLine" ReadOnly="true" Height="215px" Width="100%" ToolTip="Bank Description" />
                            </div>
                        </div>
                    </div>
                    <div class="col-5">
                        <div class="sg-blockcontent-left">
                            <div class="col-10 sg-label">
                                <asp:Label ID="NewOpeningBalanceLabel" runat="server" AssociatedControlID="NewOpeningBalanceTextBox" Text="New Opening Balance" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadNumericTextBox ID="NewOpeningBalanceTextBox" runat="server" Type="Currency" Width="100%" MinValue="0" Value="0" ToolTip="Bank Account New Opening Balance">
                                    <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="NewOpeningBalanceRequired" runat="server" CssClass="field-validation-error" ControlToValidate="NewOpeningBalanceTextBox" ValidationGroup="UpdateOpeningBalanceGroup" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="NewBankAccountOpeningBalanceMemoLabel" runat="server" AssociatedControlID="NewBankAccountOpeningBalanceMemoTextBox" Text="Description" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="NewBankAccountOpeningBalanceMemoTextBox" runat="server" TextMode="MultiLine" Height="135px" Width="100%" ToolTip="Bank Description" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="OpeningBalanceUserSignatureLabel" runat="server" AssociatedControlID="OpeningBalanceUserSignatureTextBox" Text="Signature" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="OpeningBalanceUserSignatureTextBox" runat="server" MaxLength="30" TextMode="Password" Width="100%" ToolTip="User Signature" AutoCompleteType="Disabled" />
                                <asp:RequiredFieldValidator ID="OpeningBalanceUserSignatureRequired" runat="server" CssClass="field-validation-error" ControlToValidate="OpeningBalanceUserSignatureTextBox" ValidationGroup="UpdateOpeningBalanceGroup" EnableClientScript="true" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-10 sg-button-right">
                    <telerik:RadButton ID="OpeningBalanceCancelButton" runat="server" Width="100px" CssClass="sg-button-submit" Text="Close" AutoPostBack="false" OnClientClicked="CloseAndRebind" UseSubmitBehavior="false" />
                    <telerik:RadButton ID="OpeningBalanceSubmitButton" runat="server" Width="100px" CssClass="sg-button-submit" Text="Update" ValidationGroup="UpdateOpeningBalanceGroup" OnClick="OpeningBalanceSubmitButton_Click" UseSubmitBehavior="false" OnClientClicked="BankAccountOpeningBalanceValidate" />
                </div>
            </div>
        </div>
    </div>

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script>
            function BankAccountOpeningBalanceValidate() {
                var _userSignatureObject = $telerik.$("[id$='OpeningBalanceUserSignatureTextBox']").attr('id');
                var _userSignature = $find(_userSignatureObject);

                var _openingBalanceObject = $telerik.$("[id$='NewOpeningBalanceTextBox']").attr('id');
                var _openingBalance = $find(_openingBalanceObject);

                if (_userSignature.get_value() == "") {
                    _userSignature.get_styles().EnabledStyle[0] += "border-color: red;";
                    _userSignature.updateCssClass();
                }
                else if (_userSignature.get_value() != "") {
                    _userSignature.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _userSignature.updateCssClass();
                }
                if (_openingBalance.get_value() == 0) {
                    _openingBalance.get_styles().EnabledStyle[0] += "border-color: red;";
                    _openingBalance.updateCssClass();
                }
                else if (_openingBalance.get_value() != 0) {
                    _openingBalance.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _openingBalance.updateCssClass();
                }
            }

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
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
