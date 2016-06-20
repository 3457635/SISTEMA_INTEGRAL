Imports System.Data.SqlClient
Module libreriaSeguimiento
    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()
    Private Function viajeEsMultichofer(ByVal idOrden As Integer)
        Dim buscarOrden = (From consulta In db.trayectos_asignados
                        Where consulta.equipo_asignado.viaje.id_orden = idOrden
                        Select consulta).FirstOrDefault()

        Dim esMultichofer = False

        If Not buscarOrden Is Nothing Then
            esMultichofer = True
        End If

        Return esMultichofer
    End Function
    ''' <summary>
    ''' Inserta los puntos por los que pasara la unidad en un viaje
    ''' </summary>
    ''' <param name="ubicacion"></param>
    ''' <param name="idViaje"></param>
    ''' <param name="UbicacionId"></param>
    ''' <param name="tiempo"></param>
    ''' <remarks></remarks>
    Public Sub insertarPuntoPendiente(ByVal ubicacion As String,
                                      ByVal idViaje As Integer,
                                      ByVal UbicacionId As Integer,
                                      ByVal tiempo As String)

        Dim nuevoPunto As New seguimientoPorRecorrer With {.ubicacion = ubicacion,
                                                           .UbicacionId = UbicacionId,
                                                           .idViaje = idViaje,
                                                           .hora = tiempo}
        db.seguimientoPorRecorrers.InsertOnSubmit(nuevoPunto)
        db.SubmitChanges()
    End Sub


    Public Function regresaTrayectoIniciado(ByVal idViaje As Integer)
        Dim idTrayecto = 0

        Dim buscarTrayectoIniciado = (From consulta In db.trayectos_asignados
                                   Where consulta.equipo_asignado.ViajeId = idViaje And
                                   consulta.idEstatus = 2
                                   Select consulta).FirstOrDefault()

        If Not buscarTrayectoIniciado Is Nothing Then
            idTrayecto = buscarTrayectoIniciado.id_trayecto_asignado
        End If

        Return idTrayecto
    End Function

    Public Function regresaDestinoTrayectoIniciado(ByVal idTrayectoIniciado As Integer) As Integer
        Dim idUbicacion = 0

        Dim buscarUbicacion = (From consulta In db.trayectos,
                               consulta2 In db.trayectos_asignados
                            Where consulta.id_trayecto = consulta2.id_trayecto And
                            consulta2.id_trayecto_asignado = idTrayectoIniciado And
                            consulta.id_tipo_arrivo = 3
                            Select consulta).FirstOrDefault()

        If Not buscarUbicacion Is Nothing Then
            idUbicacion = buscarUbicacion.id_ubicacion
        End If

        Return idUbicacion
    End Function

    Public Function regresaIniciosDeTrayectos(ByVal idViaje As Integer) As Array

        Dim buscarInicios = From consulta In db.trayectos,
                            consulta2 In db.trayectos_asignados
                            Where consulta.llave_trayecto.id_trayecto = consulta2.llave_trayecto.id_trayecto And
                            consulta2.equipo_asignado.ViajeId = idViaje And
                            consulta2.idEstatus = 1 And
                            consulta.id_tipo_arrivo = 1
                            Select consulta


        Dim iniciosArray(buscarInicios.Count - 1) As Integer
        Dim i = 0
        For Each inicio In buscarInicios
            iniciosArray(i) = inicio.id_ubicacion
            i += 1
        Next

        Return iniciosArray
    End Function

    Public Function regresaTrayectoPorOrigen(ByVal idUbicacion As Integer, ByVal idViaje As Integer) As Integer
        Dim idTrayecto = 0

        Dim buscarTrayecto = (From consulta In db.trayectos, consulta2 In db.trayectos_asignados
                           Where consulta.id_trayecto = consulta2.id_trayecto And
                           consulta.id_tipo_arrivo = 1 And consulta.id_ubicacion = idUbicacion And
                           consulta2.equipo_asignado.ViajeId = idViaje
                           Select consulta2).FirstOrDefault()

        If Not buscarTrayecto Is Nothing Then
            idTrayecto = buscarTrayecto.id_trayecto_asignado
        End If


        Return idTrayecto
    End Function

    Public Sub quitarPrimerLineaPuntosPendientes(ByVal idViaje As Integer)

        Dim buscarLinea = (From consulta In db.seguimientoPorRecorrers
                        Where consulta.idViaje = idViaje
                        Select consulta).FirstOrDefault()
        If Not buscarLinea Is Nothing Then
            db.seguimientoPorRecorrers.DeleteOnSubmit(buscarLinea)
            db.SubmitChanges()
        End If
    End Sub

    ''' <summary>
    ''' Busca en la tabla seguimiento por recorrer si el viaje aun tiene puntos por recorrer
    ''' </summary>
    ''' <param name="idViaje"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function existeTablaPuntosPorRecorrer(ByVal idViaje As Integer) As Boolean

        Dim existe = False
        Dim buscarTabla = (From consulta In db.seguimientoPorRecorrers
                        Where consulta.idViaje = idViaje
                        Select consulta).FirstOrDefault()

        If Not buscarTabla Is Nothing Then
            existe = True
        End If
        Return existe
    End Function
    ''' <summary>
    ''' Elimina todos los puntos pendientes por recorrer para un viaje
    ''' </summary>
    ''' <param name="idViaje"></param>
    ''' <remarks></remarks>
    Public Sub limpiarPuntosPendientes(ByVal idViaje As Integer)

        Dim buscarPuntosPendientes = From consulta In db.seguimientoPorRecorrers
                                   Where consulta.idViaje = idViaje
                                   Select consulta

        For Each punto In buscarPuntosPendientes
            db.seguimientoPorRecorrers.DeleteOnSubmit(punto)
            db.SubmitChanges()
        Next
    End Sub
    Public Function buscarRutaEnNotificacionesPersonalizadas(ByVal EmpresaId As Integer,
                                                          ByVal RutaId As Integer) As Boolean

        Dim buscarPunto = (From consulta In db.notificacionesPersonalizadas
                        Where consulta.EmpresaId = EmpresaId And
                        consulta.RutaId = RutaId
                        Select consulta).FirstOrDefault()

        Dim encontrado = False
        If Not buscarPunto Is Nothing Then
            encontrado = True
        End If

        Return encontrado
    End Function
    Public Function buscarPuntoEnNotificacionesPersonalizadas(
                                                          ByVal EmpresaId As Integer,
                                                          ByVal RutaId As Integer,
                                                          ByVal UbicacionId As Integer) As Boolean

        Dim buscarPunto = (From consulta In db.notificacionesPersonalizadas
                        Where consulta.EmpresaId = EmpresaId And
                        consulta.RutaId = RutaId And
                        consulta.UbicacionId = UbicacionId
                        Select consulta).FirstOrDefault()

        Dim encontrado = False
        If Not buscarPunto Is Nothing Then
            encontrado = True
        End If

        Return encontrado
    End Function

    Public Function obtenerDiferenciaDestinos(ByVal idUbicacionArribo As Integer,
                                              ByVal idViaje As Integer,
                                              ByVal fechaLlegada As Date)

        Dim diferencia = 0

        Dim buscarUbicacion = (From consulta In db.detalle_arrivos
                            Where consulta.id_detalle = idUbicacionArribo
                            Select consulta).FirstOrDefault()

        If Not buscarUbicacion Is Nothing Then

            Dim idUbicacionDestino = buscarUbicacion.ubicacione.id_ubicacion

            Dim buscarDestino = (From consulta In db.llegadaDestinos
                          Where consulta.idViaje = idViaje And
                          consulta.detalle_arrivo.ubicacione.id_ubicacion = idUbicacionDestino
                          Select consulta).FirstOrDefault()



            If Not buscarDestino Is Nothing Then


                Dim idLlegada = 0

                Dim fechaPrograma = buscarDestino.fecha

                If IsDate(fechaPrograma) And IsDate(fechaLlegada) Then

                    diferencia = DateDiff(DateInterval.Minute, CDate(fechaPrograma), CDate(fechaLlegada))



                    buscarDestino.fechaReal = fechaLlegada
                    buscarDestino.diferencia = diferencia

                    db.SubmitChanges()
                End If
            End If
        End If

        Return diferencia
    End Function


    


    Public Function obtener_padre(ByVal punto_actual As String) As Integer
        Dim digito As String = ""
        Dim ubicacion As String = punto_actual
        Dim contador As Integer = 0
        Dim ultimo_digito As String = ubicacion.Chars(9)
        Dim padre As Integer = 0
        Dim punto_menor As String = ""


        If ultimo_digito <> "0" Then
            padre = CInt(punto_actual) - 1

        Else
            While digito <> "0" 'encontramos los digitos hasta donde no haya ceros 

                digito = ubicacion.Chars(contador)

                contador += 1
            End While
            Dim primeros_digitos As String = ubicacion.Substring(0, contador - 2) 'a los digitos hay que restarle un digito para encontrar el padre

            Dim ceros_con_uno As String = CStr(10 ^ (10 - (contador - 2))) 'nos da la cantidad de ceros que 
            'necesitamos pero le incluye un 1 al principio 1000:
            Dim ceros_sin_uno As String = ceros_con_uno.Substring(1, ceros_con_uno.Length - 1) 'le quitamos ese uno
            punto_menor = primeros_digitos + ceros_sin_uno

            If existe_ubicacion(punto_menor) Then
                padre = CInt(encontrar_punto_max_subruta(punto_menor))
            Else
                padre = 0
            End If

        End If
        Return padre
    End Function
    ''' <summary>
    ''' Obtiene los email de los clientes a los que se les envia el seguimiento
    ''' </summary>
    ''' <param name="idViaje">id de la empresa</param>
    ''' <returns>lista de correos</returns>
    ''' <remarks></remarks>
    Public Function obtenerContactosSeguimiento(ByVal idViaje As Integer) As List(Of String)


        Dim buscarContactos = From consulta In db.viajes, consulta2 In db.contactosServicios, consulta3 In db.correos
                                      Where consulta.precio.id_relacion = consulta2.id_relacion And
                                      consulta2.idLista = consulta3.idLista And
                                      consulta2.listaDistribucion.idStatus = 5 And
                                        consulta.id_viaje = idViaje
                                      Select consulta3.correo Distinct

        Dim listaCorreos As New List(Of String)()
        For Each contacto In buscarContactos
            listaCorreos.Add(contacto)
        Next

        Return listaCorreos

    End Function
    Public Function obtener_tipo_ubicacion(ByVal id_ubicacion As String) As String
        Dim id_tipo_ubicacion As String = ""
        Try

            Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()
                Dim strSQLident As String = "SELECT id_tipo_ubicacion FROM ubicaciones WHERE id_ubicacion = " + id_ubicacion
                Dim objCommand As New SqlCommand(strSQLident, objConnection)
                Dim dr As SqlDataReader = objCommand.ExecuteReader()

                If dr.Read() Then
                    If dr("id_tipo_ubicacion") IsNot DBNull.Value Then
                        id_tipo_ubicacion = dr("id_tipo_ubicacion")
                    Else
                        Return "0"
                    End If
                End If
            End Using
        Catch ex As Exception
            Return "0"
        End Try
        Return id_tipo_ubicacion
    End Function

    Public Function obtener_primer_hijo(ByVal punto_actual As String) As String

        Dim digito As String = ""
        Dim ubicacion As String = punto_actual
        Dim hijo As String = ""
        Dim contador As Integer = 0
        Dim i As Integer = 0

        While digito <> "0" 'encontramos los digitos hasta donde no haya ceros 

            digito = ubicacion.Chars(contador)

            contador += 1
        End While

        hijo = ubicacion.Substring(0, contador - 1) 'a los digitos hay que sumarle un digito mas para encontrar al hijo

        hijo += CStr(10 ^ (10 - contador))

        Return hijo

    End Function


    Public Function existen_otros_hijo(ByVal siguiente_hijo As String) As Boolean
        Dim id_ubicacion As String = siguiente_hijo
        Try
            Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()
                Dim strSQLident As String = "SELECT id_ubicacion FROM ubicaciones WHERE id_ubicacion = " + id_ubicacion
                Dim objCommand As New SqlCommand(strSQLident, objConnection)
                Dim dr As SqlDataReader = objCommand.ExecuteReader()


                If dr.Read() Then
                    If dr("id_ubicacion") IsNot DBNull.Value Then
                        Return True

                    End If
                Else
                    Return False

                End If
            End Using
        Catch ex As Exception

        End Try
    End Function

    Public Function siguiente_hijo(ByVal hijo_actual As String) As String
        'Obtener el siguiente hijo
        Dim subcadena As String = ""
        Dim contador As Integer = 0

        While subcadena <> "0" 'encontramos los digitos hasta donde no haya ceros 

            subcadena = hijo_actual.Chars(contador)

            contador += 1
        End While
        'obtenemos el ultimo digito
        Dim digito As String = hijo_actual.Chars(contador - 2)

        Dim incrementar_digito As Integer = CInt(digito) + 1

        Dim primeros_digitos As String = hijo_actual.Substring(0, contador - 2) + CStr(incrementar_digito)

        Dim ceros_con_uno As String = (10 ^ (10 - (contador - 1)))

        Dim ceros_sin_uno As String = ceros_con_uno.Substring(1, ceros_con_uno.Length - 1)

        Dim siguiente As String = primeros_digitos + ceros_sin_uno


        Return siguiente
    End Function



    Public Function existe_ubicacion(ByVal id_ubicacion As String) As Boolean
        Try
            Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()
                Dim strSQLident As String = "SELECT id_ubicacion FROM ubicaciones WHERE id_ubicacion = " + id_ubicacion
                Dim objCommand As New SqlCommand(strSQLident, objConnection)
                Dim dr As SqlDataReader = objCommand.ExecuteReader()

                If dr.Read() Then
                    If dr("id_ubicacion") IsNot DBNull.Value Then
                        Return True
                    End If
                Else
                    Return False
                End If
            End Using
        Catch ex As Exception

        End Try
    End Function
    Public Function obtener_nombre_ubicacion(ByVal id_ubicacion As String) As String
        Dim ubicacion As String = "No hay ubicación."
        Try
            Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()
                Dim strSQLident As String = "SELECT ubicacion FROM ubicaciones WHERE id_ubicacion = " + id_ubicacion
                Dim objCommand As New SqlCommand(strSQLident, objConnection)
                Dim dr As SqlDataReader = objCommand.ExecuteReader()

                If dr.Read() Then
                    If dr("ubicacion") IsNot DBNull.Value Then
                        ubicacion = dr("ubicacion")

                    End If
                End If
            End Using
        Catch ex As Exception

        End Try
        Return ubicacion
    End Function



    ''' <summary>
    ''' Se obtiene la llave del punto de origen
    ''' </summary>
    ''' <param name="id_viaje"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function id_principal_origen(ByVal id_viaje As String) As String
        Dim id_principal As String = ""

        Dim buscar_id_principal = (From consulta In db.viajes, consulta2 In db.rutas
                           Where consulta.precio.id_ruta = consulta2.id_ruta And
                           consulta.id_viaje = id_viaje And
                           consulta2.id_tipo_arrivo = 1
                           Select consulta2).FirstOrDefault()
        If Not buscar_id_principal Is Nothing Then
            id_principal = buscar_id_principal.id_principal
        End If


        Return id_principal
    End Function

    Public Function id_principal_origen(ByVal idRuta As Integer) As Integer
        Dim id_principal As String = ""

        Dim buscar_id_principal = (From consulta In db.rutas
                                  Where consulta.llave_ruta.id_ruta = idRuta And
                                  consulta.id_tipo_arrivo = 1
                                  Select consulta).FirstOrDefault()

        If Not buscar_id_principal Is Nothing Then
            id_principal = buscar_id_principal.id_principal
        End If
        Return id_principal
    End Function


    Public Function siguiente_parada(ByVal id_principal As Integer, ByVal id_viaje As String) As String

        Dim siguiente_destino As String = CStr(id_principal + 1)
        Dim id_ubicacion As String = ""
        Dim encontrado = False
        Dim contador As Integer = 0

        While Not encontrado And contador < 15
            contador += 1
            Dim buscar_id_ubicacion = (From consulta In db.viajes, consulta2 In db.rutas
                                  Where consulta.id_viaje = id_viaje And
                                  consulta2.id_principal = siguiente_destino And
                                  consulta.precio.llave_ruta.id_ruta = consulta2.id_ruta
                                  Select consulta2).FirstOrDefault()

            If buscar_id_ubicacion Is Nothing Then
                siguiente_destino += 1
            Else
                id_ubicacion = CStr(buscar_id_ubicacion.ubicacione.id_ubicacion)
                encontrado = True
            End If
        End While
        If Not encontrado Then
            id_ubicacion = ""
        End If
        Return id_ubicacion
    End Function
    Public Function siguiente_parada(ByVal id_principal As Integer, ByVal idRuta As Integer) As String

        Dim siguiente_destino As String = CStr(id_principal + 1)
        Dim id_ubicacion As String = String.Empty
        Dim encontrado = False
        Dim contador As Integer = 0

        While Not encontrado And contador < 15
            contador += 1
            Dim buscar_id_ubicacion = (From consulta2 In db.rutas
                                  Where
                                  consulta2.id_principal = siguiente_destino And
                                  consulta2.id_ruta = idRuta
                                  Select consulta2).FirstOrDefault()

            If buscar_id_ubicacion Is Nothing Then
                siguiente_destino += 1
            Else
                id_ubicacion = CStr(buscar_id_ubicacion.ubicacione.id_ubicacion)
                encontrado = True
            End If
        End While
        If Not encontrado Then
            id_ubicacion = ""
        End If
        Return id_ubicacion
    End Function
    Public Function id_ubicacion_origen(ByVal id_viaje As String) As Integer
        Dim id_ubicacion As Integer = 0

        Dim buscar_id_ubicacion = (From consulta In db.viajes, consulta2 In db.rutas
                                Where consulta.id_viaje = id_viaje And
                                consulta.precio.llave_ruta.id_ruta = consulta2.id_ruta And
                                consulta2.id_tipo_arrivo = 1
                                Select consulta2).FirstOrDefault()

        If Not buscar_id_ubicacion Is Nothing Then
            id_ubicacion = buscar_id_ubicacion.ubicacione.id_ubicacion

        End If




        Return id_ubicacion
    End Function

    Public Function id_ubicacion_origen(ByVal idRuta As Integer) As Integer
        Dim id_ubicacion As Integer = 0

        Dim buscar_id_ubicacion = (From consulta2 In db.rutas
                                Where
                                consulta2.id_ruta = idRuta And
                                consulta2.id_tipo_arrivo = 1
                                Select consulta2).FirstOrDefault()

        If Not buscar_id_ubicacion Is Nothing Then
            id_ubicacion = buscar_id_ubicacion.ubicacione.id_ubicacion

        End If




        Return id_ubicacion
    End Function
    Public Function obtener_orientacion(ByVal id_viaje As Integer, ByVal id_destino As Integer, ByVal posicion_actual As String, ByVal tipo_ubicacion As Integer) As Boolean

        Dim hijo_actual As String = String.Empty
        Dim ir_a As Integer

        Dim menor As Integer = 0
        Dim temporal As Integer = 0


        Dim va_para_arriba As Boolean = False



        'si el punto no es el origen nos dirijimos al sig. punto
        If tipo_ubicacion >= 3 And tipo_ubicacion <= 4 Then 'si esta parado sobre un multidireccional
            hijo_actual = obtener_primer_hijo(posicion_actual) 'obtenemos el 1er hijo de multidireccion
            menor = CInt(hijo_actual)
            Dim mas_hijos As Boolean = True
            While mas_hijos = True 'obtenemos la ruta menos pesada entre los hijos
                temporal = Math.Abs(CInt(id_destino) - CInt(hijo_actual))
                If menor >= temporal Then
                    menor = temporal
                    ir_a = hijo_actual
                    va_para_arriba = False
                    'MsgBox(" entre hijos (abajo)")
                End If
                mas_hijos = existen_otros_hijo(siguiente_hijo(hijo_actual))
                If mas_hijos Then 'si hay mas hijos nos movemos al siguiente
                    hijo_actual = siguiente_hijo(hijo_actual)
                End If
            End While
            Dim padre As Integer = obtener_padre(posicion_actual) 'obtenemos el padre para ver si tenemos que ir hacia arriba
            If padre <> 0 Then 'si hay un padre vemos que sea de menor peso que los hijos
                temporal = Math.Abs(CInt(id_destino) - padre)
                If menor > temporal Then
                    menor = temporal
                    ir_a = CStr(padre)
                    va_para_arriba = True
                    '--------------------------
                    'MsgBox(" padre (arriba)")
                End If
            End If
        Else 'Si estamos parados sobre un nodo bidireccional
            menor = CInt(posicion_actual)
            Dim ubicacion_antecesor As Integer = CInt(posicion_actual) - 1
            If existe_ubicacion(ubicacion_antecesor) Then 'si el punto tiene un antecesor
                temporal = Math.Abs(CInt(id_destino) - ubicacion_antecesor)
                If menor > temporal Then
                    menor = temporal
                    ir_a = CStr(ubicacion_antecesor)
                    va_para_arriba = True
                    '----------------------------------------------
                    'MsgBox("bidireccional hijo antecesor (arriba)")
                End If
            Else 'si no tiene un antecesor verificamos si tiene padre
                Dim padre As Integer = obtener_padre(posicion_actual)
                If padre <> 0 Then 'si tiene un padre
                    temporal = Math.Abs(CInt(id_destino) - padre)
                    If menor > temporal Then
                        menor = temporal
                        ir_a = CStr(padre)
                        va_para_arriba = True
                        '----------------------------------------------
                        'MsgBox("bidireccional padre antecesor(arriba)")
                    End If
                End If
            End If
            Dim ubicacion_sucesor As Integer = CInt(posicion_actual) + 1 'si tiene hijos
            If existe_ubicacion(ubicacion_sucesor) Then
                temporal = Math.Abs(CInt(id_destino) - ubicacion_sucesor)
                If menor > temporal Then
                    menor = temporal
                    ir_a = CStr(ubicacion_sucesor)
                    va_para_arriba = False
                    '--------------------------------------
                    'MsgBox("bidireccional sucesor (abajo)")
                End If
            End If
        End If


        Return va_para_arriba
    End Function
    Public Function obtener_ultima_ubicacion(ByVal id_viaje As Integer)
        Dim ultima_ubicacion As String = String.Empty
        Dim buscar_ultima_fecha_seguimiento = (From consulta In db.puntos_predeterminados, consulta2 In db.horas
                                                Where consulta.seguimiento.id_viaje = id_viaje And consulta.id_seguimiento = consulta2.id_seguimiento
                                                Select consulta, consulta2 Order By consulta.id_punto Descending).FirstOrDefault()

        If Not buscar_ultima_fecha_seguimiento Is Nothing Then
            ultima_ubicacion = buscar_ultima_fecha_seguimiento.consulta.ubicacione.ubicacion
        End If
        Return ultima_ubicacion
    End Function
    Public Function obtener_puntodeinterseccion(ByVal id_origen As String, ByVal id_destino As String) As String

        Dim contador As Integer = 0
        Dim digito_destino As Char = ""
        Dim digito_origen As Char = ""
        Dim punto_interseccion As String = ""
        Dim digito_diferente = False



        While Not digito_diferente And contador < 10 'encontramos los digitos hasta donde no haya ceros 

            digito_destino = id_destino.Chars(contador)
            digito_origen = id_origen.Chars(contador)

            If digito_destino <> digito_origen Then
                digito_diferente = True
            Else
                contador += 1
            End If

        End While




        If contador < 10 Then
            If id_origen.Chars(contador) <> "0" And id_destino.Chars(contador) <> "0" Then

                Dim primeros_digitos As String = id_destino.Substring(0, contador)
                Dim ceros_con_uno As String = CStr(10 ^ (10 - (contador))) 'nos da la cantidad de ceros que 
                'necesitamos pero le incluye un 1 al principio 1000:
                Dim ceros_sin_uno As String = ceros_con_uno.Substring(1, ceros_con_uno.Length - 1) 'le quitamos ese uno
                punto_interseccion = primeros_digitos + ceros_sin_uno
            Else
                punto_interseccion = id_destino
            End If
        Else
            punto_interseccion = id_destino
        End If


        Return punto_interseccion
    End Function
    Public Function retraso_corregible(ByVal minutos_programados As Integer, ByVal minutos_retraso As Integer)
        Dim corregible As Boolean = False
        '7.- DEPENDIENDO DEL TIPO DE RUTA DETERMINAMOS SI VA CON RETRASO
        If minutos_programados < 420 Then 'si es ruta menor de 7 hrs.
            Select Case minutos_retraso
                Case 19 To 39
                    corregible = True
                Case 40 To 10000
                    corregible = False
            End Select
        End If
        If minutos_programados > 420 And minutos_programados < 1020 Then 'si es ruta de 17 hrs.
            Select Case minutos_retraso
                Case 60 To 90
                    corregible = True
                Case 91 To 10000
                    corregible = False
            End Select
        End If
        If minutos_programados > 1021 Then 'si es ruta mayor de 17 hrs.
            Select Case minutos_retraso
                Case 120 To 179
                    corregible = True
                Case 180 To 10000
                    corregible = False
            End Select
        End If
        Return corregible
    End Function
    Public Function obtener_minutos_recorridos(ByVal id_viaje As Integer)
        Dim minutos_recorridos As Integer = 0

        Dim llave_ultimo_seguimiento = obtener_llave_ultimo_seguimiento(id_viaje)

        Dim minutos_programados As Integer = 0 'son los minutos predeterminados en el sistema

        If Not String.IsNullOrEmpty(llave_ultimo_seguimiento) Then
            Dim ultima_fecha_seguimiento = obtener_ultima_fecha_seguimiento(id_viaje)

            Dim llave_seguimiento_origen = obtener_llave_seguimiento_origen(id_viaje)
            Dim fecha_origen = obtener_fecha_origen(id_viaje)

            If llave_ultimo_seguimiento <> llave_seguimiento_origen Then 'debe haber por lo menos 2 puntos para sacar la diferencia
                minutos_recorridos = DateDiff(DateInterval.Minute, CDate(fecha_origen), CDate(ultima_fecha_seguimiento))
            End If
        End If

        Return minutos_recorridos
    End Function
    Public Function obtener_siguiente_paso(ByVal id_destino As Integer, ByVal posicion_actual As Integer, ByVal tipo_ubicacion As Integer) As Integer

        Dim hijo_actual As String = String.Empty
        Dim ir_a As Integer

        Dim menor As Integer = 0
        Dim temporal As Integer = 0


        Dim va_para_arriba As Boolean = False




        If tipo_ubicacion >= 3 And tipo_ubicacion <= 4 Then 'si esta parado sobre un multidireccional
            hijo_actual = obtener_primer_hijo(posicion_actual) 'obtenemos el 1er hijo de multidireccion
            menor = CInt(hijo_actual)
            Dim mas_hijos As Boolean = True
            While mas_hijos = True 'obtenemos la ruta menos pesada entre los hijos
                temporal = Math.Abs(CInt(id_destino) - CInt(hijo_actual))
                If menor >= temporal Then
                    menor = temporal
                    ir_a = hijo_actual
                    va_para_arriba = False
                    'MsgBox(" entre hijos (abajo)")
                End If
                mas_hijos = existen_otros_hijo(siguiente_hijo(hijo_actual))
                If mas_hijos Then 'si hay mas hijos nos movemos al siguiente
                    hijo_actual = siguiente_hijo(hijo_actual)
                End If
            End While
            Dim padre As Integer = obtener_padre(posicion_actual) 'obtenemos el padre para ver si tenemos que ir hacia arriba
            If padre <> 0 Then 'si hay un padre vemos que sea de menor peso que los hijos
                temporal = Math.Abs(CInt(id_destino) - padre)
                If menor > temporal Then
                    menor = temporal
                    ir_a = CStr(padre)
                    va_para_arriba = True
                    '--------------------------
                    'MsgBox(" padre (arriba)")
                End If
            End If
        Else 'Si estamos parados sobre un nodo bidireccional
            menor = CInt(posicion_actual)
            Dim ubicacion_antecesor As Integer = CInt(posicion_actual) - 1
            If existe_ubicacion(ubicacion_antecesor) Then 'si el punto tiene un antecesor
                temporal = Math.Abs(CInt(id_destino) - ubicacion_antecesor)
                If menor > temporal Then
                    menor = temporal
                    ir_a = CStr(ubicacion_antecesor)
                    va_para_arriba = True
                    '----------------------------------------------
                    'MsgBox("bidireccional hijo antecesor (arriba)")
                End If
            Else 'si no tiene un antecesor verificamos si tiene padre
                Dim padre As Integer = obtener_padre(posicion_actual)
                If padre <> 0 Then 'si tiene un padre
                    temporal = Math.Abs(CInt(id_destino) - padre)
                    If menor > temporal Then
                        menor = temporal
                        ir_a = CStr(padre)
                        va_para_arriba = True
                        '----------------------------------------------
                        'MsgBox("bidireccional padre antecesor(arriba)")
                    End If
                End If
            End If
            Dim ubicacion_sucesor As Integer = CInt(posicion_actual) + 1 'si tiene hijos
            If existe_ubicacion(ubicacion_sucesor) Then
                temporal = Math.Abs(CInt(id_destino) - ubicacion_sucesor)
                If menor > temporal Then
                    menor = temporal
                    ir_a = CStr(ubicacion_sucesor)
                    va_para_arriba = False
                    '--------------------------------------
                    'MsgBox("bidireccional sucesor (abajo)")
                End If
            End If




        End If
        Return ir_a
    End Function

    
    ''' <summary>
    ''' Obtiene los email de los clientes a los que se les envia el seguimiento
    ''' </summary>
    ''' <param name="idEmpresa">id de la empresa</param>
    ''' <param name="idRuta">id de la ruta</param>
    ''' <returns>lista de correos</returns>
    ''' <remarks></remarks>
    Public Function obtenerContactosSeguimiento(ByVal idEmpresa As Integer, ByVal idRuta As Integer)


        Dim buscarContactos = From consulta In db.contactosServicios, consulta2 In db.correos
                                      Where consulta.idLista = consulta2.idLista And
                                      consulta.precio.id_empresa = idEmpresa And
                                      consulta.listaDistribucion.idStatus = 5 And
                                      consulta.precio.id_ruta = idRuta
                                      Select consulta2.correo Distinct

        Dim listaCorreos = String.Empty

        For Each contacto In buscarContactos
            listaCorreos += String.Format("{0}, ", contacto)
        Next



        Return listaCorreos

    End Function
    'metodo que devuelve la lista en la que esta el correo de la orden 17 06 2015 --------------------------------------------------------------
    Public Function obteneridLista(ByVal idEmpresa As Integer, ByVal idRuta As Integer)


        Dim buscarlista = From consulta In db.contactosServicios, consulta2 In db.correos
                                      Where consulta.idLista = consulta2.idLista And
                                      consulta.precio.id_empresa = idEmpresa And
                                      consulta.listaDistribucion.idStatus = 5 And
                                      consulta.precio.id_ruta = idRuta
                                      Select consulta2.idLista Distinct

        Dim lista = String.Empty
        Dim separators() As String = {",", "!", "?", ";", ":", " "}
        For Each idlista In buscarlista
            lista += String.Format("{0}, ", idlista)
        Next

        Dim listaArray As String() = lista.Split(separators, StringSplitOptions.RemoveEmptyEntries)

        Return listaArray

    End Function
    '--------------------------------------------------------------------------------------------------------------------------------------

    ''' <summary>
    ''' Envia una alerta cuando no se ha registrado ningun punto en el seguimiento de una orden
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub reportar_viaje_sin_seguimiento()
        Dim id_viaje_caduco As Integer = 0
        If (DateTime.Now().AddHours(-7) >= DateTime.Parse("8:00 AM") And DateTime.Now().AddHours(-7) <= DateTime.Parse("12:30 PM")) Or (DateTime.Now().AddHours(-7) >= DateTime.Parse("3:00 PM") And DateTime.Now().AddHours(-7) <= DateTime.Parse("7:00 PM")) Then



            Dim buscar_viaje = From consulta In db.fechas_viajes
                             Where
                             consulta.fecha.tipo_fecha = 1 And
                             consulta.fecha.fecha.Value.AddDays(1) < Now.AddHours(-7) And
                             Not (From consulta2 In db.seguimientos
                                  Select consulta2.id_viaje).Contains(consulta.viaje.id_viaje) And
                                consulta.viaje.id_status = 2
                             Select consulta

            Dim titulo = "Viajes Sin Seguimiento.</br>"
            Dim body = String.Empty

            For Each viaje In buscar_viaje
                body += crear_info_viaje(viaje.id_viaje) + "</br>"
            Next
            If Not String.IsNullOrEmpty(body) Then
                body += titulo + body
                EnviarCorreo("trafico@tse.com.mx,sistemas@tse.com.mx", "Viaje Sin Seguimiento", body)
            End If
        End If
    End Sub

    ''' <summary>
    ''' Registra el arribo con el cliente para el seguimiento.
    ''' </summary>
    ''' <param name="idViaje">Id del viaje</param>
    ''' <param name="observacion">Observaciones ocurridas en ese punto.</param>
    ''' <param name="inspector">Inspector que registra el arribo.</param>
    ''' <param name="idDetalle">Es el id del nombre del punto a donde se ha llegado.</param>
    ''' <param name="fecha">Hora y Fecha del arribo</param>
    ''' <param name="esLlegada">Es llegada o salida de con el cliente.</param>
    ''' <returns>En caso de una excepcion regresa la descripcion de esta.</returns>
    ''' <remarks></remarks>
    Public Function nuevoArribo(ByVal idViaje As Integer,
                           ByVal observacion As String,
                           ByVal inspector As String,
                           ByVal idDetalle As Integer,
                           ByVal fecha As String,
                           ByVal esLlegada As Boolean)

        Dim errorAlGuardar = String.Empty

        Dim nuevo_seguimiento As New seguimiento With {.id_viaje = idViaje,
                                                                   .observacion = observacion,
                                                                   .inspector = inspector,
                                                       .fecha_de_seguimiento = DateTime.Now().AddHours(-7)
                                                      }

        Dim nuevo_arrivo As New arrivo With {.seguimiento = nuevo_seguimiento,
                                                 .id_detalle = idDetalle
                                                 }

        Dim nueva_hora As New hora With {.fecha = fecha,
                                         .seguimiento = nuevo_seguimiento,
                                         .llegada = esLlegada}

        db.arrivos.InsertOnSubmit(nuevo_arrivo)
        db.horas.InsertOnSubmit(nueva_hora)

        Try
            db.SubmitChanges()
        Catch ex As Exception
            errorAlGuardar = ex.Message
        End Try

        Return errorAlGuardar
    End Function
    Public Function obtenerFechaUltimoSeguimiento(ByVal id_orden As Integer)
        Dim fecha = String.Empty
        Dim buscarSeguimiento = (From consulta In db.horas
                              Where consulta.seguimiento.viaje.Ordene.id_orden = id_orden
                              Select consulta Order By consulta.fecha Descending).FirstOrDefault()

        If Not buscarSeguimiento Is Nothing Then
            fecha = buscarSeguimiento.fecha
        End If
        Return fecha
    End Function
    Public Function obtener_ultimo_seguimiento(ByVal id_viaje As Integer)
        Dim buscar_id_ultimo_seguimiento = (From consulta In db.puntos_predeterminados
                                        Where consulta.seguimiento.id_viaje = id_viaje
                                        Select consulta Order By consulta.id_punto Descending).FirstOrDefault()

        Dim es_redondo As Boolean = False
        Dim llave_ultimo_seguimiento As Integer = 0

        If Not buscar_id_ultimo_seguimiento Is Nothing Then
            es_redondo = buscar_id_ultimo_seguimiento.seguimiento.viaje.precio.llave_ruta.redondo
            llave_ultimo_seguimiento = buscar_id_ultimo_seguimiento.id_seguimiento
        End If


        Dim ultimo_seguimiento As Integer = 0

        Dim buscar_id_ubicacion = (From consulta In db.puntos_predeterminados
                                   Where consulta.id_seguimiento = llave_ultimo_seguimiento
                                   Select consulta).FirstOrDefault()

        If Not buscar_id_ubicacion Is Nothing Then
            ultimo_seguimiento = buscar_id_ubicacion.ubicacione.id_ubicacion
        End If
        Return ultimo_seguimiento
    End Function

    Public Function obtener_llave_seguimiento_origen(ByVal id_viaje As Integer)
        Dim llave_seguimiento_origen As Integer


        Dim buscar_id_primer_seguimiento = (From consulta In db.puntos_predeterminados, consulta2 In db.horas
                                             Where consulta.seguimiento.id_viaje = id_viaje And
                                             consulta.id_seguimiento = consulta2.id_seguimiento
                                             Select consulta, consulta2 Order By consulta.id_punto).FirstOrDefault()
        If Not buscar_id_primer_seguimiento Is Nothing Then
            llave_seguimiento_origen = buscar_id_primer_seguimiento.consulta.id_seguimiento
        End If
        Return llave_seguimiento_origen
    End Function
    ''' <summary>
    ''' Busca la llave del ultimo seguimiento resgistrado en el viaje
    ''' </summary>
    ''' <param name="id_viaje"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function obtener_llave_ultimo_seguimiento(ByVal id_viaje As Integer)

        Dim buscar_id_ultimo_seguimiento = (From consulta In db.puntos_predeterminados
                                        Where consulta.seguimiento.id_viaje = id_viaje
                                        Select consulta Order By consulta.id_punto Descending).FirstOrDefault()

        Dim es_redondo As Boolean = False
        Dim llave_ultimo_seguimiento As Integer = 0

        If Not buscar_id_ultimo_seguimiento Is Nothing Then
            es_redondo = buscar_id_ultimo_seguimiento.seguimiento.viaje.precio.llave_ruta.redondo
            llave_ultimo_seguimiento = buscar_id_ultimo_seguimiento.id_seguimiento
        End If

        Return llave_ultimo_seguimiento
    End Function

    Public Sub insertar_seguimiento(ByVal id_viaje As String, ByVal id_ubicacion As String, ByVal fecha As String, ByVal observacion As String, ByVal inspector As String)
        Dim result As String = ""
        Try
            Using objConnection As New SqlConnection(strConnection)
                objConnection.Open()

                Dim query As String = "INSERT INTO seguimiento (id_ubicacion,fecha,observacion,id_viaje,inspector )" & _
        " VALUES (@id_ubicacion,@fecha,@observacion,@id_viaje,@inspector)"

                Dim objCommand As New SqlCommand(query, objConnection)

                objCommand.Parameters.Add("@id_viaje", SqlDbType.Int).Value = id_viaje
                objCommand.Parameters.Add("@id_ubicacion", SqlDbType.Int).Value = id_ubicacion
                objCommand.Parameters.Add("@fecha", SqlDbType.DateTime).Value = fecha
                objCommand.Parameters.Add("@observacion", SqlDbType.Text).Value = observacion
                objCommand.Parameters.Add("@inspector", SqlDbType.Text).Value = inspector
                Dim lrd As SqlDataReader = objCommand.ExecuteReader()
            End Using
        Catch ex As Exception
        End Try
    End Sub
    ''' <summary>
    ''' Busca la fecha del ultimo seguimiento registrado en un viaje
    ''' </summary>
    ''' <param name="id_viaje"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function obtener_ultima_fecha_seguimiento(ByVal id_viaje As Integer)
        Dim ultima_fecha_seguimiento As Date

        Dim buscar_ultima_fecha_seguimiento = (From consulta In db.puntos_predeterminados, consulta2 In db.horas
                                                Where consulta.seguimiento.id_viaje = id_viaje And consulta.id_seguimiento = consulta2.id_seguimiento
                                                Select consulta, consulta2 Order By consulta.id_punto Descending).FirstOrDefault()

        If Not buscar_ultima_fecha_seguimiento Is Nothing Then
            ultima_fecha_seguimiento = buscar_ultima_fecha_seguimiento.consulta2.fecha
        End If

        Return ultima_fecha_seguimiento
    End Function

    Public Function hay_retraso(ByVal minutos_programados As Integer, ByVal minutos_retraso As Integer)
        Dim retrasado As Boolean = False
        '7.- DEPENDIENDO DEL TIPO DE RUTA DETERMINAMOS SI VA CON RETRASO
        If minutos_programados < 420 Then 'si es ruta menor de 7 hrs.
            Select Case minutos_retraso
                Case 19 To 1000
                    retrasado = True
            End Select
        End If
        If minutos_programados > 420 And minutos_programados < 1020 Then 'si es ruta de 17 hrs.
            Select Case minutos_retraso
                Case 60 To 10000
                    retrasado = True
            End Select
        End If
        If minutos_programados > 1021 Then 'si es ruta mayor de 17 hrs.
            Select Case minutos_retraso
                Case 120 To 179
                    retrasado = True
            End Select
        End If
        Return retrasado
    End Function


    ''' <summary>
    ''' Verifica si el punto registrado en el seguimiento es el ultimo y por lo tanto indica si se llego al destino final.
    ''' </summary>
    ''' <param name="id_viaje">id del viaje</param>
    ''' <param name="id_ubicacion">id de la ubicacion registrada</param>
    ''' <returns>regresa true si se llego al destino</returns>
    ''' <remarks></remarks>
    Public Function llegamos_a_destino(ByVal id_viaje As Integer, ByVal id_ubicacion As Integer) As Boolean
        Dim llegamos As Boolean = False

        Dim buscar_ruta = (From consulta In db.viajes
                       Where consulta.id_viaje = id_viaje
                       Select consulta).FirstOrDefault()

        If Not buscar_ruta Is Nothing Then
            Dim es_redondo = buscar_ruta.precio.llave_ruta.redondo
            Dim id_ruta = buscar_ruta.precio.id_ruta

            If es_redondo Then
                Dim buscar_destino = (From consulta In db.rutas
                                     Where consulta.id_tipo_arrivo = 1 And
                                     consulta.id_ruta = id_ruta
                                     Select consulta).FirstOrDefault()

                If Not buscar_destino Is Nothing Then

                    Dim buscar_repeticiones_seguimiento = (From consulta In db.puntos_predeterminados
                                                        Where consulta.seguimiento.id_viaje = id_viaje And
                                                        consulta.id_ubicacion = id_ubicacion
                                                        Select consulta.id_seguimiento).Count()

                    Dim id_destino = buscar_destino.id_ubicacion

                    If id_ubicacion = id_destino And buscar_repeticiones_seguimiento > 0 Then
                        llegamos = True
                    End If
                End If

            Else

                Dim buscar_destino = (From consulta In db.rutas
                                   Where consulta.id_tipo_arrivo = 3 And
                                   consulta.id_ruta = id_ruta
                                   Select consulta).FirstOrDefault()

                If Not buscar_destino Is Nothing Then
                    Dim id_destino = buscar_destino.id_ubicacion

                    If id_ubicacion = id_destino Then
                        llegamos = True
                    Else
                        Dim buscarUltimaRecoleccion = (From consulta In db.rutas
                                                       Where consulta.id_ruta = id_ruta
                                                    Select consulta Order By consulta.id_principal Descending).FirstOrDefault()

                        If Not buscarUltimaRecoleccion Is Nothing Then
                            Dim ultimaRecoleccion = buscarUltimaRecoleccion.id_ubicacion
                            If ultimaRecoleccion = id_ubicacion Then
                                llegamos = True
                            End If
                        End If

                    End If


                End If
            End If


        End If


        Return llegamos
    End Function

    ''' <summary>
    ''' Registra una pausa en el seguimiento puede ser por descanzo del chofer, comida o cualquier parada que realice.
    ''' </summary>
    ''' <param name="id_viaje">Id del viaje</param>
    ''' <param name="observacion">Observaciones</param>
    ''' <param name="inspector">Inspector</param>
    ''' <param name="tipoPausa">Tipo de pausa (descanso, comida, etc.)</param>
    ''' <param name="fecha">hora y fecha de la pausa</param>
    ''' <param name="es_llegada">Inicia o termina la pausa</param>
    ''' <returns>Si hay alguna excepcion regresará la descripción del problema.</returns>
    ''' <remarks></remarks>
    Public Function nuevaPausaSeguimiento(ByVal id_viaje As Integer,
                                          ByVal observacion As String,
                                          ByVal inspector As String,
                                          ByVal tipoPausa As Integer,
                                          ByVal fecha As String,
                                          ByVal es_llegada As Boolean)
        Dim errorAlGuardar = String.Empty

        Dim nuevo_seguimiento As New seguimiento With {.id_viaje = id_viaje,
                                                                       .observacion = observacion,
                                                                       .inspector = inspector,
                                                       .fecha_de_seguimiento = DateTime.Now().AddHours(-7)
                                                      }

        Dim nueva_pausa As New Pausa With {.seguimiento = nuevo_seguimiento,
                                              .tipo_pausa = tipoPausa}

        Dim nueva_hora As New hora With {.fecha = fecha,
                                        .seguimiento = nuevo_seguimiento,
                                        .llegada = es_llegada}
        db.Pausas.InsertOnSubmit(nueva_pausa)
        db.horas.InsertOnSubmit(nueva_hora)
        Try
            db.SubmitChanges()

        Catch ex As Exception
            errorAlGuardar = ex.Message
        End Try
        Return errorAlGuardar
    End Function

    ''' <summary>
    ''' Obtiene el id de una ubicacion
    ''' </summary>
    ''' <param name="id_ubicacion">Es el numero que determina la ruta en el seguimiento.</param>
    ''' <returns>Id de la ubicacion</returns>
    ''' <remarks></remarks>
    Public Function obtenerIdPrincipalUbicacion(ByVal id_ubicacion As Integer)
        Dim buscar_id_principal = (From consulta In db.ubicaciones
                                Where consulta.id_ubicacion = id_ubicacion
                                Select consulta).FirstOrDefault()
        Dim id_principal_ubicacion = 0
        If Not buscar_id_principal Is Nothing Then
            id_principal_ubicacion = buscar_id_principal.id_principal
        End If
        Return id_principal_ubicacion
    End Function
    ''' <summary>
    ''' Registra un punto de revision predeterminado en el seguimiento
    ''' </summary>
    ''' <param name="idViaje">Id del viaje</param>
    ''' <param name="observacion">observaciones que ocurrieron en ese punto del seguimiento</param>
    ''' <param name="inspector">Inspector que registra </param>
    ''' <param name="id_principal_ubicacion">Id de la ubicacion de ese punto</param>
    ''' <param name="fecha">Hora y fecha del seguimiento</param>
    ''' <returns>Regresa la descripcion de la excepcion en caso de ocurrrir</returns>
    ''' <remarks></remarks>
    Public Function nuevoPuntoPredeterminadoEnSeguimiento(ByVal idViaje As Integer,
                                                          ByVal observacion As String,
                                                          ByVal inspector As String,
                                                          ByVal id_principal_ubicacion As Integer,
                                                          ByVal fecha As String)

        Dim errorAlGuardar = String.Empty

        'campo .fecha_de_seguimiento para registrar la hora a la que se registro el seguimiento independientemente de la hora que se teclee
        Dim nuevo_seguimiento As New seguimiento With {.id_viaje = idViaje,
                                                                           .observacion = observacion,
                                                                           .inspector = inspector,
                                                                            .fecha_de_seguimiento = DateTime.Now().AddHours(-7)
                                                        }


        Dim nuevo_puntos_predeterminados As New puntos_predeterminado With {.seguimiento = nuevo_seguimiento,
                                                                                   .id_ubicacion = id_principal_ubicacion}

        Dim nueva_hora As New hora With {.fecha = fecha,
                                    .seguimiento = nuevo_seguimiento,
                                    .llegada = True}

        db.puntos_predeterminados.InsertOnSubmit(nuevo_puntos_predeterminados)
        db.horas.InsertOnSubmit(nueva_hora)
        Try

            db.SubmitChanges()

        Catch ex As Exception
            errorAlGuardar = ex.Message
            EnviarCorreo("sistemas@tse.com.mx", "Ocurrio un erro.", String.Format("Error en seguimiento al intentar un punto predeterminado. Error:{0}", errorAlGuardar))
        End Try
        Return errorAlGuardar


    End Function
    Public Function encontrar_punto_max_subruta(ByVal punto_menor As String) As String
        Dim punto_mayor As String = punto_menor
        Dim finalizado As Integer = 0
        Dim ubicacion As Integer = 0
        Dim contador As Integer = 0

        While finalizado = 0



            Try
                Using objConnection As New SqlConnection(strConnection)
                    objConnection.Open()
                    Dim strSQLident As String = "SELECT id_ubicacion FROM ubicaciones WHERE id_ubicacion = " + punto_mayor
                    Dim objCommand As New SqlCommand(strSQLident, objConnection)
                    Dim dr As SqlDataReader = objCommand.ExecuteReader()



                    If dr.Read() Then
                        If dr("id_ubicacion") IsNot DBNull.Value Then
                            punto_mayor = dr("id_ubicacion")
                            finalizado = 0
                            ubicacion = CInt(punto_mayor) + 1

                            punto_mayor = CStr(ubicacion)
                        End If
                    Else

                        punto_mayor = CStr(ubicacion) - 1
                        finalizado = 1

                    End If
                End Using
            Catch ex As Exception
                Return 0
            End Try
        End While
        Return punto_mayor
    End Function
    Public Function buscar_inspector(ByVal idOrden As Integer,
                                     ByVal idEquipo As Integer,
                                     ByVal idChofer As Integer,
                                     ByVal tipo_trayecto As Integer)

        Dim buscar = (From consulta In db.Odometros
                   Where consulta.idOrden = idOrden And
                   consulta.id_equipo = idEquipo And
                   consulta.id_chofer = idChofer And
                   consulta.tipo_trayecto = tipo_trayecto
                   Select consulta).FirstOrDefault()

        Dim inspector As String = String.Empty

        If Not buscar Is Nothing Then
            inspector = buscar.inspector
        End If
        Return inspector
    End Function
    ''' <summary>
    ''' cambia el estatus de un viaje a cerrado
    ''' </summary>
    ''' <param name="id_viaje">id del viaje a cerrar</param>
    ''' <remarks></remarks>
    Public Sub cerrar_viaje(ByVal id_viaje As Integer, ByVal fechaCierre As DateTime)


        Dim buscarFecha = proxy.buscarFechaPorIdViaje(id_viaje, 2)


        If buscarFecha Is Nothing Then
            Dim nueva_fecha As New fecha With {.fecha = fechaCierre, .tipo_fecha = 2}
            Dim nueva_fecha_viaje As New fechas_viaje With {.fecha = nueva_fecha, .id_viaje = id_viaje}

            db.fechas_viajes.InsertOnSubmit(nueva_fecha_viaje)
        Else
            buscarFecha.fecha1 = fechaCierre
            buscarFecha.tipo_fecha = 2
            proxy.actualizarFecha(buscarFecha)
        End If


        Dim buscarViaje = proxy.buscarViajePorId(id_viaje)


        If Not buscarViaje Is Nothing Then
            Dim id_orden = buscarViaje.id_orden

            buscarViaje.id_status = 4
            buscarViaje.pendienteCosteo = True
            proxy.actualizarViaje(buscarViaje)

            ''Cerrar orden si ya no hay mas viajes abiertos
            Dim buscar_orden = (From consulta In db.viajes
                                                Where consulta.id_orden = id_orden
                                                Select consulta).FirstOrDefault()

            If buscar_orden Is Nothing Then

                buscarViaje.Ordene.id_status = 4

                Dim buscando_fecha_cierre = (From consulta In db.fechas_ordenes
                                        Where consulta.id_orden = id_orden And
                                        consulta.fecha.tipo_fecha = 2
                                        Select consulta).FirstOrDefault()

                If buscando_fecha_cierre Is Nothing Then
                    Dim fecha_cierre As New fecha With {.fecha = Now().AddHours(-7), .tipo_fecha = 2}
                    Dim fecha_orden As New fechas_ordene With {.fecha = fecha_cierre, .id_orden = id_orden}
                    db.fechas_ordenes.InsertOnSubmit(fecha_orden)
                Else
                    buscando_fecha_cierre.fecha.fecha = Now().AddHours(-7)
                End If
            End If

            Dim errorAlGuardar = String.Empty
            Try
                db.SubmitChanges()
            Catch ex As Exception
                errorAlGuardar = ex.Message
                EnviarCorreo("sistemas@tse.com.mx", "Error metodo cerrar_Viaje() Li.3134", errorAlGuardar)
            End Try


        End If


    End Sub

    

End Module
