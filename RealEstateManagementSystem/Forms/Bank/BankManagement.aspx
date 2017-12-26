<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="BankManagement.aspx.vb" Inherits="RealEstateManagementSystem.BankManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
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
            <div class="sg-blockcontent">
                <msg:PopMsg ID="PopMsg" runat="server" />
                <div class="col-10 sg-header">
                    <asp:Label ID="header" runat="server" Text="Bank Add/Update" />
                </div>
                <div class="col-row">
                    <div class="col-8 col-push-10">
                        <div class="col-5">
                            <div class="sg-blockcontent">
                                <div class="col-10 sg-label">
                                    <asp:Label ID="BankArabicNameLabel" runat="server" AssociatedControlID="BankArabicNameTextBox" Text="Bank Arabic Name" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadTextBox ID="BankArabicNameTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank Arabic Name" onpaste="onTextPaste()" TabIndex="1">
                                        <ClientEvents OnKeyPress="keyPressed" />
                                    </telerik:RadTextBox>
                                    <asp:RequiredFieldValidator ID="BankArabicNameRequired" runat="server" ControlToValidate="BankArabicNameTextBox" ValidationGroup="ButtonSubmit" EnableClientScript="true" CssClass="field-validation-error" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="BankSwiftCodeLabel" runat="server" AssociatedControlID="BankSwiftCodeTextBox" Text="Swift Code" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="BankSwiftCodeTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank Swift Code" TabIndex="3" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="BankLatitudeCoordinatesLabel" runat="server" AssociatedControlID="BankLatitudeCoordinatesTextBox" Text="Latitude Co-ordinates" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadNumericTextBox ID="BankLatitudeCoordinatesTextBox" MaxLength="15" runat="server" Width="100%" ToolTip="Bank Latitude Co-ordinates" TabIndex="5">
                                        <NumberFormat DecimalDigits="6" AllowRounding="false" />
                                    </telerik:RadNumericTextBox>
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="BankURLMapLabel" runat="server" AssociatedControlID="BankURLMapTextBox" Text="Map URL" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="BankURLMapTextBox" runat="server" MaxLength="60" Width="100%" ToolTip="Bank Map URl" TabIndex="7" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="BankOnlineBankingURLLabel" runat="server" AssociatedControlID="BankOnlineBankingURLTextBox" Text="Online Banking URL" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="BankOnlineBankingURLTextBox" MaxLength="60" runat="server" Width="100%" ToolTip="Bank Online Banking URL" TabIndex="9" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="BankWebsiteLabel" runat="server" AssociatedControlID="BankWebsiteTextBox" Text="Website" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="BankWebsiteTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank Website" TabIndex="10" />
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="sg-blockcontent">
                                <div class="col-10 sg-label">
                                    <asp:Label ID="BankEnglishNameLabel" runat="server" AssociatedControlID="BankEnglishNameTextBox" Text="Bank English Name" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadTextBox ID="BankEnglishNameTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank English Name" TabIndex="2" />
                                    <asp:RequiredFieldValidator ID="BankEnglishNameRequired" runat="server" ControlToValidate="BankEnglishNameTextBox" ValidationGroup="ButtonSubmit" EnableClientScript="true" CssClass="field-validation-error" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="BankIBANCodeLabel" runat="server" AssociatedControlID="BankIBANCodeTextBox" Text="IBAN Code" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="BankIBANCodeTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank IBAN Code" TabIndex="4" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="BankLongitudeCoordinatesLabel" runat="server" AssociatedControlID="BankLongitudeCoordinatesTextBox" Text="Longitude Co-ordinates" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadNumericTextBox ID="BankLongitudeCoordinatesTextBox" MaxLength="15" runat="server" Width="100%" ToolTip="Bank Longitude Co-ordinates" TabIndex="6">
                                        <NumberFormat DecimalDigits="6" AllowRounding="false" />
                                    </telerik:RadNumericTextBox>
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="BankDescriptionLabel" runat="server" AssociatedControlID="BankDescriptionTextBox" Text="Description" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="BankDescriptionTextBox" runat="server" TextMode="MultiLine" Height="205px" Width="100%" ToolTip="Bank Description" TabIndex="8" />
                                </div>
                            </div>
                        </div>
                        <div class="col-10 sg-button-right">
                            <telerik:RadButton ID="SubmitButton" runat="server" Text="Submit" Width="100px" CssClass="sg-button-submit" ValidationGroup="ButtonSubmit" TabIndex="11" OnClick="SubmitButton_Click" OnClientClicked="ValidateOnSubmit" />
                        </div>
                    </div>

                </div>
            </div>
            <div class="col-10 sg-radgrid">
                <telerik:RadGrid ID="BankRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0"
                    DataSourceID="SqlDataSource_BankList" GridLines="None" OnItemDataBound="BankRadGrid_ItemDataBound"
                    OnItemCommand="BankRadGrid_ItemCommand" OnEditCommand="BankRadGrid_EditCommand" OnUpdateCommand="BankRadGrid_UpdateCommand" AllowAutomaticUpdates="true">
                    <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_BankList" CommandItemDisplay="None" AllowPaging="true" PageSize="40">
                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                            <HeaderStyle Width="20px" />
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                            <HeaderStyle Width="20px" />
                        </ExpandCollapseColumn>
                        <Columns>
                            <telerik:GridTemplateColumn HeaderText="No." AllowFiltering="false">
                                <ItemTemplate>
                                    <asp:Label ID="IDLabel" runat="server" Text="" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn Display="false" DataField="ID" DataType="System.Int64" ReadOnly="true" UniqueName="ID" />
                            <telerik:GridBoundColumn DataField="BankArabicName" FilterControlWidth="100%" FilterControlAltText="Filter BankArabicName column" HeaderText="Arabic Name" SortExpression="BankArabicName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankArabicName">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BankEnglishName" FilterControlWidth="100%" FilterControlAltText="Filter BankEnglishName column" HeaderText="English Name" SortExpression="BankEnglishName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankEnglishName">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BankSwiftCode" FilterControlWidth="100%" FilterControlAltText="Filter BankSwiftCode column" HeaderText="Swift Code" SortExpression="BankSwiftCode"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankSwiftCode">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BankIBANCode" FilterControlWidth="100%" FilterControlAltText="Filter BankIBANCode column" HeaderText="IBAN Code" SortExpression="BankIBANCode"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankIBANCode">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BankWebsite" FilterControlWidth="100%" FilterControlAltText="Filter BankWebsite column" HeaderText="Bank Website" SortExpression="BankWebsite"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankWebsite">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="ID" AllowFiltering="false" DataNavigateUrlFormatString="~/Forms/Bank/BankAccountManagement.aspx?ID={0}" Text=">>>" HeaderText="Accounts">
                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                            </telerik:GridHyperLinkColumn>
                            <telerik:GridButtonColumn CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings EditFormType="Template">
                            <EditColumn FilterControlAltText="Filter EditCommandColumn column" />
                            <FormTemplate>
                                <div class="col-10 sg-header">
                                    <asp:Label ID="HeaderLabel" runat="server" Text="Update Bank Details" />
                                </div>
                                <div class="sg-blockcontent">
                                    <div class="col-row">
                                        <div class="col-8 col-push-10">
                                            <div class="col-5">
                                                <div class="sg-blockcontent-right">
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankArabicNameGridLabel" runat="server" AssociatedControlID="BankArabicNameGridTextBox" Text="Bank Arabic Name" />
                                                    </div>
                                                    <div class="col-10 sg-textbox-required-field">
                                                        <telerik:RadTextBox ID="BankArabicNameGridTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank Arabic Name" Text='<%# Bind("BankArabicName") %>' onpaste="onGridTextPaste()" TabIndex="12">
                                                            <ClientEvents OnKeyPress="GridKeyPressed" />
                                                        </telerik:RadTextBox>
                                                        <asp:RequiredFieldValidator ID="BankArabicNameGridRequired" runat="server" ControlToValidate="BankArabicNameGridTextBox" ValidationGroup="GridSubmitButton" EnableClientScript="true" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankSwiftCodeGridLabel" runat="server" AssociatedControlID="BankSwiftCodeGridTextBox" Text="Swift Code" />
                                                    </div>
                                                    <div class="col-10">
                                                        <telerik:RadTextBox ID="BankSwiftCodeGridTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank Swift Code" Text='<%# Bind("BankSwiftCode")%>' TabIndex="14" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankLatitudeCoordinatesGridLabel" runat="server" AssociatedControlID="BankLatitudeCoordinatesGridTextBox" Text="Latitude Co-ordinates" />
                                                    </div>
                                                    <div class="col-10 ">
                                                        <telerik:RadNumericTextBox ID="BankLatitudeCoordinatesGridTextBox" MaxLength="15" runat="server" Width="100%" ToolTip="Bank Latitude Co-ordinates" Text='<%# Bind("BankLatitudeCoordinates")%>' TabIndex="16">
                                                            <NumberFormat DecimalDigits="6" AllowRounding="false" />
                                                        </telerik:RadNumericTextBox>
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankURLMapGridLabel" runat="server" AssociatedControlID="BankURLMapGridTextBox" Text="Map URL" />
                                                    </div>
                                                    <div class="col-10">
                                                        <telerik:RadTextBox ID="BankURLMapGridTextBox" runat="server" Width="100%" MaxLength="60" ToolTip="Bank Map URl" Text='<%# Bind("BankURLMap")%>' TabIndex="18" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankOnlineBankingURLGridLabel" runat="server" AssociatedControlID="BankOnlineBankingURLGridTextBox" Text="Online Banking URL" />
                                                    </div>
                                                    <div class="col-10">
                                                        <telerik:RadTextBox ID="BankOnlineBankingURLGridTextBox" runat="server" Width="100%" MaxLength="30" ToolTip="Bank Online Banking URL" Text='<%# Bind("BankOnlineBankingURL")%>' TabIndex="20" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankWebsiteGridLabel" runat="server" AssociatedControlID="BankWebsiteGridTextBox" Text="Website" />
                                                    </div>
                                                    <div class="col-10 ">
                                                        <telerik:RadTextBox ID="BankWebsiteGridTextBox" runat="server" Width="100%" MaxLength="30" ToolTip="Bank Website" Text='<%# Bind("BankWebsite")%>' TabIndex="21" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-5">
                                                <div class="sg-blockcontent-left">
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankEnglishNameGridLabel" runat="server" AssociatedControlID="BankEnglishNameGridTextBox" Text="Bank English Name" />
                                                    </div>
                                                    <div class="col-10 sg-textbox-required-field">
                                                        <telerik:RadTextBox ID="BankEnglishNameGridTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank English Name" Text='<%# Bind("BankEnglishName") %>' TabIndex="13" />
                                                        <asp:RequiredFieldValidator ID="BankEnglishNameGridRequired" runat="server" ControlToValidate="BankEnglishNameGridTextBox" ValidationGroup="GridSubmitButton" EnableClientScript="true" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankIBANCodeGridLabel" runat="server" AssociatedControlID="BankIBANCodeGridTextBox" Text="IBAN Code" />
                                                    </div>
                                                    <div class="col-10">
                                                        <telerik:RadTextBox ID="BankIBANCodeGridTextBox" runat="server" MaxLength="30" Width="100%" ToolTip="Bank IBAN Code" Text='<%# Bind("BankIBANCode")%>' TabIndex="15" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankLongitudeCoordinatesGridLabel" runat="server" AssociatedControlID="BankLongitudeCoordinatesGridTextBox" Text="Longitude Co-ordinates" />
                                                    </div>
                                                    <div class="col-10">
                                                        <telerik:RadNumericTextBox ID="BankLongitudeCoordinatesGridTextBox" runat="server" MaxLength="15" Width="100%" ToolTip="Bank Longitude Co-ordinates" Text='<%# Bind("BankLongitudeCoordinates") %>' TabIndex="17">
                                                            <NumberFormat DecimalDigits="6" AllowRounding="false" />
                                                        </telerik:RadNumericTextBox>
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankDescriptionGridLabel" runat="server" AssociatedControlID="BankDescriptionGridTextBox" Text="Description" />
                                                    </div>
                                                    <div class="col-10">
                                                        <telerik:RadTextBox ID="BankDescriptionGridTextBox" runat="server" TextMode="MultiLine" Height="198px" Width="100%" ToolTip="Bank Description" Text='<%# Bind("BankDescription") %>' TabIndex="19" />
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="col-10 sg-button-right">
                                            <telerik:RadButton ID="CancelButton" Width="100px" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="sg-button-submit" TabIndex="23" />
                                            <telerik:RadButton ID="SubmitButton" runat="server" Width="100px" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Add", "Update")%>' CssClass="sg-button-submit" TabIndex="22"
                                                CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' ValidationGroup="GridSubmitButton" OnClientClicked="GridValidateOnSubmit" />
                                        </div>
                                        </div>
                                       
                                    </div>

                                </div>
                            </FormTemplate>
                        </EditFormSettings>
                        <PagerStyle AlwaysVisible="True" Mode="NextPrevNumericAndAdvanced" />
                    </MasterTableView>
                    <FilterItemStyle HorizontalAlign="Center" />
                    <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Bottom" AlwaysVisible="true" />
                    <FilterMenu EnableImageSprites="False" EnableSelection="True" />
                </telerik:RadGrid>
            </div>
        </div>
    </div>

    <telerik:RadCodeBlock ID="radCodeBlock" runat="server">
        <script>
            function keyPressed(sender, args) {
                if (args.get_keyCode() > 64 && args.get_keyCode() < 123) {
                    args.set_cancel(true);
                    alert("Only Arabic letters allowed");
                }
            }

            var currentText;

            function onTextPaste() {
                currentText = $find("<%= BankArabicNameTextBox.ClientID%>").get_textBoxValue();
                setTimeout(checkText, 1);
            }

            function checkText() {
                var totalText = $find("<%= BankArabicNameTextBox.ClientID%>").get_textBoxValue();
                for (var i = 0; i < totalText.length; i++) {
                    if (totalText.charCodeAt(i) > 64 && totalText.charCodeAt(i) < 123) {
                        $find("<%= BankArabicNameTextBox.ClientID%>").set_textBoxValue(currentText);
                        alert("Text contains Non-Arabic letters");
                        break;
                    }
                }
            }

            function GridKeyPressed(sender, args) {
                if (args.get_keyCode() > 64 && args.get_keyCode() < 123) {
                    args.set_cancel(true);
                    alert("Only Arabic letters allowed");
                }
            }

            var currentText;

            function onGridTextPaste() {
                var _textbox = $telerik.$("[id$='BankArabicNameGridTextBox']").attr('id');
                var _currentTextBox = $find(_textbox);
                currentText = _currentTextBox.get_textBoxValue();
                setTimeout(GridCheckText, 1);
            }

            function GridCheckText() {
                var _textbox = $telerik.$("[id$='BankArabicNameGridTextBox']").attr('id');
                var totalText = $find(_textbox).get_textBoxValue();
                for (var i = 0; i < totalText.length; i++) {
                    if (totalText.charCodeAt(i) > 64 && totalText.charCodeAt(i) < 123) {
                        var _textboxNew = $telerik.$("[id$='BankArabicNameGridTextBox']").attr('id');
                        $find(_textboxNew).set_textBoxValue(currentText);
                        alert("Text contains Non-Arabic letters");
                        break;
                    }
                }
            }

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
                            if (Page_Validators[i].controltovalidate.search("BankArabicNameTextBox") != -1) {
                                _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                _control.updateCssClass();
                            }
                            else if (Page_Validators[i].controltovalidate.search("BankEnglishNameTextBox") != -1) {
                                _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                _control.updateCssClass();
                            }
                            else if (Page_Validators[i].controltovalidate.search("BankArabicNameGridTextBox") != -1) {
                                _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                _control.updateCssClass();
                            }
                            else if (Page_Validators[i].controltovalidate.search("BankEnglishNameGridTextBox") != -1) {
                                _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                                _control.updateCssClass();
                            }
                        }
                    }
                }
                return val;
            }

            function GridValidateOnSubmit() {
                var _arabicNameObject = $telerik.$("[id$='BankArabicNameGridTextBox']").attr('id');
                var _arabicName = $find(_arabicNameObject);

                var _englishNameObject = $telerik.$("[id$='BankEnglishNameGridTextBox']").attr('id');
                var _englishName = $find(_englishNameObject);

                if (_arabicName.get_value() == "") {
                    _arabicName.get_styles().EnabledStyle[0] += "border-color: red;";
                    _arabicName.updateCssClass();
                }
                else if (_arabicName.get_value() != "") {
                    _arabicName.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _arabicName.updateCssClass();
                }
                else if (_englishName.get_value() == "") {
                    _englishName.get_styles().EnabledStyle[0] += "border-color: red;";
                    _englishName.updateCssClass();
                }
                else if (_englishName.get_value() != "") {
                    _englishName.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _englishName.updateCssClass();
                }
            }
        </script>
    </telerik:RadCodeBlock>


    <asp:SqlDataSource ID="SqlDataSource_BankList" runat="server"
        ConnectionString="<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>"
        OnUpdating="SqlDataSource_BankList_OnUpdating"
        SelectCommand="PROC_APP_BanksSELECTALL" SelectCommandType="StoredProcedure"
        UpdateCommand="PROC_APP_BanksUPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int64" />
            <asp:Parameter Name="BankArabicName" Type="String" />
            <asp:Parameter Name="BankEnglishName" Type="String" />
            <asp:Parameter Name="BankSwiftCode" Type="String" />
            <asp:Parameter Name="BankIBANCode" Type="String" />
            <asp:Parameter Name="BankLatitudeCoordinates" Type="String" />
            <asp:Parameter Name="BankLongitudeCoordinates" Type="String" />
            <asp:Parameter Name="BankURLMap" Type="String" />
            <asp:Parameter Name="BankWebsite" Type="String" />
            <asp:Parameter Name="BankOnlineBankingURL" Type="String" />
            <asp:Parameter Name="BankDescription" Type="String" />
            <asp:Parameter Name="BankUpdatedDate" Type="DateTime"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
