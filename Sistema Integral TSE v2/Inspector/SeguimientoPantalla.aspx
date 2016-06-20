<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="SeguimientoPantalla.aspx.vb" Inherits="Sistema_Integral_TSE_v45.SeguimientoPantalla" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Timer ID="Timer1" runat="server" />
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
        AssociatedUpdatePanelID="UpdatePanel6" DisplayAfter="5">
        <ProgressTemplate>
            <img alt="" class="style5" 
    src="../imagenes/updateProgress.gif" />
            Actualizando...</ProgressTemplate>
    </asp:UpdateProgress>
    <br />
    <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Label ID="Label1" runat="server" Text="Ultima Actualización: "></asp:Label>
            <asp:Label ID="lblActualizacion" runat="server"></asp:Label>
            <b>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                AutoGenerateColumns="False" DataKeyNames="id_viaje" DataSourceID="SqlViajes" 
                EnableModelValidation="True" PageSize="5" SkinID="GridView1" Width="100%" 
                Height="100%">
                <Columns>
                    <asp:BoundField DataField="id_viaje" >
                        <ItemStyle Font-Size="0pt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True" 
                        SortExpression="ORDEN" />
                    <asp:BoundField DataField="fecha" DataFormatString="{0:dd/MMM/yyyy}" 
                        HeaderText="FECHA INICIO" SortExpression="fecha" />
                    <asp:BoundField DataField="nombre" HeaderText="CLIENTE" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
                    <asp:TemplateField HeaderText="TRAYECTO">
                        <ItemTemplate>
                            <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsTrayecto" EnableModelValidation="True" SkinID="grdAnidado">
                                <Columns>
                                    <asp:BoundField DataField="trayecto" HeaderText="trayecto" 
                                        SortExpression="trayecto" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsTrayecto" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                
                                SelectCommand="SELECT llave_trayectos.trayecto FROM trayectos_asignados INNER JOIN llave_trayectos ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto INNER JOIN equipo_asignado ON trayectos_asignados.EquipoAsignadoId = equipo_asignado.id_equipo_asignado WHERE (equipo_asignado.ViajeId = @id_viaje)">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CHOFER">
                        <ItemTemplate>
                            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsChofer" EnableModelValidation="True" ShowHeader="False" 
                                SkinID="grdAnidado">
                                <Columns>
                                    <asp:BoundField DataField="primer_nombre" SortExpression="primer_nombre" />
                                    <asp:BoundField DataField="apellido_paterno" 
                                        SortExpression="apellido_paterno" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsChofer" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                
                                SelectCommand="SELECT personas.primer_nombre, personas.apellido_paterno FROM personas INNER JOIN empleados ON personas.id_persona = empleados.id_persona INNER JOIN equipo_asignado ON empleados.id_empleado = equipo_asignado.idEmpleado WHERE (equipo_asignado.ViajeId = @id_viaje)">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="UNIDAD">
                        <ItemTemplate>
                            <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsUnidad" EnableModelValidation="True" SkinID="grdAnidado">
                                <Columns>
                                    <asp:BoundField DataField="economico" HeaderText="economico" 
                                        SortExpression="economico" />
                                    <asp:BoundField DataField="equipo" HeaderText="equipo" 
                                        SortExpression="equipo" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsUnidad" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                
                                SelectCommand="SELECT equipo_operacion.economico, tipo_equipos.equipo FROM equipo_asignado INNER JOIN equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo WHERE (equipo_asignado.ViajeId = @id_viaje)">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CAJA">
                        <ItemTemplate>
                            <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsCaja" EnableModelValidation="True" SkinID="grdAnidado">
                                <Columns>
                                    <asp:BoundField DataField="economico" HeaderText="economico" 
                                        SortExpression="economico" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsCaja" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                SelectCommand="SELECT equipo_operacion.economico 
FROM equipo_operacion INNER JOIN equipo_asignado ON equipo_asignado.id_equipo = equipo_operacion.id_equipo INNER JOIN 
tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo 
WHERE (equipo_asignado.id_viaje = @id_viaje) ">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ULTIMO SEGUIMIENTO">
                        <ItemTemplate>
                            <asp:Label ID="lblSeguimiento" runat="server" ForeColor="Black"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlViajes" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS ORDEN,
 viajes.id_viaje, dbo.llave_rutas.ruta, dbo.empresas.nombre, fechas.fecha
 FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden 
INNER JOIN precios ON viajes.id_relacion = precios.id_relacion 
INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta 
INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa
 INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje 
INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha 
WHERE (viajes.id_status = 2) 
AND (fechas.tipo_fecha = 1) and viajes.id_viaje in 
(SELECT     id_viaje
FROM         seguimiento) ORDER BY fechas.fecha,ordenes.consecutivo"></asp:SqlDataSource>
            </b>
        </ContentTemplate>
        <triggers>
            <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
        </triggers>
    </asp:UpdatePanel>
    <b>
    <br />
    </b>
        
        <p>
            &nbsp;</p>
    
   
    
         </asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .style5
        {
            width: 48px;
            height: 48px;
        }
    </style>
</asp:Content>

