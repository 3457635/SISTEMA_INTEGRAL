<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ContraresiboCaja.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ContraresiboCaja" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function hide() {
            document.poppedLayer = eval('document.getElementById("hide")');
            document.poppedLayer.style.visibility = "hidden";
            window.print();
        }
    </script>   
    <style type="text/css">

        .style2
        {
            width: 100%;
        }
        .style1
        {
            width: 34px;
            height: 45px;
            font-family: Arial, Helvetica, sans-serif;
        }
        	
	
        .style4
        {
            text-align: left;
        }
	
	
        .style3
        {
            font-family: Arial, Helvetica, sans-serif;
        }
        .style12
        {
            width: 324px;
        }
        	
	
        .style5
        {
            width: 30px;
            font-family: Arial, Helvetica, sans-serif;
        }
        .style17
        {
            width: 72px;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
        }
        .style16
        {
            width: 91px;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
        }
        .style15
        {
            width: 43px;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
        }
                	
	
        .style14
        {
            width: 76px;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
        }
        .style18
        {
            width: 30px;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
        }
        	
	
        .style7
        {
            width: 72px;
        }
        .style9
        {
            width: 91px;
        }
        .style10
        {
            width: 43px;
        }
        .style13
        {
            width: 76px;
        }
        	
	
        </style>
</head>
<body>
    <form id="form1" runat="server">

    <div>
    
    <div id="hide">
    
        <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnImprimir"  
            onclientclick="hide();" Height="37px" />
    
    &nbsp;<asp:LinkButton ID="LinkButton1" runat="server">Regresar</asp:LinkButton>
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="sdsRazonSocial" DataTextField="razon_social" 
            DataValueField="razon_social">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsRazonSocial" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT [razon_social] FROM [datos_facturacion] WHERE ([id_empresa] = @id_empresa)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id_empresa" QueryStringField="cliente" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    
        <table class="style2">
            <tr>
                <td>
                    <img alt="" class="style1" src="../imagenes/logo.jpg" /></td>
                <td class="style4">
                    <span class="style3"><strong>Transportes y Seguridad Empresarial</strong></span><br 
                        class="style3" />
                    <span class="style3">Octavio Paz No. 170, Complejo Industrial Chihuahua</span><br 
                        class="style3" />
                    <span class="style3">Tel.(614) 481-42-10&nbsp; </span>
                </td>
            </tr>
        </table>
        <asp:Label ID="lblLote" runat="server" 
            style="font-family: Arial, Helvetica, sans-serif"></asp:Label>
        <br />
        <span class="style3">
        <asp:Label ID="lblCliente" runat="server" CssClass="style3" Font-Bold="True"></asp:Label>
        <br />
        <asp:Label ID="lblFecha" runat="server" CssClass="style3"></asp:Label>
        </span>
        <br />
    <div>
    
        <span class="style3">
        Chihuahua, Chih. </span>
        <br class="style3" />
        <span class="style3">Departamento de Tráfico y Pagos</span></div>
    <p class="style3">
        Por medio de la presente, nos permitimos enviar relación de fletes.</p>
    <p class="style3">
        Se anexa documentación correspondiente;</p>

    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
        CellPadding="3" DataSourceID="sdsRentaCajas" EnableModelValidation="True" 
        style="font-family: Arial, Helvetica, sans-serif">
        <Columns>
            <asp:BoundField DataField="id_factura" InsertVisible="False" ReadOnly="True" 
                SortExpression="id_factura">
            <ItemStyle Font-Size="0pt" Width="0px" />
            </asp:BoundField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text="Renta de Caja"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="folio" HeaderText="FACTURA" SortExpression="folio" />
            <asp:BoundField DataField="importe" DataFormatString="{0:c}" 
                HeaderText="IMPORTE" SortExpression="importe" />
            <asp:BoundField DataField="iva" DataFormatString="{0:c}" HeaderText="IVA" 
                SortExpression="iva" />
            <asp:BoundField DataField="total" DataFormatString="{0:c}" HeaderText="TOTAL" 
                SortExpression="total" />
            <asp:BoundField DataField="economico" HeaderText="CAJA" 
                SortExpression="economico" />
            <asp:BoundField DataField="Inicio" DataFormatString="{0:d}" HeaderText="DESDE" 
                SortExpression="Inicio" />
            <asp:BoundField DataField="Fin" DataFormatString="{0:d}" HeaderText="HASTA" 
                SortExpression="Fin" />
        </Columns>
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="Black" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <RowStyle ForeColor="#000066" />
        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
        <br />


    <asp:SqlDataSource ID="sdsRentaCajas" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        
        
        SelectCommand="SELECT        
f.id_factura, 
f.folio, 
f.importe, 
f.iva, 
f.total, 
eo.economico, 
fc.inicio, 
fc.fin, 
f.facturada_dolares
FROM            
facturas f
INNER JOIN
facturas_cajas fc
ON f.id_factura = fc.id_factura 
INNER JOIN
orden_cajas oc
ON fc.id_renta = oc.id_renta 
INNER JOIN
precios_cajas pc
ON oc.id_precio = pc.id_precio_caja 
INNER JOIN
equipo_operacion eo
ON oc.id_equipo = eo.id_equipo
join 
fechas_facturacion ff
on ff.id_factura=f.id_factura
join
fechas fe
on fe.id_fecha=ff.id_fecha
WHERE        (f.Cancelada = 0) 
AND (pc.id_cliente = @id_cliente) 
AND (f.Contrarecibo = 0)
AND fe.tipo_fecha=4
and fe.fecha between @inicio and @fin">
        <SelectParameters>
            <asp:QueryStringParameter Name="id_cliente" QueryStringField="cliente" />
            <asp:QueryStringParameter Name="inicio" QueryStringField="inicio" />
            <asp:QueryStringParameter Name="fin" QueryStringField="fin" />
        </SelectParameters>
    </asp:SqlDataSource>


        <br />
        <asp:GridView ID="grdTotal" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTotal" EnableModelValidation="True" Font-Names="Arial">
            <Columns>
                <asp:BoundField DataField="TOTAL" HeaderText="TOTAL" ReadOnly="True" SortExpression="TOTAL" />
                <asp:BoundField DataField="moneda" SortExpression="moneda" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsTotal" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT        
'$'+convert (varchar (25),sum(convert(money,facturas.total)),25) as TOTAL,
moneda=
case 
	when facturas.facturada_dolares=1 then 'Dolares'
	when facturas.facturada_dolares=0 then 'MN'
end 
FROM            
facturas 
INNER JOIN
                         facturas_cajas ON facturas.id_factura = facturas_cajas.id_factura INNER JOIN
                         orden_cajas ON facturas_cajas.id_renta = orden_cajas.id_renta INNER JOIN
                         precios_cajas ON orden_cajas.id_precio = precios_cajas.id_precio_caja INNER JOIN
                         equipo_operacion ON orden_cajas.id_equipo = equipo_operacion.id_equipo
						 join 
						 fechas_facturacion ff
						 on ff.id_factura=facturas.id_factura
						 join
						 fechas f
						 on f.id_fecha=ff.id_fecha
WHERE        (facturas.Cancelada = 0) 
AND (precios_cajas.id_cliente = @id_cliente) 
AND (facturas.id_factura NOT IN
                             (SELECT        fechas_facturacion.id_factura
                               FROM            fechas_facturacion INNER JOIN
                                                         fechas ON fechas_facturacion.id_fecha = fechas.id_fecha
                               WHERE        (fechas.tipo_fecha = 5) 
							   AND (fechas.fecha &lt;= GETDATE()))) 
							   AND (facturas.Contrarecibo = 0)
							   AND f.tipo_fecha=4
							   and f.fecha between @inicio and @fin
group by facturas.facturada_dolares">
            <SelectParameters>
                <asp:QueryStringParameter Name="id_cliente" QueryStringField="cliente" />
                <asp:QueryStringParameter Name="inicio" QueryStringField="inicio" />
                <asp:QueryStringParameter Name="fin" QueryStringField="fin" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />


        <br />
        <br />
    <p>
        Recibo por parte de Transportes y Seguridad Empresarial<br />
        las facturas de los viajes listados en este documento,<br />
        asi como su respectivo soporte.<br></p>
    
    </div>
    </form>
</body>
</html>
