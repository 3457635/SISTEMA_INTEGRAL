<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="tableroViajes.aspx.vb" Inherits="Sistema_Integral_TSE_v45.tableroViajes" %>
<%@ Register src="../Controles_Usuario/ctlLlegadasTiempo.ascx" tagname="ctlLlegadasTiempo" tagprefix="uc1" %>
<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style5
        {
            width: 100%;
        }
        .style6
        {
            width: 191px;
        }
        .auto-style1 {
            width: 726px;
        }
    </style>
    <%--<script src="../Scripts/jquery-1.9.1.js"></script>--%>
    <%--<script>
        $(document).ready(function () {
            $("#pruebaChart1").load("../UnauthorizedAccess.aspx");
        });
</script>--%>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
        <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsClientes" DataTextField="nombre" DataValueField="id_empresa" Height="16px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsClientes" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE (([id_tipo_empresa] = @id_tipo_empresa) AND ([id_status] = @id_status)) ORDER BY [nombre]">
            <SelectParameters>
                <asp:Parameter DefaultValue="1" Name="id_tipo_empresa" Type="Int32" />
                <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <div id="pruebaChart1">
    </div>
    <p>
&nbsp;<asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
        <br />
    </p>
    <p>
        <table class="style5">
            <tr>
                <td class="auto-style1">
                    <strong>Comparativo de viajes realizados por año.&nbsp; </strong></td>
                <td>
                    <strong>Comparativo de Precios por año.</strong></td>
            </tr>
            <tr>
                <td class="auto-style1">
        <asp:Chart ID="Chart5" runat="server" DataSourceID="sdsViajesPorAno" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No" Enabled="False">
            <series>
                <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Total Año Anterior" XValueMember="tipo" YValueMembers="TAñoAnt" Font="Microsoft Sans Serif, 12pt, style=Bold" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Color="Olive">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" Name="Año Anterior" XValueMember="tipo"
                    YValueMembers="añoAnt" IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" Font="Microsoft Sans Serif, 12pt, style=Bold" Color="128, 64, 0">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" Name="Año Actual" XValueMember="tipo"
                    YValueMembers="añoAct" IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" Font="Microsoft Sans Serif, 12pt, style=Bold" Color="192, 192, 0">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Proyección" XValueMember="tipo" YValueMembers="Proyección" Font="Microsoft Sans Serif, 12pt, style=Bold" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Color="Green">
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
                    <AxisX2>
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                    </AxisX2>
                    <AxisY2>
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                    </AxisY2>
                </asp:ChartArea>
            </chartareas>
            <Legends>
                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1">
                </asp:Legend>
            </Legends>
        </asp:Chart>


                </td>
                <td>
        <asp:Chart ID="chrIngresos" runat="server" DataSourceID="sdsIngresosPorAno" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No" Enabled="False">
            <series>
                <asp:Series ChartArea="ChartArea1" Font="Microsoft Sans Serif, 9pt, style=Bold" IsValueShownAsLabel="True" LabelFormat="{0:c0}" Legend="Legend1" Name="Ingresos Totales Año Anterior" XValueMember="tipo" YValueMembers="TPrecioAnt" Color="Olive">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" Name="Año Anterior" XValueMember="tipo"
                    YValueMembers="PrecioAnt" IsValueShownAsLabel="True" LabelFormat="{0:c0}" 
                    Legend="Legend1" Font="Microsoft Sans Serif, 9pt, style=Bold" Color="128, 64, 0">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" Name="Año Actual" XValueMember="tipo"
                    YValueMembers="PrecioAct" IsValueShownAsLabel="True" LabelFormat="{0:c0}" 
                    Legend="Legend1" Font="Microsoft Sans Serif, 9pt, style=Bold" Color="192, 192, 0">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Proyección" XValueMember="tipo" YValueMembers="Proyección1" Font="Microsoft Sans Serif, 9pt, style=Bold" IsValueShownAsLabel="True" LabelFormat="{0:c0}" Color="Green">
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
                    <AxisX2>
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                    </AxisX2>
                    <AxisY2>
                        <MajorGrid Enabled="False" />
                        <MajorTickMark Enabled="False" />
                    </AxisY2>
                </asp:ChartArea>
            </chartareas>
            <Legends>
                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1">
                </asp:Legend>
            </Legends>
        </asp:Chart>


                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                <strong>Comparativo de viajes por mes.
                <br />
                Año Actual vs Año Anterior </strong></td>
                <td>
                <strong>Comparativo de Precios por mes.
                <br />
                Año Actual vs Año Anterior</strong></td>
            </tr>
            <tr>
                <td class="auto-style1">
        <asp:Chart ID="Chart6" runat="server" DataSourceID="sdsMesActual" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
            <series>
                <asp:Series ChartArea="ChartArea1" Name="Año Anterior" XValueMember="mes"
                    YValueMembers="añoAnt" IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" Font="Microsoft Sans Serif, 8pt, style=Bold" Color="128, 64, 0">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" Name="Año Actual" XValueMember="mes"
                    YValueMembers="AñoAct" IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" Font="Microsoft Sans Serif, 8pt, style=Bold" Color="192, 192, 0">
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
                        <MajorTickMark Enabled="False" />
                        <LabelStyle Angle="90" />
                    </AxisX>
                </asp:ChartArea>
            </chartareas>
            <Legends>
                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1">
                </asp:Legend>
            </Legends>
        </asp:Chart>


                </td>
                <td>
        <asp:Chart ID="chrMesIngresos" runat="server" DataSourceID="sdsMesIngresos" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
            <series>
                <asp:Series ChartArea="ChartArea1" Name="Año Anterior" XValueMember="mes"
                    YValueMembers="PrecioAnt" IsValueShownAsLabel="True" LabelFormat="$0,,.0M" 
                    Legend="Legend1" Font="Microsoft Sans Serif, 7pt, style=Bold" Color="128, 64, 0">
                </asp:Series>
                <asp:Series ChartArea="ChartArea1" Name="Año Actual" XValueMember="mes"
                    YValueMembers="PrecioAct" IsValueShownAsLabel="True" LabelFormat="$0,,.0M" 
                    Legend="Legend1" Font="Microsoft Sans Serif, 7pt, style=Bold" Color="192, 192, 0">
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
                        <MajorTickMark Enabled="False" />
                        <LabelStyle Angle="90" />
                    </AxisX>
                </asp:ChartArea>
            </chartareas>
            <Legends>
                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1">
                </asp:Legend>
            </Legends>
        </asp:Chart>


                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="sdsViajesPorAno" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txbAno" DefaultValue="2014" Name="nAño" 
                    PropertyName="Text" Type="Int32" />
                <asp:Parameter DefaultValue="Anual" Name="cTipo" Type="String" />
                <asp:ControlParameter ControlID="ddlMes" DefaultValue="" Name="nMes_SD" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlCliente" DefaultValue="" Name="nCliente" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsIngresosPorAno" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txbAno" DefaultValue="2014" Name="nAño" 
                    PropertyName="Text" Type="Int32" />
                <asp:Parameter DefaultValue="Anual" Name="cTipo" Type="String" />
                <asp:ControlParameter ControlID="ddlMes" DefaultValue="" Name="nMes_SD" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlCliente" DefaultValue="" Name="nCliente" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsMesActual" runat="server" 
                    CancelSelectOnNullParameter="False" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txbAno" DefaultValue="2014" Name="nAño" 
                            PropertyName="Text" Type="Int32" />
                        <asp:Parameter DefaultValue="Mensual" Name="cTipo" Type="String" />
                        <asp:ControlParameter ControlID="ddlMes" DefaultValue="" Name="nMes_SD" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlCliente" DefaultValue="" Name="nCliente" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsMesIngresos" runat="server" 
                    CancelSelectOnNullParameter="False" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txbAno" DefaultValue="2014" Name="nAño" 
                            PropertyName="Text" Type="Int32" />
                        <asp:Parameter DefaultValue="Mensual" Name="cTipo" Type="String" />
                        <asp:ControlParameter ControlID="ddlMes" DefaultValue="" Name="nMes_SD" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlCliente" DefaultValue="" Name="nCliente" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsPorSemana" runat="server" 
                    CancelSelectOnNullParameter="False" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txbAno" DefaultValue="2014" Name="nAño" 
                            PropertyName="Text" Type="Int32" />
                        <asp:Parameter DefaultValue="Semanal" Name="cTipo" Type="String" />
                        <asp:ControlParameter ControlID="ddlMes" DefaultValue="" Name="nMes_SD" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlCliente" DefaultValue="" Name="nCliente" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsDiario" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txbAno" Name="nAño" PropertyName="Text" 
                            Type="Int32" />
                        <asp:Parameter DefaultValue="Diario" Name="cTipo" Type="String" />
                        <asp:ControlParameter ControlID="ddlMes" DefaultValue="" Name="nMes_SD" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlCliente" Name="nCliente" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsUtilizacionEquipo" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="Utilizacion_Unidades" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txbInicio" Name="dFecha_inicial" PropertyName="Text" Type="DateTime" />
                <asp:ControlParameter ControlID="ddlVehiculo" Name="cEquipo" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsViajesPorCliente" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txbAno" DefaultValue="2014" Name="nAño" 
                    PropertyName="Text" Type="Int32" />
                <asp:Parameter DefaultValue="Cliente" Name="cTipo" Type="String" />
                <asp:Parameter DefaultValue="0" Name="nMes_SD" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="nCliente" Type="Int32" />
                <asp:Parameter DefaultValue="True" Name="nFrecuente" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
        <asp:SqlDataSource ID="sdsIngesosPorCliente" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="ViajesAnuales" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="txbAno" DefaultValue="2014" Name="nAño" 
                    PropertyName="Text" Type="Int32" />
                <asp:Parameter DefaultValue="Cliente" Name="cTipo" Type="String" />
                <asp:Parameter DefaultValue="0" Name="nMes_SD" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="nCliente" Type="Int32" />
                <asp:Parameter DefaultValue="True" Name="nFrecuente" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    <p>
        &nbsp;</p>
    <table class="style5">
        <tr>
            <td class="style6">
                <strong>Viajes realizos en el mes por numero de semana.</strong></td>
            <td>
                <strong>Viajes realizados por dia en el mes.</strong></td>
        </tr>
        <tr>
            <td class="style6">
        &nbsp;
                        &nbsp;<asp:Chart ID="Chart7" runat="server" DataSourceID="sdsPorSemana" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
                            <series>
                                <asp:Series ChartArea="ChartArea1" Name="Viajes" 
                    IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" XValueMember="Semana" YValueMembers="viajes" 
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
                                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                   


                </td>
            <td>
                        <asp:Chart ID="Chart8" runat="server" DataSourceID="sdsDiario" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
                            <series>
                                <asp:Series ChartArea="ChartArea1" Name="Viajes" 
                    IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" XValueMember="Día" YValueMembers="AñoAct" Color="192, 192, 0">
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
                                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                    </td>
        </tr>
        <tr>
            <td class="style6">
                <strong>Comparativo de Viajes Por Cliente a la fecha.</strong></td>
            <td>
                <strong>Comparativo de Precios Por Cliente a la fecha.</strong></td>
        </tr>
        <tr>
            <td class="style6">
                <asp:Chart ID="Chart11" runat="server" DataSourceID="sdsViajesPorCliente" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
                            <series>
                                <asp:Series ChartArea="ChartArea1" Name="Viajes año anterior" 
                    IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" XValueMember="Cliente" YValueMembers="AñoAnt" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" Color="128, 64, 0">
                                </asp:Series>
                                <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Viajes año actual" XValueMember="cliente" YValueMembers="añoAct" Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" Color="192, 192, 0">
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
                                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                   


                </td>
            <td>
                <asp:Chart ID="ChartIngresosPorCliente" runat="server" DataSourceID="sdsIngesosPorCliente" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
                            <series>
                                <asp:Series ChartArea="ChartArea1" Name="Viajes año anterior" 
                    IsValueShownAsLabel="True" LabelFormat="$0,,.0M" 
                    Legend="Legend1" XValueMember="cliente" YValueMembers="PrecioAnt" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" Color="128, 64, 0">
                                </asp:Series>
                                <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Viajes año actual" XValueMember="cliente" YValueMembers="PrecioAct" Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" Color="192, 192, 0" LabelFormat="$0,,.0M">
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
                                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                   


                </td>
        </tr>
    </table>

    </br>

 
                
&nbsp;<strong>Uso de equipo</strong>
    <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
    <ProgressTemplate>
        <asp:Image ID="imgUpdate" runat="server" 
            ImageUrl="~/imagenes/updateProgress.gif" />
     Espere...
    </ProgressTemplate>   
    </asp:UpdateProgress>


     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>   

    <table class="style5">
        <tr>
            <td>Inicio<asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="txbInicio_CalendarExtender" runat="server" Format="yyyy/MM/dd"
                    Enabled="True" TargetControlID="txbInicio">
                </asp:CalendarExtender>
                &nbsp;Vehiculo:
                <asp:DropDownList ID="ddlVehiculo" runat="server">
                    <asp:ListItem Selected="True">Tracto</asp:ListItem>
                    <asp:ListItem>Rabon</asp:ListItem>
                    <asp:ListItem>Pick Up</asp:ListItem>
                </asp:DropDownList>
                &nbsp;<asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
                </td>
        </tr>
        <tr>
            <td>
               
            </td>
        </tr>
        <tr>
            <td>
                <asp:Chart ID="Chart10" runat="server" DataSourceID="sdsUtilizacionEquipo" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
                            <series>
                                <asp:Series ChartArea="ChartArea1" Name="Semana Anterior" 
                    IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" XValueMember="Día" YValueMembers="SemAnt" Color="128, 64, 0">
                                </asp:Series>
                                <asp:Series ChartArea="ChartArea1" Font="Microsoft Sans Serif, 8pt, style=Bold" IsValueShownAsLabel="True" Legend="Legend1" Name="Semana Actual" XValueMember="Día" YValueMembers="SemAct" Color="192, 192, 0">
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
                                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False" 
                    Name="Legend1">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                   


            </td>
        </tr>
        </table>
        
    </ContentTemplate>
    <Triggers>
     <asp:AsyncPostBackTrigger ControlID="btnConsultar" EventName="Click" />
    </Triggers>
    </asp:UpdatePanel>

    
        <table>
        <tr>
            <td>
                <strong>Llegadas a Destino</strong></td>
        </tr>
        <tr>
            <td>
                <uc1:ctlLlegadasTiempo ID="ctlLlegadasTiempo1" runat="server" />
            </td>
        </tr>
    </table>
</asp:Content>
