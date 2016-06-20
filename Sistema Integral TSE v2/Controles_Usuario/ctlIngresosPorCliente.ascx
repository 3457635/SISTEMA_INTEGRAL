<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlIngresosPorCliente.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlIngresosPorCliente" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>
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
    Total del Mes en Pesos:
    <asp:Label ID="lblTotal" runat="server">$ 0</asp:Label>
&nbsp;Total del Año en Pesos:<asp:Label ID="lblAno" runat="server"></asp:Label>
</p>
<asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource1" 
    Width="1208px" Height="1167px" RightToLeft="No">
    <Series>
        <asp:Series ChartArea="ChartArea1" ChartType="Bar" Color="Yellow" 
            Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" 
            Label="#VAL{C0}" Legend="Legend1" Name="Saldo" XValueMember="razon_social" 
            YValueMembers="saldo">
        </asp:Series>
        <asp:Series IsValueShownAsLabel="True" Label="#VAL{C0}" Name="Prometido" 
            XValueMember="razon_social" YValueMembers="Promesa" Legend="Legend1" 
            ChartType="Bar" Color="DarkOliveGreen" 
            Font="Microsoft Sans Serif, 8pt, style=Bold">
            <EmptyPointStyle LegendText="No hay datos" />
            <SmartLabelStyle MaxMovingDistance="60" />
        </asp:Series>
        <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True" Label="#VAL{C0}" 
            Legend="Legend1" Name="Ingresado" XValueMember="razon_social" 
            YValueMembers="ingreso" ChartType="Bar" Color="0, 192, 0" 
            Font="Microsoft Sans Serif, 8pt, style=Bold">
        </asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1">
            <AxisY Title="Ingreso" TitleForeColor="Blue">
                <MajorGrid Enabled="False" />
                <LabelStyle Format="{0:c0}" TruncatedLabels="True" />
            </AxisY>
            <AxisX Title="Clientes" Interval="1" TitleForeColor="Blue">
                <MajorGrid Enabled="False" />
                <LabelStyle Angle="90" TruncatedLabels="True" />
            </AxisX>
        </asp:ChartArea>
    </ChartAreas>
    <Legends>
        <asp:Legend Name="Legend1" BackImageAlignment="Bottom">
        </asp:Legend>
    </Legends>
    <Titles>
        <asp:Title Name="Title1" Text="Ingresos Por Cliente (Pesos)" Font="Arial, 10pt" 
            ForeColor="Blue">
        </asp:Title>
    </Titles>
</asp:Chart>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="Select df.razon_social
       ,      sum(case when fe.tipo_fecha = 6 then  f.total else 0 end) as Promesa
       ,      sum(case when fe.tipo_fecha = 7 then  f.total else 0 end) as ingreso
       ,	
       isnull( (
			SELECT     
			SUM(facturas.total) AS Expr1
			FROM         
			facturas 
			INNER JOIN
			datos_facturacion df2
			ON 
			facturas.id_dato_facturacion = df2.id_dato 
			WHERE 
			df.razon_social=df2.razon_social 
			and
			facturas.cancelada=0
			and
			facturas.id_factura 
			not in
				(
				SELECT     
				ff2.id_factura
				FROM         
				fechas_facturacion ff2 
				INNER JOIN
				fechas fe2 
				ON 
				ff2.id_fecha = fe2.id_fecha
				where 
				fe2.tipo_fecha=7
				) 
       ),0)as saldo 
From   
facturas f
Join   
Fechas_Facturacion ff 
on 
ff.id_factura = f.id_factura
Join   
Fechas fe 
on 
fe.id_fecha = ff.id_fecha
Join   
Datos_Facturacion df 
on 
df.id_dato = f.id_dato_facturacion
Where 
datepart(month,fe.fecha)=@mes 
and 
datepart(year,fe.fecha)=@year 
and 
fe.tipo_fecha 
in 
(6,7)
Group  by 
df.razon_social 
order  by 
promesa

">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlMes" Name="mes" 
            PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="txbAno" Name="year" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>

<p>
    &nbsp;</p>
<p>
    &nbsp;</p>


