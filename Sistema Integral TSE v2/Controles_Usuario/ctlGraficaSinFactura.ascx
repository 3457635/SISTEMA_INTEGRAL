<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlGraficaSinFactura.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlGraficaSinFactura" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>

<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>
<asp:SqlDataSource ID="sdsViajes" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="ViajesSinFacturar" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter DefaultValue="13" Name="nTipo_Cambio" Type="Int32" />
        <asp:Parameter DefaultValue="Resúmen" Name="cCual" Type="String" />
        <asp:Parameter DefaultValue="8 a 14" Name="cTipo" Type="String" />
        <asp:Parameter DefaultValue="Sin_Facturar" Name="cEstado" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
        <asp:Chart ID="Chart2" runat="server" DataSourceID="sdsViajes" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None">
            <series>
                <asp:Series ChartArea="ChartArea1" Name="Monto" XValueMember="Días"
                    YValueMembers="Monto" IsValueShownAsLabel="True" 
                    Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" Legend="Legend1" 
                    LabelAngle="90">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True" Legend="Legend1" 
                    Name="Viajes" XValueMember="Días" YAxisType="Secondary" YValueMembers="Viajes">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1"
         BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0" 
                    BorderColor="Silver">
                    <AxisY LineColor="White" LineWidth="0">
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                        <LabelStyle Enabled="False" />
                    </AxisY>
                    <AxisX Interval="1">
                        <MajorGrid Enabled="False" />
                    </AxisX>
                    <AxisY2 LineColor="White" LineWidth="0">
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                        <LabelStyle Enabled="False" />
                    </AxisY2>
                    <Position Height="94" Width="90" X="10" Y="3" />
                </asp:ChartArea>
            </chartareas>
            <Legends>
                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                    <Position Height="22.2222214" Width="16.5517235" Y="3" />
                </asp:Legend>
            </Legends>
        </asp:Chart>


            

