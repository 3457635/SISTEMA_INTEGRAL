Public Class salidaVehiculo2
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack And Session("activarControl") = 1 Then
            'agregarUsrControl()

        End If
    End Sub

    'Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click

    '    Dim idEquipo As Integer = ddlUnidad.SelectedValue
    '    Dim idChofer As Integer = ddlChofer.SelectedValue
    '    Dim idOrdenSalida As Integer = obtenerOrdenDeSalida(idEquipo, idChofer)
    '    Dim odometroInicio = txbOdometro.Text

    '    If idOrdenSalida <> 0 Then
    '        registraInfo(idOrdenSalida, idEquipo, idChofer, odometroInicio)
    '        lblMensaje.Text = "Listo!"
    '        GridView2.DataBind()
    '    Else
    '        idOrdenSalida = buscarOrdenPorChofer(idChofer)
    '        If idOrdenSalida <> 0 Then
    '            cambiarEquipoEnOrden(idEquipo, idChofer, idOrdenSalida)
    '            registraInfo(idOrdenSalida, idEquipo, idChofer, odometroInicio)
    '            lblMensaje.Text = "Listo! Se actualizó la unidad en la orden de servicio ya que estaba registrada con otra unidad."
    '            GridView2.DataBind()
    '        Else
    '            lblMensaje.Text = "Es imposible localizar la orden de salida. Verifique que el chofer o la unidad sean correctos."
    '            lnkModificar.Visible = True
    '        End If
    '    End If

    'End Sub
    'Private Sub registraInfo(ByVal idOrdenSalida As Integer, ByVal idEquipo As Integer, ByVal idChofer As Integer, ByVal odometroInicio As Integer)

    '    Dim MemUser As MembershipUser
    '    MemUser = Membership.GetUser(User.Identity.Name)
    '    Dim ejes_salida As String = ddlEjesSalida.SelectedValue

    '    Try
    '        Dim inspector As String = MemUser.UserName.ToString()
    '        Dim tipo_trayecto = 1 ''Trayecto de inicio

    '        ''Reporte Fallas
    '        If Not String.IsNullOrEmpty(txbAveria.Text) Then
    '            Dim falla = txbAveria.Text

    '            Dim buscarIdAsignacion = (From consulta In db.equipo_asignados
    '                                   Where consulta.id_equipo = idEquipo And
    '                                   consulta.recursos_asignado.id_empleado = idChofer And
    '                                   consulta.recursos_asignado.viaje.Ordene.id_orden = idOrdenSalida
    '                                   Select consulta).FirstOrDefault()

    '            If Not buscarIdAsignacion Is Nothing Then
    '                Dim idAsignacion = buscarIdAsignacion.id_asignacion

    '                Dim existe = existe_falla(idAsignacion, True)

    '                If String.IsNullOrEmpty(existe) Then
    '                    nueva_falla(idAsignacion, True, falla)
    '                Else
    '                    actualizar_falla(True, falla, idAsignacion)
    '                End If
    '                txbAveria.Text = String.Empty
    '            End If

    '        End If



    '        txbOdometro.Text = String.Empty

    'Dim existe_odometro_salida = buscar_odometro(idOrdenSalida, idEquipo, idChofer, 1)

    ''Si en el viaje se sacan 2 evaluacion debido a los trayectos el odometro perteneceria a la misma orden
    ''entonces verificamos si no existe un mismo odometro de llegada para determinar si se esta
    ''registrando un segundo odometro de salida, en ese caso hay que registrar un nuevo odometro y no actualizar el primero.

    'Dim esContinuacion = esContinuacionDeViaje(idEquipo, odometroInicio)
    'If existe_odometro_salida <> 0 And Not esContinuacion Then
    '    actualizar_odometro(idOrdenSalida, idEquipo, idChofer, 1, odometroInicio, ejes_salida)
    'Else
    'End If

    'Dim salida = 1

    'Dim idEvaluacion = obtenerIdEvaluacion(idOrdenSalida, odometroInicio, salida)

    'Dim folio = obtenerFolioAgrupacion()
    'Dim primerPunto = 1
    'Dim idEvaluacion = crearAgrupacion(primerPunto, folio)

    'If idEvaluacion = 0 Then
    '    Dim asignarNuevoFolio = unidadIniciaOTerminaRecorrido(idOrdenSalida, idEquipo, salida)

    '    If asignarNuevoFolio Then

    '    Else
    '        Dim idOrdenAnterior = buscarOrdenEnSeguimiento(idEquipo, 3)
    '        idEvaluacion = obtenerIdEvaluacion(idOrdenAnterior)
    '    End If
    'End If

    'asignarAgrupacionAOrden(idOrdenSalida, idEvaluacion)
    'nuevo_odometro_eje(inspector, idOrdenSalida, idEquipo, idChofer, odometroInicio, tipo_trayecto, ejes_salida, idEvaluacion)


    '    Catch ex As Exception

    '        Response.Redirect("~/Default.aspx")
    '    End Try








    'End Sub

    'Protected Sub ddlChofer_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlChofer.SelectedIndexChanged

    'End Sub

    'Protected Sub lnkModificar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkModificar.Click

    '    mdlOrdenes.Controls.Clear()
    '    agregarUsrControl()
    'End Sub

    'Public Sub agregarUsrControl()
    '    mdlOrdenes.Show()
    '    Session("activarControl") = 1
    '    Dim usrCtrl As UserControl = LoadControl("~/Controles_Usuario/ctlModificarRecursos.ascx")
    '    PlaceHolder1.Controls.Add(usrCtrl)

    'End Sub


    'Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
    '    Session("activarControl") = 0
    '    mdlOrdenes.Hide()

    'End Sub

    'Protected Sub ddlUnidad_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.DataBound
    '    ddlUnidad.Items.Add(Crear_item("Seleccionar...", 0))
    'End Sub

    'Protected Sub ddlChofer_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlChofer.DataBound
    '    ddlChofer.Items.Add(Crear_item("Seleccionar...", 0))
    'End Sub

    'Protected Sub ddlUnidad_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.SelectedIndexChanged
    '    Dim idEquipo As Integer = ddlUnidad.SelectedValue
    '    Dim idChofer As Integer = ddlChofer.SelectedValue
    '    Dim idOrdenSalida As Integer = obtenerOrdenDeSalida(idEquipo, idChofer)
    '    sdsOdometroSalida.SelectParameters(0).DefaultValue = idOrdenSalida
    '    sdsOdometroSalida.SelectParameters(1).DefaultValue = idEquipo
    '    sdsUltimoOdometro.SelectParameters(0).DefaultValue = idEquipo
    'End Sub
End Class