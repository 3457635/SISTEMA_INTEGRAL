<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlLlegadasTiempo.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlLlegadasTiempo" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>

<style type="text/css">
    .style1
    {}
    .style2
    {
        width: 92px;
    }
    .style3
    {
        width: 128px;
    }
    .style4
    {
        width: 61px;
    }
    .style5
    {
        width: 100%;
    }
</style>
<table class="style1">
    <tr>
        <td class="style2">
            Año<asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
        </td>
        <td class="style3">
            Mes
            <asp:DropDownList ID="ddlMes" runat="server" Height="17px" Width="114px">
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
        </td>
        <td class="style4">
            <asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar" />
        </td>
    </tr>
</table>

<p>
    <br />
    <table class="style5">
        <tr>
            <td>
                Arribos distribuidos por tiempo de llegada.</td>
            <td>
                Distribución de llegadas tarde por cliente con mas de 2 hrs. de retraso.</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
    <asp:Chart ID="Chart7" runat="server" DataSourceID="sdsTiempos" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
                            <series>
                                <asp:Series ChartArea="ChartArea1" Name="Arribos" 
                    IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" XValueMember="Rango" YValueMembers="Arribos" 
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
                                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" 
                    Name="Legend1" BackColor="Transparent" DockedToChartArea="ChartArea1" Docking="Left">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                   


                </td>
            <td>
    <asp:Chart ID="Chart8" runat="server" DataSourceID="sdsLlegadasPorCliente" 
            Height="424px" Width="726px" BorderlineColor="Black" 
        BorderlineWidth="0" Palette="None" RightToLeft="No">
                            <series>
                                <asp:Series ChartArea="ChartArea1" Name="Arribos" 
                    IsValueShownAsLabel="True" LabelFormat="{0:n0}" 
                    Legend="Legend1" XValueMember="nombre" YValueMembers="llegadasADestiempo" 
                    Font="Microsoft Sans Serif, 8pt, style=Bold" ChartType="Area" Color="192, 192, 0">
                                </asp:Series>
                            </series>
                            <chartareas>
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
                            </chartareas>
                            <Legends>
                                <asp:Legend Font="Microsoft Sans Serif, 8pt, style=Bold" 
                    Name="Legend1" BackColor="Transparent" DockedToChartArea="ChartArea1" Docking="Left">
                                </asp:Legend>
                            </Legends>
                        </asp:Chart>
                   


                <asp:SqlDataSource ID="sdsEnTiempo" runat="server"></asp:SqlDataSource>
                   


                </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
                   


                </p>
<asp:SqlDataSource ID="sdsTiempos" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="Llegadas" SelectCommandType="StoredProcedure" 
    ProviderName="<%$ ConnectionStrings:tse-erpConnectionString2.ProviderName %>">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbAno" Name="nAño" PropertyName="Text" 
            Type="Int32" />
        <asp:ControlParameter ControlID="ddlMes" Name="nMes" 
            PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

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
        <asp:ControlParameter ControlID="txbAno" Name="ano" PropertyName="Text" />
        <asp:ControlParameter ControlID="ddlMes" Name="mes" 
            PropertyName="SelectedValue" />
        <asp:Parameter DefaultValue="Con Arribo" Name="tipo" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sdsListado" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    
    
    SelectCommand="detalleLlegadasDestino" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="txbAno" Name="ano" PropertyName="Text" />
        <asp:ControlParameter ControlID="ddlMes" Name="mes" 
            PropertyName="SelectedValue" />
        <asp:Parameter Name="tipo" Type="String" />
        <asp:Parameter Name="inicio" />
        <asp:Parameter Name="fin" />
    </SelectParameters>
</asp:SqlDataSource>

<p>
    <br />
    Listado de ordenes con retraso;</p>
<p>
    <asp:DropDownList ID="ddlLlegadas" runat="server" Height="17px" Width="250px">
        <asp:ListItem Value="0">Antes de Tiempo</asp:ListItem>
        <asp:ListItem Value="1">Entre 0 y 60 minutos</asp:ListItem>
        <asp:ListItem Value="2">Entre 61 y 120 minutos</asp:ListItem>
        <asp:ListItem Value="3">Mas de 120 minutos</asp:ListItem>
        <asp:ListItem Value="4">Locales</asp:ListItem>
        <asp:ListItem Value="5">Sin Arribo</asp:ListItem>
    </asp:DropDownList>
            <asp:Button ID="btnBuscarListado" runat="server" SkinID="btn" 
        Text="Buscar" />
        <br />
</p>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="sdsListado" EnableModelValidation="True">
    <Columns>
        <asp:BoundField DataField="consecutivo" SortExpression="consecutivo" 
            HeaderText="ORDEN" />
        <asp:BoundField DataField="nombre" HeaderText="EMPRESA" 
            SortExpression="nombre" />
        <asp:BoundField DataField="ruta" SortExpression="ruta" HeaderText="RUTA" />
        <asp:BoundField DataField="punto" HeaderText="DESTINO" SortExpression="punto" />
        <asp:BoundField DataField="fechaEstablecida" HeaderText="ARRIBO PROGRAMADO" 
            SortExpression="fechaEstablecida" />
        <asp:BoundField DataField="fechaArrivo" HeaderText="ARRIBO" 
            SortExpression="fechaArrivo" />
        <asp:BoundField DataField="Diferencia" HeaderText="MINUTOS" 
            SortExpression="Diferencia" />
    </Columns>
</asp:GridView>



