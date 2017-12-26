<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="Administrator.aspx.vb" Inherits="RealEstateManagementSystem.Administrator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="HeaderPlaceHolderLabel" runat="server" Text="administration management"></asp:Label>
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
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/user.png" />
                        <p><a runat="server" href="~/Forms/Pages/Administrator/UserManagement.aspx"></a></p>
                        <h1>User Management</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/Bank.png" />
                        <p><a runat="server" href="~/Forms/Pages/Administrator/Bank.aspx"></a></p>
                        <h1>Bank Management</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
