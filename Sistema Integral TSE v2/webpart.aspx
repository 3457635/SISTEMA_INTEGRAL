<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master"
    CodeBehind="webpart.aspx.vb" Inherits="Sistema_Integral_TSE_v45.webpart" %>

<%@ Register Src="Controles_Usuario/SearchUserControl.ascx" TagName="SearchUserControl"
    TagPrefix="uc2" %>
<%@ Register src="Controles_Usuario/DisplayModeMenu.ascx" tagname="DisplayModeMenu" tagprefix="uc1" %>
<%@ Register src="Controles_Usuario/ctlGraficaSinFactura.ascx" tagname="ctlGraficaSinFactura" tagprefix="uc3" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:WebPartManager ID="WebPartManager1" runat="server" Personalization-Enabled="true">
        <Personalization InitialScope="Shared" />
    </asp:WebPartManager>
    <uc1:DisplayModeMenu ID="DisplayModeMenu1" runat="server" />
    <table style="width: 100%">
        <tr>
            <td class="style5">
                <asp:WebPartZone ID="SidebarZone" runat="server" AllowLayoutChange="true" HeaderText="Sidebar">
                    <ZoneTemplate>
                        <asp:Label runat="server" ID="linksPart" title="My Links">
      <a href="http://www.asp.net">ASP.NET site</a> 
      <br />
      <a href="http://www.gotdotnet.com">GotDotNet</a> 
      <br />
      <a href="http://www.contoso.com">Contoso.com</a> 
      <br />
                        </asp:Label>
                        <uc3:ctlGraficaSinFactura ID="ctlGraficaSinFactura1" title="monto sin facturar" runat="server" />
                        <uc2:SearchUserControl ID="SearchUserControl1" title="Search" runat="server" />
                    </ZoneTemplate>
                </asp:WebPartZone>
            </td>
            <td>
                <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                <asp:WebPartZone ID="MainZone" runat="server" AllowLayoutChange="true" HeaderText="Main">
                    <ZoneTemplate>
                        <asp:Label ID="Label1" runat="server" Title="Content">
      <h2>Welcome to My Home Page</h2>
                        </asp:Label>
                    </ZoneTemplate>
                </asp:WebPartZone>
                <asp:Button ID="Button1" runat="server" Text="Button" />
            </td>
            <td>
                &nbsp;
                <asp:EditorZone ID="EditorZone1" runat="server">
                    <ZoneTemplate>
                        <asp:LayoutEditorPart ID="LayoutEditorPart1" runat="server" />
                        <asp:AppearanceEditorPart ID="AppearanceEditorPart1" runat="server" />
                    </ZoneTemplate>
                </asp:EditorZone>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .style5
        {
            width: 668px;
        }
    </style>
</asp:Content>

