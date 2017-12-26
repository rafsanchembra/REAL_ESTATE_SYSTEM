<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/WindowMaster.Master" CodeBehind="MapLocator.aspx.vb" Inherits="RealEstateManagementSystem.MapLocator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolder" runat="server">
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
        <div class="wrapper">
            <div class="col-10 sg-closebutton-right">
                <telerik:RadButton runat="server" ID="CloseButton" CssClass="sg-button-close" AutoPostBack="false" OnClientClicked="CloseWindow" />
            </div>
            <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBtAwVqtMD1Jfq1UHb5DJq2uoUkEzgb8Ko"></script>

            <script type="text/javascript">
                window.onload = function () {
                    var mapOptions = {
                        center: new google.maps.LatLng(22.918727, 57.533914),
                        zoom: 15,
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    };
                    var infoWindow = new google.maps.InfoWindow();
                    var latlngbounds = new google.maps.LatLngBounds();
                    var map = new google.maps.Map(document.getElementById("dvMap"), mapOptions);
                    google.maps.event.addListener(map, 'click', function (e) {
                        CloseAndRebind(e.latLng.lat(), e.latLng.lng());
                    });
                }
            </script>
             
            <div id="dvMap" style="width: 1024px; height: 720px">
                <%--<asp:LinkButton ID="AddNewClientLink" runat="server" Text="Add New Client" />--%>
            </div>
        </div>
    </div>

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">

        <script>
            function CloseAndRebind(x, y) {
                var oWindow = GetRadWindow();
                oWindow.BrowserWindow.GetValue(x, y);
                oWindow.argument = null;
                oWindow.close();
            }

            function CloseWindow() {
                var oWindow = GetRadWindow();
                oWindow.argument = null;
                oWindow.close();
                return false;
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.radWindow;
                else if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow;
                return oWindow;
            }

        </script>
    </telerik:RadCodeBlock>
</asp:Content>
