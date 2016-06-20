<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlTiemposLlegada.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlTiemposLlegada" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>

<p>
    &nbsp;</p>
<telerik:RadChart ID="RadChart1" runat="server" DataSourceID="sdsLlegadas" 
    SeriesOrientation="Horizontal">
    <Series>
<telerik:ChartSeries Name="Databound Col1" DataYColumn="Databound Col1"></telerik:ChartSeries>
</Series>
    <PlotArea>
        <XAxis>
            <AxisLabel>
                <Appearance RotationAngle="270">
                </Appearance>
            </AxisLabel>
        </XAxis>
        <YAxis>
            <AxisLabel>
                <Appearance RotationAngle="0">
                </Appearance>
            </AxisLabel>
        </YAxis>
        <YAxis2>
            <AxisLabel>
                <Appearance RotationAngle="0">
                </Appearance>
            </AxisLabel>
        </YAxis2>
    </PlotArea>
</telerik:RadChart>
<asp:SqlDataSource ID="sdsLlegadas" runat="server"></asp:SqlDataSource>

