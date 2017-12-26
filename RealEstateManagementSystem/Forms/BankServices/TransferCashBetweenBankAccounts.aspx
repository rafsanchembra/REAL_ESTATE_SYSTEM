<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="TransferCashBetweenBankAccounts.aspx.vb" Inherits="RealEstateManagementSystem.TransferCashBetweenBankAccounts" %>

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
                    <asp:Label ID="header" runat="server" Text="Transcation between Bank Accounts" />
                </div>
                <div class="col-8 col-push-10">
                    <div class="col-10 sg-item-details ">
                        <div class="col-5">
                            <div class="sg-blockcontent-right">
                                <div class="col-10 sg-header">
                                    <asp:Label ID="subHeaderLabel" runat="server" Text="Sender Bank" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TransactionSenderBankLabel" runat="server" AssociatedControlID="TransactionSenderBankComboBox" Text="Bank" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="TransactionSenderBankComboBox" runat="server" TabIndex="1" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                        ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankList" DataTextField="BankEnglishName" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="TransactionSenderBankComboBox_SelectedIndexChanged">
                                        <HeaderTemplate>
                                            <ul>
                                                <li class="colName">Bank Arabic Name</li>
                                                <li class="colName">Bank English Name</li>
                                            </ul>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <ul>
                                                <li class="colName">
                                                    <%# DataBinder.Eval(Container.DataItem, "BankArabicName")%></li>
                                                <li class="colName">
                                                    <%# DataBinder.Eval(Container.DataItem, "BankEnglishName")%></li>
                                            </ul>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="TransactionSenderBankRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionSenderBankComboBox" ValidationGroup="Submit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TransactionSenderBankAccountLabel" runat="server" AssociatedControlID="TransactionSenderBankAccountComboBox" Text="Bank Account" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="TransactionSenderBankAccountComboBox" runat="server" TabIndex="3" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                        ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankSenderAccountList" DataTextField="BankAccountEnglishName" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="TransactionSenderBankAccountComboBox_SelectedIndexChanged">
                                        <HeaderTemplate>
                                            <ul>
                                                <li class="colName">Bank Account Arabic Name</li>
                                                <li class="colName">Bank Account English Name</li>
                                            </ul>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <ul>
                                                <li class="colName">
                                                    <%# DataBinder.Eval(Container.DataItem, "BankAccountArabicName")%></li>
                                                <li class="colName">
                                                    <%# DataBinder.Eval(Container.DataItem, "BankAccountEnglishName")%></li>
                                            </ul>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="TransactionSenderBankAccountRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionSenderBankAccountComboBox" ValidationGroup="Submit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="SenderBankAccountTotalLabel" runat="server" AssociatedControlID="SenderBankAccountTotalTextBox" Text="Account Total Amount" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadNumericTextBox ID="SenderBankAccountTotalTextBox" runat="server" ReadOnly="true" TabIndex="5" Type="Currency" Width="100%" ToolTip="Bank Account Total Amount">
                                        <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                    </telerik:RadNumericTextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="sg-blockcontent-left">
                                <div class="col-10 sg-header">
                                    <asp:Label ID="Label1" runat="server" Text="Recieve Bank" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TransactionRecieveBankLabel" runat="server" AssociatedControlID="TransactionRecieveBankComboBox" Text="Bank" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="TransactionRecieveBankComboBox" runat="server" TabIndex="2" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                        ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankList" DataTextField="BankEnglishName" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="TransactionRecieveBankComboBox_SelectedIndexChanged">
                                        <HeaderTemplate>
                                            <ul>
                                                <li class="colName">Bank Arabic Name</li>
                                                <li class="colName">Bank English Name</li>
                                            </ul>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <ul>
                                                <li class="colName">
                                                    <%# DataBinder.Eval(Container.DataItem, "BankArabicName")%></li>
                                                <li class="colName">
                                                    <%# DataBinder.Eval(Container.DataItem, "BankEnglishName")%></li>
                                            </ul>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="TransactionRecieveBankRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionRecieveBankComboBox" ValidationGroup="Submit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TransactionRecieveBankAccountLabel" runat="server" AssociatedControlID="TransactionRecieveBankAccountComboBox" Text="Bank Account" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="TransactionRecieveBankAccountComboBox" runat="server" TabIndex="4" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                        ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankRecieveAccountList" DataTextField="BankAccountEnglishName" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="TransactionRecieveBankAccountComboBox_SelectedIndexChanged">
                                        <HeaderTemplate>
                                            <ul>
                                                <li class="colName">Bank Account Arabic Name</li>
                                                <li class="colName">Bank Account English Name</li>
                                            </ul>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <ul>
                                                <li class="colName">
                                                    <%# DataBinder.Eval(Container.DataItem, "BankAccountArabicName")%></li>
                                                <li class="colName">
                                                    <%# DataBinder.Eval(Container.DataItem, "BankAccountEnglishName")%></li>
                                            </ul>
                                        </ItemTemplate>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="TransactionRecieveBankAccountRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionRecieveBankAccountComboBox" ValidationGroup="Submit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="RecieveBankAccountTotalLabel" runat="server" AssociatedControlID="RecieveBankAccountTotalTextBox" Text="Account Total Amount" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadNumericTextBox ID="RecieveBankAccountTotalTextBox" runat="server" TabIndex="6" ReadOnly="true" Type="Currency" Width="100%" ToolTip="Bank Account Total Amount">
                                        <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                    </telerik:RadNumericTextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-row">
                        <div class="col-5">
                            <div class="sg-blockcontent">
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TransactionDocumentTypeLabel" runat="server" AssociatedControlID="TransactionDocumentTypeComboBox" Text="Document Type" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="TransactionDocumentTypeComboBox" runat="server" TabIndex="7" CausesValidation="False" Width="100%" MarkFirstMatch="True"
                                        EmptyMessage="--- Select ---" Filter="Contains" ItemRequestTimeout="0">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="Check" Value="Check" />
                                            <telerik:RadComboBoxItem runat="server" Text="Transfer" Value="Transfer" />
                                        </Items>
                                    </telerik:RadComboBox>
                                    <asp:RequiredFieldValidator ID="TransactionDocumentTypeRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionDocumentTypeComboBox" ValidationGroup="Submit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TransactionAmountLabel" runat="server" AssociatedControlID="TransactionAmountTextBox" Text="Document Amount" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadNumericTextBox ID="TransactionAmountTextBox" TabIndex="9" runat="server" MinValue="0" Type="Currency" Width="100%" ToolTip="Transaction Document Amount">
                                        <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                    </telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="TransactionAmountRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionAmountTextBox" ValidationGroup="Submit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TreasurerSignatureLabel" runat="server" AssociatedControlID="TreasurerSignatureTextBox" Text="Treasurer Signature" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadTextBox ID="TreasurerSignatureTextBox" runat="server" MaxLength="30" TabIndex="11" TextMode="Password" Width="100%" ToolTip="User Signature" AutoCompleteType="Disabled" />
                                    <asp:RequiredFieldValidator ID="TreasurerSignatureRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TreasurerSignatureTextBox" ValidationGroup="Submit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TransactionAttachmentLabel" runat="server" AssociatedControlID="TransactionAttachmentUpload" Text="Transaction Attachment" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadAsyncUpload ID="TransactionAttachmentUpload" runat="server" TabIndex="12" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="SubmitButton" />
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="sg-blockcontent">
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TransactionDocumentNumberLabel" runat="server" AssociatedControlID="TransactionDocumentNumberTextBox" Text="Document Number" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadTextBox ID="TransactionDocumentNumberTextBox" runat="server" TabIndex="8" Width="100%" ToolTip="Transaction Document Number" />
                                    <asp:RequiredFieldValidator ID="TransactionDocumentNumberRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionDocumentNumberTextBox" ValidationGroup="Submit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TransactionDocumentDateLabel" runat="server" AssociatedControlID="TransactionDocumentDateDatePicker" Text="Document Date" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadDatePicker ID="TransactionDocumentDateDatePicker" runat="server" TabIndex="10" Width="100%" MinDate="01/01/1950" ToolTip="Transaction Document Date">
                                        <DateInput ID="TransactionDocumentDateDateInput" runat="server" Font-Size="Medium" InvalidStyleDuration="100" SelectionOnFocus="SelectAll" DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" />
                                        <Calendar ID="Calendar1" runat="server" ShowRowHeaders="false" />
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="TransactionDocumentDateRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionDocumentDateDatePicker" ValidationGroup="Submit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="TransactionMemoLabel" runat="server" AssociatedControlID="TransactionMemoTextBox" Text="Memo" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="TransactionMemoTextBox" runat="server" TabIndex="13" TextMode="MultiLine" Height="118px" Width="100%" ToolTip="Transaction Memo" />
                                </div>
                            </div>
                        </div>
                        <div class="col-10 sg-button-right">
                            <telerik:RadButton ID="SubmitButton" runat="server" Text="Submit" CssClass="sg-button-submit" TabIndex="14" Width="150px" ValidationGroup="Submit" OnClientClicked="ValidateOnSubmit" OnClick="SubmitButton_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-10 sg-radgrid">
                <telerik:RadGrid ID="TransactionBetweenBankAccountsRadGrid" runat="server" AllowAutomaticUpdates="True" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                    CellSpacing="0" DataSourceID="SqlDataSource_TransactionBetweenBankAccounts" GridLines="None" OnItemDataBound="TransactionBetweenBankAccountsRadGrid_ItemDataBound"
                    OnItemCommand="TransactionBetweenBankAccountsRadGrid_ItemCommand" OnEditCommand="TransactionBetweenBankAccountsRadGrid_EditCommand"
                    OnUpdateCommand="TransactionBetweenBankAccountsRadGrid_UpdateCommand">
                    <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_TransactionBetweenBankAccounts" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                            <telerik:GridBoundColumn Display="false" DataField="ID" DataType="System.Int64" UniqueName="ID" />
                            <telerik:GridBoundColumn Display="false" DataField="TransactionSenderBankID" UniqueName="TransactionSenderBankID" />
                            <telerik:GridBoundColumn Display="false" DataField="TransactionSenderBankAccountID" UniqueName="TransactionSenderBankAccountID" />
                            <telerik:GridBoundColumn Display="false" DataField="TransactionReceiveBankID" UniqueName="TransactionReceiveBankID" />
                            <telerik:GridBoundColumn Display="false" DataField="TransactionReceiveBankAccountID" UniqueName="TransactionReceiveBankAccountID" />
                            <telerik:GridBoundColumn Display="false" DataField="TransactionAmount" DataType="System.Int64" UniqueName="TransactionAmountValue" />
                            <telerik:GridBoundColumn DataField="SenderBank" FilterControlWidth="100%" FilterControlAltText="Filter SenderBank column" HeaderText="Sender Bank" SortExpression="SenderBank"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="SenderBank">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SenderAccount" FilterControlWidth="100%" FilterControlAltText="Filter SenderAccount column" HeaderText="Sender Bank Account" SortExpression="SenderAccount"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="SenderAccount">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RecieveBank" FilterControlWidth="100%" FilterControlAltText="Filter RecieveBank column" HeaderText="Recieve Bank" SortExpression="RecieveBank"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="RecieveBank">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RecieveAccount" FilterControlWidth="100%" FilterControlAltText="Filter RecieveAccount column" HeaderText="Recieve Bank Account" SortExpression="RecieveAccount"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="RecieveAccount">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TransactionDocumentType" FilterControlWidth="100%" FilterControlAltText="Filter TransactionDocumentType column" HeaderText="Document Type" SortExpression="TransactionDocumentType"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="TransactionDocumentType">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TransactionDocumentNumber" FilterControlWidth="100%" FilterControlAltText="Filter TransactionDocumentNumber column" HeaderText="Document Number" SortExpression="TransactionDocumentNumber"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="TransactionDocumentNumber">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TransactionAmount" DataFormatString="{0:RO 0.000}" FilterControlWidth="100%" FilterControlAltText="Filter TransactionAmount column" HeaderText="Document Amount" SortExpression="TransactionAmount"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="TransactionAmount">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TransactionStatusName" FilterControlWidth="100%" FilterControlAltText="Filter TransactionStatusName column" HeaderText="Status" SortExpression="TransactionStatusName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="TransactionStatusName">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TransactionDocumentDate" DataFormatString="{0:dd/MM/yyyy}" FilterControlWidth="100%" FilterControlAltText="Filter TransactionDocumentDate column" HeaderText="Document Date" SortExpression="TransactionDocumentDate"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="TransactionDocumentDate">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Center" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                            </telerik:GridButtonColumn>
                        </Columns>
                        <EditFormSettings EditFormType="Template">
                            <EditColumn FilterControlAltText="Filter EditCommandColumn column" />
                            <FormTemplate>
                                <div class="sg-blockcontent">
                                    <div class="col-10 sg-header">
                                        <asp:Label ID="TranscationHeader" runat="server" Text="Update Transcation Details" />
                                    </div>
                                    <div class="col-row sg-item-details">
                                        <div class="col-5">
                                            <div class="sg-blockcontent-right">
                                                <div class="col-10 sg-header">
                                                    <asp:Label ID="subHeaderGridLabel" runat="server" Text="Sender Bank" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionSenderBankGridLabel" runat="server" AssociatedControlID="TransactionSenderBankGridComboBox" Text="Bank" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadComboBox ID="TransactionSenderBankGridComboBox" runat="server" TabIndex="15" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                                        ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankList" DataTextField="BankEnglishName" DataValueField="ID" AutoPostBack="true"
                                                        OnSelectedIndexChanged="TransactionSenderBankGridComboBox_SelectedIndexChanged" SelectedValue='<%# Bind("TransactionSenderBankID") %>'>
                                                        <HeaderTemplate>
                                                            <ul>
                                                                <li class="colName">Bank Arabic Name</li>
                                                                <li class="colName">Bank English Name</li>
                                                            </ul>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <ul>
                                                                <li class="colName">
                                                                    <%# DataBinder.Eval(Container.DataItem, "BankArabicName")%></li>
                                                                <li class="colName">
                                                                    <%# DataBinder.Eval(Container.DataItem, "BankEnglishName")%></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="TransactionSenderBankGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionSenderBankGridComboBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionSenderBankAccountGridLabel" runat="server" AssociatedControlID="TransactionSenderBankAccountGridComboBox" Text="Bank Account" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadComboBox ID="TransactionSenderBankAccountGridComboBox" runat="server" TabIndex="17" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                                        ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankSenderAccountList" DataTextField="BankAccountEnglishName" DataValueField="ID" AutoPostBack="true"
                                                        OnSelectedIndexChanged="TransactionSenderBankAccountGridComboBox_SelectedIndexChanged">
                                                        <HeaderTemplate>
                                                            <ul>
                                                                <li class="colName">Bank Account Arabic Name</li>
                                                                <li class="colName">Bank Account English Name</li>
                                                            </ul>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <ul>
                                                                <li class="colName">
                                                                    <%# DataBinder.Eval(Container.DataItem, "BankAccountArabicName")%></li>
                                                                <li class="colName">
                                                                    <%# DataBinder.Eval(Container.DataItem, "BankAccountEnglishName")%></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="TransactionSenderBankAccountGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionSenderBankAccountGridComboBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="SenderBankAccountTotalGridLabel" runat="server" AssociatedControlID="SenderBankAccountTotalGridTextBox" Text="Account Total Amount" />
                                                </div>
                                                <div class="col-10">
                                                    <telerik:RadNumericTextBox ID="SenderBankAccountTotalGridTextBox" TabIndex="19" runat="server" ReadOnly="true" Type="Currency" Width="100%" ToolTip="Bank Account Total Amount">
                                                        <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                                    </telerik:RadNumericTextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-5">
                                            <div class="sg-blockcontent-left">
                                                <div class="col-10 sg-header">
                                                    <asp:Label ID="Label1" runat="server" Text="Recieve Bank" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionRecieveBankGridLabel" runat="server" AssociatedControlID="TransactionRecieveBankGridComboBox" Text="Bank" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadComboBox ID="TransactionRecieveBankGridComboBox" runat="server" TabIndex="16" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                                        ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankList" DataTextField="BankEnglishName" DataValueField="ID" AutoPostBack="true"
                                                        OnSelectedIndexChanged="TransactionRecieveBankGridComboBox_SelectedIndexChanged">
                                                        <HeaderTemplate>
                                                            <ul>
                                                                <li class="colName">Bank Arabic Name</li>
                                                                <li class="colName">Bank English Name</li>
                                                            </ul>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <ul>
                                                                <li class="colName">
                                                                    <%# DataBinder.Eval(Container.DataItem, "BankArabicName")%></li>
                                                                <li class="colName">
                                                                    <%# DataBinder.Eval(Container.DataItem, "BankEnglishName")%></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="TransactionRecieveBankGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionRecieveBankGridComboBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionRecieveBankAccountGridLabel" runat="server" AssociatedControlID="TransactionRecieveBankAccountGridComboBox" Text="Bank Account" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadComboBox ID="TransactionRecieveBankAccountGridComboBox" runat="server" CausesValidation="False" TabIndex="18" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                                        ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankRecieveAccountList" DataTextField="BankAccountEnglishName" DataValueField="ID" AutoPostBack="true"
                                                        OnSelectedIndexChanged="TransactionRecieveBankAccountGridComboBox_SelectedIndexChanged">
                                                        <HeaderTemplate>
                                                            <ul>
                                                                <li class="colName">Bank Account Arabic Name</li>
                                                                <li class="colName">Bank Account English Name</li>
                                                            </ul>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <ul>
                                                                <li class="colName">
                                                                    <%# DataBinder.Eval(Container.DataItem, "BankAccountArabicName")%></li>
                                                                <li class="colName">
                                                                    <%# DataBinder.Eval(Container.DataItem, "BankAccountEnglishName")%></li>
                                                            </ul>
                                                        </ItemTemplate>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="TransactionRecieveBankAccountGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionRecieveBankAccountGridComboBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="RecieveBankAccountTotalGridLabel" runat="server" AssociatedControlID="RecieveBankAccountTotalGridTextBox" Text="Account Total Amount" />
                                                </div>
                                                <div class="col-10">
                                                    <telerik:RadNumericTextBox ID="RecieveBankAccountTotalGridTextBox" runat="server" TabIndex="20" ReadOnly="true" Type="Currency" Width="100%" ToolTip="Bank Account Total Amount">
                                                        <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                                    </telerik:RadNumericTextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-row">
                                        <div class="col-5">
                                            <div class="sg-blockcontent-right">
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionDocumentTypeGridLabel" runat="server" AssociatedControlID="TransactionDocumentTypeGridComboBox" Text="Document Type" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadComboBox ID="TransactionDocumentTypeGridComboBox" runat="server" TabIndex="21" CausesValidation="False" Width="100%" MarkFirstMatch="True"
                                                        EmptyMessage="--- Select ---" Filter="Contains" ItemRequestTimeout="0" SelectedValue='<%# Bind("TransactionDocumentType") %>'>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text="Check" Value="Check" />
                                                            <telerik:RadComboBoxItem runat="server" Text="Transfer" Value="Transfer" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="TransactionDocumentTypeGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionDocumentTypeGridComboBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionAmountGridLabel" runat="server" AssociatedControlID="TransactionAmountGridTextBox" Text="Document Amount" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadNumericTextBox ID="TransactionAmountGridTextBox" runat="server" TabIndex="23" MinValue="0" Type="Currency" Width="100%" ToolTip="Transaction Document Amount" Text='<%# Bind("TransactionAmount") %>'>
                                                        <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                                    </telerik:RadNumericTextBox>
                                                    <asp:RequiredFieldValidator ID="TransactionAmountGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionAmountGridTextBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionStatusGridLabel" runat="server" AssociatedControlID="TransactionStatusGridComboBox" Text="Status" />
                                                </div>
                                                <div class="col-10">
                                                    <telerik:RadComboBox ID="TransactionStatusGridComboBox" runat="server" TabIndex="25" CausesValidation="False" Width="100%" MarkFirstMatch="True"
                                                        EmptyMessage="--- Select ---" Filter="Contains" ItemRequestTimeout="0" SelectedValue='<%# Bind("TransactionStatus") %>'>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text="Active" Value="True" />
                                                            <telerik:RadComboBoxItem runat="server" Text="Freezed" Value="False" />
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionMemoGridLabel" runat="server" AssociatedControlID="TransactionMemoGridTextBox" Text="Memo" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="TransactionMemoGridTextBox" runat="server" TextMode="MultiLine" TabIndex="27" Height="90px" Width="100%" ToolTip="Transaction Memo" Text='<%# Bind("TransactionMemo") %>' />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-5">
                                            <div class="sg-blockcontent-left">
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionDocumentNumberGridLabel" runat="server" AssociatedControlID="TransactionDocumentNumberGridTextBox" Text="Document Number" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="TransactionDocumentNumberGridTextBox" runat="server" Width="100%" TabIndex="22" ToolTip="Transaction Document Number" Text='<%# Bind("TransactionDocumentNumber") %>' />
                                                    <asp:RequiredFieldValidator ID="TransactionDocumentNumberGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionDocumentNumberGridTextBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionDocumentDateGridLabel" runat="server" AssociatedControlID="TransactionDocumentDateGridDatePicker" Text="Document Date" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadDatePicker ID="TransactionDocumentDateGridDatePicker" runat="server" TabIndex="24" Width="100%" MinDate="01/01/1950" ToolTip="Transaction Document Date" SelectedDate='<%# Bind("TransactionDocumentDate") %>'>
                                                        <DateInput ID="TransactionDocumentDateGridDateInput" runat="server" Font-Size="Medium" InvalidStyleDuration="100" SelectionOnFocus="SelectAll" DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" />
                                                        <Calendar ID="Calendar1" runat="server" ShowRowHeaders="false" />
                                                    </telerik:RadDatePicker>
                                                    <asp:RequiredFieldValidator ID="TransactionDocumentDateGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionDocumentDateGridDatePicker" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TreasurerSignatureGridLabel" runat="server" AssociatedControlID="TreasurerSignatureGridTextBox" Text="Treasurer Signature" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="TreasurerSignatureGridTextBox" runat="server" MaxLength="30" TabIndex="26" TextMode="Password" Width="100%" ToolTip="User Signature" AutoCompleteType="Disabled" />
                                                    <asp:RequiredFieldValidator ID="TreasurerSignatureGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TreasurerSignatureGridTextBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="TransactionAttachmentGridLabel" runat="server" AssociatedControlID="TransactionAttachmentGridUpload" Text="Transaction Attachment" />
                                                </div>
                                                <div class="col-10">
                                                    <telerik:RadAsyncUpload ID="TransactionAttachmentGridUpload" runat="server" TabIndex="28" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="SubmitButton" />
                                                    <asp:HyperLink ID="TransactionAttachmentGridView" runat="server" Target="_blank" NavigateUrl='<%# Bind("TransactionAttachment") %>'>View</asp:HyperLink>
                                                </div>
                                                <div class="col-10 sg-button-right">
                                                    <telerik:RadButton ID="CancelButton" Width="100px" Text="Cancel" runat="server" TabIndex="30" CausesValidation="False" CommandName="Cancel" CssClass="sg-button-submit" />
                                                    <telerik:RadButton ID="UpdateButton" runat="server" Width="100px" TabIndex="29" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Add", "Update")%>' CssClass="sg-button-submit"
                                                        CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' ValidationGroup="UpdateButton" OnClientClicked="GridValidateOnSubmit" />
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
    </div>

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <style>
            .colName {
                float: left;
                width: 50%;
            }
        </style>

        <script>
            function ValidateOnSubmit() {
                var val = true;

                var _control_Object;
                var _control;

                _control_Object = $telerik.$("[id$='TransactionSenderBankComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TransactionRecieveBankComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TransactionSenderBankAccountComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TransactionRecieveBankAccountComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TransactionDocumentTypeComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TransactionDocumentNumberTextBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_value() == "") {
                    val = false;

                    _control.get_styles().EnabledStyle[0] += "border-color: red;";
                    _control.updateCssClass();
                }
                else {
                    _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _control.updateCssClass();
                }

                _control_Object = $telerik.$("[id$='TransactionAmountTextBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_value() == "") {
                    val = false;

                    _control.get_styles().EnabledStyle[0] += "border-color: red;";
                    _control.updateCssClass();
                }
                else {
                    _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _control.updateCssClass();
                }

                _control_Object = $telerik.$("[id$='TransactionDocumentTypeComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TreasurerSignatureTextBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_value() == "") {
                    val = false;

                    _control.get_styles().EnabledStyle[0] += "border-color: red;";
                    _control.updateCssClass();
                }
                else {
                    _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _control.updateCssClass();
                }

                _control_Object = $telerik.$("[id$='TransactionDocumentDateDatePicker']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedDate() == null) {
                    val = false;

                    _control.get_dateInput()._textBoxElement.style.border = "1px solid red";
                }

                return val;
            }

            function GridValidateOnSubmit() {
                var val = true;

                var _control_Object;
                var _control;

                _control_Object = $telerik.$("[id$='TransactionSenderBankGridComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TransactionRecieveBankGridComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TransactionSenderBankAccountGridComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TransactionRecieveBankAccountGridComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TransactionDocumentTypeGridComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TransactionDocumentNumberGridTextBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_value() == "") {
                    val = false;

                    _control.get_styles().EnabledStyle[0] += "border-color: red;";
                    _control.updateCssClass();
                }
                else {
                    _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _control.updateCssClass();
                }

                _control_Object = $telerik.$("[id$='TransactionAmountGridTextBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_value() == "") {
                    val = false;

                    _control.get_styles().EnabledStyle[0] += "border-color: red;";
                    _control.updateCssClass();
                }
                else {
                    _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _control.updateCssClass();
                }

                _control_Object = $telerik.$("[id$='TransactionDocumentTypeGridComboBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedIndex() == null) {
                    val = false;

                    var _element = _control.get_inputDomElement();
                    _element.style.border = "1px solid red";
                }
                else {
                    var _element = _control.get_inputDomElement();
                    _element.style.border = "none";
                }

                _control_Object = $telerik.$("[id$='TreasurerSignatureGridTextBox']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_value() == "") {
                    val = false;

                    _control.get_styles().EnabledStyle[0] += "border-color: red;";
                    _control.updateCssClass();
                }
                else {
                    _control.get_styles().EnabledStyle[0] += "border-color: #CDCDCD;";
                    _control.updateCssClass();
                }

                _control_Object = $telerik.$("[id$='TransactionDocumentDateGridDatePicker']").attr('id');
                _control = $find(_control_Object);

                if (_control.get_selectedDate() == null) {
                    val = false;

                    _control.get_dateInput()._textBoxElement.style.border = "1px solid red";
                }

                return val;
            }
        </script>
    </telerik:RadCodeBlock>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_BankList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_BanksSELECTALL" SelectCommandType="StoredProcedure" />

    <asp:SqlDataSource runat="server" ID="SqlDataSource_BankSenderAccountList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_BankAccountsActiveSELECTALL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="SenderBankID" Name="BankID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_BankRecieveAccountList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_BankAccountsRecieveActiveSELECTALL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="RecieveBankID" Name="BankID" />
            <asp:SessionParameter SessionField="SenderBankAccountID" Name="BankAccountID" DefaultValue="0" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_TransactionBetweenBankAccounts"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        OnUpdating="SqlDataSource_TransactionBetweenBankAccounts_OnUpdating"
        SelectCommand="PROC_APP_BankTransactionBetweenAccountsSELECTALL" SelectCommandType="StoredProcedure"
        UpdateCommand="PROC_APP_BankTransactionBetweenAccountsUPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" Name="UserID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int64" />
            <asp:Parameter Name="TransactionSenderBankID" Type="Int64" />
            <asp:Parameter Name="TransactionSenderBankAccountID" Type="Int64" />
            <asp:Parameter Name="TransactionReceiveBankID" Type="Int64" />
            <asp:Parameter Name="TransactionReceiveBankAccountID" Type="Int64" />
            <asp:Parameter Name="TransactionAmount" Type="Decimal" />
            <asp:Parameter Name="TransactionDocumentType" Type="String" />
            <asp:Parameter DbType="Date" Name="TransactionDocumentDate" />
            <asp:Parameter Name="TransactionDocumentNumber" Type="String" />
            <asp:Parameter Name="TransactionAttachment" Type="String" />
            <asp:Parameter Name="TransactionMemo" Type="String" />
            <asp:Parameter Name="TransactionStatus" Type="Boolean" />
            <asp:Parameter Name="TransactionUpdatedBy" Type="Object" />
            <asp:Parameter Name="TransactionUpdatedDate" Type="DateTime"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
