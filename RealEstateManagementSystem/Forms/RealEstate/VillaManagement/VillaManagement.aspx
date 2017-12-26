<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="VillaManagement.aspx.vb" Inherits="RealEstateManagementSystem.VillaManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script>
        var bodyOverFlow = "";
        var htmlOverFlow = "";

        function openRadWindow() {
            bodyOverFlow = document.body.style.overflow;
            htmlOverFlow = document.documentElement.style.overflow;

            document.body.style.overflow = "hidden";
            document.documentElement.style.overflow = "hidden";
        }

        function closeRadWindow() {
            $find("<%= RadAjaxManagerMain.ClientID %>").ajaxRequest();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="featuredPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManagerMain" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel" OnAjaxRequest="RadAjaxManagerMain_AjaxRequest">
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
                <div class="col-10 sg-header">
                    <asp:Label ID="HeaderLabel" runat="server" Text="Villa" />
                </div>
                <div class="col-row">
                    <div class="col-8 col-push-10">
                        <div class="col-5">
                            <div class="sg-blockcontent">
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaNameLabel" runat="server" AssociatedControlID="VillaNameRadTextBox" Text="Name" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadTextBox ID="VillaNameRadTextBox" runat="server" Width="100%" TabIndex="1" ToolTip="Name" />
                                    <asp:RequiredFieldValidator ID="VillaNameRequired" runat="server" CssClass="field-validation-error" ControlToValidate="VillaNameRadTextBox" ValidationGroup="VillaSubmit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaCompanyNameLabel" runat="server" AssociatedControlID="VillaCompanyNameRadTextBox" Text="Company Name" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="VillaCompanyNameRadTextBox" runat="server" TabIndex="3" ToolTip="Company Name" Width="100%" />
                                </div>
                                <div class="col-5 sg-label">
                                    <asp:Label ID="VillaProvinceLabel" runat="server" AssociatedControlID="VillaProvinceComboBox" Text="Province" />
                                </div>
                                <div class="col-5 sg-label sg-text-align-right">
                                    <asp:LinkButton ID="AddnewProvince" runat="server" Text="Add New Province" Height="50%" OnClick="AddnewProvince_Click" OnOwnerClick="openRadWindow" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="VillaProvinceComboBox" runat="server" TabIndex="5" ToolTip="Select the Province" AppendDataBoundItems="True" AutoPostBack="true" EmptyMessage=" --Select-- "
                                        CausesValidation="False" MarkFirstMatch="True" Width="100%" DataSourceID="SqlDataSource_ProvincesList" DataTextField="ProvinceName" DataValueField="ID" OnSelectedIndexChanged="VillaProvinceComboBox_SelectedIndexChanged" />
                                    <asp:RequiredFieldValidator ID="VillaProvinceComboBoxRequired" CssClass="field-validation-error" runat="server" ControlToValidate="VillaProvinceComboBox" ValidationGroup="VillaSubmit" EnableClientScript="true" />
                                </div>
                                <div class="col-5 sg-label">
                                    <asp:Label ID="VillaVillageLabel" runat="server" AssociatedControlID="VillaVillageComboBox" Text="Village" />
                                </div>
                                <div class="col-5 sg-label sg-text-align-right">
                                    <asp:LinkButton ID="addnewVillage" runat="server" Text="Add New Village" OnClick="addnewVillage_Click" Height="50%" OnOwnerClick="openRadWindow" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="VillaVillageComboBox" runat="server" TabIndex="7" ToolTip="Select the Village" AppendDataBoundItems="True" AutoPostBack="true" EmptyMessage=" --Select-- "
                                        CausesValidation="False" MarkFirstMatch="True" Width="100%" DataSourceID="SqlDataSource_VillageList" DataTextField="VillageName" DataValueField="ID" />
                                    <asp:RequiredFieldValidator ID="VillaVillageComboBoxRequired" CssClass="field-validation-error" runat="server" ControlToValidate="VillaVillageComboBox" ValidationGroup="VillaSubmit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaRoomNoLabel" runat="server" AssociatedControlID="VillaRoomNoTextBox" Text="No.of Rooms" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="VillaRoomNoTextBox" runat="server" TabIndex="9" ToolTip="no.of Rooms" Width="100%" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaBathRoomTypeLabel" runat="server" AssociatedControlID="VillaBathRoomTypeComboBox" Text="BathRoom Type" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadComboBox ID="VillaBathRoomTypeComboBox" runat="server" TabIndex="11" ToolTip="Select Bathroom type" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True"
                                        ItemRequestTimeout="0" DropDownAutoWidth="Disabled">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="Room Attached" Value="Room Attached" />
                                            <telerik:RadComboBoxItem runat="server" Text="Common" Value="Common" />
                                            <telerik:RadComboBoxItem runat="server" Text="Both" Value="Both" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaMemoLabel" runat="server" AssociatedControlID="VillaMemoRadTextBox" Text="Memo" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="VillaMemoRadTextBox" runat="server" TextMode="MultiLine" TabIndex="13" Height="90px" Width="100%" ToolTip="Memo" />
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="sg-blockcontent">
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaOfficalNameLabel" runat="server" AssociatedControlID="VillaOfficalNameRadTextBox" Text="Offical Name" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="VillaOfficalNameRadTextBox" runat="server" TabIndex="2" ToolTip="Offical Name" Width="100%" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaRentPriceLabel" runat="server" AssociatedControlID="VillaRentPriceRadTextBox" Text="Rent Price" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadNumericTextBox ID="VillaRentPriceRadTextBox" runat="server" Type="Currency" TabIndex="4" ToolTip="Enter the Rent Price" Width="100%">
                                        <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                    </telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="VillarentPriceRequired" runat="server" CssClass="field-validation-error" ControlToValidate="VillaRentPriceRadTextBox" ValidationGroup="VillaSubmit" EnableClientScript="true" />
                                </div>
                                <div class="col-5 sg-label">
                                    <asp:Label ID="VillaCityLabel" runat="server" AssociatedControlID="VillaCityComboBox" Text="City" />
                                </div>
                                <div class="col-5 sg-label sg-text-align-right">
                                    <asp:LinkButton ID="AddnewCity" runat="server" Text="Add New City" OnClick="AddnewCity_Click" Height="50%" OnOwnerClick="openRadWindow" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="VillaCityComboBox" runat="server" TabIndex="6" ToolTip="Select the City name" AppendDataBoundItems="True" AutoPostBack="true" EmptyMessage=" --Select-- "
                                        CausesValidation="False" MarkFirstMatch="True" Width="100%" OnSelectedIndexChanged="VillaCityComboBox_SelectedIndexChanged" DataSourceID="SqlDataSource_CityList" DataTextField="CityName" DataValueField="ID" />
                                    <asp:RequiredFieldValidator ID="VillaCityComboBoxRequired" runat="server" CssClass="field-validation-error" ControlToValidate="VillaCityComboBox" ValidationGroup="VillaSubmit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaPlaceLabel" runat="server" AssociatedControlID="VillaPlaceRadTExtBox" Text="Place" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="VillaPlaceRadTExtBox" runat="server" TabIndex="8" ToolTip="Place" Width="100%" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaFloorNoLabel" runat="server" AssociatedControlID="VillaBathroomNoTextBox" Text="No.of Floors" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="VillaFloorNoTextBox" runat="server" TabIndex="10" ToolTip="no.of Floors" Width="100%" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaBathroomNoLabel" runat="server" AssociatedControlID="VillaBathroomNoTextBox" Text="No.of BathRooms" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="VillaBathroomNoTextBox" runat="server" TabIndex="12" ToolTip="no.of Bathrooms" Width="100%" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="VillaAttachment1Label" runat="server" AssociatedControlID="VillaAttachmentUpload" Text="Attachments" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadAsyncUpload ID="VillaAttachmentUpload" runat="server" TabIndex="14" ToolTip="Upload the Attachments" MaxFileInputsCount="10" Skin="MetroTouch" MultipleFileSelection="Automatic" AllowedFileExtensions=".pdf,.jpeg,.jpg,.tif,.png,.gif,tiff,.bmp,.bpg" PostbackTriggers="SubmitButton" />
                                </div>
                                <div class="col-10 sg-button-right">
                                    <telerik:RadButton ID="SubmitButton" runat="server" TabIndex="15" ValidationGroup="VillaSubmit" Text="Submit" CssClass="sg-button-submit" Width="150px" OnClick="SubmitButton_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-10  sg-radgrid">
                <telerik:RadGrid ID="VillaradGrid" runat="server" CssClass="sg-radgrid" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0"
                    DataSourceID="SqlDataSource_Villa" OnItemDataBound="VillaradGrid_ItemDataBound" OnItemCommand="VillaradGrid_ItemCommand" GridLines="None" AllowAutomaticUpdates="true">
                    <MasterTableView DataKeyNames="" DataSourceID="SqlDataSource_Villa" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                            <telerik:GridBoundColumn Display="false" DataField="ID" UniqueName="ID" ReadOnly="true" DataType="System.Int64"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VillaName" FilterControlWidth="100%" FilterControlAltText="Filter VillaName column" HeaderText="Name" SortExpression="VillaName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="VillaName">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VillaCompanyName" FilterControlWidth="100%" FilterControlAltText="Filter VillaCompanyName column" HeaderText="Company Name" SortExpression="VillaCompanyName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="VillaCompanyName">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VillaRentingPrice" FilterControlWidth="100%" FilterControlAltText="Filter VillaRentingPrice column" HeaderText="Rent Price" SortExpression="VillaRentingPrice"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="VillaRentingPrice">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ProvinceName" FilterControlWidth="100%" FilterControlAltText="Filter ProvinceName column" HeaderText="Province" SortExpression="ProvinceName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ProvinceName">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CityName" FilterControlWidth="100%" FilterControlAltText="Filter CityName column" HeaderText="City" SortExpression="CityName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="CityName">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VillageName" FilterControlWidth="100%" FilterControlAltText="Filter VillageName column" HeaderText="Village" SortExpression="VillageName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="VillageName">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VillaPlace" FilterControlWidth="100%" FilterControlAltText="Filter VillaPlace column" HeaderText="Place" SortExpression="VillaPlace"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="VillaPlace">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VillaFloorNumber" FilterControlWidth="100%" FilterControlAltText="Filter VillaFloorNumber column" HeaderText="Floor NO" SortExpression="VillaFloorNumber"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="VillaFloorNumber">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VillaRoomNumber" FilterControlWidth="100%" FilterControlAltText="Filter VillaRoomNumber column" HeaderText="Room NO" SortExpression="VillaRoomNumber"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="VillaRoomNumber">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VillaBathroomNumber" FilterControlWidth="100%" FilterControlAltText="Filter VillaBathroomNumber column" HeaderText="Bathrrom NO" SortExpression="VillaBathroomNumber"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="VillaBathroomNumber">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VillaBathroomType" FilterControlWidth="100%" FilterControlAltText="Filter VillaBathroomType column" HeaderText="Bathroom Type" SortExpression="VillaBathroomType"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="VillaBathroomType">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Edit.png" CommandName="EditData" UniqueName="EditData" ButtonType="ImageButton">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Photos.png" CommandName="Photos" UniqueName="Photos" ButtonType="ImageButton">
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
                    <telerik:RadWindow ID="AddBasicData_model" runat="server" Width="550px" VisibleStatusbar="False"
                        Modal="true" VisibleTitlebar="false" Behaviors="None">
                    </telerik:RadWindow>
                </Windows>
                <Windows>
                    <telerik:RadWindow ID="Villa_model" runat="server" Width="1024px" Height="680px" VisibleStatusbar="false"
                        Modal="true" VisibleTitlebar="false" Behaviors="None">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
        </div>
    </div>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_ProvincesList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_ProvincesSELECTALL" SelectCommandType="StoredProcedure" />

    <asp:SqlDataSource runat="server" ID="SqlDataSource_CityList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_CitySELECTALL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="VillaProvinceComboBox" PropertyName="SelectedValue" Name="ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_VillageList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_VillageSELECTALL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="VillaCityComboBox" PropertyName="SelectedValue" Name="ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_Villa"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_VillaSELECTALL" SelectCommandType="StoredProcedure" />

</asp:Content>
