<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="tableroEgresos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.tableroEgresos" %>
<%@ Register src="../../../../Controles_Usuario/ctlGraficaCuentasPorPagar.ascx" tagname="ctlGraficaCuentasPorPagar" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1>Egresos</h1>
    <uc1:ctlGraficaCuentasPorPagar ID="ctlGraficaCuentasPorPagar1" runat="server" />
</asp:Content>
