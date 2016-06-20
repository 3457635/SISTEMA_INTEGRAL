<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlViajesSinRegreso.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlViajesSinRegreso" %>
<h1>Viajes Sin Regreso</h1>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="sdsViajesSinRegreso" EnableModelValidation="True">
    <Columns>
        <asp:BoundField DataField="orden" HeaderText="ORDEN" ReadOnly="True" 
            SortExpression="orden" />
        <asp:BoundField DataField="nombre" HeaderText="CLIENTE" 
            SortExpression="nombre" />
        <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
        <asp:BoundField DataField="chofer" HeaderText="CHOFER" ReadOnly="True" 
            SortExpression="chofer" />
        <asp:BoundField DataField="economico" HeaderText="UNIDAD" 
            SortExpression="economico" />
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="sdsViajesSinRegreso" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="SELECT        CONVERT(nvarchar, Ordenes.ano) + '-' + CONVERT(nvarchar, Ordenes.consecutivo) + '-' + CONVERT(nvarchar, viajes.num_viaje) AS orden, 
                         dbo.empresas.nombre, dbo.llave_rutas.ruta, personas.primer_nombre + ' ' + personas.apellido_paterno AS chofer, equipo_operacion.economico
FROM            Ordenes INNER JOIN
                         viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN
                         precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                         dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN
                         dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                         equipo_asignado ON viajes.id_viaje = equipo_asignado.ViajeId INNER JOIN
                         empleados ON equipo_asignado.idEmpleado = empleados.id_empleado 
                         INNER JOIN
                         personas ON empleados.id_persona = personas.id_persona AND empleados.id_persona = personas.id_persona AND 
                         empleados.id_persona = personas.id_persona INNER JOIN 
                         equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo AND equipo_asignado.id_equipo = equipo_operacion.id_equipo AND 
                         equipo_asignado.id_equipo = equipo_operacion.id_equipo INNER JOIN
                         rutas ON dbo.llave_rutas.id_ruta = rutas.id_ruta INNER JOIN
                         ubicaciones ON rutas.id_ubicacion = ubicaciones.id_principal AND rutas.id_ubicacion = ubicaciones.id_principal
WHERE        (Ordenes.id_status = 2) AND 
(viajes.id_status = 2) AND 
(dbo.llave_rutas.redondo = 0) AND 
(Ordenes.id_orden NOT IN
                             (SELECT        Ordenes_1.id_orden
                               FROM            Ordenes AS Ordenes_1 INNER JOIN
                                                         viajes AS viajes_1 ON Ordenes_1.id_orden = viajes_1.id_orden
                               WHERE        (viajes_1.num_viaje = 2))) AND (equipo_operacion.id_tipo_equipo &lt;&gt; 107) AND (ubicaciones.ubicacion = 'Chihuahua') AND 
                         (rutas.id_tipo_arrivo = 1)">
</asp:SqlDataSource>

