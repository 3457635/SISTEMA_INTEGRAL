<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Contraresibo_alphabet.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Contraresibo_alphabet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">   
    <script type="text/javascript">
        function hide() {
            document.poppedLayer = eval('document.getElementById("hide")');
            document.poppedLayer.style.visibility = "hidden";
            window.print();
        }
    </script>   
    <style type="text/css">
        .style1
        {
            width: 34px;
            height: 45px;
            font-family: Arial, Helvetica, sans-serif;
        }
        .style2
        {
            width: 100%;
        }
        .style3
        {
            font-family: Arial, Helvetica, sans-serif;
        }
    .DataGridFixedHeader
	{
	position: relative;
	top: expression(this.offsetParent.scrollTop); /*this works fine with IE only, but FireFox seems to be ignoring this*/
	}
	
	
        .style4
        {
            text-align: left;
        }
	
	
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="hide">
    
        <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnImprimir"  
            onclientclick="hide();" style="width: 14px" />
    
    &nbsp;<asp:LinkButton ID="LinkButton1" runat="server">Regresar</asp:LinkButton>
    
    &nbsp;<asp:TextBox ID="txbInicio" runat="server" Visible="False"></asp:TextBox>
&nbsp;<asp:TextBox ID="txbFin" runat="server" Visible="False"></asp:TextBox>
&nbsp;<asp:TextBox ID="txbCliente" runat="server" Visible="False"></asp:TextBox>
    
&nbsp;&nbsp;</div>
    <div>
    
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
        _____________________________________________________________________________________________________________<br class="style3" />
        <br class="style3" />
        <span class="style3">
        <asp:Label ID="lblCliente" runat="server" CssClass="style3" Font-Bold="True"></asp:Label>
        <br />
        <asp:Label ID="lblFecha" runat="server" CssClass="style3"></asp:Label>
        &nbsp;<asp:TextBox ID="txbFecha" runat="server" Visible="False"></asp:TextBox>
        <br />
        Chihuahua, Chih. </span>
        <br class="style3" />
        <span class="style3">Departamento de Tráfico y Pagos</span></div>
    <p class="style3">
        Por medio de la presente, nos permitimos enviar relación de fletes.</p>
    <p class="style3">
        Se anexa documentación correspondiente;</p>
    <p class="style3">
        <asp:TextBox ID="TextBox1" runat="server" Height="23px" Width="330px">Tipo de Cambio </asp:TextBox>
    </p>
    <asp:GridView 
        ID="grdMn" runat="server" CssClass="Grid"
        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
        BorderWidth="1px"
        RowStyle-VerticalAlign="Bottom" 
        CellPadding="3" EnableModelValidation="True" AutoGenerateColumns="False" 
        Width="800px" ShowFooter="True" Font-Names="Arial" 
        DataSourceID="sdsOrdenes">
        

        <Columns>
            <asp:BoundField DataField="orden" HeaderText="ORDEN" ReadOnly="True" 
                SortExpression="orden">
            
            </asp:BoundField>
            <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" >
            
            </asp:BoundField>
            <asp:BoundField DataField="equipo" HeaderText="VEHICULO" 
                SortExpression="equipo" >
            
            </asp:BoundField>
            <asp:BoundField DataField="fecha" 
                HeaderText="FECHA" ReadOnly="True" SortExpression="fecha">
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#003366" ForeColor="White" Font-Bold="True" />
        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" 
            CssClass="DataGridFixedHeader" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <RowStyle ForeColor="#000066" />
        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="sdsOrdenes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS orden, dbo.llave_rutas.ruta, tipo_equipos.equipo, CONVERT (nvarchar(10), fechas.fecha, 103) AS fecha, precios.precio FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN precios ON viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN facturacion ON viajes.id_viaje = facturacion.id_viaje WHERE (facturacion.id_factura = @id_factura)">
        <SelectParameters>
            <asp:Parameter Name="id_factura" />
        </SelectParameters>
    </asp:SqlDataSource>
    TOTAL
    <asp:Label ID="lblTotal" runat="server"></asp:Label>
    <br />
    <br />


    <p>
        Recibo por parte de Transportes y Seguridad Empresarial<br />
        las facturas de los viajes listados en este documento,<br />
        asi como su respectivo soporte.<br></p>
    </form>
    <p>
        &nbsp;</p>
    <p>
        ___________________________________</p>
    <p>
        Firma del Cliente.</p>
</body>
</html>
