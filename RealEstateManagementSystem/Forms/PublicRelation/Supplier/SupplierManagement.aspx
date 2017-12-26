<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="SupplierManagement.aspx.vb" Inherits="RealEstateManagementSystem.SupplierManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
    <style>
        .colName {
            float: left;
            width: 40%;
        }

        .colGSM {
            float: left;
            width: 20%;
        }

        .colEmail {
            float: left;
            width: 40%;
        }
    </style>

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
    <div id="Master_Div" runat="server">
        <div class="wrapper">
            <msg:PopMsg ID="PopMsg" runat="server" />
            <div class="col-10 sg-header">
                <asp:Label ID="HeaderLabel" runat="server" Text="Supplier Management" />
            </div>
            <div class="col-row">
                <div class="col-8 col-push-10">
                    <div class="col-5">
                        <div class="sg-blockcontent-right">
                            <div class="col-5 sg-label">
                                <asp:Label ID="ContactNameLabel" runat="server" AssociatedControlID="ContactNameComboBox" Text="Contact Name" />
                            </div>
                            <div class="col-5 sg-label sg-text-align-right">
                                <asp:LinkButton ID="LinkButton1" runat="server" Text="Add New Contact" OnClick="AddNewContactLink_Click" OnSupplierClick="openRadWindow" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadComboBox ID="ContactNameComboBox" runat="server" CausesValidation="False" Width="100%" Height="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                    ItemRequestTimeout="0" DataSourceID="SqlDataSource_ContactList" DataTextField="ContactName" DataValueField="ID" ToolTip="Contact List" TabIndex="1">
                                    <HeaderTemplate>
                                        <ul>
                                            <li class="colName">Name</li>
                                            <li class="colGSM">GSM</li>
                                            <li class="colEmail">Email</li>
                                        </ul>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <ul>
                                            <li class="colName">
                                                <%# DataBinder.Eval(Container.DataItem, "ContactName")%></li>
                                            <li class="colGSM">
                                                <%# DataBinder.Eval(Container.DataItem, "ContactGSM1")%></li>
                                            <li class="colEmail">
                                                <%# DataBinder.Eval(Container.DataItem, "ContactEmail")%></li>
                                        </ul>
                                    </ItemTemplate>
                                </telerik:RadComboBox>
                                <asp:RequiredFieldValidator ID="ContactNameRequired" runat="server" ControlToValidate="ContactNameComboBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="SupplierStaffName1GSMLabel" runat="server" AssociatedControlID="SupplierStaffName1GSMTextBox" Text="Staff 1 GSM" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="SupplierStaffName1GSMTextBox" runat="server" Width="100%" ToolTip="Supplier Staff Name 1 GSM" TabIndex="3" />
                                <asp:RequiredFieldValidator ID="SupplierStaffName1GSMRequired" runat="server" ControlToValidate="SupplierStaffName1GSMTextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="SupplierStaffName2GSMLabel" runat="server" AssociatedControlID="SupplierStaffName2GSMTextBox" Text="Staff 2 GSM" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="SupplierStaffName2GSMTextBox" runat="server" Width="100%" ToolTip="Supplier Staff Name 2 GSM" TabIndex="5" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="SupplierDocumentLabel" runat="server" AssociatedControlID="SupplierDocumentUpload" Text="Commercial Register Attachment" />
                            </div>
                            <div class="col-10">
                                <telerik:RadAsyncUpload ID="SupplierDocumentUpload" runat="server" ToolTip="Upload the Attachments" MaxFileInputsCount="1" TabIndex="7" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="SubmitButton" />
                            </div>
                        </div>
                    </div>
                    <div class="col-5">
                        <div class="sg-blockcontent-left">
                            <div class="col-10 sg-label">
                                <asp:Label ID="SupplierStaffName1Label" runat="server" AssociatedControlID="SupplierStaffName1TextBox" Text="Staff Name 1" />
                            </div>
                            <div class="col-10 sg-textbox-required-field">
                                <telerik:RadTextBox ID="SupplierStaffName1TextBox" runat="server" Width="100%" ToolTip="Supplier Staff Name 1" TabIndex="2" />
                                <asp:RequiredFieldValidator ID="SupplierStaffName1Required" runat="server" ControlToValidate="SupplierStaffName1TextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="SupplierStaffName2Label" runat="server" AssociatedControlID="SupplierStaffName2TextBox" Text="Staff Name 2" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="SupplierStaffName2TextBox" runat="server" Width="100%" ToolTip="Supplier Staff Name 2" TabIndex="4" />
                            </div>
                            <div class="col-10 sg-label">
                                <asp:Label ID="SupplierMemoLabel" runat="server" AssociatedControlID="SupplierMemoTextBox" Text="Memo" />
                            </div>
                            <div class="col-10">
                                <telerik:RadTextBox ID="SupplierMemoTextBox" runat="server" Width="100%" TextMode="MultiLine" Height="115px" ToolTip="Supplier Memo" TabIndex="6" />
                            </div>
                        </div>
                    </div>
                    <div class="sg-button-right">
                        <telerik:RadButton ID="SubmitButton" runat="server" Text="Submit" CssClass="sg-button-submit" Width="100px" TabIndex="8" ValidationGroup="SubmitButton" OnClick="SubmitButton_Click" />
                    </div>
                </div>
            </div>
        </div>
        <div class="col-10 sg-radgrid">
            <telerik:RadGrid ID="SupplierRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0"
                DataSourceID="SqlDataSource_SupplierList" GridLines="None" OnItemDataBound="SupplierRadGrid_ItemDataBound"
                OnEditCommand="SupplierRadGrid_EditCommand" OnItemCommand="SupplierRadGrid_ItemCommand" OnUpdateCommand="SupplierRadGrid_UpdateCommand" AllowAutomaticUpdates="true">
                <MasterTableView DataSourceID="SqlDataSource_SupplierList" CommandItemDisplay="None" AllowPaging="true" PageSize="10" DataKeyNames="ID">
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
                        <telerik:GridBoundColumn Display="false" DataField="ID" UniqueName="ID" DataType="System.Int64" />
                        <telerik:GridBoundColumn Display="false" DataField="SupplierContactID" UniqueName="SupplierContactID" DataType="System.Int64" />
                        <telerik:GridBoundColumn DataField="ContactName" FilterControlWidth="100%" HeaderText="Contact Name" SortExpression="ContactName" UniqueName="ContactName" DataType="System.Int64"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter ContactName column">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SupplierStaffName1" FilterControlWidth="100%" HeaderText="Staff 1" SortExpression="SupplierStaffName1" UniqueName="SupplierStaffName1"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter SupplierStaffName1 column">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SupplierStaffName1GSM" FilterControlWidth="100%" HeaderText="Staff 1 GSM" SortExpression="SupplierStaffName1GSM" UniqueName="SupplierStaffName1GSM"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter SupplierStaffName1GSM column">
                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SupplierStaffName2" FilterControlWidth="100%" HeaderText="Staff 2" SortExpression="SupplierStaffName2" UniqueName="SupplierStaffName2"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter SupplierStaffName2 column">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SupplierStaffName2GSM" FilterControlWidth="100%" HeaderText="Staff 2 GSM" SortExpression="SupplierStaffName2GSM" UniqueName="SupplierStaffName2GSM"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter SupplierStaffName2GSM column">
                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="SupplierStatusName" FilterControlWidth="100%" HeaderText="Status" SortExpression="SupplierStatusName" UniqueName="SupplierStatusName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter SupplierStatusName column">
                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                            <HeaderStyle HorizontalAlign="Center" Width="40px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                        </telerik:GridButtonColumn>
                        <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Denied.png" CommandName="Freeze" UniqueName="Freeze" ButtonType="ImageButton">
                            <HeaderStyle HorizontalAlign="Center" Width="20px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings EditFormType="Template">
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column" />
                        <FormTemplate>
                            <div class="col-10 sg-header">
                                <asp:Label ID="HeaderLabel" runat="server" Text="Update Supplier Details" />
                            </div>
                            <div class="sg-blockcontent">
                                <div class="col-row">
                                    <div class="col-5">
                                        <div class="sg-blockcontent-right">
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactNameGridLabel" runat="server" AssociatedControlID="ContactNameGridComboBox" Text="Contact Name" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadComboBox ID="ContactNameGridComboBox" runat="server" TabIndex="9" CausesValidation="False" Width="100%" Height="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                                    ItemRequestTimeout="0" DataSourceID="SqlDataSource_ContactList" DataTextField="ContactName" DataValueField="ID" SelectedValue='<%# Bind("SupplierContactID") %>'>
                                                    <HeaderTemplate>
                                                        <ul>
                                                            <li class="colName">Name</li>
                                                            <li class="colGSM">GSM</li>
                                                            <li class="colEmail">Email</li>
                                                        </ul>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <ul>
                                                            <li class="colName">
                                                                <%# DataBinder.Eval(Container.DataItem, "ContactName")%></li>
                                                            <li class="colGSM">
                                                                <%# DataBinder.Eval(Container.DataItem, "ContactGSM1")%></li>
                                                            <li class="colEmail">
                                                                <%# DataBinder.Eval(Container.DataItem, "ContactEmail")%></li>
                                                        </ul>
                                                    </ItemTemplate>
                                                </telerik:RadComboBox>
                                                <asp:RequiredFieldValidator ID="ContactNameGridrequired" runat="server" ControlToValidate="ContactNameGridComboBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="SupplierStaffName1GSMGridLabel" runat="server" AssociatedControlID="SupplierStaffName1GSMGridTextBox" Text="Staff 1 GSM" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadTextBox ID="SupplierStaffName1GSMGridTextBox" runat="server" Width="100%" ToolTip="Supplier Staff Name 1 GSM" TabIndex="11" Text='<%# Bind("SupplierStaffName1GSM") %>' />
                                                <asp:RequiredFieldValidator ID="SupplierStaffName1GSMGridRequired" runat="server" ControlToValidate="SupplierStaffName1GSMGridTextBox" CssClass="field-validation-error" ValidationGroup="GridSubmitButton" />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="SupplierStaffName2GSMGridLabel" runat="server" AssociatedControlID="SupplierStaffName2GSMGridTextBox" Text="Staff 2 GSM" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="SupplierStaffName2GSMGridTextBox" runat="server" Width="100%" ToolTip="Supplier Staff Name 2 GSM" TabIndex="13" Text='<%# Bind("SupplierStaffName2GSM")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="SupplierDocumentGridLabel" runat="server" AssociatedControlID="SupplierDocumentGridUpload" Text="Commercial Register Attachment" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadAsyncUpload ID="SupplierDocumentGridUpload" runat="server" TabIndex="15" ToolTip="Upload the Attachments" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="GridSubmitButton" />
                                                <asp:HyperLink ID="SupplierDocumentGridLink" runat="server" Text="View Attachment" Target="_blank" NavigateUrl='<%# Bind("SupplierDocument")%>' TabIndex="15" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-5">
                                        <div class="sg-blockcontent-left">
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="SupplierStaffName1GridLabel" runat="server" AssociatedControlID="SupplierStaffName1GridTextBox" Text="Staff Name 1" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadTextBox ID="SupplierStaffName1GridTextBox" runat="server" Width="100%" ToolTip="Supplier Staff Name 1" TabIndex="10" Text='<%# Bind("SupplierStaffName1") %>' />
                                                <asp:RequiredFieldValidator ID="SupplierStaffName1GridRequired" runat="server" ControlToValidate="SupplierStaffName1GridTextBox" CssClass="field-validation-error" ValidationGroup="GridSubmitButton" />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="SupplierStaffName2GridLabel" runat="server" AssociatedControlID="SupplierStaffName2GridTextBox" Text="Staff Name 2" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="SupplierStaffName2GridTextBox" runat="server" Width="100%" TabIndex="12" ToolTip="Supplier Staff Name 2" Text='<%# Bind("SupplierStaffName2")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="SupplierMemoGridLabel" runat="server" AssociatedControlID="SupplierMemoGridTextBox" Text="Memo" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="SupplierMemoGridTextBox" runat="server" Width="100%" TextMode="MultiLine" TabIndex="14" Height="110px" ToolTip="Supplier Memo" Text='<%# Bind("SupplierMemo") %>' />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sg-button-right">
                                    <telerik:RadButton ID="GridSubmitButton" runat="server" TabIndex="16" CssClass="sg-button-submit" Width="100px" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Add", "Update")%>'
                                        CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' ValidationGroup="GridSubmitButton" />
                                    <telerik:RadButton ID="CancelButton" Width="100px" Text="Cancel" runat="server" TabIndex="17" CssClass="sg-button-submit" CausesValidation="False" CommandName="Cancel" />
                                </div>
                            </div>
                        </FormTemplate>
                    </EditFormSettings>
                    <PagerStyle AlwaysVisible="True" Mode="NextPrevNumericAndAdvanced" />
                </MasterTableView>
                <FilterItemStyle HorizontalAlign="Center" />
                <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Bottom" AlwaysVisible="true" />
                <FilterMenu EnableImageSprites="False" EnableSelection="True" />
            </telerik:RadGrid>
        </div>
        <telerik:RadWindowManager ID="RadWindowManager_modalPopup" runat="server" EnableViewState="false">
            <Windows>
                <telerik:RadWindow ID="modalPopup" runat="server" Width="1200px" Height="260px" VisibleStatusbar="false"
                    Modal="true" VisibleTitlebar="false" Behaviors="None"
                    NavigateUrl="~/Forms/PublicRelation/Contact/ContactManagementAddWindow.aspx">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>
    </div>
    <asp:SqlDataSource runat="server" ID="SqlDataSource_ContactList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_ContactSELECTALL" SelectCommandType="StoredProcedure" />

    <asp:SqlDataSource ID="SqlDataSource_SupplierList" runat="server"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        OnUpdating="SqlDataSource_SupplierList_OnUpdating"
        SelectCommand="PROC_APP_SuppliersSELECTALL" SelectCommandType="StoredProcedure"
        UpdateCommand="PROC_APP_SuppliersUPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int64" />
            <asp:Parameter Name="SupplierContactID" Type="Int64" />
            <asp:Parameter Name="SupplierStaffName1" Type="String" />
            <asp:Parameter Name="SupplierStaffName2" Type="String" />
            <asp:Parameter Name="SupplierStaffName1GSM" Type="String" />
            <asp:Parameter Name="SupplierStaffName2GSM" Type="String" />
            <asp:Parameter Name="SupplierDocument" Type="String" />
            <asp:Parameter Name="SupplierMemo" Type="String" />
            <asp:Parameter Name="SupplierUpdatedDate" Type="DateTime" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>


<%-- 0e115313-965d-4d7c-8bca-a7c7ea73dd4d --%>