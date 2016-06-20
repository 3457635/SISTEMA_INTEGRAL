<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="tableroAuditoria.aspx.vb" Inherits="Sistema_Integral_TSE_v45.tableroAuditoria" %>
<%@ Register src="../Controles_Usuario/ctlGraficaRendimientoChofer.ascx" tagname="ctlGraficaRendimientoChofer" tagprefix="uc1" %>
<%@ Register src="../Controles_Usuario/ctlGraficaRendimientoPorCliente.ascx" tagname="ctlGraficaRendimientoPorCliente" tagprefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc2:ctlGraficaRendimientoPorCliente ID="ctlGraficaRendimientoPorCliente1" 
    runat="server" />
<p>
        <br />
    </p>
</asp:Content>
