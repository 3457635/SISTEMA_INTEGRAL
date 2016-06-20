<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="indicadores.aspx.vb" Inherits="Sistema_Integral_TSE_v45.indicadores1" %>

<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style5 {
            width: 100%;
        }

        .style6 {
            width: 859px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Indicadores Mantenimiento(Año/A la fecha)</h1>
    <table class="style5">
        <tr>
            <td class="style6">&nbsp;<asp:Label ID="Label3" runat="server" Text="Indique el año:" Font-Bold="True"></asp:Label>
                <asp:TextBox ID="txbConsultar" runat="server"></asp:TextBox>
                <strong>
                    <asp:Label ID="Label1" runat="server" Text="Unidad"></asp:Label>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsBuscaTipoUnidad" DataTextField="equipo" DataValueField="equipo" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:Label ID="Label2" runat="server" Text="Económico"></asp:Label>
                </strong>
                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="sdsBuscaUnidades" DataTextField="economico" DataValueField="economico">
                </asp:DropDownList>
                <asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
            </td>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Ver costos por unidades" />
            </td>
            
            
        </tr>
        <tr>
            <td class="style6">
                <strong>Unidades registradas</strong></td>
            <td>
                <strong></strong></td>
            <td>
                <strong></strong></td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="style6">
                <asp:SqlDataSource ID="sdsUnidades" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="Taller" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txbConsultar" Name="nAño" PropertyName="Text"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="DropDownList1" Name="cunidad" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="DropDownList2" Name="ceconomico" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsBuscaTipoUnidad" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="Select equipo from tipo_equipos"></asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsBuscaUnidades" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="if @cunidad = 'Todos...' 
Select 'Todos...' as economico
else
select eo.economico as economico from equipo_operacion eo
join tipo_equipos te on te.id_tipo_equipo = eo.id_tipo_equipo 
where te.equipo= @cunidad and eo.id_status = 5 
Order by eo.economico">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="DropDownList1" Name="cunidad" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:Chart ID="Chart3" runat="server" DataSourceID="sdsUnidades"
                    Height="304px" Width="859px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None" RightToLeft="No">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Unidades" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:n0}" Legend="Legend1"
                            LabelAngle="90" XValueMember="equipo" YValueMembers="cantidad"
                            Color="0, 192, 0">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"
                            BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                            BorderColor="Silver">
                            <AxisY LineWidth="0">
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>

                                <MajorTickMark Enabled="False"></MajorTickMark>

                                <LabelStyle Enabled="False" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>
                            </AxisX>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                            <Position Height="7.920792" Width="11.1888113" X="0.81119" Y="3" />
                        </asp:Legend>
                    </Legends>
                </asp:Chart>


            </td>
           
           
            <td>&nbsp;</td>
        </tr>
        <tr><td colspan="2"><hr /> <h1>Total de mantenimientos registrados en el sistema</h1></td></tr>
        <tr>
            
            <td>
                <strong>Cantidad de mantenimientos preventivos y correctivos totales</strong></td>
            <td>
                <strong>Costo de preventivos y correctivos totales</strong></td>
            
        </tr>
        <tr>
            <td>
                <asp:Chart ID="Chart2" runat="server" DataSourceID="sdsUnidades"
                    Height="424px" Width="726px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Preventivos" XValueMember="equipo"
                            YValueMembers="preventivos" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:n0}" Legend="Legend1"
                            LabelAngle="90">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Correctivos" XValueMember="equipo"
                            YValueMembers="correctivos" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:n0}" LabelAngle="90"
                            Legend="Legend1">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"
                            BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                            BorderColor="Silver">
                            <AxisY LineColor="White" LineWidth="0">
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>

                                <MajorTickMark Enabled="False"></MajorTickMark>

                                <LabelStyle Enabled="False" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>
                            </AxisX>
                            <AxisY2 LineColor="White" LineWidth="0">
                            </AxisY2>
                            <Position Height="94" Width="90" X="10" Y="3" />

                            <Position Height="94" X="10" Y="3" Width="90"></Position>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                            <Position Height="22.2222214" Width="16.5517235" Y="3" />
                            <Position Height="22.2222214" Y="3" Width="16.5517235"></Position>
                        </asp:Legend>
                    </Legends>
                </asp:Chart>


            </td>
            <td>
                <asp:Chart ID="Chart4" runat="server" DataSourceID="sdsUnidades"
                    Height="424px" Width="726px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Gastos Preventivos" XValueMember="equipo"
                            YValueMembers="gastoPreventivos" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" Legend="Legend1"
                            LabelAngle="90">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Gastos Correctivos" XValueMember="equipo"
                            YValueMembers="gastoCorrectivos" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" LabelAngle="90"
                            Legend="Legend1">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"
                            BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                            BorderColor="Silver">
                            <AxisY LineColor="White" LineWidth="0">
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>

                                <MajorTickMark Enabled="False"></MajorTickMark>

                                <LabelStyle Enabled="False" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>
                            </AxisX>
                            <AxisY2 LineColor="White" LineWidth="0">
                            </AxisY2>
                            <Position Height="94" Width="90" X="10" Y="3" />

                            <Position Height="94" X="10" Y="3" Width="90"></Position>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                            <Position Height="22.2222214" Width="16.5517235" Y="3" />
                            <Position Height="22.2222214" Y="3" Width="16.5517235"></Position>
                        </asp:Legend>
                    </Legends>
                </asp:Chart>


            </td>
        </tr>
        <tr><td colspan="3"><hr /><h1>Comparativo de preventivos</h1></td></tr>
        <tr>

            <td class="style6">
                <strong>Comparativo total de preventivos del año indicado contra el anterior</strong></td>
            <td>
                <strong>Comparativo de costos de preventivos del año indicado contra el anterior</strong></td>
        </tr>
        <tr>
            <td class="style6">
                <asp:Chart ID="Chart5" runat="server" DataSourceID="sdsUnidades"
                    Height="424px" Width="845px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Total año anterior" XValueMember="equipo"
                            YValueMembers="p_año_ant" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:n0}" Legend="Legend1"
                            LabelAngle="90" Color="LightSteelBlue">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Año Actual  al día" XValueMember="equipo"
                            YValueMembers="p_año_act" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:n0}" LabelAngle="90"
                            Legend="Legend1">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"
                            BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                            BorderColor="Silver">
                            <AxisY LineColor="White" LineWidth="0">
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>

                                <MajorTickMark Enabled="False"></MajorTickMark>

                                <LabelStyle Enabled="False" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>
                            </AxisX>
                            <AxisY2 LineColor="White" LineWidth="0">
                            </AxisY2>
                            <Position Height="94" Width="90" X="10" Y="3" />

                            <Position Height="94" X="10" Y="3" Width="90"></Position>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                            <Position Height="22.2222214" Width="16.5517235" Y="3" />
                            <Position Height="22.2222214" Y="3" Width="16.5517235"></Position>
                        </asp:Legend>
                    </Legends>
                </asp:Chart>


            </td>
            <td>
                <asp:Chart ID="Chart7" runat="server" DataSourceID="sdsUnidades"
                    Height="424px" Width="726px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Año Anterior" XValueMember="equipo"
                            YValueMembers="gp_año_ant" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" Legend="Legend1"
                            LabelAngle="90" Color="LightSteelBlue">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Año Actual" XValueMember="equipo"
                            YValueMembers="gp_año_act" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" LabelAngle="90"
                            Legend="Legend1">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"
                            BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                            BorderColor="Silver">
                            <AxisY LineColor="White" LineWidth="0">
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>

                                <MajorTickMark Enabled="False"></MajorTickMark>

                                <LabelStyle Enabled="False" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>
                            </AxisX>
                            <AxisY2 LineColor="White" LineWidth="0">
                            </AxisY2>
                            <Position Height="94" Width="90" X="10" Y="3" />

                            <Position Height="94" X="10" Y="3" Width="90"></Position>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                            <Position Height="22.2222214" Width="16.5517235" Y="3" />
                            <Position Height="22.2222214" Y="3" Width="16.5517235"></Position>
                        </asp:Legend>
                    </Legends>
                </asp:Chart>


            </td>
            
            
        </tr>
        <tr><td colspan="3"><hr /><h1>Comparativo de correctivos</h1></td></tr>
        <tr>

            <td class="style6">
                <strong>Comparativo de total de correctivos del año indicado contra el anterior</strong></td>
            <td>
                <strong>Comparativo de costos de correctivos del año indicado contra el anterior</strong></td>
           
            
        </tr>
        <tr>
            <td class="style6">
                <asp:Chart ID="Chart6" runat="server" DataSourceID="sdsUnidades"
                    Height="424px" Width="842px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Año Anterior" XValueMember="equipo"
                            YValueMembers="c_año_ant" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:n0}" Legend="Legend1"
                            LabelAngle="90" Color="Silver">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Año Actual" XValueMember="equipo"
                            YValueMembers="c_año_act" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:n0}" LabelAngle="90"
                            Legend="Legend1" Color="#0099FF">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"
                            BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                            BorderColor="Silver">
                            <AxisY LineColor="White" LineWidth="0">
                                <MajorGrid Enabled="False"></MajorGrid>

                                <MajorTickMark Enabled="False"></MajorTickMark>

                                <LabelStyle Enabled="False" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False"></MajorGrid>
                            </AxisX>
                            <AxisY2 LineColor="White" LineWidth="0">
                            </AxisY2>

                            <Position Height="94" X="10" Y="3" Width="90"></Position>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                            <Position Height="22.2222214" Y="3" Width="16.5517235"></Position>
                        </asp:Legend>
                    </Legends>
                </asp:Chart>


            </td>
            <td>
                <asp:Chart ID="Chart8" runat="server" DataSourceID="sdsUnidades"
                    Height="424px" Width="726px" BorderlineColor="Black"
                    BorderlineWidth="0" Palette="None">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" Name="Año Anterior" XValueMember="equipo"
                            YValueMembers="gc_año_ant" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" Legend="Legend1"
                            LabelAngle="90" Color="Silver">
                        </asp:Series>
                        <asp:Series ChartArea="ChartArea1" Name="Año Actual" XValueMember="equipo"
                            YValueMembers="gc_año_act" IsValueShownAsLabel="True"
                            Font="Microsoft Sans Serif, 9pt" LabelFormat="{0:c0}" LabelAngle="90"
                            Legend="Legend1" Color="#0099FF">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1"
                            BackSecondaryColor="#B6D6EC" BorderDashStyle="Solid" BorderWidth="0"
                            BorderColor="Silver">
                            <AxisY LineColor="White" LineWidth="0">
                                <MajorGrid Enabled="False" />
                                <MajorTickMark Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>

                                <MajorTickMark Enabled="False"></MajorTickMark>

                                <LabelStyle Enabled="False" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" />
                                <MajorGrid Enabled="False"></MajorGrid>
                            </AxisX>
                            <AxisY2 LineColor="White" LineWidth="0">
                            </AxisY2>
                            <Position Height="94" Width="90" X="10" Y="3" />

                            <Position Height="94" X="10" Y="3" Width="90"></Position>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" IsTextAutoFit="False"
                            Name="Legend1" AutoFitMinFontSize="5" LegendStyle="Column">
                            <Position Height="22.2222214" Width="16.5517235" Y="3" />
                            <Position Height="22.2222214" Y="3" Width="16.5517235"></Position>
                        </asp:Legend>
                    </Legends>
                </asp:Chart>


            </td>
           
            
        </tr>
    </table>


</asp:Content>
