<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="BuildingUpdateManagement.aspx.vb" Inherits="RealEstateManagementSystem.BuildingUpdateManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="headerPlaceHolderLabel" runat="server" Text="Multi Floor Building Update"></asp:Label>
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
                            <telerik:RadTabStrip ID="BuildingTabStrip" runat="server" MultiPageID="BuildingMultiPage" Orientation="HorizontalTop" SelectedIndex="0">
                                <Tabs>
                                    <telerik:RadTab Text="General" Value="GeneralDetails"  runat="server" Selected="true"/>
                                    <telerik:RadTab Text="Flat" Value="FlatDetails" runat="server" />
                                    <telerik:RadTab Text="Shop" Value="ShopDetails" runat="server" />
                                    <telerik:RadTab Text="Office" Value="OfficeDetails" runat="server" />
                                </Tabs>
                            </telerik:RadTabStrip>
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
                                                                            Width="100%" MarkFirstMatch="True" DataSourceID="SqlDataSource_CountryList" DataTextField="CurrencyCodeName" DataValueField="CurrencyCode"  OnClientSelectedIndexChanged="CurrencyCodeSelected">
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
                                                    <asp:Label ID="BuildingAttachmentLabel" runat="server" AssociatedControlID="BuildingAttachmentRadGrid" Text="Attachment" />
                                                </div>
                                                <div class="col-10  sg-radgrid">
                                                    <telerik:RadGrid ID="BuildingAttachmentRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" AllowMultiRowSelection="true" 
                                                        DataSourceID="SqlDataSource_BuildingAttachments" OnItemDataBound="BuildingAttachmentRadGrid_ItemDataBound"  OnItemCommand="BuildingAttachmentRadGrid_ItemCommand"  AllowAutomaticDeletes="true" CellSpacing="-1" GridLines="Both">
                                                        <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_BuildingAttachments" CommandItemDisplay="Top" AllowPaging="true" PageSize="5">
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
                                                               <%-- <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                </telerik:GridButtonColumn>--%>
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
                                                        <telerik:RadButton ID="DownloadButton" Target="_blank" Width="120px" Text="Download All" CssClass="sg-button-submit" OnClick="DownloadButton_Click"  runat="server" />
                                                        <telerik:RadButton ID="SelectDownloadButton" Enabled="false" Width="200px" Text="Download Selected Files" CssClass="sg-button-submit" OnClick="SelectDownloadButton_Click" runat="server" OnClientClicking="SelectCount" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </telerik:RadPageView>
                                <telerik:RadPageView runat="server" ID="FlatPageView">
                                    <div class="col-10">
                                        <div class="col-row">
                                            <div class="col-8 col-push-10">
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
                                                                <asp:Label ID="FlatAttachmentLabel" runat="server" AssociatedControlID="FlatAttachmentRadGrid" Text="Flat Attachment" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadGrid ID="FlatAttachmentRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                                                                    DataSourceID="SqlDataSource_FlatAttachments" OnItemDataBound="FlatAttachmentRadGrid_ItemDataBound"  OnItemCommand="FlatAttachmentRadGrid_ItemCommand"  
                                                                    AllowAutomaticDeletes="true" CellSpacing="-1" GridLines="Both">
                                                                    <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_FlatAttachments" CommandItemDisplay="Top" AllowPaging="true" PageSize="5">
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
                                                                           <%-- <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridButtonColumn>--%>
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
                                                                <telerik:RadButton ID="FlatSubmitButton" runat="server" Text="Update" ValidationGroup="FlatSubmit" CssClass="sg-button-submit" Width="150px" OnClientClicked="FlatValidateOnSubmit" OnClick="FlatSubmitButton_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="sg-header">
                                                    <asp:Label ID="FlatListHeaderLabel" runat="server" Text="Flat List" />
                                                </div>
                                                <div class="col-10  sg-radgrid">
                                                    <telerik:RadGrid ID="FlatRadGrid" runat="server"  AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                                                        DataSourceID="SqlDataSource_Flats" OnItemDataBound="FlatRadGrid_ItemDataBound"  OnItemCommand="FlatRadGrid_ItemCommand" >
                                                        <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_Flats" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                    </div>
                                </telerik:RadPageView>
                                <telerik:RadPageView runat="server" ID="ShopPageView">
                                    <div class="col-10">
                                        <div class="col-row">
                                            <div class="col-8 col-push-10">
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
                                                                <asp:Label ID="ShopAttachmentLabel" runat="server" AssociatedControlID="ShopAttachmentRadGrid" Text="Shop Attachment" />
                                                            </div>
                                                            <div class="col-10 ">
                                                                <telerik:RadGrid ID="ShopAttachmentRadGrid" runat="server"  AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                                                                    DataSourceID="SqlDataSource_ShopAttachments" OnItemDataBound="ShopAttachmentRadGrid_ItemDataBound"  OnItemCommand="ShopAttachmentRadGrid_ItemCommand"  AllowAutomaticDeletes="true">
                                                                    <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_ShopAttachments" CommandItemDisplay="Top" AllowPaging="true" PageSize="5">
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
                                                                           <%-- <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridButtonColumn>--%>
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
                                                                <telerik:RadButton ID="ShopSubmitButton" runat="server" Text="Submit" ValidationGroup="ShopSubmit" CssClass="sg-button-submit" Width="150px" OnClientClicked="ShopValidateOnSubmit" OnClick="ShopSubmitButton_Click" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="sg-header">
                                                    <asp:Label ID="Label7" runat="server" Text="Shop List" />
                                                </div>
                                                <div class="col-10  sg-radgrid">
                                                    <telerik:RadGrid ID="ShopRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                                                        DataSourceID="SqlDataSource_Shops" OnItemDataBound="ShopRadGrid_ItemDataBound"  OnItemCommand="ShopRadGrid_ItemCommand" >
                                                        <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_Shops" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                    </div>
                                </telerik:RadPageView>
                                <telerik:RadPageView runat="server" ID="OfficePageView">
                                    <div class="col-10">
                                        <div class="col-row">
                                            <div class="col-8 col-push-10">
                                                <div class="col-10">
                                                    <div class="col-33">
                                                        <div class="sg-blockcontent-right">
                                                            <div class="col-10 sg-label">
                                                                <asp:Label ID="OfficeFloorLabel" runat="server" AssociatedControlID="OfficeFloorComboBox" Text="Office Floor No" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadComboBox runat="server" ID="OfficeFloorComboBox" AppendDataBoundItems="True" CausesValidation="False"
                                                                    CollapseDelay="10" DataMember="DefaultView" EnableTextSelection="true" EmptyMessage="--- Select ---" Filter="Contains"
                                                                    Width="100%" MarkFirstMatch="false" EnableLoadOnDemand="true" OnItemsRequested="OfficeFloorComboBox_ItemsRequested" >
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
                                                                <asp:Label ID="OfficeAttachmentLabel" runat="server" AssociatedControlID="OfficeAttachmentRadGrid" Text="Office Attachment" />
                                                            </div>
                                                            <div class="col-10">
                                                                <telerik:RadGrid ID="OfficeAttachmentRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                                                                    DataSourceID="SqlDataSource_OfficeAttachments" OnItemDataBound="OfficeAttachmentRadGrid_ItemDataBound"   OnItemCommand="OfficeAttachmentRadGrid_ItemCommand"   AllowAutomaticDeletes="true">
                                                                    <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_OfficeAttachments" CommandItemDisplay="Top" AllowPaging="true" PageSize="5">
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
                                                                            <%--  <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                                                                                <HeaderStyle HorizontalAlign="Center" Width="40px" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                                                            </telerik:GridButtonColumn>--%>
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
                                                                <telerik:RadButton ID="OfficeSubmitButton" runat="server" Text="Submit" ValidationGroup="OfficeSubmit" CssClass="sg-button-submit" Width="150px" OnClientClicked="OfficeValidateOnSubmit" OnClick="OfficeSubmitButton_Click"  />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="sg-header">
                                                    <asp:Label ID="Label2" runat="server" Text="Office List" />
                                                </div>
                                                <div class="col-10  sg-radgrid">
                                                    <telerik:RadGrid ID="OfficeRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False"
                                                        DataSourceID="SqlDataSource_Offices" OnItemDataBound="OfficeRadGrid_ItemDataBound"   OnItemCommand="OfficeRadGrid_ItemCommand">
                                                        <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_Offices" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                                    </div>
                                </telerik:RadPageView>
                            </telerik:RadMultiPage>
                            <div class="col-10 sg-button-right">
                                <telerik:RadButton ID="SubmitButton" runat="server"  CssClass="sg-button-submit" Text="Submit" Width="150px" OnClick="SubmitButton_Click" ValidationGroup="BuildingSubmit" OnClientClicked="BuildingValidateOnSubmit"></telerik:RadButton>
                            </div>
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


            function RowSelecting() {
                var _control_object = $telerik.$("[id$='SelectDownloadButton']").attr('id');
                var _control = $find(_control_object);
                _control.set_enabled(true);
            }


            function SelectCount(sender, args) {
                var _control_object = $telerik.$("[id$='BuildingAttachmentRadGrid']").attr('id');
                var _control = $find(_control_object);
                var _control_object2 = $telerik.$("[id$='SelectDownloadButton']").attr('id');
                var _control2 = $find(_control_object2);
                if (_control.get_masterTableView().get_selectedItems().length == 0) {
                    args.set_cancel(true);
                    alert("Please Select Any Attachment..!!");
                    _control2.set_enabled(false);
                }
            }

            function CurrencyCodeSelected(sender,args) {
                $find("<%= BuildingRentPriceRadTextBox.ClientID%>").set_value("");
                $find("<%= BuildingRentPriceRadTextBox.ClientID%>").get_numberFormat().NegativePattern = " -n " + sender.get_value();
                $find("<%= BuildingRentPriceRadTextBox.ClientID%>").get_numberFormat().PositivePattern = " +n " + sender.get_value();
            }
            function refreshGrid(type) {
                
                switch (type) {
                    case "General":
                        var GeneralAttachmentGrid = $find("<%= BuildingAttachmentRadGrid.ClientID%>").get_masterTableView();
                        GeneralAttachmentGrid.rebind();

                        break;
                    case "Flat":
                        var FlatAttachmentGrid = $find("<%= FlatAttachmentRadGrid.ClientID%>").get_masterTableView();
                        FlatAttachmentGrid.rebind();
                        break;
                    case "Shop":
                        var ShopAttachmentGrid = $find("<%= ShopAttachmentRadGrid.ClientID%>").get_masterTableView();
                        ShopAttachmentGrid.rebind();
                        break;
                    case "Office":
                        var OfficeAttachmentGrid = $find("<%= OfficeAttachmentRadGrid.ClientID%>").get_masterTableView();
                        OfficeAttachmentGrid.rebind();
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


    <asp:SqlDataSource runat="server" ID="SqlDataSource_Flats"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MultiFloorBuildingFlatsSELECTALL" SelectCommandType="StoredProcedure">
       <SelectParameters>
           <asp:RouteParameter RouteKey="ID" Name="BuildingID" />
       </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSource_Shops"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MultiFloorBuildingShopsSELECTALL" SelectCommandType="StoredProcedure">
       <SelectParameters>
           <asp:RouteParameter RouteKey="ID" Name="BuildingID" />
       </SelectParameters>
    </asp:SqlDataSource>

     <asp:SqlDataSource runat="server" ID="SqlDataSource_Offices"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MultiFloorBuildingOfficesSELECTALL" SelectCommandType="StoredProcedure">
       <SelectParameters>
           <asp:RouteParameter RouteKey="ID" Name="BuildingID" />
       </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSource_BuildingAttachments"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MFBuildingAttachmentsSELECTALL" SelectCommandType="StoredProcedure"
        DeleteCommand="PROC_APP_MFBuildingAttachmentsDELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
       <SelectParameters>
           <asp:RouteParameter RouteKey="ID" Name="BuildingID" />
       </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_FlatAttachments"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MFBuildingFlatAttachmentsSELECTALL" SelectCommandType="StoredProcedure"
        DeleteCommand="PROC_APP_MFBuildingFlatAttachmentsDELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" Name="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource runat="server" ID="SqlDataSource_ShopAttachments"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MFBuildingShopAttachmentsSELECTALL" SelectCommandType="StoredProcedure"
        DeleteCommand="PROC_APP_MFBuildingShopAttachmentsDELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" Name="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>

     <asp:SqlDataSource runat="server" ID="SqlDataSource_OfficeAttachments"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_MFBuildingOfficeAttachmentsSELECTALL" SelectCommandType="StoredProcedure"
        DeleteCommand="PROC_APP_MFBuildingOfficeAttachmentsDELETE" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int64" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter SessionField="UserID" Name="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
