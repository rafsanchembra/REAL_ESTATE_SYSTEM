<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/WindowMaster.Master" CodeBehind="FlatManagementWindow.aspx.vb" Inherits="RealEstateManagementSystem.FlatManagementWindow" %>

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
<asp:Content ID="Content2" ContentPlaceHolderID="contentPlaceHolder" runat="server">

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
                    <div class="col-5">
                        <div class="sg-blockcontent">
                            <div class="col-10 sg-label">
                                <asp:Label ID="FlatNameLabel" runat="server" AssociatedControlID="FlatNameRadTextBox" Text="Name" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="FlatNameRadTextBox" runat="server" Width="100%" TabIndex="1" ToolTip="Name" />
                                <asp:RequiredFieldValidator ID="FlatNameRequired" runat="server" CssClass ="field-validation-error" ControlToValidate="FlatNameRadTextBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
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
                                <asp:RequiredFieldValidator ID="FlatProvinceRequired" runat="server" CssClass ="field-validation-error" ControlToValidate="FlatProvinceComboBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
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
                                <asp:RequiredFieldValidator ID="FlatVillageRequired1" runat="server" CssClass ="field-validation-error" ControlToValidate="FlatVillageComboBox" ValidationGroup="FlatSubmit" EnableClientScript="true" />
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
                                <asp:LinkButton runat ="server" ID ="FlatUploadedLink" OnClick ="FlatUploadedLink_Click"  Text ="View"></asp:LinkButton>
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
                                <asp:RequiredFieldValidator ID="FlatrentPriceRequired" runat="server" ControlToValidate="FlatRentPriceRadTextBox" CssClass="field-validation-error" ValidationGroup="FlatSubmit" EnableClientScript="true" />
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
                                <asp:RequiredFieldValidator ID="FlatCityRequired" runat="server" ControlToValidate="FlatCityComboBox" CssClass="field-validation-error" ValidationGroup="FlatSubmit" EnableClientScript="true" />
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
                    <telerik:RadButton ID="CancelButton" runat="server" Width="100px" Text="Close" TabIndex="15" CssClass="sg-button-submit" AutoPostBack="false" OnClientClicked="CloseWindow" UseSubmitBehavior="false" />
                    <telerik:RadButton ID="SubmitButton" runat="server" Width="100px" Text="Submit" TabIndex="14" CssClass="sg-button-submit" ValidationGroup="FlatSubmit"  UseSubmitBehavior="false" OnClick="SubmitButton_Click"  />
                </div>
                </div>

            </div>
            <telerik:RadWindowManager ID="RadWindowManager_modalPopup" runat="server" EnableViewState="false">
                <Windows>
                    <telerik:RadWindow ID="AddBasicData_model" runat="server" Width="550px" VisibleStatusbar="False"
                        Modal="true" VisibleTitlebar="false" Behaviors="None">
                    </telerik:RadWindow>
                </Windows>
                <Windows>
                    <telerik:RadWindow ID="FlatEdit_model" runat="server" Width="1024px" Height="600px" VisibleStatusbar="false"
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

</asp:Content>
