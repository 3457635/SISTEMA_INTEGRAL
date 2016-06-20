<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="tableroIngresos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.tableroIngresos" %>

<%@ Register Src="../../Controles_Usuario/ctlGraficaCartera.ascx" TagName="ctlGraficaCartera" TagPrefix="uc1" %>
<%@ Register Src="../../Controles_Usuario/ctlGraficaCarteraVencida.ascx" TagName="ctlGraficaCarteraVencida" TagPrefix="uc2" %>
<%@ Register Src="../../Controles_Usuario/ctlIngresosPorCliente.ascx" TagName="ctlIngresosPorCliente" TagPrefix="uc3" %>
<%@ Register Src="../../Controles_Usuario/ctlGraficaCarteraGlobal.ascx" TagName="ctlGraficaCartera" TagPrefix="uc4" %>
<%--<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Ingresos </h1>
    <asp:WebPartManager ID="WebPartManager1" runat="server">
    </asp:WebPartManager>

    <asp:SqlDataSource ID="sdsDuracion" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="select 
                    avg(diferenciaFactura) promedio,
                     nombre 
                    from 
                    duracionDeProceso(@mes,@ano,@tipoFechaFactura) 
                    group by  
                    nombre 
                    order by 
                    promedio"
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMesDuracion" Name="mes"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txbAnoDuracion" Name="ano"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlFactura" Name="tipoFechaFactura"
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <strong>Promedio de dias transcurridos hasta el día de pago.</strong><br />
    Año 
        <asp:TextBox ID="txbAnoDuracion" runat="server"></asp:TextBox>
    &nbsp; Mes
    <asp:DropDownList ID="ddlMesDuracion" runat="server" Height="16px"
        Width="139px">
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

    &nbsp; Desde
        <asp:DropDownList ID="ddlFactura" runat="server" Height="17px" Width="130px">
            <asp:ListItem Value="4">Fecha Factura</asp:ListItem>
            <asp:ListItem Value="5">Contrarecibo</asp:ListItem>
            <asp:ListItem Value="6">Programación de Pago</asp:ListItem>
        </asp:DropDownList>
    &nbsp;
        <asp:Button ID="btnConsultar" runat="server" Text="Consulta" />

    &nbsp;
                <asp:Chart ID="Chart6" runat="server" BorderlineColor="Black"
                    BorderlineWidth="0" DataSourceID="sdsDuracion" Height="304px"
                    Palette="None" RightToLeft="No" Width="1420px">
                    <Series>
                        <asp:Series ChartArea="ChartArea1" IsValueShownAsLabel="True"
                            LabelFormat="{0:n0}" Legend="Legend1" Name="Cliente" XValueMember="nombre"
                            YValueMembers="Promedio" Color="Gray">
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

    <uc4:ctlGraficaCartera ID="ctlGraficaCartera2" runat="server" />
    <p>
        <asp:WebPartZone ID="WebPartZone3" runat="server">
            <ZoneTemplate>
            </ZoneTemplate>
        </asp:WebPartZone>
    </p>
    <p>
        <asp:WebPartZone ID="WebPartZone1" runat="server">
            <ZoneTemplate>
                <uc2:ctlGraficaCarteraVencida ID="ctlGraficaCarteraVencida1" title="Cartera vencida por mes." runat="server" />
            </ZoneTemplate>
        </asp:WebPartZone>
    </p>
    <asp:WebPartZone ID="WebPartZone2" runat="server">
        <ZoneTemplate>
            <uc1:ctlGraficaCartera ID="ctlGraficaCartera1" title="Cartera por mes." runat="server" />
        </ZoneTemplate>
    </asp:WebPartZone>
</asp:Content>
