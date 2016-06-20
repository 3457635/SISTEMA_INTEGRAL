<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="WebForm3.aspx.vb" Inherits="Sistema_Integral_TSE_v45.WebForm3" %>

<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    
    <asp:Chart ID="Chart7" runat="server" DataSourceID="sdsTiempos" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
                            <series>
                                <asp:Series ChartArea="ChartArea1" Name="Arribos" 
                    IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" XValueMember="Rango" YValueMembers="Arribos" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" Color="192, 192, 0">
                                </asp:Series>
                            </series>
                            <chartareas>
                                <asp:ChartArea Name="ChartArea1"
         BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0" 
                    BorderColor="Silver">
                                    <AxisY IsLabelAutoFit="False" LineWidth="0">
                                        <MajorGrid Enabled="False" />
                                        <MajorTickMark Enabled="False" />
                                        <LabelStyle Enabled="False" Font="Microsoft Sans Serif, 8pt, style=Bold" />
                                    </AxisY>
                                    <AxisX Interval="1" IsLabelAutoFit="False">
                                        <MajorGrid Enabled="False" />
                                        <MajorTickMark Enabled="False" />
                                        <LabelStyle Angle="90" />
                                    </AxisX>
                                </asp:ChartArea>
                            </chartareas>
                            <Legends>
                                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" 
                    Name="Legend1" BackColor="Transparent" DockedToChartArea="ChartArea1" Docking="Left">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                   


<asp:SqlDataSource ID="sdsTiempos" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="Llegadas" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="nAño" SessionField="ano" Type="Int32" />
        <asp:SessionParameter Name="nMes" SessionField="mes" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

    </form>
</body>
</html>
