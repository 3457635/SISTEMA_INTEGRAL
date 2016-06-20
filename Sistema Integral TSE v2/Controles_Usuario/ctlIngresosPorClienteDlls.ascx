<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlIngresosPorClienteDlls.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlIngresosPorClienteDlls" %>
<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>
<p>
    Año:
    <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
&nbsp; Mes:
    <asp:DropDownList ID="ddlMes" runat="server" SkinID="ddlMes">    
    </asp:DropDownList>
&nbsp;<asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" 
        style="width: 14px" />
&nbsp;</p>
<p>
    Total del Mes 
    en Dolares:
    <asp:Label ID="lblTotal" runat="server">$ 0</asp:Label>
&nbsp;Total del Año en Dolares: <asp:Label ID="lblAno" runat="server"></asp:Label>
</p>
<asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" 
    Width="1017px">
    <Series>
        <asp:Series IsValueShownAsLabel="True" Label="#VAL{C0}" Name="Ingresado" 
            XValueMember="nombre" YValueMembers="saldo" Legend="Legend1">
            <EmptyPointStyle LegendText="No hay datos" />
        </asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1">
            <AxisY Title="Ingreso" TitleForeColor="Blue">
                <MajorGrid Enabled="False" />
                <LabelStyle Format="{0:c0}" />
            </AxisY>
            <AxisX Title="Clientes" Interval="1" TitleForeColor="Blue">
                <MajorGrid Enabled="False" />
                <LabelStyle Angle="90" />
            </AxisX>
        </asp:ChartArea>
    </ChartAreas>
    <legends>
        <asp:Legend Name="Legend1">
        </asp:Legend>
    </legends>
    <Titles>
        <asp:Title Name="Title1" Text="Ingresos Por Cliente (Dolares)" Font="Arial, 10pt" 
            ForeColor="Blue">
        </asp:Title>
    </Titles>
</asp:Chart>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
select convert(nvarchar,cast(sum(tabla.total) as money),1) as 'saldo',tabla.razon_social as nombre from (
SELECT   
distinct facturas.id_factura, 
facturas.total, 
datos_facturacion.razon_social, 
facturas.folio
FROM        
facturas 
--INNER JOIN
--facturacion 
--ON 
--facturas.id_factura = facturacion.id_factura 
--INNER JOIN
--viajes 
--ON 
--facturacion.id_viaje = viajes.id_viaje 
--INNER JOIN
--precios 
--ON 
--viajes.id_relacion = precios.id_relacion 
--INNER JOIN
--dbo.empresas 
--ON precios.id_empresa = dbo.empresas.id_empresa 
INNER JOIN
fechas_facturacion 
ON facturas.id_factura = fechas_facturacion.id_factura 
INNER JOIN
fechas 
ON 
fechas_facturacion.id_fecha = fechas.id_fecha 
INNER JOIN
datos_facturacion
ON 
facturas.id_dato_facturacion=datos_facturacion.id_dato
WHERE 
--viajes.id_status&lt;&gt;5 
--and 
month(fechas.fecha)=@mes
and
year(fechas.fecha)=@ano
and
facturas.folio is not NULL 
and 
(facturas.facturada_dolares = 1) 
AND 
(facturas.Cancelada = 0) 
and 
fechas.tipo_fecha=7
 
) as tabla 
join 
facturas 
as 
f_out 
on 
tabla.id_factura=f_out.id_factura
where tabla.total 
is not NULL
group by tabla.razon_social
order by saldo">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlMes" Name="mes" 
            PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="txbAno" Name="ano" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>

