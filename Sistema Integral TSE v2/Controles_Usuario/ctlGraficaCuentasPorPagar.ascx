<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlGraficaCuentasPorPagar.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlGraficaCuentasPorPagar" %>
<%--<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>--%>
<style type="text/css">
    .style1 {
        width: 100%;
    }

    .style3 {
        width: 102px;
    }

    .style4 {
        width: 102px;
        height: 30px;
    }

    .style5 {
        height: 30px;
    }

    .style6 {
        width: 726px;
    }

    .style7 {
        width: 129px;
    }
</style>

<p>
    <table class="style1">
        <tr>
            <td class="style3">Año:&nbsp;
            </td>
            <td>
                <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style4">Tipo de Cambio:
            </td>
            <td class="style5">
                <asp:TextBox ID="txbTC" runat="server"></asp:TextBox>
                &nbsp;
                <asp:ImageButton ID="ibtnActualizar" runat="server" SkinID="ibtnActualizar" />
            </td>
        </tr>
    </table>
</p>


<asp:SqlDataSource ID="sdsCuentasPorPagarAnoAnterior"
    runat="server" CancelSelectOnNullParameter="False"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="cuentasPorPagar" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text"
            Type="Decimal" />
        <asp:Parameter Name="nAño" Type="Int32" />
        <asp:Parameter DefaultValue="Anual" Name="cTipo" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="sdsCuentasPorPagarAnoActual" runat="server"
    CancelSelectOnNullParameter="False"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="cuentasPorPagar" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text"
            Type="Decimal" />
        <asp:ControlParameter ControlID="txbAno" Name="nAño" PropertyName="Text"
            Type="Int32" />
        <asp:Parameter DefaultValue="Anual" Name="cTipo" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="sdsCuentasPorPagarPorVencer" runat="server"
    CancelSelectOnNullParameter="False"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="cuentasPorPagar" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text"
            Type="Decimal" />
        <asp:ControlParameter ControlID="txbAno" Name="nAño" PropertyName="Text"
            Type="Int32" />
        <asp:Parameter DefaultValue="Anual" Name="cTipo" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<table class="style1">
    <tr>
        <td class="style6">
            <strong>Cuentas por pagar del
            <asp:Label ID="lblAnoAnterior" runat="server"></asp:Label>
            </strong>
        </td>
        <td>
            <strong>Cuentas por Pagar del
            <asp:Label ID="lblAnoActual" runat="server"></asp:Label>
            </strong>
        </td>
        <td>
            <strong>Por Vencer&nbsp;
            <asp:Label ID="lblAnoActualVencido" runat="server"></asp:Label>
            </strong>
        </td>
    </tr>
    <tr>
        <td class="style6">
            <asp:Chart ID="Chart2" runat="server" DataSourceID="sdsCuentasPorPagarAnoAnterior"
                Height="424px" Width="550px" BorderlineColor="Black"
                BorderlineWidth="0" Palette="None">
                <Series>
                    <asp:Series ChartArea="ChartArea1" Name="Saldo Anterior" XValueMember="mes"
                        YValueMembers="saldo_anterior" IsValueShownAsLabel="True"
                        Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" Legend="Legend1"
                        LabelAngle="90">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" Name="Compras" XValueMember="mes"
                        YValueMembers="compras" IsValueShownAsLabel="True"
                        Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" LabelAngle="90"
                        Legend="Legend1">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                        LabelFormat="{0:c0}" Legend="Legend1" Name="Pagos" XValueMember="mes"
                        YValueMembers="pagos">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                        LabelFormat="{0:c0}" Legend="Legend1" Name="Saldo Actual" XValueMember="mes"
                        YValueMembers="saldo_actual">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1"
                        BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                        BorderColor="Silver">
                        <AxisY LineColor="White" LineWidth="0" ArrowStyle="Lines"
                            IsLabelAutoFit="False" LineDashStyle="NotSet">
                            <MajorGrid Enabled="False" />
                            <MajorTickMark Enabled="False" />
                            <LabelStyle Angle="-90" Enabled="False" />
                        </AxisY>
                        <AxisX Interval="1" IsLabelAutoFit="False">
                            <MajorGrid Enabled="False" />
                            <LabelStyle Angle="-90" Enabled="False" Interval="1" />
                        </AxisX>
                        <AxisX2 LineColor="Transparent">
                        </AxisX2>
                        <AxisY2 LineColor="Transparent" LineWidth="0" IsLabelAutoFit="False"
                            LineDashStyle="NotSet">
                        </AxisY2>
                        <Position Height="94" Width="100" Y="3" />
                    </asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold"
                        Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                        <Position Height="16" Width="25" Y="1" X="1" />
                    </asp:Legend>
                </Legends>
            </asp:Chart>
        </td>
        <td>
            <asp:Chart ID="Chart3" runat="server" DataSourceID="sdsCuentasPorPagarAnoActual"
                Height="424px" Width="550px" BorderlineColor="Black"
                BorderlineWidth="0" Palette="None">
                <Series>
                    <asp:Series ChartArea="ChartArea1" Name="Saldo Anterior" XValueMember="mes"
                        YValueMembers="saldo_anterior" IsValueShownAsLabel="True"
                        Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" Legend="Legend1"
                        LabelAngle="90">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" Name="Compras" XValueMember="mes"
                        YValueMembers="compras" IsValueShownAsLabel="True"
                        Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" LabelAngle="90"
                        Legend="Legend1">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                        LabelFormat="{0:c0}" Legend="Legend1" Name="Pagos" XValueMember="mes"
                        YValueMembers="pagos">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                        LabelFormat="{0:c0}" Legend="Legend1" Name="Saldo Actual" XValueMember="mes"
                        YValueMembers="saldo_actual">
                    </asp:Series>
                </Series>
                <ChartAreas>
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
                            <MajorTickMark Enabled="False" />
                            <LabelStyle Enabled="False" />
                        </AxisX>
                        <AxisY2 LineColor="White" LineWidth="0">
                            <MajorGrid Enabled="False" />
                            <MajorTickMark Enabled="False" />
                            <LabelStyle Enabled="False" />
                        </AxisY2>
                        <Position Height="94" Width="100" X="1" Y="1" />
                    </asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold"
                        Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                        <Position Height="16" Width="25" X="1" Y="1" />
                    </asp:Legend>
                </Legends>
            </asp:Chart>
        </td>
        <td>
            <asp:Chart ID="Chart4" runat="server" DataSourceID="sdsCuentasPorPagarPorVencer"
                Height="424px" Width="550px" BorderlineColor="Black"
                BorderlineWidth="0" Palette="None">
                <Series>
                    <asp:Series ChartArea="ChartArea1" Name="Por Vencer " XValueMember="mes"
                        YValueMembers="por_vencer" IsValueShownAsLabel="True"
                        Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" Legend="Legend1"
                        LabelAngle="90" Color="Coral">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" Name="vencido" XValueMember="mes"
                        YValueMembers="vencido" IsValueShownAsLabel="True"
                        Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" LabelAngle="90"
                        Legend="Legend1" Color="Red">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" Color="Khaki" IsValueShownAsLabel="True" LabelFormat="{0:c0}" Legend="Legend1" Name="Comprometido" XValueMember="mes" YValueMembers="comprometido">
                    </asp:Series>
                </Series>
                <ChartAreas>
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
                            <LabelStyle Enabled="False" />
                        </AxisX>
                        <AxisY2 LineColor="White" LineWidth="0">
                            <MajorGrid Enabled="False" />
                            <MajorTickMark Enabled="False" />
                            <LabelStyle Enabled="False" />
                        </AxisY2>
                        <Position Height="94" Width="100" X="10" Y="3" />
                    </asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                        Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                        <Position Height="16" Width="25" X="1" Y="1" />
                    </asp:Legend>
                </Legends>
            </asp:Chart>
        </td>
    </tr>
</table>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table class="style1">
            <tr>
                <td>
                    <strong>
                        <br />
                        <table class="style1">
                            <tr>
                                <td class="style7">
                                    <strong>Detalle Vencido</strong></td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="style7">
                                    <asp:RadioButtonList ID="rdoExpandir" runat="server">
                                        <asp:ListItem Selected="True" Value="True">Ver Frecuentes</asp:ListItem>
                                        <asp:ListItem Value="False">Ver Todos</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td>
                                    <strong>
                                        <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
                                    </strong>
                                </td>
                            </tr>
                        </table>
                        &nbsp;</strong><asp:UpdateProgress ID="UpdateProgress1" runat="server"
                            AssociatedUpdatePanelID="UpdatePanel1">
                            <ProgressTemplate>
                                <asp:Image ID="Image1" runat="server"
                                    ImageUrl="~/imagenes/updateProgress.gif" />
                                Espere...
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Chart ID="Chart7" runat="server" DataSourceID="sdsDetalleVencido"
                        Height="567px" Width="2200px" BorderlineColor="Black"
                        BorderlineWidth="0" Palette="None" RightToLeft="No">
                        <Series>
                            <asp:Series ChartArea="ChartArea1" Name="Vencidos" XValueMember="Proveedor"
                                YValueMembers="Vencido" IsValueShownAsLabel="True"
                                Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}"
                                LabelAngle="90" Color="Red">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1"
                                BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                                BorderColor="Silver">
                                <AxisY Title="$" LineColor="White" LineWidth="0">
                                    <LabelStyle Angle="90" />
                                </AxisY>
                                <AxisX Interval="1">
                                </AxisX>
                                <AxisY2 LineColor="White" LineWidth="0">
                                </AxisY2>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                    <asp:SqlDataSource ID="sdsDetalleVencido" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="CuentasPorPagarDetalle" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text"
                                Type="Decimal" />
                            <asp:ControlParameter ControlID="lblAnoActual" Name="nAño" PropertyName="Text"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="rdoExpandir" DefaultValue="True"
                                Name="lAgrupar" PropertyName="SelectedValue" Type="Boolean" />
                            <asp:Parameter DefaultValue="0" Name="nProveedor" Type="Int32" />
                            <asp:Parameter DefaultValue="0" Name="nMes" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>

<table class="style1">
    <tr>
        <td>
            <strong>Egresos por mes del
            <asp:Label ID="lblMesActual" runat="server"></asp:Label>
            </strong>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Chart ID="Chart5" runat="server" DataSourceID="sdsMesActual"
                Height="424px" Width="2200px" BorderlineColor="Black"
                BorderlineWidth="0" Palette="None" RightToLeft="No">
                <Series>
                    <asp:Series ChartArea="ChartArea1" Name="Saldo Anterior" XValueMember="mes"
                        YValueMembers="saldo_anterior" IsValueShownAsLabel="True"
                        Font="Microsoft Sans Serif, 9pt" LabelFormat="$0,,.0M" Legend="Legend1"
                        LabelAngle="90">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" Name="Compras" XValueMember="mes"
                        YValueMembers="compras" IsValueShownAsLabel="True"
                        Font="Microsoft Sans Serif, 9pt" LabelFormat="$0,,.0M" LabelAngle="90"
                        Legend="Legend1">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                        LabelFormat="$0,,.0M" Legend="Legend1" Name="Pagos" XValueMember="mes"
                        YValueMembers="pagos">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                        LabelFormat="$0,,.0M" Legend="Legend1" Name="Saldo Actual" XValueMember="mes"
                        YValueMembers="saldo_actual">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1"
                        BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                        BorderColor="Silver">
                        <AxisY LineColor="White" LineWidth="0">
                            <MajorGrid Enabled="False" />
                            <MajorTickMark Enabled="False" />
                            <LabelStyle Enabled="False" />
                        </AxisY>
                        <AxisX Interval="1">
                            <MajorGrid Enabled="False" Interval="4" LineColor="DimGray" />
                            <MinorGrid Enabled="True" Interval="4" />
                        </AxisX>
                        <AxisX2>
                            <MinorGrid Enabled="True" />
                            <MinorTickMark Enabled="True" />
                        </AxisX2>
                        <AxisY2 LineColor="White" LineWidth="0">
                        </AxisY2>
                        <Position Height="94" Width="90" X="10" Y="3" />
                    </asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                        Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                    </asp:Legend>
                </Legends>
            </asp:Chart>
        </td>
    </tr>
</table>
<p>
    <asp:SqlDataSource ID="sdsMesActual" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="cuentasPorPagar" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="lblAnoActual" Name="nAño" PropertyName="Text"
                Type="Int32" />
            <asp:Parameter DefaultValue="Mensual" Name="cTipo" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>
<asp:SqlDataSource ID="sdsMesAnterior" runat="server"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="cuentasPorPagar" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text"
            Type="Decimal" />
        <asp:Parameter Name="nAño" Type="Int32" />
        <asp:Parameter DefaultValue="Mensual" Name="cTipo" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<table class="style1">
    <tr>
        <td>
            <strong>Egresos por mes del
            <asp:Label ID="lblMesAnterior" runat="server"></asp:Label>
            </strong>
        </td>
    </tr>
    <tr>
        <td>
            <asp:Chart ID="Chart6" runat="server" DataSourceID="sdsMesAnterior"
                Height="424px" Width="2200px" BorderlineColor="Black"
                BorderlineWidth="0" Palette="None" RightToLeft="No">
                <Series>
                    <asp:Series ChartArea="ChartArea1" Name="Saldo Anterior" XValueMember="mes"
                        YValueMembers="saldo_anterior" IsValueShownAsLabel="True"
                        Font="Microsoft Sans Serif, 9pt" LabelFormat="$0,,.0M" Legend="Legend1"
                        LabelAngle="90">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" Name="Compras" XValueMember="mes"
                        YValueMembers="compras" IsValueShownAsLabel="True"
                        Font="Microsoft Sans Serif, 9pt" LabelFormat="$0,,.0M" LabelAngle="90"
                        Legend="Legend1">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                        LabelFormat="$0,,.0M" Legend="Legend1" Name="Pagos" XValueMember="mes"
                        YValueMembers="pagos">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                        LabelFormat="$0,,.0M" Legend="Legend1" Name="Saldo Actual" XValueMember="mes"
                        YValueMembers="saldo_actual">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1"
                        BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                        BorderColor="Silver">
                        <AxisY Title="$" LineColor="White" LineWidth="0">
                        </AxisY>
                        <AxisX Interval="1">
                        </AxisX>
                        <AxisY2 LineColor="White" LineWidth="0">
                        </AxisY2>
                        <Position Height="94" Width="90" X="10" Y="3" />
                    </asp:ChartArea>
                </ChartAreas>
                <Legends>
                    <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                        Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                        <Position Height="25" Width="10" Y="1" X="1                                                                                                                                                                                                                     " />
                    </asp:Legend>
                </Legends>
            </asp:Chart>
        </td>
    </tr>
</table>



