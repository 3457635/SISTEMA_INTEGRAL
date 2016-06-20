<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="cierreCaja.aspx.vb" Inherits="Sistema_Integral_TSE_v45.cierreCaja" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1>Cierre de Orden de Renta de Caja</h1>
    <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
        DataSourceID="sdsCajas" DataTextField="orden" DataValueField="id_renta">
    </asp:RadioButtonList>
    <asp:SqlDataSource ID="sdsCajas" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT dbo.empresas.nombre+' Caja:'+ equipo_operacion.economico as orden,  orden_cajas.id_renta FROM orden_cajas INNER JOIN precios_cajas ON orden_cajas.id_precio = precios_cajas.id_precio_caja INNER JOIN equipo_operacion ON orden_cajas.id_equipo = equipo_operacion.id_equipo INNER JOIN dbo.empresas ON precios_cajas.id_cliente = dbo.empresas.id_empresa WHERE (orden_cajas.Fin &lt; orden_cajas.Inicio) ORDER BY equipo_operacion.economico">
    </asp:SqlDataSource>
    <br />
    Fecha Cierre:
    <asp:TextBox ID="txbFechaCierre" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="txbFechaCierre_CalendarExtender" runat="server" 
        Enabled="True" Format="dd/MM/yyyy" TargetControlID="txbFechaCierre">
    </asp:CalendarExtender>
    <br />
    <asp:Button ID="btnGuardar" runat="server" SkinID="btn" Text="Guardar" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />


</asp:Content>
