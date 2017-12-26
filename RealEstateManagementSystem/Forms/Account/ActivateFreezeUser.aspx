<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="ActivateFreezeUser.aspx.vb" Inherits="RealEstateManagementSystem.ActivateFreezeUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="headerPlaceHolderLabel" runat="server" Text="Change User Status"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="featuredPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="mainPlaceHolder" runat="server">
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
            <msg:PopMsg ID="PopMsg" runat="server" />
            <div class="sg-absoluteCenter">
                <div class="col-3 col-push-35">
                    <div class="sg-blockcontent">
                        <div class="col-10 sg-header">
                            <asp:Label ID="HeaderLabel" runat="server" Text="Activate Or Freeze Users" />
                        </div>

                        <div class="col-row">
                            <div class="col-10 sg-label">
                                <asp:Label ID="label_UserNameList" runat="server" AssociatedControlID="UserNameList" Text="Users Lists" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="UserNameList" runat="server" AppendDataBoundItems="True" ToolTip ="select user" TabIndex="1" AutoPostBack="true" EmptyMessage=" --Select-- "
                                    CausesValidation="False" MarkFirstMatch="True" Width="100%" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="label_CurrentUserName" runat="server" AssociatedControlID="txt_CurrentUserName" Text="Current User Name" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="txt_CurrentUserName" runat="server" ReadOnly="true" Width="100%" ToolTip ="Current User Name." TabIndex ="2"  />
                                <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="txt_CurrentUserName" CssClass="field-validation-error"
                                    ToolTip="Current User Name." ValidationGroup="ChangeUserNameValidationGroup" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="label_UserStatus" runat="server" AssociatedControlID="cmb_UserStatus" Text="User Status" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="cmb_UserStatus" runat="server" AppendDataBoundItems="True" ToolTip="Select Status" TabIndex ="3" CausesValidation="False" MarkFirstMatch="True" Width="100%">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Active" Value="Active" />
                                        <telerik:RadComboBoxItem runat="server" Text="Freezed" Value="Freezed" />
                                    </Items>
                                </telerik:RadComboBox>
                            </div>
                        </div>
                        <div class="col-10 sg-button-right">
                            <telerik:RadButton ID="ChangeUserNameButton" runat="server" Text="Submit" TabIndex="4" CssClass="sg-button-submit" ValidationGroup="ChangeUserNameValidationGroup" Width="100px" />   
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
