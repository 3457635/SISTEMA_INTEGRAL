<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlGraficaDistribucionEgresos.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlGraficaDistribucionEgresos" %>
<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>
<p>

Año:<asp:TextBox ID="txbAno" runat="server"></asp:TextBox> Mes: 
    <asp:DropDownList ID="ddlMes" runat="server" Width="169px">
        <asp:ListItem Value="1">Enero</asp:ListItem>
        <asp:ListItem Value="2">Febrero</asp:ListItem>
        <asp:ListItem Value="3">Marzo</asp:ListItem>
        <asp:ListItem Value="4">Abril</asp:ListItem>
        <asp:ListItem Value="5">Mayo</asp:ListItem>
        <asp:ListItem Value="6">Junio</asp:ListItem>
        <asp:ListItem Value="7">Julio</asp:ListItem>
        <asp:ListItem Value="8">Agosto</asp:ListItem>
        <asp:ListItem Value="9">Septiembre</asp:ListItem>
        <asp:ListItem Value="10">Octubre</asp:ListItem>
        <asp:ListItem Value="11">Noviembre</asp:ListItem>
        <asp:ListItem Value="12">Diciembre</asp:ListItem>
    </asp:DropDownList>
                <asp:ImageButton ID="ibtnActualizarDetalle" runat="server" 
        SkinID="ibtnActualizar" />
                <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource3" 
                    Height="512px" Width="1970px" RightToLeft="No">
                    <Series>
                        <asp:Series IsValueShownAsLabel="True" Label="#VAL{C0}" 
                            LabelFormat="{0:c}" Name="Series1" XValueMember="proveedor" 
                            YValueMembers="egreso">
                            <SmartLabelStyle AllowOutsidePlotArea="Yes" />
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BackColor="White">
                            <AxisX Interval="1" IsLabelAutoFit="False" LineWidth="0">
                                <LabelStyle Font="Microsoft Sans Serif, 8pt, style=Bold" />
                            </AxisX>
                            <Area3DStyle Enable3D="True" IsRightAngleAxes="False" Inclination="0" 
                                Rotation="0" />
                        </asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
                    SelectCommand="SELECT 
SUM(gastos.cantidad) AS egreso,
 dbo.empresas.nombre  as proveedor
FROM 
gastos 
INNER JOIN proveedores_pago 
ON 
gastos.id_gasto = proveedores_pago.id_gasto
 INNER JOIN 
dbo.empresas 
ON 
proveedores_pago.id_proveedor = dbo.empresas.id_empresa 
WHERE 
(gastos.id_status=5) AND 
datepart(month,proveedores_pago.fecha_programacion_pago)=@mes and
datepart(year,proveedores_pago.fecha_programacion_pago)=@year and
(proveedores_pago.fecha_programacion_pago IS NOT NULL) 
GROUP BY dbo.empresas.nombre
order by egreso
">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlMes" Name="mes" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="txbAno" Name="year" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>


        </p>

