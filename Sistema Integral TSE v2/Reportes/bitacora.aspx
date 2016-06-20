<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="bitacora.aspx.vb" Inherits="Sistema_Integral_TSE_v45.bitacora" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register src="../Controles_Usuario/ctlPrenomina.ascx" tagname="ctlPrenomina" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
        Bitacora&nbsp;</p>
    <p>
        <asp:WebPartManager ID="WebPartManager1" runat="server">
        </asp:WebPartManager>
        <asp:WebPartZone ID="WebPartZone1" runat="server" SkinID="wprtProfesional">
            <ZoneTemplate>
                <uc1:ctlPrenomina ID="ctlPrenomina2" Title="Nomina" runat="server" />
            </ZoneTemplate>
        </asp:WebPartZone>
    </p>
    <p>
        Desde:
        <asp:TextBox ID="txbFecha1" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender1"
            runat="server" TargetControlID="txbFecha1" Format="dd/MM/yyyy" >
        </asp:CalendarExtender>
&nbsp;-
        Hasta:
        <asp:TextBox ID="txbFecha2" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender2"
            runat="server" TargetControlID="txbFecha2" Format="dd/MM/yyyy" >
        </asp:CalendarExtender>
    &nbsp;<asp:ImageButton ID="ibtnActualizarD" runat="server" 
            SkinID="ibtnActualizar" style="width: 14px" />
    </p>
    <p>
        Chofer:
        <asp:DropDownList ID="ddlChofer" runat="server" 
            DataSourceID="SqlDataSource1" DataTextField="CHOFER" 
            DataValueField="id_empleado" AppendDataBoundItems="True">
            <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
        </asp:DropDownList>
        &nbsp;&nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS CHOFER, empleados.id_empleado FROM personas INNER JOIN empleados ON personas.id_persona = empleados.id_persona WHERE (personas.id_status = 5) ORDER BY chofer">
        </asp:SqlDataSource>
        <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </p>
    <table class="style5">
        <tr>
            <td class="style7">
                Registro de Recolecciones</td>
            <td class="style9">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style7">
                <asp:DropDownList ID="ddlViaje" runat="server" 
                    DataSourceID="sdsOrdenesRecolecciones" DataTextField="orden" 
                    DataValueField="id_viaje">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsOrdenesRecolecciones" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT     CONVERT(nvarchar, Ordenes.ano) + '-' + CONVERT(nvarchar, Ordenes.consecutivo) + '-' + CONVERT(nvarchar, viajes.num_viaje) + ' ' + dbo.empresas.nombre AS orden, viajes.id_viaje
FROM         Ordenes INNER JOIN
                      viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa
ORDER BY Ordenes.ano DESC, Ordenes.consecutivo DESC">
                </asp:SqlDataSource>
            </td>
            <td class="style9">
                <asp:TextBox ID="txbRecolecciones" runat="server"></asp:TextBox>
                <asp:Button ID="btnGuardar" runat="server" SkinID="btn" Text="Guadar" />
            </td>
        </tr>
    </table>
    
    <p>
        <asp:ImageButton ID="ImageButton1" runat="server" Height="58px" 
            SkinID="ibtnImprimir" Width="60px" />
    <asp:UpdateProgress ID="uppDetalle" runat="server" 
        AssociatedUpdatePanelID="">
        <ProgressTemplate>
            <img alt="" class="style1" 
    src="../imagenes/updateProgress.gif" />Procesando...</ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
        
            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="id_viaje" EnableModelValidation="True" ShowFooter="True" 
                SkinID="GridView1" EmptyDataText="No hay datos.">
                <Columns>
                    <asp:BoundField DataField="id_viaje">
                    <ItemStyle Font-Size="0pt" Width="0px" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="FACTURA">
                        <ItemTemplate>
                            <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsFactura" EnableModelValidation="True" SkinID="grdAnidado">
                                <Columns>
                                    <asp:BoundField DataField="folio" HeaderText="folio" SortExpression="folio" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsFactura" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                SelectCommand="SELECT facturas.folio FROM facturacion INNER JOIN facturas ON facturacion.id_factura = facturas.id_factura WHERE (facturacion.id_viaje = @id_viaje) AND (facturas.Cancelada = 0)">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="SOPORTES">
                        <ItemTemplate>
                            <asp:Image ID="Image2" runat="server" ImageUrl="~/imagenes/ok.png" 
                                Visible="<%# bind('verificado') %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="orden" HeaderText="ORDEN" />
                    <asp:BoundField DataField="nombre" HeaderText="CLIENTE" />
                    <asp:BoundField DataField="ruta" HeaderText="RUTA" />
                    <asp:BoundField DataField="fecha" DataFormatString="{0:dd/MMM/yyyy}" 
                        HeaderText="FECHA SERVICIO" />
                    <asp:TemplateField HeaderText="FECHA CIERRE">
                        <ItemTemplate>
                            <asp:Label ID="lblFechaCierre" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TRAYECTOS">
                        <ItemTemplate>
                            <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsTrayectos" EnableModelValidation="True" GridLines="None" 
                                ShowHeader="False" SkinID="grdAnidado">
                                <AlternatingRowStyle ForeColor="Blue" />
                                <Columns>
                                    <asp:BoundField DataField="trayecto" HeaderText="trayecto" 
                                        SortExpression="trayecto" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsTrayectos" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                SelectCommand="SELECT llave_trayectos.trayecto FROM trayectos_asignados INNER JOIN llave_trayectos ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto INNER JOIN equipo_asignado ON trayectos_asignados.EquipoAsignadoId = equipo_asignado.id_equipo_asignado WHERE (equipo_asignado.ViajeId = @id_viaje) ORDER BY equipo_asignado.id_equipo_asignado">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CHOFER">
                        <ItemTemplate>
                            <asp:GridView ID="grdChofer" runat="server" BorderStyle="None" 
                                DataSourceID="sdsChofer" EnableModelValidation="True" GridLines="None" 
                                ShowHeader="False" AutoGenerateColumns="False">
                                <AlternatingRowStyle ForeColor="Blue" />
                                <Columns>
                                    <asp:BoundField DataField="primer_nombre" HeaderText="primer_nombre" 
                                        SortExpression="primer_nombre" />
                                    <asp:BoundField DataField="apellido_paterno" HeaderText="apellido_paterno" 
                                        SortExpression="apellido_paterno" />
                                </Columns>
                                <RowStyle BorderStyle="None" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsChofer" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                
                                
                                SelectCommand="SELECT personas.primer_nombre, personas.apellido_paterno FROM empleados INNER JOIN personas ON empleados.id_persona = personas.id_persona INNER JOIN equipo_asignado ON empleados.id_empleado = equipo_asignado.idEmpleado WHERE (equipo_asignado.ViajeId = @id_viaje) ORDER BY equipo_asignado.id_equipo_asignado">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="RENDIMIENTO (Fisico)">
                        <ItemTemplate>
                            <asp:Literal ID="ltlRendimiento" runat="server"></asp:Literal>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CAJA">
                        <ItemTemplate>
                            <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsCaja" EnableModelValidation="True" GridLines="None" 
                                ShowHeader="False">
                                <Columns>
                                    <asp:BoundField DataField="equipo" HeaderText="equipo" 
                                        SortExpression="equipo" />
                                    <asp:BoundField DataField="economico" HeaderText="economico" 
                                        SortExpression="economico" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsCaja" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                
                                
                                SelectCommand="SELECT tipo_equipos.equipo, equipo_operacion.economico FROM cajaAsignada INNER JOIN equipo_asignado ON cajaAsignada.EquipoAsignadoId = equipo_asignado.id_equipo_asignado INNER JOIN tipo_equipos INNER JOIN equipo_operacion ON tipo_equipos.id_tipo_equipo = equipo_operacion.id_tipo_equipo ON cajaAsignada.CajaId = equipo_operacion.id_equipo WHERE (equipo_asignado.ViajeId = @id_viaje)">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="RECOLECCIONES">
                        <ItemTemplate>
                            <asp:Literal ID="lblRecolecciones" runat="server"></asp:Literal>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TARIFA">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("tarifa") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:GridView ID="grdTarifa" runat="server" AutoGenerateColumns="False" 
                                EnableModelValidation="True" GridLines="None" ShowHeader="False" 
                                DataSourceID="sdsTarifaUnichofer">
                                <AlternatingRowStyle ForeColor="Blue" />
                                <Columns>
                                    <asp:BoundField DataField="tarifa" DataFormatString="{0:c0}" />
                                </Columns>
                            </asp:GridView>
                            <asp:GridView ID="Multichofer" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsTarifaMultichofer" EnableModelValidation="True" 
                                GridLines="None" ShowHeader="False">
                                <AlternatingRowStyle ForeColor="Blue" />
                                <Columns>
                                    <asp:BoundField DataField="primer_nombre" HeaderText="primer_nombre" 
                                        SortExpression="primer_nombre" />
                                    <asp:BoundField DataField="segundo_nombre" HeaderText="segundo_nombre" 
                                        SortExpression="segundo_nombre" />
                                    <asp:BoundField DataField="tarifa" DataFormatString="{0:c0}" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsTarifaMultichofer" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                
                                SelectCommand="SELECT     tarifas_trayectos.tarifa, personas.primer_nombre, personas.segundo_nombre
FROM         personas INNER JOIN
                      empleados ON personas.id_persona = empleados.id_persona INNER JOIN
                      equipo_asignado ON empleados.id_empleado = equipo_asignado.idEmpleado INNER JOIN
                      tipo_equipos INNER JOIN
                      tarifas_trayectos INNER JOIN
                      llave_trayectos ON tarifas_trayectos.id_trayecto = llave_trayectos.id_trayecto INNER JOIN
                      trayectos_asignados ON llave_trayectos.id_trayecto = trayectos_asignados.id_trayecto ON tipo_equipos.id_tipo_equipo = tarifas_trayectos.id_tipo_vehiculo AND 
                      tipo_equipos.id_tipo_equipo = tarifas_trayectos.id_tipo_vehiculo INNER JOIN
                      equipo_operacion ON tipo_equipos.id_tipo_equipo = equipo_operacion.id_tipo_equipo ON equipo_asignado.id_equipo_asignado = trayectos_asignados.EquipoAsignadoId AND 
                      equipo_asignado.id_equipo = equipo_operacion.id_equipo
                      WHERE (equipo_asignado.ViajeId = @id_viaje) ORDER BY equipo_asignado.idEmpleado">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="sdsTarifaUnichofer" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                
                                SelectCommand="SELECT tarifas_choferes.tarifa 
FROM viajes INNER JOIN precios ON viajes.id_relacion = precios.id_relacion 
INNER JOIN equipo_asignado ON viajes.id_viaje = equipo_asignado.ViajeId
INNER JOIN equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo 
INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo 
INNER JOIN tarifas_choferes ON tipo_equipos.id_tipo_equipo = tarifas_choferes.id_tipo_vehiculo 
INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta AND tarifas_choferes.id_ruta = dbo.llave_rutas.id_ruta 
INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa AND tarifas_choferes.id_cliente = dbo.empresas.id_empresa 
WHERE (viajes.id_viaje = @id_viaje) AND 
(viajes.id_viaje NOT IN 
(SELECT ea.ViajeId
FROM trayectos_asignados INNER JOIN equipo_asignado  AS ea ON trayectos_asignados.EquipoAsignadoId = ea.id_equipo_asignado))
ORDER BY equipo_asignado.idEmpleado">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="select">Actualizar Tarifa</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="% FACTURACIÓN">
                        <ItemTemplate>
                            <asp:Literal ID="ltrPorcentaje" runat="server"></asp:Literal>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        
        </ContentTemplate>
        <Triggers>
 <asp:AsyncPostBackTrigger ControlID="ibtnActualizarD" EventName="Click" />
 </Triggers>
    </asp:UpdatePanel>
        <asp:ModalPopupExtender ID="mdlTarifa" runat="server" 
        PopupControlID="Panel1" TargetControlID="lblMensaje" 
         Drag="True" DropShadow="True" PopupDragHandleControlID="Panel1">
        </asp:ModalPopupExtender>
    &nbsp;
            <asp:Panel ID="Panel1" runat="server" BackColor="White" 
        GroupingText="*Puede arrastrar esta ventana.">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                 <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                </ContentTemplate>
                    
                </asp:UpdatePanel>
               <asp:Button runat="server" ID="btnCerrar" Text="Cerrar" />
            </asp:Panel>

        
    <p>
        
        &nbsp;</p>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .style5
        {
            width: 388px;
        }
        .style7
        {
            width: 188px;
        }
        .style9
        {
            width: 190px;
        }
    </style>
</asp:Content>

