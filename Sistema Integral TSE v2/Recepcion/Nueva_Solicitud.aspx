<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Nueva_Solicitud.aspx.vb" Inherits="Sistema_Integral_TSE_v45.PruebaSolicitud" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="../Controles_Usuario/ctlViajesSinRegreso.ascx" TagName="ctlViajesSinRegreso" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

   
    <div id="header">
        <h1>Solicitudes de Servicio</h1>
    </div>

    <br />
    &nbsp;<br />
    Solicitudes 
    Registradas: 
    <asp:DropDownList ID="ddlOrdenes" runat="server" AutoPostBack="True"
        BackColor="#FFFF99" DataSourceID="sdsOrdenes" DataTextField="Orden"
        DataValueField="id_viaje" Height="19px" Width="282px">
    </asp:DropDownList>
    <asp:SqlDataSource ID="sdsOrdenes" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>"
        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo)  + ' (' + dbo.empresas.nombre + ')' AS Orden, viajes.id_viaje FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha WHERE (viajes.id_status &lt;&gt; 3) AND (fechas.tipo_fecha = 1) AND (fechas.fecha BETWEEN GETDATE()-365 AND GETDATE()+10) AND (viajes.id_status &lt;&gt; 5) ORDER BY Ordenes.ano, Ordenes.consecutivo"></asp:SqlDataSource>
    <br />
    <asp:TextBox ID="txbOrden" runat="server" SkinID="txbInvisible"></asp:TextBox>
    <asp:TextBox ID="txbIdRelacionBaja" runat="server" Visible="False"></asp:TextBox>
    <asp:HiddenField ID="hfldIdArrivoBaja" runat="server" />
    <br />
    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
    <br />
    <br />

    <table style="background-color: White; width: 549px;" border="0">
        <tr>
            <td bgcolor="#003300" colspan="2">
                <span style="color: #FFFFFF">Numero de Solicitud:</span>
                <asp:Label ID="lblOrden" runat="server" Font-Bold="True" ForeColor="White"></asp:Label>
                &nbsp;
            </td>
            <td bgcolor="#003300">&nbsp;</td>
            <td rowspan="13" style="top: 0px; left: 0px">
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="sdsViajesCreados" EnableModelValidation="True" SkinID="GridView1" PageSize="6">
                    <Columns>
                        <asp:BoundField DataField="ano" SortExpression="ano" />
                        <asp:BoundField DataField="consecutivo" HeaderText="ORDEN" SortExpression="consecutivo" />
                        <asp:BoundField DataField="fecha" HeaderText="FECHA INICIO" SortExpression="fecha" />
                        <asp:BoundField DataField="nombre" HeaderText="EMPRESA" SortExpression="nombre" />
                        <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
                        <asp:BoundField DataField="equipo" HeaderText="EQUIPO SOLICITADO" SortExpression="equipo" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsViajesCreados" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT 
O.ano, 
O.consecutivo,
f.fecha, 
e.nombre, 
ll.ruta, 
te.equipo
FROM Ordenes o
INNER JOIN viajes v
ON O.id_orden = v.id_orden 
INNER JOIN precios p
ON v.id_relacion = p.id_relacion 
INNER JOIN empresas e
ON p.id_empresa = e.id_empresa 
INNER JOIN llave_rutas ll 
ON p.id_ruta = ll.id_ruta 
INNER JOIN tipo_equipos te
ON p.id_tipo_recurso = te.id_tipo_equipo 
INNER JOIN tipos_monedas tm
ON p.id_moneda = tm.id_moneda 
join 
fechas_viaje fv
on fv.id_viaje=v.id_viaje
join 
fechas f
on f.id_fecha=fv.id_fecha
WHERE 
(v.id_status =1)
and f.tipo_fecha=1
ORDER BY 
O.ano DESC, O.consecutivo DESC"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 167px">Fecha:</td>
            <td class="style1" style="width: 317px">
                <asp:Label ID="lblFecha" runat="server"></asp:Label>
            </td>
            <td class="style1" style="width: 78px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 167px">Empresa:</td>
            <td class="style1" style="width: 317px">
                <asp:DropDownList ID="ddlCliente" runat="server" AutoPostBack="True"
                    DataSourceID="SqlDataClientes" DataTextField="nombre"
                    DataValueField="id_empresa">
                </asp:DropDownList>
                &nbsp;&nbsp;<asp:SqlDataSource ID="SqlDataClientes" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="SELECT id_empresa, nombre FROM dbo.empresas WHERE (id_status = 5) AND (id_tipo_empresa = 1) ORDER BY nombre"></asp:SqlDataSource>
            </td>
            <td class="style1" style="width: 78px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 167px">Contacto:</td>
            <td class="style1" style="width: 317px">
                <asp:SqlDataSource ID="SqlDataContacto" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS contacto, contactos.id_contacto FROM contactos INNER JOIN personas ON contactos.id_persona = personas.id_persona WHERE (personas.id_status = 5) AND (contactos.id_empresa = @id_empresa)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCliente" DefaultValue="" Name="id_empresa"
                            PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:Button ID="btnNuevoContacto" runat="server" SkinID="btn"
                    Text="Nuevo..." />

                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlContacto" runat="server"
                            DataSourceID="SqlDataContacto" DataTextField="contacto"
                            DataValueField="id_contacto">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlCliente" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
            <td class="style1" style="width: 78px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 167px">Ruta:</td>
            <td class="style1" style="width: 317px">
                <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="SELECT DISTINCT dbo.llave_rutas.ruta, dbo.llave_rutas.id_ruta FROM dbo.llave_rutas INNER JOIN precios ON dbo.llave_rutas.id_ruta = precios.id_ruta WHERE (precios.id_empresa = @id_empresa) AND (precios.id_status = 5) ORDER BY dbo.llave_rutas.ruta">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCliente" Name="id_empresa"
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlTrayecto" runat="server" AutoPostBack="True"
                            DataSourceID="SqlDataSource3" DataTextField="ruta" DataValueField="id_ruta">
                        </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlCliente" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>

            </td>
            <td class="style1" style="width: 78px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 167px">Contactos seguimiento:</td>
            <td class="style1" style="width: 317px">&nbsp;<asp:Label ID="lblContactos" runat="server" ForeColor="#0066FF"></asp:Label>
                <asp:LinkButton ID="lnkContactos" runat="server">Ver Lista</asp:LinkButton>

            </td>
            <td class="style1" style="width: 78px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 167px">Vehículo:</td>
            <td class="style1" style="width: 317px">
                <asp:SqlDataSource ID="SqlDataSource4" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="SELECT DISTINCT tipo_equipos.equipo, tipo_equipos.id_tipo_equipo FROM precios INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo WHERE (precios.id_empresa = @id_empresa) AND (precios.id_status = 5) AND (precios.id_ruta = @id_ruta)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCliente" Name="id_empresa"
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlTrayecto" Name="id_ruta"
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>


                <%--<asp:UpdatePanel ID="UpdatePanel3" runat="server">

                        <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlTrayecto" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>--%>

                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlIdTipoVehiculo" runat="server" AutoPostBack="True"
                            DataSourceID="SqlDataSource4" DataTextField="equipo"
                            DataValueField="id_tipo_equipo">
                        </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlTrayecto" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>

            </td>
            <td class="style1" style="width: 78px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 167px">Precio:</td>
            <td class="style1" style="width: 317px">
                <asp:SqlDataSource ID="SqlDataSource6" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="SELECT '$' + CONVERT (nvarchar, CONVERT (money, precios.precio), 1) + ' ' + tipos_monedas.moneda AS Precio, precios.id_relacion FROM precios INNER JOIN tipos_monedas ON precios.id_moneda = tipos_monedas.id_moneda WHERE (precios.id_empresa = @id_empresa) AND (precios.id_ruta = @id_ruta) AND (precios.id_tipo_recurso = @id_tipo_recurso) AND (precios.id_status = 5)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlCliente" Name="id_empresa"
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlTrayecto" Name="id_ruta"
                            PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="ddlIdTipoVehiculo" Name="id_tipo_recurso"
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <%--<asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlIdTipoVehiculo" EventName="SelectedIndexChanged" />
                                                </Triggers>
                    </asp:UpdatePanel>--%>


                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlPrecio" runat="server" DataSourceID="SqlDataSource6"
                            DataTextField="precio" DataValueField="id_relacion">
                        </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlIdTipoVehiculo" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>


            </td>
            <td class="style1" style="width: 78px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 167px">Inicio:</td>
            <td class="style1" style="width: 317px">Fecha:<asp:TextBox ID="txbFechaInicio" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender3"
                    runat="server" TargetControlID="txbFechaInicio" Format="dd/MM/yyyy"
                    PopupPosition="TopRight" FirstDayOfWeek="Monday" TodaysDateFormat="dd/MM/yyyy">
                </asp:CalendarExtender>

                <asp:Image ID="Image2" runat="server" ImageUrl="~/date_picker1.gif" />

                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txbFechaInicio" ErrorMessage="Campo Obligatorio" ValidationGroup="destino"></asp:RequiredFieldValidator>

                <br />
                Hora:
                                    &nbsp;<asp:TextBox ID="txbHoraInicio" runat="server" Height="23px"
                                        MaxLength="5" Width="84px"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txbHoraInicio"
                    Mask="99:99"
                    MaskType="Time"
                    AutoComplete="true">
                </asp:MaskedEditExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txbHoraInicio" ErrorMessage="Campo Obligatorio" ValidationGroup="destino"></asp:RequiredFieldValidator>
            </td>
            <td class="style1" style="width: 78px">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 167px" bgcolor="#FFFF99">Destinos:</td>
            <td class="style1" style="width: 317px" bgcolor="#FFFF99">
                <asp:UpdatePanel ID="updDestinos" runat="server">
                    <ContentTemplate>
                        Destino:<asp:DropDownList ID="ddlArrivo" runat="server" Height="20px"
                            Width="131px" DataSourceID="sdsArrivosCliente" DataTextField="nombre"
                            DataValueField="id_detalle">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvArrivo" runat="server" ControlToValidate="ddlArrivo" ErrorMessage="Seleccione el destino" InitialValue="0" ValidationGroup="destino"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlCliente" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                Fecha:<asp:TextBox ID="txbFechaDestino" runat="server" Height="20px"></asp:TextBox>
                <asp:CalendarExtender ID="btnFecha_CalendarExtender" runat="server"
                    Enabled="True" TargetControlID="txbFechaDestino" Format="dd/MM/yyyy">
                </asp:CalendarExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                    ControlToValidate="txbFechaDestino" ErrorMessage="*" ValidationGroup="destino">Campo Obligatorio</asp:RequiredFieldValidator>
                <br />
                Hora:<asp:TextBox
                    ID="txbHoraDestino" runat="server" Height="20px" Width="73px"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txbHoraDestino"
                    Mask="99:99"
                    MaskType="Time"
                    AutoComplete="true">
                </asp:MaskedEditExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                    ControlToValidate="txbHoraDestino" ErrorMessage="*" ValidationGroup="destino">Campo Obligatorio</asp:RequiredFieldValidator>
                <br />
                <br />
            </td>
            <td class="style1" style="width: 78px" bgcolor="#FFFF99">

                <asp:LinkButton ID="lnkDestino" runat="server">+ Agregar Destino</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td style="height: 29px;">Guía del cliente:</td>
            <td style="height: 29px;">
                <asp:TextBox ID="txbGuia" runat="server" Width="200px"></asp:TextBox>
            </td>
            <td style="height: 29px;">&nbsp;</td>
        </tr>
        <tr>
            <td style="height: 29px;">Optimizado:</td>
            <td style="height: 29px;">
                <asp:CheckBox ID="cbOptimizado" runat="server" Width="200px"></asp:CheckBox>
            </td>
            <td style="height: 29px;">&nbsp;</td>
        </tr>
        <tr>
            <td style="height: 29px;">&nbsp;<asp:Button ID="btnNuevo" runat="server" Text="Nuevo" SkinID="btn" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;</td>
            <td style="height: 29px;">
                <asp:Button ID="btnNumViaje" runat="server" Text="Guardar" SkinID="btnGuardar"
                    OnClick="btnNumViaje_Click" OnClientClick="this.value = 'Espere...';"
                    ValidationGroup="destino" />
                <asp:Label ID="lblAnuncio" runat="server" ForeColor="#003300"></asp:Label>
            </td>
            <td style="height: 29px;">
                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar"
                    SkinID="btnBorrar" />
            </td>
        </tr>
        <tr>
            <td style="height: 29px;">&nbsp;</td>
            <td style="height: 29px;">
                <asp:TextBox ID="txbConsecutivo" runat="server" Visible="False"></asp:TextBox>
            </td>
            <td style="height: 29px;">&nbsp;</td>
        </tr>
        <tr>
            <td style="height: 29px;"><b>TSE-F01</b></td>
            <td style="height: 29px;">
                <b>Abril 2016</b></td>
            <td style="height: 29px;"><b>Rev. 01</b></td>
        </tr>
    </table>
     
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
        DataSourceID="sqlOrdenModificada" EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="orden" HeaderText="ORDEN" ReadOnly="True"
                SortExpression="orden" />
            <asp:BoundField DataField="nombre" HeaderText="CLIENTE"
                SortExpression="nombre" />
            <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
            <asp:BoundField DataField="equipo" HeaderText="EQUIPO"
                SortExpression="equipo" />
            <asp:BoundField DataField="fecha" HeaderText="ORIGEN" SortExpression="fecha"
                DataFormatString="{0:dd/MM/yyyy HH:mm}" />
            <asp:BoundField DataField="Destino" DataFormatString="{0:dd/MM/yyyy HH:mm}"
                HeaderText="DESTINO" SortExpression="Destino" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlOrdenModificada" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS orden, dbo.empresas.nombre, dbo.llave_rutas.ruta, tipo_equipos.equipo, fechas.fecha, llegadaDestinos.fecha AS Destino FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha LEFT OUTER JOIN llegadaDestinos ON viajes.id_viaje = llegadaDestinos.idViaje WHERE (fechas.tipo_fecha = 1) AND (viajes.id_viaje = @id_viaje)">
        <SelectParameters>
            <asp:Parameter Name="id_viaje" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsArrivosCliente" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="SELECT detalle_arrivos.nombre + ' (' + ubicaciones.ubicacion + ')' AS nombre, detalle_arrivos.id_detalle FROM detalle_arrivos INNER JOIN ubicaciones ON detalle_arrivos.id_ubicacion = ubicaciones.id_principal WHERE (detalle_arrivos.id_status = 5) AND (detalle_arrivos.id_empresa = @id_empresa) ORDER BY nombre">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCliente" Name="id_empresa"
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />


    <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server"
        ConfirmOnFormSubmit="True"
        ConfirmText="Esta apunto de eliminar una Orden de Servicio, ¿Esta seguro de querer hacerlo?"
        TargetControlID="btnEliminar">
    </asp:ConfirmButtonExtender>
    &nbsp;<asp:Button ID="Button1" runat="server" />
    &nbsp;

    <asp:ModalPopupExtender ID="Panel1_ModalPopupExtender" runat="server" PopupControlID="Panel1"
        DynamicServicePath="" Enabled="True" TargetControlID="Button1" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>

    <asp:Panel ID="Panel1" runat="server" BackColor="White">
        <asp:PlaceHolder ID="PlaceHolder2" runat="server"></asp:PlaceHolder>
        <br />
        <asp:Button ID="btnCerrar" runat="server"
            Text="Cerrar" />
    </asp:Panel>


</asp:Content>


