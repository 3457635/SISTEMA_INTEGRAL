Public Class Liquidacion
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id_viaje = Request("id_viaje")
        If id_viaje = "" Then
            id_viaje = 915
        End If
        Dim orden = (From consulta In db.fechas_viajes
                    Where consulta.viaje.id_viaje = id_viaje
                    Select consulta.viaje.Ordene.ano,
                    consulta.viaje.Ordene.consecutivo,
                    consulta.viaje.num_viaje,
                    consulta.fecha.fecha,
                    consulta.viaje.precio.empresa.nombre,
                    contacto = consulta.viaje.contacto.persona.primer_nombre + " " + consulta.viaje.contacto.persona.apellido_paterno,
                    consulta.viaje.precio.llave_ruta.ruta).First()
        lblCliente.Text = orden.nombre
        Dim fecha_servicio As Date = orden.fecha
        lblFecha.Text = fecha_servicio.ToString("dd/MM/yyyy")
        lblOrden.Text = orden.ano.ToString() + "-" + orden.consecutivo.ToString() + "-" + orden.num_viaje.ToString()
        lblRuta.Text = orden.ruta
        Dim choferes = From consulta In db.equipo_asignados
                     Where consulta.ViajeId = id_viaje
                     Select consulta.empleado.persona.primer_nombre + " " + consulta.empleado.persona.apellido_paterno

        grdChofer.DataSource = choferes
        grdChofer.DataBind()
        Dim equipo_asignado = From consulta In db.equipo_asignados
                   Where consulta.ViajeId = id_viaje
                   Select consulta.equipo_operacion.economico,
                   consulta.equipo_operacion.tipo_equipo.equipo

        grdEquipo.DataSource = equipo_asignado
        grdEquipo.DataBind()

        sdsCaja.SelectParameters(0).DefaultValue = id_viaje
    End Sub

End Class