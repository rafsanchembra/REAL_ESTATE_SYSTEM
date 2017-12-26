<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/WindowMaster.Master" CodeBehind="BankAccountUpdateStatusManagement.aspx.vb" Inherits="RealEstateManagementSystem.BankAccountUpdateStatusManagement" %>
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
        <div class="sg-blockcontent">
            <div class="wrapper">
                <div class="col-10 sg-header-window">
                    <asp:Label ID="UpdateBankAccountAdvanceHeaderLabel" runat="server" Text="Update Bank Account Status" />
                </div>
                <div class="col-3-mid">
                    <div class="sg-blockcontent">
                        <div class="col-10 sg-label">
                            <asp:Label ID="BankAccountStatusLabel" runat="server" AssociatedControlID="BankAccountStatusComboBox" Text="Account Status" />
                        </div>
                        <div class="col-10">
                            <telerik:RadComboBox ID="BankAccountStatusComboBox" runat="server" Width="100%" ToolTip="Please Select Account Status." AppendDataBoundItems="True" CollapseDelay="10" DataMember="DefaultView" EmptyMessage="---Select---"
                                ItemRequestTimeout="0" ExpandDelay="0" ItemsPerRequest="10">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="Active" Value="True" />
                                    <telerik:RadComboBoxItem runat="server" Text="Freezed" Value="False" />
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="UserSignatureLabel" runat="server" AssociatedControlID="UserSignatureTextBox" Text="User Signature" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="UserSignatureTextBox" runat="server" MaxLength="30" TextMode="Password" Width="100%" ToolTip="User Signature" AutoCompleteType="Disabled" />
                            <asp:RequiredFieldValidator ID="UserSignatureRequired" runat="server" ControlToValidate="UserSignatureTextBox" ValidationGroup="UpdateAccountStatusGroup" EnableClientScript="true" />
                        </div>
                        <div class="col-10 sg-button-right">
                            <telerik:RadButton ID="AccountStatusCancelButton" runat="server" Width="100px" CssClass="sg-button-submit" Text="Close" AutoPostBack="false" OnClientClicked="CloseWindow" UseSubmitBehavior="false" />
                            <telerik:RadButton ID="AccountStatusSubmitButton" runat="server" Width="100px" CssClass="sg-button-submit" Text="Update" ValidationGroup="UpdateAccountStatusGroup" OnClick="AccountStatusSubmitButton_Click" UseSubmitBehavior="false" OnClientClicked="BankAccountStatusValidate" />
                        </div>
                    </div>
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

            function BankAccountStatusValidate() {
                var _userSignatureObject = $telerik.$("[id$='UserSignatureTextBox']").attr('id');
                var _userSignature = $find(_userSignatureObject);

                if (_userSignature.get_value() == "") {
                    _userSignature.get_styles().EnabledStyle[0] += "border-color: red;";
                    _userSignature.updateCssClass();
                }
                else {
                    _userSignature.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _userSignature.updateCssClass();
                }
            }
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
