<%@ Page Title="" Language="vb" Culture="ar-OM" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="BankAccountAdvanceManagement.aspx.vb" Inherits="RealEstateManagementSystem.BankAccountAdvanceManagement" %>
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
                    <asp:Label ID="header" runat="server" Text="advance Account Management" />
                </div>
                    <telerik:RadListView ID="BankListView" runat="server"  Width="100%" PageSize="1" DataKeyNames="ID" DataSourceID="SqlDataSource_Bank">
                        <ItemTemplate>
                            <div class="col-10 sg-header">
                                <asp:Label ID="bankHeaderLabel" runat="server" Text="Bank Details" />
                            </div>
                            <div class="col-row">
                                <div class="col-8 col-push-10">
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
                            </div>
                        </ItemTemplate>
                    </telerik:RadListView>
                </div>
                <div class="col-10 sg-header">
                    <asp:Label ID="bankAccountHeaderLabel" runat="server" Text="Advance Bank Account Details" />
                </div>
                <div class="col-10 sg-radgrid">
                    <telerik:RadGrid ID="BankAccountRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0"
                        DataSourceID="SqlDataSource_BankAccountList" GridLines="None" AllowAutomaticUpdates="true"
                        OnItemDataBound="BankAccountRadGrid_ItemDataBound" OnItemCommand="BankAccountRadGrid_ItemCommand">
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
                                <telerik:GridButtonColumn CommandName="OpeningBalace" UniqueName="OpeningBalace" ButtonType="ImageButton" ImageUrl ="~\Content\css\MeStyle\Grid\Invoices.png" HeaderText="Opening Balace" Text="Update">
                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                </telerik:GridButtonColumn>
                                <telerik:GridButtonColumn CommandName="AccountStatus" UniqueName="AccountStatus" ImageUrl ="~\Content\css\MeStyle\Grid\Add.png" ButtonType="ImageButton" HeaderText="Account Status" Text="Change">
                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <PagerStyle AlwaysVisible="True" Mode="NextPrevNumericAndAdvanced" />
                        </MasterTableView>
                        <FilterItemStyle HorizontalAlign="Center" />
                        <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Bottom" AlwaysVisible="true" />
                        <FilterMenu EnableImageSprites="False" EnableSelection="True" />
                    </telerik:RadGrid>
                </div>
        </div>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager_modalPopup" runat="server" EnableViewState="false">
        <Windows>
            <telerik:RadWindow ID="modalPopup_BankAccountStatus" runat="server" Width="450px" Height="250px" VisibleStatusbar="false"
                VisibleOnPageLoad="false" Modal="true" VisibleTitlebar="false" Behaviors="None" DestroyOnClose="true" />
            <telerik:RadWindow ID="modalPopup_BankAccountOpeningBalance" runat="server" Width="1200px" Height="440px" VisibleStatusbar="false"
                VisibleOnPageLoad="false" Modal="true" VisibleTitlebar="false" Behaviors="None" />
        </Windows>
    </telerik:RadWindowManager>

    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script>
            function refreshGrid() {
                var masterTable = $find("<%= BankAccountRadGrid.ClientID %>").get_masterTableView();
                masterTable.rebind();
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
        SelectCommand="PROC_APP_BankAccountsSELECTALL" SelectCommandType="StoredProcedure" >
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="BankID" Type="Int64"></asp:QueryStringParameter>

        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
