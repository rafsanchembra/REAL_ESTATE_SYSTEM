<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/WindowMaster.Master" CodeBehind="FloorManagement.aspx.vb" Inherits="RealEstateManagementSystem.FloorManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script>
        function CloseAndRebind() {
            var oWindow = GetRadWindow();
            oWindow.argument = null;
            oWindow.close();
            oWindow.BrowserWindow.closeRadWindow("Province");
        }

        function GetRadWindow() {
            var oWindow = null;
            if (window.radWindow)
                oWindow = window.radWindow;
            else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow;
            return oWindow;
        }

        function CloseWindow() {
            var oWindow = GetRadWindow();
            oWindow.argument = null;
            oWindow.close();
            return false;
        }
    </script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="contentPlaceHolder" runat="server">
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
                            <asp:Label ID="Label1" runat="server" Text="Floor Management" />
                        </div>
                        <div class="col-row">
                            <div class="col-10 sg-label">
                                <asp:Label ID="FloorNameLabel" runat="server" AssociatedControlID="FloorNameRadTextBox" Text="Floor Name" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="FloorNameRadTextBox" runat="server" TabIndex="1" ToolTip="Floor Name" Width="100%" />
                                <asp:RequiredFieldValidator ID="FloorNamerequired" ControlToValidate="FloorNameRadTextBox" runat="server" CssClass="field-validation-error" ValidationGroup="SubmittFloor" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="FloorNumberLabel" runat="server" AssociatedControlID="FloorNumberRadTextBox" Text="Floor Number" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="FloorNumberRadTextBox" runat="server" TabIndex="2" ToolTip="Floor Number" Width="100%" />
                                <asp:RequiredFieldValidator ID="FloorNumberRequired" ControlToValidate="FloorNumberRadTextBox" runat="server" CssClass="field-validation-error" ValidationGroup="SubmittFloor" />
                            </div>
                        </div>
                        <div class="col-10 sg-button-right">
                            <telerik:RadButton ID="SubmitButton" runat="server" Text="Create New Floor" CssClass="sg-button-submit" ValidationGroup="SubmittFloor" OnClick="SubmitButton_Click" Width="100%" />
                        </div>
                    </div>
                </div>

            </div>
             <div class="col-10 sg-button-right">
                    <telerik:RadButton ID="CancelButton" runat="server" Width="100px" Text="Close" CssClass="sg-button-cancel" AutoPostBack="false" OnClientClicked="CloseWindow" UseSubmitBehavior="false" />
                </div>
            <div class="col-10  sg-radgrid">
                <telerik:RadGrid ID="FloorRadGrid" runat="server" CssClass="sg-radgrid" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                    DataSourceID="SqlDataSource_Floors" OnItemDataBound="FloorRadGrid_ItemDataBound" OnItemCommand="FloorRadGrid_ItemCommand"
                    AllowAutomaticUpdates="true" GroupPanelPosition="Top">
                    <MasterTableView DataKeyNames="" DataSourceID="SqlDataSource_Floors" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn Display="false" DataField="ID" DataType="System.Int64" ReadOnly="true" UniqueName="ID" />
                            <%-- Uniques Name Should Not Be Repeated In A Grid --%>
                            <telerik:GridBoundColumn DataField="FloorName" FilterControlWidth="100%" FilterControlAltText="Filter FloorName column" HeaderText="Floor Name" SortExpression="FloorName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FloorName">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FloorNo" FilterControlWidth="100%" FilterControlAltText="Filter FloorNo column" HeaderText="Floor NO" SortExpression="FloorNo"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FloorNo">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Edit.png" CommandName="EditData" UniqueName="EditData" ButtonType="ImageButton">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridButtonColumn>
                        </Columns>
                        <PagerStyle AlwaysVisible="True" Mode="NextPrevNumericAndAdvanced" />
                    </MasterTableView>
                    <FilterItemStyle HorizontalAlign="Center" />
                    <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Bottom" AlwaysVisible="true" />
                    <FilterMenu EnableImageSprites="False" EnableSelection="True" />
                </telerik:RadGrid>
            </div>
            <telerik:RadWindowManager ID="RadWindowManager_modalPopup" runat="server" EnableViewState="false">
                <Windows>
                    <telerik:RadWindow ID="FloorEdit_model" runat="server" Width="1024px" Height="600px" VisibleStatusbar="false"
                        Modal="true" VisibleTitlebar="false" Behaviors="None">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
        </div>
    </div>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_Floors"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_FloorSELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="ID" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
