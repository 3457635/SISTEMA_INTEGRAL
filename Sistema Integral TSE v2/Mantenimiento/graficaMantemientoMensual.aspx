<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="graficaMantemientoMensual.aspx.vb" Inherits="Sistema_Integral_TSE_v45.graficaMantemientoMensual" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Indicadores de costos y cantidad de mantenimientos por mes</h1>
    <table>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Año"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server">2016</asp:TextBox>
                
                <asp:Label ID="Label3" runat="server" Text="Fecha fin" Visible="False"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" Visible="False"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy/MM/dd" TargetControlID="TextBox2">
    </asp:CalendarExtender>
                <asp:Label ID="Label2" runat="server" Text="Unidad" Visible="False"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="sdsMantenimientoMensual" DataTextField="equipo" DataValueField="equipo" Visible="False">
                </asp:DropDownList>
                <asp:Button ID="Button1" runat="server" PostBackUrl="~/Mantenimiento/graficaMantemientoMensual.aspx" Text="Consultar" />
            </td>
        </tr>
        <tr><td><h1>Correctivos</h1></td></tr>
        <tr>
            <td>
                <asp:Chart ID="Chart1" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsMantenimientoMensual" Palette="None" Width="1268px">
                    <Series>
                        <asp:Series IsValueShownAsLabel="True" LabelFormat="{0:c0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" Name="Costo en pesos" XValueMember="mes" YValueMembers="costoC">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea BorderDashStyle="Solid" BorderWidth="0" Name="ChartArea1">
                            <AxisY LineWidth="0">
                                <MajorGrid Enabled="False" LineWidth="0" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" LineWidth="0" />
                                <MinorGrid LineWidth="0" />
                            </AxisX>
                            <AxisX2>
                                <MajorGrid Enabled="False" />
                            </AxisX2>
                            <AxisY2>
                                <MajorGrid Enabled="False" />
                            </AxisY2>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend AutoFitMinFontSize="5" IsTextAutoFit="False" LegendStyle="Column" Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Costos de correctivos por mes">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Chart ID="Chart3" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsMantenimientoMensual" Palette="Chocolate" Width="1268px">
                    <Series>
                        <asp:Series IsValueShownAsLabel="True" LabelFormat="{0:n0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" Name="Cantidad de correctivos" XValueMember="mes" YValueMembers="cantidadC">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea BorderDashStyle="Solid" BorderWidth="0" Name="ChartArea1">
                            <AxisY LineWidth="0">
                                <MajorGrid Enabled="False" LineWidth="0" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" LineWidth="0" />
                                <MinorGrid LineWidth="0" />
                            </AxisX>
                            <AxisX2>
                                <MajorGrid Enabled="False" />
                            </AxisX2>
                            <AxisY2>
                                <MajorGrid Enabled="False" />
                            </AxisY2>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend AutoFitMinFontSize="5" IsTextAutoFit="False" LegendStyle="Column" Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Cantidad de correctivos por mes">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
            </td>
        </tr>
        <tr>
            <td>&nbsp;<hr />
            </td>
        </tr>
        <tr><td><h1>Preventivos</h1></td></tr>
        <tr>
            <td>
                <asp:Chart ID="Chart2" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsMantenimientoMensual" Palette="Pastel" Width="1272px">
                    <Series>
                        <asp:Series IsValueShownAsLabel="True" LabelFormat="{0:c0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" Name="Costo en pesos" XValueMember="mes" YValueMembers="costoP">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea BorderDashStyle="Solid" BorderWidth="0" Name="ChartArea1">
                            <AxisY LineWidth="0">
                                <MajorGrid Enabled="False" LineWidth="0" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" LineWidth="0" />
                                <MinorGrid LineWidth="0" />
                            </AxisX>
                            <AxisX2>
                                <MajorGrid Enabled="False" />
                            </AxisX2>
                            <AxisY2>
                                <MajorGrid Enabled="False" />
                            </AxisY2>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend AutoFitMinFontSize="5" IsTextAutoFit="False" LegendStyle="Column" Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Costos de preventivos por mes">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
            </td>
        </tr>
        
        <tr>
            <td>
                <asp:SqlDataSource ID="sdsMantenimientoMensual" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="Mantenimiento_mensual" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="TextBox1" Name="nAño" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:Chart ID="Chart4" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsMantenimientoMensual" Palette="SeaGreen" Width="1272px">
                    <Series>
                        <asp:Series IsValueShownAsLabel="True" LabelFormat="{0:n0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" Name="Cantidad de preventivos" XValueMember="mes" YValueMembers="CantidadP">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea BorderDashStyle="Solid" BorderWidth="0" Name="ChartArea1">
                            <AxisY LineWidth="0">
                                <MajorGrid Enabled="False" LineWidth="0" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" LineWidth="0" />
                                <MinorGrid LineWidth="0" />
                            </AxisX>
                            <AxisX2>
                                <MajorGrid Enabled="False" />
                            </AxisX2>
                            <AxisY2>
                                <MajorGrid Enabled="False" />
                            </AxisY2>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend AutoFitMinFontSize="5" IsTextAutoFit="False" LegendStyle="Column" Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Cantidad de preventivos por mes">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
            </td>
        </tr>
    </table>
</asp:Content>
