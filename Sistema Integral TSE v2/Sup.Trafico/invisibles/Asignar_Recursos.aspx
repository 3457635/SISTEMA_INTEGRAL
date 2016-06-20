<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Asignar_Recursos.aspx.vb"
    Inherits="Sistema_Integral_TSE_v45.Asignar_Recursos"  %>
<%@ OutputCache Duration="60" VaryByParam="*" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"    Namespace="System.Web.UI" TagPrefix="asp" %>










<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Asignar recursos</h1>
   
        Orden de Servicio:
        <asp:DropDownList ID="ddlOrden" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource6" DataTextField="orden" 
            DataValueField="id_viaje" AppendDataBoundItems="True">
            <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            
            
            
            
            
            SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) + ' (' + dbo.empresas.nombre + ')' AS orden, viajes.id_viaje FROM viajes INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa WHERE ((viajes.id_status = 2) OR (viajes.id_status = 4)) AND Ordenes.ano &gt;= Year(GETDATE()) - 1 ORDER BY Ordenes.ano DESC, Ordenes.consecutivo DESC">
        </asp:SqlDataSource>
    </p>
    <p>
        
        <table class="auto-style2">
            <tr>
                <td class="auto-style3">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            DataSourceID="SqlDataSource1" EnableModelValidation="True" CellPadding="4" 
            ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <Columns>
                <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True" SortExpression="ORDEN" />                
                <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE" SortExpression="CLIENTE" />
                <asp:BoundField DataField="RUTA" HeaderText="RUTA" SortExpression="RUTA" />
                <asp:BoundField DataField="VEHICULO" HeaderText="VEHICULO" SortExpression="VEHICULO" />
                <asp:BoundField DataField="LLEGADA_CLIENTE" HeaderText="LLEGADA_CLIENTE" 
                    SortExpression="LLEGADA_CLIENTE" ReadOnly="True" />                
            </Columns>
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        </asp:GridView>
                </td>
                <td>
                    <asp:CheckBox ID="ckbSinSeguimiento" runat="server" Text="Ruta Sin Seguimiento" AutoPostBack="True" />
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                
            
            
            
            SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS ORDEN, dbo.empresas.nombre AS CLIENTE, dbo.llave_rutas.ruta AS RUTA, tipo_equipos.equipo AS VEHICULO, CONVERT (nvarchar, fechas.fecha, 103) + ' ' + CONVERT (nvarchar(5), fechas.fecha, 108) AS LLEGADA_CLIENTE FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha WHERE (fechas.tipo_fecha = 1) AND (viajes.id_viaje = @id_viaje)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlOrden" Name="id_viaje" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="Button2" runat="server" />
       
    </p>
    
    <hr />
    <table class="style7">
        <tr>
            <td class="style8">
                &nbsp;
            </td>
            <td style="width: 199px">
                <asp:TextBox ID="txbIdViaje" runat="server" Visible="False"></asp:TextBox>
                <asp:TextBox ID="txbEquipoAsignadoId" runat="server" Visible="False"></asp:TextBox>
                <asp:Label ID="lblSolocruce" runat="server" Visible="False"></asp:Label>
            </td>
            <td style="width: 199px">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style8">
                &nbsp;</td>
            <td style="width: 199px">
                <asp:CheckBox ID="ckbMultichofer" runat="server" AutoPostBack="True" 
                    Text="Multichofer" />
                <br />
                <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
            </td>
            <td style="width: 199px">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style8">
                Trayecto:
            </td>
            <td style="width: 199px">
                <asp:DropDownList ID="ddlTrayecto" runat="server" DataSourceID="SqlDataSource5" 
                    DataTextField="trayecto" DataValueField="id_trayecto" Enabled="False" 
                    >
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
                    
                    SelectCommand="SELECT DISTINCT llave_trayectos.trayecto, llave_trayectos.id_trayecto FROM trayecto_ruta INNER JOIN llave_trayectos ON trayecto_ruta.id_trayecto = llave_trayectos.id_trayecto INNER JOIN precios INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN viajes ON precios.id_relacion = viajes.id_relacion AND precios.id_relacion = viajes.id_relacion ON trayecto_ruta.id_ruta = dbo.llave_rutas.id_ruta WHERE (viajes.id_viaje = @id_viaje)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlOrden" Name="id_viaje" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:Button ID="btnTrayecto" runat="server" Text="Nuevo..." 
                    OnClick="btnTrayecto_Click" OnClientClick="this.value = 'Espere...';" 
                    Enabled="False" />
            </td>
            <td style="width: 199px">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style9">
                Chofer:
            </td>
            <td style="width: 199px; height: 75px;">
                <asp:DropDownList ID="ddlChofer" runat="server" DataSourceID="SqlDataSource2" DataTextField="Empleado"
                    DataValueField="id_empleado">
                </asp:DropDownList>
                <br />
                <asp:LinkButton ID="lnkChofer" runat="server" Font-Size="Smaller">Catalogo Empleados</asp:LinkButton>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    
                    
                    
                    
                    SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS Empleado, empleados.id_empleado FROM empleados INNER JOIN personas ON empleados.id_persona = personas.id_persona WHERE (personas.id_status = 5) AND (empleados.id_puesto = 1) AND (personas.id_status = 5) OR (empleados.id_puesto = 3) ORDER BY personas.primer_nombre">
                </asp:SqlDataSource>
                
            </td>
            <td style="width: 199px; height: 75px;">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style8">
                Unidad:
            </td>
            <td style="width: 199px">
                <asp:DropDownList ID="ddlUnidad" runat="server" DataSourceID="SqlDataSource3" DataTextField="EQUIPO"
                    DataValueField="id_equipo" Height="16px" Width="156px">
                </asp:DropDownList>
                &nbsp;<br />
                
&nbsp;
                                <asp:LinkButton ID="lnkUnidades" runat="server" Font-Size="Smaller">Catalogo Unidades</asp:LinkButton>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                                    
                    
                    SelectCommand="SELECT equipo_operacion.economico + ' (' + tipo_equipos.equipo + ')' AS EQUIPO, equipo_operacion.id_equipo FROM equipo_operacion INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo AND equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo WHERE (tipo_equipos.id_tipo_equipo &lt;&gt; 107) AND (equipo_operacion.id_status &lt;&gt; 6) ORDER BY equipo_operacion.economico">
                </asp:SqlDataSource>
            </td>
            <td style="width: 199px">
                &nbsp;</td>
        </tr>
        <tr><td>Tipo de recorrido</td><td>
                <asp:DropDownList ID="ddlRecorrido" runat="server" 
                    ForeColor="Black" Height="25px" Width="154px">
                    <asp:ListItem Selected="True" Value="0">Seleccionar...</asp:ListItem>
                    <asp:ListItem Value="2">Regresa</asp:ListItem>
                    <asp:ListItem Value="1">Inicia recorrido</asp:ListItem>
                    <asp:ListItem Value="5">Local</asp:ListItem>
                    <asp:ListItem Value="8">Solo Cruce</asp:ListItem>
                </asp:DropDownList>
            </td><td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlRecorrido" ErrorMessage="Seleccione el tipo de recorrido." InitialValue="0"></asp:RequiredFieldValidator>
            </td></tr>
        <tr>
            <td class="style8">
                Orden de Inicio</td>
            <td style="width: 199px">                

                        <asp:TextBox ID="txbAno" runat="server" Width="60px"></asp:TextBox>
                &nbsp;-
                <asp:TextBox ID="txbOrdenInicio" runat="server" Width="86px"></asp:TextBox>
                            
                   </td>
            <td style="width: 199px">
                <asp:GridView ID="grdViajeRegreso" runat="server" AutoGenerateColumns="False" DataKeyNames="id_equipo_asignado" DataSourceID="sdsViajesRegreso" EnableModelValidation="True">
                    <Columns>
                        <asp:BoundField DataField="ano" HeaderText="ano" SortExpression="ano" />
                        <asp:BoundField DataField="consecutivo" HeaderText="consecutivo" SortExpression="consecutivo" />
                        <asp:BoundField DataField="nombre" HeaderText="nombre" SortExpression="nombre" />
                        <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta" />
                        <asp:BoundField DataField="primer_nombre" HeaderText="primer_nombre" SortExpression="primer_nombre" />
                        <asp:BoundField DataField="apellido_paterno" HeaderText="apellido_paterno" SortExpression="apellido_paterno" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsViajesRegreso" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="ordenesPorGrupo" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="grupo" Type="Int32" />
                        <asp:Parameter Name="tipoTrayecto" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style8">
                Caja:
            </td>
            <td style="width: 199px">
                
                        <asp:DropDownList ID="ddlCaja" runat="server" 
    DataSourceID="SqlDataSource4" DataTextField="economico"
                    DataValueField="CajaId">
                        </asp:DropDownList>
                    
                <asp:LinkButton ID="lnkCajas" runat="server">Catalogo Cajas</asp:LinkButton>
                <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    
                    
                            
                            SelectCommand="select economico, (id_equipo) as cajaid from equipo_operacion where id_tipo_equipo = 107 order by economico">
                </asp:SqlDataSource>
            </td>
            <td style="width: 199px">
                
                        &nbsp;</td>
        </tr>
        <tr>
            <td class="style8">
                &nbsp;</td>
            <td style="width: 199px">
                
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" OnClientClick="this.value = 'Espere...';" />
            </td>
            <td style="width: 199px">
                
                        &nbsp;</td>
        </tr>
        <tr>
            <td class="style8">
                &nbsp;
            </td>
            <td style="width: 199px">
                <asp:Label ID="lblAnuncio" runat="server"></asp:Label>
                &nbsp;<asp:LinkButton ID="LinkButton1" runat="server" Visible="False">&lt;--Regresar</asp:LinkButton>
            </td>
            <td style="width: 199px">
                &nbsp;</td>
        </tr>
    </table>
    <hr />
    <div>

                    <table class="style6">
                        <tr>
                            <td style="width: 246px">

                                <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" 
                                    CellPadding="4" DataKeyNames="id_equipo_asignado" DataSourceID="sdsConCaja" 
                                    EnableModelValidation="True" ForeColor="#333333" GridLines="None">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    <Columns>
                                        <asp:CommandField ShowDeleteButton="True" 
                                            DeleteText="Eliminar" EditText="Modificar" ShowSelectButton="True" />
                                        <asp:BoundField DataField="id_equipo_asignado" InsertVisible="False" 
                                            ReadOnly="True" SortExpression="id_equipo_asignado">
                                        <ItemStyle Font-Size="0pt" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="CHOFER" SortExpression="idEmpleado">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsChoferes" 
                                                    DataTextField="chofer" DataValueField="id_empleado" Enabled="False" 
                                                    SelectedValue='<%# Bind("idEmpleado") %>'>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="sdsChoferes" runat="server" 
                                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                                    SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS chofer, empleados.id_empleado FROM empleados INNER JOIN personas ON empleados.id_persona = personas.id_persona">
                                                </asp:SqlDataSource>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="sdsChoferes" 
                                                    DataTextField="chofer" DataValueField="id_empleado" 
                                                    SelectedValue='<%# Bind("idEmpleado") %>'>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="sdsChoferes" runat="server" 
                                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                                    
                                                    SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS chofer, empleados.id_empleado FROM empleados INNER JOIN personas ON empleados.id_persona = personas.id_persona WHERE (personas.id_status = 5) ORDER BY personas.primer_nombre">
                                                </asp:SqlDataSource>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="VEHICULO" SortExpression="id_equipo">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="sdsVehiculo" 
                                                    DataTextField="economico" DataValueField="id_equipo" Enabled="False" 
                                                    SelectedValue='<%# Bind("id_equipo") %>'>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="sdsVehiculo" runat="server" 
                                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                                    
                                                    SelectCommand="SELECT [id_equipo], [economico] FROM [equipo_operacion] WHERE ([id_status] = @id_status) and id_tipo_equipo&lt;107 ORDER BY [economico] ">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="sdsVehiculo" 
                                                    DataTextField="economico" DataValueField="id_equipo" 
                                                    SelectedValue='<%# Bind("id_equipo") %>'>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="sdsVehiculo" runat="server" 
                                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                                    
                                                    
                                                    SelectCommand="SELECT economico, id_equipo FROM equipo_operacion WHERE (id_status = @id_status) and id_tipo_equipo&lt;107 ORDER BY economico">
                                                    <SelectParameters>
                                                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="TRAYECTO">
                                            <ItemTemplate>
                                                <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" 
                                                    DataSourceID="sdsTrayectos" EnableModelValidation="True" ShowHeader="False" 
                                                    SkinID="grdAnidado">
                                                    <Columns>
                                                        <asp:BoundField DataField="trayecto" HeaderText="trayecto" 
                                                            SortExpression="trayecto" />
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sdsTrayectos" runat="server" 
                                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                                    SelectCommand="SELECT llave_trayectos.trayecto FROM llave_trayectos INNER JOIN trayectos_asignados ON llave_trayectos.id_trayecto = trayectos_asignados.id_trayecto INNER JOIN equipo_asignado ON trayectos_asignados.EquipoAsignadoId = equipo_asignado.id_equipo_asignado WHERE (equipo_asignado.id_equipo_asignado=@EquipoAsignadoId) ORDER BY trayectos_asignados.EquipoAsignadoId">
                                                    <SelectParameters>
                                                        <asp:Parameter Name="EquipoAsignadoId" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="CAJA">
                                            <ItemTemplate>
                                                <asp:GridView ID="GridView9" runat="server" AutoGenerateColumns="False" DataSourceID="sdsCaja" EnableModelValidation="True" SkinID="grdAnidado">
                                                    <Columns>
                                                        <asp:BoundField DataField="economico" HeaderText="economico" SortExpression="economico" />
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sdsCaja" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" DeleteCommand="DELETE FROM [cajaAsignada] WHERE [idCajaAsignada] = @idCajaAsignada" InsertCommand="INSERT INTO [cajaAsignada] ([CajaId], [EquipoAsignadoId]) VALUES (@CajaId, @EquipoAsignadoId)" SelectCommand="SELECT 
ca.economico
FROM cajaAsignada c 
JOIN 
equipo_asignado e
 ON c.EquipoAsignadoId = e.id_equipo_asignado 
join 
cajas ca
on ca.cajaId=c.cajaId
WHERE 
e.id_equipo_asignado=@idEquipoAsignado
ORDER BY 
c.EquipoAsignadoId" UpdateCommand="UPDATE [cajaAsignada] SET [CajaId] = @CajaId WHERE [idCajaAsignada] = @idCajaAsignada">
                                                    <DeleteParameters>
                                                        <asp:Parameter Name="idCajaAsignada" Type="Int32" />
                                                    </DeleteParameters>
                                                    <InsertParameters>
                                                        <asp:Parameter Name="CajaId" Type="Int32" />
                                                        <asp:Parameter Name="EquipoAsignadoId" Type="Int32" />
                                                    </InsertParameters>
                                                    <SelectParameters>
                                                        <asp:Parameter Name="idEquipoAsignado" />
                                                    </SelectParameters>
                                                    <UpdateParameters>
                                                        <asp:Parameter Name="CajaId" Type="Int32" />
                                                        <asp:Parameter Name="idCajaAsignada" />
                                                    </UpdateParameters>
                                                </asp:SqlDataSource>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="RECORRIDO ">
                                            <ItemTemplate>
                                                <asp:GridView ID="grdRecorrido" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRecorrido" EnableModelValidation="True" SkinID="grdAnidado">
                                                    <Columns>
                                                        <asp:BoundField DataField="tipo_trayecto" HeaderText="tipo_trayecto" SortExpression="tipo_trayecto" />
                                                    </Columns>
                                                </asp:GridView>
                                                <asp:SqlDataSource ID="sdsRecorrido" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT t.tipo_trayecto, r.grupo 
FROM 
recorridoEquipo AS r 
INNER JOIN tipo_trayecto AS t 
ON r.tipoTrayecto = t.id_tipo_trayecto 
WHERE (r.idEquipoAsignado = @idEquipoAsignado)">
                                                    <SelectParameters>
                                                        <asp:Parameter Name="idEquipoAsignado" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ODOMETROS">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="ckbOdometro" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="RECARGAS">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="ckbRecargas" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                </asp:GridView>
                            </td>
                            <td style="width: 246px">

                                &nbsp;</td>
                            <td style="width: 246px">

                                <asp:SqlDataSource ID="sdsConCaja" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                    DeleteCommand="DELETE FROM [equipo_asignado] WHERE [id_equipo_asignado] = @id_equipo_asignado" 
                                    InsertCommand="INSERT INTO [equipo_asignado] ([id_equipo], [id_asignacion], [idEmpleado], [ViajeId], [idOrden]) VALUES (@id_equipo, @id_asignacion, @idEmpleado, @ViajeId, @idOrden)" 
                                    SelectCommand="SELECT TOP (200) id_equipo_asignado, id_equipo, idEmpleado FROM equipo_asignado WHERE (ViajeId = @viajeId) ORDER BY id_equipo_asignado" 
                                    
                                    UpdateCommand="UPDATE [equipo_asignado] SET [id_equipo] = @id_equipo, idEmpleado=@idEmpleado  WHERE [id_equipo_asignado] = @id_equipo_asignado">
                                    <DeleteParameters>
                                        <asp:Parameter Name="id_equipo_asignado" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="id_equipo" Type="Int32" />
                                        <asp:Parameter Name="id_asignacion" Type="Int32" />
                                        <asp:Parameter Name="idEmpleado" Type="Int32" />
                                        <asp:Parameter Name="ViajeId" Type="Int32" />
                                        <asp:Parameter Name="idOrden" Type="Int32" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:Parameter Name="viajeId" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="id_equipo" Type="Int32" />
                                        <asp:Parameter Name="idEmpleado" Type="Int32" />
                                        <asp:Parameter Name="id_equipo_asignado" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>

                                <asp:SqlDataSource ID="sdsRecorridos" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                    
                                    SelectCommand="SELECT recorridoEquipo.id, recorridoEquipo.tipoTrayecto, recorridoEquipo.grupo, recorridoEquipo.idEquipoAsignado FROM recorridoEquipo INNER JOIN equipo_asignado ON recorridoEquipo.idEquipoAsignado = equipo_asignado.id_equipo_asignado WHERE (equipo_asignado.ViajeId = @idViaje)" 
                                    DeleteCommand="DELETE FROM [recorridoEquipo] WHERE [id] = @id" 
                                    InsertCommand="INSERT INTO [recorridoEquipo] ([tipoTrayecto], [grupo], [idEquipoAsignado]) VALUES (@tipoTrayecto, @grupo, @idEquipoAsignado)" 
                                    
                                    UpdateCommand="UPDATE [recorridoEquipo] SET [tipoTrayecto] = @tipoTrayecto, [grupo] = @grupo, [idEquipoAsignado] = @idEquipoAsignado WHERE [id] = @id">
                                    <DeleteParameters>
                                        <asp:Parameter Name="id" Type="Int32" />
                                    </DeleteParameters>
                                    <InsertParameters>
                                        <asp:Parameter Name="tipoTrayecto" Type="Int32" />
                                        <asp:Parameter Name="grupo" Type="Int32" />
                                        <asp:Parameter Name="idEquipoAsignado" Type="Int32" />
                                    </InsertParameters>
                                    <SelectParameters>
                                        <asp:Parameter Name="idViaje" />
                                    </SelectParameters>
                                    <UpdateParameters>
                                        <asp:Parameter Name="tipoTrayecto" Type="Int32" />
                                        <asp:Parameter Name="grupo" Type="Int32" />
                                        <asp:Parameter Name="idEquipoAsignado" Type="Int32" />
                                        <asp:Parameter Name="id" Type="Int32" />
                                    </UpdateParameters>
                                </asp:SqlDataSource>

                            </td>
                        </tr>
                        </table>
                
                    <asp:CheckBox ID="ckbModificacionRecursos" runat="server" Visible="False" />
                
                    <br />
                    <asp:HyperLink ID="lnkOrden" runat="server" 
                        NavigateUrl="~/Sup.Trafico/Orden.aspx" Target="_blank">Orden</asp:HyperLink>
                    &nbsp;&nbsp;
                    <br />
                    <asp:HyperLink ID="lnkLiquidacion" runat="server" Target="_blank">Liquidación</asp:HyperLink>
                    <br />
                    <br />
                    <asp:Button ID="btnGancho" runat="server" />
                    <br />

        <asp:ModalPopupExtender ID="mdlAdvertencia" runat="server" TargetControlID="btnGancho" 
                        PopupControlID="Panel2" BackgroundCssClass="modalBackground">
        </asp:ModalPopupExtender>
                    <asp:Panel ID="Panel2" runat="server" BackColor="White">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                En la orden anterior esta unidad no tiene regreso.
                                <br />
                                Registre primero la orden de regreso, o si la unidad regresa vacia de click en
                                <asp:LinkButton ID="lnkRegresoVacio" runat="server">la 
        unidad regresó vacía</asp:LinkButton>
                                &nbsp;y vuelva a intentar guardar.
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <br />
                        <br />
                        <asp:Button ID="btnCerrar2" runat="server" Text="Cerrar" />
                    </asp:Panel>
                    <br />
                    <br />
                    <br />
    </div>
    <div>
        <asp:ModalPopupExtender ID="mdlTrayecto" runat="server" TargetControlID="Button2"
            PopupControlID="Panel1" BackgroundCssClass="modalBackground">
        </asp:ModalPopupExtender>

        <asp:Panel ID="Panel1" runat="server" BackColor="White" Width="259px" >
            <table style="width: 26%">
                <tr>
                    <td colspan="2">
                        &nbsp;&nbsp;<asp:Label ID="lblRuta" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 70px">
                        Origen:
                    </td>
                    <td class="style11">
                        <asp:DropDownList ID="ddlOrigen" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 70px">
                        Destino:
                    </td>
                    <td class="style11">
                        <asp:DropDownList ID="ddlDestino" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 70px">
                        <asp:Button ID="btnAsignar" runat="server" Text="Asignar" OnClientClick="this.value = 'Espere...';" />
                    </td>
                    <td class="style11">
                        &nbsp;
                        <asp:Label ID="lblMensaje2" runat="server" SkinID="lblMensaje"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 70px">
                        <asp:Button ID="Button1" runat="server" Text="Cerrar" />
                    </td>
                    <td class="style11">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </div>
    
   <div>
       <table class="auto-style4">
           <tr>
               <td>TSE-F-02</td>
               <td>ABRIL 2016</td>
               <td>REV. 01</td>
           </tr>
       </table>

   </div>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .style6
        {
        }
        .style7
        {
            width: 398px;
        }
        .style8
        {
            width: 64px;
        }
        .style9
        {
            height: 75px;
            width: 64px;
        }
        .style11
        {
            width: 94%;
        }
    .auto-style2 {
        width: 100%;
    }
    .auto-style3 {
        width: 511px;
    }
        .auto-style4 {
            width: 100%;
        }
    </style>
</asp:Content>

