<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="vaciosAlMes.aspx.vb" Inherits="Sistema_Integral_TSE_v45.vaciosAlMes" %>

<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Chart ID="Chart7" runat="server" DataSourceID="sdsVacios" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
                            <series>
                                <asp:Series ChartArea="ChartArea1" Name="Vacios" 
                    IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" XValueMember="mes2" YValueMembers="Vacios" 
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
                            <titles>
                                <asp:Title Font="Microsoft Sans Serif, 12pt, style=Bold" Name="Title1" Text="Viajes Vacios Por Mes">
                                </asp:Title>
                            </titles>
                        </asp:Chart>
                   


<asp:SqlDataSource ID="sdsVacios" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="Viajes_Vacios" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter DefaultValue="2014" Name="nAño" Type="Int32" />
        <asp:Parameter DefaultValue="10" Name="nMes" Type="Int32" />
        <asp:Parameter Name="nId_Equipo" Type="Int32" />
        <asp:Parameter DefaultValue="Resumen" Name="cTipo" Type="String" />
        <asp:Parameter DefaultValue="False" Name="lTodos" Type="Boolean" />
    </SelectParameters>
</asp:SqlDataSource>

    </div>
    </form>
</body>
</html>
