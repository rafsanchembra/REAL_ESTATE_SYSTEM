<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="RealEstate.aspx.vb" Inherits="RealEstateManagementSystem.RealEstate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="HeaderPlaceHolderLabel" runat="server" Text="real estate management"></asp:Label>
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
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/freeland.png" />
                        <p><a runat="server" href="~/Forms/RealEstate/FreeLandManagement/FreeLandManagement.aspx"></a></p>
                        <h1>FreeLandManagement</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/flat.png" />
                        <p><a runat="server" href="~/Forms/RealEstate/FlatManagement/FlatManagement.aspx"></a></p>
                        <h1>FlatManagement</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/villa.png" />
                        <p><a runat="server" href="~/Forms/RealEstate/VillaManagement/VillaManagement.aspx"></a></p>
                        <h1>VillaManagement</h1>
                    </div>
                </div>
                <div class="col-33">
                    <div class="box">
                        <asp:Image runat="server" ImageUrl="~/Content/css/images/building.png" />
                        <p><a runat="server" href="~/Forms/RealEstate/BuildingManagement/BuildingManagement.aspx"></a></p>
                        <h1>BuildingManagement</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
