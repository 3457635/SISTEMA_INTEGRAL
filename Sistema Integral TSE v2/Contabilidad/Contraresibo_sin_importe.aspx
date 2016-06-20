<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Contraresibo_sin_importe.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Contraresibo_sin_importe" %>

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
        <asp:Label ID="lblLote" runat="server" 
            style="font-family: Arial, Helvetica, sans-serif"></asp:Label>
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
    <asp:GridView 
        ID="grdMn" runat="server" CssClass="Grid"
        RowStyle-VerticalAlign="Bottom" EnableModelValidation="True" AutoGenerateColumns="False" 
        Width="800px" ShowFooter="True" Font-Names="Arial">
        

        <Columns>
            <asp:BoundField DataField="id_factura" ShowHeader="False">
            
            <ItemStyle BorderStyle="Solid" ForeColor="White" Font-Size="0pt" Width="0px" />
            </asp:BoundField>
            <asp:BoundField DataField="folio" HeaderText="FACTURA" >
            
            <ItemStyle VerticalAlign="Middle" Font-Bold="True" />
            
            </asp:BoundField>
            <asp:TemplateField HeaderText="ORDEN  /  RUTA  /  VEHICULO / FECHA">
                <ItemTemplate>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  
                         DataSourceID="SqlDataSource1" 
                        EnableModelValidation="True" BorderStyle="None" 
                        ShowHeader="False" GridLines="Vertical" 
                        EmptyDataText="Movimiento Local TRW">
                        <Columns>
                            <asp:BoundField DataField="orden" HeaderText="orden" SortExpression="orden" 
                                ReadOnly="True" >
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta">
                            <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="equipo" HeaderText="equipo" SortExpression="equipo">
                            <ItemStyle Width="70px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fecha_viaje" HeaderText="fecha_viaje" 
                                ReadOnly="True" SortExpression="fecha_viaje">
                            <ItemStyle Width="50px" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                   
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        
                        
                        
                        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) AS orden, dbo.empresas.nombre, dbo.llave_rutas.ruta, tipo_equipos.equipo, CONVERT (nvarchar, fechas.fecha, 3) AS fecha_viaje FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN facturacion ON viajes.id_viaje = facturacion.id_viaje INNER JOIN precios ON viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha WHERE (facturacion.id_factura = @id_factura) and fechas.tipo_fecha=1">
                        <SelectParameters>
                            <asp:Parameter Name="id_factura" DefaultValue="" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                   
                </ItemTemplate>
                
                <ItemStyle VerticalAlign="Middle" Width="400px" />
                
            </asp:TemplateField>
        </Columns>
        <HeaderStyle 
            CssClass="DataGridFixedHeader" />
        <RowStyle />
    </asp:GridView>
    <br />
    <br />


    <asp:GridView 
        ID="grdDlls" runat="server" CssClass="Grid"
        RowStyle-VerticalAlign="Bottom" EnableModelValidation="True" AutoGenerateColumns="False" 
        Width="800px" ShowFooter="True" Font-Names="Arial">
        

        <Columns>
            <asp:BoundField DataField="id_factura" ShowHeader="False">
            
            <ItemStyle BorderStyle="Solid" ForeColor="White" Font-Size="0pt" Width="0px" />
            </asp:BoundField>
            <asp:BoundField DataField="folio" HeaderText="FACTURA" >
            
            <ItemStyle VerticalAlign="Middle" Font-Bold="True" />
            
            </asp:BoundField>
            <asp:TemplateField HeaderText="ORDEN  /  RUTA  /  VEHICULO / FECHA">
                <ItemTemplate>
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"  
                         DataSourceID="SqlDataSource2" 
                        EnableModelValidation="True" BorderStyle="None" 
                        ShowHeader="False" GridLines="Vertical" 
                        EmptyDataText="Movimiento Local TRW">
                        <Columns>
                            <asp:BoundField DataField="orden" HeaderText="orden" SortExpression="orden" 
                                ReadOnly="True" >
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta">
                            <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="equipo" HeaderText="equipo" SortExpression="equipo">
                            <ItemStyle Width="70px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fecha_viaje" HeaderText="fecha_viaje" 
                                ReadOnly="True" SortExpression="fecha_viaje">
                            <ItemStyle Width="50px" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                   
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        
                        
                        
                        
                        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) AS orden, dbo.empresas.nombre, dbo.llave_rutas.ruta, tipo_equipos.equipo, CONVERT (nvarchar, fechas.fecha, 3) AS fecha_viaje FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN facturacion ON viajes.id_viaje = facturacion.id_viaje INNER JOIN precios ON viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha WHERE (facturacion.id_factura = @id_factura) and fechas.tipo_fecha=1">
                        <SelectParameters>
                            <asp:Parameter Name="id_factura" DefaultValue="" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                   
                </ItemTemplate>
                
                <ItemStyle VerticalAlign="Middle" Width="400px" />
                
            </asp:TemplateField>
        </Columns>
        <HeaderStyle 
            CssClass="DataGridFixedHeader" />
        <RowStyle />
    </asp:GridView>
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
