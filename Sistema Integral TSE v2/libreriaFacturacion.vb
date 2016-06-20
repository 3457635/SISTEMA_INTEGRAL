Imports DGMC.TimbraCFDI
Module libreriaFacturacion
    Dim db As New DataClasses1DataContext()

    ''' <summary>
    ''' Asigna un numero consecutivo para el folio de la factura.
    ''' </summary>
    ''' <returns>El folio de la factura.</returns>
    ''' <remarks></remarks>
    Public Function obtenerNuevoFolioCFDI() As Integer
        Dim folio As Integer = 1

        Dim buscarUltimoFolio = (From consulta In db.cfdis
                                       Where consulta.serie = Now.AddHours(-7).Year()
                                 Select consulta Order By consulta.factura.folio Descending).FirstOrDefault()

        If Not buscarUltimoFolio Is Nothing Then
            folio = buscarUltimoFolio.factura.folio + 1
            'EnviarCorreo("sistemas@tse.com.mx", "Creacion de ultimas facturas 2015", "El folio es: " + folio.ToString())
            'comentar este ELSE para que el consecutivo al finalizar el ano se resetee
        Else
            Dim buscarUltimoFolioAñoAnterior = (From consulta In db.cfdis
                                       Where consulta.serie = Now.AddHours(-7).Year() - 1
                                 Select consulta Order By consulta.factura.folio Descending).FirstOrDefault()
            folio = buscarUltimoFolioAñoAnterior.factura.folio + 1
            ' EnviarCorreo("sistemas@tse.com.mx", "Creacion de la primer factura 2016", "El primer folio es: " + folio.ToString())
        End If


        Return folio
    End Function


    ''' <summary>
    ''' Asigna el folio de la nota de credito
    ''' </summary>
    ''' <returns>el siguiente folio disponible</returns>
    ''' <remarks></remarks>
    Public Function obtenerFolioNotaCredito() As Integer
        Dim folio = 1
        Dim buscarUltimoFolio = (From consulta In db.notasCreditos
                              Select consulta Order By consulta.id Descending).FirstOrDefault()

        If Not buscarUltimoFolio Is Nothing Then
            folio = buscarUltimoFolio.folio + 1
        End If
        Return folio
    End Function


    ''' <summary>
    ''' Busca los dias de credito del cliente para pagos
    ''' </summary>
    ''' <param name="idDatoFacturacion">Id de datos de facturacion del cliente</param>
    ''' <returns>Regresa de el numero de dias de credito.</returns>
    ''' <remarks></remarks>
    Public Function obtenerDiasCredito(ByVal idDatoFacturacion As Integer) As Integer
        Dim result = 30

        Dim buscarDias = (From consulta In db.datos_facturacions
                       Where consulta.id_dato = idDatoFacturacion
                       Select consulta).FirstOrDefault()

        If Not buscarDias Is Nothing Then
            result = buscarDias.diasCredito
        End If

        Return result

    End Function


    ''' <summary>
    ''' Asigna la fecha de programacion de cobro a una factura, si ya existe la actualiza y si no la crea.
    ''' </summary>
    ''' <param name="idFactura">id de la factura</param>
    ''' <param name="fecha">fecha de programacion de cobro</param>
    ''' <remarks></remarks>
    Public Sub asignarProgramacionCobro(ByVal idFactura As Integer, ByVal fecha As Date)

        Dim buscarFecha = (From consulta In db.fechas_facturacions
                        Where consulta.fecha.tipo_fecha = 6 And
                        consulta.factura.id_factura = idFactura
                        Select consulta).FirstOrDefault()

        If Not buscarFecha Is Nothing Then
            buscarFecha.fecha.fecha = fecha

        Else
            Dim nuevaFecha As New fecha With {.fecha = fecha, .tipo_fecha = 6}

            Dim nuevaFacturacion As New fechas_facturacion With {.id_factura = idFactura, .fecha = nuevaFecha}

            db.fechas_facturacions.InsertOnSubmit(nuevaFacturacion)
        End If

        db.SubmitChanges()

    End Sub

    ''' <summary>
    ''' Periodicamente se revisa la tabla de cfdis pendientes de cancelar
    ''' para mandorlos cancelar despues de 72 de haberse facturado.
    ''' </summary>
    ''' <remarks></remarks>
    'Public Sub cancelarCfdiPendiente()
    '    'En este ejemplo se muestra como cancelar un comprobante xml, previamente timbrado

    '    'Inicializamos el conector' el parámetro indica el ambiente en el que se utilizará 
    '    'Fasle = Ambiente de pruebas
    '    'True = Ambiente de producción
    '    Dim conector As New Conector(True)

    '    'Establecemos las credenciales para el permiso de conexión
    '    'Ambiente de pruebas = mvpNUXmQfK8=
    '    'Ambiente de producción = Esta será asignado por el proveedor al salir a productivo
    '    'Produccion
    '    conector.EstableceCredenciales("jsy+7kNPsnOotlnstxiE6w==")

    '    'pruebas
    '    'conector.EstableceCredenciales("mvpNUXmQfK8=")


    '    'prueba
    '    'Dim rfcEmisor As String = "AAA010101AAA"

    '    'Rfc Emisor
    '    Dim rfcEmisor As String = "CALL630921V68"

    '    Dim buscarCfdiPendiente = From consulta In db.cfdiPendienteCancelars,
    '                              consulta2 In db.fechas_facturacions
    '                              Where consulta.cfdi.idFactura = consulta2.id_factura And
    '                              consulta2.fecha.fecha.Value.AddHours(72) <= Now
    '                            Select consulta

    '    For Each cfdis In buscarCfdiPendiente
    '        'Folio Fiscal - UUID
    '        Dim folioFiscal As String = cfdis.cfdi.folioFiscal.Trim()

    '        'Obtenemos el xml por medio del conector y guardamos resultado'
    '        Dim resultadoCancelacion As ResultadoCancelacion

    '        resultadoCancelacion = conector.CancelaCFDI(rfcEmisor, folioFiscal)

    '        If (resultadoCancelacion.Exitoso) Then
    '            db.cfdiPendienteCancelars.DeleteOnSubmit(cfdis)
    '            db.SubmitChanges()
    '        Else
    '            EnviarCorreo("sistemas@tse.com.mx", "cancelacion pendiente", String.Format("Factura: {2} FolioFiscal: {0} Error:{1}", folioFiscal, resultadoCancelacion.Descripcion, cfdis.cfdi.factura.folio))
    '        End If
    '    Next
    'End Sub
    ''' <summary>
    ''' Periodicamente se revisa la tabla de cfdis pendientes de cancelar
    ''' para mandorlos cancelar despues de 72 de haberse facturado.
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub cancelarCfdiPendiente()
        'En este ejemplo se muestra como cancelar un comprobante xml, previamente timbrado

        'Inicializamos el conector' el parámetro indica el ambiente en el que se utilizará 
        'Fasle = Ambiente de pruebas
        'True = Ambiente de producción
        Dim conector As New TSE.Timbrado.Conector(True)

        'prueba
        'Dim rfcEmisor As String = "AAA010101AAA"

        'Rfc Emisor
        Dim rfcEmisor As String = "CALL630921V68"

        Dim buscarCfdiPendiente = From consulta In db.cfdiPendienteCancelars,
                                  consulta2 In db.fechas_facturacions
                                  Where consulta.cfdi.idFactura = consulta2.id_factura And
                                  consulta2.fecha.fecha.Value.AddHours(72) <= Now.AddHours(-7) And consulta.cfdi.serie = Now.AddHours(-7).Year
                                Select consulta

        For Each cfdis In buscarCfdiPendiente
            'Folio Fiscal - UUID
            Dim folioFiscal As String = cfdis.cfdi.folioFiscal.Trim()

            'Obtenemos el xml por medio del conector y guardamos resultado'
            Dim resultadoCancelacion As TSE.Timbrado.ResultadoCancelacion

            resultadoCancelacion = conector.CancelaCFDI(rfcEmisor, folioFiscal)

            If (resultadoCancelacion.Exitoso) Then
                db.cfdiPendienteCancelars.DeleteOnSubmit(cfdis)
                db.SubmitChanges()
            Else
                EnviarCorreo("sistemas@tse.com.mx", "cancelacion pendiente", String.Format("Factura: {2} FolioFiscal: {0} Error:{1}", folioFiscal, resultadoCancelacion.Descripcion, cfdis.cfdi.factura.folio))
            End If
        Next
    End Sub
    ''' <summary>
    ''' Cuenta la cantidad de ordenes de servicio que no se han facturado.
    ''' </summary>
    ''' <returns>Regresa la cantidad de viajes sin factura.</returns>
    ''' <remarks></remarks>
    Public Function obtenerViajesSinFactura() As Integer
        Dim cantidad As Integer = 0
        'Se omitiran los remisionados 06 07 2015 consulta.remision = 0
        cantidad = (From consulta In db.viajes
                                Where consulta.id_status <> 5 And consulta.id_status <> 3 And consulta.remision = 0 And Not (From consulta2 In db.facturacions
                                           Select consulta2.id_viaje).Contains(consulta.id_viaje)
                                       Select consulta.id_viaje).Count()

        Return cantidad
    End Function

    ''' <summary>
    ''' Actualiza el tipo de cambio para las facturas que tienen precio en dolares y se cobran en pesos. Se utiliza un tipo de cambio diferente para cada cliente.
    ''' </summary>
    ''' <param name="idDatoFacturacion">Es el id de los datos de facturacion del cliente que es donde se tiene el campo del tipo de cambio que se utiliza para facturarle.</param>
    ''' <param name="tipoCambio">Es el tipo de cambio que se va utilizar para facturar.</param>
    ''' <remarks></remarks>
    Public Sub actualizarTipoCambio(ByVal idDatoFacturacion As Integer,
                                    ByVal tipoCambio As Decimal)

        Dim actualizar_tc = (From consulta In db.datos_facturacions
                          Where consulta.id_dato = idDatoFacturacion
                          Select consulta).FirstOrDefault()

        actualizar_tc.tipo_cambio = tipoCambio
        db.SubmitChanges()

    End Sub

    ''' <summary>
    ''' busca la fecha del primer punto del seguimiento de un viaje
    ''' </summary>
    ''' <param name="id_viaje">Id del seguimiento</param>
    ''' <returns>Fecha del primer punto del seguimiento.</returns>
    ''' <remarks></remarks>
    Public Function obtener_fecha_origen(ByVal id_viaje As Integer) As Date
        Dim fecha_origen As Date

        Dim buscar_id_primer_seguimiento = (From consulta In db.puntos_predeterminados, consulta2 In db.horas
                                             Where consulta.seguimiento.id_viaje = id_viaje And
                                             consulta.id_seguimiento = consulta2.id_seguimiento
                                             Select consulta, consulta2 Order By consulta.id_punto).FirstOrDefault()
        If Not buscar_id_primer_seguimiento Is Nothing Then
            fecha_origen = buscar_id_primer_seguimiento.consulta2.fecha

        End If
        Return fecha_origen
    End Function


    ''' <summary>
    ''' Registra la factura que corresponde a cierto viaje
    ''' </summary>
    ''' <param name="idViaje">Es el id de la orden de servicio que se va a facturar.</param>
    ''' <param name="idFactura">Es el id de la factura correspondiente a la orden de servicio</param>
    ''' <returns>En caso de ocurrir alguna excepcion al almacenar regresará la descripción del error.</returns>
    ''' <remarks></remarks>
    Public Function registrarViajeFacturacion(ByVal idViaje As Integer, ByVal idFactura As Integer) As String

        Dim falla As String = String.Empty

        Dim buscarFacturacion = (From consulta In db.facturacions
                              Where consulta.id_factura = idFactura And consulta.id_viaje = idViaje
                              Select consulta).FirstOrDefault()

        If buscarFacturacion Is Nothing Then

            Dim factura_viaje As New facturacion With {.id_viaje = idViaje, .id_factura = idFactura}
            db.facturacions.InsertOnSubmit(factura_viaje)
        End If

        Dim actualizar_viaje = (From consulta In db.viajes
                                                       Where consulta.id_viaje = idViaje
                                                       Select consulta).FirstOrDefault()

        If Not actualizar_viaje Is Nothing Then

            actualizar_viaje.facturado = True
        End If


        Try
            db.SubmitChanges()
            'Dim body As String = String.Format("orden: {0} facturado:{1}", actualizar_viaje.Ordene.consecutivo, actualizar_viaje.facturado.Value.ToString())
            'EnviarCorreo("sistemas@tse.com.mx", "Viaje facturado", body)
        Catch ex As Exception
            falla = ex.Message
            EnviarCorreo("sistemas@tse.com.mx", "Error al registrar viaje en factura Lin.2557", falla)
        End Try

        Return falla
    End Function


    ''' <summary>
    ''' Crea o acualiza una factura, registra las fechas de impresión y de pago. Se utiliza principalmente al mandar imprimir la factura.
    ''' </summary>
    ''' <param name="folio">Es el numero consecutivo del formato de la factura.</param>
    ''' <param name="importe">Es la multiplicacion de la cantidad por el precio unitario. </param>
    ''' <param name="idDatoFacturacion">Es el id de los datos de facturación del cliente, hay clientes que se les factura con diferente RFC.</param>
    ''' <param name="iva">El Impuesto Al Valor Agregado 16%</param>
    ''' <param name="retencion">Es un impuesto el cual obliga retener al cliente cierto porcentaje de facturación.</param>
    ''' <param name="total">Es total a cobrar.</param>
    ''' <param name="enDolares">Se registra si la factura se cobro en dolares o en pesos, esto nos ayuda a separar las catindades facturadas en dolares y pesos.</param>
    ''' <returns>Regresa el id de la factura registrada.</returns>
    ''' <remarks></remarks>
    Public Function nuevaFactura(ByVal folio As Integer,
                                 ByVal importe As Double,
                                 ByVal idDatoFacturacion As Integer,
                                 ByVal esAmericana As Boolean,
                                 Optional ByVal iva As Double = 0,
                                 Optional ByVal retencion As Double = 0,
                                 Optional ByVal total As Double = 0,
                                 Optional ByVal enDolares As Boolean = False,
                                 Optional ByVal serie As String = "",
                                 Optional ByVal folioFiscal As String = ""
                                 ) As Integer

        Dim idFactura As Integer = 0
        Dim errorAlGuardar = String.Empty

        Dim nueva_factura As New factura With {.folio = folio,
                                                   .Contrarecibo = False,
                                                   .importe = importe,
                                                   .id_dato_facturacion = idDatoFacturacion,
                                                                  .iva = iva,
                                                   .total = total,
                                               .saldo = total,
                                                   .retencion = retencion,
                                                                  .Cancelada = False,
                                               .facturaAmericana = esAmericana,
                                                   .facturada_dolares = enDolares}

        If Not String.IsNullOrEmpty(folioFiscal) Then
            Dim nuevoFolioFiscal As New cfdi With {.folioFiscal = folioFiscal,
                                                           .serie = serie,
                                                           .factura = nueva_factura}
        End If


        Dim fecha_impresion As New fecha With {.fecha = Now.AddHours(-7), .tipo_fecha = 4}
        Dim fechas_factura As New fechas_facturacion With {.fecha = fecha_impresion, .factura = nueva_factura}
        db.fechas_facturacions.InsertOnSubmit(fechas_factura)



        Try
            db.SubmitChanges()
        Catch ex As Exception
            idFactura = 0
            errorAlGuardar = ex.Message
            EnviarCorreo("sistemas@tse.com.mx", "Error Lin.2507", String.Format("Ocurrio un problema al guardar una nueva factura. Error:{0}", errorAlGuardar))
        End Try

        Dim buscarNuevaFactura = (From consulta In db.facturas
                                   Where consulta.folio = folio
                                   Select consulta Order By consulta.id_factura Descending).FirstOrDefault()

        If Not buscarNuevaFactura Is Nothing Then
            idFactura = buscarNuevaFactura.id_factura
            asignarProgramacionCobro(idFactura, Now.AddDays(obtenerDiasCredito(idDatoFacturacion)).AddHours(-7))
        End If




        Return idFactura
    End Function



    ''' <summary>
    ''' Indica si el tipo de equipo solicitado por el cliente es diferente al asignado por trafico. Esto se utiliza para no facturar un precio equivocado.
    ''' </summary>
    ''' <param name="id_viaje">Es el id de la orden de servicio que queremos verificar.</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function existeDiferenciaVehiculos(ByVal id_viaje As Integer) As Boolean
        Dim existe As Boolean = False

        Dim existe_diferencia_vehiculos = (From consulta In db.viajes,
                                           consulta2 In db.equipo_asignados
                                        Where consulta.precio.id_tipo_recurso <> consulta2.equipo_operacion.id_tipo_equipo And
                                        consulta.id_viaje = consulta2.ViajeId And
                                        consulta.id_viaje = id_viaje And
                                        consulta2.equipo_operacion.id_tipo_equipo < 107 And
                                        Not (
                                            From consulta3 In db.equipo_asignados,
                                            consulta4 In db.viajes
                                             Where consulta3.ViajeId = id_viaje And
                                             consulta3.ViajeId = consulta4.id_viaje And
                                             consulta4.precio.id_tipo_recurso = consulta3.equipo_operacion.id_tipo_equipo
                                             Select viajes = consulta3.ViajeId).Contains(consulta.id_viaje)
                                        Select orden = consulta.Ordene.ano.ToString() + "-" + consulta.Ordene.consecutivo.ToString() + "-" + consulta.num_viaje.ToString()).FirstOrDefault()
        If Not existe_diferencia_vehiculos Is Nothing Then
            existe = True
        End If

        Return existe
    End Function



    ''' <summary>
    ''' Cambia el estatus de una factura a cancelada. Cuando el sistema detecta que una orden ya fue facturada, da la opcion de cancelar la factura anterior.
    ''' </summary>
    ''' <param name="idViaje">Es el id de la orden de servicio para obtener su factura asignada actual y poderla cancelar.</param>
    ''' <remarks></remarks>


    Public Sub cancelarFactura(ByVal idViaje As Integer)

        Dim cancelar_orden = (From consulta In db.facturacions
                           Where consulta.id_viaje = idViaje And
                           consulta.factura.Cancelada = False
                           Select consulta).FirstOrDefault()

        If Not cancelar_orden Is Nothing Then
            cancelar_orden.factura.Cancelada = True
            db.SubmitChanges()
        End If


    End Sub
    ''' <summary>
    ''' Se utiliza para saber en que renglon de una factura acomodar el dato de la colonia ya que puede ser muy grande y que no quepa.
    ''' </summary>
    ''' <param name="direccion"></param>
    ''' <param name="colonia"></param>
    ''' <param name="cp"></param>
    ''' <param name="ciudad"></param>
    ''' <param name="estado"></param>
    ''' <returns>Regresa en que renglon debe ir la colonia.</returns>
    ''' <remarks></remarks>
    Public Function acomodar_colonia(ByVal direccion As String,
                                     ByVal colonia As String,
                                     ByVal cp As String,
                                ByVal ciudad As String,
                                ByVal estado As String)

        Dim maximo As Integer = 70
        Dim primer_renglon As String = direccion + colonia
        Dim segundo_renglon As String
        Dim tipo_acomodo As Integer

        If primer_renglon.Length() > maximo Then
            If cp <> "" Then
                cp = " C.P. " + cp
            Else
                cp = ""
            End If
            segundo_renglon = colonia + " " + ciudad + "," + estado + cp

            If segundo_renglon.Length() > maximo Then
                tipo_acomodo = 0 'la colonia no cabe en ninguno de los 2 renglones
            Else
                tipo_acomodo = 2 'la colonia cabe en el renglon de ciudad
            End If
        Else
            tipo_acomodo = 1 'la colonia cabe en el primer renglon
        End If

        Return tipo_acomodo
    End Function
    Public Function ultimoLote()
        Dim buscarLote = (From consulta In db.lotesFacturas
                       Select consulta Order By consulta.idLote Descending).FirstOrDefault()
        Dim ultimoFolio = 0
        If Not buscarLote Is Nothing Then
            ultimoFolio = buscarLote.idLote + 1
        Else
            ultimoFolio = 1
        End If
        Return ultimoFolio
    End Function

    Public Function nuevoLote()
        Dim errorAlGuardar = String.Empty
        Dim lote = ultimoLote()


        Dim nuevo As New lotesFactura With {.fecha = Now().AddHours(-7), .idLote = lote}
        db.lotesFacturas.InsertOnSubmit(nuevo)

        Try
            db.SubmitChanges()

        Catch ex As Exception
            errorAlGuardar = ex.Message
            EnviarCorreo("sistemas@tse.com.mx", "Error", String.Format("Ocurrio un error al guardar un nuevo lote de contrarecibo. Error:{0}", errorAlGuardar))
        End Try
        Return lote

    End Function
    Function factura_utilizada_anteriormente(ByVal folio As String,
                                            ByVal _id_viaje As String)
        Dim viaje_facturado As String = String.Empty

        Dim factura_pertenece_a_orden = (From consulta In db.facturacions
                     Where consulta.factura.folio = folio And
                     consulta.id_viaje = _id_viaje
                     Select consulta.id_viaje).Count()

        If factura_pertenece_a_orden = 0 Then
            Dim viaje_con_esta_factura = (From consulta In db.facturacions
                     Where consulta.factura.folio = folio
                     Select consulta.viaje.Ordene.consecutivo, consulta.viaje.Ordene.ano).FirstOrDefault()
            If Not viaje_con_esta_factura Is Nothing Then
                viaje_facturado = viaje_con_esta_factura.ano.ToString() + "-" + viaje_con_esta_factura.consecutivo.ToString()
            End If

        End If

        Return viaje_facturado
    End Function

    Public Function obtenerFolioFiscal(ByVal idViaje As Integer)
        Dim folio = String.Empty
        Dim buscarFolio = (From consulta In db.cfdis, consulta2 In db.facturacions
                          Where consulta.factura.id_factura = consulta2.id_factura And
                          consulta2.id_viaje = idViaje And
                          consulta.factura.Cancelada = False
                          Select consulta).FirstOrDefault()

        If Not buscarFolio Is Nothing Then
            folio = buscarFolio.folioFiscal
        End If
        Return folio
    End Function

    Public Function orden_facturada_anteriormente(ByVal id_viaje As Integer,
                                           ByVal factura As Integer,
                                           ByVal idDatoFacturacion As Integer)

        Dim yaFueFacturada = String.Empty


        Dim factura_anterior = (From consulta In db.facturacions
                                     Where consulta.id_viaje = id_viaje And
                                        consulta.factura.Cancelada = False And
                                        consulta.factura.datos_facturacion.id_dato = idDatoFacturacion
                                     Select consulta).FirstOrDefault()

        If Not factura_anterior Is Nothing Then

            yaFueFacturada = factura_anterior.factura.folio.ToString()

        End If



        Return yaFueFacturada
    End Function
    Public Function registrarFacturasEnLote(ByVal idFactura As Integer, ByVal lote As Integer)

        Dim buscarFacturaContrarecibo = (From consulta In db.contrarecibos
                                       Where consulta.id_factura = idFactura
                                       Select consulta).FirstOrDefault()
        Dim errorAlGuardar = String.Empty

        If Not buscarFacturaContrarecibo Is Nothing Then
            buscarFacturaContrarecibo.idLote = lote
        Else
            Dim nuevoRegistro As New contrarecibo With {.idLote = lote, .id_factura = idFactura}
            db.contrarecibos.InsertOnSubmit(nuevoRegistro)
        End If

        Try
            db.SubmitChanges()
        Catch ex As Exception
            errorAlGuardar = ex.Message
            EnviarCorreo("sistemas@tse.com.mx", "Error", String.Format("Ocurrio un error al asignar la factura al lote de contrarecibo. Error:{0}", errorAlGuardar))
        End Try

        Return errorAlGuardar
    End Function
    Public Function Letras(ByVal numero As String, ByVal factura_dlls As Boolean) As String

        '********Declara variables de tipo cadena************
        Dim palabras, entero, dec, flag As String

        '********Declara variables de tipo entero***********
        Dim num, x, y As Integer

        flag = "N"

        '**********Número Negativo***********
        If Mid(numero, 1, 1) = "-" Then
            numero = Mid(numero, 2, numero.ToString.Length - 1).ToString
            palabras = "menos "
        End If

        '**********Si tiene ceros a la izquierda*************
        For x = 1 To numero.ToString.Length
            If Mid(numero, 1, 1) = "0" Then
                numero = Trim(Mid(numero, 2, numero.ToString.Length).ToString)
                If Trim(numero.ToString.Length) = 0 Then palabras = ""
            Else
                Exit For
            End If
        Next

        '*********Dividir parte entera y decimal************
        For y = 1 To Len(numero)
            If Mid(numero, y, 1) = "." Then
                flag = "S"
            Else
                If flag = "N" Then
                    entero = entero + Mid(numero, y, 1)
                Else
                    dec = dec + Mid(numero, y, 1)
                End If
            End If
        Next y

        If Len(dec) = 1 Then dec = dec & "0"

        '**********proceso de conversión***********
        flag = "N"

        If Val(numero) <= 999999999 Then
            For y = Len(entero) To 1 Step -1
                num = Len(entero) - (y - 1)
                Select Case y
                    Case 3, 6, 9
                        '**********Asigna las palabras para las centenas***********
                        ''Se agrega la N para las unidades en caso de error quitarla
                        Select Case Mid(entero, num, 1)
                            Case "1"
                                If Mid(entero, num + 1, 1) = "0" And Mid(entero, num + 2, 1) = "0" Then
                                    palabras = palabras & "cien "
                                Else
                                    palabras = palabras & "ciento "
                                    flag = "N"
                                End If
                            Case "2"
                                palabras = palabras & "doscientos "
                                flag = "N"
                            Case "3"
                                palabras = palabras & "trescientos "
                                flag = "N"
                            Case "4"
                                palabras = palabras & "cuatrocientos "
                                flag = "N"
                            Case "5"
                                palabras = palabras & "quinientos "
                                flag = "N"
                            Case "6"
                                palabras = palabras & "seiscientos "
                                flag = "N"
                            Case "7"
                                palabras = palabras & "setecientos "
                                flag = "N"
                            Case "8"
                                palabras = palabras & "ochocientos "
                                flag = "N"
                            Case "9"
                                palabras = palabras & "novecientos "
                                flag = "N"
                        End Select
                    Case 2, 5, 8
                        '*********Asigna las palabras para las decenas************
                        Select Case Mid(entero, num, 1)
                            Case "1"
                                If Mid(entero, num + 1, 1) = "0" Then
                                    flag = "S"
                                    palabras = palabras & "diez "
                                End If
                                If Mid(entero, num + 1, 1) = "1" Then
                                    flag = "S"
                                    palabras = palabras & "once "
                                End If
                                If Mid(entero, num + 1, 1) = "2" Then
                                    flag = "S"
                                    palabras = palabras & "doce "
                                End If
                                If Mid(entero, num + 1, 1) = "3" Then
                                    flag = "S"
                                    palabras = palabras & "trece "
                                End If
                                If Mid(entero, num + 1, 1) = "4" Then
                                    flag = "S"
                                    palabras = palabras & "catorce "
                                End If
                                If Mid(entero, num + 1, 1) = "5" Then
                                    flag = "S"
                                    palabras = palabras & "quince "
                                End If
                                If Mid(entero, num + 1, 1) > "5" Then
                                    flag = "N"
                                    palabras = palabras & "dieci"
                                End If
                            Case "2"
                                If Mid(entero, num + 1, 1) = "0" Then
                                    palabras = palabras & "veinte "
                                    flag = "S"
                                Else
                                    palabras = palabras & "veinti"
                                    flag = "N"
                                End If
                            Case "3"
                                If Mid(entero, num + 1, 1) = "0" Then
                                    palabras = palabras & "treinta "
                                    flag = "S"
                                Else
                                    palabras = palabras & "treinta y "
                                    flag = "N"
                                End If
                            Case "4"
                                If Mid(entero, num + 1, 1) = "0" Then
                                    palabras = palabras & "cuarenta "
                                    flag = "S"
                                Else
                                    palabras = palabras & "cuarenta y "
                                    flag = "N"
                                End If
                            Case "5"
                                If Mid(entero, num + 1, 1) = "0" Then
                                    palabras = palabras & "cincuenta "
                                    flag = "S"
                                Else
                                    palabras = palabras & "cincuenta y "
                                    flag = "N"
                                End If
                            Case "6"
                                If Mid(entero, num + 1, 1) = "0" Then
                                    palabras = palabras & "sesenta "
                                    flag = "S"
                                Else
                                    palabras = palabras & "sesenta y "
                                    flag = "N"
                                End If
                            Case "7"
                                If Mid(entero, num + 1, 1) = "0" Then
                                    palabras = palabras & "setenta "
                                    flag = "S"
                                Else
                                    palabras = palabras & "setenta y "
                                    flag = "N"
                                End If
                            Case "8"
                                If Mid(entero, num + 1, 1) = "0" Then
                                    palabras = palabras & "ochenta "
                                    flag = "S"
                                Else
                                    palabras = palabras & "ochenta y "
                                    flag = "N"
                                End If
                            Case "9"
                                If Mid(entero, num + 1, 1) = "0" Then
                                    palabras = palabras & "noventa "
                                    flag = "S"
                                Else
                                    palabras = palabras & "noventa y "
                                    flag = "N"
                                End If
                        End Select
                    Case 1, 4, 7
                        '*********Asigna las palabras para las unidades*********
                        Select Case Mid(entero, num, 1)
                            Case "1"
                                If flag = "N" Then
                                    If y = 1 Then
                                        palabras = palabras & "uno "
                                    Else
                                        palabras = palabras & "un "
                                    End If
                                End If
                            Case "2"
                                If flag = "N" Then palabras = palabras & "dos "
                            Case "3"
                                If flag = "N" Then palabras = palabras & "tres "
                            Case "4"
                                If flag = "N" Then palabras = palabras & "cuatro "
                            Case "5"
                                If flag = "N" Then palabras = palabras & "cinco "
                            Case "6"
                                If flag = "N" Then palabras = palabras & "seis "
                            Case "7"
                                If flag = "N" Then palabras = palabras & "siete "
                            Case "8"
                                If flag = "N" Then palabras = palabras & "ocho "
                            Case "9"
                                If flag = "N" Then palabras = palabras & "nueve "
                        End Select
                End Select

                '***********Asigna la palabra mil***************
                If y = 4 Then
                    If Mid(entero, 6, 1) <> "0" Or Mid(entero, 5, 1) <> "0" Or Mid(entero, 4, 1) <> "0" Or _
                    (Mid(entero, 6, 1) = "0" And Mid(entero, 5, 1) = "0" And Mid(entero, 4, 1) = "0" And _
                    Len(entero) <= 6) Then palabras = palabras & "mil "
                End If

                '**********Asigna la palabra millón*************
                If y = 7 Then
                    If Len(entero) = 7 And Mid(entero, 1, 1) = "1" Then
                        palabras = palabras & "millón "
                    Else
                        palabras = palabras & "millones "
                    End If
                End If
            Next y

            '**********Une la parte entera y la parte decimal*************
            If dec <> "" Then
                If factura_dlls Then
                    Letras = palabras & " DOLARES " & dec & "/100 USD"
                Else
                    Letras = palabras & " PESOS " & dec & "/100 M.N."
                End If
            Else
                Letras = palabras
            End If
        Else
            Letras = ""
        End If
    End Function
End Module
