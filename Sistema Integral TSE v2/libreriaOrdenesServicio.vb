Module libreriaOrdenesServicio
    Dim db As New DataClasses1DataContext()


    Function crearRecorrido(ByVal idEquipoAsignado,
                                    ByVal idRecorrido,
                                    ByVal grupo
                                    )
        Dim result = True

        Dim nuevoRecorrido As New recorridoEquipo With {.tipoTrayecto = idRecorrido,
                                                        .grupo = grupo,
                                                        .idEquipoAsignado = idEquipoAsignado}

        db.recorridoEquipos.InsertOnSubmit(nuevoRecorrido)

        Try
            db.SubmitChanges()
        Catch
            Return False
        End Try

        Return result
    End Function

    Function comprobarInicio(ByVal grupo As Integer)
        Dim result = False

        Dim buscarFechaInicio = (From consulta In db.recorridoEquipos
                                Where consulta.tipoTrayecto = 1
                                Select consulta).FirstOrDefault()

        If Not buscarFechaInicio Is Nothing Then


        End If

        Return result
    End Function



    Function recorridoAnterior(ByVal idUnidad As Integer, ByVal fecha As Date)
        Dim result = Nothing

        Dim ordenAnterior = (From consulta In db.fechas_viajes,
                            consulta2 In db.recorridoEquipos
                          Where consulta.id_viaje = consulta2.equipo_asignado.ViajeId And
                          consulta.fecha.fecha <= fecha And
                          consulta2.equipo_asignado.id_equipo = idUnidad
                          Select consulta2
                          Order By consulta2.id Descending).FirstOrDefault()

        If Not ordenAnterior Is Nothing Then
            result = ordenAnterior.tipoTrayecto
        End If

        Return result
    End Function

    Function nuevoGrupo()
        Dim result = 1

        Dim buscarUltimoGrupo = (From consulta In db.recorridoEquipos
                              Select consulta
                              Order By consulta.grupo Descending).FirstOrDefault()

        If Not buscarUltimoGrupo Is Nothing Then
            result = buscarUltimoGrupo.grupo + 1
        End If


        Return result
    End Function

    Function regresarFechaViaje(ByVal idViaje As Integer)
        Dim result = Nothing

        Dim buscar = (From
                     consulta In db.fechas_viajes
                   Where consulta.id_viaje = idViaje And
                   consulta.fecha.tipo_fecha = 1
                   Select consulta).FirstOrDefault()

        If Not buscar Is Nothing Then
            result = buscar.fecha.fecha.Value.Date
        End If


        Return result
    End Function

    Function regresarGrupo(ByVal fechaViaje As Date, ByVal idEquipo As Integer) As Integer
        Dim result = 0

        ''Buscar viajes con el tipo de trayecto 1 0 9
        ''que no sean cancelados o eliminados
        ''

        Dim buscarViajeInicio = (From consulta In db.recorridoEquipos,
                                      consulta2 In db.fechas_viajes
                                      Where
                                      consulta.equipo_asignado.ViajeId = consulta2.id_viaje And
                                      (consulta.tipoTrayecto = 1 Or
                                      consulta.tipoTrayecto = 9) And
                                      consulta.equipo_asignado.viaje.id_status <> 3 And
                                      consulta.equipo_asignado.viaje.id_status <> 5 And
                                      consulta2.fecha.fecha <= fechaViaje.AddHours(3) And
                                      consulta2.fecha.fecha >= fechaViaje.AddHours(-72) And
                                      consulta2.fecha.tipo_fecha = 1 And
                                      consulta.equipo_asignado.id_equipo = idEquipo And
                                      Not (From consulta3 In db.recorridoEquipos
                                           Where
                                           consulta3.tipoTrayecto = 2 And
                                            consulta3.equipo_asignado.id_equipo = consulta.equipo_asignado.id_equipo
                                           Select consulta3.grupo).Contains(consulta.grupo)
                                      Select consulta
                                      Order By consulta.id Descending).FirstOrDefault()

        If Not buscarViajeInicio Is Nothing Then
            result = buscarViajeInicio.grupo
        End If

        Return result
    End Function

    Function es_viaje_local(ByVal id_orden As Integer)
        Dim es_local As Boolean
        Dim buscar_viajes = From consulta In db.viajes
                        Where consulta.Ordene.id_orden = id_orden
                        Select consulta
        Dim inicio As Integer
        Dim puntos_intermedios As Boolean = False
        Dim fin As Integer

        For Each viaje In buscar_viajes
            Dim id_viaje = viaje.id_viaje
            Dim buscar_ruta = From consulta In db.viajes, consulta2 In db.rutas
                            Where consulta.precio.llave_ruta.id_ruta = consulta2.id_ruta And
                            consulta.id_viaje = id_viaje
                            Select consulta2

            puntos_intermedios = False
            inicio = 0
            fin = 0
            For Each ruta In buscar_ruta

                Select Case ruta.id_tipo_arrivo
                    Case 1
                        inicio = ruta.id_ubicacion
                    Case 2
                        puntos_intermedios = True
                    Case 3
                        fin = ruta.id_ubicacion

                End Select
                If inicio = fin And Not puntos_intermedios Then
                    es_local = True
                End If
            Next
        Next


        Return es_local
    End Function
    Public Function guardarFechaDestino(ByVal idViaje As Integer,
                                        ByVal idArrivo As Integer,
                                        ByVal hora As String,
                                        ByVal fecha As String)

        Dim buscarDestino = (From consulta In db.llegadaDestinos
                          Where consulta.idViaje = idViaje
                          Select consulta).FirstOrDefault()

        Dim llegada = String.Format("{0} {1}", fecha, hora)

        If Not buscarDestino Is Nothing Then
            buscarDestino.fecha = llegada
            buscarDestino.idViaje = idViaje
            buscarDestino.idArrivo = idArrivo
        Else
            Dim nuevoDestino As New llegadaDestino With {.idArrivo = idArrivo,
                                                         .idViaje = idViaje,
                                                         .fecha = llegada}
            db.llegadaDestinos.InsertOnSubmit(nuevoDestino)
        End If

        Dim errorAlGuardar = String.Empty

        Try
            db.SubmitChanges()
        Catch ex As Exception
            Return errorAlGuardar = ex.Message
        End Try

        Return errorAlGuardar
    End Function

    Public Function actualizarOrden(ByVal idViaje As Integer,
                                    ByVal idRelacion As Integer,
                                    ByVal idContacto As Integer,
                                    ByVal fechaViaje As String,
                                    ByVal guia As String,
                                    ByVal recolecciones As String)

        Dim actualizar_viaje = (From consulta In db.viajes
                                       Where consulta.id_viaje = idViaje
                                       Select consulta).FirstOrDefault()

        Dim errorAlGuardar = String.Empty

        If Not actualizar_viaje Is Nothing Then
            actualizar_viaje.id_relacion = idRelacion
            actualizar_viaje.id_contacto = idContacto
            Try
                db.SubmitChanges()

            Catch ex As Exception
                errorAlGuardar = ex.Message
                EnviarCorreo("sistemas@tse.com.mx", "Error al actualizar orden", errorAlGuardar)
            End Try

        End If




        If actualizar_viaje.id_status = 2 Then
            limpiarPuntosPendientes(idViaje)
        End If

        Dim buscarFecha = (From consulta In db.fechas_viajes
                        Where consulta.id_viaje = idViaje And
                        consulta.fecha.tipo_fecha = 1
                        Select consulta).FirstOrDefault()

        If Not buscarFecha Is Nothing Then

            Dim buscarFechaInicio = (From consulta In db.fechas
                                  Where consulta.id_fecha = buscarFecha.id_fecha
                                  Select consulta).FirstOrDefault()

            If Not buscarFechaInicio Is Nothing Then
                buscarFechaInicio.fecha = fechaViaje
                Try
                    db.SubmitChanges()

                Catch ex As Exception
                    errorAlGuardar = ex.Message
                    EnviarCorreo("sistemas@tse.com.mx", "Error al actualizar fecha de orden", errorAlGuardar)
                End Try
            End If




        End If




        If Not String.IsNullOrEmpty(guia) Then
            Dim buscar_guia = (From consulta In db.guias
                            Where consulta.id_viaje = idViaje
                            Select consulta).FirstOrDefault()
            If buscar_guia Is Nothing Then
                Dim nueva_guia As New guia With {.guia = guia, .id_viaje = idViaje}
                db.guias.InsertOnSubmit(nueva_guia)
            Else
                buscar_guia.guia = guia
            End If

            Try
                db.SubmitChanges()

            Catch ex As Exception
                errorAlGuardar = ex.Message
                EnviarCorreo("sistemas@tse.com.mx", "Error al actualizar guia de orden", errorAlGuardar)
            End Try
        End If

        If Not String.IsNullOrEmpty(recolecciones) And IsNumeric(recolecciones) And recolecciones <> "0" Then

            Dim actualizar_recolecciones = (From consulta In db.recolecciones
                                         Where consulta.id_viaje = idViaje
                                         Select consulta).FirstOrDefault()

            If Not actualizar_recolecciones Is Nothing Then
                actualizar_recolecciones.recolecciones = recolecciones

            Else
                Dim insertar_recoleccion As New recoleccione With {.recolecciones = recolecciones, .id_viaje = idViaje}
                db.recolecciones.InsertOnSubmit(insertar_recoleccion)

            End If

            Try
                db.SubmitChanges()

            Catch ex As Exception
                errorAlGuardar = ex.Message
                EnviarCorreo("sistemas@tse.com.mx", "Error al actualizar recolecciones de orden", errorAlGuardar)
            End Try
        End If


        Return errorAlGuardar
    End Function


    Public Function nuevaOrden(ByVal anoActual As Integer,
                               ByVal consecutivo As Integer,
                               ByVal idRelacion As Integer,
                               ByVal idContacto As Integer,
                               ByVal fecha_viaje_asignada As String,
                               ByVal guia As String,
                               ByVal recolecciones As String
                               )


        Dim nueva_orden As New Ordene With {.id_status = 1, .ano = anoActual, .consecutivo = consecutivo}

        Dim nuevo_viaje As New viaje With {.id_relacion = idRelacion,
                                           .id_contacto = idContacto,
                                           .id_status = 1,
                                           .num_viaje = 1,
                                          .verificado = False,
                                           .Ordene = nueva_orden}

        Dim nueva_fecha As New fecha With {.fecha = CDate(fecha_viaje_asignada), .tipo_fecha = 1}

        Dim fecha_viaje_creada = New fechas_viaje With {.fecha = nueva_fecha, .viaje = nuevo_viaje}

        Dim fecha_orden As New fechas_ordene With {.fecha = nueva_fecha, .Ordene = nueva_orden}

        If Not String.IsNullOrEmpty(guia) Then
            Dim nueva_guia As New guia With {.guia = guia, .viaje = nuevo_viaje}
            db.guias.InsertOnSubmit(nueva_guia)
        End If



        If Not String.IsNullOrEmpty(recolecciones) And IsNumeric(recolecciones) And recolecciones <> "0" Then
            Dim nuevasRecolecciones As New recoleccione With {.viaje = nuevo_viaje, .recolecciones = recolecciones}
            db.recolecciones.InsertOnSubmit(nuevasRecolecciones)
        End If

        db.viajes.InsertOnSubmit(nuevo_viaje)
        db.fechas.InsertOnSubmit(nueva_fecha)
        db.fechas_viajes.InsertOnSubmit(fecha_viaje_creada)
        db.fechas_ordenes.InsertOnSubmit(fecha_orden)

        Dim errorAlGuardar = String.Empty


        Dim idViaje = 0




        Try
            db.SubmitChanges()

            Dim BuscaridViaje = (From consulta In db.viajes
                   Select consulta Order By consulta.id_viaje Descending).FirstOrDefault()

            If Not BuscaridViaje Is Nothing Then
                idViaje = BuscaridViaje.id_viaje
            End If

        Catch ex As Exception
            errorAlGuardar = ex.Message
            EnviarCorreo("sistemas@tse.com.mx", "Error al crear una nueva orden", errorAlGuardar)
            idViaje = 0
        End Try

        Return idViaje

    End Function
    Public Function buscar_id_orden(ByVal ano As Integer, ByVal consecutivo As Integer)
        Dim id_orden As Integer = 0
        Dim buscar = (From consulta In db.Ordenes
                   Where consulta.ano = ano And consulta.consecutivo = consecutivo
                   Select consulta).FirstOrDefault()
        If Not buscar Is Nothing Then
            id_orden = buscar.id_orden
        End If
        Return id_orden
    End Function

    ''' <summary>
    ''' Regresa el numero de orden en formato ano-consecutivo
    ''' </summary>
    ''' <param name="idViaje">id de viaje</param>
    ''' <returns>folio</returns>
    ''' <remarks></remarks>
    Public Function obtenerFolioOrden(ByVal idViaje As Integer)

        Dim orden = String.Empty
        Try
            Dim buscar_orden = (From consulta In db.viajes
                                         Where consulta.id_viaje = idViaje
                                         Select consulta).FirstOrDefault()

            If Not buscar_orden Is Nothing Then
                orden = String.Format("{0}-{1}-{2}", buscar_orden.Ordene.ano, buscar_orden.Ordene.consecutivo, buscar_orden.num_viaje)
            End If
        Catch ex As Exception
            Return orden
        End Try

        Return orden
    End Function

    ''' <summary>
    ''' Obtiene el correo del cliente que solicitó el viaje para enviarle el seguimiento.
    ''' </summary>
    ''' <param name="idViaje">Id del viaje</param>
    ''' <returns>Email del cliente.</returns>
    ''' <remarks></remarks>
    Public Function obtenerContactoViaje(ByVal idViaje As Integer) As List(Of String)

        Dim buscar_contacto = (From consulta In db.viajes, consulta2 In db.contactos
                                    Where consulta.id_viaje = idViaje And
                                    consulta.id_contacto = consulta2.id_contacto
                                    Select consulta2, consulta).FirstOrDefault()


        Dim correo_contacto As New List(Of String)()


        If Not buscar_contacto Is Nothing Then
            correo_contacto.Add(buscar_contacto.consulta2.correo)
        End If
        Return correo_contacto

    End Function
    Function buscarRecursos(ByVal idUnidad As Integer,
                            ByVal chofer As Integer,
                            ByVal idViaje As Integer, ByVal SC As Integer)
        'comentar este bloque si hay problemas (nuevo Codigo)
        Dim result = 0
        'se agrego una instruccion condicional para saber si es el segundo cruce que se registrara
        If SC = 1 Then
            Dim buscarRecursosAsignados = (From consulta In db.equipo_asignados
                                                Where consulta.id_equipo = idUnidad And
                                                consulta.idEmpleado = chofer And
                                                consulta.ViajeId = idViaje
                                                Select consulta).FirstOrDefault()
            If Not buscarRecursosAsignados Is Nothing Then
                result = buscarRecursosAsignados.id_equipo_asignado + 1
            End If

        Else
            '   Dim buscarRecursosAsignados = (From consulta In db.equipo_asignados
            'Where consulta.id_equipo = idUnidad And
            ' consulta.idEmpleado = chofer And
            ' consulta.ViajeId = idViaje
            '                           Select consulta).FirstOrDefault()
            '  If Not buscarRecursosAsignados Is Nothing Then
            'result = buscarRecursosAsignados.id_equipo_asignado
            ' End If
            Dim buscarRecursosAsignados = (From consulta In db.equipo_asignados
                                                            Where consulta.id_equipo = idUnidad And
                                                            consulta.idEmpleado = chofer And
                                                            consulta.ViajeId = idViaje
                                                            Select consulta)
            If Not buscarRecursosAsignados Is Nothing Then
                Dim idequipoasi As Integer = 0
                'con este ciclo obtengo el id_equipo_asignado actual
                For Each elemento In buscarRecursosAsignados
                    Dim a As Integer

                    a = elemento.id_equipo_asignado

                    If idequipoasi = 0 Then
                        idequipoasi = a
                    End If
                    If a > idequipoasi Then
                        idequipoasi = a
                    End If
                Next
                result = idequipoasi
            End If

        End If
        Return result 'fin codigo nuevo
        '------------------------------------------------------------------------
        'Descomentar este bloque si hay problemas (Codigo original)
        'Dim result = 0

        'Dim buscarRecursosAsignados = (From consulta In db.equipo_asignados
        '                            Where consulta.id_equipo = idUnidad And
        '                            consulta.idEmpleado = chofer And
        '                            consulta.ViajeId = idViaje
        '                            Select consulta).FirstOrDefault()

        'If Not buscarRecursosAsignados Is Nothing Then
        '    result = buscarRecursosAsignados.id_equipo_asignado
        'End If

        'Return result
        '-----------------------------------------
    End Function


    ''' <summary>
    ''' Registra por primera vez los recursos asignados a una orden de servicio.
    ''' </summary>
    ''' <param name="multiChofer">Indica si el viaje es unichofer o multichofer, es decir si se realizara el viaje con uno o mas choferes.</param>
    ''' <param name="chofer">Es el id del chofer asignado.</param>
    ''' <param name="idUnidad">Es el id de la unidad asignada a ese chofer.</param>
    ''' <param name="idCaja">Es el id de la caja a utlizar en caso de ser tracto. Puede ser opcional ya que en rabon y pick up no se utiliza.</param>
    ''' <param name="idViaje">Es el id de la orden de servicio.</param>
    ''' <param name="idTrayecto">Es el id de trayecto o subruta, este se utiliza cuando es multichofer y cada uno recorrera solo una parte de la ruta.Puede ser opcional ya que puede ser unichofer. </param>
    ''' <returns>Es caso de existir alguna excepcion regresara la descripcion del error.</returns>
    ''' <remarks></remarks>
    ''' se agrego un parametro para hermanar en la misma orden quitar parametro flag si hay problemas

    Public Function nuevaAsignacionRecursos(ByVal multiChofer As Boolean,
                                       ByVal chofer As Integer,
                                       ByVal idUnidad As Integer,
                                       ByVal idCaja As Integer,
                                       ByVal idViaje As Integer,
                                       ByVal idTrayecto As Integer?, ByVal flagSC As Integer)
        'comentar si hay problemas
        Dim SC As Integer = flagSC
        '----------------------------
        Dim tipoVehiculo = (From querylinq In db.equipo_operacions
                                    Where querylinq.id_equipo = idUnidad
                                    Select querylinq).FirstOrDefault()

        If Not tipoVehiculo Is Nothing Then
            Dim tipoEquipo = tipoVehiculo.id_tipo_equipo

            Dim unidad_asignada As New equipo_asignado With {.id_equipo = idUnidad,
                                                                                .ViajeId = idViaje,
                                                                                .idEmpleado = chofer
                                                                                }
            db.equipo_asignados.InsertOnSubmit(unidad_asignada)

            If tipoEquipo = 102 Then

                Dim asignarCaja As New cajaAsignada With {.equipo_asignado = unidad_asignada,
                                                          .CajaId = idCaja}

                db.cajaAsignadas.InsertOnSubmit(asignarCaja)
            End If

            If multiChofer Then
                Dim asignar_trayecto As New trayectos_asignado With {.id_trayecto = idTrayecto,
                                                                     .equipo_asignado = unidad_asignada,
                                                                     .idEstatus = 1}

                db.trayectos_asignados.InsertOnSubmit(asignar_trayecto)
            End If
        End If
        Dim idEquipoAsignado = 0
        Try
            db.SubmitChanges()
            'se agrego parametro SC quitar si hay problemas, modificar metodo buscarRecursos
            idEquipoAsignado = buscarRecursos(idUnidad, chofer, idViaje, SC)
        Catch ex As Exception
            EnviarCorreo("sistemas@tse.com.mx", "Error", String.Format("Error en metodo nuevaAsignacionRecursos(). Error {0} ", ex.Message))
        End Try

        Return idEquipoAsignado
    End Function

    ''' <summary>
    ''' Actualiza los recursos asignados a una orden de servicio.
    ''' </summary>
    ''' <param name="multiChofer">Indica si el viaje es unichofer o multichofer, es decir si se realizara el viaje con uno o mas choferes.</param>
    ''' <param name="chofer">Es el id del chofer asignado.</param>
    ''' <param name="idUnidad">Es el id de la unidad asignada a ese chofer.</param>
    ''' <param name="idCaja">Es el id de la caja a utlizar en caso de ser tracto. Puede ser opcional ya que en rabon y pick up no se utiliza.</param>
    ''' <param name="idViaje">Es el id de la orden de servicio.</param>
    ''' <param name="idTrayecto">Es el id de trayecto o subruta, este se utiliza cuando es multichofer y cada uno recorrera solo una parte de la ruta.Puede ser opcional ya que puede ser unichofer. </param>
    ''' <param name="idAsignacion">Es el id del registro de recursos asignados a la orden de servicio, esto es para en caso de una actualizacion de los recursos asignados.</param>
    ''' <returns>Es caso de existir alguna excepcion regresara la descripcion del error.</returns>
    ''' <remarks></remarks>
    Public Function ActualizarRecursosAsigandos(ByVal multiChofer As Boolean,
                                       ByVal chofer As Integer,
                                       ByVal idUnidad As Integer,
                                       ByVal idCaja As Integer?,
                                       ByVal idViaje As Integer,
                                       ByVal idTrayecto As Integer?,
                                       ByVal EquipoAsignadoId As Integer)

        Dim ErrorAlGuardar As String = String.Empty


        Try

            If multiChofer Then
                Dim buscarTrayecto = (From consulta In db.trayectos_asignados
                                   Where consulta.EquipoAsignadoId = EquipoAsignadoId
                                   Select consulta).FirstOrDefault()
                If Not buscarTrayecto Is Nothing Then
                    buscarTrayecto.id_trayecto = idTrayecto

                End If

            End If

            Dim buscarRecursos = (From consulta In db.equipo_asignados
                              Where consulta.id_equipo_asignado = EquipoAsignadoId
                              Select consulta).FirstOrDefault()

            If Not buscarRecursos Is Nothing Then
                buscarRecursos.idEmpleado = chofer
                buscarRecursos.id_equipo = idUnidad
            End If


            Dim buscarCaja = (From consulta In db.cajaAsignadas
                           Where consulta.EquipoAsignadoId = EquipoAsignadoId
                           Select consulta).FirstOrDefault()

            If Not buscarCaja Is Nothing Then
                buscarCaja.CajaId = idCaja
            End If


            db.SubmitChanges()



        Catch ex As Exception
            ErrorAlGuardar = ex.Message
        End Try
        Return ErrorAlGuardar

    End Function
End Module
