<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="testBuscaOdometro.aspx.vb" Inherits="Sistema_Integral_TSE_v45.testBuscaOdometro" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
    </telerik:RadAjaxManager>
    <asp:Button ID="Button1" runat="server" Text="Button" />
    <br />
    <asp:TextBox ID="TextBox1" runat="server" Height="301px" TextMode="MultiLine" 
        Width="723px"></asp:TextBox>
    <br />
    <br />
    <telerik:RadAutoCompleteBox ID="RadAutoCompleteBox1" Runat="server" 
        AllowCustomEntry="True" DataSourceID="SqlDataSource1" DataTextField="nombre" 
        DataValueField="id_empresa" Height="29px" Width="658px">
    </telerik:RadAutoCompleteBox>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT * FROM [empresas]"></asp:SqlDataSource>
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    <br />
    <asp:TextBox ID="txthora" runat="server"></asp:TextBox>
<br />
<asp:FileUpload ID="FileUpload1" runat="server" />
<br />
<asp:Button ID="Button2" runat="server" Text="Button" />
    <br />
</asp:Content>
