<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="OwnerManagement.aspx.vb" Inherits="RealEstateManagementSystem.OwnerManagement" %>

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
                    <asp:Label ID="HeaderLabel" runat="server" Text="Owner Management" />
                </div>
            <div class="col-row">
                  <div class="col-8 col-push-10">
                <div class="col-5">
                    <div class="sg-blockcontent-right">
                        <div class="col-5 sg-label">
                            <asp:Label ID="ContactNameLabel" runat="server" AssociatedControlID="ContactNameComboBox" Text="Contact Name" />
                        </div>
                        <div class="col-5 sg-label sg-text-align-right">
                            <asp:LinkButton ID="AddNewContactLink" runat="server" Text="Add New Contact" OnClick="AddNewContactLink_Click" OnOwnerClick="openRadWindow" />
                        </div>
                        <div class="col-sg sg-textbox-required-field">
                            <telerik:RadComboBox ID="ContactNameComboBox" runat="server" CausesValidation="False" Width="100%" Height="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                ItemRequestTimeout="0" DataSourceID="SqlDataSource_ContactList" DataTextField="ContactName" DataValueField="ID" ToolTip ="Contact List" TabIndex ="1">
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
                            <asp:Label ID="OwnerStaffName1GSMLabel" runat="server" AssociatedControlID="OwnerStaffName1GSMTextBox" Text="Staff 1 GSM" />
                        </div>
                        <div class="col-10 sg-textbox-required-field">
                            <telerik:RadTextBox ID="OwnerStaffName1GSMTextBox" runat="server" Width="100%" ToolTip="Owner Staff Name 1 GSM" TabIndex="3"/>
                            <asp:RequiredFieldValidator ID="OwnerStaffName1GSMrequired" runat="server" ControlToValidate="OwnerStaffName1GSMTextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                        </div>
                         <div class="col-10 sg-label">
                            <asp:Label ID="OwnerStaffName2GSMLabel" runat="server" AssociatedControlID="OwnerStaffName2GSMTextBox" Text="Staff 2 GSM" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="OwnerStaffName2GSMTextBox" runat="server" Width="100%" ToolTip="Owner Staff Name 2 GSM" TabIndex="5"/>
                        </div>

                        <div class="col-10 sg-label">
                            <asp:Label ID="OwnerDocumentLabel" runat="server" AssociatedControlID="OwnerDocumentUpload" Text="Commercial Register Attachment" />
                        </div>
                        <div class="col-10">
                            <telerik:RadAsyncUpload ID="OwnerDocumentUpload" runat="server" ToolTip="Upload the Attachments" MaxFileInputsCount="1" TabIndex="7" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="SubmitButton" />
                        </div>
                    </div>
                </div>
                <div class="col-5">
                    <div class="sg-blockcontent-left">
                        <div class="col-10 sg-label">
                            <asp:Label ID="OwnerStaffName1Label" runat="server" AssociatedControlID="OwnerStaffName1TextBox" Text="Staff Name 1" />
                        </div>
                        <div class="col-10 sg-textbox-required-field">
                            <telerik:RadTextBox ID="OwnerStaffName1TextBox" runat="server" Width="100%" ToolTip="Owner Staff Name 1" TabIndex="2"/>
                            <asp:RequiredFieldValidator ID="OwnerStaffName1Required" runat="server" ControlToValidate="OwnerStaffName1TextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                        </div>
                         <div class="col-10 sg-label">
                            <asp:Label ID="OwnerStaffName2Label" runat="server" AssociatedControlID="OwnerStaffName2TextBox" Text="Staff Name 2" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="OwnerStaffName2TextBox" runat="server" Width="100%" ToolTip="Owner Staff Name 2" TabIndex="4"/>
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="OwnerMemoLabel" runat="server" AssociatedControlID="OwnerMemoTextBox" Text="Memo" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="OwnerMemoTextBox" runat="server" Width="100%" TextMode="MultiLine" Height="115px" ToolTip="Owner Memo" TabIndex="6" />
                        </div>
                    </div>
                </div>
                <div class="col-10 sg-button-right">
                    <telerik:RadButton ID="SubmitButton" runat="server" Text="Submit" CssClass="sg-button-submit" TabIndex="8" Width="100px" ValidationGroup="SubmitButton" OnClick="SubmitButton_Click" />
                </div>
                      </div> 
            </div>
            <div class="col-10 sg-radgrid">
                <telerik:RadGrid ID="OwnerRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0"
                    DataSourceID="SqlDataSource_OwnerList" GridLines="None" OnItemDataBound="OwnerRadGrid_ItemDataBound"
                    OnEditCommand="OwnerRadGrid_EditCommand" OnItemCommand="OwnerRadGrid_ItemCommand" OnUpdateCommand="OwnerRadGrid_UpdateCommand" AllowAutomaticUpdates="true">
                    <MasterTableView DataSourceID="SqlDataSource_OwnerList" CommandItemDisplay="None" AllowPaging="true" PageSize="10" DataKeyNames="ID">
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
                            <telerik:GridBoundColumn Display="false" DataField="OwnerContactID" UniqueName="OwnerContactID" DataType="System.Int64" />
                            <telerik:GridBoundColumn DataField="ContactName" FilterControlWidth="100%" HeaderText="Contact Name" SortExpression="ContactName" UniqueName="ContactName" DataType="System.Int64"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter ContactName column">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="OwnerStaffName1" FilterControlWidth="100%" HeaderText="Staff 1" SortExpression="OwnerStaffName1" UniqueName="OwnerStaffName1"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter OwnerStaffName1 column">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="OwnerStaffName1GSM" FilterControlWidth="100%" HeaderText="Staff 1 GSM" SortExpression="OwnerStaffName1GSM" UniqueName="OwnerStaffName1GSM"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter OwnerStaffName1GSM column">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="OwnerStaffName2" FilterControlWidth="100%" HeaderText="Staff 2" SortExpression="OwnerStaffName2" UniqueName="OwnerStaffName2"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter OwnerStaffName2 column">
                                <HeaderStyle HorizontalAlign="Center" Width="150px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="OwnerStaffName2GSM" FilterControlWidth="100%" HeaderText="Staff 2 GSM" SortExpression="OwnerStaffName2GSM" UniqueName="OwnerStaffName2GSM"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter OwnerStaffName2GSM column">
                                <HeaderStyle HorizontalAlign="Center" Width="50px" />
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="OwnerStatusName" FilterControlWidth="100%" HeaderText="Status" SortExpression="OwnerStatusName" UniqueName="OwnerStatusName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter OwnerStatusName column">
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
                                    <asp:Label ID="HeaderLabel" runat="server" Text="Update Owner Details" />
                                </div>
                                    <div class="col-row">
                                        <div class="col-5">
                                            <div class="sg-blockcontent-right">
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="ContactNameGridLabel" runat="server" AssociatedControlID="ContactNameGridComboBox" Text="Contact Name" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadComboBox ID="ContactNameGridComboBox" runat="server" CausesValidation="False" TabIndex="9" Width="100%" Height="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                                        ItemRequestTimeout="0" DataSourceID="SqlDataSource_ContactList" DataTextField="ContactName" DataValueField="ID" SelectedValue='<%# Bind("OwnerContactID") %>'>
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
                                                    <asp:RequiredFieldValidator ID="ContactNameGridRequired" runat="server" ControlToValidate="ContactNameGridComboBox" CssClass="field-validation-error" ValidationGroup="GridSubmitButton" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="OwnerStaffName1GSMGridLabel" runat="server" AssociatedControlID="OwnerStaffName1GSMGridTextBox" Text="Staff 1 GSM" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="OwnerStaffName1GSMGridTextBox" runat="server" Width="100%" ToolTip="Owner Staff Name 1 GSM" TabIndex="11" Text='<%# Bind("OwnerStaffName1GSM") %>' />
                                                    <asp:RequiredFieldValidator ID="OwnerStaffName1GSMGridRequired" runat="server" ControlToValidate="OwnerStaffName1GSMGridTextBox" CssClass="field-validation-error" ValidationGroup="GridSubmitButton" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="OwnerStaffName2GSMGridLabel" runat="server" AssociatedControlID="OwnerStaffName2GSMGridTextBox" Text="Staff 2 GSM" />
                                                </div>
                                                <div class="col-10">
                                                    <telerik:RadTextBox ID="OwnerStaffName2GSMGridTextBox" runat="server" Width="100%" ToolTip="Owner Staff Name 2 GSM" TabIndex="13" Text='<%# Bind("OwnerStaffName2GSM")%>' />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="OwnerDocumentGridLabel" runat="server" AssociatedControlID="OwnerDocumentGridUpload" Text="Commercial Register Attachment" />
                                                </div>
                                                <div class="col-10">
                                                    <telerik:RadAsyncUpload ID="OwnerDocumentGridUpload" runat="server" TabIndex="15" ToolTip="Upload the Attachments" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="GridSubmitButton" />
                                                    <asp:HyperLink ID="OwnerDocumentGridLink" runat="server" Text="View Attachment" TabIndex="15" Target="_blank" NavigateUrl='<%# Bind("OwnerDocument")%>' />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-5">
                                            <div class="sg-blockcontent-left">
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="OwnerStaffName1GridLabel" runat="server" AssociatedControlID="OwnerStaffName1GridTextBox" Text="Staff Name 1" />
                                                </div>
                                                <div class="col-10 sg-textbox-required-field">
                                                    <telerik:RadTextBox ID="OwnerStaffName1GridTextBox" runat="server" Width="100%" ToolTip="Owner Staff Name 1" TabIndex="10" Text='<%# Bind("OwnerStaffName1") %>' />
                                                    <asp:RequiredFieldValidator ID="OwnerStaffName1GridRequired" runat="server" ControlToValidate="OwnerStaffName1GridTextBox" CssClass="field-validation-error" ValidationGroup="GridSubmitButton" />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="OwnerStaffName2GridLabel" runat="server" AssociatedControlID="OwnerStaffName2GridTextBox" Text="Staff Name 2" />
                                                </div>
                                                <div class="col-10">
                                                    <telerik:RadTextBox ID="OwnerStaffName2GridTextBox" runat="server" Width="100%" ToolTip="Owner Staff Name 2" TabIndex="12" Text='<%# Bind("OwnerStaffName2")%>' />
                                                </div>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="OwnerMemoGridLabel" runat="server" AssociatedControlID="OwnerMemoGridTextBox" Text="Memo" />
                                                </div>
                                                <div class="col-10">
                                                    <telerik:RadTextBox ID="OwnerMemoGridTextBox" runat="server" Width="100%" TextMode="MultiLine" Height="110px" TabIndex="14" ToolTip="Owner Memo" Text='<%# Bind("OwnerMemo") %>' />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="sg-button-right">
                                             <telerik:RadButton ID="GridSubmitButton" runat="server" CssClass ="sg-button-submit" TabIndex="16" Width="100px" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Add", "Update")%>'
                                            CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' ValidationGroup="GridSubmitButton" />
                                        <telerik:RadButton ID="CancelButton" Width="100px" Text="Cancel" runat="server" CausesValidation="False" CssClass ="sg-button-submit" TabIndex="17" CommandName="Cancel" />
                                        </div>
                                       
                                    </div>
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
    </div>

    <asp:SqlDataSource runat="server" ID="SqlDataSource_ContactList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_ContactSELECTALL" SelectCommandType="StoredProcedure" />

    <asp:SqlDataSource ID="SqlDataSource_OwnerList" runat="server"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        OnUpdating="SqlDataSource_OwnerList_OnUpdating"
        SelectCommand="PROC_APP_OwnersSELECTALL" SelectCommandType="StoredProcedure"
        UpdateCommand="PROC_APP_OwnersUPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int64" />
            <asp:Parameter Name="OwnerContactID" Type="Int64" />
            <asp:Parameter Name="OwnerStaffName1" Type="String" />
            <asp:Parameter Name="OwnerStaffName2" Type="String" />
            <asp:Parameter Name="OwnerStaffName1GSM" Type="String" />
            <asp:Parameter Name="OwnerStaffName2GSM" Type="String" />
            <asp:Parameter Name="OwnerDocument" Type="String" />
            <asp:Parameter Name="OwnerMemo" Type="String" />
            <asp:Parameter Name="OwnerUpdatedDate" Type="DateTime" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>


<%-- 0e115313-965d-4d7c-8bca-a7c7ea73dd4d --%>