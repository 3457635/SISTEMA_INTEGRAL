<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ViajesAnuales.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ViajesAnuales" %>

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
    <h3>Viajes Anuales</h3>
    <p>
        Año:
        <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
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
                <asp:Chart ID="Chart5" runat="server" DataSourceID="sdsViajesPorAno"
                    Height="424px" Width="721px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No" Enabled="False">
                    <Titles>
                        <asp:Title Name="Viajes Por Año" Text="VIAJES POR AÑO A LA FECHA" TextOrientation="Horizontal" Font="Arial, 12pt, style=Bold">
                        </asp:Title>
                    </Titles>
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Total Año Anterior al indicado (Ene 1 a Dic 31)" XValueMember="tipo" YValueMembers="TAñoAnt" Font="Microsoft Sans Serif, 12pt, style=Bold" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Color="Olive">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Total Año Anterior al indicado al día de hoy" XValueMember="tipo"
                            YValueMembers="añoAnt" IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                            Legend="Legend1" Font="Microsoft Sans Serif, 12pt, style=Bold" Color="128, 64, 0">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Total Año indicado al día de hoy" XValueMember="tipo"
                            YValueMembers="añoAct" IsValueShownAsLabel="True" LabelFormat="{0:n0}"
                            Legend="Legend1" Font="Microsoft Sans Serif, 12pt, style=Bold" Color="192, 192, 0">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Proyección para final de año indicado" XValueMember="tipo" YValueMembers="Proyección" Font="Microsoft Sans Serif, 12pt, style=Bold" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Color="Green">
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
                                <LabelStyle Angle="90" />
                            </AxisX>
                            <AxisX2>
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                            </AxisX2>
                            <AxisY2>
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                            </AxisY2>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1">
                        </asp:Legend>
                    </Legends>
                </asp:Chart>
                <asp:SqlDataSource ID="sdsViajesPorAno" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="nAño" SessionField="ano" Type="Int32" />
                        <asp:Parameter DefaultValue="Anual" Name="cTipo" Type="String" />
                        <asp:SessionParameter DefaultValue="0" Name="nCliente" SessionField="cliente" Type="Int32" />
                        <asp:Parameter DefaultValue="False" Name="nFrecuente" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:Chart ID="chrIngresos" runat="server" DataSourceID="sdsIngresosPorAno"
                    Height="424px" Width="744px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No" Enabled="False" Visible="False">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Font="Microsoft Sans Serif, 9pt, style=Bold" 
                            IsValueShownAsLabel="True" LabelFormat="$0,,.0M" Legend="Legend1" 
                            Name="Ingresos Totales Año Anterior Ene 1 - Dic 31" XValueMember="tipo" YValueMembers="TPrecioAnt" Color="Olive">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Año Anterior Ene 1 - Hoy" XValueMember="tipo"
                            YValueMembers="PrecioAnt" IsValueShownAsLabel="True" LabelFormat="$0,,.0M"
                            Legend="Legend1" Font="Microsoft Sans Serif, 9pt, style=Bold" Color="128, 64, 0">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Año Actual al día de Hoy" XValueMember="tipo"
                            YValueMembers="PrecioAct" IsValueShownAsLabel="True" LabelFormat="$0,,.0M"
                            Legend="Legend1" Font="Microsoft Sans Serif, 9pt, style=Bold" Color="192, 192, 0">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Proyección para el final de año seleccionado" XValueMember="tipo" 
                            YValueMembers="Proyección1" Font="Microsoft Sans Serif, 9pt, style=Bold" 
                            IsValueShownAsLabel="True" LabelFormat="$0,,.0M" Color="Green">
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
                                <LabelStyle Angle="90" />
                            </AxisX>
                            <AxisX2>
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                            </AxisX2>
                            <AxisY2>
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                            </AxisY2>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Arial, 12pt, style=Bold" Name="Title1" Text="INGRESOS POR AÑO A LA FECHA">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
                <asp:SqlDataSource ID="sdsIngresosPorAno" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="" Name="nAño" SessionField="ano" Type="Int32" />
                        <asp:Parameter DefaultValue="Anual" Name="cTipo" Type="String" />
                        <asp:SessionParameter DefaultValue="0" Name="nCliente" SessionField="cliente" Type="Int32" />
                        <asp:Parameter DefaultValue="False" Name="nFrecuente" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>

    </table>
</asp:Content>
