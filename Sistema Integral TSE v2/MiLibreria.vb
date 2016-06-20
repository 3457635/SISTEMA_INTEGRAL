Imports System.Data.SqlClient
Module MiLibreria
    Public strConnection As String = ConfigurationManager.ConnectionStrings("tse-erpConnectionString2").ConnectionString
    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()
    Public Function ObtenerLlave(ByVal tabla As String) As String
        Dim result As String = ""
        Try
            Using objConnectionIdent As New SqlConnection(strConnection)
                objConnectionIdent.Open()
                Dim strSQLident As String = "SELECT IDENT_CURRENT ('" + tabla + "') AS llave;"
                Dim objCommandIdent As New SqlCommand(strSQLident, objConnectionIdent)
                Dim lrdIdent As SqlDataReader = objCommandIdent.ExecuteReader()
                Dim llave As String = "Nada"


                If lrdIdent.Read() Then
                    If lrdIdent("llave") IsNot DBNull.Value Then
                        result = CStr(lrdIdent("llave"))
                    Else
                        Return ""
                    End If
                End If
            End Using
        Catch ex As Exception

        End Try
        Return result
    End Function

    Public Sub InsertarActualizarRegistro(ByVal query As String)
         Dim objConnection As New SqlConnection(strConnection)
        objConnection.Open()

        Dim strSQL As String = query

        Dim objCommand As New SqlCommand(strSQL, objConnection)
        Dim lrd As SqlDataReader = objCommand.ExecuteReader()
        lrd.Close()
        objConnection.Close()
    End Sub

    

    Public Function InfoSolicitud(ByVal id_viaje As String) As String
        Dim result As String = "Error2"
        Try
              Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()
                'El query debe tener el alias as Info ya que es el campo que se recupera
                Dim query As String = "SELECT     'ORDEN: ' + CONVERT(nvarchar(4), Ordenes.ano) + '-' + CONVERT(nvarchar(4), Ordenes.consecutivo) + '-' + CONVERT(nvarchar(2), viajes.num_viaje)" & _
                      "+ ' EMPRESA: ' + convert(nvarchar,dbo.empresas.nombre) + ' RUTA: ' + convert(nvarchar,dbo.llave_rutas.ruta)  + ' PRECIO: $ ' + CONVERT(nvarchar, CONVERT(money," & _
                      "precios.precio))+ ' ' + precios.especificacion AS info " & _
"FROM         viajes INNER JOIN " & _
                      "precios ON viajes.id_relacion = precios.id_relacion INNER JOIN " & _
                      "dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN " & _
                      "Ordenes ON viajes.id_orden = Ordenes.id_orden AND viajes.id_orden = Ordenes.id_orden INNER JOIN " & _
                      "dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta  WHERE viajes.id_viaje=" + id_viaje

                Dim objCommand As New SqlCommand(query, objConnection)
                Dim lrd As SqlDataReader = objCommand.ExecuteReader()

                If lrd.Read() Then
                    If lrd("info") IsNot DBNull.Value Then
                        result = CStr(lrd("info"))
                    Else
                        Return "Error"
                    End If
                End If
            End Using
        Catch ex As Exception
            Return "Error3"
        End Try
        Return result
    End Function
    Public Function SeleccionarRegistro(ByVal query As String) As String
        Dim result As String = ""
        Try
             Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()

                Dim objCommand As New SqlCommand(query, objConnection)
                Dim lrd As SqlDataReader = objCommand.ExecuteReader()


                If lrd.Read() Then
                    If lrd("info") IsNot DBNull.Value Then
                        result = CStr(lrd("info"))
                    Else
                        result = "0"
                    End If
                Else
                    result = "0"
                End If
            End Using
        Catch ex As Exception
            Return "0"
        End Try
        Return result
    End Function

    Public Function compararFechas() As String
        'Contamos cuantos puntos van retrasados o que el inspector no ha registrado'
        Dim puntosCaducos As String = ""
        Try
              Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()

                Dim objCommand As New SqlCommand("consultaFecha", objConnection)
                objCommand.CommandType = CommandType.StoredProcedure
                objCommand.Parameters.AddWithValue("@p1", DateTime.Now.AddHours(-7))
                Dim lrd As SqlDataReader = objCommand.ExecuteReader()

                If lrd.Read() Then
                    If lrd("puntos") IsNot DBNull.Value Then
                        puntosCaducos = CStr(lrd("puntos"))
                    Else
                        Return "0"
                    End If
                End If
            End Using
        Catch ex As Exception
            Return "Error en la función 'compararFechas'."
        End Try
        Return puntosCaducos
    End Function
    Public Function obtener_nomina_chofer(ByVal fecha_inicio As String,
                                          ByVal fecha_fin As String,
                                          ByVal id_chofer As Integer) As Integer
        Dim nomina As Integer = 0
        'Tarifa Unichofer'
        Dim nomina_unichofer As Integer = 0
        Dim nomina_multichofer As Integer = 0

        Dim tarifa_unichofer = (From consulta In db.fechas_ordenes,
                            consulta2 In db.equipo_asignados,
                            consulta3 In db.viajes,
                            consulta4 In db.tarifas_choferes
                          Where consulta.fecha.fecha.Value.Date >= fecha_inicio And
                          consulta.fecha.fecha.Value.Date <= fecha_fin And
                          consulta.fecha.tipo_fecha = 2 And
                          consulta3.id_status = 4 And
                          consulta3.id_viaje = consulta2.ViajeId And
                          consulta.id_orden = consulta3.id_orden And
                          consulta2.idEmpleado = id_chofer And
                           consulta4.id_cliente = consulta3.precio.id_empresa And
                           consulta4.id_ruta = consulta3.precio.id_ruta And
                           consulta4.id_tipo_vehiculo = consulta2.equipo_operacion.id_tipo_equipo And
                           consulta2.equipo_operacion.id_tipo_equipo < 107 And
                           Not (From consulta6 In db.trayectos_asignados
                                Where consulta6.equipo_asignado.idEmpleado = id_chofer
                                Select consulta6.equipo_asignado.idEmpleado).Contains(consulta3.id_viaje)
                          Select consulta4.tarifa).Sum()
        'Tarifa Multichofer'
        If Not tarifa_unichofer Is Nothing Then
            nomina_unichofer = tarifa_unichofer
        Else
            nomina_unichofer = 0
        End If


        Dim tarifa_multichofer = (From consulta In db.fechas_ordenes,
                            consulta2 In db.equipo_asignados,
                            consulta3 In db.viajes,
                            consulta4 In db.tarifas_trayectos,
                            consulta5 In db.trayectos_asignados
                          Where consulta.fecha.fecha.Value.Date >= fecha_inicio And
                          consulta.fecha.fecha.Value.Date <= fecha_fin And
                          consulta.fecha.tipo_fecha = 2 And
                          consulta3.id_status = 4 And
 consulta2.idEmpleado = id_chofer And
        consulta3.id_viaje = consulta2.ViajeId And
        consulta.id_orden = consulta3.id_orden And
        consulta4.id_trayecto = consulta5.id_trayecto And
        consulta4.id_tipo_vehiculo = consulta2.equipo_operacion.id_tipo_equipo And
        consulta5.EquipoAsignadoId = consulta2.id_equipo_asignado
                          Select consulta4.tarifa).Sum()


        If Not tarifa_multichofer Is Nothing Then
            nomina_multichofer = tarifa_multichofer
        Else
            nomina_multichofer = 0
        End If


        nomina = nomina_unichofer + nomina_multichofer
        Return nomina
    End Function
    Public Function buscar_programacion_servicio(ByVal id_equipo As Integer, ByVal id_reparacion As Integer)
        ''Mantenimientos Preventivos
        ''Obtener el siguiente mantenimiento
        Dim distancia As Integer = 0
        Dim buscar_programacion = (From consulta In db.programacion_servicios
                                Where consulta.id_equipo = id_equipo And
                                consulta.id_reparacion = id_reparacion
                                Select consulta).FirstOrDefault()
        If Not buscar_programacion Is Nothing Then
            distancia = buscar_programacion.distancia
        End If
        Return distancia
    End Function
    
   
    Public Function Crear_item(ByVal display As String, ByVal valor As Integer) As ListItem
        Dim nuevoItem As ListItem = New ListItem(display, valor)
        nuevoItem.Selected = True
        Return nuevoItem
    End Function
    

   
    ''' <summary>
    ''' Regresa el numero economico de una unidad.
    ''' </summary>
    ''' <param name="IdUnidad"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerEconomicoUnidad(ByVal IdUnidad As Integer)
        Dim economico As String = String.Empty

        Dim BuscarEconomico = (From consulta In db.equipo_operacions
                            Where consulta.id_equipo = IdUnidad
                            Select consulta).FirstOrDefault()

        If Not BuscarEconomico Is Nothing Then
            economico = BuscarEconomico.economico
        End If
        Return economico
    End Function
    ''' <summary>
    ''' Regresa la fecha en que un cliente solicitó una cotización a través de la pagina tse.com.mx
    ''' </summary>
    ''' <param name="idCotizacion">Es el id de la cotizacion solicitada.</param>
    ''' <returns>regresa la fecha en que se solicito la cotizacion</returns>
    ''' <remarks></remarks>
    Public Function ObtenerFechaSolicitudCotizacion(ByVal idCotizacion As Integer)
        Dim fecha = String.Empty
        Dim buscarFecha = (From consulta In db.solicitudCotizacions
                        Where consulta.cotizacione.id_cotizacion = idCotizacion
                        Select consulta.fecha_solicitud).FirstOrDefault()
        If Not buscarFecha Is Nothing Then
            fecha = buscarFecha
        End If
        Return fecha
    End Function
    ''' <summary>
    ''' Regresa la fecha en que se envio una cotizacion a un cliente a traves del SI.
    ''' </summary>
    ''' <param name="idCotizacion">Es el id de la cotizacion que se envio.</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function ObtenerFechaRespuestaCotizacion(ByVal idCotizacion As Integer)
        Dim fecha = String.Empty
        Dim buscarFecha = (From consulta In db.cotizaciones
                        Where consulta.id_cotizacion = idCotizacion
                        Select consulta.fecha_realizacion).FirstOrDefault()

        If Not buscarFecha Is Nothing Then
            fecha = buscarFecha
        End If

        Return fecha
    End Function
   
    
    
    
   
    
  
    ''' <summary>
    ''' Se utiliza para quitar el texto de los textbox de un formulario, oculta los linkbutton, y deselecciona los checkbox de una formulario.
    ''' </summary>
    ''' <param name="controles">Recibe el formulario a limpiar</param>
    ''' <remarks></remarks>
    Public Sub limpiar_formulario(ByVal controles As Control)

        Dim txt As TextBox
        Dim lnk As LinkButton
        Dim ckb As CheckBox

        For Each x In controles.Controls
            If x.GetType() Is GetType(TextBox) Then
                txt = CType(x, TextBox)
                txt.Text = ""
            End If
            If x.GetType() Is GetType(LinkButton) Then
                lnk = CType(x, LinkButton)
                lnk.Visible = False
            End If
            If x.GetType() Is GetType(CheckBox) Then
                ckb = CType(x, CheckBox)
                ckb.Checked = False
            End If
        Next
    End Sub
    ''' <summary>
    ''' Se utiliza para deseleccionar las casillas de un Checkboxlist. Se utiliza principalmente en la facturaci[on.
    ''' </summary>
    ''' <param name="ckb"></param>
    ''' <remarks></remarks>
    Public Sub limpiarCheboxList(ByVal ckb As CheckBoxList)
        For i = 0 To ckb.Items.Count - 1
            If ckb.Items(i).Selected Then
                ckb.Items(i).Selected = False
            End If
        Next

    End Sub

    ''' <summary>
    ''' Obtiene el numero economico de la caja utilizada en cierta orden de servicio, es utilizada principalmente en facturación para darle una referencia al cliente.
    ''' </summary>
    ''' <param name="idViaje">Es el id del viaje que nos intereza saber la caja utilizada.</param>
    ''' <returns>Regresa el numero economico de la caja</returns>
    ''' <remarks></remarks>

    Public Function obtenerCajaUtilizada(ByVal idViaje As Integer)
        Dim caja = (From consulta In db.cajaAsignadas
                                    Where consulta.equipo_asignado.ViajeId = idViaje
                                    Select consulta.Caja.economico
                                    ).FirstOrDefault()
        Dim numero = String.Empty
        If Not caja Is Nothing Then
            numero = caja
        End If
        Return numero
    End Function

End Module