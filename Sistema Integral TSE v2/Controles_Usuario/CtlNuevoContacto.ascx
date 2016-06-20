<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CtlNuevoContacto.ascx.vb" Inherits="Sistema_Integral_TSE_v45.NuevoContacto" %>



<asp:Panel ID="pnlContacto" runat="server" ScrollBars="Vertical" >
      <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
        <table bgcolor="White" class="style3"  >
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td class="style4">
                    <asp:Button ID="btnNuevo" runat="server" CausesValidation="False" 
                        Text="Nuevo" />
                    &nbsp;
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" 
                        ValidationGroup="contacto" />
                    &nbsp;
                    <asp:Button ID="btnEliminar" runat="server" CausesValidation="False" 
                        Text="Eliminar" />
                    <asp:TextBox ID="txbIdContacto" runat="server" Visible="False"></asp:TextBox>
                    
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Empresa:</td>
                <td class="style4">
                    <asp:DropDownList ID="ddlEmpresa" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsEmpresa" DataTextField="nombre" DataValueField="id_empresa">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsEmpresa" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE (([id_status] = @id_status) AND ([id_tipo_empresa] = @id_tipo_empresa)) ORDER BY [nombre]">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="id_tipo_empresa" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Contacto:</td>
                <td class="style4">
<asp:DropDownList ID="ddlAdminContacto" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsContactos" DataTextField="chofer" DataValueField="id_contacto">
                            </asp:DropDownList>
                    
                    <asp:SqlDataSource ID="sdsContactos" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS chofer, contactos.id_contacto FROM contactos INNER JOIN personas ON contactos.id_persona = personas.id_persona WHERE (contactos.id_empresa = @id_empresa) and personas.id_status=5 ORDER BY personas.primer_nombre">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    
                    <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
                    
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Primer Nombre:</td>
                <td class="style4">
                    <asp:TextBox ID="txbPrimerNombre" runat="server" MaxLength="50" ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Segundo Nombre:</td>
                <td class="style4">
                    <asp:TextBox ID="txbSegundoNombre" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Apellido Paterno:</td>
                <td class="style4">
                    <asp:TextBox ID="txbApellidoPaterno" runat="server" MaxLength="50"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Apellido Materno:</td>
                <td class="style4">
                    <asp:TextBox ID="txbApellidoMaterno" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Télefono:</td>
                <td class="style4">
                    <asp:TextBox ID="txbTelefonoContacto" runat="server" MaxLength="25"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    E-mail:</td>
                <td class="style4">
                    <asp:TextBox ID="txbCorreo" runat="server" MaxLength="50"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txbCorreo" ErrorMessage="Campo Obligatorio" 
                        ValidationGroup="contacto">* El Email es necesario para notificaciones.</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="txbCorreo" ErrorMessage="El correo no es valido." 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    <br />
                </td>
            </tr>
            <tr>
                <td class="style2">
                    Radio:</td>
                <td class="style4">
                    <asp:TextBox ID="txbRadio" runat="server" MaxLength="15"></asp:TextBox>
                </td>
            </tr>
            
            <tr>
                <td class="style2">
                    <asp:Label ID="lblContacto" runat="server" Text=""></asp:Label>
                    &nbsp;</td>
                <td class="style4">
                    &nbsp;</td>
            </tr>
        </table>
     
     <asp:Button ID="btnGuardarContacto" runat="server" Text="Guardar" 
            onclick="btnGuardarContacto_Click" UseSubmitBehavior="false" 
            OnClientClick="this.value = 'Espere...';" ValidationGroup="contacto" />
     
    </asp:Panel>
    
    