<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ubicaciones.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ubicaciones" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1>Ubicaciones</h1>
    <table style="width: 525px">
        <tr>
            <td style="width: 128px">
                Ubicacion</td>
            <td style="width: 128px">
                Tiempo</td>
            <td style="width: 123px">
                Tipo_Ubicacion</td>
            <td style="width: 128px">
                Rama</td>
            <td style="width: 128px">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 128px">
                <asp:TextBox ID="txbUbicacion" runat="server"></asp:TextBox>
            </td>
            <td style="width: 128px">
                <asp:TextBox ID="txbTiempo" runat="server"></asp:TextBox>
            </td>
            <td style="width: 123px">
                <asp:DropDownList ID="ddlTipoUbicacion" runat="server" 
                    DataSourceID="sqlTipoUbicacion" DataTextField="descripcion" 
                    DataValueField="id_tipo_ubicacion">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sqlTipoUbicacion" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [descripcion], [id_tipo_ubicacion] FROM [tipo_ubicacion]">
                </asp:SqlDataSource>
            </td>
            <td style="width: 128px">
                <asp:TextBox ID="txbPosicion" runat="server"></asp:TextBox>
            </td>
            <td style="width: 128px">
                <asp:RadioButtonList ID="rbtnNotificacion" runat="server">
                    <asp:ListItem Value="1">Notificar al Cliente</asp:ListItem>
                    <asp:ListItem Selected="True" Value="0">Sin Notificacion</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
    </table>
    <asp:Button ID="Button1" runat="server" SkinID="btn" Text="Guardar" />
    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id_principal" DataSourceID="sdsUbicaciones" 
        EnableModelValidation="True" SkinID="GridView1">
        <Columns>
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
            <asp:BoundField DataField="id_principal" InsertVisible="False" ReadOnly="True" 
                SortExpression="id_principal">
            <ItemStyle Font-Size="0pt" />
            </asp:BoundField>
            <asp:BoundField DataField="ubicacion" HeaderText="Ubicacion" 
                SortExpression="ubicacion" />
            <asp:BoundField DataField="tiempo" HeaderText="Tiempo" 
                SortExpression="tiempo" />
            <asp:BoundField DataField="id_tipo_ubicacion" HeaderText="Tipo Ubicacion" 
                SortExpression="id_tipo_ubicacion" />
            <asp:BoundField DataField="id_ubicacion" HeaderText="Rama" 
                SortExpression="id_ubicacion" />
            <asp:TemplateField HeaderText="Estatus" SortExpression="id_status">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList3" runat="server" 
                        SelectedValue='<%# Bind("id_status") %>'>
                        <asp:ListItem Value="2">Activado</asp:ListItem>
                        <asp:ListItem Value="3">Desactivado</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" Enabled="False" 
                        SelectedValue='<%# Bind("id_status") %>' 
                        >
                        <asp:ListItem Value="2">Activo</asp:ListItem>
                        <asp:ListItem Value="3">Desactivado</asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Image ID="imgEstatus" runat="server" ImageUrl="~/imagenes/cancel.png" 
                        Visible="False" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Notificar">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList5" runat="server" 
                        SelectedValue='<%# Bind("notificacion_cliente") %>'>
                        <asp:ListItem Value="True">Activar</asp:ListItem>
                        <asp:ListItem Value="False">Desactivar</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList4" runat="server" Enabled="False" 
                        SelectedValue='<%# Bind("notificacion_cliente") %>'>
                        <asp:ListItem Value="True">Activar</asp:ListItem>
                        <asp:ListItem Value="False">Desactivar</asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Image ID="imgNotificacion" runat="server" ImageUrl="~/imagenes/ok.png" 
                        Visible="False" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BorderColor="Yellow" />
        <SelectedRowStyle BackColor="Yellow" />
    </asp:GridView>
    <asp:SqlDataSource ID="sdsUbicaciones" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        DeleteCommand="DELETE FROM [ubicaciones] WHERE [id_principal] = @id_principal" 
        InsertCommand="INSERT INTO [ubicaciones] ([ubicacion], [tiempo], [id_tipo_ubicacion], [id_ubicacion], [id_status], [notificacion_cliente]) VALUES (@ubicacion, @tiempo, @id_tipo_ubicacion, @id_ubicacion, @id_status, @notificacion_cliente)" 
        SelectCommand="SELECT * FROM [ubicaciones] ORDER BY [id_ubicacion]" 
        
        
        UpdateCommand="UPDATE [ubicaciones] SET [ubicacion] = @ubicacion, [tiempo] = @tiempo, [id_tipo_ubicacion] = @id_tipo_ubicacion, [id_ubicacion] = @id_ubicacion, [id_status] = @id_status, [notificacion_cliente] = @notificacion_cliente WHERE [id_principal] = @id_principal">
        <DeleteParameters>
            <asp:Parameter Name="id_principal" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ubicacion" Type="String" />
            <asp:Parameter Name="tiempo" Type="Int32" />
            <asp:Parameter Name="id_tipo_ubicacion" Type="Int32" />
            <asp:Parameter Name="id_ubicacion" Type="Int32" />
            <asp:Parameter Name="id_status" Type="Int32" />
            <asp:Parameter Name="notificacion_cliente" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ubicacion" Type="String" />
            <asp:Parameter Name="tiempo" Type="Int32" />
            <asp:Parameter Name="id_tipo_ubicacion" Type="Int32" />
            <asp:Parameter Name="id_ubicacion" Type="Int32" />
            <asp:Parameter Name="id_status" Type="Int32" />
            <asp:Parameter Name="notificacion_cliente" Type="Boolean" />
            <asp:Parameter Name="id_principal" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
