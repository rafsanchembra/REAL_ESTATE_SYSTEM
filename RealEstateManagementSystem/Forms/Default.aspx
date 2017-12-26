<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="Default.aspx.vb" Inherits="RealEstateManagementSystem._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
    <asp:Label ID="headerPlaceHolderLabel" runat="server" Text="DashBoard"></asp:Label>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="featuredPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManagerMain" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel">
        <%--<ClientEvents OnRequestStart="RequestStart" />--%>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Master_Div">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Master_Div" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <div id="Master_Div">
        <msg:PopMsg ID="PopMsg" runat="server" />
        <div class="sg-blockcontent">
            <div class="col-8 col-push-10">
                <telerik:RadDockLayout runat="server" ID="mainDockLayout">
                    <div id="AdministratorDiv" runat="server" class="col-33">
                        <div class="box">
                            <asp:Image ID="Image1" runat="server" ImageUrl="~/Content/css/images/admin.png" />
                            <div class="menu-bg" id="menu-bg-adminstrator"></div>
                            <div class="menu" id="menu-adminstrator">
                                <ul class="menu-splitL">
                                    <li><a href="./Administrator/UserRegister">Add New User</a></li>
                                    <li><a href="./Administrator/UserPermission">User Permission</a></li>
                                    <li><a href="./Administrator/ChangeUserName">Change UserName</a></li>
                                    <li><a href="./Administrator/ChangePassword">Change Password</a></li>
                                    <li><a href="./Administrator/LockUser">Lock User</a></li>
                                    <li><a href="./Administrator/ChangeSiganture">Change Signature</a></li>
                                </ul>
                                <ul class="menu-splitR">
                                    <li><a href="./Administrator/Bank/BankManagement">Bank Managament</a></li>
                                    <li><a href="./Administrator/Bank/Advance/BankManagement">Advance Bank Management</a></li>
                                    <li><a href="./Administrator/Bank/BankService/BankAccountTranscation">Bank Account Transaction</a></li>
                                    <li><a href="./Administrator/Bank/BankService/TransactionBetweenBankAccount">Transaction between bank accounts</a></li>
                                </ul>
                            </div>
                            <div class="burger" id="burger-adminstrator">
                                <div class="x" id="div-x-adminstrator"></div>
                                <div class="y" id="div-y-adminstrator"></div>
                                <div class="z" id="div-z-adminstrator"></div>
                            </div>
                            <h1>Administrator</h1>
                        </div>
                    </div>
                    <div id="PublicRelationDiv" runat="server" class="col-33">
                        <div class="box">
                            <asp:Image ID="Image2" runat="server" ImageUrl="~/Content/css/images/PublicRelation.png" />
                            <div class="menu-bg" id="menu-bg-publicRelation"></div>
                            <div class="menu" id="menu-publicRelation">
                                <ul class="menu-splitL">
                                    <li><a href="./Administrator/PublicRelation/ContactManagement">Contact Management</a></li>
                                    <li><a href="./Administrator/PublicRelation/ClientManagementx">Client Management</a></li>
                                </ul>
                                <ul class="menu-splitR">
                                    <li><a href="./Administrator/PublicRelation/SupplierManagement">Supplier Management</a></li>
                                    <li><a href="./Administrator/PublicRelation/OwnerManagement">Owner Management</a></li>
                                </ul>
                            </div>
                            <div class="burger" id="burger-publicRelation">
                                <div class="x" id="div-x-publicRelation"></div>
                                <div class="y" id="div-y-publicRelation"></div>
                                <div class="z" id="div-z-publicRelation"></div>
                            </div>
                            <h1>Public Relation</h1>
                        </div>
                    </div>
                    <div id="RealEstateDiv" runat="server" class="col-33">
                        <div class="box">
                            <asp:Image ID="Image3" runat="server" ImageUrl="~/Content/css/images/RealEstate.png" />
                            <div class="menu-bg" id="menu-bg-realEstate"></div>
                            <div class="menu" id="menu-realEstate">
                                <ul class="menu-splitL">
                                    <li><a href="./Administrator/RealEstate/FreeLandManagement">FreeLand Management</a></li>
                                    <li><a href="./Administrator/RealEstate/FlatManagement">Flat Management</a></li>
                                </ul>
                                <ul class="menu-splitR">
                                    <li><a href="./Administrator/RealEstate/VillaManagement">Villa Management</a></li>
                                    <li runat="server" id="BuildingLink"><a href="./Administrator/RealEstate/BuildingManagement">Building Management</a></li>
                                </ul>
                            </div>
                            <div class="burger" id="burger-realEstate">
                                <div class="x" id="div-x-realEstate"></div>
                                <div class="y" id="div-y-realEstate"></div>
                                <div class="z" id="div-z-realEstate"></div>
                            </div>
                            <h1>Real Estate</h1>
                        </div>
                    </div>
                </telerik:RadDockLayout>
            </div>
        </div>
    </div>
   
 <%--   <script src="./Content/js/menu.js"></script>--%>
    <telerik:RadCodeBlock runat="server" ID="RadCodeBlock">
        <script>

            if ('ontouchstart' in window) { var click = 'touchstart'; }
            else { var click = 'click'; }


            $('#burger-adminstrator').on(click, function () {
                if (!$(this).hasClass('open')) { openMenu("Adminstrator"); }
                else { closeMenu("Adminstrator"); }
            });

            $('#burger-publicRelation').on(click, function () {
                if (!$(this).hasClass('open')) { openMenu("PublicRelation"); }
                else { closeMenu("PublicRelation"); }
            });

            $('#burger-realEstate').on(click, function () {
                if (!$(this).hasClass('open')) { openMenu("RealEstate"); }
                else { closeMenu("RealEstate"); }
            });


            $('div.menu ul li a').on(click, function (e) {
                //e.preventDefault();
                closeMenu();
            });


            function openMenu(menuType) {

                switch (true) {
                    case (menuType == "Adminstrator"):

                        closeMenu("PublicRelation");
                        closeMenu("RealEstate");

                        $('#menu-bg-adminstrator').addClass('animate');
                        $('#burger-adminstrator').addClass('open');
                        $('#div-x-adminstrator, #div-z-adminstrator').addClass('collapse');
                        $('#menu-adminstrator li').addClass('animate');

                        setTimeout(function () {
                            $('#div-y-adminstrator').hide();
                            $('#div-x-adminstrator').addClass('rotate30');
                            $('#div-z-adminstrator').addClass('rotate150');
                        }, 70);
                        setTimeout(function () {
                            $('#div-x-adminstrator').addClass('rotate45');
                            $('#div-z-adminstrator').addClass('rotate135');
                        }, 120);
                        break;
                    case (menuType == "PublicRelation"):

                        closeMenu("Adminstrator");
                        closeMenu("RealEstate");

                        $('#menu-bg-publicRelation').addClass('animate');
                        $('#burger-publicRelation').addClass('open');
                        $('#div-x-publicRelation, #div-z-publicRelation').addClass('collapse');
                        $('#menu-publicRelation li').addClass('animate');

                        setTimeout(function () {
                            $('#div-y-publicRelation').hide();
                            $('#div-x-publicRelation').addClass('rotate30');
                            $('#div-z-publicRelation').addClass('rotate150');
                        }, 70);
                        setTimeout(function () {
                            $('#div-x-publicRelation').addClass('rotate45');
                            $('#div-z-publicRelation').addClass('rotate135');
                        }, 120);
                        break;
                    case (menuType == "RealEstate"):

                        closeMenu("Adminstrator");
                        closeMenu("PublicRelation");

                        $('#menu-bg-realEstate').addClass('animate');

                        $('#burger-realEstate').addClass('open');
                        $('#div-x-realEstate, #div-z-realEstate').addClass('collapse');
                        $('#menu-realEstate li').addClass('animate');

                        setTimeout(function () {
                            $('#div-y-realEstate').hide();
                            $('#div-x-realEstate').addClass('rotate30');
                            $('#div-z-realEstate').addClass('rotate150');
                        }, 70);
                        setTimeout(function () {
                            $('#div-x-realEstate').addClass('rotate45');
                            $('#div-z-realEstate').addClass('rotate135');
                        }, 120);
                        break;
                }
            }

            function closeMenu(menuType) {

                switch (true) {
                    case (menuType == "Adminstrator"):
                        $('#menu-adminstrator li').removeClass('animate');
                        setTimeout(function () {
                            $('#burger-adminstrator').removeClass('open');
                            $('#div-x-adminstrator').removeClass('rotate45').addClass('rotate30');
                            $('#div-z-adminstrator').removeClass('rotate135').addClass('rotate150');
                            $('#menu-bg-adminstrator').removeClass('animate');

                            setTimeout(function () {
                                $('#div-x-adminstrator').removeClass('rotate30');
                                $('#div-z-adminstrator').removeClass('rotate150');
                            }, 50);
                            setTimeout(function () {
                                $('#div-y-adminstrator').show();
                                $('#div-x-adminstrator, #div-z-adminstrator').removeClass('collapse');
                            }, 70);
                        }, 100);
                        break;
                    case (menuType == "PublicRelation"):
                        $('#menu-publicRelation li').removeClass('animate');
                        setTimeout(function () {
                            $('#burger-publicRelation').removeClass('open');
                            $('#div-x-publicRelation').removeClass('rotate45').addClass('rotate30');
                            $('#div-z-publicRelation').removeClass('rotate135').addClass('rotate150');
                            $('#menu-bg-publicRelation').removeClass('animate');

                            setTimeout(function () {
                                $('#div-x-publicRelation').removeClass('rotate30');
                                $('#div-z-publicRelation').removeClass('rotate150');
                            }, 50);
                            setTimeout(function () {
                                $('#div-y-publicRelation').show();
                                $('#div-x-publicRelation, #div-z-publicRelation').removeClass('collapse');
                            }, 70);
                        }, 100);
                        break;
                    case (menuType == "RealEstate"):
                        $('#menu-realEstate li').removeClass('animate');
                        setTimeout(function () {
                            $('#burger-realEstate').removeClass('open');
                            $('#div-x-realEstate').removeClass('rotate45').addClass('rotate30');
                            $('#div-z-realEstate').removeClass('rotate135').addClass('rotate150');
                            $('#menu-bg-realEstate').removeClass('animate');

                            setTimeout(function () {
                                $('#div-x-realEstate').removeClass('rotate30');
                                $('#div-z-realEstate').removeClass('rotate150');
                            }, 50);
                            setTimeout(function () {
                                $('#div-y-realEstate').show();
                                $('#div-x-realEstate, #div-z-realEstate').removeClass('collapse');
                            }, 70);
                        }, 100);
                        break;
                }
            }

            
        </script>
    </telerik:RadCodeBlock>
</asp:Content>
