<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlModificarRecursos.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlModificarRecursos" %>
<h1>Ordenes Abiertas</h1>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="id_equipo_asignado" DataSourceID="sdsOrdenesAbiertas" 
    EnableModelValidation="True" SkinID="GridView1">
    <Columns>
        <asp:CommandField ShowEditButton="True" />
        <asp:BoundField DataField="id_equipo_asignado" InsertVisible="False" 
            SortExpression="id_equipo_asignado">
        <ItemStyle Font-Size="0pt" />
        </asp:BoundField>
        <asp:BoundField DataField="orden" HeaderText="ORDEN" ReadOnly="True" 
            SortExpression="orden" />
        <asp:BoundField DataField="nombre" HeaderText="NOMBRE" 
            SortExpression="nombre" />
        <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
        <asp:BoundField DataField="primer_nombre" HeaderText="CHOFER" 
            SortExpression="primer_nombre" />
        <asp:BoundField DataField="apellido_paterno" 
            SortExpression="apellido_paterno" />
        <asp:TemplateField HeaderText="UNIDAD" InsertVisible="False" 
            SortExpression="id_equipo">
            <ItemTemplate>
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsEquipos" 
                    DataTextField="economico" DataValueField="id_equipo" Enabled="False" 
                    Height="18px" SelectedValue='<%# Bind("id_equipo") %>' Width="136px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsEquipos" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_tipo_equipo] &lt; @id_tipo_equipo) AND ([id_status] = @id_status)) ORDER BY [economico]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="107" Name="id_tipo_equipo" Type="Int32" />
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="sdsEquipos" 
                    DataTextField="economico" DataValueField="id_equipo" 
                    SelectedValue='<%# Bind("id_equipo") %>'>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsEquipos" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_status] = @id_status) AND ([id_tipo_equipo] &lt; @id_tipo_equipo)) ORDER BY [economico]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                        <asp:Parameter DefaultValue="107" Name="id_tipo_equipo" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </EditItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

<asp:SqlDataSource ID="sdsOrdenesAbiertas" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    DeleteCommand="DELETE FROM [equipo_asignado] WHERE [id_equipo_asignado] = @id_equipo_asignado" 
    InsertCommand="INSERT INTO [equipo_asignado] ([id_equipo], [id_asignacion]) VALUES (@id_equipo, @id_asignacion)" 
    SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS orden, dbo.empresas.nombre, dbo.llave_rutas.ruta, personas.primer_nombre, personas.apellido_paterno, equipo_operacion.id_equipo, equipo_asignado.id_equipo_asignado FROM equipo_asignado INNER JOIN recursos_asignados ON equipo_asignado.id_asignacion = recursos_asignados.id_asignacion INNER JOIN viajes ON recursos_asignados.id_viaje = viajes.id_viaje INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden INNER JOIN equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo INNER JOIN empleados ON recursos_asignados.id_empleado = empleados.id_empleado INNER JOIN personas ON empleados.id_persona = personas.id_persona INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta WHERE (viajes.id_status = 2) AND (equipo_operacion.id_tipo_equipo &lt; 107) ORDER BY Ordenes.consecutivo" 
    UpdateCommand="UPDATE [equipo_asignado] SET [id_equipo] = @id_equipo WHERE [id_equipo_asignado] = @id_equipo_asignado">
    <DeleteParameters>
        <asp:Parameter Name="id_equipo_asignado" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="id_equipo" Type="Int32" />
        <asp:Parameter Name="id_asignacion" Type="Int32" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="id_equipo" Type="Int32" />
        <asp:Parameter Name="id_asignacion" Type="Int32" />
        <asp:Parameter Name="id_equipo_asignado" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>


