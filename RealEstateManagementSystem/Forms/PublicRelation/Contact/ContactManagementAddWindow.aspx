<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/WindowMaster.Master" CodeBehind="ContactManagementAddWindow.aspx.vb" Inherits="RealEstateManagementSystem.ContactManagementAddWindow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script>
        function CloseAndRebind() {
            var oWindow = GetRadWindow();
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
    <div class="col-10 sg-closebutton-right">
        <telerik:RadButton runat="server" ID="CloseButton"  CssClass="sg-button-close" AutoPostBack="false" OnClientClicked="CloseWindow" />
    </div>
    <div id="Master_Div" runat="server">
        <div class="wrapper">
            <msg:PopMsg ID="PopMsg" runat="server" />
            <div class="col-10 sg-header">
                <asp:Label ID="HeaderLabel" runat="server" Text="Contact Management" />
            </div>
            <div class="col-row">
                <div class="col-5">
                    <div class="sg-blockcontent-right">
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactNameLabel" runat="server" AssociatedControlID="ContactNameTextBox" Text="Name" />
                        </div>
                        <div class="col-10 sg-textbox-required-field">
                            <telerik:RadTextBox ID="ContactNameTextBox" runat="server" Width="100%" ToolTip="Contact Name" TabIndex="1" />
                            <asp:RequiredFieldValidator ID="ContactNameRequired" runat="server" ControlToValidate="ContactNameTextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactCommercialRegisterNumberLabel" runat="server" AssociatedControlID="ContactCommercialRegisterNumberTextBox" Text="Commercial Register Number" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactCommercialRegisterNumberTextBox" runat="server" Width="100%" ToolTip="Contact Commercial Register Number" TabIndex="3" />
                        </div>
                    </div>
                </div>
                <div class="col-5">
                    <div class="sg-blockcontent-left">
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactNickNameLabel" runat="server" AssociatedControlID="ContactNickNameComboBox" Text="Nick Name" />
                        </div>
                        <div class="col-10">
                            <telerik:RadComboBox ID="ContactNickNameComboBox" runat="server" CausesValidation="False" Width="100%" MarkFirstMatch="True"
                                ItemRequestTimeout="0" DropDownAutoWidth="Disabled" ToolTip="Contact Nick Name" TabIndex="2">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="الفاضل" Value="الفاضل" />
                                    <telerik:RadComboBoxItem runat="server" Text="معالي" Value="معالي" />
                                    <telerik:RadComboBoxItem runat="server" Text="سماحة الشيخ" Value="سماحة الشيخ" />
                                    <telerik:RadComboBoxItem runat="server" Text="الشيخ" Value="الشيخ" />
                                    <telerik:RadComboBoxItem runat="server" Text="معالي الشيخ" Value="معالي الشيخ" />
                                    <telerik:RadComboBoxItem runat="server" Text="سعادة الشيخ" Value="سعادةالشيخ" />
                                    <telerik:RadComboBoxItem runat="server" Text="سعادة" Value="سعادة" />
                                    <telerik:RadComboBoxItem runat="server" Text="المكرم" Value="المكرم" />
                                    <telerik:RadComboBoxItem runat="server" Text="فضيلة" Value="فضيلة" />
                                    <telerik:RadComboBoxItem runat="server" Text="فضيلة الشيخ" Value="فضيلة الشيخ" />
                                    <telerik:RadComboBoxItem runat="server" Text="الأفاضل" Value="الأفاضل" />
                                    <telerik:RadComboBoxItem runat="server" Text="الدكتور" Value="الدكتور" />
                                    <telerik:RadComboBoxItem runat="server" Text="المهندس" Value="المهندس" />
                                    <telerik:RadComboBoxItem runat="server" Text="صاحب السمو" Value="صاحب السمو" />
                                    <telerik:RadComboBoxItem runat="server" Text="معالي السيد" Value="معالي السيد" />
                                    <telerik:RadComboBoxItem runat="server" Text="سعادة السيد" Value="سعادة السيد" />
                                    <telerik:RadComboBoxItem runat="server" Text="MR" Value="MR" />
                                    <telerik:RadComboBoxItem runat="server" Text="MSS" Value="MSS" />
                                    <telerik:RadComboBoxItem runat="server" Text="M\S" Value="M\S" />
                                    <telerik:RadComboBoxItem runat="server" Text="" Value="" />
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactGSM1Label" runat="server" AssociatedControlID="ContactGSM1TextBox" Text="GSM 1" />
                        </div>
                        <div class="col-10">
                            <telerik:RadComboBox runat="server" ID="ContactGSM1ContryCodeCombobox" ToolTip="Select GSM Number " TabIndex="4" AppendDataBoundItems="True" CausesValidation="False" CollapseDelay="10" DataMember="DefaultView"
                                Width="29%" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains" OnClientSelectedIndexChanged="GSM1_OnClientSelectedIndexChanged">
                                <Items>
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Oman.png" Text="Oman    +968" Value="968" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/UAE.png" Text="Emirates    +971" Value="971" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Saudi.png" Text="Saudi    +966" Value="966" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Kuwait.png" Text="Kuwait    +965" Value="965" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Qatar.png" Text="Qatar    +974" Value="974" />
                                </Items>
                            </telerik:RadComboBox>
                            <telerik:RadTextBox ID="ContactGSM1TextBox" runat="server" Enabled="false" TabIndex="5" Width="70%" ToolTip="Contact GSM 2" />
                            <asp:RequiredFieldValidator ID="ContactGSM1Required" runat="server" ControlToValidate="ContactGSM1TextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                        </div>
                    </div>
                </div>
                <div class="sg-button-right">
                    <telerik:RadButton ID="SubmitButton" runat="server" Text="Submit" Width="100px" CssClass="sg-button-submit" TabIndex="6" ValidationGroup="SubmitButton" OnClick="SubmitButton_Click" />
                    <telerik:RadButton ID="CancelButton" Width="100px" Text="Cancel" runat="server" TabIndex="7" CssClass="sg-button-submit" CausesValidation="False" CommandName="Cancel" OnClientClicked="CloseWindow" />
                </div>
            </div>
        </div>
    </div>
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">
            function GSM1_OnClientSelectedIndexChanged(sender, eventArgs) {
                var _mobileNumber = $find("<%= ContactGSM1TextBox.ClientID%>");
                _mobileNumber.enable();
                _mobileNumber.set_value("");
                _mobileNumber.enable();
                _mobileNumber.focus();
            }
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
