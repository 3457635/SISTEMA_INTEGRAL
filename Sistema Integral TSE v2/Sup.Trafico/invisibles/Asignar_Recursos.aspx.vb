Partial Public Class Asignar_Recursos
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()
    Dim bandera As Boolean = False
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim query As String
        If Not IsPostBack Then
            ddlUnidad.Items.Add(Crear_item("Seleccionar...", 0))
            ddlCaja.Items.Add(Crear_item("-", 0))

            txbAno.Text = Now.Year.ToString()

            btnGuardar.Enabled = True
            Dim db As New DataClasses1DataContext()
            If Request.Params("id_viaje") <> "" Then

                Dim idViaje = Request.Params("id_viaje")
                ddlOrden.SelectedValue = idViaje

                txbIdViaje.Text = Request.Params("id_viaje")
                lnkOrden.NavigateUrl = "~/Sup.Trafico/Orden.aspx?id_viaje=" + txbIdViaje.Text
                lnkLiquidacion.NavigateUrl = "~/Sup.Trafico/Liquidacion.aspx?id_viaje=" + txbIdViaje.Text
                sdsConCaja.SelectParameters(0).DefaultValue = idViaje

            Else
                'status de viaje 2=abierto 
                query = "Select id_viaje as info from viajes WHERE viajes.id_status=2 order by id_viaje desc"
                txbIdViaje.Text = SeleccionarRegistro(query)
                lnkOrden.NavigateUrl = "~/Sup.Trafico/Orden.aspx?id_viaje=" + txbIdViaje.Text
                lnkLiquidacion.NavigateUrl = "~/Sup.Trafico/Liquidacion.aspx?id_viaje=" + txbIdViaje.Text
            End If


            Dim id_viaje As String = txbIdViaje.Text
            'Habilitar o deshabilitar la seleccion de caja

            Dim tipo_vehiculo = (From querylinq In db.equipo_operacions
                                 Where querylinq.id_tipo_equipo <> 107
                            Select querylinq.id_tipo_equipo, querylinq.economico
                            Order By economico).FirstOrDefault()

            Dim id_tipo_vehiculo = tipo_vehiculo.id_tipo_equipo



            seguimientoEnRuta(id_viaje)


            If id_tipo_vehiculo <> "102" Then
                ddlCaja.Enabled = "False"
            Else
                ddlCaja.Enabled = "true"
            End If

        End If

    End Sub

    Sub seguimientoEnRuta(ByVal id_viaje)
        Dim buscarViaje = proxy.buscarViajePorId(id_viaje)

        If Not buscarViaje Is Nothing Then
            Dim buscarPrecio = proxy.buscarPrecioPorId(buscarViaje.id_relacion)
            If Not buscarPrecio Is Nothing Then
                Dim buscarRuta = proxy.buscarLlaveRutaPorId(buscarPrecio.id_ruta)

                If Not buscarRuta Is Nothing Then
                    If buscarRuta.sinSeguimiento Then
                        ckbSinSeguimiento.Checked = True

                        buscarViaje.id_status = 4
                        proxy.actualizarViaje(buscarViaje)


                    Else
                        ckbSinSeguimiento.Checked = False
                    End If
                End If

            End If

        End If
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim id_Viaje As String = txbIdViaje.Text
        Dim chofer As String = ddlChofer.SelectedValue
        Dim unidad As String = ddlUnidad.SelectedValue
        Dim caja = ddlCaja.SelectedValue
        Dim multichofer As Boolean = False

        Dim idRecorrido = ddlRecorrido.SelectedValue
        '2 regreso
        If idRecorrido >= 2 And idRecorrido <= 3 And String.IsNullOrEmpty(txbOrdenInicio.Text) Then
            lblAnuncio.Text = "Ingrese la orden con la que inicio la unidad."
        Else

            Dim id_trayecto = 0

            If ckbMultichofer.Checked Then
                multichofer = True
                If ddlTrayecto.SelectedValue <> 0 Then
                    id_trayecto = ddlTrayecto.SelectedValue
                End If
            End If

            Dim id_unidad As String = ddlUnidad.SelectedValue
            Dim exito = False


            Dim idEquipoAsignado = txbEquipoAsignadoId.Text
            'nueva variable para hermanar trayectos en la misma orden
            Dim flag As Integer = 0
            If idRecorrido = 8 And lblSolocruce.Text = "1" Then
                flag = flag + 1
            End If
            '--------------------------------------
            ''si es una asignacion nueva
            If String.IsNullOrEmpty(idEquipoAsignado) Then
                'nuevaAsignacionRecursos tiene un cambio para hermanar en la misma orden modificar si hay problemas se agrego el parametro flag
                idEquipoAsignado = nuevaAsignacionRecursos(multichofer, chofer, id_unidad, caja, id_Viaje, id_trayecto, flag)
                registarRecorrido(idEquipoAsignado, False)

            Else ''si es una modificacion

                '' Al hermanar dentro de la misma orden se obtienen id_equipo_asignado que no son los esperados
                modificarAsignacion(idEquipoAsignado)
                registarRecorrido(idEquipoAsignado, True)
                'Response.Redirect("~/Sup.Trafico/invisibles/Asignar_Recursos.aspx?id_viaje=" + id_Viaje)
            End If
            'quitar si hay problemas
            If idRecorrido = 8 And String.IsNullOrWhiteSpace(lblSolocruce.Text) Then
                lblSolocruce.Text = 1
            End If
            '------------------------

           


            LinkButton1.Visible = True
            If String.IsNullOrWhiteSpace(lblAnuncio.Text) Then
                lblAnuncio.Text = "La información se almacenó exitosamente."
            End If

            sdsRecorridos.SelectParameters(0).DefaultValue = id_Viaje
            sdsConCaja.SelectParameters(0).DefaultValue = id_Viaje

            GridView6.DataBind()
            ddlRecorrido.BackColor = Drawing.Color.White
            ddlRecorrido.SelectedValue = 0
            lnkOrden.Visible = True
            lnkLiquidacion.Visible = True
        End If
        'aqui se des-selecciona la fila en el gridview6, si el usuario selecciono una asignacion de recursos para editar
        If GridView6.SelectedIndex > -1 Then
            GridView6.EditIndex = -1
            GridView6.SelectedIndex = -1
            Response.Redirect("~/Sup.Trafico/invisibles/Asignar_Recursos.aspx?id_viaje=" + id_Viaje)
        End If

        
    End Sub


    Public Function registarRecorrido(ByVal idEquipoAsignado As Integer, ByVal modificacion As Boolean)

        Dim idRecorrido = ddlRecorrido.SelectedValue
        Dim id_Viaje As String = txbIdViaje.Text
        Dim chofer As String = ddlChofer.SelectedValue
        Dim unidad As String = ddlUnidad.SelectedValue
        Dim caja = 0
        Dim multichofer As Boolean = False
        Dim id_unidad As String = ddlUnidad.SelectedValue
        Dim exito = False
        Dim id_trayecto = ddlTrayecto.SelectedValue
        ''Si la unidad es de juarez el regreso va en un nuevo grupo
        Dim baseUnidad = 1110000000


        Dim result = False

        Dim buscarUnidad = (From consulta In db.equipo_operacions
                         Where consulta.id_equipo = id_unidad
                         Select consulta).FirstOrDefault()

        If Not buscarUnidad Is Nothing Then
            baseUnidad = buscarUnidad.idBase
        End If

        Dim grupo As Integer = 0
        Dim fecha = regresarFechaViaje(id_Viaje)
        Dim recorridoPrevio = recorridoAnterior(id_unidad, fecha)

        ''Si el viaje inicia
        If (idRecorrido = 1 Or idRecorrido >= 4 Or baseUnidad = 1000000003) And Not modificacion Then
            grupo = nuevoGrupo()

            Dim nRecorrido As New wcfRef1.recorridoEquipo()
            nRecorrido.idEquipoAsignado = idEquipoAsignado
            nRecorrido.tipoTrayecto = idRecorrido
            nRecorrido.grupo = grupo

            proxy.crearRecorrido(nRecorrido)

            exito = True
        Else
            ''Si es un regreso
            Dim ano = txbAno.Text
            Dim consecutivo = txbOrdenInicio.Text

            ''Es necesario que proporsione la orden con la que inicio el viaje
            If Not String.IsNullOrEmpty(ano) And Not String.IsNullOrEmpty(consecutivo) Then

                Dim ea = proxy.buscarAsignacionPorOrden(ano, consecutivo, id_unidad)

                'comentar esto si hay problemas
                'hice mi propia sentecia para buscar el id_equipo_asignado del grupo de inicio, 
                'ya que cuando habia mas de una tupla solo devolvia la primera y no era la correcta
                ' 
                Dim buscarAsigPorOrden = (From consulta In db.equipo_asignados
                Where consulta.viaje.Ordene.ano = ano And consulta.viaje.Ordene.consecutivo = consecutivo And consulta.id_equipo = id_unidad
                         Select consulta)
                Dim idequipoasiGrupo As Integer = 0
                'selecciono el idequipoasignado mas chico porque si tomaria el mismo y no se guardaria bien
                For Each elemento In buscarAsigPorOrden
                    Dim a As Integer

                    a = elemento.id_equipo_asignado

                    If idequipoasiGrupo = 0 Then
                        idequipoasiGrupo = a
                    End If
                    If a < idequipoasiGrupo Then
                        idequipoasiGrupo = a
                    End If
                Next
                '-------------------------------------------------------------------------------------------------------------------------------------------

                If Not ea Is Nothing Then
                    'descomentar la linea de abajo si hay problemas
                    'Dim buscarGrupoInicio = proxy.buscarRecorridoPorIdEquipoAsignado(ea.id_equipo_asignado)

                    'comentar esto si hay problemas
                    'en lugar de que recibiera el id_equipo_asignado actual hago que reciba el del grupo de inicio, esto para que sea en la misma orden 
                    Dim buscarGrupoInicio = proxy.buscarRecorridoPorIdEquipoAsignado(idequipoasiGrupo)
                    '---------------------------------------------------------------------------------------------------------------------------------------
                    If Not buscarGrupoInicio Is Nothing Then
                        grupo = buscarGrupoInicio.grupo
                        sdsViajesRegreso.SelectParameters("grupo").DefaultValue = grupo

                        If Not modificacion Then
                            Dim nRecorrido As New wcfRef1.recorridoEquipo()
                            nRecorrido.idEquipoAsignado = idEquipoAsignado
                            nRecorrido.tipoTrayecto = idRecorrido
                            nRecorrido.grupo = grupo
                            proxy.crearRecorrido(nRecorrido)
                        Else
                            Dim buscarRecorrido = proxy.buscarRecorridoPorIdEquipoAsignado(idEquipoAsignado)
                            If Not buscarRecorrido Is Nothing Then
                                buscarRecorrido.grupo = grupo
                                proxy.actualizarRecorrido(buscarRecorrido)
                            End If
                        End If


                    Else
                        lblAnuncio.Text = "No se encontró el viaje inicial. Verifique que la orden y la unidad sean correctas."
                    End If


                End If

            Else
                lblAnuncio.Text = "Proporsione la orden de inicio del viaje."
            End If

        End If
        Return result
    End Function


    Public Sub modificarAsignacion(ByVal idEquipoAsignado As Integer)
        Dim buscarTrayecto = proxy.buscarTrayectoPorAsignacion(idEquipoAsignado)


        ''Trayectos
        If ckbMultichofer.Checked Then
            If buscarTrayecto Is Nothing Then ''Si esta cambiando de unichofer a multichofer
                Dim nuevoTrayecto As New wcfRef1.trayectos_asignados
                nuevoTrayecto.id_trayecto = ddlTrayecto.SelectedValue
                nuevoTrayecto.EquipoAsignadoId = idEquipoAsignado
                nuevoTrayecto.idEstatus = 1

                proxy.crearTrayectoAsignado(nuevoTrayecto)
            Else ''Si esta corrijiendo el trayecto
                buscarTrayecto.id_trayecto = ddlTrayecto.SelectedValue
                proxy.actualizarTrayectoAsignado(buscarTrayecto)
            End If
        Else ''si esta cambiando de multichofer a unichofer
            If Not buscarTrayecto Is Nothing Then
                proxy.eliminarTrayectoAsignado(buscarTrayecto)
            End If
        End If

        ''Equipo Asignado
        Dim buscarEquipo = proxy.buscarAsignacionPorId(idEquipoAsignado)

        If Not buscarEquipo Is Nothing Then
            buscarEquipo.id_equipo = ddlUnidad.SelectedValue
            buscarEquipo.idEmpleado = ddlChofer.SelectedValue
            proxy.actualizarEquipoAsignado(buscarEquipo)
        End If


        Dim tipoEquipo = proxy.buscarEquipoPorId(buscarEquipo.id_equipo)

        Dim buscarCaja = proxy.buscarCajaPorAsignacion(idEquipoAsignado)

        If Not tipoEquipo Is Nothing Then
            If tipoEquipo.id_tipo_equipo = 102 Then ''Si es tracto

                If Not buscarCaja Is Nothing Then ''actualizamos la caja
                    buscarCaja.CajaId = ddlCaja.SelectedValue
                    proxy.actualizarCajaAsignada(buscarCaja)
                Else ''si no tenia caja asignada
                    Dim nuevaCajaAsignada As New wcfRef1.cajaAsignada()
                    nuevaCajaAsignada.EquipoAsignadoId = idEquipoAsignado
                    nuevaCajaAsignada.CajaId = ddlCaja.SelectedValue

                    proxy.crearCajaAsignada(nuevaCajaAsignada)
                End If
            Else
                If Not buscarCaja Is Nothing Then ''Si esta cambiando de tracto a otro vehiculo
                    proxy.eliminarCajaAsignada(buscarCaja)
                End If
            End If
        End If



    End Sub




    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LinkButton1.Click
        Response.Redirect("~/Sup.Trafico/Autorizaciones.aspx")
    End Sub

    Protected Sub ddlUnidad_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.SelectedIndexChanged

    End Sub



    Protected Sub btnTrayecto_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnTrayecto.Click
        Dim id_viaje As String = txbIdViaje.Text


        Dim ubicaciones As New DataTable
        ubicaciones.TableName = "ubica"
        ubicaciones.Columns.Add("ubicacion", GetType(String))
        ubicaciones.Columns.Add("id_ubicacion", GetType(String))

        Dim llegamos_ultima_parada As Boolean = False
        Dim id_principal As String = id_principal_origen(id_viaje) 'obtenemos la llave del punto de origen
        Dim id_destino As String = siguiente_parada(CInt(id_principal), id_viaje)
        Dim id_origen As String = id_ubicacion_origen(id_viaje) 'obtenemos la llave de la ubicación
        Dim posicion_actual As String = id_origen
        Dim destino_original As Integer = 0
        Dim ruta_con_vuelta As Boolean = False
        Dim id_principal_siguiente As Integer = 0
        Dim botador As Integer = 0
        Dim ultimo_seguimiento As String = obtener_ultimo_seguimiento(id_viaje)



        While Not llegamos_ultima_parada

            Dim punto_interseccion As String = obtener_puntodeinterseccion(posicion_actual, id_destino)

            If punto_interseccion <> id_destino Then
                destino_original = id_destino
                id_destino = encontrar_punto_max_subruta(punto_interseccion)
                ruta_con_vuelta = True
            Else
                ruta_con_vuelta = False
            End If
            id_principal_siguiente += 1

            Dim tipo_ubicacion As String = ""
            Dim ir_a As String = ""

            Dim query As String = String.Empty

            While posicion_actual <> id_destino And botador < 45

                tipo_ubicacion = obtener_tipo_ubicacion(posicion_actual)
                botador += 1
                If botador <> 1 Then
                    ir_a = obtener_siguiente_paso(id_destino, posicion_actual, tipo_ubicacion)
                    posicion_actual = ir_a
                End If


                Dim nombre_ubicacion As String = obtener_nombre_ubicacion(posicion_actual)

                Dim buscar_id_principal = (From consulta In db.ubicaciones
                           Where consulta.id_ubicacion = posicion_actual
                           Select consulta).FirstOrDefault()

                Dim id_principal_ubicacion = buscar_id_principal.id_principal

                ubicaciones.Rows.Add(nombre_ubicacion, id_principal_ubicacion)

            End While

            If botador >= 60 Then
                llegamos_ultima_parada = True
            Else
                If ruta_con_vuelta Then
                    posicion_actual = id_destino
                    id_destino = destino_original
                Else
                    posicion_actual = id_destino
                    id_destino = siguiente_parada(CInt(id_principal) + id_principal_siguiente, id_viaje)
                    If id_destino = "" Then
                        llegamos_ultima_parada = True
                    End If
                End If
            End If
        End While
        ddlOrigen.DataTextField = "ubicacion"
        ddlOrigen.DataValueField = "id_ubicacion"

        ddlOrigen.DataSource = ubicaciones
        ddlOrigen.DataBind()

        ddlDestino.DataTextField = "ubicacion"
        ddlDestino.DataValueField = "id_ubicacion"

        ddlDestino.DataSource = ubicaciones
        ddlDestino.DataBind()

        mdlTrayecto.Show()

    End Sub

    Protected Sub btnAsignar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnAsignar.Click
        Dim id_origen As String = ddlOrigen.SelectedValue
        Dim id_destino As String = ddlDestino.SelectedValue

        Dim id_viaje As String = txbIdViaje.Text

        Dim buscar_ruta = (From consulta In db.viajes
                        Where consulta.id_viaje = id_viaje
                        Select consulta).FirstOrDefault()

        If Not buscar_ruta Is Nothing Then
            Dim idruta = buscar_ruta.precio.id_ruta
            Dim trayecto As String = ddlOrigen.SelectedItem.ToString + "-" + ddlDestino.SelectedItem.ToString
            lblRuta.Text = trayecto

            Dim buscar_trayecto = (From consulta In db.llave_trayectos
                                Where consulta.trayecto = trayecto
                                Select consulta).FirstOrDefault()

            If buscar_trayecto Is Nothing Then

                Dim nuevo_trayecto As New llave_trayecto With {.trayecto = trayecto, .id_status = 5, .id_ruta = idruta}
                Dim nuevo_trayectos_origen As New trayecto With {.llave_trayecto = nuevo_trayecto, .id_tipo_arrivo = 1, .id_ubicacion = id_origen}
                Dim nuevo_trayectos_destino As New trayecto With {.llave_trayecto = nuevo_trayecto, .id_tipo_arrivo = 3, .id_ubicacion = id_destino}
                Dim asignar_trayecto_a_ruta As New trayecto_ruta With {.llave_trayecto = nuevo_trayecto, .id_ruta = idruta}

                db.trayectos.InsertOnSubmit(nuevo_trayectos_origen)
                db.trayectos.InsertOnSubmit(nuevo_trayectos_destino)
                db.trayecto_rutas.InsertOnSubmit(asignar_trayecto_a_ruta)
                db.SubmitChanges()
                ddlTrayecto.DataBind()
            Else
                Dim id_trayecto = buscar_trayecto.id_trayecto

                Dim trayecto_asignado_a_ruta = (From consulta In db.trayecto_rutas
                                                         Where consulta.id_trayecto = id_trayecto And
                                                         consulta.id_ruta = idruta
                                                         Select consulta).FirstOrDefault()
                If trayecto_asignado_a_ruta Is Nothing Then
                    Dim asignar_trayecto_a_ruta As New trayecto_ruta With {.id_trayecto = id_trayecto, .id_ruta = idruta}
                    db.trayecto_rutas.InsertOnSubmit(asignar_trayecto_a_ruta)
                    db.SubmitChanges()
                    ddlTrayecto.DataBind()
                Else
                    lblMensaje2.Text = "El trayecto ya existe."
                End If
            End If
        End If
    End Sub



    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlOrden.SelectedIndexChanged
        txbIdViaje.Text = ddlOrden.SelectedValue

        Dim viajeId = txbIdViaje.Text

        seguimientoEnRuta(viajeId)

        lnkOrden.NavigateUrl = String.Format("~/Sup.Trafico/Orden.aspx?id_viaje={0}", viajeId)
        lnkLiquidacion.NavigateUrl = String.Format("~/Sup.Trafico/Liquidacion.aspx?id_viaje={0}", viajeId)

        Dim buscar_multichofer = (From consulta In db.equipo_asignados
                               Where consulta.ViajeId = viajeId
                               Select consulta.idEmpleado).Count()

        Dim cantidad_de_choferes = buscar_multichofer
        sdsConCaja.SelectParameters(0).DefaultValue = viajeId
        sdsRecorridos.SelectParameters(0).DefaultValue = viajeId

        If cantidad_de_choferes > 1 Then
            ckbMultichofer.Checked = True
            ddlTrayecto.Enabled = True
            btnTrayecto.Enabled = True

        Else
            ckbMultichofer.Checked = False
            ddlTrayecto.Enabled = False
            btnTrayecto.Enabled = False

        End If
        txbEquipoAsignadoId.Text = String.Empty
        btnGuardar.Enabled = True
    End Sub


    Protected Sub lnkChofer_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkChofer.Click
        Response.Redirect("~/Recursos_Humanos/Catalogos/empleados.aspx")
    End Sub

    Protected Sub lnkUnidades_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkUnidades.Click
        Response.Redirect("~/Sup.Trafico/Catalogos/Unidades.aspx")
    End Sub

    Protected Sub ckbMultichofer_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ckbMultichofer.CheckedChanged
        lblAnuncio.Text = ""
        LinkButton1.Visible = False
        lnkOrden.Visible = False
        lnkLiquidacion.Visible = False
        btnGuardar.Enabled = True

        If ckbMultichofer.Checked Then
            ddlTrayecto.Enabled = True
            btnTrayecto.Enabled = True
        Else
            ddlTrayecto.Enabled = False
            btnTrayecto.Enabled = False
        End If
    End Sub

    Protected Sub lnkCajas_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkCajas.Click
        Response.Redirect("~/Sup.Trafico/Catalogos/Unidades.aspx")
    End Sub


    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView6.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim IdEquipoAsignado = e.Row.Cells(1).Text

            Dim sdsTrayectos As SqlDataSource = CType(e.Row.FindControl("sdsTrayectos"), SqlDataSource)
            Dim sdsCaja As SqlDataSource = CType(e.Row.FindControl("sdsCaja"), SqlDataSource)
            Dim ckbOdometro As CheckBox = CType(e.Row.FindControl("ckbOdometro"), CheckBox)
            Dim ckbRecargas As CheckBox = CType(e.Row.FindControl("ckbRecargas"), CheckBox)
            Dim sdsRecorrido As SqlDataSource = CType(e.Row.FindControl("sdsRecorrido"), SqlDataSource)
            Dim buscarGrupo = proxy.buscarRecorridoPorIdEquipoAsignado(IdEquipoAsignado)

            If Not buscarGrupo Is Nothing Then
                Dim grupo = buscarGrupo.grupo
                Dim buscarOdometro = proxy.buscarOdometroPorGrupo(grupo, 1)

                If Not buscarOdometro Is Nothing Then
                    ckbOdometro.Checked = True
                End If

                Dim buscarRecargas = proxy.buscarLtsPorAsignacion(IdEquipoAsignado)

                If buscarRecargas > 0 Then
                    ckbRecargas.Checked = True

                End If

                sdsCaja.SelectParameters(0).DefaultValue = IdEquipoAsignado
                sdsTrayectos.SelectParameters(0).DefaultValue = IdEquipoAsignado
                sdsRecorrido.SelectParameters(0).DefaultValue = IdEquipoAsignado
            End If
        End If

    End Sub




    Protected Sub GridView6_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView6.SelectedIndexChanged
        Dim fila = GridView6.SelectedRow

        Dim idEquipoAsignado = fila.Cells(1).Text

        txbEquipoAsignadoId.Text = idEquipoAsignado

        Dim trayectoAsignado = proxy.buscarTrayectoPorAsignacion(idEquipoAsignado)

        Dim equipoAsignado = proxy.buscarAsignacionPorId(idEquipoAsignado)

        If Not trayectoAsignado Is Nothing Then
            ckbMultichofer.Enabled = True
            ckbMultichofer.Checked = True
            ddlTrayecto.Enabled = True
            btnTrayecto.Enabled = True
            ddlTrayecto.SelectedValue = trayectoAsignado.id_trayecto
        End If

        If Not equipoAsignado Is Nothing Then
            ddlChofer.SelectedValue = equipoAsignado.idEmpleado
            ddlUnidad.SelectedValue = equipoAsignado.id_equipo
        End If

        Dim cajaAsignada = proxy.buscarCajaPorAsignacion(idEquipoAsignado)

        If Not cajaAsignada Is Nothing Then
            ddlCaja.SelectedValue = cajaAsignada.CajaId
        End If


        Dim recorridoEquipo = proxy.buscarRecorridoPorIdEquipoAsignado(idEquipoAsignado)

        If Not recorridoEquipo Is Nothing Then
            ddlRecorrido.SelectedValue = recorridoEquipo.tipoTrayecto

            If recorridoEquipo.tipoTrayecto = 2 Or recorridoEquipo.tipoTrayecto = 3 Then

                Dim buscarViaje = proxy.buscarViajePorId(equipoAsignado.ViajeId)

                If Not buscarViaje Is Nothing Then
                    Dim buscarOrden = proxy.buscarOrdenPorId(buscarViaje.id_orden)

                    If Not buscarOrden Is Nothing Then
                        txbOrdenInicio.Text = buscarOrden.consecutivo
                        txbAno.Text = buscarOrden.ano
                    End If
                End If


            End If

        End If


    End Sub

    Protected Sub GridView6_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles GridView6.RowDeleting
        Dim idEquipoAsignado = GridView6.Rows(e.RowIndex).Cells(1).Text
        Dim buscarGrupo = proxy.buscarRecorridoPorIdEquipoAsignado(idEquipoAsignado)
        Dim buscarRecargas = proxy.buscarLtsPorAsignacion(idEquipoAsignado)
        Dim grupo = 0
        bandera = True
        If Not buscarGrupo Is Nothing Then
            Dim buscarOdometros = proxy.buscarOdometroPorGrupo(buscarGrupo.grupo, 1)
            If Not buscarOdometros Is Nothing Then
                e.Cancel = True
                lblAnuncio.Text = "Este trayecto ya tiene recargas registradas."
            End If


        End If

        If buscarRecargas > 0 Then
            e.Cancel = True
            lblAnuncio.Text = "Este trayecto ya tiene recargas registradas."
        End If




    End Sub

    Protected Sub ckbSinSeguimiento_CheckedChanged(sender As Object, e As EventArgs) Handles ckbSinSeguimiento.CheckedChanged
        Dim idViaje = txbIdViaje.Text

        Dim buscarViaje = proxy.buscarViajePorId(idViaje)

        If Not buscarViaje Is Nothing Then
            Dim buscarPrecio = proxy.buscarPrecioPorId(buscarViaje.id_relacion)
            If Not buscarPrecio Is Nothing Then
                Dim buscarRuta = proxy.buscarLlaveRutaPorId(buscarPrecio.id_ruta)

                If Not buscarRuta Is Nothing Then
                    If ckbSinSeguimiento.Checked Then
                        buscarRuta.sinSeguimiento = True
                        buscarViaje.id_status = 4
                    Else
                        buscarRuta.sinSeguimiento = False
                    End If

                    proxy.actualizarLlaveRuta(buscarRuta)
                End If

            End If

        End If



    End Sub
End Class