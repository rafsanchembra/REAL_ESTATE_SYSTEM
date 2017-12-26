<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="ClientManagement.aspx.vb" Inherits="RealEstateManagementSystem.ClientManagement" %>

<asp:Content ID="Content4" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
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
        function closeRadWindow() {
            $find("<%= RadAjaxManagerMain.ClientID %>").ajaxRequest();
        }
    </script>

</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="headerPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content6" ContentPlaceHolderID="featuredPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainPlaceHolder" runat="server">
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
            <div class="col-row">
                <div class="col-10 sg-header">
                    <asp:Label ID="HeaderLabel" runat="server" Text="Client Management" />
                </div>
                  <div class="col-8 col-push-10">
                <div class="col-5">
                    <div class="sg-blockcontent-right">
                        <div class="col-5 sg-label">
                            <asp:Label ID="ContactNameLabel" runat="server" AssociatedControlID="ContactNameComboBox" Text="Contact Name" />
                        </div>
                         <div class="col-5 sg-label sg-text-align-right">
                            <asp:LinkButton ID="AddNewContactLink" runat="server" Text="Add New Contact" OnClick="AddNewContactLink_Click" OnClientClick="openRadWindow" />
                        </div>
                        <div class="col-10 sg-textbox-required-field">
                            <telerik:RadComboBox ID="ContactNameComboBox" runat="server" CausesValidation="False" Width="100%"  MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
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
                                            <%# DataBinder.Eval(Container.DataItem, "CompleteContactGSM1")%></li>
                                        <li class="colEmail">
                                            <%# DataBinder.Eval(Container.DataItem, "ContactEmail")%></li>
                                    </ul>
                                </ItemTemplate>
                            </telerik:RadComboBox>
                            <asp:RequiredFieldValidator ID="ContactNameRequired" runat="server" ControlToValidate="ContactNameComboBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ClientStaffName1GSMLabel" runat="server" AssociatedControlID="ClientStaffName1GSMTextBox" Text="Staff 1 GSM" />
                        </div>
                        <div class="col-10 sg-textbox-required-field">
                            <telerik:RadTextBox ID="ClientStaffName1GSMTextBox" runat="server" Width="100%" ToolTip="Client Staff Name 1 GSM" TabIndex ="3" />
                            <asp:RequiredFieldValidator ID="ClientStaffName1GSMRequired" runat="server" ControlToValidate="ClientStaffName1GSMTextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ClientStaffName2GSMLabel" runat="server" AssociatedControlID="ClientStaffName2GSMTextBox" Text="Staff 2 GSM" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ClientStaffName2GSMTextBox" runat="server" Width="100%" ToolTip="Client Staff Name 2 GSM" TabIndex ="5"/>
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ClientDocumentLabel" runat="server" AssociatedControlID="ClientDocumentUpload" Text="Commercial Register Attachment" />
                        </div>
                        <div class="col-10">
                           <telerik:RadAsyncUpload ID="ClientDocumentUpload" runat="server" ToolTip="Upload the Attachments" MaxFileInputsCount="1" TabIndex="7" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="SubmitButton" />
                        </div>
                    </div>
                </div>
                <div class="col-5">
                    <div class="sg-blockcontent-left">
                        <div class="col-10 sg-label">
                            <asp:Label ID="ClientStaffName1Label" runat="server" AssociatedControlID="ClientStaffName1TextBox" Text="Staff Name 1" />
                        </div>
                        <div class="col-10 sg-textbox-required-field">
                            <telerik:RadTextBox ID="ClientStaffName1TextBox" runat="server" Width="100%" ToolTip="Client Staff Name 1" TabIndex ="2" />
                            <asp:RequiredFieldValidator ID="ClientStaffName1Required" runat="server" ControlToValidate="ClientStaffName1TextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                        </div>

                        <div class="col-10 sg-label">
                            <asp:Label ID="ClientStaffName2Label" runat="server" AssociatedControlID="ClientStaffName2TextBox" Text="Staff Name 2" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ClientStaffName2TextBox" runat="server" Width="100%" ToolTip="Client Staff Name 2" TabIndex ="4" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ClientMemoLabel" runat="server" AssociatedControlID="ClientMemoTextBox" Text="Memo" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ClientMemoTextBox" runat="server" Width="100%" TextMode="MultiLine" Height="110px" ToolTip="Client Memo" TabIndex ="6" />
                        </div>
                    </div>
                </div>
                <div class="sg-button-right">
                    <telerik:RadButton ID="SubmitButton" runat="server" Text="Submit" Width="100px" ValidationGroup="SubmitButton" TabIndex ="8" CssClass="sg-button-submit" OnClick="SubmitButton_Click" />
                </div>
                      </div> 
            </div>
        </div>
        <div class="col-row sg-radgrid">
            <telerik:RadGrid ID="ClientRadGrid" runat="server" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0"
                DataSourceID="SqlDataSource_ClientList" GridLines="None" OnItemDataBound="ClientRadGrid_ItemDataBound"
                OnEditCommand="ClientRadGrid_EditCommand" OnItemCommand="ClientRadGrid_ItemCommand" OnUpdateCommand="ClientRadGrid_UpdateCommand" AllowAutomaticUpdates="true">
                <MasterTableView DataSourceID="SqlDataSource_ClientList" CommandItemDisplay="None" AllowPaging="true" PageSize="10" DataKeyNames="ID">
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
                        <telerik:GridBoundColumn Display="false" DataField="ClientContactID" UniqueName="ClientContactID" DataType="System.Int64" />
                        <telerik:GridBoundColumn DataField="ContactName" FilterControlWidth="100%" HeaderText="Contact Name" SortExpression="ContactName" UniqueName="ContactName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter ContactName column">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ClientStaffName1" FilterControlWidth="100%" HeaderText="Staff 1" SortExpression="ClientStaffName1" UniqueName="ClientStaffName1"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter ClientStaffName1 column">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ClientStaffName1GSM" FilterControlWidth="100%" HeaderText="Staff 1 GSM" SortExpression="ClientStaffName1GSM" UniqueName="ClientStaffName1GSM"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter ClientStaffName1GSM column">
                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ClientStaffName2" FilterControlWidth="100%" HeaderText="Staff 2" SortExpression="ClientStaffName2" UniqueName="ClientStaffName2"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter ClientStaffName2 column">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ClientStaffName2GSM" FilterControlWidth="100%" HeaderText="Staff 2 GSM" SortExpression="ClientStaffName2GSM" UniqueName="ClientStaffName2GSM"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter ClientStaffName2GSM column">
                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ClientStatusName" FilterControlWidth="100%" HeaderText="Status" SortExpression="ClientStatusName" UniqueName="ClientStatusName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" FilterControlAltText="Filter ClientStatusName column">
                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                            <HeaderStyle HorizontalAlign="Center" Width="40px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                        </telerik:GridButtonColumn>
                        <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Delete.png" CommandName="Freeze" UniqueName="Freeze" ButtonType="ImageButton">
                            <HeaderStyle HorizontalAlign="Center" Width="20px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings EditFormType="Template">
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column" />
                        <FormTemplate>
                            <div class="col-10 sg-header">
                                <asp:Label ID="HeaderLabel" runat="server" Text="Update Client Details" />
                            </div>
                                <div class="col-row">
                                    <div class="col-5">
                                        <div class="sg-blockcontent-right">
                                            <div class="col-5 sg-label">
                                                <asp:Label ID="ContactNameGridLabel" runat="server" AssociatedControlID="ContactNameGridComboBox" Text="Contact Name" />
                                            </div>
                                             <div class="col-5 sg-label sg-text-align-right">
                                                <asp:LinkButton ID="AddNewContactGridLink" runat="server" Text="Add New Contact" OnClick="AddNewContactLink_Click" OnClientClick="openRadWindow" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadComboBox ID="ContactNameGridComboBox" runat="server" CausesValidation="False" TabIndex ="9" Width="100%" Height="200px" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains"
                                                    ItemRequestTimeout="0" DataSourceID="SqlDataSource_ContactList" DataTextField="ContactName" DataValueField="ID" SelectedValue='<%# Bind("ClientContactID") %>'>
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
                                                <asp:Label ID="ClientStaffName1GSMGridLabel" runat="server" AssociatedControlID="ClientStaffName1GSMGridTextBox" Text="Staff 1 GSM" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadTextBox ID="ClientStaffName1GSMGridTextBox" runat="server" Width="100%"  ToolTip="Client Staff Name 1 GSM" Text='<%# Bind("ClientStaffName1GSM") %>' TabIndex="11"/>
                                                <asp:RequiredFieldValidator ID="ClientStaffName1GSMGridRequired" runat="server" ControlToValidate="ClientStaffName1GSMGridTextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ClientStaffName2GSMGridLabel" runat="server" AssociatedControlID="ClientStaffName2GSMGridTextBox" Text="Staff 2 GSM" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ClientStaffName2GSMGridTextBox" runat="server" Width="100%" ToolTip="Client Staff Name 2 GSM" TabIndex="13" Text='<%# Bind("ClientStaffName1GSM")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ClientDocumentGridLabel" runat="server" AssociatedControlID="ClientDocumentGridUpload" Text="Commercial Register Attachment" />
                                            </div>
                                            <div class="col-5">
                                                <telerik:RadAsyncUpload ID="ClientDocumentGridUpload" runat="server" TabIndex="15" ToolTip="Upload the Attachments" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="GridSubmitButton" />
                                                <asp:HyperLink ID="ClientDocumentGridLink" runat="server" Text="View Attachment" Target="_blank" NavigateUrl='<%# Bind("ClientDocument")%>' TabIndex="15"  />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-5">
                                        <div class="sg-blockcontent-left">

                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ClientStaffName1GridLabel" runat="server" AssociatedControlID="ClientStaffName1GridTextBox" Text="Staff Name 1" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadTextBox ID="ClientStaffName1GridTextBox" runat="server" Width="100%" ToolTip="Client Staff Name 1" TabIndex="10" Text='<%# Bind("ClientStaffName1") %>' />
                                                <asp:RequiredFieldValidator ID="ClientStaffName1GridRequired" runat="server" ControlToValidate="ClientStaffName1GridTextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ClientStaffName2GridLabel" runat="server" AssociatedControlID="ClientStaffName2GridTextBox" Text="Staff Name 2" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ClientStaffName2GridTextBox" runat="server" Width="100%" ToolTip="Client Staff Name 2" TabIndex="12" Text='<%# Bind("ClientStaffName2")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ClientMemoGridLabel" runat="server" AssociatedControlID="ClientMemoGridTextBox" Text="Memo" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ClientMemoGridTextBox" runat="server" Width="100%" TextMode="MultiLine" Height="130px" ToolTip="Client Memo" TabIndex="14" Text='<%# Bind("ClientMemo") %>' />
                                            </div>
                                        </div>
                                        <div class="col-10 sg-button-right">
                                            <telerik:RadButton ID="GridSubmitButton" runat="server" Width="100px" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Add", "Update")%>'
                                                CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' ValidationGroup="GridSubmitButton" CssClass="sg-button-submit" TabIndex="16" />
                                            <telerik:RadButton ID="CancelButton" Width="100px" Text="Cancel" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="sg-button-submit" TabIndex="17" />
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
                <telerik:RadWindow ID="modalPopup" runat="server" Width="1200px" Height="312px" VisibleStatusbar="false"
                    Modal="true" VisibleTitlebar="false" Behaviors="None" Animation="Fade" VisibleOnPageLoad="false" 
                    DestroyOnClose="true" NavigateUrl="~/Forms/PublicRelation/Contact/ContactManagementAddWindow.aspx">
                </telerik:RadWindow>
            </Windows>
        </telerik:RadWindowManager>

    </div>
    <asp:SqlDataSource runat="server" ID="SqlDataSource_ContactList"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        SelectCommand="PROC_APP_ContactSELECTALL" SelectCommandType="StoredProcedure" />


    <asp:SqlDataSource ID="SqlDataSource_ClientList" runat="server"
        ConnectionString='<%$ ConnectionStrings:RealEstateManagementSystemDataBaseConnection %>'
        OnUpdating="SqlDataSource_ClientList_OnUpdating"
        SelectCommand="PROC_APP_ClientsSELECTALL" SelectCommandType="StoredProcedure"
        UpdateCommand="PROC_APP_ClientsUPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int64" />
            <asp:Parameter Name="ClientContactID" Type="Int64" />
            <asp:Parameter Name="ClientStaffName1" Type="String" />
            <asp:Parameter Name="ClientStaffName2" Type="String" />
            <asp:Parameter Name="ClientStaffName1GSM" Type="String" />
            <asp:Parameter Name="ClientStaffName2GSM" Type="String" />
            <asp:Parameter Name="ClientDocument" Type="String" />
            <asp:Parameter Name="ClientMemo" Type="String" />
            <asp:Parameter Name="ClientUpdatedDate" Type="DateTime" />
            <asp:Parameter Name="ClientStatus" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
