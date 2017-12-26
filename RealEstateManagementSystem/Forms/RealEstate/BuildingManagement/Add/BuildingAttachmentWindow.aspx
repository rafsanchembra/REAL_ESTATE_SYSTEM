<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/WindowMaster.Master" CodeBehind="BuildingAttachmentWindow.aspx.vb" Inherits="RealEstateManagementSystem.BuildingAttachmentWindow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
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
            <div class="col-10 sg-closebutton-right">
                <telerik:RadButton runat="server" ID="CloseButton" CssClass="sg-button-close" AutoPostBack="false" OnClientClicked="CloseAndRebind" />
            </div>
            <div class="sg-blockcontent">

                <div class="col-row">
                    <div class="col-10">
                        <telerik:RadTabStrip ID="BuildingAttachmentTabStrip" runat="server" MultiPageID="BuildingAttachmentMultiPage" Orientation="HorizontalTop" SelectedIndex="0">
                            <Tabs>
                                <telerik:RadTab Text="Images" Value="Images" SelectedCssClass="tabImage" runat="server" Selected="true" />
                                <telerik:RadTab Text="Documents" Value="Documents" CssClass="tabPDF" runat="server" />
                            </Tabs>
                        </telerik:RadTabStrip>
                    </div>
                    <div class="col-10 tabMain">
                        <telerik:RadMultiPage runat="server" ID="BuildingAttachmentMultiPage" SelectedIndex="0">
                            <telerik:RadPageView runat="server" ID="ImagePageView" Selected="true">
                                <div class="col-10 sg-header">
                                    <asp:Label ID="AttachmentImageHeaderLabel" runat="server" Text="Image Attachment" />
                                </div>
                                <div class="col-10">
                                    <div class="col-4">
                                        <div class="sg-blockcontent-right">
                                            <div class="col-10 sg-label">
                                                <asp:Label runat="server" ID="AttachmentNameLabel" Text="Attachment Name" AssociatedControlID="AttachmentNameTextBox" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadTextBox ID="AttachmentNameTextBox" runat="server" Width="100%" ToolTip="Attachment Name" />
                                                <asp:RequiredFieldValidator ID="AttachmentNameRequired" runat="server" ControlToValidate="AttachmentNameTextBox" ValidationGroup="AttachmentSubmit" EnableClientScript="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="sg-blockcontent-right">
                                            <div class="col-10 sg-label">
                                                <asp:Label runat="server" ID="AttachmentLabel" Text="Attachments" AssociatedControlID="AttachmentUpload" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadAsyncUpload ID="AttachmentUpload" runat="server" ToolTip="Upload the Attachments" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".jpeg,.jpg,.tif,.png,.gif,tiff,.bmp,.bpg" PostbackTriggers="UploadButton"
                                                    OnClientFileUploaded="attachmentUploaded" OnClientFileUploadRemoved="attachmentUploadRemoved"
                                                    OnFileUploaded="AttachmentUpload_FileUploaded" />
                                            </div>
                                           <%-- <div class="col-10 sg-label">
                                                <asp:Label ID="SpanLabel" Text="File Size limit 4MB (jpeg, jpg, tif, png, gif,tiff, bmp, bpg)" runat="server" />
                                            </div>--%>
                                            <div class="col-10 sg-label">
                                                <asp:Label runat="server" ID="AttachmentQualityLabel" Text="Image Quality" Visible="false" AssociatedControlID="AttachmentQualityRating" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadRating RenderMode="Lightweight" ID="AttachmentQualityRating" runat="server" Visible="false" ItemCount="5" Value="4" SelectionMode="Continuous" Precision="Half" Orientation="Horizontal" />
                                            </div>

                                        </div>
                                    </div>
                                    <div class="col-2" style="padding-top: 30px;">
                                        <div class="sg-blockcontent-right">
                                            <div class="col-10  sg-button-right">
                                                <div class="col-5">
                                                    <telerik:RadButton ID="UploadButton" runat="server" Enabled="false" Text="Upload" CssClass="sg-button-submit" Width="150px" ValidationGroup="AttachmentSubmit" OnClientClicked="ValidateOnSubmit" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-10 sg-textbox-required-field">
                                    <telerik:RadImageEditor RenderMode="Lightweight" ID="AttachmentImageEditor" CanvasMode="No" Enabled="false" runat="server" Width="1024px" Height="720" OnImageLoading="AttachmentImageEditor_ImageLoading" OnImageSaving="AttachmentImageEditor_ImageSaving"
                                        OnClientCommandExecuting="OnClientCommandExecuting" OnClientSaved="OnClientSaved">
                                    </telerik:RadImageEditor>
                                    <p id="messageLbl"></p>
                                </div>
                            </telerik:RadPageView>
                            <telerik:RadPageView runat="server" ID="DocumentPageView">
                                <div class="col-10 sg-header">
                                    <asp:Label ID="Label1" runat="server" Text="Document Attachment" />
                                </div>
                                <div class="col-10">
                                    <div class="col-4">
                                        <div class="sg-blockcontent-right">
                                            <div class="col-10 sg-label">
                                                <asp:Label runat="server" ID="DocAttachmentLabel" Text="Attachment Name" AssociatedControlID="DocAttachmentNameTextBox" />
                                            </div>
                                            <div class="col-10 sg-textbox-required-field">
                                                <telerik:RadTextBox ID="DocAttachmentNameTextBox" runat="server" Width="100%" ToolTip="Attachment Name" />
                                                <asp:RequiredFieldValidator ID="DocNameRequired" runat="server" ControlToValidate="DocAttachmentNameTextBox" ValidationGroup="DocAttachmentSubmit" EnableClientScript="true" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="sg-blockcontent-right">
                                            <div class="col-10 sg-label">
                                                <asp:Label runat="server" ID="DocAttachmentUploadLabel" Text="Attachments" AssociatedControlID="DocAttachmentUpload" />
                                            </div>
                                            <div class="col-10">
                                                <telerik:RadAsyncUpload ID="DocAttachmentUpload" runat="server" ToolTip="Upload the Attachments" MaxFileInputsCount="1" Skin="MetroTouch" AllowedFileExtensions=".pdf" PostbackTriggers="DocUploadButton"
                                                    OnClientFileUploaded="docAttachmentUploaded" OnClientFileUploadRemoved="docAttachmentUploadRemoved" />
                                                <asp:HyperLink runat="server" ID="DocAttachmentHyperLink" Text="View" Visible="false" Target="_blank" />
                                            </div>
                                            <div class="col-10 sg-label">
                                                <asp:Label ID="Label3" Text="File Size limit 4MB (Pdf)" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-2" style="padding-top: 30px;">
                                        <div class="sg-blockcontent-right">
                                            <div class="col-10  sg-button-right">
                                                <div class="col-5">
                                                    <telerik:RadButton ID="DocUploadButton" runat="server" Enabled="false" Text="Upload" CssClass="sg-button-submit" Width="150px"
                                                        ValidationGroup="DocAttachmentSubmit" OnClientClicked="DocValidateOnSubmit" OnClick="DocUploadButton_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </telerik:RadPageView>
                        </telerik:RadMultiPage>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <asp:HiddenField runat="server" ID="AttachmentType" ClientIDMode="Static" />
    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock">
        <script>

            function CloseAndRebind() {

                var attachmentTypeControl = document.getElementById('<%= AttachmentType.ClientID%>');
             var attachmentType = attachmentTypeControl.value
             var oWindow = GetRadWindow();
             oWindow.BrowserWindow.refreshGrid(attachmentType);
             oWindow.argument = null;
             oWindow.close();

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


         function attachmentUploaded() {
             $find("<%= UploadButton.ClientID%>").set_enabled(true);

       }
       function attachmentUploadRemoved() {
           $find("<%= UploadButton.ClientID%>").set_enabled(false);
       }

       function docAttachmentUploaded() {
           $find("<%= DocUploadButton.ClientID%>").set_enabled(true);

            }
            function docAttachmentUploadRemoved() {
                $find("<%= DocUploadButton.ClientID%>").set_enabled(false);
            }

            function OnClientCommandExecuting(imEditor, eventArgs) {
               
                if (eventArgs.get_commandName() == 'Save') {
                    imEditor.saveImageOnServer('', true);

                    //Prevent the buil-in Save dialog to pop up
                    imEditor.setToggleState('Save', false);
                    imEditor.saveImageOnServer('', true);
                    eventArgs.set_cancel(true);
                }
            }

            function OnClientSaved(imgEditor, args) {
                if (args.get_argument() == "0") {
                    alert("Attachment Name Already Exists..!!");
                }
                else {
                    CloseAndRebind();
                }
            }


            function ValidateOnSubmit(sender, args) {
                var val = true;

                var _control_Object;
                var _control;

                _control_Object = $telerik.$("[id$='AttachmentNameTextBox']").attr('id');
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


            function DocValidateOnSubmit(sender, args) {
                var val = true;

                var _control_Object;
                var _control;

                _control_Object = $telerik.$("[id$='DocAttachmentNameTextBox']").attr('id');
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
        </script>
    </telerik:RadCodeBlock>

</asp:Content>
