<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ViajesOptimizados.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ViajesOptimizados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Viajes optimizados</h1>
    <table>
        <tr><td>
            <asp:Label ID="Label1" runat="server" Text="Fecha inicio"></asp:Label>
            <asp:TextBox ID="txtFechaInicio" runat="server"></asp:TextBox>
            <asp:Label ID="Label2" runat="server" Text="Fecha fin"></asp:Label>
            <asp:TextBox ID="txtFechaFin" runat="server"></asp:TextBox>
            <asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
            </td></tr>
        <tr><td>
            <asp:SqlDataSource ID="sdsViajesOptimizados" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="select distinct Consecutivo, nombre as Cliente,fecha, Ruta, Economico, primer_nombre as Nombre,apellido_paterno as Apellido, fs.total as facturado
from vista_kmsunidad 
join facturacion f on f.id_viaje = vista_kmsunidad.id_viaje
join facturas fs on f.id_factura = fs.id_factura
where optimizado = 1 and  tipo_fecha =1"></asp:SqlDataSource>
            <asp:Chart ID="Chart1" runat="server" Visible="False" Width="486px">
                <Series>
                    <asp:Series Name="Series1" YValuesPerPoint="2">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="sdsViajesOptimizados" SkinID="GridViewGreen">
                <Columns>
                    <asp:BoundField DataField="Consecutivo" HeaderText="Consecutivo" SortExpression="Consecutivo" />
                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                    <asp:BoundField DataField="fecha" HeaderText="fecha" SortExpression="fecha" />
                    <asp:BoundField DataField="Ruta" HeaderText="Ruta" SortExpression="Ruta" />
                    <asp:BoundField DataField="Economico" HeaderText="Economico" SortExpression="Economico" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                    <asp:BoundField DataField="Apellido" HeaderText="Apellido" SortExpression="Apellido" />
                    <asp:BoundField DataField="facturado" DataFormatString="{0:c}" HeaderText="facturado" SortExpression="facturado" />
                </Columns>
            </asp:GridView>
            </td></tr>


    </table>
</asp:Content>
