<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Rechazos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Rechazos" 
    title="TSE SI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
        <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id_viaje" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True" 
                    SortExpression="ORDEN" />
                <asp:BoundField DataField="FECHA" HeaderText="FECHA" SortExpression="FECHA" />
                <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE" 
                    SortExpression="CLIENTE" />
                <asp:BoundField DataField="RUTA" HeaderText="RUTA" SortExpression="RUTA" />
                <asp:BoundField DataField="VEHÍCULO" HeaderText="VEHÍCULO" 
                    SortExpression="VEHÍCULO" />
                <asp:BoundField DataField="id_viaje" HeaderText="id_viaje" 
                    InsertVisible="False" ReadOnly="True" SortExpression="id_viaje" />
            </Columns>
        </asp:GridView>
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS ORDEN, viajes.fecha_apertura AS FECHA, dbo.empresas.nombre AS CLIENTE, dbo.llave_rutas.ruta AS RUTA, dbo.tipo_vehiculo.descripcion AS VEHÍCULO, viajes.id_viaje FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.tipo_vehiculo ON precios.id_tipo_recurso = dbo.tipo_vehiculo.id_tipo_recurso INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta WHERE viajes.id_viaje=@id_viaje">
            <SelectParameters>
                <asp:QueryStringParameter Name="id_viaje" QueryStringField="id_viaje" />
            </SelectParameters>
        </asp:SqlDataSource>
        <table style="width: 100%" bgcolor="White">
            <tr>
                <td style="width: 61px">
                    <asp:Label ID="lblIdViaje" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="lblOrden" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 61px">
                    Motivo:</td>
                <td>
                    <asp:DropDownList ID="ddlRechazos" runat="server" DataSourceID="SqRechazos" 
                        DataTextField="rechazo" DataValueField="id_tipo_rechazo">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqRechazos" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [id_tipo_rechazo], [rechazo] FROM [tipos_rechazo]">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 61px">
                    Observación:
                </td>
                <td>
                    <asp:TextBox ID="txbDescripcion" runat="server" Height="101px" 
                        TextMode="MultiLine" Width="352px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 61px">
                    <asp:Button ID="btnGuardarRechazo" runat="server" Text="Guardar" onclick="btnGuardarRechazo_Click" OnClientClick="this.value = 'Espere...';" />
                </td>
                <td>
                    <asp:Label ID="lblAnuncio" runat="server"></asp:Label>
                &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" Visible="False">&lt;-- Regresar</asp:LinkButton>
                </td>
            </tr>
        </table>
   
</asp:Content>
