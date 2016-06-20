<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ViajesComparativo.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ViajesComparativo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <script src="../Scripts/jquery-1.9.1.js"></script>
    <script>
    </script>
    <style type="text/css">
        .auto-style2 {
            width: auto;
        }

        .auto-style3 {
            height: 22px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3>Comparativo Anual</h3>
    <p>
        Año:
        <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
        <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
    </p>
    <table>
        <tr>
            <td>
                <asp:Chart ID="Chart11" runat="server" DataSourceID="sdsViajesPorCliente"
                    Height="424px" Width="909px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No">
                    <Titles>
                        <asp:Title Font="Arial, 12pt, style=Bold" Name="Title1" Text="Total de viajes por cliente ">
                        </asp:Title>
                    </Titles>
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Total de viajes año anterior (Ene 1 a Dic 31)"
                            IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                            Legend="Legend1" XValueMember="Cliente" YValueMembers="AñoAnt"
                            Font="Microsoft Sans Serif, 8pt, style=Bold" Color="128, 64, 0">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Total de viajes año actual (Ene 1 a Hoy)" XValueMember="cliente" YValueMembers="añoAct" Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" Color="192, 192, 0">
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
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1">
                        </asp:Legend>
                    </Legends>
                </asp:Chart>

                <asp:SqlDataSource ID="sdsViajesPorCliente" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="nAño" SessionField="ano" Type="Int32" />
                        <asp:Parameter DefaultValue="Cliente" Name="cTipo" Type="String" />
                        <asp:Parameter DefaultValue="0" Name="nMes_SD" Type="Int32" />
                        <asp:Parameter DefaultValue="0" Name="nCliente" Type="Int32" />
                        <asp:Parameter DefaultValue="true" Name="nFrecuente" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:Chart ID="ChartIngresosPorCliente" runat="server" DataSourceID="sdsIngesosPorCliente"
                    Height="424px" Width="851px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No">
                    <Titles>
                        <asp:Title Font="Arial, 12pt, style=Bold" Name="Title1" Text="INGRESOS">
                        </asp:Title>
                    </Titles>
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Viajes año anterior"
                            IsValueShownAsLabel="True" LabelFormat="$0,,.0M"
                            Legend="Legend1" XValueMember="cliente" YValueMembers="PrecioAnt"
                            Font="Microsoft Sans Serif, 8pt, style=Bold" Color="128, 64, 0">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Viajes año actual" XValueMember="cliente" YValueMembers="PrecioAct" Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" Color="192, 192, 0" LabelFormat="$0,,.0M">
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
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1">
                        </asp:Legend>
                    </Legends>
                </asp:Chart>

                <asp:SqlDataSource ID="sdsIngesosPorCliente" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="nAño" SessionField="ano" Type="Int32" />
                        <asp:Parameter DefaultValue="Cliente" Name="cTipo" Type="String" />
                        <asp:Parameter DefaultValue="0" Name="nMes_SD" Type="Int32" />
                        <asp:Parameter DefaultValue="0" Name="nCliente" Type="Int32" />
                        <asp:Parameter DefaultValue="True" Name="nFrecuente" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
