<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlLlegadasListado.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlLlegadasListado" %>
<style type="text/css">

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
</style>
<asp:SqlDataSource ID="sdsTiempos" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    
    SelectCommand="SELECT Ordenes.ano, Ordenes.consecutivo, viajes.num_viaje, detalle_arrivos.nombre, llegadaDestinos.diferencia, dbo.empresas.nombre AS Expr1 FROM llegadaDestinos INNER JOIN viajes ON llegadaDestinos.idViaje = viajes.id_viaje INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden INNER JOIN detalle_arrivos ON llegadaDestinos.idArrivo = detalle_arrivos.id_detalle INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa WHERE (llegadaDestinos.diferencia BETWEEN @inicio AND @fin) AND (DATEPART(month, llegadaDestinos.fecha) = @mes) AND (DATEPART(year, llegadaDestinos.fecha) = @ano)">
    <SelectParameters>
        <asp:Parameter Name="inicio" />
        <asp:Parameter Name="fin" />
        <asp:Parameter Name="mes" />
        <asp:Parameter Name="ano" />
    </SelectParameters>
</asp:SqlDataSource>

<p>
<table class="style1">
    <tr>
        <td class="style2">
            Mes<asp:DropDownList ID="DropDownList1" runat="server">
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
        <td class="style3">
            Año<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </td>
        <td class="style4">
            <asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar" />
        </td>
    </tr>
</table>

    <br />
    <asp:DropDownList ID="ddlLlegadas" runat="server" Height="17px" Width="250px">
        <asp:ListItem Value="0">Antes de Tiempo</asp:ListItem>
        <asp:ListItem Value="1">Retraso 0-15 min</asp:ListItem>
        <asp:ListItem Value="2">Retraso 16-30 min</asp:ListItem>
        <asp:ListItem Value="3">Retraso 30-60 min</asp:ListItem>
        <asp:ListItem Value="4">Retraso 60-120 min</asp:ListItem>
        <asp:ListItem Value="5">Retraso de mas de 120 min</asp:ListItem>
    </asp:DropDownList>
</p>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="sdsTiempos" EnableModelValidation="True">
    <Columns>
        <asp:BoundField DataField="ano" SortExpression="ano" />
        <asp:BoundField DataField="consecutivo" HeaderText="ORDEN" 
            SortExpression="consecutivo" />
        <asp:BoundField DataField="num_viaje" SortExpression="num_viaje" />
        <asp:BoundField DataField="Expr1" HeaderText="EMPRESA" SortExpression="Expr1" />
        <asp:BoundField DataField="nombre" HeaderText="PUNTO" SortExpression="nombre" />
        <asp:BoundField DataField="diferencia" HeaderText="MINUTOS" 
            SortExpression="diferencia" />
    </Columns>
</asp:GridView>

