<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlEvaluacionesPendientes.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlEvaluacionesPendientes" %>
<style type="text/css">
    .style1
    {
        font-family: Arial, Helvetica, sans-serif;
    }
</style>

<p>
    <br />
    <span class="style1"><strong>Viajes sin evaluación:</strong></span></p>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="sdsEvaluaciones" EnableModelValidation="True" 
    style="font-family: Arial, Helvetica, sans-serif">
    <Columns>
        <asp:BoundField DataField="ano" SortExpression="ano" />
        <asp:BoundField DataField="consecutivo" HeaderText="ORDEN" 
            SortExpression="consecutivo" />
        <asp:BoundField DataField="num_viaje" SortExpression="num_viaje" />
        <asp:BoundField DataField="fecha" HeaderText="FECHA" SortExpression="fecha" 
            DataFormatString="{0:d}" />
        <asp:BoundField DataField="economico" HeaderText="ECONOMICO" 
            SortExpression="economico" />
        <asp:BoundField DataField="primer_nombre" HeaderText="CHOFER" 
            SortExpression="primer_nombre" />
        <asp:BoundField DataField="apellido_paterno" 
            SortExpression="apellido_paterno" />
        <asp:BoundField DataField="inspectorFin" HeaderText="INSPECTOR" 
            SortExpression="inspectorFin" />
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="sdsEvaluaciones" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="SELECT        Ordenes.ano, Ordenes.consecutivo, viajes.num_viaje, equipo_operacion.economico, personas.primer_nombre, personas.apellido_paterno, fechas.fecha,
                             (SELECT        inspector
                               FROM            seguimiento
                               WHERE        (id_seguimiento IN
                                                             (SELECT        MAX(id_seguimiento) AS Expr1
                                                               FROM            seguimiento AS seguimiento_1
                                                               WHERE        (id_viaje = viajes.id_viaje)))) AS inspectorFin
FROM            equipo_asignado INNER JOIN                        
                         equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo INNER JOIN
                         viajes ON equipo_asignado.ViajeId = viajes.id_viaje INNER JOIN
                         Ordenes ON viajes.id_orden = Ordenes.id_orden INNER JOIN
                         empleados ON equipo_asignado.idEmpleado = empleados.id_empleado INNER JOIN
                         personas ON empleados.id_persona = personas.id_persona INNER JOIN
                         fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                         fechas ON fechas_viaje.id_fecha = fechas.id_fecha
WHERE        (fechas.tipo_fecha = 1) AND 
datepart(month, fecha)=@mes AND 
datepart(year, fecha)=@ano AND
(Ordenes.id_status = 4) AND 
                         (equipo_asignado.id_equipo_asignado NOT IN
                             (SELECT        idEquipoAsignado
                               FROM            rendimientos))
Order by fecha desc">
    <SelectParameters>
        <asp:Parameter Name="mes" />
        <asp:Parameter Name="ano" />
    </SelectParameters>
</asp:SqlDataSource>

