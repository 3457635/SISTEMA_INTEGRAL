<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Contraresibo.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Contraresibo" %>

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
	
	
        .style5
        {
            width: 30px;
            font-family: Arial, Helvetica, sans-serif;
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
        .style12
        {
            width: 324px;
        }
        .style13
        {
            width: 76px;
        }
        	
	
        .style14
        {
            width: 76px;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
        }
        .style15
        {
            width: 43px;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
        }
        .style16
        {
            width: 91px;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
        }
        .style17
        {
            width: 72px;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
        }
        .style18
        {
            width: 30px;
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
        }
        	
	
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="hide">
    
        <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnImprimir"  
            onclientclick="hide();" style="width: 14px; height: 16px;" />
    
    &nbsp;<asp:LinkButton ID="LinkButton1" runat="server">Regresar</asp:LinkButton>
    
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
            DataSourceID="sdsRazonSocial" DataTextField="razon_social" 
            DataValueField="razon_social">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsRazonSocial" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT [razon_social] FROM [datos_facturacion] WHERE ([id_empresa] = @id_empresa) and idEstatus=5">
            <SelectParameters>
                <asp:QueryStringParameter Name="id_empresa" QueryStringField="cliente" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
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
        &nbsp;<br />
        Chihuahua, Chih. </span>
        <br class="style3" />
        <span class="style3">Departamento de Tráfico y Pagos</span></div>
    <p class="style3">
        Por medio de la presente, nos permitimos enviar relación de fletes.</p>
    <p class="style3">
        Se anexa documentación correspondiente;</p>
    <asp:GridView 
        ID="grdMn" runat="server" CssClass="Grid"
        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
        BorderWidth="1px"
        RowStyle-VerticalAlign="Bottom" 
        CellPadding="3" EnableModelValidation="True" AutoGenerateColumns="False" 
        Width="800px" Font-Names="Arial" DataSourceID="sdsViajesMN">
        

        <Columns>
            <asp:BoundField DataField="id_factura" InsertVisible="False" ReadOnly="True" SortExpression="id_factura">
            <ItemStyle Font-Size="0pt" />
            </asp:BoundField>
            <asp:BoundField DataField="folio" HeaderText="FACTURA" >
            
            <ItemStyle VerticalAlign="Middle" Font-Bold="True" />
            
            </asp:BoundField>
            <asp:BoundField DataField="importe" HeaderText="IMPORTE" 
                DataFormatString="{0:c}" >
            
            <ItemStyle VerticalAlign="Middle" />
            
            </asp:BoundField>
            <asp:BoundField DataField="retencion" DataFormatString="{0:c}" 
                HeaderText="RETENCION">
            <ItemStyle VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="iva" DataFormatString="{0:c}" HeaderText="IVA">
            <ItemStyle VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="total" DataFormatString="{0:c}" HeaderText="TOTAL">
            <ItemStyle VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="moneda" HeaderText="MONEDA" SortExpression="moneda">
            
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
                                ReadOnly="True" SortExpression="fecha_viaje" 
                                DataFormatString="{0:dd/MMM/yyyy}">
                            <ItemStyle Width="50px" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                   
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        
                        
                        
                        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) AS orden, dbo.empresas.nombre, dbo.llave_rutas.ruta, tipo_equipos.equipo, CONVERT (nvarchar, fechas.fecha, 3) AS fecha_viaje FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN facturacion ON viajes.id_viaje = facturacion.id_viaje INNER JOIN precios ON viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha WHERE (facturacion.id_factura = @id_factura) AND (fechas.tipo_fecha = 1)">
                        <SelectParameters>
                            <asp:Parameter Name="id_factura" DefaultValue="" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                   
                </ItemTemplate>
                
                <ItemStyle VerticalAlign="Middle" Width="400px" />
                
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#003366" ForeColor="White" Font-Bold="True" />
        <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="Black" 
            CssClass="DataGridFixedHeader" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <RowStyle ForeColor="#000066" />
        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
    </asp:GridView>
                        <asp:SqlDataSource ID="sdsViajesMN" runat="server" 
                            CancelSelectOnNullParameter="False" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            DeleteCommand="DELETE FROM [facturas] WHERE [id_factura] = @id_factura" 
                            InsertCommand="INSERT INTO [facturas] ([folio], [importe], [iva], [retencion], [total], [Cancelada], [id_dato_facturacion], [facturada_dolares], [Contrarecibo]) VALUES (@folio, @importe, @iva, @retencion, @total, @Cancelada, @id_dato_facturacion, @facturada_dolares, @Contrarecibo)" 
                            SelectCommand="SELECT	
	f.fecha
	, case fa.facturada_dolares
	when 1 then 'Dolares' else 'MN'
	end as moneda
    			,	fa.*
    			,c.foliofiscal
    			,c.serie
    			,c.enviadoA
		FROM	fechas f
		JOIN	fechas_facturacion	ff
		ON f.id_fecha = ff.id_fecha
		JOIN	facturas fa			
		ON ff.id_factura = fa.id_factura 	
		JOIN	
		datos_facturacion	df
		ON 
		fa.id_dato_facturacion = df.id_dato
		LEFT	JOIN
		cfdi c
		ON
		fa.id_factura=c.idFactura
		where	
		df.id_empresa=@cliente
		and		f.fecha&gt;=@inicio
		and		f.fecha&lt;=@fin
		and		f.tipo_fecha=4
		and		fa.contrarecibo=0
		and		fa.cancelada=0
		and		fa.id_factura not in (select id_factura from facturas_cajas)
		order	by f.fecha desc" 
                            
        UpdateCommand="UPDATE [facturas] SET [folio] = @folio, [Cancelada] = @Cancelada,   [Contrarecibo] = @Contrarecibo WHERE [id_factura] = @id_factura">
                            <DeleteParameters>
                                <asp:Parameter Name="id_factura" Type="Int32" />
                            </DeleteParameters>
                            
                            <InsertParameters>
                                <asp:Parameter Name="folio" />
                                <asp:Parameter Name="importe" />
                                <asp:Parameter Name="iva" />
                                <asp:Parameter Name="retencion" />
                                <asp:Parameter Name="total" />
                                <asp:Parameter Name="Cancelada" />
                                <asp:Parameter Name="id_dato_facturacion" />
                                <asp:Parameter Name="facturada_dolares" />
                                <asp:Parameter Name="Contrarecibo" />
                            </InsertParameters>
                            
                            <SelectParameters>
                                <asp:QueryStringParameter Name="cliente" QueryStringField="cliente" />
                                <asp:QueryStringParameter Name="inicio" QueryStringField="inicio" />
                                <asp:QueryStringParameter Name="fin" QueryStringField="fin" />
                            </SelectParameters>
                            
                            <UpdateParameters>
                                <asp:Parameter Name="folio" Type="Int32" />                                
                                <asp:Parameter Name="Cancelada" Type="Boolean" />        
                                <asp:Parameter Name="Contrarecibo" Type="Boolean" />
                                <asp:Parameter Name="id_factura" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
    <br />

        <asp:GridView ID="grdLibres" runat="server" AutoGenerateColumns="False" DataKeyNames="id_factura" DataSourceID="sdsFacturasOtros" EnableModelValidation="True">
            <Columns>
                <asp:BoundField DataField="id_factura" InsertVisible="False" ReadOnly="True" SortExpression="id_factura">
                <ItemStyle Font-Size="0pt" />
                </asp:BoundField>
                <asp:BoundField DataField="folio" HeaderText="FOLIO" SortExpression="folio" />
                <asp:BoundField DataField="importe" DataFormatString="{0:c2}" HeaderText="IMPORTE" SortExpression="importe" />
                <asp:BoundField DataField="retencion" DataFormatString="{0:c2}" HeaderText="RETENCION" SortExpression="retencion" />
                <asp:BoundField DataField="iva" DataFormatString="{0:c2}" HeaderText="IVA" SortExpression="iva" />
                <asp:BoundField DataField="total" DataFormatString="{0:c2}" HeaderText="TOTAL" SortExpression="total" />
                <asp:BoundField DataField="moneda" HeaderText="MONEDA" SortExpression="moneda" />
                <asp:BoundField DataField="concepto" HeaderText="CONCEPTO" SortExpression="concepto" />
            </Columns>
            <HeaderStyle Font-Names="Arial" />
            <RowStyle Font-Names="Arial" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsFacturasOtros" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT	
				fechas.fecha
				,case f.facturada_dolares 
					when 1 then 'Dolares' else 'MN'
					end as moneda
				,f.*
    			,cfdi.foliofiscal
    			,cfdi.serie
    			,cfdi.enviadoA
				,fo.concepto
		FROM	fechas 
		JOIN	fechas_facturacion	
		ON fechas.id_fecha = fechas_facturacion.id_fecha
		JOIN	facturas f			
		ON fechas_facturacion.id_factura = f.id_factura 	
		JOIN	
		datos_facturacion	
		ON 		
		f.id_dato_facturacion = datos_facturacion.id_dato
		join facturasOtros fo
		on fo.idFactura=f.id_factura
		LEFT	JOIN
		cfdi
		ON
		f.id_factura=cfdi.idFactura
		where	
				datos_facturacion.id_empresa=@cliente
		and		fechas.fecha&gt;=@inicio
		and		fechas.fecha&lt;=@fin
		and		fechas.tipo_fecha=4
		and		f.contrarecibo=0
		and		f.cancelada=0
		order	by fechas.fecha desc">
            <SelectParameters>
                <asp:QueryStringParameter Name="cliente" QueryStringField="cliente" />
                <asp:QueryStringParameter Name="inicio" QueryStringField="inicio" />
                <asp:QueryStringParameter Name="fin" QueryStringField="fin" />
            </SelectParameters>
        </asp:SqlDataSource>

    <br />

    <br />
    <table border="1" cellpadding="0" cellspacing="0" class="style12">
        <tr>
            <td class="style5">
                &nbsp;</td>
            <td class="style17">
                IMPORTE</td>
            <td class="style16">
                RETENCIÓN</td>
            <td class="style15">
                IVA</td>
            <td class="style14">
                TOTAL</td>
        </tr>
        <tr>
            <td class="style18">
                M.N</td>
            <td class="style7">
                <asp:Label ID="lblImporte" runat="server" CssClass="style3"></asp:Label>
            </td>
            <td class="style9">
                <asp:Label ID="lblRentencion" runat="server" CssClass="style3"></asp:Label>
            </td>
            <td class="style10">
                <asp:Label ID="lblIva" runat="server" CssClass="style3"></asp:Label>
            </td>
            <td class="style13">
                <asp:Label ID="lblTotalMn" runat="server" CssClass="style3"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style18">
                Dlls.</td>
            <td class="style7">
                <asp:Label ID="lblImporteDlls" runat="server" CssClass="style3"></asp:Label>
            </td>
            <td class="style9">
                <asp:Label ID="lblRetencionDlls" runat="server" CssClass="style3"></asp:Label>
            </td>
            <td class="style10">
                <asp:Label ID="lblIvaDlls" runat="server" CssClass="style3"></asp:Label>
            </td>
            <td class="style13">
                <asp:Label ID="lblTotalDlls" runat="server" CssClass="style3"></asp:Label>
            </td>
        </tr>
    </table>
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
