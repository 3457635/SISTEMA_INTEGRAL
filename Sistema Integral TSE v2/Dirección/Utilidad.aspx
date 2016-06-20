<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Utilidad.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Utilidad" %>
<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style5
        {
            width: 100%;
        }
        .style6
        {
            width: 726px;
        }
        .style7
        {
            width: 4px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
    </p>
    <table class="style5">
        <tr>
            <td class="style6">
                Año
                <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
            </td>
            <td>
                &nbsp;</td>
            <td class="style7">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style6">
        <asp:Chart ID="Chart5" runat="server" DataSourceID="sdsUtilidad" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
            <series>
                <asp:Series ChartArea="ChartArea1" Name="Por Vencer" XValueMember="Año"
                    YValueMembers="utilidad" IsValueShownAsLabel="True" LabelFormat="{0:c0}">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1"
         BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0" 
                    BorderColor="Silver">
                    <AxisY LineWidth="0">
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                        <LabelStyle Enabled="False" />
                    </AxisY>
                    <AxisX Interval="1" IsLabelAutoFit="False">
                        <MajorGrid Enabled="False" />
                        <LabelStyle Angle="90" />
                    </AxisX>
                </asp:ChartArea>
            </chartareas>
            <Titles>
                <asp:Title BackColor="Transparent" DockedToChartArea="ChartArea1" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" IsDockedInsideChartArea="False" 
                    Name="Utilidad" Text="UTILIDAD">
                </asp:Title>
            </Titles>
        </asp:Chart>


                <asp:SqlDataSource ID="sdsUtilidad" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="Utilidad" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txbAno" Name="nAño" PropertyName="Text" 
                            Type="Int32" />
                        <asp:Parameter DefaultValue="43000000" Name="nMeta_Ingresos" Type="Int32" />
                        <asp:Parameter DefaultValue="34000000" Name="nMeta_Egresos" Type="Int32" />
                        <asp:Parameter DefaultValue="45000000" Name="nMeta_Ventas" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
        <asp:Chart ID="Chart6" runat="server" DataSourceID="sdsUtilidad" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
            <series>
                <asp:Series ChartArea="ChartArea1" Name="Por Vencer" XValueMember="Año"
                    YValueMembers="ingresos" IsValueShownAsLabel="True" LabelFormat="{0:c0}">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1"
         BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0" 
                    BorderColor="Silver">
                    <AxisY LineWidth="0">
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                        <LabelStyle Enabled="False" />
                    </AxisY>
                    <AxisX Interval="1" IsLabelAutoFit="False">
                        <MajorGrid Enabled="False" />
                        <LabelStyle Angle="90" />
                    </AxisX>
                </asp:ChartArea>
            </chartareas>
            <Titles>
                <asp:Title Font="Microsoft Sans Serif, 8pt, style=Bold" Name="Title1" 
                    Text="INGRESOS">
                </asp:Title>
            </Titles>
        </asp:Chart>


                </td>
            <td class="style7">
        <asp:Chart ID="Chart7" runat="server" DataSourceID="sdsUtilidad" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
            <series>
                <asp:Series ChartArea="ChartArea1" Name="Por Vencer" XValueMember="Año"
                    YValueMembers="Egresos" IsValueShownAsLabel="True" LabelFormat="{0:c0}">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1"
         BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0" 
                    BorderColor="Silver">
                    <AxisY LineWidth="0">
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                        <LabelStyle Enabled="False" />
                    </AxisY>
                    <AxisX Interval="1" IsLabelAutoFit="False">
                        <MajorGrid Enabled="False" />
                        <LabelStyle Angle="90" />
                    </AxisX>
                </asp:ChartArea>
            </chartareas>
            <Titles>
                <asp:Title Font="Microsoft Sans Serif, 8pt, style=Bold" Name="Title1" 
                    Text="EGRESOS">
                </asp:Title>
            </Titles>
        </asp:Chart>


                </td>
            <td>
        <asp:Chart ID="Chart8" runat="server" DataSourceID="sdsUtilidad" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
            <series>
                <asp:Series ChartArea="ChartArea1" Name="ventas" XValueMember="Año"
                    YValueMembers="ventas" IsValueShownAsLabel="True" LabelFormat="{0:c0}">
                </asp:Series>
            </series>
            <chartareas>
                <asp:ChartArea Name="ChartArea1"
         BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0" 
                    BorderColor="Silver">
                    <AxisY LineWidth="0">
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                        <LabelStyle Enabled="False" />
                    </AxisY>
                    <AxisX Interval="1" IsLabelAutoFit="False">
                        <MajorGrid Enabled="False" />
                        <LabelStyle Angle="90" />
                    </AxisX>
                </asp:ChartArea>
            </chartareas>
            <Titles>
                <asp:Title Font="Microsoft Sans Serif, 8pt, style=Bold" Name="Title1" 
                    Text="VENTAS">
                </asp:Title>
            </Titles>
        </asp:Chart>


                </td>
        </tr>
    </table>
</asp:Content>
