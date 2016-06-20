Imports System.Data.SqlClient


Public Class WebForm2
    Inherits System.Web.UI.Page
    Protected WithEvents etiqueta As System.Web.UI.WebControls.Label
    Dim db As New DataClasses1DataContext()
    Dim mandar_alertas_retraso As Boolean
    Dim proxy As New wcfRef1.Service1Client()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.Year

            reportar_viaje_sin_seguimiento()




        Else
            If Session("arrivos") = 1 Then
                Dim micontrol As UserControl = LoadControl("~/Controles_Usuario/ctlPuntosArrivo.ascx")
                phrSeguimiento.Controls.Add(micontrol)

            End If
            If Session("arrivos") = 2 Then
                Dim micontrol As UserControl = LoadControl("~/Controles_Usuario/ctlTiposPausas.ascx")
                phrSeguimiento.Controls.Add(micontrol)

            End If
            If Session("panelSeguimiento") = 1 Then

                mdlHolder.Show()
            End If
        End If
        '  Dim fecha As Date = Now.AddHours(-6).ToString("d") 'Cambio a 7 horas 09 de nov 2015


    End Sub
   
    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView1.SelectedIndexChanged
        lblAnuncio.Text = String.Empty
        lblAnuncio.BackColor = Drawing.Color.White
        Dim row As GridViewRow = GridView1.SelectedRow
        Dim id_viaje As String = row.Cells(1).Text
        btnGuardar1.Enabled = True
        lblAnuncio.Text = String.Empty
        txbIdViaje.Text = id_viaje
        sdsInfoViaje.SelectParameters(0).DefaultValue = id_viaje

        Dim buscar_empresa = (From consulta In db.viajes
                           Where consulta.id_viaje = id_viaje
                           Select consulta).FirstOrDefault()

        If Not buscar_empresa Is Nothing Then
            Dim id_empresa = buscar_empresa.precio.id_empresa
            sdsArrivos.SelectParameters(0).DefaultValue = id_empresa
            ddlArrivos.DataBind()
            SqlSeguimiento.SelectParameters(0).DefaultValue = id_viaje
        End If

        GridView2.DataBind()
        lblHora.BackColor = Drawing.Color.White
        mandar_alertas_retraso = False

        Dim existe = existeTablaPuntosPorRecorrer(id_viaje)

        If Not existe Then
            actualizar_seguimiento2(id_viaje)
        Else
            sdsPuntoPendientes.SelectParameters(0).DefaultValue = id_viaje
            grdPuntosPendientes.DataBind()

            Dim siguientePunto = (From consulta In db.seguimientoPorRecorrers
                               Where consulta.idViaje = id_viaje
                               Select consulta).FirstOrDefault()

            If Not siguientePunto Is Nothing Then
                Label1.Text = siguientePunto.ubicacion
                lblHora.Text = siguientePunto.hora
                txbIdUbicacion1.Text = siguientePunto.UbicacionId
            End If
        End If


        Session("panelSeguimiento") = 1
        mdlHolder.Show()



    End Sub


    



    Protected Sub btnGuardar1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar1.Click
        lblAnuncio.Text = String.Empty
        lblAnuncio2.Text = String.Empty
        lblAnuncio.BackColor = Drawing.Color.White
        mandar_alertas_retraso = True
        Dim id_viaje As String = txbIdViaje.Text
        Dim errorAlGuardar = String.Empty
        Dim enviarSeguimientoPorDefault = False
        Dim enviarSeguimientoPersonalizado = False




        Dim hora As String = String.Empty
        ''Hora de salida o de llegada
        If rbtnSalida.Checked Then
            hora = txbSalida.Text
        Else
            hora = TextBox1.Text
        End If

        Dim fecha As String = Now.AddHours(-7).ToString("d") + " " + hora 'Cambio a 7 horas 09 de nov 2015



        If proxy.seguimientoVacio(id_viaje) Then
            Dim buscarViaje = proxy.buscarViajePorId(id_viaje)

            If Not buscarViaje Is Nothing Then
                buscarViaje.inicioReal = fecha

                proxy.actualizarViaje(buscarViaje)
            End If

        End If


        ''Seguimiento personalizado
        Dim buscarRutaEmpresa = (From consulta In db.viajes
                                  Where consulta.id_viaje = id_viaje
                                  Select consulta).FirstOrDefault()
        Dim EmpresaId = 0
        Dim RutaId = 0

        If Not buscarRutaEmpresa Is Nothing Then
            EmpresaId = buscarRutaEmpresa.precio.id_empresa
            RutaId = buscarRutaEmpresa.precio.id_ruta
        End If

        If User.Identity.IsAuthenticated Then

            Dim inspector As String = String.Empty
            Try
                inspector = User.Identity.Name
            Catch
                Response.Redirect("~/Default.aspx")
            End Try
            Dim es_llegada As Boolean = True

            If rbtLlegada.Checked Then
                es_llegada = True
            Else
                es_llegada = False
            End If



            ''Si llegamos con el cliente
            If rbtnArrivo.Checked Then
                Dim idArrivo = ddlArrivos.SelectedValue
                If idArrivo <> 0 Then
                    ''Solo avisamos cuando sea una llegada
                    If rbtLlegada.Checked Then

                        If buscarRutaEnNotificacionesPersonalizadas(EmpresaId, RutaId) Then
                            enviarSeguimientoPersonalizado = True
                        Else
                            enviarSeguimientoPorDefault = True
                        End If


                        ''Trafico registra las horas de llegada con el cliente 
                        ''aqui obtenemos la diferencia de tiempo con la que llego realmente
                        Dim diferencia = obtenerDiferenciaDestinos(idArrivo, id_viaje, fecha)

                    End If
                    errorAlGuardar = nuevoArribo(id_viaje, txbObservacion1.Text, inspector, idArrivo, fecha, es_llegada)


                    If Not String.IsNullOrEmpty(errorAlGuardar) Then
                        lblAnuncio2.Text = "1.-Ocurrió un problema al guardar la información."
                        enviarSeguimientoPorDefault = False
                    End If
                    txbObservacion1.Text = String.Empty
                    GridView2.DataBind()

                    'actualizar_seguimiento2(id_viaje)

                Else
                    lblAnuncio2.Text = "Seleccione el lugar de arrivo."
                End If

            End If


            ''Si es un punto dentro de la ruta de seguimiento
            If rbtnUbicacion.Checked Then
                Dim id_ubicacion As String = txbIdUbicacion1.Text
                Dim id_principal_ubicacion = obtenerIdPrincipalUbicacion(id_ubicacion)
                Dim seguimiento = String.Empty



                If buscarRutaEnNotificacionesPersonalizadas(EmpresaId, RutaId) Then
                    If buscarPuntoEnNotificacionesPersonalizadas(EmpresaId, RutaId, id_principal_ubicacion) Then
                        enviarSeguimientoPersonalizado = True
                    End If

                Else
                    ''Solo los puntos seleccionados pueden enviar notificacion al cliente
                    enviarSeguimientoPorDefault = enviarSeguimientoEnEstePunto(id_principal_ubicacion)
                End If

                Dim observacion As String = txbObservacion1.Text


                'Verificamos si llegamos a destino final para cerrar el viaje
                Dim llegamos = llegamos_a_destino(id_viaje, id_principal_ubicacion)

                If llegamos Then
                    Dim arriboRegistrado = proxy.hemosLlegadoADestino(txbIdViaje.Text)
                    If Not arriboRegistrado Then
                        lblAnuncio2.Text = "Debe registrar el arribo con el cliente para poder cerrar este viaje."
                        enviarSeguimientoPersonalizado = False
                        enviarSeguimientoPorDefault = False

                    Else
                        errorAlGuardar = nuevoPuntoPredeterminadoEnSeguimiento(id_viaje, txbObservacion1.Text, inspector, id_principal_ubicacion, fecha)
                        cerrar_viaje(id_viaje, fecha)
                        btnGuardar1.Enabled = False
                        Label1.Text = String.Empty
                        limpiarPuntosPendientes(id_viaje)
                        lblAnuncio2.Text = "Viaje Cerrado."
                    End If
                Else
                    errorAlGuardar = nuevoPuntoPredeterminadoEnSeguimiento(id_viaje, txbObservacion1.Text, inspector, id_principal_ubicacion, fecha)

                    If Not String.IsNullOrEmpty(errorAlGuardar) Then
                        lblAnuncio2.Text = "2.- Nuevo punto predeterminado Ocurrió un problema al guardar, intentelo nuevamente."
                        enviarSeguimientoPersonalizado = False
                        enviarSeguimientoPorDefault = False
                    Else
                        quitarPrimerLineaPuntosPendientes(id_viaje)

                        Dim siguientePunto = (From consulta In db.seguimientoPorRecorrers
                                           Where consulta.idViaje = id_viaje
                                           Select consulta).FirstOrDefault()

                        If Not siguientePunto Is Nothing Then
                            Label1.Text = siguientePunto.ubicacion
                            lblHora.Text = siguientePunto.hora
                            txbIdUbicacion1.Text = siguientePunto.UbicacionId
                        End If
                        grdPuntosPendientes.DataBind()
                    End If
                End If
                txbObservacion1.Text = String.Empty

                GridView2.DataBind()
                

                Dim posibleInicioDeRelebo = False
                Dim idTrayectoIniciado As Integer = regresaTrayectoIniciado(id_viaje)

                ''Si ya inicio un trayecto buscamos la ubicacion del destino de ese trayecto
                If idTrayectoIniciado <> 0 Then
                    Dim idDestino = regresaDestinoTrayectoIniciado(idTrayectoIniciado)

                    If idDestino = id_principal_ubicacion Then
                        ''CambiarEstatus y regristrarFecha
                        Dim buscarTrayecto = (From consulta In db.trayectos_asignados
                                           Where consulta.id_trayecto_asignado = idTrayectoIniciado
                                           Select consulta).FirstOrDefault()

                        If Not buscarTrayecto Is Nothing Then
                            buscarTrayecto.idEstatus = 3
                            buscarTrayecto.fin = fecha
                            db.SubmitChanges()
                            posibleInicioDeRelebo = True
                        End If
                    End If
                End If

                If posibleInicioDeRelebo Or idTrayectoIniciado = 0 Then
                    ''Si no ha iniciado
                    For Each inicio In regresaIniciosDeTrayectos(id_viaje)

                        If inicio = id_principal_ubicacion Then

                            Dim idTrayectoPorIniciar = regresaTrayectoPorOrigen(inicio, id_viaje)

                            Dim buscarTrayecto = (From consulta In db.trayectos_asignados
                                          Where consulta.id_trayecto_asignado = idTrayectoPorIniciar
                                          Select consulta).FirstOrDefault()

                            If Not buscarTrayecto Is Nothing Then
                                buscarTrayecto.idEstatus = 2
                                buscarTrayecto.inicio = fecha
                                db.SubmitChanges()
                            End If
                        End If
                    Next
                End If




            End If

            ''Solo en arrivos con el cliente y puntos de la ruta se envia notificacion al cliente
            If enviarSeguimientoPorDefault Or enviarSeguimientoPersonalizado Then

                Dim body = String.Empty
                Dim orden = obtenerFolioOrden(id_viaje)
                Dim contactosSeguimiento = obtenerContactosSeguimiento(id_viaje)
                Dim correo_contacto = obtenerContactoViaje(id_viaje)
                Dim errorAlEnviar = String.Empty


                For Each item In contactosSeguimiento
                    correo_contacto.Add(item)
                Next
                'Se quito la opcion de enviar el seguimiento al inspector a peticion del sup. trafico y el inspector 15/07/2015
                ' correo_contacto.Add("inspector@tse.com.mx")
                '--------------------------------------------------------------------------------------------------------------

                Dim rutaArchivos(0) As String

                If enviarSeguimientoPorDefault Then
                    body = crearCorreoSeguimientoDefault(id_viaje)
                    proxy.enviarMail(correo_contacto.ToArray, body, body, "Estatus de Orden de Servicio ", rutaArchivos)

                End If

                If enviarSeguimientoPersonalizado Then
                    body = crearCorreoSeguimientoPersonalizado(id_viaje, EmpresaId, RutaId)
                    proxy.enviarMail(correo_contacto.ToArray, body, body, "Estatus de Orden de Servicio ", rutaArchivos)
                End If

                If Not String.IsNullOrEmpty(errorAlEnviar) Then
                    lblAnuncio2.Text = String.Format("3.-Ocurrió un problema al enviar correo, error:{0}", errorAlEnviar)
                End If
            End If

            ''Si es una pausa en el viaje
            If rbtnPausas.Checked Then
                If ddlPausas.SelectedValue <> 0 Then
                    errorAlGuardar = nuevaPausaSeguimiento(id_viaje, txbObservacion1.Text, inspector, ddlPausas.SelectedValue, fecha, es_llegada)

                    If Not String.IsNullOrEmpty(errorAlGuardar) Then
                        lblAnuncio2.Text = "4.- Nueva pausa en seguimiento Ocurrió un problema al guardar, intentelo nuevamente."
                    End If
                    txbObservacion1.Text = String.Empty
                    GridView2.DataBind()
                    actualizar_seguimiento2(id_viaje)

                Else
                    lblAnuncio2.Text = "Seleccione el tipo de pausa."
                End If

            End If
        Else
            Response.Redirect("~/Default.aspx")
        End If


    End Sub
  

    
   

   
    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        lblAnuncio.Text = ""
        lblAnuncio2.Text = ""
        GridView1.DataBind()

        mdlHolder.Hide()
        btnGuardar1.Enabled = True
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim sdsChofer As SqlDataSource = CType(e.Row.FindControl("sdsChofer"), SqlDataSource)
            Dim id_viaje = e.Row.Cells(1).Text

            txbIdViaje.Text = id_viaje.ToString()

            sdsChofer.SelectParameters(0).DefaultValue = id_viaje

            Dim sdsUnidad As SqlDataSource = CType(e.Row.FindControl("sdsUnidad"), SqlDataSource)
            sdsUnidad.SelectParameters(0).DefaultValue = id_viaje

            Dim sdsCaja As SqlDataSource = CType(e.Row.FindControl("sdsCaja"), SqlDataSource)
            sdsCaja.SelectParameters(0).DefaultValue = id_viaje

            Dim sdsTrayecto As SqlDataSource = CType(e.Row.FindControl("sdsTrayecto"), SqlDataSource)
            sdsTrayecto.SelectParameters(0).DefaultValue = id_viaje

            Dim lblSeguimiento As Label = CType(e.Row.FindControl("lblSeguimiento"), Label)

            Dim ultimo_seguimiento = (From consulta In db.seguimientos
                                   Where consulta.id_viaje = id_viaje
                                   Order By consulta.id_seguimiento Descending
                                   Select consulta).FirstOrDefault()

            If Not ultimo_seguimiento Is Nothing Then
                Dim id_seguimiento = ultimo_seguimiento.id_seguimiento

                Dim buscar_hora = (From consulta In db.horas
                                Where consulta.id_seguimiento = id_seguimiento
                                Select consulta).FirstOrDefault()

                Dim buscar_ubicacion = (From consulta In db.puntos_predeterminados
                                     Where consulta.id_seguimiento = id_seguimiento
                                     Select consulta).FirstOrDefault()

                If Not buscar_ubicacion Is Nothing And Not buscar_hora Is Nothing Then
                    lblSeguimiento.Text = buscar_ubicacion.ubicacione.ubicacion.ToString() + " //  " + String.Format("{0:R}", buscar_hora.fecha)
                End If

                Dim buscar_arrivos = (From consulta In db.arrivos
                                    Where consulta.id_seguimiento = id_seguimiento
                                    Select consulta).FirstOrDefault()

                If Not buscar_arrivos Is Nothing And Not buscar_hora Is Nothing Then
                    lblSeguimiento.Text = buscar_arrivos.detalle_arrivo.nombre.ToString() + " //  " + String.Format("{0:R}", buscar_hora.fecha)
                End If

                Dim buscar_pausas = (From consulta In db.Pausas
                                   Where consulta.id_seguimiento = id_seguimiento
                                   Select consulta).FirstOrDefault()

                If Not buscar_pausas Is Nothing And Not buscar_hora Is Nothing Then
                    lblSeguimiento.Text = buscar_pausas.tipos_pausa.pausa.ToString() + " //  " + String.Format("{0:R}", buscar_hora.fecha)
                End If


            End If


        End If
    End Sub



    Protected Sub ibtnActualizar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizar.Click
        lblAnuncio.Text = String.Empty
        lblAnuncio3.Text = String.Empty
        If Not String.IsNullOrEmpty(txbAno.Text) And
            Not String.IsNullOrEmpty(txbConsecutivo.Text) And
            Not String.IsNullOrEmpty(txbNumViaje.Text) Then

            Dim buscar_id_viaje = (From consulta In db.viajes
                                Where consulta.Ordene.ano = txbAno.Text And
                                consulta.Ordene.consecutivo = txbConsecutivo.Text And
                                consulta.num_viaje = txbNumViaje.Text
                                Select consulta).FirstOrDefault()

            If Not buscar_id_viaje Is Nothing Then
                Dim id_viaje = buscar_id_viaje.id_viaje

                sdsInfoViaje.SelectParameters(0).DefaultValue = id_viaje
                SqlSeguimiento.SelectParameters(0).DefaultValue = id_viaje
                GridView2.DataBind()
                mandar_alertas_retraso = False
                txbIdViaje.Text = id_viaje
                If User.IsInRole("administrador") Then
                    btnGuardar1.Enabled = True
                Else
                    btnGuardar1.Enabled = False
                End If
                actualizar_seguimiento2(id_viaje)

                mdlHolder.Show()
            Else
                lblAnuncio3.Text = "La Orden de Servicio no existe."
            End If


        End If
    End Sub

    Protected Sub lnkCatalogoArrivos_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkCatalogoArrivos.Click
        lblAnuncio.Text = String.Empty
        Dim micontrol As UserControl = LoadControl("~/Controles_Usuario/ctlPuntosArrivo.ascx")

        phrSeguimiento.Controls.Add(micontrol)
        btnCerrarPanel.Visible = True
    End Sub

    Protected Sub btnCerrarPanel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrarPanel.Click
        lblAnuncio.Text = String.Empty
        phrSeguimiento.Controls.Clear()

        If Not String.IsNullOrEmpty(txbIdViaje.Text) Then
            Dim id_viaje = txbIdViaje.Text
            mandar_alertas_retraso = False
            'actualizar_seguimiento2(id_viaje)

            ddlArrivos.DataBind()
            ddlPausas.DataBind()
        End If
        btnCerrarPanel.Visible = False
        Session("arrivos") = 0
    End Sub

    Protected Sub ddlArrivos_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlArrivos.DataBound
        ddlArrivos.Items.Add(New ListItem("Seleccionar...", 0))
        ddlArrivos.SelectedValue = 0
    End Sub

    Protected Sub lnkTiposPausas_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkTiposPausas.Click
        lblAnuncio.Text = String.Empty
        Dim control_pausas As UserControl = LoadControl("~/Controles_Usuario/ctlTiposPausas.ascx")
        phrSeguimiento.Controls.Add(control_pausas)
        btnCerrarPanel.Visible = True

    End Sub

    Protected Sub ddlPausas_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlPausas.DataBound
        lblAnuncio.Text = String.Empty
        ddlPausas.Items.Add(New ListItem("Seleccionar...", 0))
        ddlPausas.SelectedValue = 0
    End Sub

    Protected Sub rbtnArrivo_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles rbtnArrivo.CheckedChanged


        lblAnuncio.Text = String.Empty

        ''activamos los controles de arrivo
        ddlArrivos.Enabled = True
        lnkCatalogoArrivos.Enabled = True
        lnkCatalogoArrivos.ForeColor = Drawing.Color.Blue

        ''desactivamos los controles de pausas
        lnkTiposPausas.ForeColor = Drawing.Color.Gray
        lnkTiposPausas.Enabled = False

        ''desactivamos los controles de pausas
        ddlPausas.Enabled = False
        Label1.ForeColor = Drawing.Color.Gray

        ''cambiar los colores de los radio botones
        rbtnArrivo.BackColor = Drawing.Color.Yellow
        rbtnPausas.BackColor = Drawing.Color.White
        rbtnUbicacion.BackColor = Drawing.Color.White


        txbSalida.Enabled = True
    End Sub

    Protected Sub rbtnPausas_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles rbtnPausas.CheckedChanged
        lblAnuncio.Text = String.Empty

        ''activamos los controles de pausas
        ddlPausas.Enabled = True
        lnkTiposPausas.Enabled = True
        lnkTiposPausas.ForeColor = Drawing.Color.Blue

        ''desactivamos los controles de ubicaciones
        Label1.ForeColor = Drawing.Color.Gray

        ''desactivamos los controles de arrivo
        lnkCatalogoArrivos.Enabled = False
        lnkCatalogoArrivos.ForeColor = Drawing.Color.Gray
        ddlArrivos.Enabled = False


        ''cambiamos los colores al radio boton seleccionado
        rbtnPausas.BackColor = Drawing.Color.Yellow
        rbtnArrivo.BackColor = Drawing.Color.White
        rbtnUbicacion.BackColor = Drawing.Color.White


        txbSalida.Enabled = True
    End Sub

    Protected Sub rbtnUbicacion_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles rbtnUbicacion.CheckedChanged
        lblAnuncio.Text = String.Empty

        ddlArrivos.Enabled = False

        ''activamos los controles de ubicaciones
        Label1.ForeColor = Drawing.Color.Black

        ''desactivamos los catalogos de arrivos
        lnkCatalogoArrivos.Enabled = False
        lnkCatalogoArrivos.ForeColor = Drawing.Color.Gray

        ''desactivamos los controles de pausas
        lnkTiposPausas.ForeColor = Drawing.Color.Gray
        ddlPausas.Enabled = False
        lnkTiposPausas.Enabled = False

        ''cambiamos los colores de los radio botones
        rbtnUbicacion.BackColor = Drawing.Color.Yellow
        rbtnArrivo.BackColor = Drawing.Color.White
        rbtnPausas.BackColor = Drawing.Color.White


        txbSalida.Enabled = False
    End Sub

    Protected Sub rbtLlegada_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles rbtLlegada.CheckedChanged
        lblAnuncio.Text = String.Empty
        TextBox1.Enabled = True

        rbtnSalida.Checked = False
        txbSalida.Enabled = False


        rbtLlegada.BackColor = Drawing.Color.Green
        rbtnSalida.BackColor = Drawing.Color.White
    End Sub

    Protected Sub rbtnSalida_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles rbtnSalida.CheckedChanged
        ''Cuando son puntos predeterminados no se registra la hora de salida aqui verificamos que no seleccione hora de salida
        ''eb puntos predeterminados

        If Not rbtnUbicacion.Checked Then
            txbSalida.Enabled = True
            rbtnSalida.BackColor = Drawing.Color.Green


            rbtLlegada.Checked = False
            rbtLlegada.BackColor = Drawing.Color.White
            TextBox1.Enabled = False

        Else


            rbtnSalida.Checked = False
            txbSalida.Enabled = False

            rbtLlegada.Checked = True
            TextBox1.Enabled = True

            lblAnuncio.Text = "Para los punto predeterminados no se registra salida." & vbCrLf & "Solo para arrivos y pausas."
        End If

    End Sub



    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblUbicacion As Label = CType(e.Row.FindControl("lblUbicacion"), Label)
            Dim imgArribo As Image = CType(e.Row.FindControl("imgArribo"), Image)


            Dim id_seguimiento = e.Row.Cells(0).Text

            Dim buscar_ubicacion = (From consulta In db.puntos_predeterminados
                                   Where consulta.id_seguimiento = id_seguimiento
                                   Select consulta).FirstOrDefault()
            If Not buscar_ubicacion Is Nothing Then
                lblUbicacion.Text = buscar_ubicacion.ubicacione.ubicacion
            End If

            Dim buscar_arrivo = (From consulta In db.arrivos
                              Where consulta.id_seguimiento = id_seguimiento
                              Select consulta).FirstOrDefault()

            If Not buscar_arrivo Is Nothing Then
                lblUbicacion.Text = buscar_arrivo.detalle_arrivo.nombre
                Dim buscar_tipo_movimiento = (From consulta In db.horas
                                           Where consulta.id_seguimiento = id_seguimiento
                                           Select consulta).FirstOrDefault()
                If Not buscar_tipo_movimiento Is Nothing Then
                    imgArribo.Visible = True
                    If buscar_tipo_movimiento.llegada Then
                        imgArribo.ImageUrl = "~/imagenes/llegada.png"
                    Else
                        imgArribo.ImageUrl = "~/imagenes/salida.png"
                    End If
                End If

            End If

            Dim buscar_pausas = (From consulta In db.Pausas
                              Where consulta.id_seguimiento = id_seguimiento
                              Select consulta).FirstOrDefault()
            If Not buscar_pausas Is Nothing Then
                lblUbicacion.Text = buscar_pausas.tipos_pausa.pausa
            End If

        End If
    End Sub


    Protected Sub GridView2_RowDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeletedEventArgs) Handles GridView2.RowDeleted
        If Not String.IsNullOrEmpty(txbIdViaje.Text) Then
            UpdatePanel2.DataBind()
            UpdatePanel1.DataBind()
            Dim id_viaje = txbIdViaje.Text
            GridView2.DataBind()
            mandar_alertas_retraso = False
            actualizar_seguimiento2(id_viaje)


        End If
    End Sub


    Public Sub actualizar_seguimiento2(ByVal id_viaje As String)

        Dim BuscarFolioOrden = (From consulta In db.viajes
                  Where consulta.id_viaje = id_viaje
                  Select consulta).FirstOrDefault()

        Dim folioOrden = String.Empty
        If Not BuscarFolioOrden Is Nothing Then
            folioOrden = String.Format("{0}-{1}-{2}", BuscarFolioOrden.Ordene.ano, BuscarFolioOrden.Ordene.consecutivo, BuscarFolioOrden.num_viaje)
        End If

        Dim seguimiento = String.Empty
        Dim ubicacionId = String.Empty


        ''Se borran todos los puntos registrados en la tabla de los puntos pendientes por recorrer
        limpiarPuntosPendientes(id_viaje)

        Label1.Text = String.Empty
        'cuando se obtiene la diferencia entre minutos recorridos y programados solo se debe hacer una vez
        Dim ya_no_entrar As Boolean = False
        lblSiguientePunto.BackColor = Drawing.Color.White

        Dim va_para_arriba As Boolean = False 'indica hacia donde se va mover el siguiente punto
        ' para determinar que tiempo seleccionar en la base de datos
        ' si va hacia arriba toma el tiempo del punto actual
        'si va hacia abajo toma el tiempo de siguiente punto

        'si regresa diferente de 0 es que tenemos un registro en seguimiento
        'y por tanto el campo de registro de hora debe ser modificable

        '1.- OBTENEMOS LOS MINUTOS RECORRIDOS
        Dim minutos_recorridos = obtener_minutos_recorridos(id_viaje)
        Dim botador As Integer = 0


        Dim num_columnas_seguimiento = (From consulta In db.puntos_predeterminados
        Where (consulta.seguimiento.id_viaje = id_viaje)
        Select consulta.id_seguimiento).Count()


        Dim mostrar_origen As Boolean
        Dim mostrar_puntos_por_reccorer As Boolean
        Dim fecha_origen As Date

        ''si hay registro de seguimiento
        Dim existe_seguimiento = (From consulta In db.puntos_predeterminados
                                 Where consulta.seguimiento.id_viaje = id_viaje
                                 Select consulta.id_seguimiento).Count()



        If existe_seguimiento <> 0 Then
            'descomentar 
            fecha_origen = obtener_fecha_origen(id_viaje)
            mostrar_origen = False
            TextBox1.ReadOnly = False
        Else 'si es igual a 0 no hay ningun seguimiento y en ese caso el inspector no puede modificar la hora
            mostrar_origen = True 'si no hay ningun punto en el seguimiento no recorremos la ruta hasta despues de registrar el primer punto
            'TextBox1.ReadOnly = True
            mostrar_puntos_por_reccorer = True
            fecha_origen = DateTime.Now.AddHours(-7)
        End If

        'ubicacion del ultimo punto registrado
        Dim ultimo_seguimiento As String = obtener_ultimo_seguimiento(id_viaje)

        Dim llegamos_ultima_parada As Boolean = False

        'obtenemos la llave del punto de origen
        Dim id_principal As String = id_principal_origen(id_viaje)
        'obtenemos la llave de la ubicación
        Dim id_origen As String = id_ubicacion_origen(id_viaje)

        Dim id_destino As String = siguiente_parada(CInt(id_principal), id_viaje)
        
        Dim posicion_actual As String = id_origen
        Dim destino_original As Integer = 0

        Dim ruta_con_vuelta As Boolean = False
        Dim id_principal_siguiente As Integer = 0

        While Not llegamos_ultima_parada
            'el punto de intersección se utiliza cuando el trayecto va a un punto superior y desciende a un punto
            'inferior de una rama

            '2.- DETERMINAMOS EL PRIMER PUNTO DE DESTINO
            Dim punto_interseccion As String = obtener_puntodeinterseccion(posicion_actual, id_destino)

            'si el punto de interseccion es el mismo que el de destino quiere decir
            'que el trayecto no va de un nodo hijo a otro nodo hijo "trayecto con vuelta de retorno"
            'si es diferente el destino tiene que ser primero el nodo padre de ambos puntos ejemplo. 
            'Origen: 1122000000 destino: 1135000000  el padre de ambos seria 1100000000
            'en ese caso tendriamos que ir primero al padre y despues al destino original
            If punto_interseccion <> id_destino Then
                destino_original = id_destino 'conservamos el destino original para cuando lleguemos al padre
                'dirijirnos a destino original
                id_destino = encontrar_punto_max_subruta(punto_interseccion) 'el destino parcialmente será el padre
                
                ruta_con_vuelta = True
            Else 'si el destino es igual al punto de interseccion entonces es una ruta en linea recta
                ruta_con_vuelta = False
            End If
            id_principal_siguiente += 1 'para encontrar el siguiente punto de destino del intinerario

            Dim tipo_ubicacion As String = "" 'hay que identificar si el punto es multidireccional(que tiene que elegir entre distintos puntos) o unidireccional
            Dim ir_a As String = ""


            Dim minutos_retraso As Integer = 0
            Dim minutos_programados As Integer = 0
            Dim query As String = String.Empty
            Dim ultima_fecha_seguimiento As Date
            Dim fecha As String = Format(DateTime.Now.AddHours(-7), "HH:mm") 'fecha que pondremos en el registro del seguimiento


            While posicion_actual <> id_destino And botador < 45 'si se cicla lo botamos al llegar a determinado numero de ciclos

                tipo_ubicacion = obtener_tipo_ubicacion(posicion_actual) 'obtenemos si el punto el multidireccion o unidireccion
                botador += 1

                '4.- SI LLEGAMOS AL ULTIMO PUNTO DEL SEGUIMIENTO AHORA DIBUJAMOS LOS PUNTOS 
                'PENDIENTES Y OBTENEMOS LOS MINUTOS DE RETRASO (MINUTOS PROGRAMADOS - RECORRIDOS)
                If posicion_actual = ultimo_seguimiento And Not ya_no_entrar And botador >= num_columnas_seguimiento Then
                    mostrar_puntos_por_reccorer = True
                    botador = 1
                    minutos_retraso = minutos_recorridos - minutos_programados
                    ya_no_entrar = True
                End If
                If Not mostrar_origen Then
                    va_para_arriba = obtener_orientacion(id_viaje, id_destino, posicion_actual, tipo_ubicacion)

                    ir_a = obtener_siguiente_paso(id_destino, posicion_actual, tipo_ubicacion)

                    '5.- NOS MOVEMOS AL SIGUIENTE PUNTO
                    If va_para_arriba Then
                        Dim buscarTiempo = (From consulta In db.ubicaciones
                                         Where consulta.id_ubicacion = posicion_actual
                                         Select consulta).FirstOrDefault()

                        If Not buscarTiempo Is Nothing Then
                            minutos_programados += buscarTiempo.tiempo
                        End If
                        
                        posicion_actual = ir_a
                    Else
                        posicion_actual = ir_a
                        Dim buscarTiempo = (From consulta In db.ubicaciones
                                         Where consulta.id_ubicacion = posicion_actual
                                         Select consulta).FirstOrDefault()

                        If Not buscarTiempo Is Nothing Then
                            minutos_programados += buscarTiempo.tiempo
                        End If
                        
                    End If



                End If

                Dim nombre_ubicacion As String = obtener_nombre_ubicacion(posicion_actual)



                Dim buscarEstatusUbicacion = (From consulta In db.ubicaciones
                                                                        Where
                                                                        consulta.id_ubicacion = posicion_actual
                                                                        Select consulta).FirstOrDefault()
                Dim ubicacion_activada As Integer = 0
                If Not buscarEstatusUbicacion Is Nothing Then
                    ubicacion_activada = buscarEstatusUbicacion.id_status
                End If


                Dim buscar_posicion_actual_en_ruta = (From consulta In db.viajes, consulta2 In db.rutas
                                                       Where consulta.precio.id_ruta = consulta2.id_ruta And
                                                       consulta2.ubicacione.id_ubicacion = posicion_actual And
                                                       consulta.id_viaje = id_viaje
                                                       Select consulta).FirstOrDefault()

                Dim existe_posicion_actual_en_ruta = True

                If buscar_posicion_actual_en_ruta Is Nothing Then
                    existe_posicion_actual_en_ruta = False
                End If
                If ubicacion_activada <> 2 And Not existe_posicion_actual_en_ruta Then
                    botador -= 1
                End If

                If mostrar_puntos_por_reccorer Then

                    Dim ubicacion_es_origen_o_destino = True

                    If ubicacion_activada = 2 Or existe_posicion_actual_en_ruta Then

                        Dim horaProgramadaRegistro = DateAdd(DateInterval.Minute, minutos_programados, CDate(fecha_origen))
                        Dim horaProgramada = DateAdd(DateInterval.Minute, minutos_programados, CDate(fecha_origen)).ToString("HH:mm")
                        Dim siguienteHora = DateAdd(DateInterval.Minute, minutos_programados, CDate(fecha_origen)).ToString("dddd d, HH:mm")

                        If String.IsNullOrEmpty(Label1.Text) Then

                            Label1.Text = nombre_ubicacion
                            txbIdUbicacion1.Text = posicion_actual
                            ''TextBox1.Text = fecha
                            lblHora.Text = horaProgramada
                            insertarPuntoPendiente(nombre_ubicacion, id_viaje, posicion_actual, horaProgramadaRegistro)

                            If mostrar_origen Then
                                'TextBox1.ReadOnly = True
                                mostrar_origen = False
                            Else
                                ultima_fecha_seguimiento = obtener_ultima_fecha_seguimiento(id_viaje)
                                Dim diferencia_siguiente_punto As Integer = DateDiff(DateInterval.Minute, CDate(fecha), ultima_fecha_seguimiento)
                                If diferencia_siguiente_punto > 0 Then
                                    lblHora.BackColor = Drawing.Color.Red
                                End If
                            End If
                        Else
                            insertarPuntoPendiente(nombre_ubicacion, id_viaje, posicion_actual, horaProgramadaRegistro)
                            
                        End If

                    End If
                End If


            End While

            If botador >= 60 Then
                llegamos_ultima_parada = True
            Else

                '6.- CAMBIAMOS EL DESTINO AL SIGUIENTE PUNTO DE LA RUTA
                If ruta_con_vuelta Then
                    posicion_actual = id_destino
                    id_destino = destino_original

                Else
                    posicion_actual = id_destino 'recorremos la siguiente subruta del trayecto
                    id_destino = siguiente_parada(CInt(id_principal) + id_principal_siguiente, id_viaje)

                    If id_destino = "" Then 'si ya no hay más puntos en la ruta hemos llegado al destino final
                        llegamos_ultima_parada = True

                    End If
                End If
            End If


            'If mandar_alertas_retraso Then

            '    Dim tabla = llenar_tabla_seguimiento(id_viaje, fecha_origen, ultima_fecha_seguimiento, minutos_retraso)
            '    Dim color_label As System.Drawing.Color
            '    Dim destinatario As String = String.Empty

            '    Dim corregible = retraso_corregible(minutos_programados, minutos_retraso)
            '    Dim viaje_retrasado = hay_retraso(minutos_programados, minutos_retraso)

            '    If viaje_retrasado Then
            '        If corregible Then
            '            color_label = Drawing.Color.Yellow
            '            destinatario = "sistemas@tse.com.mx"
            '        Else
            '            color_label = Drawing.Color.Red
            '            destinatario = "sistemas@tse.com.mx,inspector@tse.com.mx"
            '        End If
            '        lblAnuncio.Text = "Ruta con " + CStr(minutos_retraso) + " minutos de retraso."
            '        lblAnuncio.BackColor = color_label
            '        EnviarCorreo(destinatario, "Precaución viaje con " + CStr(minutos_retraso) + " minutos de retraso.", tabla)
            '    End If
            'End If
        End While
        sdsPuntoPendientes.SelectParameters(0).DefaultValue = id_viaje
        grdPuntosPendientes.DataBind()

    End Sub


    Protected Sub Timer1_Tick(sender As Object, e As EventArgs) Handles Timer1.Tick

    End Sub
End Class