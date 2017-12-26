<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="FlatManagement.aspx.vb" Inherits="RealEstateManagementSystem.FlatManagement" %>

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
                    <asp:Label ID="HeaderLabel" runat="server" Text="Flat" />
                </div>
                <div class="col-row">
                    <div class="col-8 col-push-10">
                        <div class="col-5">
                            <div class="sg-blockcontent">
                                <div class="col-10 sg-label">
                                    <asp:Label ID="FlatNameLabel" runat="server" AssociatedControlID="FlatNameRadTextBox" Text="Name" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadTextBox ID="FlatNameRadTextBox" runat="server" Width="100%" TabIndex="1" ToolTip="Name" />
                                    <asp:RequiredFieldValidator ID="FlatNameRequired" runat="server" CssClass="field-validation-error" ControlToValidate="FlatNameRadTextBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="FlatCompanyNameLabel" runat="server" AssociatedControlID="FlatCompanyNameRadTextBox" Text="Company Name" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="FlatCompanyNameRadTextBox" runat="server" TabIndex="3" ToolTip="Company Name" Width="100%" />
                                </div>
                                <div class="col-5 sg-label">
                                    <asp:Label ID="FlatProvinceLabel" runat="server" AssociatedControlID="FlatProvinceComboBox" Text="Province" />
                                </div>
                                <div class="col-5 sg-label sg-text-align-right">
                                    <asp:LinkButton ID="AddnewProvince" runat="server" Text="Add New Province" Height="50%" OnClick="AddnewProvince_Click" OnOwnerClick="openRadWindow" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="FlatProvinceComboBox" runat="server" TabIndex="5" ToolTip="Select the Province" AppendDataBoundItems="True" AutoPostBack="true" EmptyMessage=" --Select-- "
                                        CausesValidation="False" MarkFirstMatch="True" Width="100%" DataSourceID="SqlDataSource_ProvincesList" DataTextField="ProvinceName" DataValueField="ID" OnSelectedIndexChanged="FlatProvinceComboBox_SelectedIndexChanged" />
                                    <asp:RequiredFieldValidator ID="FlatProvinceRequired" runat="server" CssClass="field-validation-error" ControlToValidate="FlatProvinceComboBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
                                </div>
                                <div class="col-5 sg-label">
                                    <asp:Label ID="FlatVillageLabel" runat="server" AssociatedControlID="FlatVillageComboBox" Text="Village" />
                                </div>
                                <div class="col-5 sg-label sg-text-align-right">
                                    <asp:LinkButton ID="addnewVillage" runat="server" Text="Add New Village" OnClick="addnewVillage_Click" Height="50%" OnOwnerClick="openRadWindow" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="FlatVillageComboBox" runat="server" TabIndex="7" ToolTip="Select the Village" AppendDataBoundItems="True" AutoPostBack="true" EmptyMessage=" --Select-- "
                                        CausesValidation="False" MarkFirstMatch="True" Width="100%" DataSourceID="SqlDataSource_VillageList" DataTextField="VillageName" DataValueField="ID" />
                                    <asp:RequiredFieldValidator ID="FlatVillageRequired" runat="server" CssClass="field-validation-error" ControlToValidate="FlatVillageComboBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="FlatRoomNoLabel" runat="server" AssociatedControlID="FlatRoomNoTextBox" Text="No.of Rooms" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="FlatRoomNoTextBox" runat="server" TabIndex="9" ToolTip="no.of Rooms" Width="100%" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="FlatBathRoomTypeLabel" runat="server" AssociatedControlID="FlatBathRoomTypeComboBox" Text="BathRoom Type" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadComboBox ID="FlatBathRoomTypeComboBox" runat="server" TabIndex="11" ToolTip="Select Bathroom type" CausesValidation="False" Width="100%" MaxHeight="200px" MarkFirstMatch="True"
                                        ItemRequestTimeout="0" DropDownAutoWidth="Disabled">
                                        <Items>
                                            <telerik:RadComboBoxItem runat="server" Text="Room Attached" Value="Room Attached" />
                                            <telerik:RadComboBoxItem runat="server" Text="Common" Value="Common" />
                                            <telerik:RadComboBoxItem runat="server" Text="Both" Value="Both" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="FlatAttachment1Label" runat="server" AssociatedControlID="FlatAttachmentUpload" Text="Attachments" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadAsyncUpload ID="FlatAttachmentUpload" runat="server" TabIndex="13" ToolTip="Upload the Attachments" MaxFileInputsCount="10" Skin="MetroTouch" MultipleFileSelection="Automatic" AllowedFileExtensions=".pdf,.jpeg,.jpg,.tif,.png,.gif,tiff,.bmp,.bpg" PostbackTriggers="SubmitButton" />
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="sg-blockcontent">
                                <div class="col-10 sg-label">
                                    <asp:Label ID="FlatOfficalNameLabel" runat="server" AssociatedControlID="FlatOfficalNameRadTextBox" Text="Offical Name" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="FlatOfficalNameRadTextBox" runat="server" TabIndex="2" ToolTip="Offical Name" Width="100%" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="FlatRentPriceLabel" runat="server" AssociatedControlID="FlatRentPriceRadTextBox" Text="Rent Price" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadNumericTextBox ID="FlatRentPriceRadTextBox" runat="server" Type="Currency" TabIndex="4" ToolTip="Enter the Rent Price" Width="100%">
                                        <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                    </telerik:RadNumericTextBox>
                                    <asp:RequiredFieldValidator ID="FlatrentPriceRequired" runat="server" CssClass="field-compare-error" ControlToValidate="FlatRentPriceRadTextBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
                                </div>
                                <div class="col-5 sg-label">
                                    <asp:Label ID="FlatCityLabel" runat="server" AssociatedControlID="FlatCityComboBox" Text="City" />
                                </div>
                                <div class="col-5 sg-label sg-text-align-right">
                                    <asp:LinkButton ID="AddnewCity" runat="server" Text="Add New City" OnClick="AddnewCity_Click" Height="50%" OnOwnerClick="openRadWindow" />
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadComboBox ID="FlatCityComboBox" runat="server" TabIndex="6" ToolTip="Select the City name" AppendDataBoundItems="True" AutoPostBack="true" EmptyMessage=" --Select-- "
                                        CausesValidation="False" MarkFirstMatch="True" Width="100%" OnSelectedIndexChanged="FlatCityComboBox_SelectedIndexChanged" DataSourceID="SqlDataSource_CityList" DataTextField="CityName" DataValueField="ID" />
                                    <asp:RequiredFieldValidator ID="FlatCityRequired" runat="server" CssClass="field-validation-error" ControlToValidate="FlatCityComboBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="FlatPlaceLabel" runat="server" AssociatedControlID="FlatPlaceRadTExtBox" Text="Place" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="FlatPlaceRadTExtBox" runat="server" TabIndex="8" ToolTip="Place" Width="100%" />
                                </div>
                                <div class="col-10 sg-label">
                                    <asp:Label ID="FlatBathroomNoLabel" runat="server" AssociatedControlID="FlatBathroomNoTextBox" Text="No.of BathRooms" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="FlatBathroomNoTextBox" runat="server" TabIndex="10" ToolTip="no.of Bathrooms" Width="100%" />
                                </div>

                                <div class="col-10 sg-label">
                                    <asp:Label ID="FlatMemoLabel" runat="server" AssociatedControlID="FlatMemoRadTextBox" Text="Memo" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadTextBox ID="FlatMemoRadTextBox" runat="server" TextMode="MultiLine" TabIndex="12" Height="115px" Width="100%" ToolTip="Memo" />
                                </div>
                            </div>
                        </div>
                        <div class="col-10 sg-button-right">
                            <telerik:RadButton ID="SubmitButton" runat="server" Text="Submit" TabIndex="13" ValidationGroup="FlatSubmit" CssClass="sg-button-submit" Width="150px" OnClick="SubmitButton_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-10  sg-radgrid">
                <telerik:RadGrid ID="FlatradGrid" runat="server" CssClass="sg-radgrid" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0"
                    DataSourceID="SqlDataSource_Flat" OnItemDataBound="FlatradGrid_ItemDataBound" OnItemCommand="FlatradGrid_ItemCommand" GridLines="None" AllowAutomaticUpdates="true">
                    <MasterTableView DataKeyNames="" DataSourceID="SqlDataSource_Flat" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                            <telerik:GridBoundColumn DataField="FlatName" FilterControlWidth="100%" FilterControlAltText="Filter FlatName column" HeaderText="Name" SortExpression="FlatName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatName">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FlatCompanyName" FilterControlWidth="100%" FilterControlAltText="Filter FlatCompanyName column" HeaderText="Company Name" SortExpression="FlatCompanyName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatCompanyName">
                                <HeaderStyle HorizontalAlign="Center" Width="100px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FlatRentingPrice" FilterControlWidth="100%" FilterControlAltText="Filter FlatRentingPrice column" HeaderText="Rent Price" SortExpression="FlatRentingPrice"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatRentingPrice">
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
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatVillage">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FlatPlace" FilterControlWidth="100%" FilterControlAltText="Filter FlatPlace column" HeaderText="Place" SortExpression="FlatPlace"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatPlace">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FlatRoomNumber" FilterControlWidth="100%" FilterControlAltText="Filter FlatRoomNumber column" HeaderText="Room NO" SortExpression="FlatRoomNumber"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatRoomNumber">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FlatBathroomNumber" FilterControlWidth="100%" FilterControlAltText="Filter FlatBathroomNumber column" HeaderText="Bathroom NO" SortExpression="FlatBathroomNumber"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatBathroomNumber">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FlatBathroomType" FilterControlWidth="100%" FilterControlAltText="Filter FlatBathroomType column" HeaderText="Bathroom Type" SortExpression="FlatBathroomType"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatBathroomType">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Edit.png" CommandName="EditData" UniqueName="EditData" ButtonType="ImageButton">
                                <HeaderStyle HorizontalAlign="Center" Width="70px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
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
                    <telerik:RadWindow ID="Flat_model" runat="server" Width="1024px" Height="680px" VisibleStatusbar="false"
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
            <asp:ControlParameter ControlID="FlatProvinceComboBox" PropertyName="SelectedValue" Name="ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_VillageList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_VillageSELECTALL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="FlatCityComboBox" PropertyName="SelectedValue" Name="ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource_Flat" runat="server"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_FlatSELECTALL" SelectCommandType="StoredProcedure" />
</asp:Content>
