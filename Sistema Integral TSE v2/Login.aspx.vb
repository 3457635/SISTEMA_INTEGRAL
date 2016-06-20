Public Partial Class Login
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Se desactivo el envio de un correo con los viajes sin facturar
            'If Now.DayOfWeek = DayOfWeek.Friday And Now.Hour <= 11 Then
            'If User.IsInRole("Trafico") Then
            'If Request.Cookies("SinFactura_enviadas") Is Nothing Then
            'Dim aCookie As HttpCookie = Request.Cookies("SinFactura_enviadas")
            ' Dim inicio = 0
            ' Dim fin = 0
            '  Dim total = 0


            ' Dim tabla = "<TABLE border='1'><TR><TD>Días</TD><TD>Viajes</TD></TR>"

            '  For i = 0 To 5 Step 1
            'Select Case i
            '     Case 0
            ' inicio = -1000
            '  fin = 0
            '      Case 1
            '  inicio = 1
            '  fin = 3
            '     Case 2
            ' inicio = 4
            ' fin = 7
            '      Case 3
            ' inicio = 8
            '  fin = 14
            '      Case 4
            '  inicio = 15
            '  fin = 1000
            '  End Select
            '  Dim cantidad = 0
            'Se agrego que se omitieran las remisionadas
            '  Dim Todas = (From consulta In db.fechas_viajes
            'Where(consulta.fecha.tipo_fecha = 1 And
            ' consulta.viaje.id_status <> 5 And
            '     consulta.viaje.id_status <> 3 And
            '     consulta.viaje.remision = 0 And
            '  (Now() - consulta.fecha.fecha).Value.Days >= inicio And
            '(Now() - consulta.fecha.fecha).Value.Days <= fin And
            '    Not (
            '   From consulta2 In db.facturacions
            '  Select consulta2.id_viaje()()
            '      ).Contains(consulta.id_viaje))
            '                            Select consulta.id_viaje).Count()
            '  cantidad = Todas


            '  Select Case i
            '     Case 0
            '  tabla += "<TR><TD>Viajes Por Salir</TD><TD>" + cantidad.ToString() + "</TD></TR>"
            '
            '     Case 1
            '   tabla += "<TR><TD>1-3</TD><TD>" + cantidad.ToString() + "</TD></TR>"

            '       Case 2
            '   tabla += "<TR><TD>4-7</TD><TD>" + cantidad.ToString() + "</TD></TR>"
            '
            '       Case 3
            '   tabla += "<TR><TD>8-14</TD><TD>" + cantidad.ToString() + "</TD></TR>"
            '
            '      Case 4
            '  tabla += "<TR><TD>14+</TD><TD>" + cantidad.ToString() + "</TD></TR>"
            '
            ' End Select
            '  Next
            '  tabla += "</TABLE>"

            '  Dim body = "<H1>Viajes sin factura.</h1>"

            '  Dim viajes_sin_factura = (From consulta In db.viajes, consulta3 In db.fechas_viajes
            'Where Not (From consulta2 In db.facturacions
            '       Select consulta2.id_viaje).Contains(consulta.id_viaje) And
            'consulta.id_viaje = consulta3.id_viaje And
            'consulta3.fecha.tipo_fecha = 1 And
            'consulta.remision = 0 And
            'consulta.id_status <> 5 And consulta.id_status <> 3
            '                  Select consulta.id_viaje,
            '                  orden = consulta.Ordene.ano.ToString() + "-" + consulta.Ordene.consecutivo.ToString() + "-" + consulta.num_viaje.ToString(),
            ''                  consulta.precio.empresa.nombre,
            '                   consulta.precio.llave_ruta.ruta,
            '                  consulta.precio.precio,
            '                 consulta.verificado,
            '                dias = (Now() - consulta3.fecha.fecha).Value.Days,
            '               consulta3.fecha.fecha).OrderByDescending(Function(x) x.dias)
            '         Dim tabla_viajes = "<Table border='1'><TH>SOPORTES</TH><TH>ORDEN</TH><TH>RUTA</TH><TH>ORDEN</TH><TH>FECHA SERVICIO</TH><TH>DIAS</TH>"

            'For Each viaje In viajes_sin_factura
            'Dim imagen = String.Empty
            'If viaje.verificado Then
            'imagen = "<img src=http://tse.com.mx/net/imagenes/ok.png>"

            'End If
            'tabla_viajes += "<TR><td>" + imagen + "</td><td>" + viaje.orden.ToString() + "</td><td>" + viaje.nombre.ToString() + "</td><td>" + viaje.ruta.ToString() + "</td><td>" + viaje.fecha.ToString() + "</td><td>" + viaje.dias.ToString() + "</td></TR>"
            '    Next
            'tabla_viajes += "</TABLE>"
            'body += tabla + "<br>" + tabla_viajes

            'Dim contactos(2) As String
            'contactos(0) = "sistemas@tse.com.mx"
            ' contactos(1) = "contacto@tse.com.mx"

            'Dim rutaArchios(0) As String

            'proxy.enviarMail(contactos, body, String.Empty, "Viajes Sin Factura", rutaArchios)

            'End If
            'End If
            'End If

            If Request.IsAuthenticated AndAlso Not String.IsNullOrEmpty(Request.QueryString("ReturnUrl")) Then
                ' This is an unauthorized, authenticated request...
                Response.Redirect("~/UnauthorizedAccess.aspx")
            End If
            'Envio de facturas retrasadas de cobro cada martes
            'If Now.DayOfWeek = DayOfWeek.Monday Or Now.DayOfWeek = DayOfWeek.Friday Then
            Try
                ' If Roles.IsUserInRole("Trafico") Then
                ''Se envia 1 sola vez en el dia y lo registramos en una cookie, verificamos si ya se envio
                ' If Request.Cookies("Facturas_enviadas") Is Nothing Then
                'Dim aCookie As HttpCookie = Request.Cookies("Facturas_enviadas")

                ' Dim hoy = Now()
                ' Dim facturas_atrazadas = (From consulta In db.fechas_facturacions
                ' Where(consulta.factura.importe IsNot Nothing And
                ' consulta.fecha.fecha < hoy And
                'consulta.fecha.tipo_fecha = 6 And
                'consulta.factura.Cancelada = False And
                'consulta.factura.facturada_dolares = False And
                'Not (From consulta2 In db.fechas_facturacions
                'Where(consulta2.fecha.tipo_fecha = 7)
                ' Select consulta2.id_factura).Contains(consulta.id_factura))
                '                      Select consulta.factura.folio,
                '                     consulta.factura.total,
                '                    consulta.id_factura,
                '                   consulta.fecha.fecha).OrderBy(Function(x) x.folio)
                '
                'Dim monto_total = (From consulta In db.fechas_facturacions
                'Where(consulta.factura.importe IsNot Nothing And
                'consulta.fecha.fecha < hoy And
                'consulta.fecha.tipo_fecha = 6 And
                'consulta.factura.Cancelada = False And
                'consulta.factura.facturada_dolares = False And
                'Not (From consulta2 In db.fechas_facturacions
                'Where (consulta2.fecha.tipo_fecha = 7)
                ' Select consulta2.id_factura).Contains(consulta.id_factura))
                'Select consulta.factura.total).Sum()



                '                Dim body = Now.ToString("dd/MMM/yyyy") + "<br><b>MONTO TOTAL: M.N. " + String.Format("{0:c}", monto_total) + "</b> <br> <TABLE border=1 cellspacing=0><th>FECHA PROGRAMACION COBRO</th><th>FACTURA</th><th>EMPRESA</TH><TH>MONTO</TH>"

                'For Each factura In facturas_atrazadas
                'Dim id_factura = factura.id_factura
                'Dim cliente = (From consulta In db.facturacions
                ' Where consulta.id_factura = id_factura
                '             Select consulta.viaje.precio.empresa.nombre).FirstOrDefault()
                ' If cliente Is Nothing Then
                ' cliente = "TRW"
                ' End If
                'body += "<tr><td>" + String.Format("{0:d}", factura.fecha) + "</td><td>" + factura.folio.ToString() + "</td><td>" + cliente.ToString() + "</td><TD>" + String.Format("{0:c}", factura.total) + "</TD></tr>"
                'Next
                '
                '               body += "</TABLE>"
                ''EnviarCorreo("sistemas@tse.com.mx,contabilidad@tse.com.mx,contacto@tse.com.mx,gerencia@tse.com.mx", "Facturas vencidas - TSE", body)
                '              Response.Cookies("facturas_enviadas").Value = "1"
                '             Response.Cookies("facturas_enviadas").Expires = DateTime.Now.AddDays(1).ToString
                '            End If
                '  End If


            Catch
                Response.Redirect("default.aspx")

            End Try
            'End If

            ''Reporte de Nomina

            '    Try
            '        If Now.DayOfWeek = DayOfWeek.Monday Then
            '            If Roles.IsUserInRole("trafico") Then
            '                If Request.Cookies("prenomina") Is Nothing Then
            '                    Dim aCookie As HttpCookie = Request.Cookies("prenomina")
            '                    Response.Cookies("prenomina").Value = "1"
            '                    Response.Cookies("prenomina").Expires = DateTime.Now.AddDays(1).ToString

            '                    Dim numero_de_dia = Now.Day
            '                    Dim inicio As Date = "1/" + Now.Month.ToString() + "/" + Now.Year.ToString()
            '                    Dim fin As Date = numero_de_dia.ToString() + "/" + Now.Month.ToString() + "/" + Now.Year.ToString()

            '                    If numero_de_dia > 15 Then
            '                        inicio = "16/" + Now.Month.ToString() + "/" + Now.Year.ToString()
            '                        fin = numero_de_dia.ToString() + "/" + Now.Month.ToString() + "/" + Now.Year.ToString()
            '                    End If

            '                    Dim choferes = (From consulta In db.empleados
            '                       Where (consulta.id_puesto = 1 Or consulta.id_puesto = 3) And
            '                       consulta.persona.id_status = 5
            '                       Select consulta.id_empleado, consulta.persona.primer_nombre).OrderBy(Function(x) x.primer_nombre)

            '                    Dim tabla As String
            '                    tabla = "<TABLE border='1'>"

            '                    Dim nomina_total As Integer

            '                    For Each chofer In choferes
            '                        Dim id_chofis = chofer.id_empleado
            '                        Dim tarifa_total As Decimal = 0

            '                        tarifa_total = obtener_nomina_chofer(inicio, fin, id_chofis)



            '                        If tarifa_total > 0 Then
            '                            Dim nombre_chofer = (From consulta In db.empleados
            '                                              Where consulta.id_empleado = id_chofis
            '                                              Select nombre = consulta.persona.primer_nombre.ToString() + " " + consulta.persona.apellido_paterno.ToString()).FirstOrDefault()

            '                            tabla += "<tr><td>" + CStr(nombre_chofer) + "</td>"


            '                            tabla += "<td>" + String.Format("{0:c0}", tarifa_total) + "</td></tr>"

            '                        End If

            '                        nomina_total += tarifa_total

            '                    Next
            '                    tabla += "</TABLE>"

            '                    Dim f_inicio = inicio.Day.ToString() + "/" + inicio.ToString("MMM") + "/" + inicio.Year.ToString()
            '                    Dim f_fin = fin.Day.ToString() + "/" + fin.ToString("MMM") + "/" + fin.Year.ToString()

            '                    EnviarCorreo("sistemas@tse.com.mx,trafico@tse.com.mx,rhumanos@tse.com.mx", "Prenomina del " + f_inicio + " al " + f_fin, tabla + "<br><font size='5'><b>TOTAL: " + String.Format("{0:c0}", nomina_total) + "</b></font>")
            '                End If
            '            End If
            '        End If

            If Roles.IsUserInRole("Trafico") Or Roles.IsUserInRole("Administrador") Then
                'Response.Redirect("~/Sup.Trafico/tableroTrafico.aspx", False)
            ElseIf Roles.IsUserInRole("Contabilidad") Then
                Response.Redirect("~/Sup.Trafico/tableroIngresos.aspx", False)
            End If
            '    Catch ex As Exception
            '        Dim mensaje = ex.Message
            '        Response.Redirect("default.aspx")
            '    End Try

        End If
    End Sub


    
End Class