Public Class Facturax1b2ASin_orden

    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Dim subtotal As Decimal
    Dim iva As Decimal
    Dim retencion As Decimal
    Dim total As Decimal
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lnkSinFactura.Text = obtenerViajesSinFactura().ToString()
            lblFolio.Text = ctlFormatoFacturaAmericana1.obtenerFolio()
            ctlFormatoFacturaAmericana1.ponerFecha()
        End If
    End Sub

    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton1.Click
        Dim folio = lblFolio.Text

        Dim idDato = ddlDatoFacturacion.SelectedValue

        ctlFormatoFacturaAmericana1.limpiarFormulario()
        limpiar_formulario(form1)
        lblFolio.Text = folio
        crear_encabezado(idDato)

        Me.subtotal = 0
    End Sub
    Protected Sub llenarLinea(ByVal numeroLinea As Integer,
                              ByVal descripcion As String,
                              ByVal precioViaje As Decimal,
                              ByVal facturaDolares As Boolean)


        Dim cantidad = ctlFormatoFacturaAmericana1.regresarCantidad(numeroLinea)
        Dim cantidadViajes = 0

        If cantidad > 0 Then
            cantidadViajes = cantidad + 1
        Else
            cantidadViajes = 1
        End If

        Dim importe = cantidadViajes * precioViaje




        If cantidadViajes = 1 Then
            ctlFormatoFacturaAmericana1.agregarRenglon(cantidadViajes, descripcion, precioViaje)

        Else
            ctlFormatoFacturaAmericana1.cambiarCantidadEnLinea(numeroLinea, cantidadViajes)
            ctlFormatoFacturaAmericana1.cambiarImporteEnLinea(numeroLinea, importe)
        End If

    End Sub
    Private Sub crear_encabezado(ByVal id_dato As Integer)
        Dim monto = (From consulta2 In db.datos_facturacions
        Where consulta2.id_dato = id_dato
           Select
           consulta2.razon_social,
           consulta2.calle,
           consulta2.colonia,
           consulta2.noExterior,
           consulta2.municipio,
           consulta2.c_postal,
           consulta2.estado,
           consulta2.telefono,
           consulta2.retencion,
           consulta2.rfc).First()


        Dim city = String.Empty
        Dim state = String.Empty
        Dim cp = String.Empty

        If Not monto.municipio Is Nothing Then
            city = monto.municipio
        End If

        If Not monto.estado Is Nothing Then
            state = monto.estado
        End If
        If Not monto.c_postal Is Nothing Then
            cp = monto.c_postal.ToString()
        End If

        Dim direccion = String.Format("{0} {1} {2}", monto.calle, monto.noExterior, monto.colonia)
        Dim ciudad = city + ", " + state + " " + cp

        ctlFormatoFacturaAmericana1.datosReceptor(monto.razon_social, direccion, ciudad, String.Empty)



    End Sub

    Protected Sub ibtnTC_Click(sender As Object, e As ImageClickEventArgs) Handles ibtnTC.Click
        Dim _id_empresa = ddlEmpresa.SelectedValue



        If txbTc.Text <> "" Then
            Dim idDatoFacturacion = ddlDatoFacturacion.SelectedValue
            Dim tipoCambio = txbTc.Text
            actualizarTipoCambio(idDatoFacturacion, tipoCambio)

        End If


    End Sub

    Protected Sub btnImprimir_Click(sender As Object, e As EventArgs) Handles btnImprimir.Click
        Dim idDatoFacturacion = ddlDatoFacturacion.SelectedValue
        Dim folio = lblFolio.Text

        Dim total = ctlFormatoFacturaAmericana1.obtenertotal()

        Dim idFactura = nuevaFactura(folio, total, idDatoFacturacion, True, iva, retencion, total, True)

        Response.Redirect("~/Contabilidad/Facturar/Facturax1b2ASin_orden.aspx")
    End Sub

    Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Response.Redirect("~/Contabilidad/Facturar/Facturax1b2ASin_orden.aspx")
    End Sub

    Protected Sub lnkSinFactura_Click(sender As Object, e As EventArgs) Handles lnkSinFactura.Click
        Response.Redirect("~/Contabilidad/SinFactura_detalle.aspx")
    End Sub
End Class