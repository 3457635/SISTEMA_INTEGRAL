<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlCuentasSeguimiento.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlCuentasSeguimiento" %>
<style type="text/css">
    .style1
    {}
    .style3
    {
        width: 45px;
    }
</style>
<table class="style1">
    <tr>
        <td class="style3">
    Cliente:
        </td>
        <td>
    <asp:DropDownList ID="ddlCliente" runat="server" AutoPostBack="True" 
        DataSourceID="sdsCliente" DataTextField="nombre" DataValueField="id_empresa" 
        Width="179px">
    </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="style3">
    Ruta:</td>
        <td>
    <asp:DropDownList ID="ddlRuta" runat="server" DataSourceID="sdsRutas" 
        DataTextField="ruta" DataValueField="id_ruta" AutoPostBack="True" Width="179px">
    </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="style3">
    Lista:
        </td>
        <td>
    <asp:DropDownList ID="ddlLista" runat="server" DataSourceID="sdsLista" 
        DataTextField="nombreLista" DataValueField="idLista" Height="17px" 
        Width="179px">
    </asp:DropDownList>
        </td>
    </tr>
</table>
<p>
    <asp:SqlDataSource ID="sdsCliente" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE (([id_status] = @id_status) AND ([id_tipo_empresa] = @id_tipo_empresa)) ORDER BY [nombre]">
        <SelectParameters>
            <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="id_tipo_empresa" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsRutas" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT DISTINCT dbo.llave_rutas.ruta, dbo.llave_rutas.id_ruta FROM dbo.llave_rutas INNER JOIN precios ON dbo.llave_rutas.id_ruta = precios.id_ruta WHERE (precios.id_empresa = @id_empresa) and precios.id_status=5 order by llave_rutas.ruta">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCliente" Name="id_empresa" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsLista" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT [nombreLista], [idLista] FROM [listaDistribucion] WHERE ([idStatus] = @idStatus)">
        <SelectParameters>
            <asp:Parameter DefaultValue="5" Name="idStatus" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>
<p>
    &nbsp;<asp:Button ID="btnAsignar" runat="server" Text="Asignar" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
</p>
<p>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="sdsContactos" EnableModelValidation="True" 
        DataKeyNames="idGrupo">
        <Columns>
            <asp:CommandField DeleteText="Borrar" EditText="Modificar" 
                ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="idGrupo" 
                SortExpression="idGrupo" InsertVisible="False" ReadOnly="True" >
            <ItemStyle Font-Size="0pt" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="EMPRESA" SortExpression="nombreLista">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="sdsLista2" 
                        DataTextField="nombreLista" DataValueField="idLista" 
                        SelectedValue='<%# Bind("idLista") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsLista2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [nombreLista], [idLista] FROM [listaDistribucion] ORDER BY [nombreLista]">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsLista1" 
                        DataTextField="nombreLista" DataValueField="idLista" Enabled="False" 
                        SelectedValue='<%# Bind("idLista") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsLista1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [idLista], [nombreLista] FROM [listaDistribucion]">
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsContactos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        DeleteCommand="DELETE FROM [contactosServicio] WHERE [idGrupo] = @idGrupo" 
        InsertCommand="INSERT INTO [contactosServicio] ([idLista]) VALUES (@idLista)" 
        SelectCommand="SELECT DISTINCT contactosServicio.idGrupo, listaDistribucion.idLista FROM contactosServicio INNER JOIN listaDistribucion ON contactosServicio.idLista = listaDistribucion.idLista INNER JOIN precios ON contactosServicio.id_relacion = precios.id_relacion WHERE (precios.id_empresa = @idEmpresa) AND (precios.id_ruta = @id_ruta)" 
        
        UpdateCommand="UPDATE [contactosServicio] SET [idLista] = @idLista WHERE [idGrupo] = @idGrupo">
        <DeleteParameters>
            <asp:Parameter Name="idGrupo" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="idLista" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCliente" Name="idEmpresa" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ddlRuta" Name="id_ruta" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="idLista" Type="Int32" />
            <asp:Parameter Name="idGrupo" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>

