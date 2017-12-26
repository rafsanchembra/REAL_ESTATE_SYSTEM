<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="BuildingList.aspx.vb" Inherits="RealEstateManagementSystem.BuildingList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="headerPlaceHolderLabel" runat="server" Text="Multi Floor Building" />
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
            <div class="sg-blockcontent">

                <div class="col-row">
                    <div class="col-10 sg-header">
                        <asp:Label ID="BuildingHeaderLabel" runat="server"  AssociatedControlID="BuildingRadGrid" Text="Multi Floor Building List" />
                    </div>
                    <div class="col-10">
                        <telerik:RadGrid ID="BuildingRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource_BuildingList" OnItemDataBound="BuildingRadGrid_ItemDataBound" OnItemCommand="BuildingRadGrid_ItemCommand" CellSpacing="-1" GridLines="Both">
                            <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_BuildingList" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                    <telerik:GridBoundColumn DataField="MFBuildingName" FilterControlWidth="100%" FilterControlAltText="Filter MFBuildingName column" HeaderText="Name" SortExpression="MFBuildingName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="MFBuildingName">
                                        <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="OwnerName" FilterControlWidth="100%" FilterControlAltText="Filter OwnerName column" HeaderText="Owner Name" SortExpression="OwnerName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="OwnerName">
                                        <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MFBuildingFloorCount" FilterControlWidth="100%" FilterControlAltText="Filter MFBuildingFloorCount column" HeaderText="Floor Count" SortExpression="MFBuildingFloorCount"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="MFBuildingFloorCount">
                                        <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MFBuildingFlatCount" FilterControlWidth="100%" FilterControlAltText="Filter MFBuildingFlatCount column" HeaderText="Flat Count" SortExpression="MFBuildingFlatCount"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="MFBuildingFlatCount">
                                        <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MFBuildingShopCount" FilterControlWidth="100%" FilterControlAltText="Filter MFBuildingShopCount column" HeaderText="Shop Count" SortExpression="MFBuildingShopCount"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="MFBuildingShopCount">
                                        <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MFBuildingOfficeCount" FilterControlWidth="100%" FilterControlAltText="Filter MFBuildingOfficeCount column" HeaderText="Office Count" SortExpression="MFBuildingOfficeCount"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="MFBuildingOfficeCount">
                                        <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
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
        </div>
    </div>


   <%-- <telerik:RadWindowManager ID="RadWindowManager_modalPopup" runat="server" EnableViewState="false">
        <Windows>
            <telerik:RadWindow ID="Building_modal" runat="server" VisibleStatusbar="false"
                Modal="true" VisibleTitlebar="false" Behaviors="None">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>--%>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_BuildingList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MultiFloorBuildingsSELECTALL" SelectCommandType="StoredProcedure" />
</asp:Content>
