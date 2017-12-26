<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="ContactManagement.aspx.vb" Inherits="RealEstateManagementSystem.ContactManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
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
    <div id="Master_Div" runat="server">
        <div class="wrapper">
            <msg:PopMsg ID="PopMsg" runat="server" />
            <div class="col-row">
                  <div class="col-8 col-push-10">
                <div class="col-10 sg-header">
                    <asp:Label ID="HeaderLabel" runat="server" Text="Contact Management" />
                </div>
                <div class="col-5">
                    <div class="sg-blockcontent-right">
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactNameLabel" runat="server" AssociatedControlID="ContactNameTextBox" Text="Name" />
                        </div>
                        <div class="col-10 sg-textbox-required-field">
                            <telerik:RadTextBox ID="ContactNameTextBox" runat="server" Width="100%" ToolTip="Contact Name" TabIndex="1" />
                            <asp:RequiredFieldValidator ID="ContactNameRequired" runat="server" ControlToValidate="ContactNameTextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactGSM1Label" runat="server" AssociatedControlID="ContactGSM1TextBox" Text="GSM 1" />
                        </div>
                        <div class="col-10 sg-textbox-required-field">
                            <telerik:RadComboBox runat="server" ID="ContactGSM1ContryCodeCombobox" TabIndex="3" AppendDataBoundItems="True" CausesValidation="False" CollapseDelay="10" DataMember="DefaultView"
                                Width="29%" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains" OnClientSelectedIndexChanged="GSM1_OnClientSelectedIndexChanged">
                                <Items>
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Oman.png" Text="Oman    +968" Value="968" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/UAE.png" Text="Emirates    +971" Value="971" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Saudi.png" Text="Saudi    +966" Value="966" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Kuwait.png" Text="Kuwait    +965" Value="965" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Qatar.png" Text="Qatar    +974" Value="974" />
                                </Items>
                            </telerik:RadComboBox>
                            <telerik:RadTextBox ID="ContactGSM1TextBox" runat="server" Enabled="false" TabIndex="4" Width="70%" ToolTip="Contact GSM 2" />
                            <asp:RequiredFieldValidator ID="ContactGSM1Required" runat="server" ControlToValidate="ContactGSM1TextBox" CssClass="field-validation-error" ValidationGroup="SubmitButton" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactIdentityNumberLabel" runat="server" AssociatedControlID="ContactIdentityNumberTextBox" Text="Identity Number" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactIdentityNumberTextBox" runat="server" Width="100%" ToolTip="Contact Identity Number" TabIndex="7" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactCommercialRegisterNumberLabel" runat="server" AssociatedControlID="ContactCommercialRegisterNumberTextBox" Text="Commercial Register Number" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactCommercialRegisterNumberTextBox" runat="server" Width="100%" ToolTip="Contact Commercial Register Number" TabIndex="9" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactEmailLabel" runat="server" AssociatedControlID="ContactEmailTextBox" Text="Email" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactEmailTextBox" runat="server" Width="100%" ToolTip="Contact Email" TabIndex="11" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactLatitudeCoordinatesLabel" runat="server" AssociatedControlID="ContactLatitudeCoordinatesTextBox" Text="Latitude Co-ordinates" />
                        </div>
                        <div class="col-10">
                            <telerik:RadNumericTextBox ID="ContactLatitudeCoordinatesTextBox" runat="server" Width="100%" ToolTip="Contact Latitude Co-ordinates" TabIndex="13">
                                <NumberFormat DecimalDigits="6" AllowRounding="false" />
                            </telerik:RadNumericTextBox>
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactOfficeFaxLabel" runat="server" AssociatedControlID="ContactOfficeFaxTextBox" Text="Office Fax" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactOfficeFaxTextBox" runat="server" Width="100%" ToolTip="Contact Office Fax" TabIndex="15" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactPOBoxLabel" runat="server" AssociatedControlID="ContactPOBoxTextBox" Text="PO Box" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactPOBoxTextBox" runat="server" Width="100%" ToolTip="Contact PO Box" TabIndex="16" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactURLMapLabel" runat="server" AssociatedControlID="ContactURLMapTextBox" Text="Map URL" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactURLMapTextBox" runat="server" Width="100%" ToolTip="Contact Map URl" TabIndex="18" />
                        </div>
                    </div>
                </div>
                <div class="col-5">
                    <div class="sg-blockcontent-left">
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactNickNameLabel" runat="server" AssociatedControlID="ContactNickNameComboBox" Text="Nick Name" />
                        </div>
                        <div class="col-10">
                            <telerik:RadComboBox ID="ContactNickNameComboBox" runat="server" CausesValidation="False" Width="100%" MarkFirstMatch="True"
                                ItemRequestTimeout="0" DropDownAutoWidth="Disabled" TabIndex="2">
                                <Items>
                                    <telerik:RadComboBoxItem runat="server" Text="الفاضل" Value="الفاضل" />
                                    <telerik:RadComboBoxItem runat="server" Text="معالي" Value="معالي" />
                                    <telerik:RadComboBoxItem runat="server" Text="سماحة الشيخ" Value="سماحة الشيخ" />
                                    <telerik:RadComboBoxItem runat="server" Text="الشيخ" Value="الشيخ" />
                                    <telerik:RadComboBoxItem runat="server" Text="معالي الشيخ" Value="معالي الشيخ" />
                                    <telerik:RadComboBoxItem runat="server" Text="سعادة الشيخ" Value="سعادةالشيخ" />
                                    <telerik:RadComboBoxItem runat="server" Text="سعادة" Value="سعادة" />
                                    <telerik:RadComboBoxItem runat="server" Text="المكرم" Value="المكرم" />
                                    <telerik:RadComboBoxItem runat="server" Text="فضيلة" Value="فضيلة" />
                                    <telerik:RadComboBoxItem runat="server" Text="فضيلة الشيخ" Value="فضيلة الشيخ" />
                                    <telerik:RadComboBoxItem runat="server" Text="الأفاضل" Value="الأفاضل" />
                                    <telerik:RadComboBoxItem runat="server" Text="الدكتور" Value="الدكتور" />
                                    <telerik:RadComboBoxItem runat="server" Text="المهندس" Value="المهندس" />
                                    <telerik:RadComboBoxItem runat="server" Text="صاحب السمو" Value="صاحب السمو" />
                                    <telerik:RadComboBoxItem runat="server" Text="معالي السيد" Value="معالي السيد" />
                                    <telerik:RadComboBoxItem runat="server" Text="سعادة السيد" Value="سعادة السيد" />
                                    <telerik:RadComboBoxItem runat="server" Text="MR" Value="MR" />
                                    <telerik:RadComboBoxItem runat="server" Text="MSS" Value="MSS" />
                                    <telerik:RadComboBoxItem runat="server" Text="M\S" Value="M\S" />
                                    <telerik:RadComboBoxItem runat="server" Text="" Value="" />
                                </Items>
                            </telerik:RadComboBox>
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactGSM2Label" runat="server" AssociatedControlID="ContactGSM2TextBox" Text="GSM 2" />
                        </div>
                        <div class="col-10">
                            <telerik:RadComboBox runat="server" ID="ContactGSM2ContryCodeCombobox" TabIndex="5" AppendDataBoundItems="True" CausesValidation="False" CollapseDelay="10" DataMember="DefaultView"
                                Width="29%" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains" OnClientSelectedIndexChanged="GSM2_OnClientSelectedIndexChanged">
                                <Items>
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Oman.png" Text="Oman    +968" Value="968" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/UAE.png" Text="Emirates    +971" Value="971" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Saudi.png" Text="Saudi    +966" Value="966" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Kuwait.png" Text="Kuwait    +965" Value="965" />
                                    <telerik:RadComboBoxItem ImageUrl="../../../Content/Images/Qatar.png" Text="Qatar    +974" Value="974" />
                                </Items>
                            </telerik:RadComboBox>
                            <telerik:RadTextBox ID="ContactGSM2TextBox" runat="server" Enabled="false" Width="70%" ToolTip="Contact GSM 2" TabIndex="6" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactOfficePhoneLabel" runat="server" AssociatedControlID="ContactOfficePhoneTextBox" Text="Office Phone" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactOfficePhoneTextBox" runat="server" Width="100%" ToolTip="Contact Office Phone" TabIndex="8" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactWebsiteLabel" runat="server" AssociatedControlID="ContactWebsiteTextBox" Text="Website" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactWebsiteTextBox" runat="server" Width="100%" ToolTip="Contact Website" TabIndex="10" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactPostalCodeLabel" runat="server" AssociatedControlID="ContactPostalCodeTextBox" Text="Postal Code" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactPostalCodeTextBox" runat="server" Width="100%" ToolTip="Contact Postal Code" TabIndex="12" />
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactLongitudeCoordinatesLabel" runat="server" AssociatedControlID="ContactLongitudeCoordinatesTextBox" Text="Longitude Co-ordinates" />
                        </div>
                        <div class="col-10">
                            <telerik:RadNumericTextBox ID="ContactLongitudeCoordinatesTextBox" runat="server" Width="100%" ToolTip="Contact Longitude Co-ordinates" TabIndex="14">
                                <NumberFormat DecimalDigits="6" AllowRounding="false" />
                            </telerik:RadNumericTextBox>
                        </div>
                        <div class="col-10 sg-label">
                            <asp:Label ID="ContactMemoLabel" runat="server" AssociatedControlID="ContactMemoTextBox" Text="Memo" />
                        </div>
                        <div class="col-10">
                            <telerik:RadTextBox ID="ContactMemoTextBox" runat="server" Width="100%" TextMode="MultiLine" Height="128px" ToolTip="Contact Memo" TabIndex="17" />
                        </div>

                        <div class="col-5">
                            <div class="sg-blockcontent-right">
                                <div class="col-10 sg-label">
                                    <asp:Label ID="ContactIdentityAttachmentLabel" runat="server" AssociatedControlID="ContactIdentityUpload" Text="Identity Attachment" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadAsyncUpload ID="ContactIdentityUpload" runat="server" ToolTip="Upload the Attachments" MaxFileInputsCount="1" TabIndex="19" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="SubmitButton" />
                                </div>
                            </div>
                        </div>
                        <div class="col-5">
                            <div class="sg-blockcontent-right">
                                <div class="col-10 sg-label">
                                    <asp:Label ID="ContactCommercialRegisterLabel" runat="server" AssociatedControlID="ContactCommercialRegisterUpload" Text="Commercial Register Attachment" />
                                </div>
                                <div class="col-10">
                                    <telerik:RadAsyncUpload ID="ContactCommercialRegisterUpload" runat="server" TabIndex="20" ToolTip="Upload the Attachments" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="SubmitButton" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sg-button-right">
                    <telerik:RadButton ID="SubmitButton" runat="server" Text="Submit" Width="100px" CssClass="sg-button-submit" TabIndex="21" ValidationGroup="SubmitButton" OnClick="SubmitButton_Click" />
                </div>
                      </div> 
            </div>
        </div>
        <div class="col-10 sg-radgrid">
            <telerik:RadGrid ID="ContactRadGrid" runat="server" CssClass="sg-radgrid" AllowFilteringByColumn="True" AllowPaging="True" AutoGenerateColumns="False" CellSpacing="0"
                DataSourceID="SqlDataSource_ContactList" GridLines="None" OnItemDataBound="ContactRadGrid_ItemDataBound"
                OnItemCommand="ContactRadGrid_ItemCommand" OnEditCommand="ContactRadGrid_EditCommand" OnUpdateCommand="ContactRadGrid_UpdateCommand" AllowAutomaticUpdates="true">
                <MasterTableView DataKeyNames="ID" DataSourceID="SqlDataSource_ContactList" CommandItemDisplay="None" AllowPaging="true" PageSize="10">
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
                        <telerik:GridBoundColumn Display="false" DataField="ContactName" ReadOnly="true" UniqueName="ContactName" />
                        <telerik:GridBoundColumn DataField="ContactFullName" FilterControlWidth="100%" FilterControlAltText="Filter ContactFullName column" HeaderText="Contact Name" SortExpression="ContactFullName"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ContactFullName">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ContactIdentityNumber" FilterControlWidth="100%" FilterControlAltText="Filter ContactIdentityNumber column" HeaderText="Identity Number" SortExpression="ContactIdentityNumber"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ContactIdentityNumber">
                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ContactCommercialRegisterNumber" FilterControlWidth="100%" FilterControlAltText="Filter ContactCommercialRegisterNumber column" HeaderText="Commercial Register Number" SortExpression="ContactCommercialRegisterNumber"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ContactCommercialRegisterNumber">
                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CompleteContactGSM1" FilterControlWidth="100%" FilterControlAltText="Filter CompleteContactGSM1 column" HeaderText="GSM 1" SortExpression="CompleteContactGSM1"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="CompleteContactGSM1">
                            <HeaderStyle HorizontalAlign="Center" Width="50px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ContactOfficePhone" FilterControlWidth="100%" FilterControlAltText="Filter ContactOfficePhone column" HeaderText="Office Phone" SortExpression="ContactOfficePhone"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ContactOfficePhone">
                            <HeaderStyle HorizontalAlign="Center" Width="70px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ContactOfficeFax" FilterControlWidth="100%" FilterControlAltText="Filter ContactOfficeFax column" HeaderText="Office Fax" SortExpression="ContactOfficeFax"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ContactOfficeFax">
                            <HeaderStyle HorizontalAlign="Center" Width="70px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="70px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ContactEmail" FilterControlWidth="100%" FilterControlAltText="Filter ContactEmail column" HeaderText="Email" SortExpression="ContactEmail"
                            AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false" UniqueName="ContactEmail">
                            <HeaderStyle HorizontalAlign="Center" Width="150px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridButtonColumn ImageUrl="~/Content/css/MeStyle/Grid/Edit.png" CommandName="Edit" UniqueName="Edit" ButtonType="ImageButton">
                            <HeaderStyle HorizontalAlign="Center" Width="40px" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="40px" />
                        </telerik:GridButtonColumn>
                    </Columns>
                    <EditFormSettings EditFormType="Template">
                        <EditColumn FilterControlAltText="Filter EditCommandColumn column" />
                        <FormTemplate>
                                <div class="col-10 sg-header">
                                    <asp:Label ID="HeaderLabel" runat="server" Text="Update Contact Details" />
                                </div>
                                <div class="col-row">
                                    <div class="col-5">
                                        <div class="sg-blockcontent-right">
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactNameGridLabel" runat="server" AssociatedControlID="ContactNameGridTextBox" Text="Name" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadTextBox ID="ContactNameGridTextBox" runat="server" Width="100%" TabIndex ="22" ToolTip="Contact Name" Text='<%# Bind("ContactName") %>' />
                                                <asp:RequiredFieldValidator ID="ContactNameGridRequired" runat="server" ControlToValidate="ContactNameGridTextBox" CssClass="field-validation-error " ValidationGroup="GridSubmitButton" />
                                            </div>
                                             <div class="col-10 sg-label">
                                                <asp:Label ID="ContactGSM1GridLabel" runat="server" AssociatedControlID="ContactGSM1GridTextBox" Text="GSM 1" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadComboBox runat="server" ID="ContactGSM1ContryCodeGridCombobox" TabIndex="24" AppendDataBoundItems="True" CausesValidation="False" CollapseDelay="10" DataMember="DefaultView"
                                                    Width="29%" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains" OnClientSelectedIndexChanged="GridGSM1_OnClientSelectedIndexChanged" SelectedValue='<%# Bind("ContactGSM1CountryCode")%>'>
                                                    <Items>
                                                        <telerik:RadComboBoxItem ImageUrl="~/Content/Images/Oman.png" Text="Oman    +968" Value="968" />
                                                        <telerik:RadComboBoxItem ImageUrl="~/Content/Images/UAE.png" Text="Emirates    +971" Value="971" />
                                                        <telerik:RadComboBoxItem ImageUrl="~/Content/Images/Saudi.png" Text="Saudi    +966" Value="966" />
                                                        <telerik:RadComboBoxItem ImageUrl="~/Content/Images/Kuwait.png" Text="Kuwait    +965" Value="965" />
                                                        <telerik:RadComboBoxItem ImageUrl="~/Content/Images/Qatar.png" Text="Qatar    +974" Value="974" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                                <telerik:RadTextBox ID="ContactGSM1GridTextBox" runat="server" Width="70%" TabIndex="25" ToolTip="Contact GSM " Text='<%# Bind("ContactGSM1")%>' />
                                                <asp:RequiredFieldValidator ID="ContactGSM1GridRequired" runat="server" ControlToValidate="ContactGSM1GridTextBox" ErrorMessage="*" CssClass="field-validation-error" ValidationGroup="GridSubmitButton" />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactIdentityNumberGridLabel" runat="server" AssociatedControlID="ContactIdentityNumberGridTextBox" Text="Identity Number" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ContactIdentityNumberGridTextBox" runat="server" Width="100%" TabIndex="28" ToolTip="Contact Identity Number" Text='<%# Bind("ContactIdentityNumber") %>' />
                                            </div>
                                            </br>
                                                <div class="col-10 sg-label">
                                                    <asp:Label ID="ContactCommercialRegisterNumberGridLabel" runat="server" AssociatedControlID="ContactCommercialRegisterNumberGridTextBox" Text="Commercial Register Number" />
                                                </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ContactCommercialRegisterNumberGridTextBox" runat="server" Width="100%" TabIndex="30" ToolTip="Contact Commercial Register Number" Text='<%# Bind("ContactCommercialRegisterNumber")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactEmailGridLabel" runat="server" AssociatedControlID="ContactEmailGridTextBox" Text="Email" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ContactEmailGridTextBox" runat="server" Width="100%" TabIndex="32" ToolTip="Contact Email" Text='<%# Bind("ContactEmail")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactLatitudeCoordinatesGridLabel" runat="server" AssociatedControlID="ContactLatitudeCoordinatesGridTextBox" Text="Latitude Co-ordinates" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadNumericTextBox ID="ContactLatitudeCoordinatesGridTextBox" TabIndex="34" runat="server" Width="100%" ToolTip="Contact Latitude Co-ordinates" Text='<%# Bind("ContactLatitudeCoordinates")%>'>
                                                    <NumberFormat DecimalDigits="6" AllowRounding="false" />
                                                </telerik:RadNumericTextBox>
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactOfficeFaxGridLabel" runat="server" AssociatedControlID="ContactOfficeFaxGridTextBox" Text="Office Fax" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ContactOfficeFaxGridTextBox" runat="server" Width="100%" TabIndex="36" ToolTip="Contact Office Fax" Text='<%# Bind("ContactOfficeFax")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactPOBoxGridLabel" runat="server" AssociatedControlID="ContactPOBoxGridTextBox" Text="PO Box" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ContactPOBoxGridTextBox" runat="server" Width="100%" TabIndex="37"  ToolTip="Contact PO Box" Text='<%# Bind("ContactPOBox")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactURLMapGridLabel" runat="server" AssociatedControlID="ContactURLMapGridTextBox" Text="Map URL" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ContactURLMapGridTextBox" runat="server" Width="100%" TabIndex="39" ToolTip="Contact Map URl" Text='<%# Bind("ContactURLMap")%>' />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-5">
                                        <div class="sg-blockcontent-left">
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactNickNameGridLabel" runat="server" AssociatedControlID="ContactNickNameGridComboBox" Text="Nick Name" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadComboBox ID="ContactNickNameGridComboBox" runat="server" TabIndex="23" CausesValidation="False" Width="100%" Height="200px" MarkFirstMatch="True"
                                                    ItemRequestTimeout="0" DropDownAutoWidth="Disabled" SelectedValue='<%# Bind("ContactNickName") %>'>
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Text="الفاضل" Value="الفاضل" />
                                                        <telerik:RadComboBoxItem runat="server" Text="سماحة الشيخ" Value="سماحة الشيخ" />
                                                        <telerik:RadComboBoxItem runat="server" Text="الشيخ" Value="الشيخ" />
                                                        <telerik:RadComboBoxItem runat="server" Text="معالي الشيخ" Value="معالي الشيخ" />
                                                        <telerik:RadComboBoxItem runat="server" Text="سعادة الشيخ" Value="سعادةالشيخ" />
                                                        <telerik:RadComboBoxItem runat="server" Text="معالي" Value="معالي" />
                                                        <telerik:RadComboBoxItem runat="server" Text="سعادة" Value="سعادة" />
                                                        <telerik:RadComboBoxItem runat="server" Text="المكرم" Value="المكرم" />
                                                        <telerik:RadComboBoxItem runat="server" Text="فضيلة" Value="فضيلة" />
                                                        <telerik:RadComboBoxItem runat="server" Text="فضيلة الشيخ" Value="فضيلة الشيخ" />
                                                        <telerik:RadComboBoxItem runat="server" Text="الأفاضل" Value="الأفاضل" />
                                                        <telerik:RadComboBoxItem runat="server" Text="الدكتور" Value="الدكتور" />
                                                        <telerik:RadComboBoxItem runat="server" Text="المهندس" Value="المهندس" />
                                                        <telerik:RadComboBoxItem runat="server" Text="صاحب السمو" Value="صاحب السمو" />
                                                        <telerik:RadComboBoxItem runat="server" Text="معالي السيد" Value="معالي السيد" />
                                                        <telerik:RadComboBoxItem runat="server" Text="سعادة السيد" Value="سعادة السيد" />
                                                        <telerik:RadComboBoxItem runat="server" Text="MR" Value="MR" />
                                                        <telerik:RadComboBoxItem runat="server" Text="MSS" Value="MSS" />
                                                        <telerik:RadComboBoxItem runat="server" Text="M\S" Value="M\S" />
                                                        <telerik:RadComboBoxItem runat="server" Text="" Value="" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactGSM2GridLabel" runat="server" AssociatedControlID="ContactGSM2GridTextBox" Text="GSM 2" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadComboBox runat="server" ID="ContactGSM2ContryCodeGridCombobox" TabIndex="26" AppendDataBoundItems="True" CausesValidation="False" CollapseDelay="10" DataMember="DefaultView"
                                                    Width="29%" MarkFirstMatch="True" EmptyMessage="--- Select ---" Filter="Contains" OnClientSelectedIndexChanged="GridGSM2_OnClientSelectedIndexChanged" SelectedValue='<%# Bind("ContactGSM2CountryCode")%>'>
                                                    <Items>
                                                        <telerik:RadComboBoxItem ImageUrl="~/Content/Images/Oman.png" Text="Oman    +968" Value="968" />
                                                        <telerik:RadComboBoxItem ImageUrl="~/Content/Images/UAE.png" Text="Emirates    +971" Value="971" />
                                                        <telerik:RadComboBoxItem ImageUrl="~/Content/Images/Saudi.png" Text="Saudi    +966" Value="966" />
                                                        <telerik:RadComboBoxItem ImageUrl="~/Content/Images/Kuwait.png" Text="Kuwait    +965" Value="965" />
                                                        <telerik:RadComboBoxItem ImageUrl="~/Content/Images/Qatar.png" Text="Qatar    +974" Value="974" />
                                                    </Items>
                                                </telerik:RadComboBox>
                                                <telerik:RadTextBox ID="ContactGSM2GridTextBox" runat="server" Width="70%" TabIndex="27" ToolTip="Contact GSM 2" Text='<%# Bind("ContactGSM2")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactOfficePhoneGridLabel" runat="server" AssociatedControlID="ContactOfficePhoneGridTextBox" Text="Office Phone" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ContactOfficePhoneGridTextBox" runat="server" Width="100%" TabIndex="29" ToolTip="Contact Office Phone" Text='<%# Bind("ContactOfficePhone")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactWebsiteGridLabel" runat="server" AssociatedControlID="ContactWebsiteGridTextBox" Text="Website" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ContactWebsiteGridTextBox" runat="server" Width="100%" TabIndex="31" ToolTip="Contact Website" Text='<%# Bind("ContactWebsite")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactPostalCodeGridLabel" runat="server" AssociatedControlID="ContactPostalCodeGridTextBox" Text="Postal Code" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ContactPostalCodeGridTextBox" runat="server" Width="100%" TabIndex="33" ToolTip="Contact Postal Code" Text='<%# Bind("ContactPostalCode")%>' />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactLongitudeCoordinatesGridLabel" runat="server" AssociatedControlID="ContactLongitudeCoordinatesGridTextBox" Text="Longitude Co-ordinates" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadNumericTextBox ID="ContactLongitudeCoordinatesGridTextBox" runat="server" TabIndex="35" Width="100%" ToolTip="Contact Longitude Co-ordinates" Text='<%# Bind("ContactLongitudeCoordinates")%>'>
                                                    <NumberFormat DecimalDigits="6" AllowRounding="false" />
                                                </telerik:RadNumericTextBox>
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="ContactMemoGridLabel" runat="server" AssociatedControlID="ContactMemoGridTextBox" Text="Memo" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadTextBox ID="ContactMemoGridTextBox" runat="server" TabIndex="38" Width="100%" TextMode="MultiLine" Height="110px" ToolTip="Contact Memo" Text='<%# Bind("ContactMemo")%>' />
                                            </div>
                                            <div class="col-5">
                                                <div class="sg-blockcontent-right">
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="ContactIdentityAttachmentLabel" runat="server" AssociatedControlID="ContactIdentityGridUpload" Text="Identity Attachment" />
                                                    </div>
                                                    <div class="col-5">
                                                        <telerik:RadAsyncUpload ID="ContactIdentityGridUpload" runat="server" TabIndex="40" ToolTip="Upload the Attachments" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="GridSubmitButton" />
                                                        <asp:HyperLink ID="ContactIdentityGridLink" runat="server" Text="View Attachment" Target="_blank" NavigateUrl='<%# Bind("ContactIdentityAttachment") %>' />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-5">
                                                <div class="sg-blockcontent-left">
                                                    <div class="col-10 sg-label">
                                                        <asp:Label ID="ContactCommercialRegisterGridLabel" runat="server" AssociatedControlID="ContactCommercialRegisterGridUpload" Text="Commercial Register Attachment" />
                                                    </div>
                                                    <div class="col-5">
                                                        <telerik:RadAsyncUpload ID="ContactCommercialRegisterGridUpload" TabIndex="41" runat="server" ToolTip="Upload the Attachments" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="GridSubmitButton" />
                                                        <asp:HyperLink ID="ContactCommercailRegisterGridLink" runat="server" Text="View Attachment" Target="_blank" NavigateUrl='<%# Bind("ContactCommercialRegisterAttachment")%>' />
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                    <div class="sg-button-right">
                                                <telerik:RadButton ID="GridSubmitButton" runat="server" Width="100px" TabIndex="42" CssClass="sg-button-submit" Text='<%# IIf((TypeOf (Container) Is GridEditFormInsertItem), "Add", "Update")%>'
                                                    CommandName='<%# IIf((TypeOf(Container) is GridEditFormInsertItem), "PerformInsert", "Update")%>' ValidationGroup="GridSubmitButton" />
                                                <telerik:RadButton ID="CancelButton" Width="100px" TabIndex="43" Text="Cancel" runat="server" CssClass="sg-button-submit" CausesValidation="False" CommandName="Cancel" />
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
    </div>
    <telerik:RadCodeBlock ID="RadCodeBlock" runat="server">
        <script type="text/javascript">
            function GSM1_OnClientSelectedIndexChanged(sender, eventArgs) {
                var _mobileNumber = $find("<%= ContactGSM1TextBox.ClientID%>");
                _mobileNumber.enable();
                _mobileNumber.set_value("");
                _mobileNumber.enable();
                _mobileNumber.focus();
            }

            function GSM2_OnClientSelectedIndexChanged(sender, eventArgs) {
                var _mobileNumber = $find("<%= ContactGSM2TextBox.ClientID%>");
                _mobileNumber.enable();
                _mobileNumber.set_value("");
                _mobileNumber.enable();
                _mobileNumber.focus();
            }

            function GridGSM1_OnClientSelectedIndexChanged(sender, eventArgs) {
                var _mobileNumber = $telerik.$("[id$='ContactGSM1GridTextBox']").attr('id');
                var _number = $find(_mobileNumber);
                _number.clear();
                _number.focus();
            }

            function GridGSM2_OnClientSelectedIndexChanged(sender, eventArgs) {
                var _mobileNumber = $telerik.$("[id$='ContactGSM2GridTextBox']").attr('id');
                var _number = $find(_mobileNumber);
                _number.clear();
                _number.focus();
            }
        </script>
    </telerik:RadCodeBlock>

    <asp:SqlDataSource ID="SqlDataSource_ContactList" runat="server"
        ConnectionString="<%$ConnectionStrings:RealEstateManagementSystemDataBaseConnection%>"
        OnUpdating="SqlDataSource_ContactList_OnUpdating"
        SelectCommand="PROC_APP_ContactSELECTALL" SelectCommandType="StoredProcedure"
        UpdateCommand="PROC_APP_ContactUPDATE" UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int64" />
            <asp:Parameter Name="ContactName" Type="String" />
            <asp:Parameter Name="ContactNickName" Type="String" />
            <asp:Parameter Name="ContactIdentityNumber" Type="String" />
            <asp:Parameter Name="ContactIdentityAttachment" Type="String" />
            <asp:Parameter Name="ContactGSM1CountryCode" Type="String" />
            <asp:Parameter Name="ContactGSM1" Type="String" />
            <asp:Parameter Name="ContactGSM2CountryCode" Type="String" />
            <asp:Parameter Name="ContactGSM2" Type="String" />
            <asp:Parameter Name="ContactCommercialRegisterNumber" Type="String" />
            <asp:Parameter Name="ContactCommercialRegisterAttachment" Type="String" />
            <asp:Parameter Name="ContactEmail" Type="String" />
            <asp:Parameter Name="ContactOfficePhone" Type="String" />
            <asp:Parameter Name="ContactOfficeFax" Type="String" />
            <asp:Parameter Name="ContactWebsite" Type="String" />
            <asp:Parameter Name="ContactPOBox" Type="String" />
            <asp:Parameter Name="ContactPostalCode" Type="String" />
            <asp:Parameter Name="ContactLatitudeCoordinates" Type="String" />
            <asp:Parameter Name="ContactLongitudeCoordinates" Type="String" />
            <asp:Parameter Name="ContactURLMap" Type="String" />
            <asp:Parameter Name="ContactMemo" Type="String" />
            <asp:Parameter Name="ContactUpdatedDate" Type="DateTime" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
