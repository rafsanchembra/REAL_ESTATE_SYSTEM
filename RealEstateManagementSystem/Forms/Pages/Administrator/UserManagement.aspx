<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="UserManagement.aspx.vb" Inherits="RealEstateManagementSystem.UserManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="HeaderPlaceHolderLabel" runat="server" Text="user management"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="featuredPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="mainPlaceHolder" runat="server">
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
        <div class="sg-blockcontent">
          <div class="col-8 col-push-10">
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/add-user.png" />
                        <p><a runat="server" href="~/Forms/Account/Register.aspx"></a></p>
                        <h1>Add New User</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/settings.png" />
                        <p><a runat="server" href="~/Forms/Account/ManageUser.aspx"></a></p>
                        <h1>User Premission</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/settings.png" />
                        <p><a runat="server" href="~/Forms/Account/ChangeUserName.aspx"></a></p>
                        <h1>Change User name</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/settings.png" />
                        <p><a runat="server" href="~/Forms/Account/ResetPassword.aspx"></a></p>
                        <h1>replace password</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/settings.png" />
                        <p><a runat="server" href="~/Forms/Account/ActivateFreezeUser.aspx"></a></p>
                        <h1>Lock user</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/settings.png" />
                        <p><a runat="server" href="~/Forms/Account/ChangeUserSignature.aspx"></a></p>
                        <h1>Change user signature</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
