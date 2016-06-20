<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlFacturas.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlFacturas" %>
<p>
    <asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
&nbsp;
    <asp:TextBox ID="txbFin" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
    <asp:Button ID="Button1" runat="server" Text="Mostrar" />
    <br />
</p>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    EnableModelValidation="True">
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS ORDEN, dbo.empresas.nombre AS CLIENTE, dbo.llave_rutas.ruta AS RUTA, CONVERT (nvarchar, CONVERT (money, precios.precio), 1) + ' ' + tipos_monedas.moneda AS PRECIO FROM viajes INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN facturacion ON viajes.id_viaje = facturacion.id_viaje INNER JOIN fechas_facturacion ON facturacion.id_facturacion = fechas_facturacion.id_facturacion INNER JOIN fechas ON fechas_facturacion.id_fecha = fechas.id_fecha INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden INNER JOIN tipos_monedas ON precios.id_moneda = tipos_monedas.id_moneda INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta WHERE (fechas.fecha BETWEEN '02/05/2012' AND '02/11/2012') AND (fechas.tipo_fecha = 6) AND (precios.id_moneda = 5)">
</asp:SqlDataSource>

