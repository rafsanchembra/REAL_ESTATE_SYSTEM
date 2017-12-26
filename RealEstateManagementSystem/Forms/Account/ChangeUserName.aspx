<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="ChangeUserName.aspx.vb" Inherits="RealEstateManagementSystem.ChangeUserName" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="headerPlaceHolderLabel" runat="server" Text="Change USerName"></asp:Label>
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
    <div id="Master_Div">
        <div class="wrapper">
            <msg:PopMsg ID="PopMsg" runat="server" />
            <div class="sg-absoluteCenter">
                <div class="col-3 col-push-35">
                    <div class="sg-blockcontent">
                        <div class="col-10 sg-header">
                            <asp:Label ID="HeaderLabel" runat="server" Text="Change User name" />
                        </div>
                        <div class="col-row">
                            <div class="col-10 sg-label">
                                <asp:Label ID="UsersListLabel" runat="server" AssociatedControlID="UsersListComboBox" Text="Users List" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="UsersListComboBox" runat="server" Width="100%" ToolTip="Please Select A User." AppendDataBoundItems="True" CollapseDelay="10" DataMember="DefaultView" EmptyMessage="---Select---"
                                    ItemRequestTimeout="0" ExpandDelay="0" ItemsPerRequest="10" OnSelectedIndexChanged="UsersListComboBox_SelectedIndexChanged" AutoPostBack="true" TabIndex ="1" />
                                <asp:RequiredFieldValidator ID="UserListRequired" runat="server" ValidationGroup="ChangeUserNameValidationGroup" ControlToValidate="UsersListComboBox" CssClass="field-validation-error" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="SelectedUserLabel" runat="server" AssociatedControlID="SelectedUserTextBox" Text="Selected User"  />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="SelectedUserTextBox" runat="server" Width="100%" Enabled="false" ToolTip="Selected User." TabIndex="2"/>
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="NewUserNameLabel" runat="server" AssociatedControlID="NewUserName" Text="New Username" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="NewUserName" runat="server" Width="100%" ToolTip="Please Enter New Username." TabIndex ="3" />
                                <asp:RequiredFieldValidator ID="NewUserNameRequired" runat="server" ValidationGroup="ChangeUserNameValidationGroup" ControlToValidate="NewUserName" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="ConfirmNewUserNameLabel" runat="server" AssociatedControlID="ConfirmNewUserName" Text="Re-Enter New Username" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="ConfirmNewUserName" runat="server" Width="100%" ToolTip="Please Re-Enter New Username." TabIndex="4"/>
                                <asp:RequiredFieldValidator ID="ConfirmNewUserNameRequired" runat="server" ValidationGroup="ChangeUserNameValidationGroup" ControlToValidate="ConfirmNewUserName" EnableClientScript="true" />
                                <asp:CompareValidator ID="NewUserNameCompare" runat="server" ControlToCompare="NewUserName" ControlToValidate="ConfirmNewUserName" ValidationGroup="ChangeUserNameValidationGroup" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-button-right">
                                <telerik:RadButton ID="ChangeUsernameButton" runat="server" ValidationGroup="ChangeUserNameValidationGroup" CssClass="sg-button-submit" TabIndex ="5" Text="Submit" Width="100px" OnClick="ChangeUsernameButton_Click" OnClientClicked="ValidateOnSubmit" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <telerik:RadCodeBlock ID="radCodeBlock" runat="server">
        <script>
            function ValidateOnSubmit() {
                var val = Page_ClientValidate();
                if (!val) {
                    var i = 0;
                    for (; i < Page_Validators.length; i++) {
                        if (!Page_Validators[i].isvalid) {
                            var _control = $find(Page_Validators[i].controltovalidate);

                            if (Page_Validators[i].controltovalidate.search("UsersListComboBox") != -1) {
                                _control.ToolTip = "Please Select User.";
                                var _element = _control.get_inputDomElement();
                                _element.style.backgroundColor = "red";
                            }
                            else if (Page_Validators[i].controltovalidate.search("NewUserName") != -1) {
                                if (Page_Validators[i].controltovalidate.search("ConfirmNewUserName") != -1) {
                                    _control.get_styles().EnabledStyle[0] += "border-color: red;";
                                    _control.updateCssClass();
                                }
                                else {
                                    _control.get_styles().EnabledStyle[0] += "border-color: red;";
                                    _control.updateCssClass();
                                }
                            }
                        }
                        else {
                            var _control = $find(Page_Validators[i].controltovalidate);
                            if (Page_Validators[i].controltovalidate.search("UsersListComboBox") != -1) {
                                var _element = _control.get_inputDomElement();
                                _element.style.backgroundColor = "white";
                            }
                            else if (Page_Validators[i].controltovalidate.search("NewUserName") != -1) {
                                if (Page_Validators[i].controltovalidate.search("ConfirmNewUserName") != -1) {
                                    var _password = ValidatorGetValue(Page_Validators[i].controltovalidate);
                                    if (_password != "") {
                                        if (Page_Validators[i].controltovalidate != Page_Validators[i].initialvalue) {
                                            _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                            _control.updateCssClass();
                                        }
                                    }
                                }
                                else {
                                    _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                    _control.updateCssClass();
                                }
                            }
                        }
                    }
                }
                return val;
            }
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
