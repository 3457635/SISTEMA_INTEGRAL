<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ViajesMensuales.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ViajesMensuales" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>

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
    <h3>Viajes Mensuales</h3>
    <p>
        Año:
        <asp:TextBox ID="txbAno" runat="server">2015</asp:TextBox>
        &nbsp;Cliente:
        <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsClientes" DataTextField="nombre" DataValueField="id_empresa" Height="22px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsClientes" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE (([id_tipo_empresa] = @id_tipo_empresa) AND ([id_status] = @id_status)) ORDER BY [nombre]">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="id_tipo_empresa" Type="Int32" />
                <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
    </p>
    <table>
        <tr>
            <td>
                <asp:Chart ID="Chart6" runat="server" DataSourceID="sdsMesActual"
                    Height="424px" Width="687px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Total del año anterior al indicado (Ene 1 a Dic 31)" XValueMember="mes"
                            YValueMembers="añoAnt" IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                            Legend="Legend1" Font="Microsoft Sans Serif, 8pt, style=Bold" Color="Highlight">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Total año indicado (Ene 1 a Hoy)" XValueMember="mes"
                            YValueMembers="AñoAct" IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                            Legend="Legend1" Font="Microsoft Sans Serif, 8pt, style=Bold" Color="192, 192, 0">
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
                    <Titles>
                        <asp:Title Font="Arial, 12pt, style=Bold" Name="Title1" Text="Total de viajes por mes">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
                <asp:SqlDataSource ID="sdsMesActual" runat="server"
                    CancelSelectOnNullParameter="False"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txbAno" DefaultValue="" Name="nAño" PropertyName="Text" Type="Int32" />
                        <asp:Parameter DefaultValue="Mensual" Name="cTipo" Type="String" />
                        <asp:Parameter DefaultValue="0" Name="nMes_SD" Type="Int32" />
                        <asp:SessionParameter DefaultValue="0" Name="nCliente" SessionField="cliente" Type="Int32" />
                        <asp:Parameter DefaultValue="False" Name="nFrecuente" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:Chart ID="chrMesIngresos" runat="server" DataSourceID="sdsMesIngresos"
                    Height="424px" Width="776px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No" Visible="False">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Total año Anterior (Ene 1 - Dic 31)" XValueMember="mes"
                            YValueMembers="PrecioAnt" IsValueShownAsLabel="True" LabelFormat="$0,,.0M"
                            Legend="Legend1" Font="Microsoft Sans Serif, 7pt, style=Bold" Color="Highlight">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Total año actual (Ene 1 a Hoy)" XValueMember="mes"
                            YValueMembers="PrecioAct" IsValueShownAsLabel="True" LabelFormat="$0,,.0M"
                            Legend="Legend1" Font="Microsoft Sans Serif, 7pt, style=Bold" Color="192, 192, 0">
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
                    <Titles>
                        <asp:Title Font="Arial, 12pt, style=Bold" Name="Title1" Text="VALORES DE VIAJES POR MES">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
                <asp:SqlDataSource ID="sdsMesIngresos" runat="server"
                    CancelSelectOnNullParameter="False"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="nAño" SessionField="ano" Type="Int32" />
                        <asp:Parameter DefaultValue="Mensual" Name="cTipo" Type="String" />
                        <asp:Parameter DefaultValue="0" Name="nMes_SD" Type="Int32" />
                        <asp:SessionParameter DefaultValue="0" Name="nCliente" SessionField="cliente" Type="Int32" />
                        <asp:Parameter DefaultValue="false" Name="nFrecuente" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
