<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Content/HomeMaster.Master" CodeBehind="Test.aspx.vb" Inherits="RealEstateManagementSystem.Test1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="scriptPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="headerPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="featuredPlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="mainPlaceHolder" runat="server">
    <msg:PopMsg ID="PopMsg" runat="server" />
    <telerik:RadSplitter runat="server" ID="RadSpilter" Orientation="Horizontal">
        <telerik:RadPane runat="server" ID="Radpane"  ></telerik:RadPane>
    </telerik:RadSplitter>
    
</asp:Content>
