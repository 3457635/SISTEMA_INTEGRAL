Imports System.Web.Mail
Imports System.Net.Mail

Module libreriaCorreos

    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()
    ''' <summary>
    ''' Al crear una orden verifica si el precio aun es valido.
    ''' </summary>
    ''' <param name="idRelacion">Id del Precio</param>
    ''' <returns>regresa True si aun es vigente</returns>
    ''' <remarks></remarks>
    Public Function comprobar_cotizacion_vencida(ByVal idRelacion As Integer) As Boolean


        'comprobamos la vigencia del precio'
        Dim buscar_vigencia = proxy.buscarPrecioPorId(idRelacion)

        Dim esVigente = True

        If Not buscar_vigencia.id_cotizacion Is Nothing Then

            Dim idCotizacion = buscar_vigencia.id_cotizacion

            If IsNumeric(idCotizacion) Then
                Dim buscarCotizacion = proxy.buscarCotizacionPorId(idCotizacion)

                If Not buscarCotizacion.fechaCaducidadPrecio Is Nothing Then
                    Dim fechaCaducidad = buscarCotizacion.fechaCaducidadPrecio

                    If fechaCaducidad < Now.AddHours(-7) Then

                        Dim ano = buscarCotizacion.ano
                        Dim consecutivo = buscarCotizacion.consecutivo

                        Dim infoViaje = (From consulta In db.precios
                                      Where consulta.id_relacion = idRelacion
                                      Select consulta).FirstOrDefault()

                        Dim empresa = String.Empty
                        Dim ruta = String.Empty
                        Dim tipoVehiculo = String.Empty

                        If Not infoViaje Is Nothing Then
                            empresa = infoViaje.empresa.nombre
                            ruta = infoViaje.llave_ruta.ruta
                            tipoVehiculo = infoViaje.tipo_equipo.equipo
                        End If

                        Dim tabla = "<TABLE>"
                        tabla += "<TR><TD>Cotizacion:</TD><TD>ct-" + ano.ToString() + "-" + consecutivo.ToString() + "</TD></TR>"
                        tabla += "<TR><TD>Vigencia:</TD><TD>" + buscarCotizacion.fechaCaducidadPrecio + "</TD></TR>"
                        tabla += String.Format("<TR><TD>Empresa:</TD><TD>{0}</TD></TR>", empresa)
                        tabla += String.Format("<TR><TD>Ruta:</TD><TD>{0}</TD></TR>", ruta)
                        tabla += String.Format("<TR><TD>Vehiculo:</TD><TD>{0}</TD></TR>", tipoVehiculo)
                        tabla += "</TABLE>"
                        Dim body = "El siguiente precio esta cerca o ha llegado a su fecha de vencimiento, es necesario recotizar este precio;</br></br>" + tabla

                        Dim errorAlEnviar = EnviarCorreo("contacto@tse.com.mx,contabilidad@tse.com.mx,sistemas@tse.com.mx", "Precio Vencido", body)
                        esVigente = False
                    End If
                End If
            End If




            Dim hoy As Date = FormatDateTime(Now.AddHours(-7), DateFormat.ShortDate)



        Else
            Dim infoViaje = (From consulta In db.precios
                          Where consulta.id_relacion = idRelacion
                          Select consulta).FirstOrDefault()
            If Not infoViaje Is Nothing Then

                Dim info = "<TABLE>"
                info += "<TR><TD>EMPRESA</TD><TD>" + infoViaje.empresa.nombre.ToString + "</TD></TR>"
                info += "<TR><TD>RUTA</TD><TD>" + infoViaje.llave_ruta.ruta.ToString + "</TD></TR>"
                info += "<TR><TD>VEHICULO</TD><TD>" + infoViaje.tipo_equipo.equipo.ToString + "</TD></TR>"
                info += "</TABLE>"

                EnviarCorreo("contacto@tse.com.mx,contabilidad@tse.com.mx,sistemas@tse.com.mx", "Precio Sin Cotización", info)
            End If

        End If

        Return esVigente
    End Function

    ''' <summary>
    ''' Busca los contactos del cliente para enviar factura.
    ''' </summary>
    ''' <param name="idEmpresa">Id de la Empresa</param>
    ''' <returns>Contactos</returns>
    ''' <remarks></remarks>
    Public Function obtenerContactosFacturacion(ByVal idEmpresa As Integer) As String()

        Dim contarContactos = (From consulta In db.ContactosCFDIs
                                    Where consulta.idDatoFacturacion = idEmpresa
                                    Select consulta).Count()

        Dim buscarContactos = From consulta In db.ContactosCFDIs
                            Where consulta.idDatoFacturacion = idEmpresa
                            Select consulta


        Dim contactos(contarContactos - 1) As String
        Dim i = 0
        For Each correo In buscarContactos
            contactos(i) = correo.correo
            i += 1
        Next

        Return contactos
    End Function

    ''' <summary>
    ''' Envia email sin archivos adjuntos
    ''' </summary>
    ''' <param name="destinatarios">Destinatarios.</param>
    ''' <param name="subject">Asunto del correo.</param>
    ''' <param name="body">Cuerpo del correo.</param>
    ''' <returns>Si hay un error al enviar regresa la descripción del error, sino regresa una string vacia.</returns>
    ''' <remarks></remarks>

    Public Function EnviarCorreo(ByVal destinatarios As String,
                                 ByVal subject As String,
                                 ByVal body As String) As String

        Dim correo As System.Net.Mail.MailMessage = New System.Net.Mail.MailMessage()
        correo.From = New System.Net.Mail.MailAddress("sistema_integral@tse.com.mx")

        correo.Subject = subject
        correo.Body = body
        correo.IsBodyHtml = True

        Dim separators() As String = {",", "!", "?", ";", ":", " "}

        Dim correosArray As String() = destinatarios.Split(separators, StringSplitOptions.RemoveEmptyEntries)

        For Each direccion In correosArray
            If validar_Mail(direccion) Then
                correo.To.Add(New System.Net.Mail.MailAddress(direccion))

            End If
        Next


        Dim smtpClient As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient()

        Dim errorAlEnviar As String = String.Empty

        Try
            smtpClient.Send(correo)
        Catch ex As Exception
            errorAlEnviar = ex.Message
        End Try
        Return errorAlEnviar

    End Function
    ''' <summary>
    ''' Enviar cotizaciones desde la direccion de correo contacto@tse.com.mx para que los clientes se comuniquen directamente con facturacion
    ''' 21 07 2015 Jose Pallares
    ''' </summary>
    ''' <param name="destinatarios"></param>
    ''' <param name="subject"></param>
    ''' <param name="body"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Function EnviarCorreoFacturacion(ByVal destinatarios As String,
                                     ByVal subject As String,
                                     ByVal body As String) As String

        Dim correo As System.Net.Mail.MailMessage = New System.Net.Mail.MailMessage()
        correo.From = New System.Net.Mail.MailAddress("contacto@tse.com.mx")

        correo.Subject = subject
        correo.Body = body
        correo.IsBodyHtml = True

        Dim separators() As String = {",", "!", "?", ";", ":", " "}

        Dim correosArray As String() = destinatarios.Split(separators, StringSplitOptions.RemoveEmptyEntries)

        For Each direccion In correosArray
            If validar_Mail(direccion) Then
                correo.To.Add(New System.Net.Mail.MailAddress(direccion))

            End If
        Next

        Dim smtpClient As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient()


        smtpClient.Credentials =
            New System.Net.NetworkCredential("contacto@tse.com.mx", "ALEfactu.2015")

        smtpClient.Port = 26
        smtpClient.EnableSsl = False
        smtpClient.Host = "mail.tse.com.mx"
        Dim errorAlEnviar As String = String.Empty

        Try
            smtpClient.Send(correo)
        Catch ex As Exception
            errorAlEnviar = ex.Message
        End Try
        Return errorAlEnviar

    End Function

    ''' <summary>
    ''' Envia Email con opcion de adjunto.
    ''' </summary>
    ''' <param name="destinatarios">Destinatarios</param>
    ''' <param name="subject">Asunto del correo</param>
    ''' <param name="body">Cuerpo del correo</param>
    ''' <param name="ArchivoAdjunto">Arreglo de rutas de los archivos a enviar. </param>
    ''' <returns>si hay alguna excepcion regresa la descripcion de lo contrario regresa la cadena vacia.</returns>
    ''' <remarks></remarks>
    Public Function EnviarCorreo(ByVal destinatarios As String,
                                 ByVal subject As String,
                                 ByVal body As String,
                                  ByVal ParamArray ArchivoAdjunto() As String) As String

        Dim correo As System.Net.Mail.MailMessage = New System.Net.Mail.MailMessage()
        correo.From = New System.Net.Mail.MailAddress("sistema_integral@tse.com.mx")

        correo.Subject = subject
        correo.Body = body
        correo.IsBodyHtml = True
        Dim errorAlEnviar As String = String.Empty
        Dim separators() As String = {",", "!", "?", ";", ":", " "}

        Dim correosArray As String() = destinatarios.Split(separators, StringSplitOptions.RemoveEmptyEntries)

        For Each Archivo In ArchivoAdjunto
            Try
                Dim adg As New System.Net.Mail.Attachment(Archivo)
                correo.Attachments.Add(adg)
            Catch ex As Exception
                errorAlEnviar = ex.Message
            End Try
        Next



        For Each direccion In correosArray
            If validar_Mail(direccion) Then
                Try
                    correo.To.Add(New System.Net.Mail.MailAddress(direccion))
                Catch ex As Exception
                    errorAlEnviar = ex.Message
                End Try
            End If
        Next


        Dim smtpClient As System.Net.Mail.SmtpClient = New System.Net.Mail.SmtpClient()



        Try
            smtpClient.Send(correo)
        Catch ex As Exception
            errorAlEnviar = ex.Message
        End Try
        Return errorAlEnviar

    End Function


    ''' <summary>
    ''' valida la sintaxis de una direccion de correo
    ''' </summary>
    ''' <param name="correo">direccion de correo</param>
    ''' <returns>Regresa True si el correo es correcto</returns>
    ''' <remarks></remarks>
    Public Function validar_Mail(ByVal correo As String) As Boolean
        ' retorna true o false   
        Return Regex.IsMatch(correo, "\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*")
    End Function
    ''' <summary>
    ''' Existen puntos en el seguimiento en donde se debe enviar notificacion al cliente
    ''' </summary>
    ''' <returns>Regresa true o false si en este punto se envia notificacion.</returns>
    ''' <remarks></remarks>
    Public Function enviarSeguimientoEnEstePunto(ByVal id_ubicacion As Integer)

        Dim buscar_id_principal = (From consulta In db.ubicaciones
                                       Where consulta.id_ubicacion = id_ubicacion
                                       Select consulta).FirstOrDefault()

        Dim enviar_notificacion_a_cliente = False

        If Not buscar_id_principal Is Nothing Then
            enviar_notificacion_a_cliente = buscar_id_principal.notificacion_cliente
        End If


        Return enviar_notificacion_a_cliente

    End Function
    ''' <summary>
    ''' Crea el encabezado de un correo con un saludo para el cliente en forma de html.
    ''' </summary>
    ''' <returns>Regresa el encabezado del correo como string</returns>
    ''' <remarks></remarks>
    Public Function crear_encabezado_rastreo() As String


        Dim body = "<html>"
        body += "<head><title>"
        body += "</title>"
        body += "<style type='text/css'>"
        body += ".style1()"
        body += "{width: 100%;}"
        body += ".style2(){width: 70px;}"
        body += ".style3(){font-size: large;}"
        body += ".style4(){font-family: Arial, Helvetica, sans-serif;}"
        body += "</style></head><body>"
        body += "<table class='style1'><tr>"
        body += "   <td class='style2'>"
        body += "   <img id='Image1' src='http://tse.com.mx/logo2.jpg' style='border-width:0px;' />"
        body += "   </td><td style='text-align: left; font-family: Arial, Helvetica, sans-serif'>"
        body += "   <strong><span class='style3'>TRANSPORTES Y SEGURIDAD EMPRESARIAL</span></strong><br />"
        body += "       Reporte de Servicio</td>"
        body += " </tr></table><p>&nbsp;<span class='style4'>Para su información le anexo el estatus de su orden. </span><span id='lblFecha' style='font-family: Arial, Helvetica, sans-serif'></span>"


        Return body
    End Function
    ''' <summary>
    ''' Crea la firma para correos del sistema.
    ''' </summary>
    ''' <returns>Firma para correo</returns>
    ''' <remarks></remarks>
    Public Function crear_pie_pagina() As String
        Dim body As String = String.Empty
        body += "<br><br>Cualquier duda o comentario puede dirigirse con nuestro Inspector de Tráfico que le atenderá con gusto.<br /> Correo: inspector@tse.com.mx<br />Télefono:614.481.42.10 Ext.118<br />   </p>"
        body += "<p>Atentamente.<br>Departamento de Tráfico.</p><br><br><p style='text-align: center'>Ave. Octavio Paz No. 170 Complejo Industrial Chihuahua C.P. 31109</p>"
        body += "<p style='text-align: center'>"
        body += "Tel. 614-481-42-10&nbsp; Lada Mex.01.800.467.21.98 Toll Free From USA "
        body += "1.800.297.5730</p>"
        body += "<p style='text-align: center'>"
        body += "tse.com.mx</p></form></body></html>"
        Return body

    End Function
    ''' <summary>
    ''' Arma el correo con la información de seguimiento para el cliente
    ''' </summary>
    ''' <param name="id_viaje">El id del viaje.</param>
    ''' <returns>Cuerpo del correo del seguimiento.</returns>
    ''' <remarks></remarks>
    Public Function crearCorreoSeguimientoDefault(ByVal id_viaje As Integer)
        Dim body = String.Empty
        Dim info_orden = crear_info_viaje(id_viaje)
        Dim saludo = crear_encabezado_rastreo()
        Dim equipo = crear_info_equipo(id_viaje)
        Dim pie_pagina_correo = crear_pie_pagina()
        Dim seguimiento = String.Empty
        seguimiento = crear_tabla_seguimientoPorDefault(id_viaje)

        body = saludo + "<br>" + info_orden + "<br>" + equipo + "<br>" + seguimiento + "<br>" + pie_pagina_correo

        Return body
    End Function

    ''' <summary>
    ''' Son puntos donde el cliente a solicitado que se le notifique.
    ''' </summary>
    ''' <param name="id_viaje">Id del Viaje</param>
    ''' <param name="EmpresaId">Id de la empresa</param>
    ''' <param name="RutaId">id de la ruta</param>
    ''' <returns>el cuerpo del correo</returns>
    ''' <remarks></remarks>

    Public Function crearCorreoSeguimientoPersonalizado(ByVal id_viaje As Integer,
                                                        ByVal EmpresaId As Integer,
                                                        ByVal RutaId As Integer) As String
        Dim body = String.Empty
        Dim info_orden = crear_info_viaje(id_viaje)
        Dim saludo = crear_encabezado_rastreo()
        Dim equipo = crear_info_equipo(id_viaje)
        Dim pie_pagina_correo = crear_pie_pagina()
        Dim seguimiento = String.Empty

        seguimiento = crear_tabla_seguimientoPersonalizado(id_viaje, EmpresaId, RutaId)

        body = saludo + "<br>" + info_orden + "<br>" + equipo + "<br>" + seguimiento + "<br>" + pie_pagina_correo

        Return body
    End Function


    
    ''' <summary>
    ''' Crea una tabla con el seguimiento de una orden de servicio.
    ''' </summary>
    ''' <param name="id_viaje">Id del viaje</param>
    ''' <returns>Tabla con el seguimiento del viaje.</returns>
    ''' <remarks></remarks>
    Public Function crear_tabla_seguimientoPorDefault(ByVal id_viaje As Integer) As String

        Dim seguimiento = From consulta In db.seguimientos
                          Where consulta.id_viaje = id_viaje
                          Select consulta Order By consulta.id_seguimiento Descending


        Dim tabla_seguimiento = "<TABLE>"


        For Each punto In seguimiento
            Dim id_seguimiento = punto.id_seguimiento

            Dim arribo = (From consulta In db.arrivos, consulta2 In db.horas
                       Where consulta.seguimiento.id_seguimiento = consulta2.id_seguimiento And
                       consulta.id_seguimiento = id_seguimiento And
                       consulta2.llegada = True
                       Select consulta, consulta2).FirstOrDefault()

            If Not arribo Is Nothing Then
                tabla_seguimiento += String.Format("<TR><TD><b>{0}({1})</b></TD><td><b>{2:dd/MM/yyyy HH:mm}</b></td></TR>", arribo.consulta.detalle_arrivo.nombre, arribo.consulta.detalle_arrivo.ubicacione.ubicacion, arribo.consulta2.fecha)
            End If

            Dim ubicacion_predeterminada = (From consulta In db.puntos_predeterminados, consulta2 In db.horas
                                                     Where consulta.id_seguimiento = id_seguimiento And
                                                     consulta.id_seguimiento = consulta2.id_seguimiento And
                                                     consulta.ubicacione.notificacion_cliente = True
                                                     Select consulta, consulta2).FirstOrDefault()

            If Not ubicacion_predeterminada Is Nothing Then
                tabla_seguimiento += String.Format("<TR><TD>{0}</TD><td>{1:dd/MM/yyyy HH:mm}</td></TR>", ubicacion_predeterminada.consulta.ubicacione.ubicacion, ubicacion_predeterminada.consulta2.fecha)
            End If

        Next


        tabla_seguimiento += "</TABLE>"

        Return tabla_seguimiento

    End Function

    ''' <summary>
    ''' crea la informacion para los puntos de notificacion solicitados por el cliente
    ''' </summary>
    ''' <param name="id_viaje"></param>
    ''' <param name="EmpresaId"></param>
    ''' <param name="RutaId"></param>
    ''' <returns>Tabla de informacion del viaje</returns>
    ''' <remarks></remarks>

    Public Function crear_tabla_seguimientoPersonalizado(ByVal id_viaje As Integer,
                                                         ByVal EmpresaId As Integer,
                                                         ByVal RutaId As Integer) As String

        Dim seguimiento = From consulta In db.seguimientos
                          Where consulta.id_viaje = id_viaje
                          Select consulta Order By consulta.id_seguimiento Descending


        Dim tabla_seguimiento = "<TABLE>"


        For Each punto In seguimiento
            Dim id_seguimiento = punto.id_seguimiento

            Dim arribo = (From consulta In db.arrivos, consulta2 In db.horas
                       Where consulta.seguimiento.id_seguimiento = consulta2.id_seguimiento And
                       consulta.id_seguimiento = id_seguimiento And
                       consulta2.llegada = True
                       Select consulta, consulta2).FirstOrDefault()

            If Not arribo Is Nothing Then
                tabla_seguimiento += String.Format("<TR><TD><b>{0}({1})</b></TD><td><b>{2:dd/MM/yyyy HH:mm}</b></td></TR>", arribo.consulta.detalle_arrivo.nombre, arribo.consulta.detalle_arrivo.ubicacione.ubicacion, arribo.consulta2.fecha)
            End If

            Dim ubicacionPersonalizada = (From consulta In db.puntos_predeterminados,
                                          consulta2 In db.horas,
                                          consulta3 In db.notificacionesPersonalizadas
                                         Where consulta.id_seguimiento = consulta2.id_seguimiento And
                                         consulta.id_ubicacion = consulta3.UbicacionId And
                                         consulta.id_seguimiento = id_seguimiento And
                                         consulta3.EmpresaId = EmpresaId And
                                         consulta3.RutaId = RutaId
                                         Select consulta, consulta2).FirstOrDefault()

            If Not ubicacionPersonalizada Is Nothing Then
                tabla_seguimiento += String.Format("<TR><TD>{0}</TD><td>{1:dd/MM/yyyy HH:mm}</td></TR>", ubicacionPersonalizada.consulta.ubicacione.ubicacion, ubicacionPersonalizada.consulta2.fecha)
            End If


        Next


        tabla_seguimiento += "</TABLE>"

        Return tabla_seguimiento

    End Function
    ''' <summary>
    ''' Crea una tabla html con información de los recursos asignados(equipo, chofer, caja, etc.) a una orden de servicio. Se utiliza principalmente para el envio de correos con esta información.
    ''' </summary>
    ''' <param name="id_viaje">Es el id de la orden de servicio.</param>
    ''' <returns>Regresa la tabla con la información.</returns>
    ''' <remarks></remarks>
    Public Function crear_info_equipo(ByVal id_viaje As Integer) As String

        Dim es_multichofer = (From consulta In db.trayectos_asignados
                                   Where consulta.equipo_asignado.ViajeId = id_viaje
                                   Select consulta.id_trayecto_asignado).Count()




        Dim tabla_info_equipo As String = String.Empty

        If es_multichofer < 1 Then
            Dim buscar_recursos = From consulta In db.equipo_asignados
                                Where consulta.ViajeId = id_viaje
                                Select consulta


            Dim idEquipo = (From consulta In db.equipo_asignados
                           Where consulta.ViajeId = id_viaje
                           Select consulta)
            Dim buscar_caja = (From Consulta In db.cajaAsignadas Where Consulta.EquipoAsignadoId.ToString = idEquipo.ToString Select Consulta.CajaId)

            tabla_info_equipo = "<TABLE><tH>ECONOMICO</TH><th>TIPO</TH><TH>PLACAS</TH><TH>CAJA</TH>"
            For Each equipos In buscar_recursos
                'borrar 4 y 5 jared Quezada
                tabla_info_equipo += String.Format("<TR><TD>{0}</TD><TD>{1}</TD><TD>{2}</TD><TD>{3}</TD><td>{4}</td><td>{5}</td>", equipos.equipo_operacion.economico, equipos.equipo_operacion.tipo_equipo.equipo, equipos.equipo_operacion.placa, equipos.cajaAsignadas)
            Next
            tabla_info_equipo += "</TABLE>"

            tabla_info_equipo += "<TABLE><tH>CHOFER</TH></TH>"

            Dim noRepetirChofer = 0
            For Each choferes In buscar_recursos
                If noRepetirChofer = 0 Then
                    tabla_info_equipo += String.Format("<TR><TD>{0} {1}</TD></TR>", choferes.empleado.persona.primer_nombre, choferes.empleado.persona.apellido_paterno)
                    noRepetirChofer = 1
                End If

            Next
            tabla_info_equipo += "</TABLE>"


        End If

        Return tabla_info_equipo
    End Function


    ''' <summary>
    ''' Crea una tabla con informacion del viaje el cual puede usarse para enviarse por correo.
    ''' </summary>
    ''' <param name="id_viaje">id del viaje</param>
    ''' <returns>tabla del viaje</returns>
    ''' <remarks></remarks>
    ''' SE "AGREGO LA PLACA EN EL CORREO" <<<<<VERIFICAR></VERIFICAR>
    Public Function crear_info_viaje(ByVal id_viaje As Integer) As String
        Dim info_viaje = (From consulta In db.viajes
                                          Where consulta.id_viaje = id_viaje
                                          Select consulta).FirstOrDefault()

        Dim tabla_viaje As String = String.Empty
        If Not info_viaje Is Nothing Then
            Dim buscar_guia = (From consulta In db.guias
                            Where consulta.id_viaje = id_viaje
                            Select consulta).FirstOrDefault()

            tabla_viaje = "<TABLE>"
            tabla_viaje += "<TR><TD><b>ORDEN:</b></TD><TD>" + info_viaje.Ordene.ano.ToString() + "-" + info_viaje.Ordene.consecutivo.ToString() + "-" + info_viaje.num_viaje.ToString() + "</TD></TR>"
            tabla_viaje += "<TR><TD><b>CLIENTE:</b></TD><TD>" + info_viaje.precio.empresa.nombre.ToString() + "</TD></TR>"
            tabla_viaje += "<TR><TD><b>RUTA:</b></TD><TD>" + info_viaje.precio.llave_ruta.ruta.ToString() + "</TD></TR>"
            tabla_viaje += "<TR><TD><b>EQUIPO SOLICITADO:</b></TD><TD>" + info_viaje.precio.tipo_equipo.equipo.ToString() + "</TD></TR>"

            If Not buscar_guia Is Nothing Then
                tabla_viaje += "<TR><TD><b>GUÍA:</b></TD><TD>" + buscar_guia.guia.ToString() + "</TD></TR>"
            End If
            tabla_viaje += "</TABLE>"
        End If
        Return tabla_viaje
    End Function

End Module
