<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="BankAccountTransaction.aspx.vb" Inherits="RealEstateManagementSystem.BankAccountTransaction" %>

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
                <div class="col-row">
                    <div class="col-8 col-push-10">
                    <div class="col-10 sg-header">
                        <asp:Label ID="TranscationHeader" runat="server" Text="Bank Account Transcation" />
                    </div>
                    <div class="col-5">
                        <div class="sg-blockcontent">
                            <div class="col-10 sg-label">
                                <asp:Label ID="TransactionBankLabel" runat="server" AssociatedControlID="TransactionBankComboBox" Text="Bank" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="TransactionBankComboBox" runat="server" TabIndex="1" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                    ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankList" DataTextField="BankEnglishName" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="TransactionBankComboBox_SelectedIndexChanged">
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
                                <asp:RequiredFieldValidator ID="TransactionBankRequired" runat="server" ControlToValidate="TransactionBankComboBox" ValidationGroup="Submit" CssClass="field-validation-error" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="TransactionDocumentTypeLabel" runat="server" AssociatedControlID="TransactionDocumentTypeComboBox" Text="Document Type" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="TransactionDocumentTypeComboBox" runat="server" TabIndex="3" CausesValidation="False" Width="100%" MarkFirstMatch="True"
                                    EmptyMessage="--- Select ---" Filter="Contains" ItemRequestTimeout="0">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Check" Value="Check" />
                                        <telerik:RadComboBoxItem runat="server" Text="Transfer" Value="Transfer" />
                                    </Items>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="TransactionDocumentTypeRequired" runat="server" ControlToValidate="TransactionDocumentTypeComboBox" ValidationGroup="Submit" CssClass="field-validation-error" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="TransactionAmountLabel" runat="server" AssociatedControlID="TransactionAmountTextBox" Text="Document Amount" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadNumericTextBox ID="TransactionAmountTextBox" runat="server" MinValue="0" TabIndex="5" Type="Currency" Width="100%" ToolTip="Transaction Document Amount">
                                    <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="TransactionAmountRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionAmountTextBox" ValidationGroup="Submit" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="TransactionDocumentDateLabel" runat="server" AssociatedControlID="TransactionDocumentDateDatePicker" Text="Document Date" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadDatePicker ID="TransactionDocumentDateDatePicker" runat="server" TabIndex="7" Width="100%" MinDate="01/01/1950" ToolTip="Transaction Document Date">
                                    <DateInput ID="TransactionDocumentDateDateInput" runat="server" Font-Size="Medium" InvalidStyleDuration="100" SelectionOnFocus="SelectAll" DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" />
                                    <Calendar ID="Calendar1" runat="server" ShowRowHeaders="false" />
                                </telerik:RadDatePicker>
                                <asp:RequiredFieldValidator ID="TransactionDocumentDateRequired" runat="server" ControlToValidate="TransactionDocumentDateDatePicker" CssClass="field-validation-error" ValidationGroup="Submit" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="TreasurerSignatureLabel" runat="server" AssociatedControlID="TreasurerSignatureTextBox" Text="Treasurer Signature" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="TreasurerSignatureTextBox" runat="server" MaxLength="30" TextMode="Password" TabIndex="9" Width="100%" ToolTip="User Signature" AutoCompleteType="Disabled" />
                                <asp:RequiredFieldValidator ID="TreasurerSignatureRequired" runat="server" ControlToValidate="TreasurerSignatureTextBox" CssClass="field-validation-error" ValidationGroup="Submit" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="TransactionAttachmentLabel" runat="server" AssociatedControlID="TransactionAttachmentUpload" Text="Transaction Attachment" />
                            </div>
                            <div class="col-10">
                                <telerik:RadAsyncUpload ID="TransactionAttachmentUpload" runat="server" MaxFileInputsCount="1" Skin="MetroTouch" TabIndex="10" AllowedFileExtensions=".pdf" PostbackTriggers="SubmitButton" />
                            </div>
                        </div>
                    </div>
                    <div class="col-5">
                        <div class="sg-blockcontent">
                            <div class="col-10 sg-label">
                                <asp:Label ID="TransactionBankAccountLabel" runat="server" AssociatedControlID="TransactionBankAccountComboBox" Text="Bank Account" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="TransactionBankAccountComboBox" runat="server" CausesValidation="False" Width="100%" TabIndex="2" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                    ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankAccountList" DataTextField="BankAccountEnglishName" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="TransactionBankAccountComboBox_SelectedIndexChanged">
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
                                <asp:RequiredFieldValidator ID="TransactionBankAccountRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionBankAccountComboBox" ValidationGroup="Submit" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="TransactionDocumentNumberLabel" runat="server" AssociatedControlID="TransactionDocumentNumberTextBox" Text="Document Number" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="TransactionDocumentNumberTextBox" runat="server" Width="100%" TabIndex="4" ToolTip="Transaction Document Number" />
                                <asp:RequiredFieldValidator ID="TransactionDocumentNumberRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionDocumentNumberTextBox" ValidationGroup="Submit" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="BankAccountTotalLabel" runat="server" AssociatedControlID="BankAccountTotalTextBox" Text="Account Total Amount" />
                            </div>
                            <div class="col-10">
                                <telerik:RadNumericTextBox ID="BankAccountTotalTextBox" runat="server" TabIndex="6" ReadOnly="true" Type="Currency" Width="100%" ToolTip="Bank Account Total Amount">
                                    <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                </telerik:RadNumericTextBox>
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="TransactionTypeLabel" runat="server" AssociatedControlID="TransactionTypeComboBox" Text="Transaction Type" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="TransactionTypeComboBox" runat="server" CausesValidation="False" TabIndex="8" Width="100%" MarkFirstMatch="True"
                                    EmptyMessage="--- Select ---" Filter="Contains" ItemRequestTimeout="0">
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="TransactionTypeRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionTypeComboBox" ValidationGroup="Submit" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="TransactionMemoLabel" runat="server" AssociatedControlID="TransactionMemoTextBox" Text="Memo" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="TransactionMemoTextBox" runat="server" TextMode="MultiLine" Height="120px" TabIndex="10" Width="100%" ToolTip="Transaction Memo" />
                            </div>
                        </div>
                    </div>
                    <div class="col-10 sg-button-right">
                        <telerik:RadButton ID="SubmitButton" runat="server" Text="Submit" CssClass="sg-button-submit" Width="150px" TabIndex="12" ValidationGroup="Submit" OnClientClicked="ValidateOnSubmit" OnClick="SubmitButton_Click" />
                    </div>
                        </div>
                </div>
                <div class="col-10 sg-radgrid">
                    <telerik:RadGrid ID="BankAccountTransactionRadGrid" runat="server" AllowAutomaticUpdates="True" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                        CellSpacing="0" DataSourceID="SqlDataSource_BankAccountTransaction" GridLines="None" OnItemDataBound="BankAccountTransactionRadGrid_ItemDataBound"
                        OnItemCommand="BankAccountTransactionRadGrid_ItemCommand" OnEditCommand="BankAccountTransactionRadGrid_EditCommand" OnUpdateCommand="BankAccountTransactionRadGrid_UpdateCommand">
                        <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_BankAccountTransaction" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                <telerik:GridBoundColumn Display="false" DataField="TransactionBankID" UniqueName="TransactionBankID" />
                                <telerik:GridBoundColumn Display="false" DataField="TransactionBankAccountID" UniqueName="TransactionBankAccountID" />
                                <telerik:GridBoundColumn Display="false" DataField="TransactionAmount" DataType="System.Int64" UniqueName="TransactionAmountValue" />
                                <telerik:GridBoundColumn DataField="BankEnglishName" FilterControlWidth="100%" FilterControlAltText="Filter BankEnglishName column" HeaderText="Bank Name" SortExpression="BankEnglishName"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankEnglishName">
                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                    <ItemStyle HorizontalAlign="Center" Width="150px" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BankAccountEnglishName" FilterControlWidth="100%" FilterControlAltText="Filter BankAccountEnglishName column" HeaderText="Account Name" SortExpression="BankAccountEnglishName"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BankAccountEnglishName">
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
                                <telerik:GridBoundColumn DataField="TransactionType" FilterControlWidth="100%" FilterControlAltText="Filter TransactionType column" HeaderText="Transaction Type" SortExpression="TransactionType"
                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="TransactionType">
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
                                        <div class="col-row">
                                            <div class="col-10 sg-header">
                                                <asp:Label ID="TranscationHeader" runat="server" Text="Bank Account Transcation" />
                                            </div>
                                            <div class="col-5">
                                                <div class="sg-blockcontent-right">
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="TransactionBankGridLabel" runat="server" AssociatedControlID="TransactionBankGridComboBox" Text="Bank" />
                                                    </div>
                                                    <div class="col-10 sg-textbox-required-field">
                                                        <telerik:RadComboBox ID="TransactionBankGridComboBox" runat="server" TabIndex="13" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                                            ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankList" DataTextField="BankEnglishName" DataValueField="ID" AutoPostBack="true"
                                                            OnSelectedIndexChanged="TransactionBankGridComboBox_SelectedIndexChanged" SelectedValue='<%# Bind("TransactionBankID") %>'>
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
                                                        <asp:RequiredFieldValidator ID="TransactionBankGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionBankGridComboBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="TransactionDocumentTypeGridLabel" runat="server" AssociatedControlID="TransactionDocumentTypeGridComboBox" Text="Document Type" />
                                                    </div>
                                                    <div class="col-10 sg-textbox-required-field">
                                                        <telerik:RadComboBox ID="TransactionDocumentTypeGridComboBox" runat="server" CausesValidation="False" Width="100%" MarkFirstMatch="True"
                                                            EmptyMessage="--- Select ---" Filter="Contains" TabIndex="15" ItemRequestTimeout="0" SelectedValue='<%# Bind("TransactionDocumentType") %>'>
                                                            <Items>
                                                                <telerik:RadComboBoxItem runat="server" Text="Check" Value="Check" />
                                                                <telerik:RadComboBoxItem runat="server" Text="Transfer" Value="Transfer" />
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator ID="TransactionDocumentTypeGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionDocumentTypeGridComboBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="BankAccountTotalGridLabel" runat="server" AssociatedControlID="BankAccountTotalGridTextBox" Text="Account Total Amount" />
                                                    </div>
                                                    <div class="col-10">
                                                        <telerik:RadNumericTextBox ID="BankAccountTotalGridTextBox" runat="server" TabIndex="17" ReadOnly="true" Type="Currency" Width="100%" ToolTip="Bank Account Total Amount">
                                                            <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                                        </telerik:RadNumericTextBox>
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="TransactionDocumentDateGridLabel" runat="server" AssociatedControlID="TransactionDocumentDateGridDatePicker" Text="Document Date" />
                                                    </div>
                                                    <div class="col-10 sg-textbox-required-field">
                                                        <telerik:RadDatePicker ID="TransactionDocumentDateGridDatePicker" TabIndex="19" runat="server" Width="100%" MinDate="01/01/1950" ToolTip="Transaction Document Date" SelectedDate='<%# Bind("TransactionDocumentDate") %>'>
                                                            <DateInput ID="TransactionDocumentDateGridDateInput" runat="server" Font-Size="Medium" InvalidStyleDuration="100" SelectionOnFocus="SelectAll" DateFormat="dd/MM/yyyy" DisplayDateFormat="dd/MM/yyyy" />
                                                            <Calendar ID="Calendar1" runat="server" ShowRowHeaders="false" />
                                                        </telerik:RadDatePicker>
                                                        <asp:RequiredFieldValidator ID="TransactionDocumentDateGridRequired" CssClass="field-validation-error" runat="server" ControlToValidate="TransactionDocumentDateGridDatePicker" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="TransactionStatusGridLabel" runat="server" AssociatedControlID="TransactionStatusGridComboBox" Text="Status" />
                                                    </div>
                                                    <div class="col-10">
                                                        <telerik:RadComboBox ID="TransactionStatusGridComboBox" runat="server" TabIndex="21" CausesValidation="False" Width="100%" MarkFirstMatch="True"
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
                                                    <div class="col-10">
                                                        <telerik:RadTextBox ID="TransactionMemoGridTextBox" runat="server" TextMode="MultiLine" TabIndex="23" Height="80px" Width="100%" ToolTip="Transaction Memo" Text='<%# Bind("TransactionMemo") %>' />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-5">
                                                <div class="sg-blockcontent-left">
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="TransactionBankAccountGridLabel" runat="server" AssociatedControlID="TransactionBankAccountGridComboBox" Text="Bank Account" />
                                                    </div>
                                                    <div class="col-10 sg-textbox-required-field">
                                                        <telerik:RadComboBox ID="TransactionBankAccountGridComboBox" runat="server" TabIndex="14" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                                            ItemRequestTimeout="0" DataSourceID="SqlDataSource_BankAccountList" DataTextField="BankAccountEnglishName" DataValueField="ID" AutoPostBack="true" OnSelectedIndexChanged="TransactionBankAccountGridComboBox_SelectedIndexChanged">
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
                                                        <asp:RequiredFieldValidator ID="TransactionBankAccountGridRequired" CssClass="field-validation-error" runat="server" ControlToValidate="TransactionBankAccountGridComboBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="TransactionDocumentNumberGridLabel" runat="server" AssociatedControlID="TransactionDocumentNumberGridTextBox" Text="Document Number" />
                                                    </div>
                                                    <div class="col-10 sg-textbox-required-field">
                                                        <telerik:RadTextBox ID="TransactionDocumentNumberGridTextBox" runat="server" TabIndex="16" Width="100%" ToolTip="Transaction Document Number" Text='<%# Bind("TransactionDocumentNumber") %>' />
                                                        <asp:RequiredFieldValidator ID="TransactionDocumentNumberGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionDocumentNumberGridTextBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="TransactionAmountGridLabel" runat="server" AssociatedControlID="TransactionAmountGridTextBox" Text="Document Amount" />
                                                    </div>
                                                    <div class="col-10 sg-textbox-required-field">
                                                        <telerik:RadNumericTextBox ID="TransactionAmountGridTextBox" runat="server" TabIndex="18" MinValue="0" Type="Currency" Width="100%" ToolTip="Transaction Document Amount" Text='<%# Bind("TransactionAmount") %>'>
                                                            <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                                        </telerik:RadNumericTextBox>
                                                        <asp:RequiredFieldValidator ID="TransactionAmountGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionAmountGridTextBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="TransactionTypeGridLabel" runat="server" AssociatedControlID="TransactionTypeGridComboBox" Text="Transaction Type" />
                                                    </div>
                                                    <div class="col-10 sg-textbox-required-field">
                                                        <telerik:RadComboBox ID="TransactionTypeGridComboBox" runat="server" TabIndex="20" CausesValidation="False" Width="100%" MarkFirstMatch="True"
                                                            EmptyMessage="--- Select ---" Filter="Contains" ItemRequestTimeout="0" SelectedValue='<%# Bind("TransactionType") %>'>
                                                            <Items>
                                                                <telerik:RadComboBoxItem runat="server" Text="In" Value="In" />
                                                                <telerik:RadComboBoxItem runat="server" Text="Out" Value="Out" />
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator ID="TransactionTypeGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TransactionTypeGridComboBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="TreasurerSignatureGridLabel" runat="server" AssociatedControlID="TreasurerSignatureGridTextBox" Text="Treasurer Signature" />
                                                    </div>
                                                    <div class="col-10 sg-textbox-required-field">
                                                        <telerik:RadTextBox ID="TreasurerSignatureGridTextBox" runat="server" MaxLength="30" TabIndex="22" TextMode="Password" Width="100%" ToolTip="User Signature" AutoCompleteType="Disabled" />
                                                        <asp:RequiredFieldValidator ID="TreasurerSignatureGridRequired" runat="server" CssClass="field-validation-error" ControlToValidate="TreasurerSignatureGridTextBox" ValidationGroup="UpdateButton" EnableClientScript="true" />
                                                    </div>
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="TransactionAttachmentGridLabel" runat="server" AssociatedControlID="TransactionAttachmentGridUpload" Text="Transaction Attachment" />
                                                    </div>
                                                    <div class="col-10">
                                                        <telerik:RadAsyncUpload ID="TransactionAttachmentGridUpload" runat="server" TabIndex="24" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="UpdateButton" />
                                                        <asp:HyperLink ID="TransactionAttachmentGridView" runat="server" Target="_blank" NavigateUrl='<%# Bind("TransactionAttachment") %>'>View</asp:HyperLink>
                                                    </div>
                                                    <div class="col-10 sg-button-right">
                                                        <telerik:RadButton ID="CancelButton" Width="100px" Text="Cancel" runat="server" TabIndex="25" CausesValidation="False" CommandName="Cancel" CssClass="sg-button-submit" />
                                                        <telerik:RadButton ID="UpdateButton" runat="server" Width="100px" TabIndex="26" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Add", "Update")%>' CssClass="sg-button-submit"
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

                _control_Object = $telerik.$("[id$='TransactionBankComboBox']").attr('id');
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

                _control_Object = $telerik.$("[id$='TransactionBankAccountComboBox']").attr('id');
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

                _control_Object = $telerik.$("[id$='TransactionTypeComboBox']").attr('id');
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

                _control_Object = $telerik.$("[id$='TransactionBankGridComboBox']").attr('id');
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

                _control_Object = $telerik.$("[id$='TransactionBankAccountGridComboBox']").attr('id');
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

                _control_Object = $telerik.$("[id$='TransactionTypeGridComboBox']").attr('id');
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

    <asp:SqlDataSource runat="server" ID="SqlDataSource_BankAccountList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_BankAccountsActiveSELECTALL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="BankID" Name="BankID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_BankAccountTransaction"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        OnUpdating="SqlDataSource_BankAccountTransaction_OnUpdating"
        SelectCommand="PROC_APP_BankAccountTransactionsSELECTALL" SelectCommandType="StoredProcedure"
        UpdateCommand="PROC_APP_BankAccountTransactionsUPDATE" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" Name="UserID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int64" />
            <asp:Parameter Name="TransactionBankID" Type="Int64" />
            <asp:Parameter Name="TransactionBankAccountID" Type="Int64" />
            <asp:Parameter Name="TransactionDocumentType" Type="String" />
            <asp:Parameter Name="TransactionDocumentNumber" Type="String" />
            <asp:Parameter Name="TransactionAmount" Type="Decimal" />
            <asp:Parameter Name="TransactionType" Type="String" />
            <asp:Parameter DbType="Date" Name="TransactionDocumentDate" />
            <asp:Parameter Name="TransactionAttachment" Type="String" />
            <asp:Parameter Name="TransactionMemo" Type="String" />
            <asp:Parameter Name="TransactionStatus" Type="Boolean" />
            <asp:Parameter Name="TransactionUpdatedDate" Type="DateTime" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
