Imports System.Data.SqlClient
Partial Public Class Cierre_Viaje
    Inherits System.Web.UI.Page

    Dim query As String
    Dim odometro_regreso As String
    Dim db As New DataClasses1DataContext()
    Dim viaje_pendiente_de_seguimiento As Boolean = False
    Dim proxy As New wcfRef1.Service1Client()


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year

            ddlEstacion.SelectedValue = 2
            recarga_en_base()

            txbFechaCarga.Text = Now.AddHours(-7).ToString("yyyy/MM/dd")
        End If

    End Sub
    

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarOdometro.Click
        odometro_regreso = txbOdometro.Text


        If Not String.IsNullOrEmpty(txbIdEquipoAsignado.Text) Then



            Dim IdEquipoAsignado = txbIdEquipoAsignado.Text
            Dim idOrden = txbIdOrden.Text


            Dim buscarAsignacion = proxy.buscarAsignacionPorId(IdEquipoAsignado)

            If Not buscarAsignacion Is Nothing Then
                Dim idEquipo = buscarAsignacion.id_equipo
                Dim idChofer = buscarAsignacion.idEmpleado

                Dim buscarRecorrido = proxy.buscarRecorridoPorIdEquipoAsignado(IdEquipoAsignado)

                If Not buscarRecorrido Is Nothing Then
                    Dim grupo = buscarRecorrido.grupo

                    lblMensaje2.Text = ""
                    Dim MemUser As MembershipUser
                    Try
                        MemUser = Membership.GetUser(User.Identity.Name)
                        Dim inspector = MemUser.UserName.ToString()
                        Dim ejes As String = ddlEjesRegreso.SelectedValue
                        Dim fecha As String = DateTime.Now.AddHours(-7)

                        'Dim existe_odometro_inicio = buscar_odometro(idOrden, idEquipo, idChofer, 1)

                        'If existe_odometro_inicio = 0 Then
                        '    lblAnuncio.Text = "Falta el odometro de inicio, registrelo primero."

                        'Else




                        Dim odometro_salida = hflOdometroInicio.Value

                        Dim kmsRecorridos = odometro_regreso - odometro_salida

                        'Dim existe_odometro_llegada = buscar_odometro(idChofer, 2, grupo)

                        Dim buscar_odometro_llegada = proxy.buscarOdometroPorGrupo(grupo, 2)

                        If buscar_odometro_llegada Is Nothing Then
                            Dim nuevoOdometro As New wcfRef1.Odometro

                            nuevoOdometro.id_chofer = idChofer
                            nuevoOdometro.id_equipo = idEquipo
                            nuevoOdometro.grupo = grupo
                            nuevoOdometro.idOrden = idOrden
                            nuevoOdometro.tipo_trayecto = 2
                            nuevoOdometro.num_ejes = ejes
                            nuevoOdometro.odometro1 = odometro_regreso
                            nuevoOdometro.inspector = inspector

                            proxy.crearOdometro(nuevoOdometro)

                            'nuevo_odometro_eje(inspector, idOrden, idEquipo, idChofer, odometro_regreso, 2, ejes, grupo)
                        Else
                            buscar_odometro_llegada.id_chofer = idChofer
                            buscar_odometro_llegada.id_equipo = idEquipo
                            buscar_odometro_llegada.grupo = grupo
                            buscar_odometro_llegada.tipo_trayecto = 2
                            buscar_odometro_llegada.num_ejes = ejes
                            buscar_odometro_llegada.idOrden = idOrden
                            buscar_odometro_llegada.odometro1 = odometro_regreso
                            buscar_odometro_llegada.inspector = inspector

                            proxy.actualizarOdometro(buscar_odometro_llegada)
                            'actualizar_odometro(grupo, idChofer, 2, odometro_regreso, ejes)
                        End If

                        Dim buscarRendimiento = proxy.buscarRendimientoPorGrupo(grupo)
                        Dim lts = proxy.regresarLtsPorGrupo(grupo)
                        Dim rendimiento = 0.0

                        If Not buscarRendimiento Is Nothing Then

                            If lts > 0 Then
                                rendimiento = kmsRecorridos / lts
                            End If

                            buscarRendimiento.kms = kmsRecorridos
                            buscarRendimiento.rendimiento1 = rendimiento

                            proxy.actualizarRendimiento(buscarRendimiento)
                        End If

                        lblAnuncio.Text = "Odometro: " + txbOdometro.Text + " Ejes:" + ejes
                        sdsOrden.SelectParameters(0).DefaultValue = txbConsecutivo.Text
                        sdsOrden.SelectParameters(1).DefaultValue = txbAno.Text

                        grdViaje.DataBind()
                        

                        actualizar_indicadores(IdEquipoAsignado)
                        'End If
                    Catch ex As Exception
                        lblAnuncio.Text = ex.Message
                    End Try
                Else
                    lblAnuncio.Text = "No se encontro el recorrido de esta unidad."
                End If

                
            Else
                lblAnuncio.Text = "Ingrese la orden y seleccione la unidad."
            End If

        Else
            lblAnuncio.Text = "Seleccione la unidad."
        End If


    End Sub
    

    Protected Sub btnGuardarRecargas_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarRecargas.Click
        'calcular litros o galones 
        Dim litros As String
        Dim enGalones As Boolean = False
        Dim parcial As Integer = 0



        If radioLitros.SelectedValue = 1 Then
            enGalones = True
            Dim galonAlitro As Double = Convert.ToDouble(txbLitros.Text)
            litros = galonAlitro * 3.785
        Else
            litros = txbLitros.Text
        End If
        Dim id_orden As String = txbIdOrden.Text
        Dim estacion As String = ddlEstacion.SelectedValue
        Dim idEquipoAsignado = txbIdEquipoAsignado.Text
        Dim grupo = hfldGrupo.Value
        Dim fecha As Date = String.Format("{0} {1}", txbFechaCarga.Text, txbHoraCarga.Text)
        Dim resultado As Integer = DateTime.Compare(fecha, DateTime.Now)


        If resultado < 0 Then
            If String.IsNullOrEmpty(txbTicketCombustible.Text) Then
                txbTicketCombustible.Text = 0
            End If

            If Not String.IsNullOrEmpty(txbIdEquipoAsignado.Text) And
                Not String.IsNullOrEmpty(txbLitros.Text) Then


                Dim buscarEquipo = (From consulta In db.equipo_asignados
                             Where consulta.id_equipo_asignado = idEquipoAsignado
                             Select consulta).FirstOrDefault()

                Dim idEquipo = buscarEquipo.id_equipo
                Dim idChofer = buscarEquipo.idEmpleado

                lblMensaje2.Text = ""

                Dim cantidad = txbPesosCombustible.Text

                If Not IsNumeric(cantidad) Then
                    cantidad = 0
                End If

                Dim ticket As String = txbTicketCombustible.Text

                Dim responsable = User.Identity.Name

                Dim nuevaRecarga As New recargas_combustible With
                    {
                        .id_chofer = idChofer,
                        .id_equipo = idEquipo,
                        .idEquipoAsignado = idEquipoAsignado,
                        .id_lugar = estacion,
                        .lts = litros,
                        .grupo = grupo,
                        .ticket = ticket,
                        .monto = cantidad,
                        .responsable = responsable,
                        .recargaSinOrden = False,
                        .odometro = txbOdometroRecarga.Text,
                        .fechaRecarga = fecha,
                        .idUso = 1,
                        .en_galones = enGalones
                                    }
                db.recargas_combustibles.InsertOnSubmit(nuevaRecarga)
                Try
                    db.SubmitChanges()
                    lblMensaje2.Text = "Datos de recarga guardados"
                    If ckbRecargaParcial.Checked = True Then
                        sqlUpdate.Update()
                    Else
                        sqlUpdate0.Update()
                    End If
                    'Intento de update con checkbox (Jared Quezada)



                    ' Dim body As String = "La recarga con id: " + nuevaRecarga.id_recarga + " guarda"
                    'EnviarCorreo("sistemas@tse.com.mx", "Recarga de galones", body)
                Catch ex As Exception
                    Dim body As String = "Recarga en idorden: " + id_orden + " no se guardo"
                    EnviarCorreo("sistemas@tse.com.mx", "Recarga de galones", body)
                End Try
                'Dim nuevaRecarga As New wcfRef1.recargas_combustible()
                'nuevaRecarga.id_chofer = idChofer
                'nuevaRecarga.id_equipo = idEquipo
                'nuevaRecarga.idEquipoAsignado = idEquipoAsignado
                'nuevaRecarga.id_lugar = estacion
                'nuevaRecarga.lts = litros
                'nuevaRecarga.grupo = grupo
                'nuevaRecarga.ticket = ticket
                'nuevaRecarga.monto = cantidad
                'nuevaRecarga.responsable = responsable
                'nuevaRecarga.recargaSinOrden = False
                'nuevaRecarga.odometro = txbOdometroRecarga.Text
                'nuevaRecarga.fechaRecarga = fecha
                'nuevaRecarga.idUso = 1 ''recarga de uso foraneo
                'proxy.crearRecargaCombustible(nuevaRecarga)


                actualizar_indicadores(idEquipoAsignado)
                actualizarLtsRendimiento()

            Else
                lblMensaje2.Text = "Seleccione la unidad."
            End If
        Else
            lblMensaje2.Text = "Verifique la fecha de recarga que no sea futura."
        End If
        limpiar()

    End Sub
    Sub limpiar()

        ckbRecargaParcial.Checked = False
        txbFechaCarga.Text = ""
        txbHoraCarga.Text = ""
        txbLitros.Text = ""
        txbOdometro.Text = ""
        txbOdometroRecarga.Text = ""
        txbPesosCombustible.Text = ""
        txbTicketCombustible.Text = ""
    End Sub


    Protected Sub ddlEstacion_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEstacion.SelectedIndexChanged
        If ddlEstacion.SelectedValue = "2" Then
            recarga_en_base()
        Else

            txbPesosCombustible.Enabled = "true"
            txbTicketCombustible.Enabled = "true"
            txbLitros.BackColor = Drawing.Color.White
        End If
    End Sub

    Protected Sub recarga_en_base()
        txbPesosCombustible.Enabled = "false"
        txbTicketCombustible.Enabled = "false"
        txbLitros.BackColor = Drawing.Color.Aqua
    End Sub



    Protected Sub ibtnActualizar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizar.Click
        If Not String.IsNullOrEmpty(txbAno.Text) And Not String.IsNullOrEmpty(txbConsecutivo.Text) Then

            sdsOrden.SelectParameters(0).DefaultValue = txbConsecutivo.Text
            sdsOrden.SelectParameters(1).DefaultValue = txbAno.Text

            txbIdEquipoAsignado.Text = String.Empty
            txbIdOrden.Text = String.Empty

            txbOdometro.Text = String.Empty
            lblMensaje2.Text = String.Empty
            lblMensaje.Text = String.Empty
            lblAnuncio.Text = String.Empty

            grdViaje.DataBind()

            Dim buscar_orden = (From consulta In db.Ordenes
                               Where consulta.ano = txbAno.Text And
                               consulta.consecutivo = txbConsecutivo.Text And
                               consulta.id_status <> 3 And
                               consulta.id_status <> 5
                               Select consulta).FirstOrDefault()

            If Not buscar_orden Is Nothing Then
                Dim id_orden = buscar_orden.id_orden
                txbIdOrden.Text = id_orden
            End If
        Else
            lblMensaje2.Text = "Ingrese el numero de orden."
        End If

    End Sub

    Protected Sub grdViaje_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdViaje.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblOdometro = CType(e.Row.FindControl("lblOdometro"), Label)
            Dim lblEjes = CType(e.Row.FindControl("lblEjes"), Label)
            Dim lblInspector = CType(e.Row.FindControl("lblInspector"), Label)
            Dim lblOdometroRegreso = CType(e.Row.FindControl("lblOdometroRegreso"), Label)
            Dim lblEjesRegreso = CType(e.Row.FindControl("lblEjesRegreso"), Label)
            Dim sdsTrayecto As SqlDataSource = CType(e.Row.FindControl("sdsTrayecto"), SqlDataSource)

            Dim EquipoAsignadoId As Integer = e.Row.Cells(2).Text

            sdsTrayecto.SelectParameters(0).DefaultValue = EquipoAsignadoId

            Dim buscarInfo = (From consulta In db.equipo_asignados
                                  Where consulta.id_equipo_asignado = EquipoAsignadoId
                                  Select consulta).FirstOrDefault()

            Dim buscarGrupo = (From consulta In db.recorridoEquipos
                            Where consulta.idEquipoAsignado = EquipoAsignadoId
                            Select consulta).FirstOrDefault()
            Dim grupo = 0
            If Not buscarGrupo Is Nothing Then
                grupo = buscarGrupo.grupo
            End If

            If Not buscarInfo Is Nothing Then
                Dim idOrden = buscarInfo.viaje.id_orden
                Dim idEquipo = buscarInfo.id_equipo
                Dim idChofer = buscarInfo.idEmpleado

                Dim odometroInicio = proxy.buscarOdometroPorGrupo(grupo, 1)
                Dim odometroFin = proxy.buscarOdometroPorGrupo(grupo, 2)

                If Not odometroInicio Is Nothing Then
                    lblOdometro.Text = odometroInicio.odometro1
                    lblEjes.Text = odometroInicio.num_ejes
                End If

                If Not odometroFin Is Nothing Then
                    lblOdometroRegreso.Text = odometroFin.odometro1
                    lblEjesRegreso.Text = odometroFin.num_ejes
                    lblInspector.Text = odometroFin.inspector
                End If


            End If



        End If



    End Sub
    Protected Sub actualizar_indicadores(ByVal EquipoAsignadoId As Integer)

        Dim BuscarAsignacion = (From consulta In db.equipo_asignados
                             Where consulta.id_equipo_asignado = EquipoAsignadoId 
                             Select consulta).FirstOrDefault()

        If Not BuscarAsignacion Is Nothing Then
            Dim idEquipo = BuscarAsignacion.id_equipo
            Dim idChofer = BuscarAsignacion.idEmpleado
            Dim grupo = hfldGrupo.Value

            grdRecargasInternas.DataBind()
            grdRecargasExternas.DataBind()

            Dim buscarOdometroRegreso = proxy.buscarOdometroPorGrupo(grupo, 2)


            'buscar_odometro(idChofer, 2, grupo)
            If Not buscarOdometroRegreso Is Nothing Then
                Dim odometroRegreso = buscarOdometroRegreso.odometro1
                txbOdometro.Text = odometroRegreso
                txbOdometroRecarga.Text = odometroRegreso
            End If



            

            Dim rendimiento = proxy.buscarRendimientoPorGrupo(grupo)

            If Not rendimiento Is Nothing Then
                lblKms.Text = String.Format("{0:N0}", rendimiento.kms)
                lblTotalLitros.Text = String.Format("{0:N}", rendimiento.lts)
                lblRendimiento.Text = rendimiento.rendimiento1
            End If

        End If



    End Sub

    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles grdRecargasExternas.SelectedIndexChanged
        Dim id_recarga_externa = grdRecargasExternas.SelectedDataKey.Value.ToString()


        Dim borrar_recarga_combustible = (From consulta In db.recargas_combustibles,
                                          consulta2 In db.liquidaciones
                                       Where consulta.id_recarga = id_recarga_externa
                                       Select consulta).FirstOrDefault()

        db.recargas_combustibles.DeleteOnSubmit(borrar_recarga_combustible)
        db.SubmitChanges()
        grdRecargasExternas.DataBind()
        'GridView3.DataBind()
    End Sub


    Protected Sub txbFin_Click(ByVal sender As Object, ByVal e As EventArgs) Handles txbFin.Click

        Dim idOrden = txbIdOrden.Text

        Dim idEquipoAsignado = txbIdEquipoAsignado.Text

        Dim grupo=hfldGrupo.Value


        If Not String.IsNullOrEmpty(idOrden) And Not String.IsNullOrEmpty(idEquipoAsignado) Then

            Dim buscar = (From consulta In db.recorridoEquipos
                               Where consulta.equipo_asignado.id_equipo_asignado = idEquipoAsignado
                               Select consulta).FirstOrDefault()

            Dim EquipoId = buscar.equipo_asignado.id_equipo
            Dim ChoferId = buscar.equipo_asignado.idEmpleado
            Dim buscarGrupo = buscar.grupo
            actualizarLtsRendimiento()
            

            Dim buscarIdViaje = (From consulta In db.equipo_asignados
                                Where consulta.id_equipo_asignado = idEquipoAsignado
                                Select consulta).FirstOrDefault()

            If Not buscarIdViaje Is Nothing Then

                Dim idViaje = buscarIdViaje.ViajeId
                Dim idEquipo = buscarIdViaje.id_equipo

                Response.Redirect(String.Format("~/inspector/EvaluacionChofer.aspx?idOrden={0}&idEquipo={1}&grupo={2}", idOrden, idEquipo, hfldGrupo.Value))
            End If
        Else
            lblMensaje2.Text = "Seleccione la unidad"
        End If

    End Sub



    Protected Sub grdViaje_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles grdViaje.SelectedIndexChanged

        Dim idOrden As Integer = grdViaje.SelectedDataKey(0)

        Dim EquipoAsignadoId As Integer = grdViaje.SelectedDataKey(1)
        txbIdEquipoAsignado.Text = EquipoAsignadoId

        Dim buscarGrupo = (From consulta In db.recorridoEquipos
                               Where consulta.idEquipoAsignado = EquipoAsignadoId
                               Select consulta).FirstOrDefault()

        If Not buscarGrupo Is Nothing Then
            Dim grupo = buscarGrupo.grupo
            hfldGrupo.Value = grupo
            Dim buscarOdometroInicio = proxy.buscarOdometroPorGrupo(grupo, 1)

            If Not buscarOdometroInicio Is Nothing Then
                hflOdometroInicio.Value = buscarOdometroInicio.odometro1

                txbIdOrden.Text = idOrden


                lblMensaje.Text = String.Empty
                lblMensaje2.Text = String.Empty


                Dim buscar_chofer = (From consulta In db.equipo_asignados
                                  Where consulta.id_equipo_asignado = EquipoAsignadoId
                                  Select consulta.empleado.persona.primer_nombre,
                                  consulta.empleado.persona.apellido_paterno,
                                  consulta.idEmpleado).FirstOrDefault()
                Dim idChofer = 0
                If Not buscar_chofer Is Nothing Then
                    lblChofer.Text = String.Format("{0} {1}", buscar_chofer.primer_nombre, buscar_chofer.apellido_paterno)
                    idChofer = buscar_chofer.idEmpleado
                End If


                Dim buscar_equipo = (From consulta In db.equipo_asignados
                                  Where consulta.id_equipo_asignado = EquipoAsignadoId
                                  Select consulta).FirstOrDefault()
                Dim idEquipo = 0
                If Not buscar_equipo Is Nothing Then
                    lblUnidad.Text = buscar_equipo.equipo_operacion.economico
                    idEquipo = buscar_equipo.id_equipo

                    Dim tipo_equipo = buscar_equipo.equipo_operacion.id_tipo_equipo

                    If tipo_equipo <> 102 Then
                        ddlEjesRegreso.SelectedValue = 2
                        ddlEjesRegreso.Enabled = False
                    Else
                        ddlEjesRegreso.SelectedValue = 4
                        ddlEjesRegreso.Enabled = True
                    End If
                End If

                sdsRecargasInternas.SelectParameters(0).DefaultValue = hfldGrupo.Value

                sdsRecargasExternas.SelectParameters(0).DefaultValue = hfldGrupo.Value

                If Not String.IsNullOrEmpty(EquipoAsignadoId) Then
                    actualizar_indicadores(EquipoAsignadoId)
                End If
                'Dim falla = existe_falla(EquipoAsignadoId, False)
                'txbFalla.Text = falla
                sdsOrdenComplementario.SelectParameters(0).DefaultValue = hfldGrupo.Value
                sdsOrdenComplementario.SelectParameters(1).DefaultValue = EquipoAsignadoId
            Else
                lblAnuncio.Text = "Registre el odometro de inicio."
            End If
        End If





    End Sub

    Protected Sub btnGuardar_Click1(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarAveria.Click
        If Not String.IsNullOrEmpty(txbFalla.Text) Then
            Dim falla = txbFalla.Text
            Dim EquipoAsignadoId = txbIdEquipoAsignado.Text

            Dim buscarEquipo = (From consulta In db.equipo_asignados
                             Where consulta.id_equipo_asignado = EquipoAsignadoId
                             Select consulta).FirstOrDefault()


            Dim idEquipo = 0
            Dim idChofer = 0
            Dim idOrden = 0

            Dim buscarUnidad = (From consulta In db.equipo_asignados
                                               Where consulta.id_equipo_asignado = EquipoAsignadoId
                                               Select consulta).FirstOrDefault()

            If Not buscarUnidad Is Nothing Then
                idEquipo = buscarUnidad.id_equipo
                idChofer = buscarUnidad.idEmpleado
                idOrden = buscarUnidad.viaje.id_orden
            End If

            If rbtnVehiculo.SelectedValue = 1 Then
                Dim buscarCaja = (From consulta In db.cajaAsignadas
                                              Where consulta.EquipoAsignadoId = EquipoAsignadoId
                                              Select consulta).FirstOrDefault()
                idEquipo = buscarCaja.CajaId
            End If

            Dim existe = existe_falla(idOrden, idChofer, idEquipo, False)

            If String.IsNullOrEmpty(existe) Then
                nueva_falla(idEquipo, idChofer, idOrden, False, falla)
            Else
                actualizar_falla(False, falla, idChofer, idEquipo, idOrden)
            End If
        End If
    End Sub



    Protected Sub GridView1_RowDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeletedEventArgs) Handles grdRecargasInternas.RowDeleted
        actualizarLtsRendimiento()

    End Sub
    Private Sub actualizarLtsRendimiento()
        Dim grupo = hfldGrupo.Value

        Dim buscarRendmiento = proxy.buscarRendimientoPorGrupo(grupo)

        If Not buscarRendmiento Is Nothing Then
            Dim lts = proxy.regresarLtsPorGrupo(grupo)
            Dim kms = buscarRendmiento.kms
            Dim rendimiento = 0.0

            If lts > 0 Then
                rendimiento = kms / lts
            End If

            buscarRendmiento.lts = lts
            buscarRendmiento.rendimiento1 = rendimiento

            proxy.actualizarRendimiento(buscarRendmiento)

        End If
    End Sub


    Protected Sub btnLiquidacion_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnLiquidacion.Click
        Dim buscarIdViaje = (From consulta In db.equipo_asignados
                                Where consulta.id_equipo_asignado = txbIdEquipoAsignado.Text
                                Select consulta).FirstOrDefault()

        If Not buscarIdViaje Is Nothing Then

            Dim idViaje = buscarIdViaje.ViajeId
            Dim fecha_cierre = (From consulta In db.viajes
                               Where consulta.id_viaje = idViaje
                               Select consulta).FirstOrDefault()
            Try
                If fecha_cierre.fechaCierre.Equals(Nothing) Then

                    fecha_cierre.fechaCierre = DateTime.Now.AddHours(-7)
                    db.SubmitChanges()
                    EnviarCorreo("sistemas@tse.com.mx", "viaje cerrado", String.Format("{0} Orden: {1}", fecha_cierre.fechaCierre, fecha_cierre.Ordene.consecutivo))
                End If
            Catch ex As Exception
                EnviarCorreo("sistemas@tse.com.mx", "viaje cerrado", String.Format("{0}{1}", "Viaje que no registro fecha de cierre al sacar la liquidacion ", fecha_cierre.Ordene.consecutivo))
            End Try
            Response.Redirect(String.Format("~/Sup.Trafico/Liquidacion.aspx?id_viaje={0}", buscarIdViaje.ViajeId))
        End If

    End Sub

    Protected Sub grdRecargasExternas_RowDeleted(sender As Object, e As GridViewDeletedEventArgs) Handles grdRecargasExternas.RowDeleted
        actualizarLtsRendimiento()
    End Sub
End Class