Module libreriaInspecciones
    Dim db As New DataClasses1DataContext()

    Dim proxy As New wcfRef1.Service1Client()

    Public Function buscarOdometroMasCercano(ByVal odometroIngresado As Integer)
        Dim result = String.Empty

        Dim buscarUnidades = From consulta In db.equipo_operacions
                           Where consulta.id_tipo_equipo < 106 And
                           consulta.id_status = 5
                           Select consulta

        Dim masCercano = 100000000000


        For Each vehiculo In buscarUnidades
            Dim idEquipo = vehiculo.id_equipo

            Dim compararOdometro = (From consulta In db.Odometros
                                 Where consulta.id_equipo = idEquipo
                                 Select consulta Order By consulta.id_odometro Descending).FirstOrDefault()
            Dim diferencia = 0

            If Not compararOdometro Is Nothing Then
                Dim odometro = compararOdometro.odometro
                diferencia = odometro - odometroIngresado
                diferencia = Math.Abs(diferencia)

                If diferencia < masCercano Then
                    result = vehiculo.economico
                    masCercano = diferencia
                End If
            End If
        Next

        Return result
    End Function
    Public Sub nuevoRendimiento(ByVal idEquipoAsignado As Integer,
                                ByVal kms As Decimal,
                                ByVal lts As Decimal,
                                ByVal grupo As Integer)

        Dim buscarRendimiento = (From consulta In db.rendimientos
                              Where consulta.idEquipoAsignado = idEquipoAsignado
                              Select consulta).FirstOrDefault()

        Dim rendimiento As Decimal = 0

        If lts > 0 Then
            rendimiento = kms / lts
        End If

        If Not buscarRendimiento Is Nothing Then
            buscarRendimiento.kms = kms
            buscarRendimiento.lts = lts
            buscarRendimiento.rendimiento = rendimiento


        Else
            Dim nuevoRendimiento As New rendimiento With {.kms = kms,
                                                          .idEquipoAsignado = idEquipoAsignado,
                                                          .lts = lts,
                                                          .rendimiento = rendimiento,
                                                          .grupo = grupo}
            db.rendimientos.InsertOnSubmit(nuevoRendimiento)
        End If
        db.SubmitChanges()
    End Sub


    
   
    
    Public Function nueva_recarga_externa(ByVal cantidad As Decimal,
                                     ByVal idAsignacion As Integer,
                                     ByVal ticket As Integer,
                                     ByVal descripcion As String,
                                     ByVal estacion As Integer,
                                     ByVal litros As Decimal,
                                     ByVal idEquipoAsignado As Integer,
                                     ByVal grupo As Integer
                                     )

        Dim errorAlguardar = String.Empty
        Dim idRecarga = 0
        Dim buscar_orden = (From consulta In db.equipo_asignados
                          Where consulta.id_equipo_asignado = idEquipoAsignado
                          Select consulta).FirstOrDefault()

        If Not buscar_orden Is Nothing Then
            Dim idOrden = buscar_orden.viaje.id_orden
            Dim idChofer = buscar_orden.idEmpleado
            Dim idUnidad = buscar_orden.id_equipo

            Dim nueva_recarga As New recargas_combustible With {.id_lugar = estacion,
                                                                          .lts = litros,
                                                                       .id_chofer = idChofer,
                                                                .id_equipo = idUnidad,
                                                                .idEquipoAsignado = idEquipoAsignado,
                                                                .grupo = grupo}

            Dim nuevo_gasto As New gasto With {.cantidad = cantidad,
                                               .descripcion = descripcion,
                                               .id_concepto = 1,
                                                       .id_moneda = 4,
                                               .id_forma_pago = 1}

            Dim nueva_liquidacion As New liquidacione With {.id_orden = idOrden,
                                                            .gasto = nuevo_gasto}

            Dim nuevo_comprobante As New comprobantes_fiscale With {.folio = ticket,
                                                                    .tipo_comprobante = 2,
                                                                    .gasto = nuevo_gasto}

            Dim recarga_externa As New recargas_externa With {.recargas_combustible = nueva_recarga,
                                                                    .gasto = nuevo_gasto}

            db.gastos.InsertOnSubmit(nuevo_gasto)
            db.liquidaciones.InsertOnSubmit(nueva_liquidacion)
            db.recargas_externas.InsertOnSubmit(recarga_externa)



            Try
                db.SubmitChanges()
                Dim buscarRecarga = (From consulta In db.recargas_combustibles
                                  Select consulta Order By consulta.id_recarga Descending).FirstOrDefault()

                If Not buscarRecarga Is Nothing Then
                    idRecarga = buscarRecarga.id_recarga
                End If

            Catch ex As Exception
                errorAlguardar = ex.Message
                EnviarCorreo("sistemas@tse.com.mx", "Error al guardar recarga externa Li.1649", errorAlguardar)
            End Try
        End If
        Return idRecarga
    End Function
    'Public Function nueva_recarga_externa(ByVal cantidad As Decimal,
    '                             ByVal ticket As Integer,
    '                             ByVal descripcion As String,
    '                             ByVal estacion As Integer,
    '                             ByVal litros As Decimal,
    '                             ByVal idEvaluacion As Integer,
    '                             ByVal idChofer As Integer,
    '                             ByVal idUnidad As Integer,
    '                             ByVal idOrden As Integer
    '                             )




    '    Dim nueva_recarga As New recargas_combustible With {.id_lugar = estacion,
    '                                                                  .lts = litros,
    '                                                               .id_chofer = idChofer,
    '                                                        .id_equipo = idUnidad,
    '                                                        .idEvaluacion = idEvaluacion
    '                                                        }

    '    Dim nuevo_gasto As New gasto With {.cantidad = cantidad,
    '                                       .descripcion = descripcion,
    '                                       .id_concepto = 1,
    '                                               .id_moneda = 4,
    '                                       .id_forma_pago = 1}

    '    Dim nueva_liquidacion As New liquidacione With {.id_orden = idOrden,
    '                                                    .gasto = nuevo_gasto}

    '    Dim nuevo_comprobante As New comprobantes_fiscale With {.folio = ticket,
    '                                                            .tipo_comprobante = 2,
    '                                                            .gasto = nuevo_gasto}

    '    Dim recarga_externa As New recargas_externa With {.recargas_combustible = nueva_recarga,
    '                                                            .gasto = nuevo_gasto}

    '    db.gastos.InsertOnSubmit(nuevo_gasto)
    '    db.liquidaciones.InsertOnSubmit(nueva_liquidacion)
    '    db.recargas_externas.InsertOnSubmit(recarga_externa)
    '    Dim errorAlguardar = String.Empty
    '    Try
    '        db.SubmitChanges()
    '    Catch ex As Exception
    '        errorAlguardar = ex.Message
    '        EnviarCorreo("sistemas@tse.com.mx", "Error al guardar recarga externa Li.1697", errorAlguardar)
    '    End Try
    '    Return errorAlguardar
    'End Function
    Public Function nueva_recarga_Interna(ByVal estacion As Integer,
                                     ByVal litros As Decimal,
                                     ByVal idAsignacion As Integer,
                                     ByVal idEquipoAsignado As Integer,
                                     ByVal grupo As Integer)

        Dim idRecarga = 0

        Dim buscar_orden = (From consulta In db.equipo_asignados
                          Where consulta.id_equipo_asignado = idEquipoAsignado
                          Select consulta).FirstOrDefault()

        Dim errorAlGuardar = String.Empty
        If Not buscar_orden Is Nothing Then
            Dim idOrden = buscar_orden.viaje.id_orden
            Dim idChofer = buscar_orden.idEmpleado
            Dim idUnidad = buscar_orden.id_equipo


            Dim nueva_recarga As New recargas_combustible With {.id_lugar = estacion,
                                                                          .lts = litros,
                                                                       .id_equipo = idUnidad,
                                                                       .id_chofer = idChofer,
                                                                .idEquipoAsignado = idEquipoAsignado,
                                                                .grupo = grupo}

            Dim recarga_interna As New recargas_interna With {.recargas_combustible = nueva_recarga,
                                                                    .id_orden = idOrden}

            db.recargas_internas.InsertOnSubmit(recarga_interna)

            Try
                db.SubmitChanges()
                Dim buscarRecarga = (From consulta In db.recargas_combustibles
                                  Select consulta Order By consulta.id_recarga Descending).FirstOrDefault()

                If Not buscarRecarga Is Nothing Then
                    idRecarga = buscarRecarga.id_recarga
                End If
            Catch ex As Exception
                errorAlGuardar = ex.Message
                EnviarCorreo("sistemas@tse.com.mx", "Error al guardar recarga interna Li.1729", errorAlGuardar)
            End Try

        End If
        Return idRecarga
    End Function

    'Function buscar_odometro(ByVal idEvaluacion As Integer, ByVal tipoTrayecto As Integer)

    '    Dim odometro As Integer = 0

    '    Dim buscar = (From consulta In db.Odometros
    '                                        Where consulta.idEvaluacion = idEvaluacion And
    '                                        consulta.tipo_trayecto = tipoTrayecto
    '                                        Select consulta).FirstOrDefault()
    '    If Not buscar Is Nothing Then
    '        odometro = buscar.odometro
    '    End If
    '    Return odometro
    'End Function

    

    ''' <summary>
    ''' Obtiene el costo de casetas de una orden de servicio, el costo varia si regresa vacio o con carga ya que se divide el costo entre los clientes involucrados.
    ''' </summary>
    ''' <param name="idViaje">Es el id de la orden de servicio de la cual queremos conocer su costo de casetas.</param>
    ''' <returns>El costo total de casetas</returns>
    ''' <remarks></remarks>
    Public Function obtenerCasetasPorViaje(ByVal idViaje As Integer)
        Dim costo As Decimal = 0
        Dim buscarCAsetas = (From consulta In db.viajes
                          Where consulta.id_viaje = idViaje
                          Select consulta).FirstOrDefault()


        Dim recorridosPorViaje = proxy.listarRecorridoPorIdViaje(idViaje)

        Dim grupos As New List(Of Integer)

        For Each r In recorridosPorViaje
            grupos.Add(r.grupo)
        Next


        Dim viajeRegreso As New wcfRef1.recorridoEquipo

        For Each g In grupos.Distinct()

            If viajeRegreso Is Nothing Then
                viajeRegreso = proxy.buscarViajeDeRegresoDeGrupo(g)
            End If

        Next


        If Not buscarCAsetas.precio.casetas Is Nothing Then
            Dim idOrden = buscarCAsetas.id_orden

            Dim numeroViajes = (From consulta In db.viajes
                             Where consulta.id_orden = idOrden
                             Select consulta.num_viaje).Count

            Dim esRedondo = buscarCAsetas.precio.llave_ruta.redondo

            If esRedondo Then
                costo += buscarCAsetas.precio.casetas * 2
            Else
                costo += buscarCAsetas.precio.casetas
            End If

        End If

        Return costo
    End Function

    ''' <summary>
    ''' Registra y obtiene el margen o ganancia real de una orden de servicio.
    ''' </summary>
    ''' <param name="idViaje">Es el id de la orden de servicio de la que se obtendra el margen</param>
    ''' <returns>Regresa el porcentaje de ganancia o margen.</returns>
    ''' <remarks></remarks>
    Public Sub nuevoMargen(ByVal idViaje As Integer)

        Dim costoChofer As Decimal = 0

        Dim costoCasetas As Decimal = 0


        Dim recorridosPorViaje = proxy.listarRecorridoPorIdViaje(idViaje)

        Dim grupos As New List(Of Integer)

        For Each r In recorridosPorViaje
            grupos.Add(r.grupo)
        Next


        Dim buscarPrecio = (From consulta In db.viajes
                     Where consulta.id_viaje = idViaje
                     Select consulta).FirstOrDefault()

        Dim precio As Decimal = 0

        Dim esRedondo = False

        If Not buscarPrecio Is Nothing Then

            esRedondo = buscarPrecio.precio.llave_ruta.redondo

            Dim tipo_moneda = buscarPrecio.precio.id_moneda
            precio = buscarPrecio.precio.precio

            If tipo_moneda = 5 Then
                precio *= 13.0
            End If
        End If

        Dim costoCombustibleTotal As Decimal = 0
        Dim costoCombustibleGrupo As Decimal = 0

        For Each g In grupos.Distinct()
            'costo de combustible

            Dim buscarRecargas = proxy.buscarRecargasCombustiblePorGrupo(g)
            Dim fechaRecarga = buscarRecargas.Where(Function(x) x.id_lugar = 2).FirstOrDefault

            Dim fechaPrecio As DateTime

            If fechaRecarga Is Nothing Then
                fechaPrecio = Now.AddHours(-7)
            Else
                fechaPrecio = fechaRecarga.fechaRecarga
            End If


            Dim costoRecargasExternas = buscarRecargas.Sum(Function(x) x.monto)
            Dim precioDiesel = proxy.buscarCostoCombustiblePorFecha(fechaPrecio, 1)
            Dim ltsRecargasInternos = buscarRecargas.Where(Function(x) x.id_lugar = 2).Sum(Function(x) x.lts)



            Dim costoRecargasInternas = precioDiesel.precio * ltsRecargasInternos
            Dim viajesHechos = proxy.viajesRealizadosPorGrupo(g)

            costoCombustibleGrupo = costoRecargasExternas + costoRecargasInternas

            costoCombustibleGrupo /= viajesHechos.Count

            costoCombustibleTotal += costoCombustibleGrupo

        Next

        Dim margen As Decimal = 0


        ''costoCombustible =
        Dim buscarCostoChofer = proxy.buscarNominaPorIdViaje(idViaje)

        If Not buscarCostoChofer Is Nothing Then
            costoChofer = buscarCostoChofer
        End If

        costoCasetas = FormatNumber(obtenerCasetasPorViaje(idViaje), 2)

        Dim costoCruce = obtenerCostoCruce(idViaje)

        Dim costoOperativo = costoCombustibleTotal + costoCasetas + costoChofer + costoCruce

        Dim monto = FormatNumber((precio - costoOperativo), 2)

        If precio <> 0 Then
            margen = FormatNumber((monto / precio) * 100, 2)
        End If



        Dim buscarMargen = proxy.buscarMargenPorIdViaje(idViaje)

        If Not buscarMargen Is Nothing Then
            buscarMargen.casetas = costoCasetas
            buscarMargen.combustible = costoCombustibleTotal
            buscarMargen.choferes = costoChofer
            buscarMargen.monto = monto
            buscarMargen.margen1 = margen
            buscarMargen.idViaje = idViaje
            buscarMargen.otros = costoCruce

            proxy.actualizarMargen(buscarMargen)
        Else


            Dim nuevoMa As New wcfRef1.margen
            nuevoMa.casetas = costoCasetas
            nuevoMa.choferes = costoChofer
            nuevoMa.combustible = costoCombustibleTotal
            nuevoMa.monto = monto
            nuevoMa.margen1 = margen
            nuevoMa.otros = costoCruce
            nuevoMa.idViaje = idViaje


            proxy.crearMargen(nuevoMa)

        End If

        Dim errorAlGuardar = String.Empty


    End Sub
    Public Function obtenerCostoCruce(ByVal idViaje As Integer) As Decimal
        Dim costo As Decimal = 0

        Dim buscarTipoVehiculo = (From consulta In db.equipo_asignados
                               Where consulta.ViajeId = idViaje And
                               consulta.viaje.precio.llave_ruta.ruta.Contains("El Paso,Tx")
                               Select consulta).FirstOrDefault()

        If Not buscarTipoVehiculo Is Nothing Then
            Dim TipoEquipoId = buscarTipoVehiculo.equipo_operacion.id_tipo_equipo

            Select Case TipoEquipoId
                Case 105
                    costo = 130
                Case 103
                    costo = 181
                Case 102
                    costo = 421
            End Select


        End If

        Return costo

    End Function
    

   
    Public Function obtener_costo_diesel_viaje(ByVal id_orden As Integer)
        Dim costo As Decimal = 0

        Dim asignaciones = From consulta In db.equipo_asignados
                         Where consulta.viaje.id_orden = id_orden
                         Select consulta

        For Each asignacion In asignaciones
            Dim idEquipo = asignacion.id_equipo
            Dim idChofer = asignacion.idEmpleado


            Dim recargas_externas = (From consulta In db.recargas_externas, consulta2 In db.liquidaciones
                                          Where consulta.id_gasto = consulta2.id_gasto And
                                          consulta.recargas_combustible.id_chofer = idChofer And
                                          consulta.recargas_combustible.id_equipo = idEquipo And
                                          consulta2.id_orden = id_orden
                                          Select consulta.gasto.cantidad).Sum

            If Not recargas_externas Is Nothing Then
                costo += recargas_externas
            End If


            Dim recargas_internas = (From consulta In db.recargas_internas
                                          Where consulta.id_orden = id_orden And
                                          consulta.recargas_combustible.id_equipo = idEquipo And
                                          consulta.recargas_combustible.id_chofer = idChofer
                                          Select consulta.recargas_combustible.lts).Sum
            Dim ltsInternos = 0
            If Not recargas_internas Is Nothing Then
                ltsInternos = recargas_internas
            End If


            Dim fecha_orden = (From consulta In db.fechas_ordenes
                                    Where consulta.id_orden = id_orden And
                                    consulta.fecha.tipo_fecha = 1
                                    Select consulta).FirstOrDefault()

            If Not fecha_orden Is Nothing Then
                Dim fecha_realizacion_orden = fecha_orden.fecha.fecha
                Dim precio = obtener_precio_combustible(1, fecha_realizacion_orden)

                If precio <> 0 Then
                    costo += ltsInternos * precio
                End If

            End If
        Next

        Return costo
    End Function
    ''' <summary>
    ''' Cuando la recarga es en base no se sabe con exactitud el precio del combustible asi que se toma el precio inmediato anteriro del precio del diesel dependiendo de la fecha de la orden de servicio y el precio en ese momento del diesel.
    ''' </summary>
    ''' <param name="tipo_combustible"></param>
    ''' <param name="fecha_precio_consulta"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function obtener_precio_combustible(ByVal tipo_combustible As Integer, ByVal fecha_precio_consulta As Date)
        Dim precio As Decimal = 0
        Dim costo_diesel = (From consulta In db.costo_combustibles
                                Where consulta.tipo_combustible = tipo_combustible And
                                consulta.fecha <= fecha_precio_consulta
                                Select consulta Order By consulta.precio Descending).FirstOrDefault()
        If Not costo_diesel Is Nothing Then
            precio = costo_diesel.precio
        End If
        Return precio
    End Function

    Public Function costo_casetas_orden(ByVal id_orden As Integer)
        Dim casetas_cotizadas = From consulta In db.viajes
                               Where consulta.id_viaje = id_orden
                               Select consulta.precio.casetas
        Dim costo As Decimal = 0
        For Each caseta_orden In casetas_cotizadas
            If Not caseta_orden Is Nothing Then
                costo += caseta_orden
            End If
        Next
        Return costo
    End Function

    Public Function obtener_rendimiento(
                                        ByVal idUnidad As Integer,
                                        ByVal idChofer As Integer,
                                        ByVal grupo As Integer) As Decimal
        Dim rendimiento As Decimal = 0
        Dim kms As Integer = 0

        Dim buscarOdometroRegreso = proxy.buscarOdometroPorGrupo(grupo, 2)

        Dim buscarOdometroInicio = proxy.buscarOdometroPorGrupo(grupo, 1)

        If Not buscarOdometroRegreso Is Nothing And Not buscarOdometroInicio Is Nothing Then
            Dim odometroInicio = buscarOdometroInicio.odometro1
            Dim odometroRegreso = buscarOdometroRegreso.odometro1

            If odometroInicio <> 0 Then
                If odometroRegreso <> 0 Then
                    kms = odometroRegreso - odometroInicio
                End If
            End If
        End If


        

        Dim buscarIdEquipoAsignado = (From consulta In db.recorridoEquipos
                                   Where consulta.grupo = grupo And
                                   consulta.equipo_asignado.idEmpleado = idChofer
                                   Select consulta).FirstOrDefault()


        If Not buscarIdEquipoAsignado Is Nothing Then
            Dim idEquipoAsignado = buscarIdEquipoAsignado.idEquipoAsignado
            Dim RecargasExternas = ObtenerRecargaExterna(grupo)
            Dim RecargasInternas = ObtenerRecargasInternas(grupo)
            Dim lts_total = RecargasExternas + RecargasInternas


            If kms <> 0 And lts_total <> 0 Then
                rendimiento = kms / lts_total
            End If
        End If





        Return rendimiento
    End Function

    Public Function comprobrar_odometro(ByVal idOrden As Integer,
                                     ByVal EquipoAsignadoId As Integer,
                                     ByVal nuevo_odometro As Integer,
                                     ByVal idEquipo As Integer,
                                     ByVal idChofer As Integer)

        Dim buscar_ultimo_odometro = (From consulta In db.Odometros
                                   Where
                                   consulta.id_equipo = idEquipo And
                                    consulta.tipo_trayecto = 2
                                   Select consulta Order By consulta.id_odometro Descending).FirstOrDefault()
        Dim diferencia = 0

        If Not buscar_ultimo_odometro Is Nothing Then
            Dim ultimo_odometro = buscar_ultimo_odometro.odometro


            Dim buscar_viaje = (From consulta In db.equipo_asignados
                                             Where consulta.id_equipo_asignado = EquipoAsignadoId
                                             Select consulta).FirstOrDefault()

            Dim id_viaje = buscar_viaje.ViajeId

            Dim encabezado = crear_info_viaje(id_viaje)


            Dim economico = buscar_viaje.equipo_operacion.economico
            
            diferencia = nuevo_odometro - ultimo_odometro

        End If

        Return diferencia

    End Function

    ''' <summary>
    ''' Regresa los litros recargados en base de una determinada orden, equipo y chofer.
    ''' </summary>
    ''' <returns>Litros Recargados en base.</returns>
    ''' <remarks></remarks>

    Public Function ObtenerRecargasInternas(ByVal grupo As Integer)
        Dim lts As Decimal = 0

        Dim buscar_recargas_internas = From consulta In db.recargas_internas,
                                       consulta2 In db.recorridoEquipos
                                          Where consulta.recargas_combustible.idEquipoAsignado = consulta2.idEquipoAsignado And
                                          consulta2.grupo = grupo
                                          Select consulta Distinct

        For Each recarga In buscar_recargas_internas
            Dim idEquipoAsignado = recarga.recargas_combustible.idEquipoAsignado
            lts += recarga.recargas_combustible.lts
        Next

        Return lts
    End Function

   

    Public Function existe_falla(ByVal idOrden As Integer,
                                 ByVal idChofer As Integer,
                                 ByVal idEquipo As Integer,
                                 ByVal salida As Boolean)

        Dim buscar = (From consulta In db.reportes_fallas
                   Where
                   consulta.idChofer = idChofer And
                   consulta.idEquipo = idEquipo And
                   consulta.idOrden = idOrden And
                    consulta.salida = salida
                   Select consulta).FirstOrDefault()

        Dim falla As String = String.Empty

        If Not buscar Is Nothing Then
            falla = buscar.falla
        End If

        Return falla
    End Function
    Public Sub actualizar_falla(ByVal salida As Boolean,
                                ByVal falla As String,
                                ByVal idChofer As Integer,
                                ByVal idEquipo As Integer,
                                ByVal idOrden As Integer)

        Dim buscar = (From consulta In db.reportes_fallas
                   Where consulta.idChofer = idChofer And
                   consulta.salida = salida And
                   consulta.idEquipo = idEquipo And
                   consulta.idOrden = idOrden 
                   Select consulta).FirstOrDefault()

        If Not buscar Is Nothing Then
            buscar.falla = falla
            db.SubmitChanges()
        End If
    End Sub

    Public Sub nueva_falla(ByVal idEquipo As Integer,
                           ByVal idChofer As Integer,
                           ByVal idOrden As Integer,
                                ByVal salida As Boolean,
                                ByVal falla As String)



        Dim nueva_falla As New reportes_falla With {.falla = falla,
                                                            .idEquipo = idEquipo,
                                                    .idChofer = idChofer,
                                                    .idOrden = idOrden,
                                                            .salida = salida,
                                                    .idEstatus = 5}

        db.reportes_fallas.InsertOnSubmit(nueva_falla)

        Dim errorAlGuardar = String.Empty

        Try
            db.SubmitChanges()
        Catch ex As Exception
            errorAlGuardar = ex.Message
            EnviarCorreo("sistemas@tse.com.mx", "Error al guardar recarga externa Lin.1824", errorAlGuardar)
        End Try


    End Sub

    Public Function ObtenerRecargaExterna(ByVal grupo As Integer)
        Dim lts As Decimal = 0

        Dim buscar_recargas_externas = From consulta2 In db.recargas_externas,
                                       consulta3 In db.recorridoEquipos
                                       Where
                                       consulta2.recargas_combustible.idEquipoAsignado = consulta3.idEquipoAsignado And
                                       consulta3.grupo = grupo
                                       Select consulta2 Distinct

        For Each recarga In buscar_recargas_externas
            lts += recarga.recargas_combustible.lts
        Next

        Return lts
    End Function


    'Public Function nueva_recarga_Interna(ByVal estacion As Integer,
    '                                 ByVal litros As Decimal,
    '                                 ByVal idEvaluacion As Integer,
    '                                 ByVal idChofer As Integer,
    '                                 ByVal idUnidad As Integer,
    '                                 ByVal idOrden As Integer)

    '    Dim nueva_recarga As New recargas_combustible With {.id_lugar = estacion,
    '                                                                  .lts = litros,
    '                                                               .id_equipo = idUnidad,
    '                                                               .id_chofer = idChofer,
    '                                                        .idEvaluacion = idEvaluacion}

    '    Dim recarga_interna As New recargas_interna With {.recargas_combustible = nueva_recarga,
    '                                                            .id_orden = idOrden}

    '    db.recargas_internas.InsertOnSubmit(recarga_interna)
    '    Dim errorAlGuardar = String.Empty

    '    Try
    '        db.SubmitChanges()
    '    Catch ex As Exception
    '        errorAlguardar = ex.Message
    '        EnviarCorreo("sistemas@tse.com.mx", "Error al guardar recarga externa Li.1758", errorAlGuardar)
    '    End Try

    '    Return errorAlGuardar

    'End Function
    Function buscar_ejes(ByVal id_orden As Integer,
                         ByVal idEquipo As Integer,
                         ByVal idChofer As Integer,
                         ByVal TipoTrayecto As Integer)

        Dim ejes As Integer = 0
        Dim buscar = (From consulta In db.Odometros
                                            Where consulta.idOrden = id_orden And
                                            consulta.id_chofer = idChofer And
                                            consulta.id_equipo = idEquipo And
                                            consulta.tipo_trayecto = TipoTrayecto
                                            Select consulta).FirstOrDefault()
        If Not buscar Is Nothing Then
            ejes = buscar.num_ejes
        End If
        Return ejes
    End Function
    
End Module
