<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CtlNuevaEmpresa.ascx.vb" Inherits="Sistema_Integral_TSE_v45.Nuevo_" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
            
      

            
      
<style type="text/css">
    .style1
    {
        color: #336600;
    }
    .style3
    {
        width: 191px;
    }
</style>
            


        <asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical" >
    
        <table bgcolor="White" >
            <tr>
                <td  >
                    <asp:Button ID="btnNuevo" runat="server" Text="Nueva Empresa" 
                        CausesValidation="False" SkinID="btn" />
                </td>
                <td  >
                    <asp:Button ID="btnGuardarCliente" runat="server" 
                        onclick="btnGuardarCliente_Click" OnClientClick="this.value = 'Espere...';" 
                        Text="Guardar Empresa" SkinID="btn" ValidationGroup="empresa" />
                </td>
                <td  >
                    <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" 
                        CausesValidation="False" SkinID="btn" />
                </td>
            </tr>
            <tr>
                <td  >
                    Empresa:</td>
                <td   colspan="2">
                    <asp:DropDownList ID="ddlEmpresa" runat="server" 
                        AutoPostBack="True" DataSourceID="SqlDataSource1" DataTextField="nombre" 
                        DataValueField="id_empresa" Height="16px" Width="187px">
                        <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE (([id_tipo_empresa] = @id_tipo_empresa) AND ([id_status] = @id_status)) ORDER BY [nombre]">
                        <SelectParameters>
                            <asp:SessionParameter DefaultValue="0" Name="id_tipo_empresa" 
                                SessionField="tipo_empresa" Type="Int32" />
                            <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td  >
                    Nombre Corto:</td>
                <td   colspan="2">
                    <asp:TextBox ID="txbNombre" runat="server" Width="197px" 
                        ValidationGroup="empresa"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" 
                        ControlToValidate="txbNombre" ErrorMessage="Campo Obligatorio" 
                        ValidationGroup="empresa">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td  >
                    <asp:CheckBox ID="ckbFrecuente" runat="server" Text="Frecuente" />
                </td>
                <td   colspan="2">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style1" colspan="3">
                    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
                    <asp:TextBox ID="txbIdEmpresa" runat="server" Visible="False"></asp:TextBox>
                    <asp:Label ID="lblGuardarCliente" runat="server" SkinID="lblMensaje"></asp:Label>
                </td>
            </tr>
            <tr>
                <td  >
                    <asp:Button ID="btnNuevoDato" runat="server" SkinID="btn" 
                        Text="Agregar Razón Social" Width="167px" />
                </td>
                <td   colspan="2">
                    <asp:Button ID="btnGuardarDato" runat="server" SkinID="btn" Text="Guardar Razón Social" 
                        ValidationGroup="datos" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnEliminarDato" runat="server" SkinID="btn" Text="Eliminar" />
                </td>
            </tr>
            <tr>
                <td  >
                    Razon Social:</td>
                <td   colspan="2">
                    <asp:DropDownList ID="ddlRazonSocial" runat="server" AutoPostBack="True" 
                        DataSourceID="sdsRazonSocial" DataTextField="razon_social" 
                        DataValueField="id_dato" Width="180px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsRazonSocial" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        SelectCommand="SELECT [razon_social], [id_dato] FROM [datos_facturacion] WHERE (([id_empresa] = @id_empresa) AND ([idEstatus] = @idEstatus))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                                PropertyName="SelectedValue" Type="Int32" />
                            <asp:Parameter DefaultValue="5" Name="idEstatus" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td  >
                    Razón Social:
                </td>
                <td   colspan="2">
                    <asp:TextBox ID="txbRazon" runat="server" MaxLength="100" Width="197px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txbRazon" ErrorMessage="Campo Requerido" 
                        ValidationGroup="datos">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td  >
                    Calle:</td>
                <td   colspan="2">
                    <asp:TextBox ID="txbCalle" runat="server" Width="197px" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txbCalle" ErrorMessage="Campo Requerido" 
                        ValidationGroup="datos">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td  >
                    No. Exterior:</td>
                <td   colspan="2">
                    <asp:TextBox ID="txbNoExterior" runat="server" Width="197px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="txbNoExterior" ErrorMessage="Campo Requerido" 
                        ValidationGroup="datos">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td  >
                    Colonia:</td>
                <td   colspan="2">
                    <asp:TextBox ID="txbColonia" runat="server" Width="197px" MaxLength="100"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td  >
                    Municipio:</td>
                <td   colspan="2">
                    <asp:TextBox ID="txbMunicipio" runat="server" MaxLength="100" Width="197px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="txbMunicipio" ErrorMessage="Campo Requerido" 
                        ValidationGroup="datos">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td  >
                    Estado:</td>
                <td   colspan="2">
                    <asp:TextBox ID="txbEstado" runat="server" Width="197px" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="txbEstado" ErrorMessage="Campo Requerido" 
                        ValidationGroup="datos">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td  >
                    Pais:</td>
                <td   colspan="2">
                    <asp:TextBox ID="txbPais" runat="server" Width="197px">México</asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="txbPais" ErrorMessage="Campo Requerido" 
                        ValidationGroup="datos">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td  >
                    Codigo Postal:</td>
                <td  >
                    <asp:TextBox ID="txbCP" runat="server" MaxLength="5"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ControlToValidate="txbCP" ErrorMessage="Campo Requerido" 
                        ValidationGroup="datos">*</asp:RequiredFieldValidator>
                </td>
                <td  >
                    &nbsp;</td>
            </tr>
            <tr>
                <td  >
                    Télefono:</td>
                <td  >
                    <asp:TextBox ID="txbTelefono" runat="server" MaxLength="15"></asp:TextBox>
                </td>
                <td  >
                    &nbsp;</td>
            </tr>
            <tr>
                <td  >
                    Fax:</td>
                <td  >
                    <asp:TextBox ID="txbFax" runat="server" MaxLength="15"></asp:TextBox>
                </td>
                <td  >
                    &nbsp;</td>
            </tr>
            <tr>
                <td  >
                    RFC:</td>
                <td  >
                    <asp:TextBox ID="txbRFC" runat="server" MaxLength="15"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" 
                        ControlToValidate="txbRFC" ErrorMessage="Campo Requerido" 
                        ValidationGroup="datos">*</asp:RequiredFieldValidator>
                </td>
                <td  >
                    &nbsp;</td>
            </tr>
            <tr>
                <td  >
                    Tipo de cambio para factura:</td>
                <td  >
                    <asp:TextBox ID="txbTC" runat="server"></asp:TextBox>
                </td>
                <td  >
                    &nbsp;</td>
            </tr>
            <tr>
                <td  >
                    Dias de credito otorgados</td>
                <td  >
                    <asp:TextBox ID="txbDiasCredito" runat="server">30</asp:TextBox>
                </td>
                <td  >
                    &nbsp;</td>
            </tr>
            <tr>
                <td  >
                    ¿Se le aplica retención?</td>
                <td  >
                    <asp:CheckBox ID="ckbRetencion" runat="server" />
                </td>
                <td  >
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:TextBox ID="txbIdDato" runat="server" Visible="False"></asp:TextBox>
                </td>
            </tr>
        </table>
           
    
    </asp:Panel>