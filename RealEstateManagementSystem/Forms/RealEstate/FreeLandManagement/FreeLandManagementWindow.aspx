<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/WindowMaster.Master" CodeBehind="FreeLandManagementWindow.aspx.vb" Inherits="RealEstateManagementSystem.FreeLandManagementWindow" %>

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
                <div class="col-10 sg-header">
                    <asp:Label ID="EditFreeLandHeaderLabel" runat="server" Text="Edit FreeLand details" />
                </div>
                <div class="col-row">
                    <div class="col-5">
                        <div class="sg-blockcontent">
                            <div class="col-10 sg-label">
                                <asp:Label ID="EditFreeLandNameLabel" runat="server" AssociatedControlID="EditFreeLandNameRadTextBox" Text="Name" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="EditFreeLandNameRadTextBox" runat="server" Width="100%" TabIndex="1" ToolTip="Name" />
                                <asp:RequiredFieldValidator ID="EditFreeLandNameRequired" runat="server" ControlToValidate="EditFreeLandNameRadTextBox" ValidationGroup="EditFreeLandSubmit" EnableClientScript="true" CssClass="field-validation-error" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="EditFreeLandCompanyNameLabel" runat="server" AssociatedControlID="EditFreeLandCompanyNameRadTextBox" Text="Company Name" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="EditFreeLandCompanyNameRadTextBox" runat="server" TabIndex="3" ToolTip="Company Name" Width="100%" />
                            </div>
                            <div class="col-5 sg-label">
                                <asp:Label ID="EditFreeLandProvinceLabel" runat="server" AssociatedControlID="EditFreeLandProvinceComboBox" Text="Province" />
                            </div>
                            <div class="col-5 sg-label sg-text-align-right">
                                <asp:LinkButton ID="AddnewProvince" runat="server" Text="Add New Province" OnClick="AddnewProvince_Click" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="EditFreeLandProvinceComboBox" runat="server" AutoPostBack="true" TabIndex="5" ToolTip="Select the Province" ItemRequestTimeout="0" EmptyMessage=" --Select-- " Filter="Contains"
                                    CausesValidation="False" MarkFirstMatch="True" Width="100%" OnSelectedIndexChanged="FreeLandProvinceComboBox_SelectedIndexChanged" DataSourceID="SqlDataSource_ProvincesList" DataTextField="ProvinceName" DataValueField="ID" />
                                <asp:RequiredFieldValidator ID="EditFreeLandProvinceRequired" runat="server" ControlToValidate="EditFreeLandProvinceComboBox" ValidationGroup="EditFreeLandSubmit" EnableClientScript="true" CssClass="field-validation-error" />
                            </div>
                            <div class="col-5 sg-label">
                                <asp:Label ID="EditFreeLandVillageLabel" runat="server" AssociatedControlID="EditFreeLandVillageComboBox" Text="Village" />
                            </div>
                            <div class="col-5 sg-label sg-text-align-right">
                                <asp:LinkButton ID="addnewVillage" runat="server" Text="Add New Village" OnClick="addnewVillage_Click" Height="50%" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="EditFreeLandVillageComboBox" runat="server" TabIndex="7" ToolTip="Select the Village" AppendDataBoundItems="True" AutoPostBack="true" EmptyMessage=" --Select-- "
                                    CausesValidation="False" MarkFirstMatch="True" Width="100%" DataSourceID="SqlDataSource_VillageList" DataTextField="VillageName" DataValueField="ID" />
                                <asp:RequiredFieldValidator ID="EditFreeLandVillageRequired" runat="server" ControlToValidate="EditFreeLandVillageComboBox" ValidationGroup="EditFreeLandSubmit" EnableClientScript="true" CssClass="field-validation-error" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="EditFreeLandMemoLabel" runat="server" AssociatedControlID="EditFreeLandMemoRadTextBox" Text="Memo" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="EditFreeLandMemoRadTextBox" runat="server" TextMode="MultiLine" TabIndex="9" Height="115px" Width="100%" ToolTip="Memo" />
                            </div>
                        </div>
                    </div>
                    <div class="col-5">
                        <div class="sg-blockcontent">
                            <div class="col-10 sg-label">
                                <asp:Label ID="EditFreeLandOfficalNameLabel" runat="server" AssociatedControlID="EditFreeLandOfficalNameRadTextBox" Text="Offical Name" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="EditFreeLandOfficalNameRadTextBox" runat="server" TabIndex="2" ToolTip="Offical Name" Width="100%" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="EditFreeLandRentPriceLabel" runat="server" AssociatedControlID="EditFreeLandRentingPriceTextBox" Text="Rent Price" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadNumericTextBox ID="EditFreeLandRentingPriceTextBox" runat="server" TabIndex="4" Type="Currency" Width="100%" ToolTip="Enter the Rent Price">
                                    <NumberFormat DecimalDigits="3" AllowRounding="true" NegativePattern="RO -n" PositivePattern="RO n" />
                                </telerik:RadNumericTextBox>
                                <asp:RequiredFieldValidator ID="EditFreeLandrentPriceRequired" runat="server" ControlToValidate="EditFreeLandRentingPriceTextBox" ValidationGroup="EditFreeLandSubmit" CssClass="field-validation-error" EnableClientScript="true" />
                            </div>
                            <div class="col-5 sg-label">
                                <asp:Label ID="EditFreeLandCityLabel" runat="server" AssociatedControlID="EditFreeLandCityComboBox" Text="City" />
                            </div>
                            <div class="col-5 sg-label sg-text-align-right">
                                <asp:LinkButton ID="AddnewCity" runat="server" Text="Add New City" OnClick="AddnewCity_Click" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="EditFreeLandCityComboBox" runat="server" TabIndex="6" ToolTip="Select the City name" AppendDataBoundItems="True" AutoPostBack="true" EmptyMessage=" --Select-- "
                                    CausesValidation="False" MarkFirstMatch="True" Width="100%" OnSelectedIndexChanged="FreeLandCityComboBox_SelectedIndexChanged" DataSourceID="SqlDataSource_CityList" DataTextField="CityName" DataValueField="ID" />
                                <asp:RequiredFieldValidator ID="EditFreeLandCityRequired" runat="server" ControlToValidate="EditFreeLandCityComboBox" ValidationGroup="EditFreeLandSubmit" EnableClientScript="true" CssClass="field-validation-error" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="EditFreeLandPlaceLabel" runat="server" AssociatedControlID="EditFreeLandPlaceRadTExtBox" Text="Place" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="EditFreeLandPlaceRadTExtBox" runat="server" TabIndex="8" ToolTip="Place" Width="100%" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="EditFreeLandAttachment1Label" runat="server" AssociatedControlID="EditFreeLandAttachmentUpload" Text="Attachments" />
                            </div>
                            <div class="col-10">
                                <telerik:RadAsyncUpload ID="EditFreeLandAttachmentUpload" runat="server" TabIndex="10" ToolTip="Upload the Attachments" MaxFileInputsCount="10" Skin="MetroTouch" MultipleFileSelection="Automatic" AllowedFileExtensions=".pdf,.jpeg,.jpg,.tif,.png,.gif,tiff,.bmp,.bpg" PostbackTriggers="SubmitButton" />
                                <asp:LinkButton runat="server" ID="FreeLandUploadedLink" OnClick="FreeLandUploadedLink_Click" Text="View"></asp:LinkButton>
                            </div>
                            <div class="col-10 sg-button-right">
                                <telerik:RadButton ID="CancelButton" runat="server" Width="100px" Text="Close" TabIndex="12" CssClass="sg-button-submit" AutoPostBack="false" ValidationGroup="EditFreeLandSubmit" OnClientClicked="CloseWindow" UseSubmitBehavior="false" />
                                <telerik:RadButton ID="SubmitButton" runat="server" Width="100px" Text="Submit" TabIndex="11" CssClass="sg-button-submit" ValidationGroup="EditFreeLandSubmit" UseSubmitBehavior="false" OnClick="SubmitButton_Click" />
                            </div>
                        </div>
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
                    <telerik:RadWindow ID="ImageView_model" runat="server" Width="1024px" Height="600px" VisibleStatusbar="False"
                        Modal="true" VisibleTitlebar="false" Behaviors="None">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
        </div>
    </div>

    <asp:SqlDataSource ID="SqlDataSource_FreeLand" runat="server"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_FreeLandSELECT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="ID" Name="ID" Type="Int64"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_ProvincesList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_ProvincesSELECTALL" SelectCommandType="StoredProcedure" />

    <asp:SqlDataSource runat="server" ID="SqlDataSource_CityList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_CitySELECTALL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="EditFreeLandProvinceComboBox" PropertyName="SelectedValue" Name="ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_VillageList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_VillageSELECTALL" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="EditFreeLandCityComboBox" PropertyName="SelectedValue" Name="ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
