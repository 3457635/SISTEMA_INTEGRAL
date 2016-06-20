Imports System.Globalization
Imports System.Net
Imports System.IO

Public Class OrdenMail
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id_viaje = Request("id_viaje")

        If id_viaje Is Nothing Then
            id_viaje = 915
        End If
        sdsDestinos.SelectParameters(0).DefaultValue = id_viaje

        Dim buscarGuia = (From consulta In db.guias
                       Where consulta.id_viaje = id_viaje
                       Select consulta).FirstOrDefault()
        If Not buscarGuia Is Nothing Then
            lblGuia.Text += String.Format("Guía: {0}", buscarGuia.guia)
        End If


        Dim orden = (From consulta In db.fechas_viajes
                   Where consulta.viaje.id_viaje = id_viaje
                   Select consulta.viaje.Ordene.ano,
                   consulta.viaje.Ordene.consecutivo,
                   consulta.viaje.num_viaje,
                   consulta.fecha.fecha,
                   consulta.viaje.precio.empresa.nombre,
                   contacto = consulta.viaje.contacto.persona.primer_nombre + " " + consulta.viaje.contacto.persona.apellido_paterno,
                   consulta.viaje.precio.llave_ruta.ruta).FirstOrDefault()

        lblOrden.Text = String.Format("{0}-{1}-{2}", orden.ano, orden.consecutivo, orden.num_viaje)

        Dim dia As Date = orden.fecha

        lblFechaServicio.Text = dia.ToString("dd/MM/yyyy")
        lblDia.Text = StrConv(dia.ToString("dddd", New CultureInfo("es-Es")), VbStrConv.ProperCase)
        lblHora.Text = String.Format("{0:HH:mm}", dia)

        lblCliente.Text = orden.nombre
        lblRuta.Text = orden.ruta
        lblContacto.Text = orden.contacto

        Dim choferes = From consultas In db.equipo_asignados
                      Where consultas.ViajeId = id_viaje
                      Order By consultas.id_equipo_asignado
                      Select CHOFER = consultas.empleado.persona.primer_nombre + " " + consultas.empleado.persona.apellido_paterno

        grdChoferes.DataSource = choferes
        grdChoferes.ShowHeader = False
        grdChoferes.DataBind()

        Dim trayectos = From consultas In db.trayectos_asignados
                        Where consultas.equipo_asignado.ViajeId = id_viaje
                        Order By consultas.equipo_asignado.id_equipo_asignado
                        Select consultas.llave_trayecto.trayecto

        grdTrayectos.DataSource = trayectos
        grdTrayectos.DataBind()

        Dim equipo_asignado = From consulta In db.recorridoEquipos
                     Where consulta.equipo_asignado.ViajeId = id_viaje
                     Select ECONOMICO = consulta.equipo_asignado.equipo_operacion.economico,
                     TIPO = consulta.equipo_asignado.equipo_operacion.tipo_equipo.equipo,
                     PLACAS = consulta.equipo_asignado.equipo_operacion.placa,
                     MARCA = consulta.equipo_asignado.equipo_operacion.marca.marca,
                     AÑO = consulta.equipo_asignado.equipo_operacion.ano,
                     RECORRIDO = consulta.grupo

        grdEquipo.DataSource = equipo_asignado
        grdEquipo.DataBind()



    End Sub

End Class