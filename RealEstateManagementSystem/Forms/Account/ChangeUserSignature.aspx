<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="ChangeUserSignature.aspx.vb" Inherits="RealEstateManagementSystem.ChangeUserSignature" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script type="text/javascript">
        function changeCase(sender) {
            sender.value = sender.value.toUpperCase();
        }

        function validationFailed(sender, args) {
            sender.deleteFileInputAt(0);
            alert("Invalid file type");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="headerPlaceHolderLabel" runat="server" Text="Change Siganture"></asp:Label>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="featuredPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManagerMain" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Master_Div">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Master_Div" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <div id="Master_Div" runat="server">
        <div class="wrapper">
            <msg:PopMsg ID="PopMsg" runat="server" />
            <div class="sg-absoluteCenter">
                <div class="col-3 col-push-35">
                    <div class="sg-blockcontent">
                        <div class="col-row">
                            <div class="col-10 sg-header">
                                <asp:Label ID="HeaderLabel" runat="server" Text="Change User Signature" />
                            </div>

                            <div class="col-10 sg-label">
                                <asp:Label ID="label_UserNameList" runat="server" AssociatedControlID="UserNameList" Text="List" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="UserNameList" runat="server" AppendDataBoundItems="true" EmptyMessage="--Select--"
                                    CausesValidation="false" MarkFirstMatch="true" Width="100%" ToolTip="User List" TabIndex ="1" />
                            </div>

                            <div class="col-10 sg-label">
                                <asp:Label ID="label_UserNewSignature" runat="server" AssociatedControlID="NewUserSignature" Text="New Signature" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="NewUserSignature" runat="server" TextMode="Password" Width="100%" ToolTip="Enter User Signature" TabIndex ="2"/>
                                <asp:RequiredFieldValidator ID="NewUserSignatureRequired" runat="server" ControlToValidate="NewUserSignature" CssClass="field-validation-error"
                                    ToolTip="New user signature." ValidationGroup="ChangeUserSignatureValidation"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="label_ConfirmNewUserSignature" runat="server" AssociatedControlID="ConfirmNewUserSignature" Text="Confirm New Signature" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="ConfirmNewUserSignature" runat="server" TextMode="Password" Width="100%" ToolTip="Confirm User Signature" TabIndex ="3" />
                                <asp:RequiredFieldValidator ID="ConfirmNewUserSignatureRequired" runat="server" ControlToValidate="ConfirmNewUserSignature" CssClass="field-validation-error"
                                    ToolTip="New user signature." ValidationGroup="ChangeUserSignatureValidation">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="NewSignatureCompare" runat="server" ControlToCompare="NewUserSignature" ControlToValidate="ConfirmNewUserSignature" CssClass="field-validation-error"
                                    ValidationGroup="ChangeUserSignatureValidation">*</asp:CompareValidator>
                            </div>
                        </div>
                        <div class="col-10 sg-button-right">
                            <telerik:RadButton ID="ChangeUserSignatureButton" runat="server" Text="Submit" TabIndex="4" CssClass="sg-button-submit" ValidationGroup="ChangeUserSignatureValidation" Width="100px" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
</asp:Content>
