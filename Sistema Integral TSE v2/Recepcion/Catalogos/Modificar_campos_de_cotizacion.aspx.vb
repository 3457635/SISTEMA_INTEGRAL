Public Class Modificar_campos_de_cotizacion
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Dim id_cotizacion = Request("id_cotizacion")

            If Not String.IsNullOrEmpty(id_cotizacion) Then
                txbIdCotizacion.Text = id_cotizacion


                'If Not buscar_cotizacion Is Nothing Then
                '    lblAno.Text = buscar_cotizacion.ano
                '    lblConsecutivo.Text = buscar_cotizacion.consecutivo
                'End If
            End If
        End If
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim falla As String
        Dim Exitoso As Boolean = False
        'Verificar si el txbIdCotizacion tiene un id para reali zar la modificacion en esa cotizacion
        If Not String.IsNullOrEmpty(txbIdCotizacion.Text) And (Not String.IsNullOrWhiteSpace(txtFecha.Text) Or Not String.IsNullOrEmpty(txtFecha.Text)) Then
            Dim buscar_cotizacion = (From consulta In db.cotizaciones
                                          Where consulta.id_cotizacion = txbIdCotizacion.Text
                                          Select consulta).FirstOrDefault()

            Try
                buscar_cotizacion.fechaCaducidadPrecio = txtFecha.Text
            Catch exeption As Exception
                lblMensaje.Text = "Verifique su fecha"
                EnviarCorreo("sistemas@tse.com.mx", "Error al modificar la fecha de caducidad en una cotización", exeption.Message)
                Return
            End Try
            Try
                db.SubmitChanges()
                Exitoso = True

            Catch ex As Exception
                falla = ex.Message
                EnviarCorreo("sistemas@tse.com.mx", "Error al modificar la fecha de caducidad en una cotización", falla)
            End Try
            If Exitoso Then
                Response.Redirect("~/Recepcion/Catalogos/Precios.aspx")
            End If

        Else
            lblMensaje.Text = "Debe seleccionar una fecha"
        End If
    End Sub
End Class