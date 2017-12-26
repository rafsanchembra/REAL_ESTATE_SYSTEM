<%@ Page Title="" Language="vb" AutoEventWireup="true" MasterPageFile="~/Content/LoginMaster.Master" CodeBehind="Login.aspx.vb" Inherits="RealEstateManagementSystem.Login" %>

<asp:Content runat="server" ID="Content1" ContentPlaceHolderID="scriptPlaceHolder">
</asp:Content>
<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="headerPlaceHolder">
</asp:Content>
<asp:Content runat="server" ID="Content3" ContentPlaceHolderID="featuredPlaceHolder">
</asp:Content>
<asp:Content runat="server" ID="Content4" ContentPlaceHolderID="mainPlaceHolder">
    <telerik:RadAjaxManager ID="RadAjaxManagerMain" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Master-Div">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Master-Div" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <div id="Master-Div">
        <div class="wrapper sg-no-select">
            <msg:PopMsg ID="PopMsg" runat="server" />
            <div class="sg-absoluteCenter">
                <div class="col-3 col-push-35">
                    <asp:Login ID="UserLogin" runat="server" ViewStateMode="Disabled" RenderOuterTable="true" Width="100%"
                        OnLoginError="UserLogin_LoginError" OnLoggedIn="UserLogin_LoggedIn">
                        <LayoutTemplate>
                             <div class="sg-login">
                            <div class="loginForm">
                                <div class="sg-blockcontent">
                                   
                                        <div class="col-10 sg-header">
                                            <asp:Label ID="HeaderLabel" runat="server" Text="Login" />
                                        </div>
                                        <div class="col-row">
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Text="Username" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadTextBox ID="UserName" runat="server" Width="100%" CssClass="masterTooltip" TabIndex="1" ToolTip="Please Enter UserName." AutoCompleteType="Disabled" />
                                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ValidationGroup="LoginValidationGroup" ControlToValidate="UserName"
                                                    CssClass="field-validation-error" EnableClientScript="true" />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" Text="Password" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadTextBox ID="Password" runat="server" Width="100%" TextMode="Password" ToolTip="Please Enter Password." TabIndex="2" />
                                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ValidationGroup="LoginValidationGroup" ControlToValidate="Password"
                                                    CssClass="field-validation-error" EnableClientScript="true" />
                                            </div>
                                        </div>
                                        <div class="col-10 sg-button-right">
                                            <telerik:RadButton ID="LoginButton" runat="server" ValidationGroup="LoginValidationGroup" CommandName="Login" Text="Login" CssClass="sg-button-submit" Width="100px" TabIndex="3" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </LayoutTemplate>
                    </asp:Login>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
