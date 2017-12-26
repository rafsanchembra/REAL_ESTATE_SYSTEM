<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/WindowMaster.Master" CodeBehind="FreeLandManagementAttachmentWindow.aspx.vb" Inherits="RealEstateManagementSystem.FreeLandManagementAttachmentWindow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script>
        function CloseAndRebind() {
            var oWindow = GetRadWindow();
            oWindow.argument = null;
            oWindow.close();
            oWindow.BrowserWindow.closeRadWindow("Province");
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
    <div id="Master_Div">
        <div class="wrapper">
            <msg:PopMsg ID="PopMsg" runat="server" />
            <div class="col-10 sg-header">
                <asp:Label ID="HeaderLabel" runat="server" Text="Images" />
            </div>
            <div class="col-row sg-text-align-center">
                <div class="col-10">
                    <telerik:RadImageGallery ID="FreelandRadImage" runat="server" RenderMode="Classic" Width="1024px" Height="650px" >
                        <ThumbnailsAreaSettings Position="Bottom" ScrollOrientation="Horizontal" />
                    </telerik:RadImageGallery>
                </div>
                <div class="col-10 sg-button">
                    <telerik:RadButton ID="CancelButton" runat="server" Width="100px" Text="Close" CssClass="sg-button-cancel" AutoPostBack="false" OnClientClicked="CloseWindow" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
