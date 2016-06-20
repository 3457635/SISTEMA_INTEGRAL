<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlGraficaLocaleros.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlGraficaLocaleros" %>
<%--<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
Fecha inicial
<asp:TextBox ID="txbFechainicio" runat="server"></asp:TextBox>
<asp:CalendarExtender ID="clrSemana" runat="server" Enabled="True" Format="yyyy/MM/dd" TargetControlID="txbFechainicio">
</asp:CalendarExtender>
<asp:Label ID="Label1" runat="server" Text="Fecha final"></asp:Label>
<asp:TextBox ID="txbFechaFinal" runat="server"></asp:TextBox>
<asp:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" Format="yyyy/MM/dd" TargetControlID="txbFechaFinal">
</asp:CalendarExtender>
<asp:Button ID="btnConsultar" runat="server" SkinID="btn" Text="Consultar" />
<br />
<asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource2"
    Height="391px" Width="1275px" BorderlineColor="Black"
    BorderlineWidth="0" Palette="None">
    <Series>
        <asp:Series ChartArea="ChartArea1" Name="Kilometros" XValueMember="economico"
            CustomProperties="DrawingStyle=Cylinder, MaxPixelPointWidth=50" ShadowOffset="2"
            YValueMembers="kms_sem" IsValueShownAsLabel="True"
            Font="Arial, 10pt, style=Bold" LabelFormat="{0:n0}" Legend="Legend1" LabelAngle="90" YAxisType="Secondary">
        </asp:Series>
        
        <%--Se comentaron los litros por si se vuelven a pedir que aparezcan
            <asp:Series ChartArea="ChartArea1" Name="Litros" XValueMember="economico"
            CustomProperties="DrawingStyle=Cylinder, MaxPixelPointWidth=50" ShadowOffset="2"
            YValueMembers="Lts_sem" IsValueShownAsLabel="True"
            Font="Arial, 10pt, style=Bold" LabelFormat="{0:n0}" LabelAngle="90"
            Legend="Legend1" YAxisType="Secondary">
        </asp:Series>--%>
        <asp:Series ChartArea="ChartArea1" Font="Arial, 10pt, style=Bold" CustomProperties="DrawingStyle=Cylinder, MaxPixelPointWidth=50" ShadowOffset="2" 
            IsValueShownAsLabel="True" LabelFormat="{0:n2}" Legend="Legend1" Name="Semanal" 
            XValueMember="economico" YValueMembers="Ren_sem">
        </asp:Series>
        <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True" LabelFormat="{0:n2}" CustomProperties="DrawingStyle=Cylinder, MaxPixelPointWidth=50" ShadowOffset="2" 
            Legend="Legend1" Name="Mes Anterior" XValueMember="economico" YValueMembers="Ren_mes">
        </asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea Name="ChartArea1"
            BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
            BorderColor="Silver">
            <AxisY LineWidth="0">
                <MajorGrid Enabled="False" />
                <MajorTickMark Enabled="False" />
                <LabelStyle Enabled="False" />
            </AxisY>
            <AxisX Title="UNIDAD" Interval="1" TitleFont="Arial, 8pt, style=Bold">
                <MajorGrid Enabled="False" />
            </AxisX>
            <AxisY2 IsLabelAutoFit="False" LineWidth="0">
                <MajorGrid Enabled="False" />
                <MajorTickMark Enabled="False" />
                <LabelStyle Enabled="False" />
            </AxisY2>
        </asp:ChartArea>
    </ChartAreas>
    <Legends>
        <asp:Legend Font="Arial, 8pt, style=Bold" IsTextAutoFit="False"
            Name="Legend1" AutoFitMinFontSize="5" BorderWidth="0" LegendStyle="Column" TableStyle="Tall">
            <Position Height="20" Width="10" />
        </asp:Legend>
    </Legends>
</asp:Chart>
<asp:SqlDataSource ID="SqlDataSource2" runat="server"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="Rendimiento_Localeros"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbFechainicio" Name="dFecha" PropertyName="Text" Type="DateTime" DefaultValue="" />
        <asp:ControlParameter ControlID="txbFechaFinal" Name="dFechaFinal" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>

