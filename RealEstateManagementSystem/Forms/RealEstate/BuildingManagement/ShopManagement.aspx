<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="ShopManagement.aspx.vb" Inherits="RealEstateManagementSystem.ShopManagement" %>

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
            <msg:PopMsg ID="PopMsg" runat="server" />
            <div class="sg-absoluteCenter">
                <div class="col-3 col-push-35">
                    <div class="sg-blockcontent">
                        <div class="col-10 sg-header">
                            <asp:Label ID="HeaderLabel" runat="server" Text="Shop Management" />
                        </div>
                        <div class="col-row">
                            <div class="col-10 sg-label">
                                <asp:Label ID="ShopNameLabel" runat="server" AssociatedControlID="ShopNameRadTextBox" Text="Shop Name" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="ShopNameRadTextBox" runat="server" TabIndex="1" ToolTip="Shop Name" Width="100%" />
                                <asp:RequiredFieldValidator ID="ShopNamerequired" ControlToValidate="ShopNameRadTextBox" runat="server" CssClass="field-validation-error" ValidationGroup="Submittshop" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="ShopNumberLabel" runat="server" AssociatedControlID="ShopNumberRadTextBox" Text="Shop Number" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="ShopNumberRadTextBox" runat="server" TabIndex="2" ToolTip="Shop Number" Width="100%" />
                                <asp:RequiredFieldValidator ID="ShopNumberRequired" ControlToValidate="ShopNumberRadTextBox" runat="server" CssClass="field-validation-error" ValidationGroup="Submittshop" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="ShopCapacityLabel" runat="server" AssociatedControlID="ShopNumberRadTextBox" Text="Shop Capacity" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="ShopCapacityRadTextBox" runat="server" TabIndex="3" ToolTip="Shop Capacity" Width="100%" />
                            </div>
                                <div class="col-10 sg-label">
                                <asp:Label ID="ShopFloorComboBoxlabel" runat="server" AssociatedControlID="ShopFloorComboBox" Text="Floor Name" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="ShopFloorComboBox" runat="server" AutoPostBack="true" TabIndex="4" ToolTip="Select the Flat" ItemRequestTimeout="0" EmptyMessage=" --Select-- " Filter="Contains"
                                    CausesValidation="False" MarkFirstMatch="True" Width="100%" DataSourceID="SqlDataSource_FloorList" DataTextField="FloorName" DataValueField="ID" />
                                <asp:RequiredFieldValidator ID="ShopFlatRequired" ControlToValidate="ShopFloorComboBox" runat="server" CssClass="field-validation-error" ValidationGroup="SubmittShop" />
                            </div>
                        </div>
                        <div class="col-10 sg-button-right">
                            <telerik:RadButton ID="SubmitButton" runat="server" Text="Create" CssClass="sg-button-submit" ValidationGroup="Submittshop" OnClick="ShopButton_Click" Width="100px" />
                        </div>
                    </div>                    
                </div>
            </div>
            <div class="col-10  sg-radgrid">
                        <telerik:RadGrid ID="ShopRadGrid" runat="server" CssClass="sg-radgrid" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource_ShopList" OnItemDataBound="ShopRadGrid_ItemDataBound" OnItemCommand="ShopRadGrid_ItemCommand"
                            AllowAutomaticUpdates="true" GroupPanelPosition="Top">
                            <MasterTableView DataKeyNames="" DataSourceID="SqlDataSource_ShopList" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                    <telerik:GridBoundColumn DataField="ShopName" FilterControlWidth="100%" FilterControlAltText="Filter ShopName column" HeaderText="Shop Name" SortExpression="ShopName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ShopName">
                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ShopNumber" FilterControlWidth="100%" FilterControlAltText="Filter ShopNumber column" HeaderText="Shop NO" SortExpression="ShopNumber"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ShopNumber">
                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ShopCapacity" FilterControlWidth="100%" FilterControlAltText="Filter ShopCapacity column" HeaderText="Shop Capacity" SortExpression="ShopCapacity"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ShopCapacity">
                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                      <telerik:GridBoundColumn DataField="FloorName" FilterControlWidth="100%" FilterControlAltText="Filter FloorName column" HeaderText="Shop Floor" SortExpression="FloorName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FloorName">
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
                    <telerik:RadWindow ID="ShopEdit_model" runat="server" Width="1024px" Height="600px" VisibleStatusbar="false"
                        Modal="true" VisibleTitlebar="false" Behaviors="None" >
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
        </div>
    </div>


    <asp:SqlDataSource runat="server" ID="SqlDataSource_ShopList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_ShopSELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="ID" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>

     <asp:SqlDataSource runat="server" ID="SqlDataSource_FloorList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_FloorSELECT" SelectCommandType="StoredProcedure" >
         <SelectParameters>
             <asp:QueryStringParameter QueryStringField="ID" Name="ID" Type="Int64"></asp:QueryStringParameter>
         </SelectParameters>
     </asp:SqlDataSource>
</asp:Content>
