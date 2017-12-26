<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="Building.aspx.vb" Inherits="RealEstateManagementSystem.Building" %>

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
                        <p>
                            <a runat="server" href="~/Administrator/RealEstate/BuildingManagement/Add">
                                <asp:Image runat="server" ImageUrl="~/Content/css/images/add.png" />
                            </a>
                        </p>
                        <h1>Add</h1>
                    </div>
                </div>
                <div class="col-33">
                   <div class="box">
                        <p>
                            <a runat="server" href="~/Administrator/RealEstate/BuildingManagement/List">
                                <asp:Image runat="server" ImageUrl="~/Content/css/images/update.png" />
                            </a>
                        </p>
                        <h1>Update</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
