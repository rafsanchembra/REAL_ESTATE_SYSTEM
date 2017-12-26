<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="BankAdvanceManagement.aspx.vb" Inherits="RealEstateManagementSystem.BankAdvanceManagement" %>
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
                    <asp:Label ID="header" runat="server" Text="Advance Bank Management" />
                </div>
                <div class="col-10 sg-radgrid">
                    <telerik:RadGrid ID="BankRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0" AllowAutomaticUpdates="true"
                        DataSourceID="SqlDataSource_BankList" GridLines="None" OnItemDataBound="BankRadGrid_ItemDataBound">
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
                                <telerik:GridHyperLinkColumn DataNavigateUrlFields="ID" AllowFiltering="false" DataNavigateUrlFormatString="~/Forms/Bank/BankAccountAdvanceManagement.aspx?ID={0}" ImageUrl="~/Content/css/MeStyle/Grid/next.png" HeaderText="Accounts">
                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                </telerik:GridHyperLinkColumn>
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
    </div>

    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock">
        <style>
             .sg-blockcontent a:visited, .sg-blockcontent a.visited {
            color: #0F3057 !important ;
        }

        .sg-blockcontent a:hover, .sg-blockcontent a.hover {
            color: #0F3057 !important ;
        }
        </style>
    </telerik:RadCodeBlock>
    <asp:SqlDataSource ID="SqlDataSource_BankList" runat="server"
        ConnectionString="<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>"
        SelectCommand="PROC_APP_BanksSELECTALL" SelectCommandType="StoredProcedure" />
</asp:Content>

