<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="viaje_con_carga.aspx.vb" Inherits="Sistema_Integral_TSE_v45.viaje_con_carga" 
    title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id_orden" DataSourceID="SqlDataSource3" 
        EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True" 
                SortExpression="ORDEN" />
            <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE" 
                SortExpression="CLIENTE" />
            <asp:BoundField DataField="RUTA" HeaderText="RUTA" SortExpression="RUTA" />
            <asp:BoundField DataField="CHOFER" HeaderText="CHOFER" ReadOnly="True" 
                SortExpression="CHOFER" />
            <asp:BoundField DataField="id_orden" HeaderText="id_orden" 
                SortExpression="id_orden" InsertVisible="False" ReadOnly="True" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        
        
        SelectCommand="infoOrden" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="id_orden" QueryStringField="id_orden" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table style="width: 362px">
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 177px">
                Orden de Servicio:</td>
            <td style="width: 173px">
                <asp:Label ID="lblViaje" runat="server"></asp:Label>
&nbsp;<asp:Label ID="lblOrden" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 177px">
                Empresa:</td>
                                    <td style="width: 173px">
                                        <asp:DropDownList ID="ddlEmpresa" runat="server" DataSourceID="SqlEmpresa" 
                                            DataTextField="nombre" DataValueField="id_empresa" AutoPostBack="True">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlEmpresa" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                            
                                            
                                            
                                            SelectCommand="SELECT [id_empresa], [nombre] FROM [empresas] WHERE id_status=5 and id_tipo_empresa=1 ORDER BY [nombre]">
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 177px">
                                        Contacto:</td>
                                    <td style="width: 173px">
                                        <asp:DropDownList ID="ddlContacto" runat="server" DataSourceID="SqlContactos" 
                                            DataTextField="contacto" DataValueField="id_contacto">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="SqlContactos" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                            
                                            
                                            
                                            SelectCommand="SELECT contactos.id_contacto, personas.primer_nombre + ' ' + personas.apellido_paterno AS contacto FROM contactos INNER JOIN personas ON contactos.id_persona = personas.id_persona WHERE (contactos.id_empresa = @id_empresa) AND (personas.id_status = 5)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                                                    PropertyName="SelectedValue" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 177px">
                                        Ruta:</td>
            <td style="width: 173px">
                <asp:DropDownList ID="ddlTrayecto" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource1" DataTextField="ruta" DataValueField="id_ruta">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    SelectCommand="SELECT DISTINCT dbo.llave_rutas.ruta, dbo.llave_rutas.id_ruta FROM dbo.llave_rutas INNER JOIN precios ON dbo.llave_rutas.id_ruta = precios.id_ruta WHERE (precios.id_empresa = @id_empresa) and precios.id_status=5 order by llave_rutas.ruta">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
                                <tr>
                                    <td style="width: 177px">
                                        Vehículo:</td>
            <td style="width: 173px">
                <asp:DropDownList ID="ddlVehiculo" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource2" DataTextField="equipo" 
                    DataValueField="id_tipo_recurso">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    SelectCommand="SELECT DISTINCT tipo_equipos.equipo, precios.id_tipo_recurso FROM precios INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo WHERE (precios.id_ruta = @id_ruta) AND (precios.id_empresa = @id_empresa)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlTrayecto" Name="id_ruta" 
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
                                <tr>
                                    <td style="width: 177px">
                                        Precio:</td>
            <td style="width: 173px">
                <asp:DropDownList ID="ddlPrecio" runat="server" DataSourceID="SqlDataSource4" 
                    DataTextField="Precio" DataValueField="id_relacion">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
                    SelectCommand="SELECT '$' + CONVERT (nvarchar, CONVERT (money, precios.precio), 1) + ' ' + tipos_monedas.moneda AS Precio, precios.id_relacion FROM precios INNER JOIN tipos_monedas ON precios.id_moneda = tipos_monedas.id_moneda WHERE (precios.id_empresa = @id_empresa) AND (precios.id_ruta = @id_ruta) AND (precios.id_tipo_recurso = @id_tipo_recurso) and precios.id_status=5">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlTrayecto" Name="id_ruta" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlVehiculo" Name="id_tipo_recurso" 
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
                                <tr>
                                    <td style="width: 177px">
                                        Fecha:</td>
            <td style="width: 173px">
               
            Fecha:<asp:TextBox ID="txbLlegada" runat="server"></asp:TextBox>
                    Hora:<asp:CalendarExtender ID="CalendarExtender1" runat="server" 
                    TargetControlID="txbLlegada" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                                    &nbsp;<asp:TextBox ID="txbHora" runat="server" Height="23px" 
                        MaxLength="5" Width="84px"></asp:TextBox>
                    <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txbHora"
                    Mask="99:99"
                     MaskType="Time"
                      AutoComplete="true"
                    >
                    </asp:MaskedEditExtender>
                &nbsp;</td>
        </tr>
                                <tr>
                                    <td style="width: 177px">
                                        Guía:</td>
            <td style="width: 173px">
                &nbsp;</td>
        </tr>
                                <tr>
                                    <td style="width: 177px">
                                        &nbsp;</td>
            <td style="width: 173px">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 177px">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
            </td>
            <td style="width: 173px">
                <asp:Label ID="lblAnuncio" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 177px">
                &nbsp;</td>
            <td style="width: 173px">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
