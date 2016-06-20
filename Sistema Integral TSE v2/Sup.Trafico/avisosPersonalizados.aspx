<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="avisosPersonalizados.aspx.vb" Inherits="Sistema_Integral_TSE_v45.avisosPersonalizados" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style5
        {
            width: 396px;
        }
        .style6
        {
            width: 68px;
        }
        .style7
        {
            width: 318px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
    </p>
    <table class="style5">
        <tr>
            <td class="style6">
                Empresa:</td>
            <td class="style7">
                <asp:DropDownList ID="ddlEmpresa" runat="server" AutoPostBack="True" 
                    DataSourceID="sdsEmpresas" DataTextField="nombre" DataValueField="id_empresa" 
                    Width="150px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsEmpresas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE (([id_status] = @id_status) AND ([id_tipo_empresa] = @id_tipo_empresa)) ORDER BY [nombre]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                        <asp:Parameter DefaultValue="1" Name="id_tipo_empresa" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="style7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style6">
                Ruta:</td>
            <td class="style7">
                <asp:DropDownList ID="ddlRuta" runat="server" AutoPostBack="True" 
                    DataSourceID="sdsRutas" DataTextField="ruta" DataValueField="id_ruta" 
                    Width="318px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsRutas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT DISTINCT dbo.llave_rutas.ruta, dbo.llave_rutas.id_ruta FROM dbo.llave_rutas INNER JOIN precios ON dbo.llave_rutas.id_ruta = precios.id_ruta WHERE (precios.id_empresa = @id_empresa) AND (precios.id_status = 5) ORDER BY dbo.llave_rutas.ruta">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="style7">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style6">
                &nbsp;</td>
            <td class="style7">
                <asp:CheckBoxList ID="ckbUbicaciones" runat="server">
                </asp:CheckBoxList>
            </td>
            <td valign="top" >
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="NotificacionId" DataSourceID="sdsPuntosPersonalizadas" 
                    EnableModelValidation="True" SkinID="GridView1">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="NotificacionId" InsertVisible="False" 
                            ReadOnly="True" SortExpression="NotificacionId">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ubicacion" HeaderText="Punto de Aviso" 
                            SortExpression="ubicacion" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsPuntosPersonalizadas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    DeleteCommand="DELETE FROM [notificacionesPersonalizadas] WHERE [NotificacionId] = @NotificacionId" SelectCommand="SELECT ubicaciones.ubicacion, notificacionesPersonalizadas.NotificacionId FROM ubicaciones INNER JOIN notificacionesPersonalizadas ON ubicaciones.id_principal = notificacionesPersonalizadas.UbicacionId
where EmpresaId=@empresaId and RutaId=@rutaId">
                    <DeleteParameters>
                        <asp:Parameter Name="NotificacionId" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlEmpresa" Name="empresaId" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlRuta" Name="rutaId" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style6">
                &nbsp;</td>
            <td class="style7">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
                <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
            </td>
            <td class="style7">
                &nbsp;</td>
        </tr>
    </table>
    <p>
    </p>
</asp:Content>
