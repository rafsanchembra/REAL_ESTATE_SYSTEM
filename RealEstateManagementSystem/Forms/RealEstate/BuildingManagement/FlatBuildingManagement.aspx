<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="FlatBuildingManagement.aspx.vb" Inherits="RealEstateManagementSystem.FlatBuildingManagement" %>
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
                            <asp:Label ID="HeaderLabel" runat="server" Text="Building Flat Management" />
                        </div>
                        <div class="col-row">
                            <div class="col-10 sg-label">
                                <asp:Label ID="FlatNameLabel" runat="server" AssociatedControlID="FlatNameRadTextBox" Text="Flat Name" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="FlatNameRadTextBox" runat="server" TabIndex="1" ToolTip="Flat Name" Width="100%" />
                                <asp:RequiredFieldValidator ID="FlatNamerequired" ControlToValidate="FlatNameRadTextBox" runat="server" CssClass="field-validation-error" ValidationGroup="SubmittFlat" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="FlatNumberLabel" runat="server" AssociatedControlID="FlatNumberRadTextBox" Text="Flat Number" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="FlatNumberRadTextBox" runat="server" TabIndex="2" ToolTip="Flat Number" Width="100%" />
                                <asp:RequiredFieldValidator ID="FlatNumberRequired" ControlToValidate="FlatNumberRadTextBox" runat="server" CssClass="field-validation-error" ValidationGroup="SubmittFlat" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="FlatRoomNoLabel" runat="server" AssociatedControlID="FlatRoomNoRadTextBox" Text="Flat Room No" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="FlatRoomNoRadTextBox" runat="server" TabIndex="3" ToolTip="Flat Room No" Width="100%" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="FlatBathNoLabel" runat="server" AssociatedControlID="FlatBathNoRadTextBox" Text="Flat Bathroom No" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="FlatBathNoRadTextBox" runat="server" TabIndex="4" ToolTip="Flat bathroom No" Width="100%" />
                            </div>
                              <div class="col-10 sg-label">
                                <asp:Label ID="FlatBathRoomTypeLabel" runat="server" AssociatedControlID="FlatBathRoomTypeComboBox" Text="BathRoom Type" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="FlatBathRoomTypeComboBox" runat="server" TabIndex="5" ToolTip="Select Bathroom type" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True"
                                    ItemRequestTimeout="0" DropDownAutoWidth="Disabled">
                                    <Items>
                                        <telerik:RadComboBoxItem runat="server" Text="Room Attached" Value="Room Attached" />
                                        <telerik:RadComboBoxItem runat="server" Text="Common" Value="Common" />
                                        <telerik:RadComboBoxItem runat="server" Text="Both" Value="Both" />
                                    </Items>
                                </telerik:RadComboBox>
                            </div>
                                <div class="col-10 sg-label">
                                <asp:Label ID="FlatFloorComboBoxlabel" runat="server" AssociatedControlID="FlatFloorComboBox" Text="Floor Name" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="FlatFloorComboBox" runat="server" AutoPostBack="true" TabIndex="6" ToolTip="Select the Flat" ItemRequestTimeout="0" EmptyMessage=" --Select-- " Filter="Contains"
                                    CausesValidation="False" MarkFirstMatch="True" Width="100%" DataSourceID="SqlDataSource_FloorList" DataTextField="FloorName" DataValueField="ID" />
                                <asp:RequiredFieldValidator ID="FlatFlatRequired" ControlToValidate="FlatFloorComboBox" runat="server" CssClass="field-validation-error" ValidationGroup="SubmittFlat" />
                            </div>
                        </div>
                        <div class="col-10 sg-button-right">
                            <telerik:RadButton ID="SubmitButton" runat="server" Text="Create" CssClass="sg-button-submit" ValidationGroup="SubmittFlat" OnClick="SubmitButton_Click" Width="100px" />
                        </div>
                    </div>                    
                </div>
            </div>
            <div class="col-10  sg-radgrid">
                        <telerik:RadGrid ID="FlatRadGrid" runat="server" CssClass="sg-radgrid" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource_FlatList" OnItemDataBound="FlatRadGrid_ItemDataBound"  OnItemCommand="FlatRadGrid_ItemCommand" 
                            AllowAutomaticUpdates="true" GroupPanelPosition="Top">
                            <MasterTableView DataKeyNames="" DataSourceID="SqlDataSource_FlatList" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                    <telerik:GridBoundColumn DataField="FlatName" FilterControlWidth="100%" FilterControlAltText="Filter FlatName column" HeaderText="Flat Name" SortExpression="FlatName"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatName">
                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="FlatNumber" FilterControlWidth="100%" FilterControlAltText="Filter FlatNumber column" HeaderText="Flat NO" SortExpression="FlatNumber"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatNumber">
                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="FlatRoomNo" FilterControlWidth="100%" FilterControlAltText="Filter FlatRoomNo column" HeaderText="Flat Room Number" SortExpression="FlatRoomNo"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatRoomNo">
                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                     <telerik:GridBoundColumn DataField="FlatBathRoomNo" FilterControlWidth="100%" FilterControlAltText="Filter FlatBathRoomNo column" HeaderText="Flat Bathroom Number" SortExpression="FlatBathRoomNo"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatBathRoomNo">
                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                      <telerik:GridBoundColumn DataField="FlatBathRoomType" FilterControlWidth="100%" FilterControlAltText="Filter FlatBathRoomType column" HeaderText="Flat Bathroom Type" SortExpression="FlatBathRoomType"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatBathRoomType">
                                        <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                    </telerik:GridBoundColumn>
                                      <telerik:GridBoundColumn DataField="FloorName" FilterControlWidth="100%" FilterControlAltText="Filter FloorName column" HeaderText="Flat Floor" SortExpression="FloorName"
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
                    <telerik:RadWindow ID="FlatEdit_model" runat="server" Width="1024px" Height="600px" VisibleStatusbar="false"
                        Modal="true" VisibleTitlebar="false" Behaviors="None" >
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
        </div>
    </div>


    <asp:SqlDataSource runat="server" ID="SqlDataSource_FlatList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_BuildingFlatSELECT" SelectCommandType="StoredProcedure">
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

