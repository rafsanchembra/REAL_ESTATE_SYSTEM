<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="BankAccountManagement.aspx.vb" Inherits="RealEstateManagementSystem.BankAccountManagement" %>

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
                    <asp:Label ID="header" runat="server" Text="Account Management" />
                </div>
                <div class="col-10">
                    <telerik:RadListView ID="BankListView" runat="server" Width="100%" PageSize="1" DataKeyNames="ID" DataSourceID="SqlDataSource_Bank">
                        <ItemTemplate>
                            <div class="col-row">
                                <div class="col-5">
                                    <div class="sg-blockcontent-right">
                                        <div class="col-10 sg-label">
                                            <asp:Label ID="BankArabicNameGridLabel" runat="server" AssociatedControlID="BankArabicNameGridTextBox" Text="Bank Arabic Name" />
                                        </div>
                                        <div class="col-10">
                                            <telerik:RadTextBox ID="BankArabicNameGridTextBox" runat="server" MaxLength="30" Width="100%" Enabled="false" ToolTip="Bank Arabic Name" Text='<%# Bind("BankArabicName") %>' />
                                        </div>
                                        <div class="col-10 sg-label">
                                            <asp:Label ID="BankSwiftCodeGridLabel" runat="server" AssociatedControlID="BankSwiftCodeGridTextBox" Text="Swift Code" />
                                        </div>
                                        <div class="col-10">
                                            <telerik:RadTextBox ID="BankSwiftCodeGridTextBox" runat="server" MaxLength="30" Width="100%" Enabled="false" ToolTip="Bank Swift Code" Text='<%# Bind("BankSwiftCode")%>' />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-5">
                                    <div class="sg-blockcontent-left">
                                        <div class="col-10 sg-label">
                                            <asp:Label ID="BankEnglishNameGridLabel" runat="server" AssociatedControlID="BankEnglishNameGridTextBox" Text="Bank English Name" />
                                        </div>
                                        <div class="col-10">
                                            <telerik:RadTextBox ID="BankEnglishNameGridTextBox" runat="server" MaxLength="30" Width="100%" Enabled="false" ToolTip="Bank English Name" Text='<%# Bind("BankEnglishName") %>' />
                                        </div>
                                        <div class="col-10 sg-label">
                                            <asp:Label ID="BankIBANCodeGridLabel" runat="server" AssociatedControlID="BankIBANCodeGridTextBox" Text="IBAN Code" />
                                        </div>
                                        <div class="col-10">
                                            <telerik:RadTextBox ID="BankIBANCodeGridTextBox" runat="server" MaxLength="30" Width="100%" Enabled="false" ToolTip="Bank IBAN Code" Text='<%# Bind("BankIBANCode")%>' />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </telerik:RadListView>
                </div>
                <div class="col-10 sg-header">
                    <asp:Label ID="bankAccountHeaderLabel" runat="server" Text="Bank Account Details" />
                </div>
                <div class="col-10 sg-button-right">
                    <telerik:RadButton ID="CreateBankAccountButton" runat="server" Text="Add New Bank Account" Width="250px" CssClass="sg-button-submit" OnClick="CreateBankAccountButton_Click" UseSubmitBehavior="false" />
                </div>
            </div>
        </div>
        <div class="col-10 sg-radgrid">
            <telerik:RadGrid ID="BankAccountRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0"
                DataSourceID="SqlDataSource_BankAccountList" GridLines="None" OnItemDataBound="BankAccountRadGrid_ItemDataBound"
                OnItemCommand="BankAccountRadGrid_ItemCommand" OnEditCommand="BankAccountRadGrid_EditCommand" OnUpdateCommand="BankAccountRadGrid_UpdateCommand"
                AllowAutomaticUpdates="true">
                <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_BankAccountList" CommandItemDisplay="None" AllowPaging="true" PageSize="40">
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
                        <telerik:GridBoundColumn DataField="BankAccountNumber" FilterControlWidth="100%" FilterControlAltText="Filter BankAccountNumber column" HeaderText="Account Number" SortExpression="BankAccountNumber"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankAccountNumber">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="BankAccountArabicName" FilterControlWidth="100%" FilterControlAltText="Filter BankAccountArabicName column" HeaderText="Account Arabic Name" SortExpression="BankAccountArabicName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankAccountArabicName">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="BankAccountEnglishName" FilterControlWidth="100%" FilterControlAltText="Filter BankAccountEnglishName column" HeaderText="Account English Name" SortExpression="BankAccountEnglishName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankAccountEnglishName">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="BankAccountOpeningBalance" DataFormatString="{0:RO 0.000}" FilterControlWidth="100%" FilterControlAltText="Filter BankAccountOpeningBalance column" HeaderText="Account Opening Balance" SortExpression="BankAccountOpeningBalance"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankAccountOpeningBalance">
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="BankAccountTotalBalance" DataFormatString="{0:RO 0.000}" FilterControlWidth="100%" FilterControlAltText="Filter BankAccountTotalBalance column" HeaderText="Account Total Balance" SortExpression="BankAccountTotalBalance"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankAccountTotalBalance">
                            <HeaderStyle HorizontalAlign="Center" Width="100px" />
                            <ItemStyle HorizontalAlign="Center" Width="100px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="BankAccountStatusName" FilterControlWidth="100%" FilterControlAltText="Filter BankAccountStatusName column" HeaderText="Account Status" SortExpression="BankAccountStatusName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankAccountStatusName">
                            <HeaderStyle HorizontalAlign="Center" Width="40px" />
                            <ItemStyle HorizontalAlign="Center" Width="40px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                            <HeaderStyle HorizontalAlign="Center" Width="40px" />
                            <ItemStyle HorizontalAlign="Center" Width="40px" />
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings EditFormType="Template">
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column" />
                        <FormTemplate>  
                                <div class="sg-blockcontent">
                                    <div class="col-10 sg-header">
                                        <asp:Label ID="createBankAccountHeaderLabel" runat="server" Text="Update Bank Account Details" />
                                    </div>
                                    <div class="col-row">
                                        <div class="col-5">
                                            <div class="sg-blockcontent-right">
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="BankAccountNumberGridLabel" runat="server" AssociatedControlID="BankAccountNumberGridTextBox" Text="Account Number" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="BankAccountNumberGridTextBox" runat="server" MaxLength="30" Width="100%" TabIndex="1" ToolTip="Bank Account Number" Text='<%# Bind("BankAccountNumber")%>' />
                                                    <asp:RequiredFieldValidator ID="BankAccountNumberGridRequired" runat="server" ControlToValidate="BankAccountNumberGridTextBox" ValidationGroup="GridSubmitButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="BankAccountArabicNameGridLabel" runat="server" AssociatedControlID="BankAccountArabicNameGridTextBox" Text="Account Arabic Name" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="BankAccountArabicNameGridTextBox" runat="server" MaxLength="30" Width="100%" TabIndex="2" ToolTip="Bank Account Arabic Name" Text='<%# Bind("BankAccountArabicName")%>' onpaste="onGridTextPaste()">
                                                        <ClientEvents OnKeyPress="GridKeyPressed" />
                                                    </telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator ID="BankAccountArabicNameGridRequired" runat="server" ControlToValidate="BankAccountArabicNameGridTextBox" ValidationGroup="GridSubmitButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="BankAccountEnglishNameGridLabel" runat="server" AssociatedControlID="BankAccountEnglishNameGridTextBox" Text="Account English Name" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="BankAccountEnglishNameGridTextBox" runat="server" MaxLength="30" Width="100%" TabIndex="3" ToolTip="Bank Account English Name" Text='<%# Bind("BankAccountEnglishName")%>' />
                                                    <asp:RequiredFieldValidator ID="BankAccountEnglishNameGridRequired" runat="server" ControlToValidate="BankAccountEnglishNameGridTextBox" ValidationGroup="GridSubmitButton" EnableClientScript="true" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-5">
                                            <div class="sg-blockcontent-left">
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="BankAccountMemoGridLabel" runat="server" AssociatedControlID="BankAccountMemoGridTextBox" Text="Memo" />
                                                </div>
                                                <div class="col-10">
                                                    <telerik:RadTextBox ID="BankAccountMemoGridTextBox" runat="server" TextMode="MultiLine" Height="165px" Width="100%" TabIndex="4" ToolTip="Bank Account Memo" Text='<%# Bind("BankAccountMemo") %>' />
                                                </div>
                                                <div class="col-10 sg-button-right">
                                            <telerik:RadButton ID="CancelButton" Width="100px" Text="Cancel" TabIndex="5" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="sg-button-submit" />
                                            <telerik:RadButton ID="SubmitButton" runat="server" Width="100px" TabIndex="4" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Add", "Update")%>' CssClass="sg-button-submit "
                                                CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' ValidationGroup="GridSubmitButton" OnClientClicked="GridValidateOnSubmit" />
                                        </div>
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


    <telerik:RadWindowManager ID="RadWindowManager_modalPopup" runat="server" EnableViewState="false">
        <Windows>
            <telerik:RadWindow ID="modalPopup_BankAccount" runat="server" Width="1366px" Height="320px" VisibleStatusbar="false"
                Modal="true" VisibleTitlebar="false" Behaviors="None">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script>
            function refreshGrid() {
                var masterTable = $find("<%= BankAccountRadGrid.ClientID %>").get_masterTableView();
                masterTable.rebind();
            }

            function GridValidateOnSubmit() {
                var _accountNumberObject = $telerik.$("[id$='BankAccountNumberGridTextBox']").attr('id');
                var _accountNumber = $find(_accountNumberObject);

                var _accountArabicNameObject = $telerik.$("[id$='BankAccountArabicNameGridTextBox']").attr('id');
                var _accountArabicName = $find(_accountArabicNameObject);

                var _accountEnglshNameObject = $telerik.$("[id$='BankAccountEnglishNameGridTextBox']").attr('id');
                var _accountEnglshName = $find(_accountEnglshNameObject);

                if (_accountNumber.get_value() == "") {
                    _accountNumber.get_styles().EnabledStyle[0] += "border-color: red;";
                    _accountNumber.updateCssClass();
                }
                else if (_accountNumber.get_value() != "") {
                    _accountNumber.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _accountNumber.updateCssClass();
                }
                else if (_accountArabicName.get_value() == "") {
                    _accountArabicName.get_styles().EnabledStyle[0] += "border-color: red;";
                    _accountArabicName.updateCssClass();
                }
                else if (_accountArabicName.get_value() != "") {
                    _accountArabicName.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _accountArabicName.updateCssClass();
                }
                else if (_accountEnglshName.get_value() == "") {
                    _accountEnglshName.get_styles().EnabledStyle[0] += "border-color: red;";
                    _accountEnglshName.updateCssClass();
                }
                else if (_accountEnglshName.get_value() != "") {
                    _accountEnglshName.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _accountEnglshName.updateCssClass();
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
                var _textbox = $telerik.$("[id$='BankAccountArabicNameGridTextBox']").attr('id');
                var _currentTextBox = $find(_textbox);
                currentText = _currentTextBox.get_textBoxValue();
                setTimeout(GridCheckText, 1);
            }

            function GridCheckText() {
                var _textbox = $telerik.$("[id$='BankAccountArabicNameGridTextBox']").attr('id');
                var totalText = $find(_textbox).get_textBoxValue();
                for (var i = 0; i < totalText.length; i++) {
                    if (totalText.charCodeAt(i) > 64 && totalText.charCodeAt(i) < 123) {
                        var _textboxNew = $telerik.$("[id$='BankAccountArabicNameGridTextBox']").attr('id');
                        $find(_textboxNew).set_textBoxValue(currentText);
                        alert("Text contains Non-Arabic letters");
                        break;
                    }
                }
            }
        </script>
    </telerik:RadCodeBlock>

    <asp:SqlDataSource ID="SqlDataSource_Bank" runat="server"
        ConnectionString="<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>"
        SelectCommand="PROC_APP_BanksSELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="ID" Type="Int64"></asp:QueryStringParameter>

        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource_BankAccountList" runat="server"
        ConnectionString="<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>"
        OnUpdating="SqlDataSource_BankAccountList_OnUpdating"
        SelectCommand="PROC_APP_BankAccountsSELECTALL" SelectCommandType="StoredProcedure"
        UpdateCommand="PROC_APP_BankAccountsUPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="BankID" Type="Int64"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:QueryStringParameter Name="BankID" QueryStringField="BankID" Type="Int64" />
            <asp:Parameter Name="ID" Type="Int64" />
            <asp:Parameter Name="BankAccountNumber" Type="String" />
            <asp:Parameter Name="BankAccountArabicName" Type="String" />
            <asp:Parameter Name="BankAccountEnglishName" Type="String" />
            <asp:Parameter Name="BankAccountMemo" Type="String" />
            <asp:Parameter Name="BankAccountUpdatedBy" Type="Object" />
            <asp:Parameter Name="BankAccountUpdatedDate" Type="DateTime"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
