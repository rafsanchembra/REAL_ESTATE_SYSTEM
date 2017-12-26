<%@ Page Language="vb" MasterPageFile="~/Content/HomeMaster.Master" AutoEventWireup="false" CodeBehind="FreeLandManagement.aspx.vb" Inherits="RealEstateManagementSystem.FreeLandManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <script>
        function closeRadWindow() {
            $find("<%= RadAjaxManagerMain.ClientID %>").ajaxRequest();
        }
        function CloseWindow() {
            var oWindow = GetRadWindow();
            oWindow.argument = null;
            oWindow.close();
            return false;
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
                    <asp:Label ID="HeaderLabel" runat="server" Text="Free Land" />
                </div>
                <div class="col-row">
                    <div class="col-8 col-push-10">
                    <div class="col-5">
                        <div class="sg-blockcontent">
                            <div class="col-10 sg-label">
                                <asp:Label ID="FreelandNameLabel" runat="server" AssociatedControlID="FreeLandNameRadTextBox" Text="Name" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="FreeLandNameRadTextBox" runat="server" Width="100%" TabIndex="1" ToolTip="Name" />
                                <asp:RequiredFieldValidator ID="FreeLandNameRequired" runat="server" ControlToValidate="FreeLandNameRadTextBox" ValidationGroup="FreeLandSubmit" EnableClientScript="true" CssClass="field-validation-error" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="FreelandCompanyNameLabel" runat="server" AssociatedControlID="FreeLandCompanyNameRadTextBox" Text="Company Name" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="FreeLandCompanyNameRadTextBox" runat="server" TabIndex="3" ToolTip="Company Name" Width="100%" />
                            </div>
                            <div class="col-5 sg-label">
                                <asp:Label ID="FreelandProvinceLabel" runat="server" AssociatedControlID="FreelandProvinceComboBox" Text="Province" />
                            </div>
                            <div class="col-5 sg-label sg-text-align-right">
                                <asp:LinkButton ID="AddnewProvince" runat="server" Text="Add New Province" OnClick="AddnewProvince_Click" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="FreelandProvinceComboBox" runat="server" AutoPostBack="true" TabIndex="5" ToolTip="Select the Province" ItemRequestTimeout="0" EmptyMessage=" --Select-- " Filter="Contains"
                                    CausesValidation="false"  MarkFirstMatch="True"  Width="100%" OnSelectedIndexChanged="FreelandProvinceComboBox_SelectedIndexChanged" DataSourceID="SqlDataSource_ProvincesList" DataTextField="ProvinceName" DataValueField="ID" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="FreelandProvinceComboBox" ValidationGroup="FreeLandSubmit" EnableClientScript="true" CssClass="field-validation-error" />
                            </div>
                            <div class="col-5 sg-label">
                                <asp:Label ID="FreelandVillageLabel" runat="server" AssociatedControlID="FreelandVillageComboBox" Text="Village" />
                            </div>
                            <div class="col-5 sg-label sg-text-align-right">
                                <asp:LinkButton ID="addnewVillage" runat="server" Text="Add New Village" OnClick="addnewVillage_Click" Height="50%" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="FreelandVillageComboBox" runat="server" TabIndex="7" ToolTip="Select the Village" AppendDataBoundItems="True" AutoPostBack="true" EmptyMessage=" --Select-- "
                                    CausesValidation="False" MarkFirstMatch="True" Width="100%" DataSourceID="SqlDataSource_VillageList" DataTextField="VillageName" DataValueField="ID" />
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="FreelandVillageComboBox" ValidationGroup="FreeLandSubmit" EnableClientScript="true" CssClass="field-validation-error" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="FreelandMemoLabel" runat="server" AssociatedControlID="FreelandMemoRadTextBox" Text="Memo" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="FreelandMemoRadTextBox" runat="server" TextMode="MultiLine" TabIndex="9" Height="90px" Width="100%" ToolTip="Memo" />
                            </div>
                        </div>
                    </div>
                    <div class="col-5">
                        <div class="sg-blockcontent">
                            <div class="col-10 sg-label">
                                <asp:Label ID="FreeLandOfficalNameLabel" runat="server" AssociatedControlID="FreeLandOfficalNameRadTextBox" Text="Offical Name" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="FreeLandOfficalNameRadTextBox" runat="server" TabIndex="2" ToolTip="Offical Name" Width="100%" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="FreelandRentPriceLabel" runat="server" AssociatedControlID="FreeLandRentingPriceTextBox" Text="Rent Price" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadNumericTextBox ID="FreeLandRentingPriceTextBox" TabIndex ="4" runat="server" Type="Currency" Width="100%" ToolTip="Enter the Rent Price">
                                    <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="FreeLandrentPriceRequired" runat="server" ControlToValidate="FreeLandRentingPriceTextBox" ValidationGroup="FreeLandSubmit" CssClass="field-validation-error" EnableClientScript="true" />
                            </div>
                            <div class="col-5 sg-label">
                                <asp:Label ID="FreelandCityLabel" runat="server" AssociatedControlID="FreelandCityComboBox" Text="City" />
                            </div>
                            <div class="col-5 sg-label sg-text-align-right">
                                <asp:LinkButton ID="AddnewCity" runat="server" Text="Add New City" OnClick="AddnewCity_Click" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="FreelandCityComboBox" runat="server" TabIndex="6" ToolTip="Select the City name" AppendDataBoundItems="True" AutoPostBack="true" EmptyMessage=" --Select-- "
                                    CausesValidation="False" MarkFirstMatch="True" Width="100%" OnSelectedIndexChanged="FreelandCityComboBox_SelectedIndexChanged" DataSourceID="SqlDataSource_CityList" DataTextField="CityName" DataValueField="ID" />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="FreelandCityComboBox" ValidationGroup="FreeLandSubmit" CssClass="field-validation-error" EnableClientScript="true" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="FreelandPlaceLabel" runat="server" AssociatedControlID="FreelandPlaceRadTExtBox" Text="Place" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="FreelandPlaceRadTExtBox" runat="server" TabIndex="8" ToolTip="Place" Width="100%" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="FreeLandAttachment1Label" runat="server" AssociatedControlID="FreeLandAttachmentUpload" Text="Attachments" />
                            </div>
                            <div class="col-10">
                                <telerik:RadAsyncUpload ID="FreeLandAttachmentUpload" runat="server" TabIndex="10" ToolTip="Upload the Attachments" MaxFileInputsCount="10" Skin="MetroTouch" MultipleFileSelection="Automatic" AllowedFileExtensions=".pdf,.jpeg,.jpg,.tif,.png,.gif,tiff,.bmp,.bpg" PostbackTriggers="SubmitButton" />
                            </div>
                            <div class="col-10 sg-button-right">
                                <telerik:RadButton ID="SubmitButton" runat="server" Text="Submit" CssClass="sg-button-submit" TabIndex="11" Width="150px" ValidationGroup ="FreeLandSubmit" OnClick="SubmitButton_Click" />
                            </div>
                        </div>
                    </div>
</div>
                </div>
            </div>

            <div class="col-10  sg-radgrid">
                <telerik:RadGrid ID="freeLandradGrid" runat="server" CssClass="sg-radgrid" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0"
                    DataSourceID="SqlDataSource_FreeLand" OnItemDataBound="freeLandradGrid_ItemDataBound" OnItemCommand="freeLandradGrid_ItemCommand" GridLines="None"
                      AllowAutomaticUpdates="true">
                    <MasterTableView DataKeyNames="" DataSourceID="SqlDataSource_FreeLand" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                            <telerik:GridBoundColumn Display="false" DataField="ID" DataType="System.Int64" ReadOnly="true" UniqueName="ID" /> <%-- Uniques Name Should Not Be Repeated In A Grid --%>
                            <telerik:GridBoundColumn DataField="FreeLandName" FilterControlWidth="100%" FilterControlAltText="Filter FreeLandName column" HeaderText="Name" SortExpression="FreeLandName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FreeLandName">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FreeLandCompanyName" FilterControlWidth="100%" FilterControlAltText="Filter FreeLandCompanyName column" HeaderText="Company Name" SortExpression="FreeLandCompanyName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FreeLandCompanyName">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FreeLandRentingPrice" DataFormatString="{0:0.000 OMR}" FilterControlWidth="100%" FilterControlAltText="Filter FreeLandRentingPrice column" HeaderText="Rent Price" SortExpression="FreeLandRentingPrice"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FreeLandRentingPrice">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ProvinceName" FilterControlWidth="100%" FilterControlAltText="Filter ProvinceName column" HeaderText="Province" SortExpression="ProvinceName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ProvinceName">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CityName" FilterControlWidth="100%" FilterControlAltText="Filter CityName column" HeaderText="City" SortExpression="CityName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="CityName">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VillageName" FilterControlWidth="100%" FilterControlAltText="Filter VillageName column" HeaderText="Village" SortExpression="VillageName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="VillageName">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FreeLandPlace" FilterControlWidth="100%" FilterControlAltText="Filter FreeLandPlace column" HeaderText="Place" SortExpression="FreeLandPlace"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FreeLandPlace">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
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
                        Modal="true" VisibleTitlebar="false" Behaviors="None" >
                    </telerik:RadWindow>
                </Windows>
                <Windows>
                    <telerik:RadWindow ID="FreeLand_model" runat="server" Width="1024px" Height="680px" VisibleStatusbar="false"
                        Modal="true" VisibleTitlebar="false" Behaviors="None" >
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
            <asp:ControlParameter ControlID="FreelandProvinceComboBox" PropertyName="SelectedValue" Name="ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_VillageList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_VillageSELECTALL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="FreelandCityComboBox" PropertyName="SelectedValue" Name="ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource_FreeLand" runat="server"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_FreeLandSELECTALL" SelectCommandType="StoredProcedure" />
</asp:Content>
