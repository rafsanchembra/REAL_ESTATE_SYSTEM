<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="Register.aspx.vb" Inherits="RealEstateManagementSystem.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="headerPlaceHolderLabel" runat="server" Text="Add New User"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="featuredPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="mainPlaceHolder" runat="server">
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
                    <%--<div class="col-10 sg-header">
                            <asp:Label ID="HeaderLabel" runat="server" Text="Add New User" />
                        </div>--%>
                    <div class="sg-blockcontent">
                        <asp:CreateUserWizard ID="RegisterUser" runat="server" EnableViewState="false" CompleteSuccessText="User created Successful."
                            OnCreateUserError="RegisterUser_CreateUserError" CancelButtonText="Permission" OnCreatedUser="RegisterUser_CreatedUser"
                            ContinueDestinationPageUrl="~/Forms/Account/ManageUser.aspx" DuplicateEmailErrorMessage="Already Registered Email Id" DuplicateUserNameErrorMessage="Username Exists..!!" ErrorMessageStyle-CssClass="sg-error"
                            FinishCompleteButtonText="Finished" LoginCreatedUser="false" StartNextButtonText="Next" StepNextButtonText="Next"
                            UnknownErrorMessage="System fails to create user. Please try again later!" RequireEmail="true" BackColor="#CC0000"
                            InvalidPasswordErrorMessage="Password must be bigger that {0}. Password must have non-alphabetic character {1}.">
                            <LayoutTemplate>
                                <asp:PlaceHolder ID="wizardStepPlaceHolder" runat="server" />
                                <asp:PlaceHolder ID="navigationPlaceHolder" runat="server" />
                            </LayoutTemplate>
                            <WizardSteps>
                                <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                                    <ContentTemplate>
                                        <span>
                                            <asp:Literal ID="ErrorMessage" runat="server" />
                                        </span>
                                        <div class="userRegisterForm">
                                            <div class="col-row">
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" Text="User Name" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="UserName" runat="server" Width="100%" TabIndex="1" ToolTip ="User Name" />
                                                    <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" ValidationGroup="RegisterUserValidationGroup" EnableClientScript="true"/>
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" Text="Email" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="Email" runat="server" Width="100%" TabIndex="2" ToolTip ="Enter Email Id" />
                                                    <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" ValidationGroup="RegisterUserValidationGroup" EnableClientScript="true"/>
                                                    <asp:RegularExpressionValidator ID="EmailRegularExpression" runat="server"  ValidationGroup="RegisterUserValidationGroup" ControlToValidate="Email"  ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" EnableClientScript="true"/>
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" Text="Password"/>
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="Password" runat="server" TextMode="Password" Width="100%" TabIndex="3" ToolTip="Enter Password"/>
                                                    <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" ToolTip="Password" ValidationGroup="RegisterUserValidationGroup" EnableClientScript="true"/>
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Confirm Password</asp:Label>
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="ConfirmPassword" runat="server" TextMode="Password" Width="100%" TabIndex="4" ToolTip="Confirm Password"/>
                                                    <asp:RequiredFieldValidator ID="ConfirmPasswordrequired" runat="server" ControlToValidate="ConfirmPassword"
                                                        ToolTip="Confirm Password" ValidationGroup="RegisterUserValidationGroup" EnableClientScript="true"/>
                                                    <asp:CompareValidator runat="server" ID="ComparePassword" ControlToValidate="ConfirmPassword" ValidationGroup="RegisterUserValidationGroup"
                                                        CssClass="field-compare-error" ToolTip="Password not matching!" ControlToCompare="Password" EnableClientScript="true" />
                                                </div>
                                            </div>
                                            <div class="col-10 sg-button-right">
                                                <telerik:RadButton ID="CreateUser" runat="server" CommandName="MoveNext" CssClass="sg-button-submit" TabIndex="5" Text="Submit" ValidationGroup="RegisterUserValidationGroup" Width="100px" OnClientClicked="ValidateOnSubmit" />
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                    <CustomNavigationTemplate>
                                    </CustomNavigationTemplate>
                                </asp:CreateUserWizardStep>
                                <asp:CompleteWizardStep runat="server" ID="CompleteStep" AllowReturn="false">
                                    <ContentTemplate>
                                        <div class="userRegisterForm">
                                            <p>
                                                USER REGISTERED SUCCESSFULLY!!!!
                                            </p>
                                        </div>
                                        <div class="col-10 sg-button">
                                            <telerik:RadButton ID="PermissionsButton" runat="server" Text="Set User Permission" Width="200px" CssClass="sg-button-submit" NavigateUrl="~/Forms/Account/ManageUser.aspx" ButtonType="LinkButton" />
                                            <telerik:RadButton ID="RegisterButton" runat="server" Text="Create New User" Width="200px" CssClass="sg-button-submit" NavigateUrl="~/Forms/Account/Register.aspx" ButtonType="LinkButton" />
                                        </div>
                                    </ContentTemplate>
                                </asp:CompleteWizardStep>
                            </WizardSteps>
                        </asp:CreateUserWizard>
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
                            _control.get_styles().EnabledStyle[0] += "border-color: red;";
                            _control.updateCssClass();
                        }
                        else {
                            var _control = $find(Page_Validators[i].controltovalidate);
                            if (Page_Validators[i].controltovalidate.search("UserName") != -1) {
                                _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                _control.updateCssClass();
                            }
                            else if (Page_Validators[i].controltovalidate.search("Email") != -1) {
                                var _email = ValidatorGetValue(Page_Validators[i].controltovalidate);
                                if (_email != "") {
                                    var _emailExpression = new RegExp(Page_Validators[i].validationexpression);
                                    var _matches = _emailExpression.exec(_email);
                                    if (_matches != null && _email == _matches[0]) {
                                        _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                        _control.updateCssClass();
                                    }
                                }
                            }
                            else if (Page_Validators[i].controltovalidate.search("Password") != -1) {
                                if (Page_Validators[i].controltovalidate.search("ConfirmPassword") != -1) {
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
