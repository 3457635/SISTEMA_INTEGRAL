<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Arribos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Arrivos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <script src="../Scripts/jquery-1.9.1.js"></script>
    <script>
    </script>
    </asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Arribos</h3>
    <p>
        Año:
        <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
        &nbsp;Mes
        <asp:DropDownList ID="ddlMes" runat="server" Height="22px"
            Width="120px">
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
        <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
    </p>

    <table>
        <tr>
            <td>
                <asp:Chart ID="Chart7" runat="server" DataSourceID="sdsTiempos"
                    Height="424px" Width="600px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Arribos"
                            IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                            Legend="Legend1" XValueMember="Rango" YValueMembers="Arribos"
                            Font="Microsoft Sans Serif, 8pt, style=Bold" Color="192, 192, 0">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
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
                    </ChartAreas>
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
            </td>
            <td>
                <asp:Chart ID="Chart8" runat="server" DataSourceID="sdsLlegadasPorCliente"
                    Height="424px" Width="600px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Arribos"
                            IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                            Legend="Legend1" XValueMember="nombre" YValueMembers="llegadasADestiempo"
                            Font="Microsoft Sans Serif, 8pt, style=Bold" ChartType="Area" Color="192, 192, 0">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"
                            BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                            BorderColor="Silver">
                            <AxisY IsLabelAutoFit="False" LineWidth="0">
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                                <LabelStyle Font="Microsoft Sans Serif, 8pt, style=Bold" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                                <LabelStyle Angle="90" TruncatedLabels="True" />
                            </AxisX>
                            <Area3DStyle Enable3D="True" />
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold"
                            Name="Legend1" BackColor="Transparent" DockedToChartArea="ChartArea1" Docking="Left">
                        </asp:Legend>
                    </Legends>
                </asp:Chart>

                <asp:SqlDataSource ID="sdsLlegadasPorCliente" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="select
                                 nombre,
                                count(consecutivo) llegadasADestiempo
                                 From	
                                Llegadas_Viajes(@ano,@mes,@tipo)
                                where diferencia&gt;=120
	                                group by nombre
	                                order by llegadasADestiempo">
                    <SelectParameters>
                        <asp:SessionParameter Name="ano" SessionField="ano" />
                        <asp:SessionParameter Name="mes" SessionField="mes" />
                        <asp:Parameter DefaultValue="Con Arribo" Name="tipo" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
