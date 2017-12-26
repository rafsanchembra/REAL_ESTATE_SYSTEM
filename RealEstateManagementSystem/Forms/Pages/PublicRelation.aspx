<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="PublicRelation.aspx.vb" Inherits="RealEstateManagementSystem.PublicRelation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="HeaderPlaceHolderLabel" runat="server" Text="public relation management"></asp:Label>
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
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/contact.png" />
                        <p><a runat="server" href="~/Forms/PublicRelation/Contact/ContactManagement.aspx"></a></p>
                        <h1>Contact Management</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/client.png" />
                        <p><a runat="server" href="~/Forms/PublicRelation/Client/ClientManagement.aspx"></a></p>
                        <h1>Client Management</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/supplier.png" />
                        <p><a runat="server" href="~/Forms/PublicRelation/Supplier/SupplierManagement.aspx"></a></p>
                        <h1>Supplier Management</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/owner.png" />
                        <p><a runat="server" href="~/Forms/PublicRelation/Owner/OwnerManagement.aspx"></a></p>
                        <h1>Owner Management</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
