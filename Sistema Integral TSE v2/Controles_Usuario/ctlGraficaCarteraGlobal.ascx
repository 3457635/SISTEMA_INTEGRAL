<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlGraficaCarteraGlobal.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlGraficaCartera_Global" %>



<%--<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>--%>



<style type="text/css">
    .style1 {
        width: 100%;
    }

    .style2 {
        width: 111px;
    }

    .style4 {
        width: 56px;
    }

    .style5 {
        width: 99px;
    }
</style>




<p>
    <table class="style1">
        <tr>
            <td class="style5">Año</td>
            <td>
                <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style5">Tipo de Cambio</td>
            <td>
                <asp:TextBox ID="txbTC" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style5">Sucursal</td>
            <td>
                <asp:DropDownList ID="ddlSucursal" runat="server" Height="16px" Width="131px">
                    <asp:ListItem Value="Mexicana"> Chihuahua</asp:ListItem>
                    <asp:ListItem Value="Americana">El Paso</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style5">&nbsp;</td>
            <td>
                <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
            </td>
        </tr>
    </table>
    <br />
    <table class="style1">
        <tr>
            <td>
                <strong>Cartera </strong>
            </td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Chart ID="Chart2" runat="server" DataSourceID="sdsGlobal"
                    Height="424px" Width="700px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Saldo Anterior" XValueMember="Mes"
                            YValueMembers="Saldo_anterior" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" Legend="Legend1"
                            LabelAngle="90">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Ventas" XValueMember="Mes"
                            YValueMembers="Ventas" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" LabelAngle="90"
                            Legend="Legend1">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                            LabelFormat="{0:c0}" Legend="Legend1" Name="Cobros" XValueMember="Mes"
                            YValueMembers="Pagos">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                            LabelFormat="{0:c0}" Legend="Legend1" Name="Saldo Actual" XValueMember="Mes"
                            YValueMembers="Saldo_Actual">
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
                            </AxisX>
                            <AxisY2 LineColor="White" LineWidth="0">
                            </AxisY2>
                            <Position Height="94" Width="90" X="10" Y="3" />
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                            <Position Height="22.2222214" Width="16.5517235" Y="3" />
                        </asp:Legend>
                    </Legends>
                </asp:Chart>


            </td>
            <td>
                <asp:Chart ID="Chart5" runat="server" DataSourceID="sdsAnoVencido"
                    Height="424px" Width="700px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Por Vencer" XValueMember="Mes"
                            YValueMembers="por_vencer" IsValueShownAsLabel="True" LabelFormat="{0:c0}"
                            Legend="Legend1" Color="Orange">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Vencido" XValueMember="Mes"
                            YValueMembers="vencido" IsValueShownAsLabel="True" LabelFormat="{0:c0}"
                            Legend="Legend1" Color="Red">
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
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1">
                        </asp:Legend>
                    </Legends>
                </asp:Chart>


            </td>
        </tr>
    </table>
</p>


<asp:SqlDataSource ID="sdsAnoActual" runat="server"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="carteraGlobalAnual"
    SelectCommandType="StoredProcedure"
    CancelSelectOnNullParameter="False">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text" Type="Decimal" />
        <asp:ControlParameter ControlID="txbAno" Name="nAño" PropertyName="Text" Type="Int32" />
        <asp:Parameter Name="cTipo" Type="String" DefaultValue="Anual" />
        <asp:ControlParameter ControlID="ddlSucursal" Name="cCartera" PropertyName="SelectedValue" Type="String" />
        <asp:Parameter Name="lAgrupar" Type="Boolean" />
        <asp:Parameter Name="cSaldo" Type="String"></asp:Parameter>
        <asp:Parameter Name="nMes" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="sdsAnoVencido" runat="server"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="carteraGlobalAnual"
    SelectCommandType="StoredProcedure"
    CancelSelectOnNullParameter="False">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text"
            Type="Decimal" />
        <asp:ControlParameter ControlID="txbAno" Name="nAño" PropertyName="Text"
            Type="Int32" />
        <asp:Parameter Name="cTipo" Type="String" DefaultValue="Anual" />
        <asp:ControlParameter ControlID="ddlSucursal" DefaultValue="Mexicana" Name="cCartera" PropertyName="SelectedValue" Type="String" />
        <asp:Parameter Name="lAgrupar" Type="Boolean" DefaultValue="False" />
        <asp:Parameter DefaultValue="Vencido" Name="cSaldo" Type="String" />
        <asp:Parameter Name="nMes" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsGlobal" runat="server"
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
    SelectCommand="carteraGlobalAnual" SelectCommandType="StoredProcedure"
    CancelSelectOnNullParameter="False">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbTC" DefaultValue="13" Name="nTipo_Cambio"
            PropertyName="Text" Type="Decimal" />
        <asp:ControlParameter ControlID="txbAno" DefaultValue="" Name="nAño"
            PropertyName="Text" Type="Int32" />
        <asp:Parameter Name="cTipo" Type="String" DefaultValue="Anual" />
        <asp:ControlParameter ControlID="ddlSucursal" DefaultValue="Mexicana"
            Name="cCartera" PropertyName="SelectedValue" Type="String" />
        <asp:Parameter Name="lAgrupar" Type="Boolean" DefaultValue="True" />
        <asp:Parameter DefaultValue="Saldo" Name="cSaldo" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>




<p>
</p>

<asp:UpdateProgress ID="UpdateProgress1" runat="server"
    AssociatedUpdatePanelID="UpdatePanel1">
    <ProgressTemplate>
        <asp:Image ID="Image1" runat="server"
            ImageUrl="~/imagenes/updateProgress.gif" />
        Espere..
    </ProgressTemplate>
</asp:UpdateProgress>
<table class="style1">
    <tr>
        <td class="style2">
            <asp:RadioButtonList ID="rbtnAgrupar" runat="server" AutoPostBack="True">
                <asp:ListItem Selected="True" Value="True">Agrupado</asp:ListItem>
                <asp:ListItem Value="False">No Agrupado</asp:ListItem>
            </asp:RadioButtonList>
        </td>
        <td class="style4"></td>
        <td>&nbsp;&nbsp;<strong>Cartera Vencida</strong></td>
    </tr>
</table>

<asp:SqlDataSource ID="sdsVencidoPorCliente" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="carteraGlobalAnual" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text" Type="Decimal" />
        <asp:ControlParameter ControlID="txbAno" DefaultValue="" Name="nAño" PropertyName="Text" Type="Int32" />
        <asp:Parameter DefaultValue="Cliente" Name="cTipo" Type="String" />
        <asp:ControlParameter ControlID="ddlSucursal" DefaultValue="Mexicana" Name="cCartera" PropertyName="SelectedValue" Type="String" />
        <asp:ControlParameter ControlID="rbtnAgrupar" DefaultValue="True" Name="lAgrupar" PropertyName="SelectedValue" Type="Boolean" />
        <asp:Parameter DefaultValue="Vencido" Name="cSaldo" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:Chart ID="Chart6" runat="server" BorderlineColor="Black"
    BorderlineWidth="0" DataSourceID="sdsVencidoPorCliente" Height="304px"
    Palette="None" RightToLeft="No" Width="1420px">
    <Series>
        <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
            LabelFormat="{0:c0}" Legend="Legend1" Name="Cliente" XValueMember="Cliente"
            YValueMembers="Saldo" Color="Red">
        </asp:Series>
    </Series>
    <ChartAreas>
        <asp:ChartArea BackSecondaryColor="#B6D6EC" BorderColor="Silver"
            BorderDashStyle="Solid" BorderWidth="0" Name="ChartArea1">
            <AxisY LineWidth="0">
                <MajorGrid Enabled="False" />
                <MajorTickMark Enabled="False" />
                <LabelStyle Enabled="False" />
            </AxisY>
            <AxisX Interval="1">
                <MajorGrid Enabled="False" />
            </AxisX>
        </asp:ChartArea>
    </ChartAreas>
    <Legends>
        <asp:Legend AutoFitMinFontSize="5" Font="Microsoft Sans Serif, 8pt, style=Bold"
            IsTextAutoFit="False" LegendStyle="Column" Name="Legend1">
        </asp:Legend>
    </Legends>
</asp:Chart>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
    </ContentTemplate>
</asp:UpdatePanel>
<p>
    <br />
</p>
<p>
    &nbsp;Cartera por mes del
    <asp:Label ID="lblMesActual" runat="server"></asp:Label>
</p>




<p>
    <asp:Chart ID="Chart3" runat="server" DataSourceID="sdsMensualActual"
        Height="304px" Width="1420px" BorderlineColor="Black"
        BorderlineWidth="0" Palette="None" RightToLeft="No">
        <Series>
            <asp:Series ChartArea="ChartArea1" Name="Saldo Anterior" IsValueShownAsLabel="True"
                Font="Microsoft Sans Serif, 9pt" LabelFormat="$0,,.0M" Legend="Legend1"
                LabelAngle="90" XValueMember="mes" YValueMembers="saldo_anterior">
            </asp:Series>
            <asp:Series ChartArea="ChartArea1" Name="Ventas" IsValueShownAsLabel="True"
                Font="Microsoft Sans Serif, 9pt" LabelFormat="$0,,.0M" LabelAngle="90"
                Legend="Legend1" XValueMember="mes" YValueMembers="ventas">
            </asp:Series>
            <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                LabelFormat="$0,,.0M" Legend="Legend1" Name="Cobros" XValueMember="mes"
                YValueMembers="pagos">
            </asp:Series>
            <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                LabelFormat="$0,,.0M" Legend="Legend1" Name="Saldo Actual"
                XValueMember="mes" YValueMembers="saldo_actual">
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
                <AxisX Interval="1">
                    <MajorGrid Enabled="False" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
        <Legends>
            <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
            </asp:Legend>
        </Legends>
    </asp:Chart>


</p>
<p>
    <asp:SqlDataSource ID="sdsMensualActual" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="carteraGlobalAnual" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txbAno" Name="nAño" PropertyName="Text"
                Type="Int32" />
            <asp:Parameter DefaultValue="Mensual" Name="cTipo" Type="String" />
            <asp:ControlParameter ControlID="ddlSucursal" DefaultValue="Mexicana"
                Name="cCartera" PropertyName="SelectedValue" Type="String" />
            <asp:Parameter Name="lAgrupar" Type="Boolean" DefaultValue="false" />
            <asp:Parameter DefaultValue="Saldo" Name="cSaldo" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>
<p>
    Cartera por mes del
    <asp:Label ID="lblMesAnterior" runat="server"></asp:Label>
</p>
<p>
    <asp:Chart ID="Chart4" runat="server" DataSourceID="sdsMensualAntiguo"
        Height="280px" Width="1420px" BorderlineColor="Black"
        BorderlineWidth="0" Palette="None" RightToLeft="No">
        <Series>
            <asp:Series ChartArea="ChartArea1" Name="Saldo Anterior" IsValueShownAsLabel="True"
                Font="Microsoft Sans Serif, 9pt" LabelFormat="$0,,.0M" Legend="Legend1"
                LabelAngle="90" XValueMember="mes" YValueMembers="saldo_anterior">
            </asp:Series>
            <asp:Series ChartArea="ChartArea1" Name="Ventas" IsValueShownAsLabel="True"
                Font="Microsoft Sans Serif, 9pt" LabelFormat="$0,,.0M" LabelAngle="90"
                Legend="Legend1" XValueMember="mes" YValueMembers="ventas">
            </asp:Series>
            <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                LabelFormat="$0,,.0M" Legend="Legend1" Name="Cobros" XValueMember="mes"
                YValueMembers="pagos">
            </asp:Series>
            <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                LabelFormat="$0,,.0M" Legend="Legend1" Name="Saldo Actual"
                XValueMember="mes" YValueMembers="saldo_actual">
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
                <AxisX Interval="1">
                    <MajorGrid Enabled="False" />
                </AxisX>
            </asp:ChartArea>
        </ChartAreas>
        <Legends>
            <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
            </asp:Legend>
        </Legends>
    </asp:Chart>


    <asp:SqlDataSource ID="sdsMensualAntiguo" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="carteraGlobalAnual" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txbTC" Name="nTipo_Cambio" PropertyName="Text"
                Type="Decimal" />
            <asp:Parameter Name="nAño" Type="Int32" />
            <asp:Parameter Name="cTipo" Type="String" DefaultValue="Mensual" />
            <asp:ControlParameter ControlID="ddlSucursal" DefaultValue="Mexicana"
                Name="cCartera" PropertyName="SelectedValue" Type="String" />
            <asp:Parameter DefaultValue="False" Name="lAgrupar" Type="Boolean" />
            <asp:Parameter DefaultValue="Saldo" Name="cSaldo" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>
<p>
    &nbsp;
</p>





