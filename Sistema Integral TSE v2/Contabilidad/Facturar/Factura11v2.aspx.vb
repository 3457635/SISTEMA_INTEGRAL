Public Class Factura11v2
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Dim enDolares As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        lnkSinFactura.Text = obtenerViajesSinFactura()
    End Sub

    Protected Sub ddlOrden_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlOrden.SelectedIndexChanged
        Dim folio As String = String.Empty

        If Not String.IsNullOrEmpty(txbFolio.Text) Then
            folio = txbFolio.Text
        End If
        limpiar_formulario(form1)
        txbFolio.Text = folio
        ctlFormatoFactura1.ponerFecha()

    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim idViaje = ddlOrden.SelectedValue
        Dim idDatoFacturacion = ddlFacturacion.SelectedValue
        Dim tipoCambio = txbTc.Text
        actualizarTipoCambio(idDatoFacturacion, tipoCambio)

        crear_factura(idViaje)
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
           consulta2.retencion,
           consulta4.fecha.fecha,
           consulta.Ordene.consecutivo,
           consulta.precio.llave_ruta.ruta,
           consulta.precio.tipo_equipo.equipo,
           equipo_precio = consulta3.equipo_operacion.tipo_equipo.equipo,
           consulta3.equipo_operacion.economico,
           consulta3.equipo_operacion.id_tipo_equipo,
           consulta.precio.factura_dolares,
consulta2.tipo_cambio,
consulta.precio.id_moneda).FirstOrDefault()

        Dim existe_diferencia_vehiculos = existeDiferenciaVehiculos(id_viaje)

        If existe_diferencia_vehiculos Then
            lblMensaje.Text = "El precio es de " + monto.equipo.ToString() + " y se fue en " + monto.equipo_precio.ToString()
            lnkActivarImpresion.Visible = True
            btnImprimir.Enabled = False
        End If

        Dim cantidad As Decimal = 0
        Dim descripcion = String.Empty

        Dim importe As Decimal
        
        enDolares = monto.factura_dolares

        If monto.id_moneda = 5 And Not monto.factura_dolares Then
            txbTc.Text = monto.tipo_cambio.ToString()
            lblTC.Text = " Precio: " + monto.precio.ToString() + " dlls."
            importe = monto.precio * monto.tipo_cambio
        Else
            importe = monto.precio
        End If

        Dim precioUnitario As Decimal = importe

        Dim vehiculo = String.Empty
        Dim orden = String.Format("Orden: {0}", monto.consecutivo)
        Dim rutaDes = String.Format("Ruta: {0}", monto.ruta)
        Dim servicio = String.Format("Servicio: {0:dd/MM/yyyy}", monto.fecha)


        If monto.id_tipo_equipo = 102 Then
            vehiculo = "Trailer"

            Dim caja = (From consulta In db.cajaAsignadas
                     Where consulta.equipo_asignado.ViajeId = id_viaje
                     Select consulta.Caja.economico
                     ).FirstOrDefault()

            If Not caja Is Nothing Then
                vehiculo += String.Format(" {0}", caja)
            End If
        Else
            vehiculo = String.Format("{0} :", monto.equipo)
            vehiculo += monto.economico
        End If

        '*datos de la empresa
        Dim datos_facturacion = (From consulta In db.datos_facturacions
                              Where consulta.id_dato = ddlFacturacion.SelectedValue
                              Select consulta).FirstOrDefault()

        Dim razonSocial = datos_facturacion.razon_social
        Dim direccion = String.Format("{0} {1}", datos_facturacion.calle, datos_facturacion.noExterior)
        Dim col = datos_facturacion.colonia
        Dim cp = datos_facturacion.c_postal
        Dim municipio = datos_facturacion.municipio
        Dim estado = datos_facturacion.estado
        Dim RFC = datos_facturacion.rfc
        Dim telefono = datos_facturacion.telefono

        ctlFormatoFactura1.ponerFecha()

        descripcion = String.Format("{0} / {1} / {2} / {3}", orden, vehiculo, rutaDes, servicio)

        ctlFormatoFactura1.crearEncabezado(razonSocial, direccion, col, estado, cp, municipio, RFC, telefono)

        ctlFormatoFactura1.agregarRenglon(1, descripcion, precioUnitario, importe)
        Dim fecha_servicio As Date = monto.fecha
        servicio = String.Format("Servicio: {0:dd/MM/yyyy}", fecha_servicio)

        ctlFormatoFactura1.calcularTotal(importe, monto.retencion, monto.factura_dolares)

        

    End Sub

    Protected Sub btnImprimir_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnImprimir.Click

        Dim idViaje = ddlOrden.SelectedValue
        Dim folio = txbFolio.Text
        Dim importe = ctlFormatoFactura1.regresarSubtotal
        Dim iva = ctlFormatoFactura1.regresarIva
        Dim retencion = ctlFormatoFactura1.regresarRetencion
        Dim total = ctlFormatoFactura1.regresarTotal
        Dim idDatoFacturacion = ddlFacturacion.SelectedValue


        Dim idFactura = nuevaFactura(folio, importe, idDatoFacturacion, False, iva, retencion, total, enDolares)
        If idFactura <> 0 Then

            Dim errorAlRegistrar = registrarViajeFacturacion(idViaje, idFactura)
            If Not String.IsNullOrEmpty(errorAlRegistrar) Then
                lblMensaje.Text = "Ocurrió un error al registrar: " + errorAlRegistrar
            End If
            lblMensaje.Text = "Se imprimió la factura " + folio + " de la orden " + ddlOrden.SelectedItem.ToString()
        Else
            lblMensaje.Text = "Ocurrió un problema y no se ha registrado la factura, notifiquelo a sistemas."

        End If



        Dim viajes_sin_factura = obtenerViajesSinFactura()
        lnkSinFactura.Text = viajes_sin_factura.ToString()
    End Sub


    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LinkButton1.Click
        Response.Redirect("~/Recepcion/Catalogos/Clientes.aspx")
    End Sub

    Protected Sub lnkCancelarOrden_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkCancelarOrden.Click
        btnImprimir.Enabled = True
        Dim folio = txbFolio.Text
        Dim idViaje = ddlOrden.SelectedValue

        cancelarFactura(idViaje)

        lblMensaje.Text = String.Format("Se canceló la factura {0}. Ahora puede imprimir la nueva factura.", folio)
        lnkCancelarOrden.Visible = False

    End Sub

    



    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Dim folio As String = String.Empty

        If Not String.IsNullOrEmpty(txbFolio.Text) Then
            folio = txbFolio.Text
        End If
        limpiar_formulario(form1)
        txbFolio.Text = folio

    End Sub



    Protected Sub lnkSinFactura_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkSinFactura.Click
        Response.Redirect("~/Contabilidad/SinFactura_detalle.aspx")
    End Sub


    Protected Sub lnkActivarImpresion_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkActivarImpresion.Click
        lblMensaje.Text = ""
        btnImprimir.Enabled = True
        lnkActivarImpresion.Visible = False
    End Sub

    Protected Sub ibtnActualizar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizar.Click
        Dim folio = txbFolio.Text

        ctlFormatoFactura1.limpiar_formulario()
        txbFolio.Text = folio

        validar_factura()

    End Sub
    Protected Sub validar_factura()

        lnkCancelarOrden.Visible = False
        lblTC.Text = ""
        Dim folio = txbFolio.Text
        Dim idViaje = ddlOrden.SelectedValue
        Dim idDatoFacturacion = ddlFacturacion.SelectedValue

        If txbFolio.Text <> "" Then
            lblMensaje.Text = ""
            Dim repetida = factura_utilizada_anteriormente(folio, idViaje) ''Ver MiLiberia.vb
            If Not String.IsNullOrEmpty(repetida) Then
                btnImprimir.Enabled = False
                lblMensaje.Text = "Esta factura no puede registrarse porque ya fue utilizada en el servicio " + repetida
            Else


                Dim empresa = (From consulta In db.viajes
                Where (consulta.id_viaje = ddlOrden.SelectedValue)
                            Select consulta.precio).FirstOrDefault()

                Session("id_empresa") = empresa.id_empresa ''ddlActualizarvehiculo
                Session("id_ruta") = empresa.id_ruta ''ddlActualziarvehiculo


                ''Ver MiLibreria.vb
                Dim factura_anterior = orden_facturada_anteriormente(idViaje, folio, idDatoFacturacion)

                If Not String.IsNullOrEmpty(factura_anterior) Then
                    btnImprimir.Enabled = False
                    lnkCancelarOrden.Visible = True
                    lblMensaje.Text = "Este viaje tiene la factura " + factura_anterior

                Else
                    btnImprimir.Enabled = True
                    crear_factura(idViaje)
                End If
            End If
        Else
            lblMensaje.Text = "Primero debe ingresar el numero de factura."



            If Not String.IsNullOrEmpty(txbFolio.Text) Then
                folio = txbFolio.Text
            End If
            limpiar_formulario(form1)
            txbFolio.Text = folio
        End If
    End Sub
End Class