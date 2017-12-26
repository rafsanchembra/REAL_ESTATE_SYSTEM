<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="BuildingManagement.aspx.vb" Inherits="RealEstateManagementSystem.BuildingManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="headerPlaceHolderLabel" runat="server" Text="Multi Floor Building Add" />
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
                    <div class="col-10">
                        <div class="col-7">
                            <telerik:RadTabStrip ID="BuildingTabStrip" runat="server" MultiPageID="BuildingMultiPage" Orientation="HorizontalTop" SelectedIndex="0">
                                <Tabs>
                                    <telerik:RadTab Text="General" Value="GeneralDetails" runat="server" Selected="true" />
                                    <telerik:RadTab Text="Flat" Value="FlatDetails" runat="server" Enabled="false" />
                                    <telerik:RadTab Text="Shop" Value="ShopDetails" runat="server" Enabled="false" />
                                    <telerik:RadTab Text="Office" Value="OfficeDetails" runat="server" Enabled="false" />
                                </Tabs>
                            </telerik:RadTabStrip>
                        </div>
                        <div class="col-3 sg-button-right">

                            <telerik:RadButton ID="ClearTabButton" runat="server" Text="Clear Tab Data" CssClass="sg-button-cancel" Width="150px" OnClick="ClearTabButton_Click" OnClientClicking="function (sender, args){args.set_cancel(!window.confirm('Are You Sure To Clear Current Tab Data ?'));}" />
                            <telerik:RadButton ID="ClearAllButton" runat="server" Text="Clear All Data" CssClass="sg-button-cancel" Width="150px" OnClick="ClearAllButton_Click" OnClientClicking="function (sender, args){args.set_cancel(!window.confirm('Are You Sure To Clear All Data ?'));}" />
                        </div>
                    </div>
                    <div class="col-10">
                        <div class="sg-blockcontent">
                            <telerik:RadMultiPage runat="server" ID="BuildingMultiPage" SelectedIndex="0">
                                <telerik:RadPageView runat="server" ID="GeneralPageView" Selected="True">

                                    <div class="col-10">
                                        <div class="col-row">
                                            <div class="col-8 col-push-10">
                                                <div class="col-5">
                                                    <div class="sg-blockcontent">
                                                        <div class="col-10 sg-label">
                                                            <asp:Label ID="MFBuildingNameLabel" runat="server" AssociatedControlID="BuildingNameRadTextBox" Text="Name" />
                                                        </div>
                                                        <div class="col-10">
                                                            <telerik:RadTextBox ID="BuildingNameRadTextBox" runat="server" Width="100%" ToolTip="Name" />
                                                            <asp:RequiredFieldValidator ID="BuildingNameRequired" runat="server" ControlToValidate="BuildingNameRadTextBox" ValidationGroup="BuildingSubmit" EnableClientScript="true" />
                                                        </div>
                                                        <div class="col-10 sg-label">
                                                            <asp:Label ID="BuildingOwnerLabel" runat="server" AssociatedControlID="BuildingOwnerComboBox" Text="Owner" />
                                                        </div>
                                                        <div class="col-10">
                                                            <telerik:RadComboBox runat="server" ID="BuildingOwnerComboBox" AppendDataBoundItems="True" CausesValidation="False"
                                                                CollapseDelay="10" DataMember="DefaultView" EnableTextSelection="true" EmptyMessage="--- Select ---" Filter="Contains"
                                                                Width="100%" MarkFirstMatch="True" DataSourceID="SqlDataSource_OwnerList" DataTextField="ContactName" DataValueField="ID">
                                                            </telerik:RadComboBox>
                                                            <asp:RequiredFieldValidator ID="BuildingOwnerRequired" runat="server" ControlToValidate="BuildingOwnerComboBox" ValidationGroup="BuildingSubmit" EnableClientScript="true" />
                                                        </div>
                                                        <div class="col-10 sg-label">
                                                            <asp:Label ID="BuildingContactStaffNameLabel" runat="server" AssociatedControlID="BuildingContactStaffNameTextBox" Text="Contact Staff Name" />
                                                        </div>
                                                        <div class="col-10">
                                                            <telerik:RadTextBox ID="BuildingContactStaffNameTextBox" runat="server" Width="100%" ToolTip="Contact Staff Name" />
                                                        </div>
                                                        <div class="col-10 sg-label">
                                                            <div class="col-5">
                                                                <asp:Label ID="BuildingAddressLabel" runat="server" AssociatedControlID="BuildingAddressTextBox" Text="Address" />
                                                            </div>
                                                            <div class="col-5 sg-button-right">
                                                                <asp:LinkButton ID="BuildingAddressLink" runat="server" Text="Get Address" OnClick="BuildingAddressLink_Click" />
                                                            </div>
                                                        </div>
                                                        <div class="col-10">
                                                            <telerik:RadTextBox ID="BuildingAddressTextBox" runat="server" Width="100%" ToolTip="Address" />
                                                            <asp:RequiredFieldValidator ID="BuildingAddressRequired" runat="server" ControlToValidate="BuildingAddressTextBox" ValidationGroup="BuildingSubmit" EnableClientScript="true" />
                                                        </div>
                                                        <div class="col-10">
                                                            <div class="col-5">
                                                                <div class="sg-blockcontent-right">
                                                                    <div class="col-10 sg-label">
                                                                        <asp:Label ID="BuildingFloorNoLabel" runat="server" AssociatedControlID="BuildingFloorNoRadTextBox" Text="Floors Number" />
                                                                    </div>
                                                                    <div class="col-10">
                                                                        <telerik:RadNumericTextBox ID="BuildingFloorNoRadTextBox" Value="0" MinValue="0" runat="server" Type="Number" Width="100%" ToolTip="Floor Number">
                                                                            <NumberFormat DecimalDigits="0" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-5">
                                                                <div class="sg-blockcontent-left">
                                                                    <div class="col-10 sg-label">
                                                                        <asp:Label ID="BuildingFlatNoLabel" runat="server" AssociatedControlID="BuildingFlatNoRadTextBox" Text="Flats Number" />
                                                                    </div>
                                                                    <div class="col-10">
                                                                        <telerik:RadNumericTextBox ID="BuildingFlatNoRadTextBox" Value="0" MinValue="0" runat="server" Type="Number" Width="100%" ToolTip="Flat Number">
                                                                            <NumberFormat DecimalDigits="0" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="col-5">
                                                    <div class="sg-blockcontent">
                                                        <div class="col-10 sg-label">
                                                            <asp:Label ID="BuildingOfficalNameLabel" runat="server" AssociatedControlID="BuildingOfficalNameRadTextBox" Text="Offical Name" />
                                                        </div>
                                                        <div class="col-10">
                                                            <telerik:RadTextBox ID="BuildingOfficalNameRadTextBox" runat="server" ToolTip="Offical Name" Width="100%" />
                                                        </div>
                                                        <div class="col-10">
                                                            <div class="col-5">
                                                                <div class="sg-blockcontent-right">

                                                                    <div class="col-10 sg-label">
                                                                        <asp:Label ID="BuildingCurrencyTypeLabel" runat="server" AssociatedControlID="BuildingCurrencyTypeComboBox" Text="Currency Type" />
                                                                    </div>
                                                                    <div class="col-10">
                                                                        <telerik:RadComboBox runat="server" ID="BuildingCurrencyTypeComboBox" AppendDataBoundItems="True" CausesValidation="False"
                                                                            CollapseDelay="10" DataMember="DefaultView" EnableTextSelection="true" EmptyMessage="--- Select ---" Filter="Contains" Height="500px"
                                                                            Width="100%" MarkFirstMatch="True" DataSourceID="SqlDataSource_CountryList" DataTextField="CurrencyCodeName" DataValueField="CurrencyCode" OnClientSelectedIndexChanged="CurrencyCodeSelected">
                                                                        </telerik:RadComboBox>
                                                                        <asp:RequiredFieldValidator ID="BuildingCurrencyTypeRequired" runat="server" ControlToValidate="BuildingCurrencyTypeComboBox" ValidationGroup="BuildingSubmit" EnableClientScript="true" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-5">
                                                                <div class="sg-blockcontent-left">
                                                                    <div class="col-10 sg-label">
                                                                        <asp:Label ID="BuildingRentPriceLabel" runat="server" AssociatedControlID="BuildingRentPriceRadTextBox" Text="Rent Price" />
                                                                    </div>
                                                                    <div class="col-10">
                                                                        <telerik:RadNumericTextBox ID="BuildingRentPriceRadTextBox" runat="server" Type="Currency" Width="100%" ToolTip="Enter the Rent Price">
                                                                            <NumberFormat DecimalDigits="3" AllowRounding="true" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-10 sg-label">
                                                            <asp:Label ID="BuildingContactStaffGSMLabel" runat="server" AssociatedControlID="BuildingContactStaffGSMTextBox" Text="Contact Staff GSM" />
                                                        </div>
                                                        <div class="col-10">
                                                            <div class="col-5">
                                                                <div class="sg-blockcontent-right">
                                                                    <telerik:RadComboBox runat="server" ID="BuildingContactStaffGSMContryCodeCombobox" AppendDataBoundItems="True" CausesValidation="False"
                                                                        CollapseDelay="10" DataMember="DefaultView" EnableTextSelection="true" EmptyMessage="--- Select ---" Filter="Contains" Height="500px"
                                                                        Width="100%" MarkFirstMatch="True" DataSourceID="SqlDataSource_CountryList" DataTextField="CountryCode" DataValueField="ID" OnClientSelectedIndexChanged="ContactGSMCountryOnClientSelected">
                                                                    </telerik:RadComboBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-5">
                                                                <div class="sg-blockcontent-left">
                                                                    <telerik:RadTextBox ID="BuildingContactStaffGSMTextBox" runat="server" Enabled="false" Width="100%" ToolTip="Building Contact Staff GSM" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-10">
                                                            <div class="col-5">
                                                                <div class="sg-blockcontent-right">
                                                                    <div class="col-10 sg-label">
                                                                        <asp:Label ID="BuildingGPSLabel" runat="server" AssociatedControlID="BuildingGPSTextBox" Text="GPS" />
                                                                    </div>
                                                                    <div class="col-10">
                                                                        <telerik:RadTextBox ID="BuildingGPSTextBox" ReadOnly="true" CssClass="GSMMargin" runat="server" ToolTip="GPS" Width="100%" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-5">
                                                                <div class="sg-blockcontent-left">
                                                                    <div class="col-10 sg-label">
                                                                        <div class="col-5">
                                                                            <asp:Label ID="BuildingMapUrlLabel" runat="server" AssociatedControlID="BuildingMapUrlTextBox" Text="Map URl" />
                                                                        </div>

                                                                        <div class="col-5 sg-button-right">
                                                                            <asp:LinkButton ID="BuildingMapURLCopyLink" runat="server" href="#" Text="Copy" />
                                                                        </div>

                                                                    </div>
                                                                    <div class="col-10">
                                                                        <telerik:RadTextBox ID="BuildingMapUrlTextBox" ReadOnly="true" runat="server" ToolTip="Map URL" Width="100%" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-10">
                                                            <div class="col-5">
                                                                <div class="sg-blockcontent-right">
                                                                    <div class="col-10 sg-label">
                                                                        <asp:Label ID="BuildingShopNoLabel" runat="server" AssociatedControlID="BuildingShopNoRadTextBox" Text="Shops Number" />
                                                                    </div>
                                                                    <div class="col-10">
                                                                        <telerik:RadNumericTextBox ID="BuildingShopNoRadTextBox" Value="0" MinValue="0" runat="server" Type="Number" Width="100%" ToolTip="Shops Number">
                                                                            <NumberFormat DecimalDigits="0" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-5">
                                                                <div class="sg-blockcontent-left">
                                                                    <div class="col-10 sg-label">
                                                                        <asp:Label ID="BuildingOfficeNoLabel" runat="server" AssociatedControlID="BuildingOfficeNoTextBox" Text="Office Number" />
                                                                    </div>
                                                                    <div class="col-10">
                                                                        <telerik:RadNumericTextBox ID="BuildingOfficeNoTextBox" Value="0" MinValue="0" runat="server" Type="Number" Width="100%" ToolTip="Office Number">
                                                                            <NumberFormat DecimalDigits="0" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>


                                                    </div>
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="BuildingMemoLabel" runat="server" AssociatedControlID="BuildingMemoRadTextBox" Text="Memo" />
                                                </div>
                                                <div class="col-10">
                                                    <telerik:RadTextBox ID="BuildingMemoRadTextBox" runat="server" TextMode="MultiLine" Height="120px" Width="100%" ToolTip="Memo" />
                                                </div>
                                                <div class="col-10 sg-header">
                                                    <asp:Label ID="BuildingAttachmentLabel" runat="server" AssociatedControlID="BuildingAttachmentTempRadGrid" Text="Attachment" />
                                                </div>
                                                <div class="col-10  sg-radgrid">
                                                    <telerik:RadGrid ID="BuildingAttachmentTempRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" AllowMultiRowSelection="true"
                                                        DataSourceID="SqlDataSource_BuildingAttachmentTemp" OnItemDataBound="BuildingAttachmentTempRadGrid_ItemDataBound" OnItemCommand="BuildingAttachmentTempRadGrid_ItemCommand" AllowAutomaticDeletes="true">
                                                        <MasterTableView DataKeyNames="ID" Name="GeneralAttachment" DataSourceID="SqlDataSource_BuildingAttachmentTemp" CommandItemDisplay="Top" AllowPaging="true" PageSize="5">
                                                            <CommandItemSettings AddNewRecordText="Add New Record" ShowRefreshButton="false" />
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
                                                                <telerik:GridBoundColumn Display="false" DataField="BuildingAttachment" ReadOnly="true" UniqueName="BuildingAttachment" />
                                                                <telerik:GridBoundColumn DataField="BuildingAttachmentName" FilterControlWidth="100%" FilterControlAltText="Filter BuildingAttachmentName column" HeaderText="Attachment Name" SortExpression="AttachmentName"
                                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BuildingAttachmentName">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridHyperLinkColumn DataNavigateUrlFields="BuildingAttachment" DataNavigateUrlFormatString="{0}" AllowFiltering="false"
                                                                    ShowFilterIcon="false" Text="View" Target="_blank" ImageUrl="~/Content/css/MeStyle/Grid/photo-color.png" UniqueName="View">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridHyperLinkColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridButtonColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Delete.png" CommandName="Delete" UniqueName="Delete" ButtonType="ImageButton">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridButtonColumn>
                                                                <telerik:GridClientSelectColumn UniqueName="Download" HeaderText="Download">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridClientSelectColumn>
                                                            </Columns>
                                                            <PagerStyle AlwaysVisible="True" Mode="NextPrevNumericAndAdvanced" />
                                                        </MasterTableView>
                                                        <ClientSettings>
                                                            <Selecting AllowRowSelect="True"></Selecting>
                                                            <ClientEvents OnRowSelecting="RowSelecting" />
                                                        </ClientSettings>
                                                        <FilterItemStyle HorizontalAlign="Center" />
                                                        <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Bottom" AlwaysVisible="true" />
                                                        <FilterMenu EnableImageSprites="False" EnableSelection="True" />
                                                    </telerik:RadGrid>
                                                    <div class="col-10 sg-label-right">
                                                        <telerik:RadButton ID="GeneralDownloadButton" Target="_blank" Width="120px" Text="Download All" CssClass="sg-button-submit" CommandName="GeneralDownload" OnClick="GeneralDownloadButton_Click" runat="server" />
                                                        <telerik:RadButton ID="GeneralSelectDownloadButton" Enabled="false" Width="200px" Text="Download Selected Files" CssClass="sg-button-submit" CommandName="GeneralDownload" OnClick="GeneralSelectDownloadButton_Click" runat="server" OnClientClicking="SelectCount" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-10 sg-button-right">
                                            <telerik:RadButton ID="GeneralSubmitButton" runat="server" Text="Next" CssClass="sg-button-submit" ValidationGroup="BuildingSubmit" Width="150px" OnClientClicked="BuildingValidateOnSubmit" OnClick="GeneralSubmitButton_Click" />

                                        </div>
                                    </div>
                                </telerik:RadPageView>
                                <telerik:RadPageView runat="server" ID="FlatPageView">
                                    <div class="col-10">
                                        <div class="col-row">
                                            <div class="col-8 col-push-10">
                                                <div class="col-10 sg-header">
                                                    <asp:Label ID="FlatHeaderLabel" runat="server" />
                                                </div>
                                                <div class="col-10">
                                                    <div class="col-33">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="FlatFloorLabel" runat="server" AssociatedControlID="FlatFloorComboBox" Text="Flat Floor No" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadComboBox runat="server" ID="FlatFloorComboBox" AppendDataBoundItems="True" CausesValidation="False"
                                                                    CollapseDelay="10" DataMember="DefaultView" EnableTextSelection="true" EmptyMessage="--- Select ---" Filter="Contains"
                                                                    Width="100%" MarkFirstMatch="false" EnableLoadOnDemand="true" OnItemsRequested="FloorFlatComboBox_ItemsRequested">
                                                                </telerik:RadComboBox>
                                                                <asp:RequiredFieldValidator ID="FlatFloorRequired" runat="server" ControlToValidate="FlatFloorComboBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-33">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="FlatNameLabel" runat="server" AssociatedControlID="FlatNameTextBox" Text="Flat Name" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadTextBox ID="FlatNameTextBox" runat="server" Width="100%" ToolTip="Flat Name" />
                                                                <asp:RequiredFieldValidator ID="FlatNameRequired" runat="server" ControlToValidate="FlatNameTextBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-33">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="FlatNumberLabel" runat="server" AssociatedControlID="FlatNumberTextBox" Text="Flat Number" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadTextBox ID="FlatNumberTextBox" runat="server" Width="100%" ToolTip="Flat Number" />
                                                                <asp:RequiredFieldValidator ID="FlatNumberRequired" runat="server" ControlToValidate="FlatNumberTextBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-10">
                                                    <div class="col-5">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="FlatAttachmentLabel" runat="server" AssociatedControlID="FlatAttachmentTempRadGrid" Text="Flat Attachment" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadGrid ID="FlatAttachmentTempRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" AllowMultiRowSelection="true"
                                                                    DataSourceID="SqlDataSource_FlatAttachmentTemp" OnItemDataBound="FlatAttachmentTempRadGrid_ItemDataBound" OnItemCommand="FlatAttachmentTempRadGrid_ItemCommand" AllowAutomaticDeletes="true" CellSpacing="-1" GridLines="Both">
                                                                    <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_FlatAttachmentTemp" Name="FlatAttachment" CommandItemDisplay="Top" AllowPaging="true" PageSize="5">
                                                                        <CommandItemSettings AddNewRecordText="Add New Record" ShowRefreshButton="false" />
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
                                                                            <telerik:GridBoundColumn Display="false" DataField="BuildingAttachment" ReadOnly="true" UniqueName="BuildingAttachment" />
                                                                            <telerik:GridBoundColumn DataField="BuildingAttachmentName" FilterControlWidth="100%" FilterControlAltText="Filter BuildingAttachmentName column" HeaderText="Attachment Name" SortExpression="AttachmentName"
                                                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BuildingAttachmentName">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="BuildingAttachment" DataNavigateUrlFormatString="{0}" AllowFiltering="false"
                                                                                ShowFilterIcon="false" Text="View" Target="_blank" ImageUrl="~/Content/css/MeStyle/Grid/photo-color.png" UniqueName="View">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridHyperLinkColumn>
                                                                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridButtonColumn>
                                                                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Delete.png" CommandName="Delete" UniqueName="Delete" ButtonType="ImageButton">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridButtonColumn>
                                                                            <telerik:GridClientSelectColumn UniqueName="Download" HeaderText="Download">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridClientSelectColumn>
                                                                        </Columns>
                                                                        <PagerStyle AlwaysVisible="True" Mode="NextPrevNumericAndAdvanced" />
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="True"></Selecting>
                                                                        <ClientEvents OnRowSelecting="RowSelecting" />
                                                                    </ClientSettings>
                                                                    <FilterItemStyle HorizontalAlign="Center" />
                                                                    <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Bottom" AlwaysVisible="true" />
                                                                    <FilterMenu EnableImageSprites="False" EnableSelection="True" />
                                                                </telerik:RadGrid>
                                                                <div class="col-10 sg-label-right">
                                                                    <telerik:RadButton ID="FlatDownloadButton" Target="_blank" Width="120px" Text="Download All" CssClass="sg-button-submit" CommandName="FlatDownload" OnClick="FlatDownloadButton_Click" runat="server" />
                                                                    <telerik:RadButton ID="FlatSelectDownloadButton" Enabled="false" Width="200px" Text="Download Selected Files" CssClass="sg-button-submit" CommandName="FlatDownload" OnClick="FlatSelectDownloadButton_Click" runat="server" OnClientClicking="SelectCount" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="col-5">

                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="FlatDescriptionLabel" runat="server" AssociatedControlID="FlatDescriptionEditor" Text="Flat Description" />
                                                            </div>

                                                            <div class="col-10">
                                                                <telerik:RadEditor runat="server" ID="FlatDescriptionEditor" ContentAreaMode="Div" Width="100%" EditModes="Design" Height="362px"
                                                                    EditType="Normal" ToolbarMode="ShowOnFocus">
                                                                    <Modules>
                                                                        <telerik:EditorModule Name="RadEditorHtmlInspector" Enabled="false" Visible="false" />
                                                                        <telerik:EditorModule Name="RadEditorNodeInspector" Enabled="false" Visible="false" />
                                                                        <telerik:EditorModule Name="RadEditorDomInspector" Enabled="false" />
                                                                        <telerik:EditorModule Name="RadEditorStatistics" Enabled="false" />
                                                                    </Modules>
                                                                </telerik:RadEditor>
                                                            </div>
                                                            <div class="col-10 sg-button-right">
                                                                <telerik:RadButton ID="FlatSubmitButton" runat="server" ValidationGroup="FlatSubmit" CssClass="sg-button-submit" Width="150px" OnClientClicked="FlatValidateOnSubmit" OnClick="FlatSubmitButton_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="sg-header">
                                                    <asp:Label ID="FlatListHeaderLabel" runat="server" Text="Flat List" />
                                                </div>
                                                <div class="col-10  sg-radgrid">
                                                    <telerik:RadGrid ID="FlatTempRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                                                        DataSourceID="SqlDataSource_FlatTemp" OnItemDataBound="FlatTempRadGrid_ItemDataBound" OnItemCommand="FlatTempRadGrid_ItemCommand">
                                                        <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_FlatTemp" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                                                <telerik:GridBoundColumn DataField="FloorName" FilterControlWidth="100%" FilterControlAltText="Filter FloorName column" HeaderText="Floor Name" SortExpression="FloorName"
                                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FloorName">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="FlatNumber" FilterControlWidth="100%" FilterControlAltText="Filter FlatNumber column" HeaderText="Flat Number" SortExpression="FlatNumber"
                                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatNumber">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="FlatName" FilterControlWidth="100%" FilterControlAltText="Filter FlatName column" HeaderText="Flat Name" SortExpression="FlatName"
                                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FlatName">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/photo-color.png" CommandName="ViewAttachment" HeaderText="View Attachment" UniqueName="ViewAttachment" ButtonType="ImageButton">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridButtonColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" HeaderText="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridButtonColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Delete.png" CommandName="Delete" HeaderText="Delete" UniqueName="Delete" ButtonType="ImageButton">
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
                                            <div class="col-5 sg-button-left">
                                                <telerik:RadButton ID="FlatPreviousButton" runat="server" Text="Previous" CssClass="sg-button-submit" OnClientClicked="previousTab" AutoPostBack="false" Width="150px" />
                                            </div>
                                            <div class="col-5 sg-button-right">
                                                <telerik:RadButton ID="FlatNextButton" runat="server" Text="Next" CssClass="sg-button-submit" Width="150px" OnClick="FlatNextButton_Click" />
                                            </div>
                                        </div>

                                    </div>
                                </telerik:RadPageView>
                                <telerik:RadPageView runat="server" ID="ShopPageView">
                                    <div class="col-10">
                                        <div class="col-row">
                                            <div class="col-8 col-push-10">
                                                <div class="col-10 sg-header">
                                                    <asp:Label ID="ShopHeaderLabel" runat="server" />
                                                </div>
                                                <div class="col-10">
                                                    <div class="col-33">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="ShopFloorLabel" runat="server" AssociatedControlID="ShopFloorComboBox" Text="Shop Floor No" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadComboBox runat="server" ID="ShopFloorComboBox" AppendDataBoundItems="True" CausesValidation="False"
                                                                    CollapseDelay="10" DataMember="DefaultView" EnableTextSelection="true" EmptyMessage="--- Select ---" Filter="Contains"
                                                                    Width="100%" MarkFirstMatch="false" EnableLoadOnDemand="true" OnItemsRequested="ShopFloorComboBox_ItemsRequested">
                                                                </telerik:RadComboBox>
                                                                <asp:RequiredFieldValidator ID="ShopFloorRequired" runat="server" ControlToValidate="ShopFloorComboBox" ValidationGroup="ShopSubmit" EnableClientScript="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-33">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="ShopNameLabel" runat="server" AssociatedControlID="ShopNameTextBox" Text="Shop Name" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadTextBox ID="ShopNameTextBox" runat="server" Width="100%" ToolTip="Shop Name" />
                                                                <asp:RequiredFieldValidator ID="ShopNameRequired" runat="server" ControlToValidate="ShopNameTextBox" ValidationGroup="ShopSubmit" EnableClientScript="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-33">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="ShopNumberLabel" runat="server" AssociatedControlID="ShopNumberTextBox" Text="Shop Number" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadTextBox ID="ShopNumberTextBox" runat="server" Width="100%" ToolTip="Shop Number" />
                                                                <asp:RequiredFieldValidator ID="ShopNumberRequired" runat="server" ControlToValidate="ShopNumberTextBox" ValidationGroup="ShopSubmit" EnableClientScript="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-10">
                                                    <div class="col-5">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="ShopAttachmentLabel" runat="server" AssociatedControlID="ShopAttachmentTempRadGrid" Text="Shop Attachment" />
                                                            </div>
                                                            <div class="col-10 ">
                                                                <telerik:RadGrid ID="ShopAttachmentTempRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" AllowMultiRowSelection="true"
                                                                    DataSourceID="SqlDataSource_ShopAttachmentTemp" OnItemDataBound="ShopAttachmentTempRadGrid_ItemDataBound" OnItemCommand="ShopAttachmentTempRadGrid_ItemCommand" AllowAutomaticDeletes="true">
                                                                    <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_ShopAttachmentTemp" Name="ShopAttachment" CommandItemDisplay="Top" AllowPaging="true" PageSize="5">
                                                                        <CommandItemSettings AddNewRecordText="Add New Record" ShowRefreshButton="false" />
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
                                                                            <telerik:GridBoundColumn Display="false" DataField="BuildingAttachment" ReadOnly="true" UniqueName="BuildingAttachment" />
                                                                            <telerik:GridBoundColumn DataField="BuildingAttachmentName" FilterControlWidth="100%" FilterControlAltText="Filter BuildingAttachmentName column" HeaderText="Attachment Name" SortExpression="AttachmentName"
                                                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BuildingAttachmentName">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="BuildingAttachment" DataNavigateUrlFormatString="{0}" AllowFiltering="false"
                                                                                ShowFilterIcon="false" Text="View" Target="_blank" ImageUrl="~/Content/css/MeStyle/Grid/photo-color.png" UniqueName="View">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridHyperLinkColumn>
                                                                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridButtonColumn>
                                                                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Delete.png" CommandName="Delete" UniqueName="Delete" ButtonType="ImageButton">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridButtonColumn>
                                                                            <telerik:GridClientSelectColumn UniqueName="Download" HeaderText="Download">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridClientSelectColumn>
                                                                        </Columns>
                                                                        <PagerStyle AlwaysVisible="True" Mode="NextPrevNumericAndAdvanced" />
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="True"></Selecting>
                                                                        <ClientEvents OnRowSelecting="RowSelecting" />
                                                                    </ClientSettings>
                                                                    <FilterItemStyle HorizontalAlign="Center" />
                                                                    <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Bottom" AlwaysVisible="true" />
                                                                    <FilterMenu EnableImageSprites="False" EnableSelection="True" />
                                                                </telerik:RadGrid>
                                                                <div class="col-10 sg-label-right">
                                                                    <telerik:RadButton ID="ShopDownloadButton" Target="_blank" Width="120px" Text="Download All" CssClass="sg-button-submit" CommandName="ShopDownload" OnClick="ShopDownloadButton_Click" runat="server" />
                                                                    <telerik:RadButton ID="ShopSelectDownloadButton" Enabled="false" Width="200px" Text="Download Selected Files" CssClass="sg-button-submit" CommandName="ShopDownload" OnClick="ShopSelectDownloadButton_Click" runat="server" OnClientClicking="SelectCount" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="col-5">

                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="Label" runat="server" AssociatedControlID="ShopDescriptionEditor" Text="Shop Description" />
                                                            </div>

                                                            <div class="col-10">
                                                                <telerik:RadEditor runat="server" ID="ShopDescriptionEditor" ContentAreaMode="Div" Width="100%" EditModes="Design" Height="362px"
                                                                    EditType="Normal" ToolbarMode="ShowOnFocus">
                                                                    <Modules>
                                                                        <telerik:EditorModule Name="RadEditorHtmlInspector" Enabled="false" Visible="false" />
                                                                        <telerik:EditorModule Name="RadEditorNodeInspector" Enabled="false" Visible="false" />
                                                                        <telerik:EditorModule Name="RadEditorDomInspector" Enabled="false" />
                                                                        <telerik:EditorModule Name="RadEditorStatistics" Enabled="false" />
                                                                    </Modules>
                                                                </telerik:RadEditor>
                                                            </div>
                                                            <div class="col-10 sg-button-right">
                                                                <telerik:RadButton ID="ShopSubmitButton" runat="server" ValidationGroup="ShopSubmit" CssClass="sg-button-submit" Width="150px" OnClientClicked="ShopValidateOnSubmit" OnClick="ShopSubmitButton_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="sg-header">
                                                    <asp:Label ID="Label7" runat="server" Text="Shop List" />
                                                </div>
                                                <div class="col-10  sg-radgrid">
                                                    <telerik:RadGrid ID="ShopTempRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                                                        DataSourceID="SqlDataSource_ShopTemp" OnItemDataBound="ShopTempRadGrid_ItemDataBound" OnItemCommand="ShopTempRadGrid_ItemCommand">
                                                        <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_ShopTemp" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                                                <telerik:GridBoundColumn DataField="FloorName" FilterControlWidth="100%" FilterControlAltText="Filter FloorName column" HeaderText="Floor Name" SortExpression="FloorName"
                                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FloorName">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="ShopNumber" FilterControlWidth="100%" FilterControlAltText="Filter ShopNumber column" HeaderText="Shop Number" SortExpression="ShopNumber"
                                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ShopNumber">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="ShopName" FilterControlWidth="100%" FilterControlAltText="Filter ShopName column" HeaderText="Shop Name" SortExpression="ShopName"
                                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ShopName">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/photo-color.png" CommandName="ViewAttachment" HeaderText="View Attachment" UniqueName="ViewAttachment" ButtonType="ImageButton">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridButtonColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" HeaderText="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridButtonColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Delete.png" CommandName="Delete" UniqueName="Delete" ButtonType="ImageButton">
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
                                            <div class="col-5 sg-button-left">
                                                <telerik:RadButton ID="ShopPreviousButton" runat="server" Text="Previous" CssClass="sg-button-submit" OnClientClicked="previousTab" AutoPostBack="false" Width="150px" />
                                            </div>
                                            <div class="col-5 sg-button-right">
                                                <telerik:RadButton ID="ShopNextButton" runat="server" Text="Next" CssClass="sg-button-submit" Width="150px" OnClick="ShopNextButton_Click" />
                                            </div>
                                        </div>
                                    </div>
                                </telerik:RadPageView>
                                <telerik:RadPageView runat="server" ID="OfficePageView">
                                    <div class="col-10">
                                        <div class="col-row">
                                            <div class="col-8 col-push-10">
                                                <div class="col-10 sg-header">
                                                    <asp:Label ID="OfficeHeaderLabel" runat="server" />
                                                </div>
                                                <div class="col-10">
                                                    <div class="col-33">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="OfficeFloorLabel" runat="server" AssociatedControlID="OfficeFloorComboBox" Text="Office Floor No" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadComboBox runat="server" ID="OfficeFloorComboBox" AppendDataBoundItems="True" CausesValidation="False"
                                                                    CollapseDelay="10" DataMember="DefaultView" EnableTextSelection="true" EmptyMessage="--- Select ---" Filter="Contains"
                                                                    Width="100%" MarkFirstMatch="false" EnableLoadOnDemand="true" OnItemsRequested="OfficeFloorComboBox_ItemsRequested">
                                                                </telerik:RadComboBox>
                                                                <asp:RequiredFieldValidator ID="OfficeFloorRequired" runat="server" ControlToValidate="OfficeFloorComboBox" ValidationGroup="OfficeSubmit" EnableClientScript="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-33">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="OfficeNameLabel" runat="server" AssociatedControlID="OfficeNameTextBox" Text="Office Name" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadTextBox ID="OfficeNameTextBox" runat="server" Width="100%" ToolTip="Office Name" />
                                                                <asp:RequiredFieldValidator ID="OfficeNameRequired" runat="server" ControlToValidate="OfficeNameTextBox" ValidationGroup="OfficeSubmit" EnableClientScript="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-33">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="OfficeNumberLabel" runat="server" AssociatedControlID="OfficeNumberTextBox" Text="Office Number" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadTextBox ID="OfficeNumberTextBox" runat="server" Width="100%" ToolTip="Office Number" />
                                                                <asp:RequiredFieldValidator ID="OfficeNumberRequired" runat="server" ControlToValidate="OfficeNumberTextBox" ValidationGroup="OfficeSubmit" EnableClientScript="true" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-10">
                                                    <div class="col-5">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="OfficeAttachmentLabel" runat="server" AssociatedControlID="OfficeAttachmentTempRadGrid" Text="Office Attachment" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadGrid ID="OfficeAttachmentTempRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" AllowMultiRowSelection="true"
                                                                    DataSourceID="SqlDataSource_OfficeAttachmentTemp" OnItemDataBound="OfficeAttachmentTempRadGrid_ItemDataBound" OnItemCommand="OfficeAttachmentTempRadGrid_ItemCommand" AllowAutomaticDeletes="true">
                                                                    <MasterTableView DataKeyNames="ID" Name="OfficeAttachment" DataSourceID="SqlDataSource_OfficeAttachmentTemp" CommandItemDisplay="Top" AllowPaging="true" PageSize="5">
                                                                        <CommandItemSettings AddNewRecordText="Add New Record" ShowRefreshButton="false" />
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
                                                                            <telerik:GridBoundColumn Display="false" DataField="BuildingAttachment" ReadOnly="true" UniqueName="BuildingAttachment" />
                                                                            <telerik:GridBoundColumn DataField="BuildingAttachmentName" FilterControlWidth="100%" FilterControlAltText="Filter BuildingAttachmentName column" HeaderText="Attachment Name" SortExpression="AttachmentName"
                                                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="BuildingAttachmentName">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridHyperLinkColumn DataNavigateUrlFields="BuildingAttachment" DataNavigateUrlFormatString="{0}" AllowFiltering="false"
                                                                                ShowFilterIcon="false" Text="View" Target="_blank" ImageUrl="~/Content/css/MeStyle/Grid/photo-color.png" UniqueName="View">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridHyperLinkColumn>
                                                                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridButtonColumn>
                                                                            <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Delete.png" CommandName="Delete" UniqueName="Delete" ButtonType="ImageButton">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridButtonColumn>
                                                                            <telerik:GridClientSelectColumn UniqueName="Download" HeaderText="Download">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridClientSelectColumn>
                                                                        </Columns>
                                                                        <PagerStyle AlwaysVisible="True" Mode="NextPrevNumericAndAdvanced" />
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="True"></Selecting>
                                                                        <ClientEvents OnRowSelecting="RowSelecting" />
                                                                    </ClientSettings>
                                                                    <FilterItemStyle HorizontalAlign="Center" />
                                                                    <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Bottom" AlwaysVisible="true" />
                                                                    <FilterMenu EnableImageSprites="False" EnableSelection="True" />
                                                                </telerik:RadGrid>
                                                                <div class="col-10 sg-label-right">
                                                                    <telerik:RadButton ID="OfficeDownloadButton" Target="_blank" Width="120px" Text="Download All" CssClass="sg-button-submit" CommandName="OfficeDownload" OnClick="OfficeDownloadButton_Click" runat="server" />
                                                                    <telerik:RadButton ID="OfficeSelectDownloadButton" Enabled="false" Width="200px" Text="Download Selected Files" CssClass="sg-button-submit" CommandName="OfficeDownload" OnClick="OfficeSelectDownloadButton_Click" runat="server" OnClientClicking="SelectCount" />
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="col-5">

                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="Label1" runat="server" AssociatedControlID="OfficeDescriptionEditor" Text="Office Description" />
                                                            </div>

                                                            <div class="col-10">
                                                                <telerik:RadEditor runat="server" ID="OfficeDescriptionEditor" ContentAreaMode="Div" Width="100%" EditModes="Design" Height="362px"
                                                                    EditType="Normal" ToolbarMode="ShowOnFocus">
                                                                    <Modules>
                                                                        <telerik:EditorModule Name="RadEditorHtmlInspector" Enabled="false" Visible="false" />
                                                                        <telerik:EditorModule Name="RadEditorNodeInspector" Enabled="false" Visible="false" />
                                                                        <telerik:EditorModule Name="RadEditorDomInspector" Enabled="false" />
                                                                        <telerik:EditorModule Name="RadEditorStatistics" Enabled="false" />
                                                                    </Modules>
                                                                </telerik:RadEditor>
                                                            </div>
                                                            <div class="col-10 sg-button-right">
                                                                <telerik:RadButton ID="OfficeSubmitButton" runat="server" ValidationGroup="OfficeSubmit" CssClass="sg-button-submit" Width="150px" OnClientClicked="OfficeValidateOnSubmit" OnClick="OfficeSubmitButton_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="sg-header">
                                                    <asp:Label ID="Label2" runat="server" Text="Office List" />
                                                </div>
                                                <div class="col-10  sg-radgrid">
                                                    <telerik:RadGrid ID="OfficeTempRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                                                        DataSourceID="SqlDataSource_OfficeTemp" OnItemDataBound="OfficeTempRadGrid_ItemDataBound" OnItemCommand="OfficeTempRadGrid_ItemCommand">
                                                        <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_OfficeTemp" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                                                <telerik:GridBoundColumn DataField="FloorName" FilterControlWidth="100%" FilterControlAltText="Filter FloorName column" HeaderText="Floor Name" SortExpression="FloorName"
                                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="FloorName">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="OfficeNumber" FilterControlWidth="100%" FilterControlAltText="Filter OfficeNumber column" HeaderText="Office Number" SortExpression="OfficeNumber"
                                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="OfficeNumber">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="OfficeName" FilterControlWidth="100%" FilterControlAltText="Filter OfficeName column" HeaderText="Office Name" SortExpression="OfficeName"
                                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="OfficeName">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/photo-color.png" CommandName="ViewAttachment" HeaderText="View Attachment" UniqueName="ViewAttachment" ButtonType="ImageButton">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridButtonColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" HeaderText="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridButtonColumn>
                                                                <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Delete.png" CommandName="Delete" UniqueName="Delete" ButtonType="ImageButton">
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
                                        <div class="col-5 sg-button-left">
                                            <telerik:RadButton ID="OfficePreviousButton" runat="server" Text="Previous" CssClass="sg-button-submit" OnClientClicked="previousTab" AutoPostBack="false" Width="150px" />
                                        </div>
                                        <div class="col-5 sg-button-right">
                                            <telerik:RadButton ID="OfficeNextButton" runat="server" Text="Save" CssClass="sg-button-submit" Width="150px" OnClick="OfficeNextButton_Click" />
                                        </div>
                                    </div>
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                        </div>
                    </div>


                </div>

            </div>


            <telerik:RadWindowManager ID="RadWindowManager_modalPopup" runat="server" EnableViewState="false">
                <Windows>
                    <telerik:RadWindow ID="Building_modal" runat="server" VisibleStatusbar="false"
                        Modal="true" VisibleTitlebar="false" Behaviors="None">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
        </div>
    </div>

    <asp:HiddenField ID="newTabURLHiddenField" runat="server" ClientIDMode="Static" Value="" />

    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyBtAwVqtMD1Jfq1UHb5DJq2uoUkEzgb8Ko"></script>
    <script src="https://apis.google.com/js/client.js"> </script>
    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock">
        <style>
            .GSMMargin {
                margin-right: 10px !important;
            }
        </style>
        <script>
            Sys.Application.add_load(function () {
                $("#<%=BuildingMapURLCopyLink.ClientID%>").click(function () {
                    var aux = document.createElement("input");
                    aux.setAttribute("value", $("#<%= BuildingMapUrlTextBox.ClientID %>").val());
                    document.body.appendChild(aux);
                    aux.select();
                    document.execCommand("copy");
                    document.body.removeChild(aux);
                });
            });

            function load() {
                gapi.client.setApiKey('AIzaSyBtAwVqtMD1Jfq1UHb5DJq2uoUkEzgb8Ko');
                gapi.client.load('urlshortener', 'v1', function () { });

            }
            window.onload = load;

            function GetValue(x, y) {

                var GPSTextBox = $find("<%= BuildingGPSTextBox.ClientID%>");
                var AddressTextBox = $find("<%= BuildingAddressTextBox.ClientID()%>");
                GPSTextBox.set_value(x + "," + y);

                geocoder = new google.maps.Geocoder();
                var latlng = new google.maps.LatLng(x, y);
                geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                    if (status == google.maps.GeocoderStatus.OK) {
                        if (results[0]) {
                            var j = 0;

                            for (var i = 0; i < results[j].address_components.length; i++) {
                                if (results[j].address_components[i].types[0] == "locality") {

                                    city = results[j].address_components[i];
                                }
                                if (results[j].address_components[i].types[0] == "administrative_area_level_1") {

                                    region = results[j].address_components[i];
                                }
                                if (results[j].address_components[i].types[0] == "country") {

                                    country = results[j].address_components[i];
                                }
                                if (results[j].address_components[i].types[0] == "route") {

                                    route = results[j].address_components[i];
                                }
                            }

                            AddressTextBox.set_value(route.long_name + " , " + city.long_name + " , " + region.long_name + " , " + country.long_name);
                            makeShort("http://www.google.com/maps/place/" + x + "," + y)


                        } else {
                            alert("No address found");
                        }
                    } else {
                        alert("Geocoder failed due to: " + status);
                    }
                });
            }

            function makeShort(longUrl) {
                var str;

                var request = gapi.client.urlshortener.url.insert({
                    'resource': {
                        'longUrl': longUrl
                    }
                });
                request.execute(function (response) {

                    if (response.id != null) {
                        str = response.id;
                    }
                    else {
                        str = longUrl;
                    }

                    var MapURLTextBox = $find("<%= BuildingMapUrlTextBox.ClientID()%>");
                    MapURLTextBox.set_value(str);
                });
            }




        </script>
        <script>
            function myFunction() {
                var newTabHiddenField = document.getElementById('<%= newTabURLHiddenField.ClientID%>');
                var url = newTabHiddenField.value;

                window.open(url, '_blank');
            }


            function RowSelecting(sender, args) {
                var tableView = args.get_tableView();

                switch (tableView.get_name()) {
                    case "GeneralAttachment":

                        var _control_object = $telerik.$("[id$='GeneralSelectDownloadButton']").attr('id');
                        var _control = $find(_control_object);
                        _control.set_enabled(true);

                        break;
                    case "FlatAttachment":

                        var _control_object = $telerik.$("[id$='FlatSelectDownloadButton']").attr('id');
                        var _control = $find(_control_object);
                        _control.set_enabled(true);

                        break;
                    case "ShopAttachment":
                        var _control_object = $telerik.$("[id$='ShopSelectDownloadButton']").attr('id');
                        var _control = $find(_control_object);
                        _control.set_enabled(true);
                        break;
                    case "OfficeAttachment":
                        var _control_object = $telerik.$("[id$='OfficeSelectDownloadButton']").attr('id');
                        var _control = $find(_control_object);
                        _control.set_enabled(true);
                        break;
                }
            }


            function SelectCount(sender, args) {

                switch (sender.get_commandName()) {
                    case "GeneralDownload":

                        var _control_object = $telerik.$("[id$='BuildingAttachmentTempRadGrid']").attr('id');
                        var _control = $find(_control_object);
                        var _control_object2 = $telerik.$("[id$='GeneralSelectDownloadButton']").attr('id');
                        var _control2 = $find(_control_object2);
                        if (_control.get_masterTableView().get_selectedItems().length == 0) {
                            args.set_cancel(true);
                            alert("Please Select Any Attachment..!!");
                            _control2.set_enabled(false);
                        }

                        break;
                    case "FlatDownload":

                        var _control_object = $telerik.$("[id$='FlatAttachmentTempRadGrid']").attr('id');
                        var _control = $find(_control_object);
                        var _control_object2 = $telerik.$("[id$='FlatSelectDownloadButton']").attr('id');
                        var _control2 = $find(_control_object2);
                        if (_control.get_masterTableView().get_selectedItems().length == 0) {
                            args.set_cancel(true);
                            alert("Please Select Any Attachment..!!");
                            _control2.set_enabled(false);
                        }

                        break;
                    case "ShopDownload":

                        var _control_object = $telerik.$("[id$='ShopAttachmentTempRadGrid']").attr('id');
                        var _control = $find(_control_object);
                        var _control_object2 = $telerik.$("[id$='ShopSelectDownloadButton']").attr('id');
                        var _control2 = $find(_control_object2);
                        if (_control.get_masterTableView().get_selectedItems().length == 0) {
                            args.set_cancel(true);
                            alert("Please Select Any Attachment..!!");
                            _control2.set_enabled(false);
                        }

                        break;
                    case "OfficeDownload":
                        var _control_object = $telerik.$("[id$='OfficeAttachmentTempRadGrid']").attr('id');
                        var _control = $find(_control_object);
                        var _control_object2 = $telerik.$("[id$='OfficeSelectDownloadButton']").attr('id');
                        var _control2 = $find(_control_object2);
                        if (_control.get_masterTableView().get_selectedItems().length == 0) {
                            args.set_cancel(true);
                            alert("Please Select Any Attachment..!!");
                            _control2.set_enabled(false);
                        }
                        break;
                }
            }


            function CurrencyCodeSelected(sender, args) {
                $find("<%= BuildingRentPriceRadTextBox.ClientID%>").set_value("");
                $find("<%= BuildingRentPriceRadTextBox.ClientID%>").get_numberFormat().NegativePattern = " -n " + sender.get_value();
                $find("<%= BuildingRentPriceRadTextBox.ClientID%>").get_numberFormat().PositivePattern = " +n " + sender.get_value();
            }
            function refreshGrid(type) {

                switch (type) {
                    case "General":
                        var GeneralAttachmentGrid = $find("<%= BuildingAttachmentTempRadGrid.ClientID%>").get_masterTableView();
                        GeneralAttachmentGrid.rebind();

                        break;
                    case "Flat":
                        var FlatAttachmentGrid = $find("<%= FlatAttachmentTempRadGrid.ClientID%>").get_masterTableView();
                        FlatAttachmentGrid.rebind();
                        break;
                    case "Shop":
                        var ShopAttachmentGrid = $find("<%= ShopAttachmentTempRadGrid.ClientID%>").get_masterTableView();
                        ShopAttachmentGrid.rebind();
                        break;
                    case "Office":
                        var OfficeAttachmentGrid = $find("<%= OfficeAttachmentTempRadGrid.ClientID%>").get_masterTableView();
                        OfficeAttachmentGrid.rebind();
                        break;
                }
            }

            function previousTab() {
                var tabStrip = $find('<%= BuildingTabStrip.ClientID%>');
                var multiPage = $find("<%= BuildingMultiPage.ClientID %>");

                switch (tabStrip.get_selectedTab().get_text()) {
                    case "Flat":
                        var previousTab = tabStrip.findTabByText("General");
                        var currentTab = tabStrip.findTabByText("Flat");
                        var pageView = multiPage.findPageViewByID("mainPlaceHolder_GeneralPageView");

                        if (previousTab) {
                            if (pageView)
                                pageView.set_selected(true);
                            currentTab.disable();
                            previousTab.enable();
                            previousTab.select();
                        }
                        break;
                    case "Shop":
                        var previousTab = tabStrip.findTabByText("Flat");
                        var currentTab = tabStrip.findTabByText("Shop");
                        var pageView = multiPage.findPageViewByID("mainPlaceHolder_FlatPageView");

                        if (previousTab) {
                            if (pageView)
                                pageView.set_selected(true);
                            currentTab.disable();
                            previousTab.enable();
                            previousTab.select();
                        }
                        break;
                    case "Office":
                        var previousTab = tabStrip.findTabByText("Shop");
                        var currentTab = tabStrip.findTabByText("Office");
                        var pageView = multiPage.findPageViewByID("mainPlaceHolder_ShopPageView");

                        if (previousTab) {
                            if (pageView)
                                pageView.set_selected(true);
                            currentTab.disable();
                            previousTab.enable();
                            previousTab.select();
                        }
                        break;
                }
            }

            function ContactGSMCountryOnClientSelected() {
                var _contactStaffGSM = $find("<%= BuildingContactStaffGSMTextBox.ClientID%>");
                _contactStaffGSM.enable();
                _contactStaffGSM.set_value("");
                _contactStaffGSM.enable();
                _contactStaffGSM.focus();
            }

            function BuildingValidateOnSubmit(sender, args) {
                var val = true;

                var _control_Object;
                var _control;

                _control_Object = $telerik.$("[id$='BuildingNameRadTextBox']").attr('id');
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


                _control_Object = $telerik.$("[id$='BuildingOwnerComboBox']").attr('id');
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

                _control_Object = $telerik.$("[id$='BuildingCurrencyTypeComboBox']").attr('id');
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

                _control_Object = $telerik.$("[id$='BuildingAddressTextBox']").attr('id');
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

                if (val == false) {
                    args.set_cancel(true);
                }
                return val;
            }

            function FlatValidateOnSubmit(sender, args) {
                var val = true;

                var _control_Object;
                var _control;

                _control_Object = $telerik.$("[id$='FlatNameTextBox']").attr('id');
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

                _control_Object = $telerik.$("[id$='FlatNumberTextBox']").attr('id');
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


                _control_Object = $telerik.$("[id$='FlatFloorComboBox']").attr('id');
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
                if (val == false) {
                    args.set_cancel(true);
                }
                return val;
            }

            function ShopValidateOnSubmit(sender, args) {
                var val = true;

                var _control_Object;
                var _control;

                _control_Object = $telerik.$("[id$='ShopNameTextBox']").attr('id');
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

                _control_Object = $telerik.$("[id$='ShopNumberTextBox']").attr('id');
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


                _control_Object = $telerik.$("[id$='ShopFloorComboBox']").attr('id');
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

                if (val == false) {
                    args.set_cancel(true);
                }
                return val;
            }

            function OfficeValidateOnSubmit(sender, args) {
                var val = true;

                var _control_Object;
                var _control;

                _control_Object = $telerik.$("[id$='OfficeNameTextBox']").attr('id');
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

                _control_Object = $telerik.$("[id$='OfficeNumberTextBox']").attr('id');
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


                _control_Object = $telerik.$("[id$='OfficeFloorComboBox']").attr('id');
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

                if (val == false) {
                    args.set_cancel(true);
                }
                return val;
            }


        </script>
    </telerik:RadCodeBlock>



    <asp:SqlDataSource ID="SqlDataSource_CountryList" runat="server"
        ConnectionString="<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>"
        SelectCommand="PROC_APP_CountriesSELECTALL" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource_OwnerList" runat="server"
        ConnectionString="<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>"
        SelectCommand="PROC_APP_OwnersSELECTALL" SelectCommandType="StoredProcedure"></asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSource_FlatTemp"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MultiFloorBuildingFlatTempsSELECTALL" SelectCommandType="StoredProcedure"
        OnSelecting="SqlDataSource_FlatTemp_Selecting">
        <SelectParameters>
            <asp:Parameter Name="BuildingTempID" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>



    <asp:SqlDataSource runat="server" ID="SqlDataSource_ShopTemp"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MultiFloorBuildingShopTempsSELECTALL" SelectCommandType="StoredProcedure"
        OnSelecting="SqlDataSource_ShopTemp_Selecting">
        <SelectParameters>
            <asp:Parameter Name="BuildingTempID" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_OfficeTemp"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MultiFloorBuildingOfficeTempsSELECTALL" SelectCommandType="StoredProcedure"
        OnSelecting="SqlDataSource_OfficeTemp_Selecting">
        <SelectParameters>
            <asp:Parameter Name="BuildingTempID" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSource_BuildingAttachmentTemp"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MFBuildingAttachmentTempsSELECTALL" SelectCommandType="StoredProcedure"
        DeleteCommand="PROC_APP_MFBuildingAttachmentTempsDELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" Name="UserID" />

        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_FlatAttachmentTemp"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MFBuildingFlatAttachmentTempsSELECTALL" SelectCommandType="StoredProcedure"
        DeleteCommand="PROC_APP_MFBuildingFlatAttachmentTempsDELETE" DeleteCommandType="StoredProcedure"
        OnSelecting="SqlDataSource_FlatAttachmentTemp_Selecting">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" Name="UserID" />
            <asp:Parameter DefaultValue="" Name="FlatTempID" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSource_ShopAttachmentTemp"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MFBuildingShopAttachmentTempsSELECTALL" SelectCommandType="StoredProcedure"
        DeleteCommand="PROC_APP_MFBuildingShopAttachmentTempsDELETE" DeleteCommandType="StoredProcedure"
        OnSelecting="SqlDataSource_ShopAttachmentTemp_Selecting">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" Name="UserID" />
            <asp:Parameter DefaultValue="" Name="ShopTempID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_OfficeAttachmentTemp"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MFBuildingOfficeAttachmentTempsSELECTALL" SelectCommandType="StoredProcedure"
        DeleteCommand="PROC_APP_MFBuildingOfficeAttachmentTempsDELETE" DeleteCommandType="StoredProcedure"
        OnSelecting="SqlDataSource_OfficeAttachmentTemp_Selecting">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" Name="UserID" />
            <asp:Parameter DefaultValue="" Name="OfficeTempID" />
        </SelectParameters>
    </asp:SqlDataSource>




</asp:Content>
