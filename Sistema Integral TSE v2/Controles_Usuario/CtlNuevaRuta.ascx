<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CtlNuevaRuta.ascx.vb" Inherits="Sistema_Integral_TSE_v45.NuevaRuta" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Panel ID="pnlRuta" runat="server" ScrollBars="Vertical" Height="400" >
        
        
       
            
        <table style="width: 100%" bgcolor="White">
            <tr>
                <td colspan="2">
                    Configurar Ruta Solicitada</td>
            </tr>
            <tr>
                <td style="width: 187px">
                    Especificación:</td>
                <td style="width: 70%">
                    <asp:TextBox ID="txbEspecificacion" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 187px">
                    Ruta:</td>
                <td style="width: 70%">
                    <asp:DropDownList ID="ddlRuta0" runat="server" DataSourceID="SqlRuta" 
                        DataTextField="ruta" DataValueField="id_ruta">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlRuta" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [ruta], [id_ruta] FROM [rutas] ORDER BY [ruta]">
                    </asp:SqlDataSource>
                    <asp:Button ID="btnNuevaRuta0" runat="server" Text="Nueva..." OnClientClick="$find('mdlChild').show(); return false;" />
                    
                    
                </td>
            </tr>
             <tr>
                <td style="width: 187px">
                    Vehículo:</td>
                <td style="width: 70%">
                    <asp:DropDownList ID="ddlVehiculo" runat="server" DataSourceID="SqlVehiculo" 
                        DataTextField="descripcion" DataValueField="id_tipo_recurso">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlVehiculo" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [id_tipo_recurso], [descripcion] FROM [tipo_vehiculo]">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 187px">
                    Moneda:</td>
                <td style="width: 70%">
                    <asp:DropDownList ID="ddlMoneda" runat="server" DataSourceID="SqlMoneda" 
                        DataTextField="moneda" DataValueField="id_moneda">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlMoneda" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [id_moneda], [moneda] FROM [Moneda]">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 187px">
                    Empresa:</td>
                <td style="width: 70%">
                    <asp:DropDownList ID="ddlEmpresaRuta" runat="server" DataSourceID="EmpresaRuta" 
                        DataTextField="nombre" DataValueField="id_empresa">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="EmpresaRuta" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [id_empresa], [nombre] FROM [empresas] WHERE ([id_empresa] = @id_empresa)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlCliente" Name="id_empresa" 
                                PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 187px">
                    Precio:</td>
                <td style="width: 70%">
                    <asp:TextBox ID="txbPrecio" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 187px">
                    <asp:Button ID="btnGuardarRuta" runat="server" Text="Guardar" OnClick="btnGuardarRuta_Click" OnClientClick="this.value = 'Espere...';" />
                </td>
                <td style="width: 70%">
                    
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblGuardarRuta" runat="server"></asp:Label>
                </td>
            </tr>
        </table>  
        
         <asp:Button ID="btnChildTarget" runat="server" Style="display: none" />
   
    
     <asp:ModalPopupExtender ID="mdlChild" runat="server" TargetControlID="btnNuevaRuta0"
                    PopupControlID="pnlChild" CancelControlID="btnCloseChild" BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>
                   
    <asp:Panel ID="pnlChild" runat="server" Style="display: none; position: absolute; width: 500px;
        border: solid 1px black; height: 400px; background-color: White; margin-left: 50px">
        <table style="width: 100%">
            <tr>
                <td colspan="2">
                    Nueva Ruta</td>
            </tr>
            <tr>
                <td>
                    Ruta:</td>
                <td>
                    <asp:TextBox ID="txbRuta" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Abreviatura:</td>
                <td>
                    <asp:TextBox ID="txbAbre" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Tipo de Ruta:</td>
                <td>
                    <asp:DropDownList ID="ddlTipoRuta" runat="server" DataSourceID="SqlTipoRuta" 
                        DataTextField="tipo_ruta" DataValueField="id_tiporuta">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlTipoRuta" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [id_tiporuta], [tipo_ruta] FROM [tipo_ruta]">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    Kilometros:</td>
                <td>
                    <asp:TextBox ID="txbKms" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Tiempo:</td>
                <td>
                    <asp:TextBox ID="txbTiempo" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnGuardarRuta0" runat="server" Text="Guardar" OnClientClick="this.value = 'Espere...';" />
                </td>
                <td>
                    <asp:Label ID="lblRuta" runat="server"></asp:Label>
                    <asp:Button ID="btnCloseChild" runat="server" Text="Close" OnClientClick="$find('mdlChild').hide(); return false;" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    
    </asp:Panel>
        
    
    </asp:Panel>