<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlSaldosClientes.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlSaldosClientes" %>
<p>
    Total:
    <asp:Label ID="lblTotal" runat="server"></asp:Label>
&nbsp;M.N.</p>
<asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" 
    Width="1013px" SkinID="chrtIngresos" >
    <Series>
        <asp:Series IsValueShownAsLabel="True" Label="#VAL{C0}" Name="Series1" 
            XValueMember="nombre" YValueMembers="saldo">
        </asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1">
            <AxisY Title="Saldo" LineWidth="0" TitleForeColor="Blue">
                <MajorGrid Enabled="False" />
                <MajorTickMark Enabled="False" />
                <LabelStyle IntervalType="Number" Enabled="False" Format="{0:c0}" />
            </AxisY>
            <AxisX Interval="1" Title="Clientes" TitleForeColor="Blue">
                <MajorGrid Enabled="False" />
            </AxisX>
        </asp:ChartArea>
    </ChartAreas>
    <Titles>
        <asp:Title Name="Saldos Por Cliente" ForeColor="Blue" Text="Saldos Por Cliente">
        </asp:Title>
    </Titles>
</asp:Chart>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="select sum(tabla.total)as saldo,tabla.nombre from (SELECT   distinct facturas.id_factura, facturas.total, empresas.nombre
FROM        facturas INNER JOIN
                      facturacion ON facturas.id_factura = facturacion.id_factura INNER JOIN
                      viajes ON facturacion.id_viaje = viajes.id_viaje INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_facturacion ON facturas.id_factura = fechas_facturacion.id_factura INNER JOIN
                      fechas ON fechas_facturacion.id_fecha = fechas.id_fecha AND fechas_facturacion.id_fecha = fechas.id_fecha
WHERE viajes.id_status&lt;&gt;5 and 
facturas.folio is not NULL and 
(facturas.facturada_dolares = 0) AND 
(facturas.Cancelada = 0) and 
fechas.tipo_fecha=6 AND 
facturas.id_factura NOT IN
                          (SELECT     facturas_1.id_factura
                            FROM          fechas AS fechas_1 INNER JOIN
                                                   fechas_facturacion AS fechas_facturacion_1 ON fechas_1.id_fecha = fechas_facturacion_1.id_fecha AND 
                                                   fechas_1.id_fecha = fechas_facturacion_1.id_fecha INNER JOIN
                                                   facturas AS facturas_1 ON fechas_facturacion_1.id_factura = facturas_1.id_factura AND fechas_facturacion_1.id_factura = facturas_1.id_factura
                            WHERE      (fechas_1.tipo_fecha = 7)) 
) as tabla 
join facturas as f_out on tabla.id_factura=f_out.id_factura
where tabla.total is not NULL
group by tabla.nombre
"></asp:SqlDataSource>

