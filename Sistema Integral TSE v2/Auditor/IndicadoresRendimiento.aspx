<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="IndicadoresRendimiento.aspx.vb" Inherits="Sistema_Integral_TSE_v45.IndicadoresRendimiento" %>
<%@ Register src="../Controles_Usuario/ctlGraficaLocaleros.ascx" tagname="ctlGraficaLocaleros" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Indicadores de Rendimientos</h1>
    <asp:WebPartManager ID="WebPartManager1" runat="server">
    </asp:WebPartManager>
    <asp:WebPartZone ID="WebPartZone1" runat="server" SkinID="wprtProfesional">
        <ZoneTemplate>
            <uc1:ctlGraficaLocaleros ID="ctlGraficaLocaleros1" title="Rendimientos Localeros" runat="server" />
        </ZoneTemplate>
    </asp:WebPartZone>
</asp:Content>
