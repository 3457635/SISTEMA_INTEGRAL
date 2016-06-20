<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlViajesHechos.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlViajesHechos" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>
<p>
    Inicio:&nbsp;<asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txbInicio">
    </asp:CalendarExtender>
&nbsp;Fin:<asp:TextBox ID="txbFin" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txbFin">
    </asp:CalendarExtender>
&nbsp;<asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
</p>
<p>
    Total:
    <asp:Label ID="lblTotal" runat="server"></asp:Label>
&nbsp;</p>
<asp:Chart ID="Chart1" runat="server" DataSourceID="sdsViajesPorCliente" 
    Width="917px" SkinID="chrtCantidad" RightToLeft="No">
    <Series>
        <asp:Series Name="Series1" IsValueShownAsLabel="True" Label="#VAL{N0}">
        </asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1">
            <AxisY LineColor="Transparent" LineWidth="0" Title="Viajes" 
                TitleForeColor="Blue" LineDashStyle="Dash">
                <MajorGrid Enabled="False" />
                <MajorTickMark Enabled="False" />
<MajorGrid Enabled="False"></MajorGrid>
<MajorTickMark Enabled="False"></MajorTickMark>

                <LabelStyle ForeColor="Transparent" />
            </AxisY>
            <AxisX Interval="1" LineColor="DarkRed" Title="Clientes" 
                TitleForeColor="Blue" LabelAutoFitMinFontSize="8">
                <MajorGrid Enabled="False" />
<MajorGrid Enabled="False"></MajorGrid>

                <LabelStyle TruncatedLabels="True" />
            </AxisX>
        </asp:ChartArea>
    </ChartAreas>
    <Titles>
        <asp:Title Font="Microsoft Sans Serif, 10pt" ForeColor="Blue" Name="Title1" 
            Text="Viajes Realizados">
        </asp:Title>
    </Titles>
</asp:Chart>
<asp:SqlDataSource ID="sdsViajesPorCliente" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    
    
    SelectCommand="SELECT 
	COUNT(viajes.id_viaje) AS viajes, 
	dbo.empresas.nombre 
FROM 
	viajes 
INNER JOIN 
	precios 
	ON viajes.id_relacion = precios.id_relacion 
INNER JOIN 
	dbo.empresas 
	ON precios.id_empresa = dbo.empresas.id_empresa 
INNER JOIN 
	fechas_viaje 
	ON viajes.id_viaje = fechas_viaje.id_viaje 
INNER JOIN 
	fechas 
	ON fechas_viaje.id_fecha = fechas.id_fecha
WHERE 	
	(viajes.id_status &lt;&gt; 5) AND 
	(viajes.id_status &lt;&gt;3)  aNd 
	(fechas.tipo_fecha = 1) and
fechas.fecha between @inicio and @fin 
GROUP BY 
	dbo.empresas.nombre 
ORDER BY 
	viajes" CancelSelectOnNullParameter="False">
    <SelectParameters>
        <asp:Parameter Name="inicio" />
        <asp:Parameter Name="fin" />
    </SelectParameters>
</asp:SqlDataSource>

<p>
    &nbsp;</p>
<p>
    &nbsp;</p>


