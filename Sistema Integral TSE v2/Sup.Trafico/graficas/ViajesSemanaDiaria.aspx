<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ViajesSemanaDiaria.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ViajesSemanaDiaria" %>

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
    <h3>Viajes Semanales y Diarios</h3>
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
                <asp:Chart ID="Chart7" runat="server" DataSourceID="sdsPorSemana"
                    Height="424px" Width="600px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Viajes"
                            IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                            Legend="Legend1" XValueMember="Semana" YValueMembers="viajes"
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
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Arial, 12pt, style=Bold" Name="Title1" Text="VIAJES POR SEMANA">
                        </asp:Title>
                    </Titles>
                </asp:Chart>

                <asp:SqlDataSource ID="sdsPorSemana" runat="server"
                    CancelSelectOnNullParameter="False"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="nAño" SessionField="ano" Type="Int32" />
                        <asp:Parameter DefaultValue="Semanal" Name="cTipo" Type="String" />
                        <asp:SessionParameter DefaultValue="0" Name="nMes_SD" SessionField="mes" Type="Int32" />
                        <asp:SessionParameter DefaultValue="0" Name="nCliente" SessionField="cliente" Type="Int32" />
                        <asp:Parameter DefaultValue="false" Name="nFrecuente" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:Chart ID="Chart8" runat="server" DataSourceID="sdsDiario"
                    Height="424px" Width="600px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Viajes"
                            IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                            Legend="Legend1"
                            Font="Microsoft Sans Serif, 8pt, style=Bold" XValueMember="Día" YValueMembers="AñoAct" Color="192, 192, 0">
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
                    <Titles>
                        <asp:Title Font="Arial, 12pt, style=Bold" Name="Title1" Text="VIAJES POR DIA">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
                <asp:SqlDataSource ID="sdsDiario" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="nAño" SessionField="ano" Type="Int32" />
                        <asp:Parameter DefaultValue="Diario" Name="cTipo" Type="String" />
                        <asp:SessionParameter DefaultValue="0" Name="nMes_SD" SessionField="mes" Type="Int32" />
                        <asp:SessionParameter DefaultValue="0" Name="nCliente" SessionField="cliente" Type="Int32" />
                        <asp:Parameter DefaultValue="false" Name="nFrecuente" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>

</asp:Content>
