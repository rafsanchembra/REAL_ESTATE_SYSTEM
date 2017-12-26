<%@ Page Title="Reset Password" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="ResetPassword.aspx.vb" Inherits="RealEstateManagementSystem.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="headerPlaceHolderLabel" runat="server" Text="Reset Password"></asp:Label>
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
                        <div class="col-10 sg-header">
                            <asp:Label ID="HeaderLabel" runat="server" Text="Reset Passwords" />
                        </div>
                        <div class="col-row">
                            <div class="col-10 sg-label">
                                <asp:Label ID="label_UserNameList" runat="server" AssociatedControlID="UserNameList" Text="User List" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="UserNameList" runat="server" AppendDataBoundItems="true" AutoPostBack="true"
                                    EmptyMessage="--Select--" CausesValidation="false" MarkFirstMatch="true" Width="100%" ToolTip="User list" TabIndex="1" />
                            </div>

                            <%-- <div class="col-10 sg-label">
                            <asp:Label ID="label_CurrentPassword" runat="server" AssociatedControlID="CurrentPassword" Text="Current Password" />
                        </div>
                        <div class="col-10 sg-textbox-required-field">
                            <telerik:RadTextBox ID="CurrentPassword" runat="server" ReadOnly="true" Width="100%" ToolTip="Current password" TabIndex="2" />
                            <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword" CssClass="field-validation-error"
                                ValidationGroup="ResetPasswordValidationGroup"></asp:RequiredFieldValidator>
                        </div>--%>
                            <div class="col-10 sg-label">
                                <asp:Label ID="label_NewPassword" runat="server" AssociatedControlID="NewPassword" Text="New Password" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="NewPassword" runat="server" TextMode="Password" Width="100%" ToolTip="New Password" TabIndex="3" />
                                <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword" CssClass="field-validation-error"
                                    ValidationGroup="ResetPasswordValidationGroup"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="label_ConfirmPassword" runat="server" AssociatedControlID="ConfirmPassword" Text="Confirm Password" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="ConfirmPassword" runat="server" TextMode="Password" Width="100%" ToolTip="Confirm new password" TabIndex="4" />
                                <asp:RequiredFieldValidator ID="ConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword" CssClass="field-validation-error"
                                    ValidationGroup="ResetPasswordValidationGroup"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmPassword"
                                    CssClass="field-validation-error" ValidationGroup="RestPasswordValidationGroup"></asp:CompareValidator>
                            </div>
                        </div>
                    </div>
                    <div class="col-10 sg-button-right">
                        <telerik:RadButton ID="button_ResetPassword" runat="server" TabIndex="5" CssClass="sg-button-submit" Text="Reset Password" ValidationGroup="ResetPasswordValidationGroup" Width="125px" />
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
