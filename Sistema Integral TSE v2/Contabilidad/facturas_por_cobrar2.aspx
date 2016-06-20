<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="facturas_por_cobrar2.aspx.vb" Inherits="Sistema_Integral_TSE_v45.facturas_por_cobrar2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../Controles_Usuario/ctlSaldosClientes.ascx" TagName="ctlSaldosClientes" TagPrefix="uc1" %>
<%@ Register Src="../Controles_Usuario/ctlIngresosPorCliente.ascx" TagName="ctlIngresosPorCliente" TagPrefix="uc3" %>


<%@ Register Src="../Controles_Usuario/ctlUnfactured.ascx" TagName="ctlUnfactured" TagPrefix="uc2" %>


<%@ Register Src="../Controles_Usuario/ctlIngresosPorClienteDlls.ascx" TagName="ctlIngresosPorClienteDlls" TagPrefix="uc4" %>


<%@ Register Src="../Controles_Usuario/ctlSemaforoCxC.ascx" TagName="ctlSemaforoCxC" TagPrefix="uc5" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1 class="style6">Facturas por cobrar</h1>

    <asp:WebPartManager ID="WebPartManager1" runat="server">
    </asp:WebPartManager>

    <asp:WebPartZone ID="WebPartZone1" runat="server" SkinID="wprtProfesional">
    </asp:WebPartZone>
    <br />

    <asp:WebPartZone ID="WebPartZone2" runat="server" SkinID="wprtProfesional">
    </asp:WebPartZone>

    <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0"
        Height="488px" Width="1280px" style="margin-right: 40px">
        <asp:TabPanel ID="TabPanel1" runat="server" HeaderText="Indicadores">
            <ContentTemplate>
                <table>
                    <tr><td></td><td></td></tr>
                    <tr>
                        <td>
                            <asp:GridView
                                ID="GridView1" runat="server" AutoGenerateColumns="False"
                                DataSourceID="sdsResumen" SkinID="GridViewGreen">
                                <Columns>
                                    <asp:BoundField DataField="días"
                                        HeaderText="RANGO" ReadOnly="True" SortExpression="rango" />
                                    <asp:BoundField
                                        DataField="facturas" HeaderText="FACTURAS" ReadOnly="True"
                                        SortExpression="viajes" />
                                    <asp:BoundField DataField="MONTO" DataFormatString="{0:c0}" HeaderText="MONTO" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource
                                ID="sdsResumen" runat="server"
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                                SelectCommand="CuentasporCobrar" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="13" Name="nTipo_Cambio" Type="Int32" />
                                    <asp:Parameter DefaultValue="Resúmen" Name="cCual" Type="String" />
                                    <asp:Parameter DefaultValue="+60" Name="cTipo" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                        <td>

                            <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataSourceID="sdsClientesDias" SkinID="GridViewGreen">
                                <Columns>
                                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                                    <asp:BoundField DataField="0 a 30" DataFormatString="{0:c0}" HeaderText="0 a 30" />
                                    <asp:BoundField DataField="31 a 60" DataFormatString="{0:c0}" HeaderText="31 a 60" />
                                    <asp:BoundField DataField="+60" DataFormatString="{0:c0}" HeaderText="+60" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsClientesDias" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="CuentasporCobrar" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="13" Name="nTipo_Cambio" Type="Int32" />
                                    <asp:Parameter DefaultValue="Clientes" Name="cCual" Type="String" />
                                    <asp:Parameter DefaultValue="Total" Name="cTipo" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Chart ID="Chart3" runat="server" BorderlineColor="Black" BorderlineWidth="0" Palette="Bright" Width="1146px" Height="475px" Visible="False">
                                <Series>
                                    <asp:Series IsValueShownAsLabel="True" LabelAngle="45" LabelFormat="{0:n0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" Name="0 a 30" ChartArea="ChartArea1">
                                    </asp:Series>
                                    <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Legend="Legend1" Name="31 a 60">
                                    </asp:Series>
                                    <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Legend="Legend1" Name="+60">
                                    </asp:Series>
                                </Series>
                                <ChartAreas>
                                    <asp:ChartArea BorderDashStyle="Solid" BorderWidth="0" Name="ChartArea1">
                                        <AxisY LineWidth="0">
                                            <MajorGrid Enabled="False" LineWidth="0" />
                                        </AxisY>
                                        <AxisX Interval="1">
                                            <MajorGrid Enabled="False" LineWidth="0" />
                                            <MinorGrid LineWidth="0" />
                                        </AxisX>
                                        <AxisX2>
                                            <MajorGrid Enabled="False" />
                                        </AxisX2>
                                        <AxisY2>
                                            <MajorGrid Enabled="False" />
                                        </AxisY2>
                                    </asp:ChartArea>
                                </ChartAreas>
                                <Legends>
                                    <asp:Legend AutoFitMinFontSize="5" IsTextAutoFit="False" LegendStyle="Column" Name="Legend1">
                                    </asp:Legend>
                                </Legends>
                                <Titles>
                                    <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Saldo Vencido">
                                    </asp:Title>
                                </Titles>
                            </asp:Chart>

                        </td>
                    </tr>
                </table>


            </ContentTemplate>
        </asp:TabPanel>
        <asp:TabPanel ID="TabPanel2" runat="server" HeaderText="Detalle">
            <HeaderTemplate>
                Detalle Vencido
            </HeaderTemplate>
            <ContentTemplate>

                <br />
                Rango
                <asp:DropDownList ID="ddlRango" runat="server" Height="18px"
                    Width="159px">
                    <asp:ListItem Value="0 a 30">0 a 30 días</asp:ListItem>
                    <asp:ListItem Value="31 a 60">31 a 60 días</asp:ListItem>
                    <asp:ListItem Value="+60" Selected="True">+60 días</asp:ListItem>
                </asp:DropDownList><asp:Button ID="btnConsultar"
                    runat="server" Text="Consultar" /><br />
                <br />
                <asp:GridView ID="grdDetalle"
                    runat="server" AutoGenerateColumns="False" DataSourceID="sdsDetalles" Width="635px" AllowPaging="True" SkinID="GridViewGreen">
                    <Columns>
                        <asp:BoundField DataField="factura"
                            HeaderText="FACTURA" SortExpression="folio" />
                        <asp:BoundField
                            DataField="fecha_Factura" HeaderText="FECHA FACTURACION"
                            SortExpression="fechaFactura" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="total"
                            DataFormatString="{0:c0}" HeaderText="IMPORTE" SortExpression="total" />
                        <asp:BoundField
                            DataField="cliente" HeaderText="CLIENTE" SortExpression="cliente" />
                        <asp:BoundField
                            DataField="días" HeaderText="DIAS TRANSCURRIDO"
                            SortExpression="diferencia" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource
                    ID="sdsDetalles" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="CuentasporCobrar" CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="nTipo_Cambio" DefaultValue="13" Type="Int32" />
                        <asp:Parameter Name="cCual" DefaultValue="Factura" Type="String" />
                        <asp:ControlParameter ControlID="ddlRango" DefaultValue="+60" Name="cTipo" PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:TabPanel>
    </asp:TabContainer>

    <br />
    <br />
    <hr />
    <h1>Seleccionar cliente</h1>
    
    Cliente:
    <asp:DropDownList ID="ddlEmpresas" runat="server" DataSourceID="sdsClientes"
        DataTextField="razon_social" DataValueField="id_dato" Height="30px"
        Width="449px">
    </asp:DropDownList>
    <asp:SqlDataSource ID="sdsClientes" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="SELECT        datos_facturacion.razon_social, datos_facturacion.id_dato
FROM            dbo.empresas INNER JOIN
                         datos_facturacion ON dbo.empresas.id_empresa = datos_facturacion.id_empresa
WHERE        (dbo.empresas.id_status = 5) and
empresas.id_tipo_empresa=1
AND 
(datos_facturacion.razon_social IS NOT NULL) 
aND
                         (LTRIM(datos_facturacion.razon_social) &lt;&gt; '')
ORDER BY datos_facturacion.razon_social"></asp:SqlDataSource>
    <br />
    &nbsp;<br />
    <asp:LinkButton ID="lnkSaldo" runat="server">Ver saldo del cliente.</asp:LinkButton>
    <br />
    <br />
    <asp:LinkButton ID="lnkRetraso" runat="server">Ver promesas atrasadas.</asp:LinkButton>
    <hr /><h1>Indicar filtros</h1>
    <strong><span class="style5">
        
        Filtrar por fecha de facturación;&nbsp;&nbsp;</span>&nbsp;&nbsp; </strong>&nbsp;&nbsp;
    <asp:RadioButtonList ID="RadioButtonList1" runat="server">
        <asp:ListItem Value="7">Ingresado</asp:ListItem>
        <asp:ListItem Value="6">Prometido</asp:ListItem>
        <asp:ListItem Selected="True" Value="4">Todas</asp:ListItem>
    </asp:RadioButtonList>
    <br />
    Fecha Desde:<asp:TextBox
        ID="txbFechaInicio" runat="server" ValidationGroup="porFecha"></asp:TextBox>
    <asp:CalendarExtender ID="CalendarExtender1" runat="server"
        TargetControlID="txbFechaInicio" Format="dd/MM/yyyy">
    </asp:CalendarExtender>
    &nbsp;- Hasta:<asp:TextBox ID="txbFechaFin" runat="server"
        ValidationGroup="porFecha"></asp:TextBox>
    <asp:CalendarExtender ID="CalendarExtender3" runat="server"
        TargetControlID="txbFechaFin" Format="dd/MM/yyyy">
    </asp:CalendarExtender>
    <asp:Button ID="btnIngresado" runat="server" SkinID="btn" Text="Buscar"
        ValidationGroup="porFecha" />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server"
        ControlToValidate="txbFechaInicio" ErrorMessage="Fecha inicio requerido"
        ValidationGroup="porFecha"></asp:RequiredFieldValidator>
    &nbsp;
    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server"
        ControlToValidate="txbFechaFin" ErrorMessage="Fecha fin requerida"
        ValidationGroup="porFecha"></asp:RequiredFieldValidator>
    <br />
    <br />
    <span class="style5">
        <strong>Filtrar por rango de facturas;</strong></span><br />
    Inicio:<asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
    - Fin:<asp:TextBox ID="txbFin" runat="server"></asp:TextBox>
    &nbsp;<asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar"
        ValidationGroup="porRango" />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
        ControlToValidate="txbInicio" ErrorMessage="*" ValidationGroup="porRango">Rango de inicio obligatorio</asp:RequiredFieldValidator>
    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
        ControlToValidate="txbFin" ErrorMessage="*" ValidationGroup="porRango">Rango de fin obligatorio</asp:RequiredFieldValidator>
    <br />
    <br />
    <span class="style5">
        <strong>Filtrar por lote de contrarecibo;</strong></span><br />
    Lote:
    <asp:TextBox ID="txbLote" runat="server"></asp:TextBox>
    &nbsp;<asp:Button ID="btnBuscarLote" runat="server" SkinID="btn" Text="Buscar"
        ValidationGroup="porLote" />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
        ControlToValidate="txbLote" ErrorMessage="*" ValidationGroup="porLote">Falta el numero de lote.</asp:RequiredFieldValidator>
    <br />
    <br />
    
    <hr /><h1>Indicar fechas de pago</h1>
    Fecha de Promesa de Pago:
    <asp:TextBox ID="txbPromesaPago" runat="server"></asp:TextBox>
    <asp:Button ID="btnGuardarPromesa" runat="server" SkinID="btn" Text="Guadar" ValidationGroup="guardarPromesa" />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server"
        ControlToValidate="txbPromesaPago" ErrorMessage="*" ValidationGroup="guardarPromesa">Ingresa la fecha.</asp:RequiredFieldValidator>
    <asp:CalendarExtender ID="CalendarExtender2" runat="server"
        Enabled="True" TargetControlID="txbPromesaPago" Format="dd/MM/yyyy">
    </asp:CalendarExtender>
    <br />
    <br />
    <br />
    Fecha de Ingreso:
    <asp:TextBox ID="txbFecha" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="txbFecha_CalendarExtender" runat="server"
        Enabled="True" TargetControlID="txbFecha" Format="dd/MM/yyyy">
    </asp:CalendarExtender>
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" SkinID="btn"
        ValidationGroup="guardar" />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"
        ControlToValidate="txbFecha" ErrorMessage="*" ValidationGroup="guardar">Ingresa la fecha.</asp:RequiredFieldValidator>
    <br />
    <hr />
    &nbsp;<br />
    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    &nbsp;<br />
    <asp:CheckBox ID="ckbSeleccionar" runat="server" AutoPostBack="True"
        Text="Todas las facturas..." />
    <br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
        DataKeyNames="id_factura" DataSourceID="sdsFacturas"
        EnableModelValidation="True" ShowFooter="True"
        EmptyDataText="No hay datos.">
        <Columns>
            <asp:BoundField DataField="id_factura" InsertVisible="False" ReadOnly="True"
                SortExpression="id_factura">
                <ItemStyle Font-Size="0pt" />
            </asp:BoundField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="ckbFactura" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="FECHA INGRESO">
                <ItemTemplate>
                    <asp:Label ID="lblFecha" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="FECHA PROMESA">
                <ItemTemplate>
                    <asp:Label ID="lblPromesa" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="fecha" DataFormatString="{0:d}"
                HeaderText="FECHA FACTURA" />
            <asp:BoundField DataField="folio" HeaderText="FOLIO" ReadOnly="True"
                SortExpression="folio" />
            <asp:BoundField DataField="importe" DataFormatString="{0:c}"
                HeaderText="IMPORTE" />
            <asp:BoundField DataField="iva" DataFormatString="{0:c}" HeaderText="IVA" />
            <asp:BoundField DataField="retencion" DataFormatString="{0:c}"
                HeaderText="RETENCIÓN" />
            <asp:BoundField DataField="total" DataFormatString="{0:c}" HeaderText="TOTAL" />
            <asp:TemplateField HeaderText="SERVICIO">
                <ItemTemplate>
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False"
                        DataSourceID="sdsViajes" EnableModelValidation="True" SkinID="grdAnidado">
                        <Columns>
                            <asp:BoundField DataField="orden" HeaderText="orden" SortExpression="orden" />
                            <asp:BoundField DataField="nombre" HeaderText="nombre"
                                SortExpression="nombre" />
                            <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta" />
                            <asp:BoundField DataField="equipo" HeaderText="equipo"
                                SortExpression="equipo" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsViajes" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT 
convert(nvarchar,Ordenes.ano)
+'-'+ 
convert(nvarchar,Ordenes.consecutivo)
+'-'+ 
convert(nvarchar,viajes.num_viaje)
as orden,
dbo.empresas.nombre, 
dbo.llave_rutas.ruta, tipo_equipos.equipo FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo INNER JOIN facturacion ON viajes.id_viaje = facturacion.id_viaje WHERE (facturacion.id_factura = @id_factura)">
                        <SelectParameters>
                            <asp:Parameter Name="id_factura" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False"
                        DataSourceID="sdsCajas" EnableModelValidation="True" SkinID="grdAnidado">
                        <Columns>
                            <asp:BoundField DataField="nombre" DataFormatString="Cliente: {0}"
                                HeaderText="nombre" SortExpression="nombre" />
                            <asp:BoundField DataField="Expr1" HeaderText="Expr1" ReadOnly="True"
                                SortExpression="Expr1">
                                <ItemStyle Font-Bold="True" />
                            </asp:BoundField>
                            <asp:BoundField DataField="inicio" DataFormatString="Desde: {0:d}"
                                HeaderText="inicio" SortExpression="inicio" />
                            <asp:BoundField DataField="fin" DataFormatString="Hasta: {0:d}"
                                HeaderText="fin" SortExpression="fin" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsCajas" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT dbo.empresas.nombre, 'Renta de Caja ' + equipo_operacion.economico AS Expr1, facturas_cajas.inicio, facturas_cajas.fin FROM facturas_cajas INNER JOIN orden_cajas ON facturas_cajas.id_renta = orden_cajas.id_renta INNER JOIN precios_cajas ON orden_cajas.id_precio = precios_cajas.id_precio_caja INNER JOIN dbo.empresas ON precios_cajas.id_cliente = dbo.empresas.id_empresa INNER JOIN equipo_operacion ON orden_cajas.id_equipo = equipo_operacion.id_equipo AND orden_cajas.id_equipo = equipo_operacion.id_equipo WHERE (facturas_cajas.id_factura = @id_factura)">
                        <SelectParameters>
                            <asp:Parameter Name="id_factura" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle Font-Bold="True" />
    </asp:GridView>
    <br />

    <asp:SqlDataSource ID="sdsFacturas" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="facturasSinIngreso" SelectCommandType="StoredProcedure"
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="tipoConsulta" Type="Int32" />
            <asp:Parameter DefaultValue="" Name="inicio" />
            <asp:Parameter DefaultValue="" Name="fin" />
            <asp:Parameter DefaultValue="" Name="idLote" Type="Int32" />
            <asp:Parameter Name="idDato" Type="Int32" />
            <asp:Parameter Name="tipoFecha" Type="Int32" />
            <asp:Parameter Name="fechaInicio" Type="DateTime" />
            <asp:Parameter Name="fechaFin" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <br />

    <br />
    <br />
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Head">
    <style type="text/css">
        .style5 {
            color: #006600;
        }

        .style6 {
            font-family: Arial, Helvetica, sans-serif;
        }
    </style>
</asp:Content>

