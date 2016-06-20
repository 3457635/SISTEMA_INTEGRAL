Imports System.Data.SqlClient
Partial Public Class Cierre_Viaje2
    Inherits System.Web.UI.Page

    Dim query As String
    Dim odometro_regreso As String
    Dim db As New DataClasses1DataContext()
    Dim viaje_pendiente_de_seguimiento As Boolean = False
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            
            ddlEstacion.SelectedValue = 2
            'recarga_en_base()
        End If

    End Sub


    'Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarOdometro.Click
    '    odometro_regreso = txbOdometro.Text
    '    Dim idEquipo = ddlUnidad.SelectedValue
    '    Dim idChofer = ddlChofer.SelectedValue
    '    Dim odometroRegreso = 0
    '    Dim odometroSalida = obtenerOdometro(idEquipo, 1)
    '    Dim kmsRecorridos = 0
    '    Dim puntoAgrupacionSalida = obtenerPuntoSalida(idEquipo)



    '    If odometroSalida <> 0 And IsNumeric(txbOdometro.Text) Then
    '        odometroRegreso = txbOdometro.Text
    '        kmsRecorridos = odometroRegreso - odometroSalida

    '        Dim idOrdenSalida = obtenerOrdenConOdometro(odometroSalida, idEquipo, 1)
    '        Dim destino = 3
    '        Dim idOrdenRegreso = buscarOrdenEnSeguimiento(idEquipo, destino)

    '        txbIdOrdenRegreso.Text = idOrdenRegreso

    '        If idOrdenRegreso <> 0 Then
    '            Dim idEvaluacion = obtenerIdEvaluacion(odometroSalida, 1)

    '            If idEvaluacion <> 0 Then
    '                asignarAgrupacionAOrden(idOrdenRegreso, idEvaluacion)

    '                Dim fechaSalida = obtenerFechaOrden(idOrdenSalida)
    '                Dim fechaRegreso = obtenerFechaOrden(idOrdenRegreso)

    '                Dim MemUser As MembershipUser
    '                Try
    '                    MemUser = Membership.GetUser(User.Identity.Name)
    '                    Dim inspector = MemUser.UserName.ToString()
    '                    Dim ejes As String = ddlEjesRegreso.SelectedValue
    '                    Dim fecha As String = DateTime.Now.AddHours(-1)

    '                    Dim tipo_trayecto = 2

    '                    nuevo_odometro_eje(inspector, idOrdenRegreso, idEquipo, idChofer, odometro_regreso, 2, ejes, idEvaluacion)

    '                    lblAnuncio.Text = "Odometro: " + txbOdometro.Text + " Ejes:" + ejes
    '                Catch

    '                    Response.Redirect("~/default.aspx")
    '                End Try
    '            End If

    '        Else
    '            lblAnuncio.Text = "Es imposible encontrar la orden de servicio."
    '        End If


    '    End If




    'End Sub


    'Protected Sub btnGuardarRecargas_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarRecargas.Click
    '    Dim litros As String = txbLitros.Text
    '    Dim id_orden As String = String.Empty
    '    Dim estacion As String = ddlEstacion.SelectedValue
    '    Dim idEquipo = ddlUnidad.SelectedValue
    '    Dim idChofer = ddlChofer.SelectedValue
    '    Dim destino = 3
    '    Dim idOrdenRegreso = buscarOrdenEnSeguimiento(idEquipo, destino)
    '    txbIdOrdenRegreso.Text = idOrdenRegreso

    '    Dim odometroSalida = obtenerOdometro(idEquipo, 1)
    '    Dim idOrdenSalida = obtenerOrdenConOdometro(odometroSalida, idEquipo, 1)


    '    Dim idEvaluacion = obtenerIdEvaluacion(idOrdenSalida)

    '    If idEvaluacion <> 0 Then

    '        lblMensaje2.Text = ""
    '        If idOrdenSalida <> 0 Then
    '            If estacion <> "2" Then
    '                Dim cantidad As String = txbPesosCombustible.Text
    '                Dim ticket As String = txbTicketCombustible.Text
    '                Dim descripcion_gasto = "Recarga combustible orden."
    '                'nueva_recarga_externa(cantidad, ticket, descripcion_gasto, estacion, litros, idEvaluacion, idChofer, idEquipo, idOrdenRegreso)
    '            Else
    '                nueva_recarga_Interna(estacion, litros, idEvaluacion, idChofer, idEquipo, idOrdenRegreso)
    '            End If

    '            'actualizar_indicadores(id_asignacion)

    '            txbPesosCombustible.Text = ""
    '            txbLitros.Text = ""
    '            txbTicketCombustible.Text = ""
    '        Else
    '            lblMensaje2.Text = "No se encotró la orden de servicio."
    '        End If



    '    Else
    '        lblMensaje2.Text = "Es probable que el odometro de inicio no se registró."
    '    End If
    'End Sub



    'Protected Sub ddlEstacion_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEstacion.SelectedIndexChanged
    '    If ddlEstacion.SelectedValue = "2" Then
    '        recarga_en_base()
    '    Else

    '        txbPesosCombustible.Enabled = "true"
    '        txbTicketCombustible.Enabled = "true"
    '        txbLitros.BackColor = Drawing.Color.White
    '    End If
    'End Sub

    'Protected Sub recarga_en_base()
    '    txbPesosCombustible.Enabled = "false"
    '    txbTicketCombustible.Enabled = "false"
    '    txbLitros.BackColor = Drawing.Color.Aqua
    'End Sub


    'Protected Sub actualizar_indicadores(ByVal id_asignacion As Integer)
    '    Dim idUnidad = ddlUnidad.SelectedValue
    '    Dim odometroInicio = obtenerOdometro(idUnidad, 1)
    '    Dim odometroFin = obtenerOdometro(idUnidad, 2)



    '    Dim BuscarAsignacion = (From consulta In db.equipo_asignados
    '                         Where consulta.recursos_asignado.id_asignacion = id_asignacion And
    '                         consulta.equipo_operacion.id_tipo_equipo < 107
    '                         Select consulta).FirstOrDefault()

    '    If Not BuscarAsignacion Is Nothing Then
    '        Dim idEquipo = BuscarAsignacion.id_equipo
    '        Dim idChofer = BuscarAsignacion.recursos_asignado.id_empleado
    '        Dim idOrden = BuscarAsignacion.recursos_asignado.viaje.id_orden

    '        Dim kms As Integer
    '        SqlDataSource2.SelectParameters(0).DefaultValue = idOrden
    '        SqlDataSource2.SelectParameters(1).DefaultValue = idChofer
    '        SqlDataSource2.SelectParameters(2).DefaultValue = idEquipo

    '        SqlDataSource6.SelectParameters(0).DefaultValue = idOrden
    '        SqlDataSource6.SelectParameters(1).DefaultValue = idChofer
    '        SqlDataSource6.SelectParameters(2).DefaultValue = idEquipo

    '        GridView1.DataBind()
    '        GridView2.DataBind()

    '        Dim odometro_regreso = buscar_odometro(idOrden, idEquipo, idChofer, 2)
    '        Dim odometro_inicio = buscar_odometro(idOrden, idEquipo, idChofer, 1)

    '        txbOdometro.Text = odometro_regreso
    '        kms = odometro_regreso - odometro_inicio
    '        lblKms.Text = String.Format("{0:N}", kms)

    '        Dim buscar_recargas_externas = From consulta2 In db.recargas_externas, consulta3 In db.liquidaciones
    '                                           Where consulta2.gasto.id_gasto = consulta3.id_gasto And
    '                                           consulta2.recargas_combustible.id_chofer = idChofer And
    '                                           consulta2.recargas_combustible.id_equipo = idEquipo And
    '                                           consulta3.id_orden = idOrden
    '                                           Select consulta2

    '        Dim lts_total As Decimal = 0
    '        Dim costo As Decimal = 0

    '        For Each recarga In buscar_recargas_externas

    '            costo += recarga.gasto.cantidad
    '            lblPesosRecarga.Text = String.Format("{0:c2}", costo)

    '            lts_total += recarga.recargas_combustible.lts
    '            lblTotalLitros.Text = String.Format("{0:N}", lts_total)

    '        Next

    '        Dim buscar_recargas_internas = From consulta In db.recargas_internas
    '                                      Where consulta.recargas_combustible.id_chofer = idChofer And
    '                                      consulta.recargas_combustible.id_equipo = idEquipo And
    '                                      consulta.id_orden = idOrden
    '                                      Select consulta

    '        For Each recarga In buscar_recargas_internas
    '            lts_total += recarga.recargas_combustible.lts
    '            lblTotalLitros.Text = String.Format("{0:N}", lts_total)
    '        Next

    '        Dim Rendimiento As Decimal = 0
    '        If kms <> 0 And lts_total <> 0 Then
    '            Rendimiento = kms / lts_total
    '            lblRendimiento.Text = String.Format("{0:N}", Rendimiento)
    '        End If
    '    End If



    'End Sub
    'Public Sub Obtener_rendimiento(ByVal idChofer As Integer,
    '                              ByVal idUnidad As Integer,
    '                              ByVal odometroInicio As Integer,
    '                              ByVal odometroFin As Integer)


    '    Dim trayectoSalida = 1
    '    Dim trayectoRegreso = 2

    '    Dim kms As Integer = 0
    '    If odometroInicio <> 0 And odometroFin <> 0 Then
    '        kms = odometroFin - odometroInicio
    '    End If

    '    Dim idEvaluacion = obtenerIdEvaluacion(odometroInicio, 1)

    '    Dim Recargas = ObtenerRecargas(idEvaluacion)

    '    Dim costo As Decimal = 0
    '    Dim Rendimiento As Decimal = 0

    '    If kms <> 0 And Recargas <> 0 Then
    '        Rendimiento = kms / Recargas
    '    End If

    '    Dim Economico = ObtenerEconomicoUnidad(idUnidad)

    'End Sub
    'Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView2.SelectedIndexChanged
    '    Dim id_recarga_externa = GridView2.SelectedDataKey.Value.ToString()


    '    Dim borrar_recarga_combustible = (From consulta In db.recargas_combustibles, consulta2 In db.liquidaciones
    '                                   Where consulta.id_recarga = id_recarga_externa
    '                                   Select consulta).FirstOrDefault()

    '    db.recargas_combustibles.DeleteOnSubmit(borrar_recarga_combustible)
    '    db.SubmitChanges()
    '    GridView2.DataBind()
    'End Sub

    'Protected Sub lnkCierreViaje_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkCierreViaje.Click
    '    If Not String.IsNullOrEmpty(txbIdAsignacion.Text) Then
    '        Dim id_asignacion = txbIdAsignacion.Text
    '        Dim buscar_asignacion = (From consulta In db.recursos_asignados
    '                              Where consulta.id_asignacion = id_asignacion
    '                              Select consulta).FirstOrDefault()
    '        Dim id_viaje As Integer = 0
    '        If Not buscar_asignacion Is Nothing Then
    '            id_viaje = buscar_asignacion.id_viaje
    '        End If

    '        cerrar_viaje_local(id_viaje)

    '    End If
    'End Sub

    'Protected Sub txbFin_Click(ByVal sender As Object, ByVal e As EventArgs) Handles txbFin.Click

    '    Dim idOrden = txbIdOrden.Text

    '    Dim idAsignacion = txbIdAsignacion.Text

    '    If Not String.IsNullOrEmpty(idOrden) And Not String.IsNullOrEmpty(idAsignacion) Then

    '        Dim buscarIdViaje = (From consulta In db.recursos_asignados
    '                            Where consulta.id_asignacion = idAsignacion
    '                            Select consulta).FirstOrDefault()

    '        If Not buscarIdViaje Is Nothing Then

    '            Dim idViaje = buscarIdViaje.id_viaje

    '            If Not idOrden = String.Empty Then

    '                Dim margen = nuevoMargen(idViaje)

    '                If margen < 40 Or margen >= 60 Then
    '                    Dim viaje = crear_info_viaje(idViaje)
    '                    Dim recursos = crear_info_equipo(idViaje)

    '                    Dim encabezado = "Margen por debajo del 40%"
    '                    If margen >= 60 Then
    '                        encabezado = "Margen por arriba del 60%"
    '                    End If

    '                    Dim buscarMargen = (From consulta In db.margens
    '                                     Where consulta.idViaje = idViaje
    '                                     Select consulta).FirstOrDefault()
    '                    Dim costos = String.Empty
    '                    If Not buscarMargen Is Nothing Then

    '                        Dim costoCombustible = String.Format("{0:c}", buscarMargen.combustible)
    '                        Dim costoChoferes = String.Format("{0:c}", buscarMargen.choferes)
    '                        Dim costoCasetas = String.Format("{0:c}", buscarMargen.casetas)
    '                        Dim precio = String.Format("{0:c}", buscarMargen.viaje.precio.precio)
    '                        Dim margenTotal = buscarMargen.margen
    '                        Dim montoTotal = String.Format("{0:c}", buscarMargen.monto)

    '                        costos = "<TABLE>"
    '                        costos += "<TR><TD>COMBUSTIBLE</TD><TD>" + costoCombustible + "</TD></TR>"
    '                        costos += "<TR><TD>CHOFER(ES)</TD><TD>" + costoChoferes + "</TD></TR>"
    '                        costos += "<TR><TD>CASETAS</TD><TD>" + costoCasetas + "</TD></TR>"
    '                        costos += "<TR><TD>PRECIO</TD><TD>" + precio + "</TD></TR>"
    '                        costos += "<TR><TD>MARGEN</TD><TD>" + margenTotal.ToString + "%</TD></TR>"
    '                        costos += "<TR><TD>MONTO</TD><TD>" + montoTotal + "</TD></TR>"
    '                        costos += "</TABLE>"
    '                    End If
    '                    Dim body = viaje + "<br>" + recursos + "<br>" + costos

    '                    ''EnviarCorreo("sistemas@tse.com.mx,trafico@tse.com.mx,rhumanos@tse.com.mx,contabilidad@tse.com.mx,auditoria@tse.com.mx",encabezado,
    '                    '             body)
    '                End If
    '                Response.Redirect("~/inspector/EvaluacionChofer.aspx?idOrden=" + idOrden)
    '            Else
    '                lblMensaje.Text = "Seleccione la unidad."
    '                lblMensaje2.Text = "Seleccione la unidad."
    '            End If


    '        End If
    '    End If



    'End Sub





    'Protected Sub txbFin_Click(ByVal sender As Object, ByVal e As EventArgs) Handles txbFin.Click
    '    Dim idChofer = ddlChofer.SelectedValue
    '    Dim idEquipo = ddlUnidad.SelectedValue

    '    If idChofer <> 0 And idEquipo <> 0 Then
    '        Response.Redirect(String.Format("~/inspector/EvaluacionChofer2.aspx?idChofer={0}&idUnidad={1}", idChofer, idEquipo))
    '    Else
    '        lblMensaje.Text = "Seleccione Unidad y Chofer."
    '        lblMensaje2.Text = "Seleccione Unidad y Chofer"
    '    End If

    'End Sub

    'Protected Sub btnGuardarAveria_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarAveria.Click
    '    ''Reporte Fallas
    '    If Not String.IsNullOrEmpty(txbFalla.Text) Then
    '        Dim falla = txbFalla.Text
    '        Dim idEquipo = ddlUnidad.SelectedValue
    '        Dim idChofer = ddlChofer.SelectedValue
    '        Dim idOrdenRegreso = txbIdOrdenRegreso.Text

    '        Dim buscarIdAsignacion = (From consulta In db.equipo_asignados
    '                               Where consulta.id_equipo = idEquipo And
    '                               consulta.recursos_asignado.id_empleado = idChofer And
    '                               consulta.recursos_asignado.viaje.Ordene.id_orden = idOrdenRegreso
    '                               Select consulta).FirstOrDefault()

    '        If Not buscarIdAsignacion Is Nothing Then
    '            Dim idAsignacion = buscarIdAsignacion.id_asignacion

    '            Dim existe = existe_falla(idAsignacion, True)

    '            If String.IsNullOrEmpty(existe) Then
    '                nueva_falla(idAsignacion, True, falla)
    '            Else
    '                actualizar_falla(True, falla, idAsignacion)
    '            End If
    '            txbFalla.Text = String.Empty
    '        End If

    '    End If
    'End Sub

    'Protected Sub ddlUnidad_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.SelectedIndexChanged
    '    Dim idEquipo = ddlUnidad.SelectedValue
    '    Dim odometroSalida = obtenerOdometro(idEquipo, 1)
    '    Dim idOrdenSalida = obtenerOrdenConOdometro(odometroSalida, idEquipo, 1)

    '    Dim idEvaluacion = obtenerIdEvaluacion(odometroSalida, 1)

    '    sdsRecargasInternas.SelectParameters(0).DefaultValue = idEvaluacion
    '    sdsRecargasExternas.SelectParameters(0).DefaultValue = idEvaluacion
    '    sdsOdometros.SelectParameters(0).DefaultValue = idEvaluacion




    'End Sub


    'Protected Sub ddlChofer_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlChofer.DataBound
    '    ddlChofer.Items.Add(Crear_item("Seleccionar...", 0))
    'End Sub

    'Protected Sub ddlUnidad_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.DataBound
    '    ddlUnidad.Items.Add(Crear_item("Seleccionar...", 0))
    'End Sub
End Class