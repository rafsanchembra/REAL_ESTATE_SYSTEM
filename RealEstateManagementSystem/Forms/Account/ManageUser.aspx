<%@ Page Title="Users Permissions" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="ManageUser.aspx.vb" Inherits="RealEstateManagementSystem.ManageUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="headerPlaceHolderLabel" runat="server" Text="Manage USer"></asp:Label>
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
                            <asp:Label ID="HeaderLabel" runat="server" Text="Change User Permissions" />
                        </div>
                        <div class="col-row">
                            <div class="col-10 sg-label">
                                <asp:Label ID="label1" runat="server" AssociatedControlID="UserNameList" Text="Users List" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="UserNameList" runat="server" AppendDataBoundItems="true" AutoPostBack="true" EmptyMessage="---Select---"
                                    MarkFirstMatch="true" Width="100%" ToolTip="User List" TabIndex="1" />
                                <asp:RequiredFieldValidator ID="UserNameListRequired" runat="server" ControlToValidate="UserNameList" ValidationGroup="ChangeUserPermissionGroup" CssClass="field-validation-error" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="label_RolesList" runat="server" AssociatedControlID="RoleList" Font-Size="14px" Text="Permissions List" />
                            </div>
                            <div class="col-10">
                                <telerik:RadComboBox ID="RoleList" runat="server" CheckBoxes="true" EnableCheckAllItemsCheckBox="true" AppendDataBoundItems="true" EmptyMessage="---Select---"
                                    AutoPostBack="false" CollapseDelay="10" ExpandDelay="0" DataMember="DefaultView" ItemRequestTimeout="0" ItemsPerRequest="10" Width="100%" ToolTip="Role List" TabIndex="2" />
                            </div>
                        </div>
                        <div class="col-10 sg-button-right">
                            <telerik:RadButton ID="ChangeUserPermissionButton" OnClick="ChangeUserPermissionButton_Click" TabIndex="3" ValidationGroup="ChangeUserPermissionGroup" runat="server" CssClass="sg-button-submit" Text="Save" Width="100px" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
