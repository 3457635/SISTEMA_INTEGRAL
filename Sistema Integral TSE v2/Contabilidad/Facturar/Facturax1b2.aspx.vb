Public Class Facturax1b2
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Dim subtotal As Decimal
    Dim iva As Decimal
    Dim retencion As Decimal
    Dim total As Decimal

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            lnkSinFactura.Text = obtenerViajesSinFactura().ToString()
        End If

    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnTC.Click
        Dim _id_empresa = ddlEmpresa.SelectedValue



        If txbTc.Text <> "" Then
            Dim idDatoFacturacion = ddlDatoFacturacion.SelectedValue
            Dim tipoCambio = txbTc.Text
            actualizarTipoCambio(idDatoFacturacion, tipoCambio)

        End If

        For i = 0 To CheckBoxList1.Items.Count - 1
            If CheckBoxList1.Items(i).Selected Then
                Dim id_viaje = CheckBoxList1.Items(i).Value
                crear_factura(id_viaje)
            End If
        Next

    End Sub
    Protected Sub llenarLinea(ByVal numeroLinea As Integer,
                              ByVal descripcion As String,
                              ByVal precioViaje As Decimal,
                              ByVal aplicaRetencion As Boolean,
                              ByVal facturaDolares As Boolean)


        Dim linea = ctlFormatoFactura1.regresarCantidadPorLinea(numeroLinea)
        Dim cantidadViajes = 0

        If Not String.IsNullOrEmpty(linea) Then
            cantidadViajes = CInt(linea) + 1
        Else
            cantidadViajes = 1
        End If

        Dim Importe = cantidadViajes * precioViaje

        subtotal += precioViaje
        If aplicaRetencion Then
            retencion = subtotal * 0.04
        End If
        iva = subtotal * 0.16
        total = subtotal - retencion + iva

        If cantidadViajes = 1 Then
            ctlFormatoFactura1.agregarRenglon(cantidadViajes, descripcion, precioViaje, Importe)
            ctlFormatoFactura1.calcularTotal(precioViaje, aplicaRetencion, facturaDolares)
        Else
            ctlFormatoFactura1.cambiarLineaCantidad(numeroLinea, cantidadViajes)
            ctlFormatoFactura1.cambiarLineaImporte(numeroLinea, Importe)
            ctlFormatoFactura1.calcularTotal(precioViaje, aplicaRetencion, facturaDolares)
        End If

    End Sub

    Protected Sub crear_factura(ByVal id_viaje As String)

        Dim monto = (From consulta In db.viajes,
                     consulta2 In db.datos_facturacions,
                     consulta3 In db.equipo_asignados,
                     consulta4 In db.fechas_viajes
        Where (consulta.id_viaje = id_viaje And
               consulta.precio.empresa.id_empresa = consulta2.id_empresa And
               consulta.id_viaje = consulta4.id_viaje And
               consulta4.fecha.tipo_fecha = 1 And
               consulta.id_viaje = consulta3.ViajeId And
               consulta3.equipo_operacion.id_tipo_equipo <> 107)
           Select consulta.precio.precio,
           consulta.precio.id_relacion,
           consulta2.retencion,
           consulta.Ordene.consecutivo,
           consulta.precio.llave_ruta.ruta,
           consulta.precio.tipo_equipo.equipo,
           consulta3.equipo_operacion.id_tipo_equipo,
           consulta.precio.factura_dolares,
consulta2.tipo_cambio,
consulta.precio.id_moneda).FirstOrDefault()


        If Not monto Is Nothing Then

            Dim precioViaje As Decimal
            Dim facturaDolares = monto.factura_dolares
            Dim aplicaRetencion = monto.retencion
            Dim descripcion = String.Format("FLETE {0} ({1})", monto.ruta, monto.equipo)
            Dim numeroLinea = 0

            If monto.id_moneda = 5 And Not monto.factura_dolares Then
                txbTc.Text = monto.tipo_cambio.ToString()
                ctlFormatoFactura1.borrarAnotacion()
                ctlFormatoFactura1.agregarAnotaciones("Tipo de Cambio " + String.Format("{0:n4}", monto.tipo_cambio))
                lblTC.Text = " Precio: " + monto.precio.ToString() + " dlls."
                precioViaje = monto.precio * monto.tipo_cambio

            Else
                precioViaje = monto.precio
            End If

            Dim servicio = monto.id_relacion.ToString()
            Dim salir As Boolean = False

            Dim entrar = True
            'Renglon 1
            If txbRelacion1.Text = "" Or txbRelacion1.Text = servicio Then
                entrar = False
                txbRelacion1.Text = servicio
                numeroLinea = 0
            End If

            'Renglon 2
            If entrar Then
                If txbRelacion2.Text = "" Or txbRelacion2.Text = servicio Then
                    entrar = False
                    txbRelacion2.Text = servicio
                    numeroLinea = 1
                End If
            End If

            'Renglon 3
            If entrar Then
                If txbRelacion3.Text = "" Or txbRelacion3.Text = servicio Then
                    entrar = False
                    txbRelacion3.Text = servicio
                    numeroLinea = 2
                End If
            End If

            'Renglon 4
            If entrar Then
                If txbRelacion4.Text = "" Or txbRelacion4.Text = servicio Then
                    entrar = False
                    txbRelacion4.Text = servicio
                    numeroLinea = 3
                End If
            End If

            'Renglon 5
            If entrar Then
                If txbRelacion5.Text = "" Or txbRelacion5.Text = servicio Then
                    entrar = False
                    txbRelacion5.Text = servicio
                    numeroLinea = 4
                End If
            End If

            'Renglon 6
            If entrar Then
                If txbRelacion6.Text = "" Or txbRelacion6.Text = servicio Then
                    entrar = False
                    txbRelacion6.Text = servicio
                    numeroLinea = 5
                End If
            End If

            llenarLinea(numeroLinea, descripcion, precioViaje, aplicaRetencion, facturaDolares)
        Else
            lblMensaje.Text = "Ocurrió un problema con una de las ordenes de servicio selecionada."
        End If

    End Sub
    Private Sub crear_encabezado(ByVal id_dato As Integer)
        Dim monto = (From consulta2 In db.datos_facturacions
        Where consulta2.id_dato = id_dato
           Select
           consulta2.razon_social,
           consulta2.direccion,
           consulta2.colonia,
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


        ctlFormatoFactura1.crearEncabezado(monto.razon_social, monto.direccion, monto.colonia, state, cp, city, monto.rfc, monto.telefono)
        ctlFormatoFactura1.ponerFecha()
    End Sub

    Protected Sub btnImprimir_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnImprimir.Click


        Dim idDatoFacturacion = ddlDatoFacturacion.SelectedValue
        Dim folio = txbFolio.Text
        Dim importe = ctlFormatoFactura1.regresarSubtotal
        Dim iva = ctlFormatoFactura1.regresarIva()

        Dim retencion = ctlFormatoFactura1.regresarRetencion
        Dim total = ctlFormatoFactura1.regresarTotal

        Dim idFactura = nuevaFactura(folio, importe, idDatoFacturacion, False, iva, retencion, total)

        If idFactura <> 0 Then
            For i = 0 To CheckBoxList1.Items.Count - 1
                If CheckBoxList1.Items(i).Selected Then
                    Dim id_viaje = CheckBoxList1.Items(i).Value

                    Dim errorAlRegistrar = registrarViajeFacturacion(id_viaje, idFactura)

                    If Not String.IsNullOrEmpty(errorAlRegistrar) Then
                        lblMensaje.Text = "Ocurrió un problema al guardar: " + errorAlRegistrar
                    End If
                End If
            Next

            lblMensaje.Text = "Se imprimió la factura " + folio

            lnkSinFactura.Text = obtenerViajesSinFactura()
        Else
            lblMensaje.Text = "No se registró la factura."
        End If
    End Sub

    Protected Sub lnkCancelarOrden_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkCancelarOrden.Click
        btnImprimir.Enabled = True
        Dim idViaje = txbIdViaje.Text
        cancelarFactura(idViaje)

        lblMensaje.Text = String.Format("Se canceló la factura anterior. ")
        lnkCancelarOrden.Visible = False

    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button2.Click
        ctlFormatoFactura1.limpiar_formulario()
    End Sub

   

    Protected Sub lnkSinFactura_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkSinFactura.Click
        Response.Redirect("~/Contabilidad/SinFactura_detalle.aspx")
    End Sub


    Protected Sub ImageButton1_Click1(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        If txbFolio.Text <> "" Then
            Dim folio = txbFolio.Text

            Dim idDato = ddlDatoFacturacion.SelectedValue

            ctlFormatoFactura1.limpiar_formulario()
            limpiar_formulario(form1)
            txbFolio.Text = folio
            crear_encabezado(idDato)



            Me.subtotal = 0
            For i = 0 To CheckBoxList1.Items.Count - 1
                If CheckBoxList1.Items(i).Selected Then
                    Dim id_viaje = CheckBoxList1.Items(i).Value

                    lblMensaje.Text = ""
                    txbIdViaje.Text = id_viaje
                    Dim repetida = factura_utilizada_anteriormente(folio, id_viaje)
                    If repetida <> "" Then
                        btnImprimir.Enabled = False

                        lblMensaje.Text = "Esta factura no puede registrarse porque ya fue utilizada en el servicio " + repetida
                    Else
                        btnImprimir.Enabled = True
                        Dim idDatoFacturacion = ddlDatoFacturacion.SelectedValue

                        Dim factura_anterior = orden_facturada_anteriormente(id_viaje, folio, idDatoFacturacion)

                        If factura_anterior <> "" Then
                            btnImprimir.Enabled = False
                            lnkCancelarOrden.Visible = True
                            Dim folioOrden = obtenerFolioOrden(id_viaje)
                            lblMensaje.Text = String.Format("El viaje {0} tiene la factura {1}", folioOrden, factura_anterior)
                            txbIdViaje.Text = id_viaje
                        Else
                            crear_factura(id_viaje)
                        End If

                    End If

                End If
            Next
        Else
            lblMensaje.Text = "Primero debe ingresar el numero de factura."

        End If
    End Sub
End Class