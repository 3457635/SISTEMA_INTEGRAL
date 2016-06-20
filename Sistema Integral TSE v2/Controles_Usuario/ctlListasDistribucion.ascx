<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlListasDistribucion.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlListasDistribucion" %>


<p>
    <br />
    Listas de distribución para seguimiento:</p>
<table class="style1">
    <tr>
        <td class="style2">
            Cliente:</td>
        <td>
            <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsClientes" 
                DataTextField="nombre" DataValueField="id_empresa" AutoPostBack="True">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsClientes" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT nombre, id_empresa FROM dbo.empresas WHERE (id_status = 5) AND (id_tipo_empresa = 1) ORDER BY nombre">
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Lista de Distribución:</td>
        <td>
            <asp:DropDownList ID="ddlListaDistribucion" runat="server" 
                DataSourceID="sdsListas" DataTextField="lista" DataValueField="id_lista">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsListas" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT [lista], [id_lista] FROM [lista_distribucion_seguimiento] WHERE ([id_emprea] = @id_emprea)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlCliente" Name="id_emprea" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:TextBox ID="txbLista" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Contactos:</td>
        <td>
            <asp:TextBox ID="txbContactos" runat="server" Height="182px" 
                TextMode="MultiLine" Width="545px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Servicios en los que se enviara la notificación.</td>
        <td>
            <asp:CheckBox ID="ckbTodos" runat="server" Text="Seleccionar Todo" />
            <asp:CheckBoxList ID="CheckBoxList1" runat="server" DataSourceID="sdsServicios" 
                DataTextField="servicio" DataValueField="id_relacion">
            </asp:CheckBoxList>
            <asp:SqlDataSource ID="sdsServicios" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                
                SelectCommand="SELECT dbo.llave_rutas.ruta + ' ~ ' + tipo_equipos.equipo AS servicio, precios.id_relacion FROM precios INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo WHERE (precios.id_empresa = @id_empresa) AND (precios.id_status = 5) ORDER BY dbo.llave_rutas.ruta">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlCliente" Name="id_empresa" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
</table>

