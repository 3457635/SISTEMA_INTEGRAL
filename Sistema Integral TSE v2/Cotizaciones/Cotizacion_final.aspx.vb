Public Class Cotizacion_final
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim tabla As String
    Dim cotizacion As String
    Dim proxy As New wcfRef1.Service1Client()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbIdCotizacion.Text = Request("id_cotizacion")
            Dim id_cotizacion = txbIdCotizacion.Text
            Dim buscar_cotizacion = (From consulta In db.precios, consulta2 In db.cotizaciones
                                              Where consulta.id_cotizacion = id_cotizacion And
                                              consulta.id_cotizacion = consulta2.id_cotizacion And
                                              consulta.id_status <> 6
                                              Select consulta, consulta2).FirstOrDefault()
            lblFecha.Text = FormatDateTime(Now.AddHours(-7), DateFormat.LongDate)

            If Not buscar_cotizacion Is Nothing Then
                lblEmpresa.Text = buscar_cotizacion.consulta.empresa.nombre

                If Not buscar_cotizacion.consulta2.vigencia Is Nothing Then
                    lblVigencia.Text = FormatDateTime(buscar_cotizacion.consulta2.vigencia, DateFormat.LongDate)
                End If

                If Not buscar_cotizacion.consulta2.contacto.correo Is Nothing Then
                    txbCorreo.Text = buscar_cotizacion.consulta2.contacto.correo
                End If

                lblFolio.Text = "ct-" + buscar_cotizacion.consulta2.ano.ToString() + "-" + buscar_cotizacion.consulta2.consecutivo.ToString()
                cotizacion = "ct-" + buscar_cotizacion.consulta2.ano.ToString() + "-" + buscar_cotizacion.consulta2.consecutivo.ToString()
                lblContacto.Text = buscar_cotizacion.consulta2.contacto.persona.primer_nombre.ToString() + " " + buscar_cotizacion.consulta2.contacto.persona.apellido_paterno.ToString()

            End If

        End If

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click

        If Not String.IsNullOrEmpty(txbIdCotizacion.Text) Then
            Dim id_cotizacion = txbIdCotizacion.Text


            Dim buscarCotizacion = proxy.buscarCotizacionPorId(id_cotizacion)

            If Not buscarCotizacion Is Nothing Then

                Dim buscarConfiguracionCotizador = (From consulta In db.configuracion_cotizadors
                                                 Select consulta).FirstOrDefault()

                Dim mesesVigencia As Integer = 0
                Dim comentarios = String.Empty

                If Not buscarConfiguracionCotizador Is Nothing Then
                    mesesVigencia = buscarConfiguracionCotizador.meses_vigencia
                End If

                buscarCotizacion.fecha_realizacion = Now.AddHours(-7)
                buscarCotizacion.vigencia = Now.AddHours(-7).AddMonths(mesesVigencia)
                buscarCotizacion.enviadoA = txbCorreo.Text

                proxy.actualizarCotizacion(buscarCotizacion)

            End If


            Dim buscarPrecios = From consulta In db.precios, consulta2 In db.cotizaciones
                                              Where consulta.id_cotizacion = id_cotizacion And
                                              consulta.id_cotizacion = consulta2.id_cotizacion And
                                              consulta.id_status <> 6
                                              Select consulta, consulta2
            'obtener el tipo de moneda, dolares o moneda nacional--------------------------------23 junio 2015-------------------                                              
            Dim buscarMoneda = From consulta In db.precios, consulta2 In db.cotizaciones
            Where consulta.id_cotizacion = id_cotizacion And
            consulta.id_cotizacion = consulta2.id_cotizacion And
            consulta.id_status <> 6
            Select consulta.id_moneda
            Dim moneda As Integer = buscarMoneda.FirstOrDefault()
            '--------------------------------------------------------------------------------------------------

            lblFecha.Text = FormatDateTime(Now.AddHours(-7), DateFormat.LongDate)
            tabla = "<TABLE border='1' cellspacing='0' ><TH>FOLIO</TH><TH>RUTA</TH><TH>VEHICULO</TH><TH>PRECIO</TH><TH>COMENTARIOS</TH>"

            For Each precio In buscarPrecios
                tabla += "<TR>"
                tabla += "<TD>" + precio.consulta2.ano.ToString() + "-" + precio.consulta2.consecutivo.ToString() + "-" + precio.consulta.letra.ToString() + "</TD>"
                tabla += "<TD>" + precio.consulta.llave_ruta.ruta.ToString() + "</TD>"
                tabla += "<TD>" + precio.consulta.tipo_equipo.equipo.ToString() + "</TD>"
                'Especificar si son dolares o mn------------------------------------------------23 junio 2015
                If moneda.Equals(5) Then
                    tabla += "<TD>" + String.Format("{0:c}", precio.consulta.precio) + " Dlls" + "</TD>"
                Else
                    tabla += "<TD>" + String.Format("{0:c}", precio.consulta.precio) + " M.n" + "</TD>"
                End If
                '--------------------------------------------------------------------------------------------------------
                tabla += "<TD>" + String.Format("{0:c}", precio.consulta.especificacion) + "</TD>"
                tabla += "</TR>"
                lblEmpresa.Text = precio.consulta.empresa.nombre
                lblVigencia.Text = FormatDateTime(precio.consulta2.vigencia, DateFormat.LongDate)
                lblFolio.Text = "ct-" + precio.consulta2.ano.ToString() + "-" + precio.consulta2.consecutivo.ToString()
                cotizacion = "ct-" + precio.consulta2.ano.ToString() + "-" + precio.consulta2.consecutivo.ToString()
                lblContacto.Text = precio.consulta2.contacto.persona.primer_nombre.ToString() + " " + precio.consulta2.contacto.persona.apellido_paterno.ToString()

            Next
            tabla += "</TABLE>"

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
            'body += "   <img id='Image1' src='http://tse.com.mx/logo2.jpg' style='border-width:0px;' />"
            'cambio de url 23 06 2015
            body += "   <img id='Image1' src='http://tseinterno.azurewebsites.net/imagenes/logo2.jpg' style='border-width:0px;' />"
            '----------------------------------------------------------------------------------------------------------------------
            body += "   </td><td style='text-align: left; font-family: Arial, Helvetica, sans-serif'>"
            body += "   <strong><span class='style3'>TRANSPORTES Y SEGURIDAD EMPRESARIAL</span></strong><br />"
            body += "       AUTOTRANSPORTE ESPECIALIZADO DENTRO Y FUERA DEL PAÍS</td>"
            body += " </tr></table><p>&nbsp;<span class='style4'>Chihuahua, Chih. A </span><span id='lblFecha' style='font-family: Arial, Helvetica, sans-serif'>" + lblFecha.Text + "</span>"
            body += "</p> <table class='style1'><tr><td><span id='lblEmpresa' style='font-family: Arial, Helvetica, sans-serif; font-weight: 700;'>" + lblEmpresa.Text + "</span>"
            body += "   </td></tr><tr><td>Atención a <span id='lblContacto' style='font-family: Arial, Helvetica, sans-serif'>" + lblContacto.Text + ".</span></td>"
            body += "</tr><tr><td class='style4'>En referencia a su amable solicitud me permito enviarle el precio solicitado, hemos considerado la información recibida para el servicio especifico que necesita, pero le agradeceremos revisar los datos para asegurarnos haber enviado el valor correcto.</td></tr></table>"
            body += "<p> Folio <b>" + lblFolio.Text + "</b>   <br>    <div> " + tabla + "</div><br>"
            body += "Comentarios: <br>"
            body += "<br>Este precio incluye la totalidad de conceptos como chofer, combustible.<br> El precio no incluye IVA el cual será a la tasa vigente.<br> El precio tendrá una vigencia hasta el " + lblVigencia.Text
            body += ".<br>Cualquier duda o comentario puede dirigirse al Departamento de Cotizaciones.<br /> Correo: contacto@tse.com.mx<br />Télefono:(614-481-42-10) Ext.109<br />   </p><p>&nbsp;</p><p>Agradeceremos sus comentarios a la presente.</p>"
            body += "<p>Atentamente.<br>Atención a Cliente.<br>Departamento Cotizaciones.</p><p style='text-align: center'>Ave. Octavio Paz No. 170 Complejo Industrial Chihuahua C.P. 31109</p>"
            body += "<p style='text-align: center'>"
            body += "Tel. 614-481-42-10&nbsp; Lada Mex.01.800.467.21.98 Toll Free From USA "
            body += "1.800.297.5730</p>"
            body += "<p style='text-align: center'>"
            body += "tse.com.mx</p></form></body></html>"
            'Ahora las cotizaciones se envian desde el correo de contacto para agilizar cualquier duda del cliente-------------- 21 07 2015 jose pallares
            'Dim errorAlEnviar = EnviarCorreo(txbCorreo.Text, "Cotización TSE (" + cotizacion + ")", body)
            Dim errorAlEnviar = EnviarCorreoFacturacion(txbCorreo.Text, "Cotización TSE (" + cotizacion + ")", body)
            '-------------------------------------------------------------------------------------------------------------------
            If String.IsNullOrEmpty(errorAlEnviar) Then
                lblMensaje.Text = "La cotización se ha enviado."
            Else
                lblMensaje.Text = String.Format("No se pudo enviar el correo por el siguiente error {0}", errorAlEnviar)
            End If


        End If

    End Sub


    Protected Sub btnRegresar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("~/Cotizaciones/cotizaciones.aspx")
    End Sub

    'Visualizar si la cotizacion esta en Dlls o M.n antes de enviar el correo 02 07 2015----------------------------------
    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If IsNumeric(e.Row.Cells(3).Text) Then
                Dim id_cotizacion = txbIdCotizacion.Text
                Dim buscarMoneda = From consulta In db.precios, consulta2 In db.cotizaciones
                Where consulta.id_cotizacion = id_cotizacion And
                consulta.id_cotizacion = consulta2.id_cotizacion And
                consulta.id_status <> 6
                Select consulta.id_moneda
                Dim moneda As Integer = buscarMoneda.FirstOrDefault()

                If moneda.Equals(5) Then
                    e.Row.Cells(3).Text = e.Row.Cells(3).Text + " Dlls"
                Else
                    e.Row.Cells(3).Text = e.Row.Cells(3).Text + " M.n"
                End If
            End If
        End If
    End Sub
    '-------------------------------------------------------------------------------------------------------------------------
End Class