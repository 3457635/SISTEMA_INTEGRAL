<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlMapa.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlMapa" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<style type="text/css">
    .style1 {
        width: 100%;
    }
</style>

<telerik:RadSiteMapDataSource ID="RadSiteMapDataSource1" runat="server" SiteMapFile="Manuales.sitemap" />

<table class="style1">
    <tr>
        <td bgcolor="#FF9900">
            <telerik:RadTreeView ID="RadTreeView1" runat="server"
                DataSourceID="RadSiteMapDataSource1" Font-Bold="True" Font-Size="Medium">
            </telerik:RadTreeView>
        </td>
        <td>
            <asp:ImageMap ID="ImageMap1" runat="server" BorderStyle="Dotted"
                HotSpotMode="Navigate" ImageUrl="~/imagenes/mapa.jpg">
                <asp:RectangleHotSpot AlternateText="Ver Manual" Bottom="300"
                    HotSpotMode="Navigate" Left="0"
                    NavigateUrl="~/Manuales/CotizadorM1.1.pptx" Right="100"
                    Top="250" />
                <asp:RectangleHotSpot AlternateText="Ver Manual" Bottom="430"
                    HotSpotMode="Navigate" Left="160"
                    NavigateUrl="~/Manuales/CotizadorM1.1.pptx" Right="260"
                    Top="380" />
            </asp:ImageMap>

        </td>
    </tr>
</table>


<br />
<br />


