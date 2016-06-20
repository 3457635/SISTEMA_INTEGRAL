Public Partial Class Salida_Vehículo
    Inherits System.Web.UI.Page
    Dim diferencia_odometros As Integer

    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.Year
        End If
    End Sub





    Protected Sub ibtnActualizar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizar.Click
        Dim ano = txbAno.Text
            Dim consecutivo = txbConsecutivo.Text

            sdsOrden.SelectParameters(0).DefaultValue = ano
            sdsOrden.SelectParameters(1).DefaultValue = consecutivo

            sdsChoferes.SelectParameters(0).DefaultValue = ano
            sdsChoferes.SelectParameters(1).DefaultValue = consecutivo

            GridView1.Visible = False
            Dim id_orden = buscar_id_orden(txbAno.Text, txbConsecutivo.Text)



            'grdViaje.DataBind()
            GridView2.DataBind()

            If id_orden <> 0 Then
                txbIdOrden.Text = id_orden
                lblMensaje.Text = ""
            End If




    End Sub

    

    Protected Sub btnGuardarFalla_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardarFalla.Click
        Dim idOrden = txbIdOrden.Text
        Dim IdEquipoAsignado = txbEquipoAsignadoId.Text

        If Not String.IsNullOrEmpty(IdEquipoAsignado) And Not String.IsNullOrEmpty(idOrden) Then

            Dim buscarAsignacion = proxy.buscarAsignacionPorId(IdEquipoAsignado)

            If Not buscarAsignacion Is Nothing Then
                Dim idEquipo = buscarAsignacion.id_equipo
                Dim idChofer = buscarAsignacion.idEmpleado

                ''Reporte Fallas
                If Not String.IsNullOrEmpty(txbAveria.Text) Then
                    Dim falla = txbAveria.Text

                    Dim existe = existe_falla(idOrden, idChofer, idEquipo, True)

                    If String.IsNullOrEmpty(existe) Then
                        nueva_falla(idEquipo, idChofer, idOrden, True, falla)

                    Else
                        actualizar_falla(True, falla, idChofer, idEquipo, idOrden)
                    End If
                    txbAveria.Text = String.Empty
                End If
                lblMensajeFallas.Text = "Listo!"
            End If
        Else
            lblMensajeFallas.Text = "Seleccione la unidad."
        End If

    End Sub


    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView2.SelectedIndexChanged

        Dim EquipoAsignadoId As Integer = GridView2.SelectedDataKey(0)

        Dim buscarAsignacion = (From consulta In db.equipo_asignados
                             Where consulta.id_equipo_asignado = EquipoAsignadoId
                             Select consulta).FirstOrDefault()

        Dim buscarGrupo = (From consulta In db.recorridoEquipos
                        Where consulta.idEquipoAsignado = EquipoAsignadoId
                        Select consulta).FirstOrDefault()

        If Not buscarGrupo Is Nothing Then
            hfldGrupo.Value = buscarGrupo.grupo
        End If

        If Not buscarAsignacion Is Nothing Then
            Dim idOrden As Integer = buscarAsignacion.viaje.id_orden
            txbIdOrden.Text = idOrden.ToString
            txbEquipoAsignadoId.Text = EquipoAsignadoId

            Dim idEquipo = buscarAsignacion.id_equipo
            Dim idChofer = buscarAsignacion.idEmpleado

            sdsUltimoOdometro.SelectParameters(0).DefaultValue = idEquipo

            Dim buscarOdometro = proxy.buscarOdometroPorGrupo(hfldGrupo.Value, 1)

            If Not buscarOdometro Is Nothing Then
                txbOdometro.Text = buscarOdometro.odometro1
            End If


            GridView1.Visible = True
            Dim existe = existe_falla(idOrden, idChofer, idEquipo, True)

            If Not String.IsNullOrEmpty(existe) Then
                txbAveria.Text = existe
            End If


            Dim buscar_chofer = (From consulta In db.empleados,
                                 consulta2 In db.equipo_asignados
                              Where
                              consulta.id_empleado = consulta2.idEmpleado And
                              consulta2.id_equipo_asignado = EquipoAsignadoId
                              Select consulta).FirstOrDefault()

            If Not buscar_chofer Is Nothing Then
                lblChofer.Text = String.Format("{0} {1}", buscar_chofer.persona.primer_nombre, buscar_chofer.persona.apellido_paterno)
            End If


            Dim buscar_equipo = (From consulta In db.equipo_asignados
                              Where consulta.id_equipo_asignado = EquipoAsignadoId
                              Select consulta).FirstOrDefault()

            If Not buscar_equipo Is Nothing Then
                lblUnidad.Text = buscar_equipo.equipo_operacion.economico


                Dim tipo_equipo = buscar_equipo.equipo_operacion.id_tipo_equipo
                If tipo_equipo <> 102 Then
                    ddlEjesSalida.SelectedValue = 2
                    ddlEjesSalida.Enabled = False
                Else
                    ddlEjesSalida.SelectedValue = 4
                    ddlEjesSalida.Enabled = True
                End If

                sdsUltimoOdometro.SelectParameters(0).DefaultValue = buscar_equipo.id_equipo
                GridView1.DataBind()
            End If
        End If
    End Sub

    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim idEquipoAsignado = e.Row.Cells(1).Text

            Dim sdsTrayectos As SqlDataSource = CType(e.Row.FindControl("sdsTrayecto"), SqlDataSource)
            sdsTrayectos.SelectParameters(0).DefaultValue = idEquipoAsignado

        End If
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim idOrden = txbIdOrden.Text
        Dim IdEquipoAsignado = txbEquipoAsignadoId.Text
        Dim odometro = txbOdometro.Text

        If Not String.IsNullOrEmpty(IdEquipoAsignado) And Not String.IsNullOrEmpty(idOrden) Then

            If odometro > 0 Then

                Dim buscarAsignacion = proxy.buscarAsignacionPorId(IdEquipoAsignado)

                If Not buscarAsignacion Is Nothing Then

                    Dim idEquipo = buscarAsignacion.id_equipo
                    Dim idChofer = buscarAsignacion.idEmpleado

                    Dim buscarRecorrido = proxy.buscarRecorridoPorIdEquipoAsignado(IdEquipoAsignado)

                    If Not buscarRecorrido Is Nothing Then

                        Dim grupo = buscarRecorrido.grupo


                        Dim diferencia = comprobrar_odometro(idOrden, IdEquipoAsignado, odometro, idEquipo, idChofer)

                        Dim unidadCorrespondiente = buscarOdometroMasCercano(odometro)
                        

                        Dim MemUser As MembershipUser
                        MemUser = Membership.GetUser(User.Identity.Name)
                        Dim ejes_salida As String = ddlEjesSalida.SelectedValue

                        Try
                            Dim inspector As String = MemUser.UserName.ToString()
                            Dim tipo_trayecto = 1 ''Trayecto de inicio

                            'Dim existe_odometro_salida = buscar_odometro(idChofer, 1, grupo)

                            Dim buscarOdometroSalida = proxy.buscarOdometroPorGrupo(grupo, tipo_trayecto)

                            If buscarOdometroSalida Is Nothing Then

                                Dim nuevoOdometro As New wcfRef1.Odometro

                                nuevoOdometro.inspector = inspector
                                nuevoOdometro.id_equipo = idEquipo
                                nuevoOdometro.id_chofer = idChofer
                                nuevoOdometro.idOrden = idOrden
                                nuevoOdometro.grupo = grupo
                                nuevoOdometro.num_ejes = ejes_salida
                                nuevoOdometro.tipo_trayecto = 1
                                nuevoOdometro.odometro1 = odometro

                                proxy.crearOdometro(nuevoOdometro)

                                ' actualizar_odometro(grupo, idChofer, 1, odometro, ejes_salida)
                            Else

                                buscarOdometroSalida.inspector = inspector
                                buscarOdometroSalida.id_equipo = idEquipo
                                buscarOdometroSalida.id_chofer = idChofer
                                buscarOdometroSalida.grupo = grupo
                                buscarOdometroSalida.num_ejes = ejes_salida
                                buscarOdometroSalida.tipo_trayecto = 1
                                buscarOdometroSalida.idOrden = idOrden
                                buscarOdometroSalida.odometro1 = odometro

                                proxy.actualizarOdometro(buscarOdometroSalida)

                                'nuevo_odometro_eje(inspector, idOrden, idEquipo, idChofer, odometro_inicio, tipo_trayecto, ejes_salida, grupo)
                            End If



                            'grdViaje.DataBind()

                            txbOdometro.Text = String.Empty
                            lblMensaje.Text = "Listo!"

                        Catch ex As Exception

                            Response.Redirect("~/Default.aspx")
                        End Try
                    Else
                        lblMensaje.Text = "No se encontro el recorrido de esta unidad."
                    End If
                End If
            Else
                lblMensaje.Text = "El odometro debe ser mayor que cero."
            End If

        Else
            lblMensaje.Text = "Seleccione la unidad."
        End If

    End Sub
End Class