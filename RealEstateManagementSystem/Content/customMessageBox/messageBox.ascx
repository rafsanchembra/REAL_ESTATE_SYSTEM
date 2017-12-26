<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="messageBox.ascx.vb" Inherits="RealEstateManagementSystem.messageBox" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<link runat="server" href="~/Content/css/style.css" rel="stylesheet" />

<asp:Panel ID="PopPanel" runat="server" ForeColor="White" DefaultButton="CANCEL" Style="display: none;" CssClass="popUpPanel">
    <div class="popUpPanel-body">
        <div class="popUpPanel-header sg-no-select">
            <div class="popUpPanel-col-title">
                <asp:Label ID="lblTitle" runat="server" />
            </div>
        </div>
        <div class="popUpPanel-content">
            <div class="popUpPanel-content-body">
                <div class="col-10">
                    <div class="popUp-col-1 popUpPanel-col-icon sg-no-select">
                        <asp:Image ID="image" runat="server" ImageUrl="~/MessageBoxes/imgs/info.png" />
                    </div>
                    <div class="popUp-col-2 popUpPanel-col-msg sg-no-select">
                        <div class="sg-blockcontent">
                            <asp:Label ID="lblMsg" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="popUpPanel-footer">
            <div class="popUpPanel-col-button">
                <asp:LinkButton ID="LinkButton1" runat="server" />
                <telerik:RadButton ID="CANCEL" runat="server" Text="OK" Width="100px" CssClass="sg-button-popup-cancel" />
                <telerik:RadButton ID="CONFIRM" runat="server" Text="No" Width="100px" Visible="False" CssClass="sg-button-popup-cancel" />
            </div>
        </div>
    </div>
</asp:Panel>
<asp:ModalPopupExtender ID="PopUp" runat="server" Enabled="True" PopupControlID="PopPanel" TargetControlID="LinkButton1" 
    BackgroundCssClass="popUpExtender" OkControlID="CANCEL" >
</asp:ModalPopupExtender>