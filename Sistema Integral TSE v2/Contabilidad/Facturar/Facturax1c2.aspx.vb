Public Class Facturax1c2
    Inherits System.Web.UI.Page

    Dim db As New DataClasses1DataContext()
    Dim importe_total As Decimal
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
        lnkSinFactura.Text = obtenerViajesSinFactura()

    End Sub

    Protected Sub ddlOrden_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        limpiar_formulario()
        ctlFormatoFactura1.limpiar_formulario()

    End Sub
    Protected Sub limpiar_formulario()


        For i = 0 To CheckBoxList1.Items.Count - 1
            If CheckBoxList1.Items(i).Selected Then
                CheckBoxList1.Items(i).Selected = False
            End If
        Next


    End Sub




    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton2.Click
        If txbFolio.Text <> "" Then

            Dim idDatoFacturacion = ddlDatoFacturacion.SelectedValue
            ctlFormatoFactura1.limpiar_formulario()

            For i = 0 To CheckBoxList1.Items.Count - 1
                If CheckBoxList1.Items(i).Selected Then

                    Dim folio = txbFolio.Text
                    Dim idViaje = CheckBoxList1.Items(i).Value



                    Dim repetida = factura_utilizada_anteriormente(folio, idViaje) ''ver MiLiberia.vb
                    If repetida <> "" Then
                        btnImprimir.Enabled = False
                        lblMensaje.Text = "Esta factura no puede registrarse porque ya fue utilizada en el servicio " + repetida

                    Else
                        btnImprimir.Enabled = True

                        Dim factura_anterior = orden_facturada_anteriormente(idViaje, folio, idDatoFacturacion) ''ver MiLibreria.vb

                        If factura_anterior <> "" Then

                            lnkCancelarOrden.Visible = True
                            lblMensaje.Text = "Este viaje tiene la factura " + factura_anterior
                            txbIdViaje.Text = idViaje
                            crear_factura(idViaje)
                        Else
                            crear_factura(idViaje)
                        End If
                    End If
                End If
            Next

            crear_encabezado(idDatoFacturacion)


        Else
            lblMensaje.Text = "Primero debe ingresar el numero de factura."

        End If





    End Sub
    Protected Sub crear_encabezado(ByVal id_dato As Integer)
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

        Dim razonSocial = monto.razon_social

        Dim dir = monto.direccion


        ctlFormatoFactura1.crearEncabezado(razonSocial, dir, monto.colonia, state, cp, city, monto.rfc, monto.telefono)

        ctlFormatoFactura1.ponerFecha()
    End Sub

    Protected Sub crear_factura(ByVal id_viaje As String)

        Dim monto = (From consulta In db.viajes, consulta2 In db.datos_facturacions
        Where (consulta.id_viaje = id_viaje And
               consulta.precio.empresa.id_empresa = consulta2.id_empresa
              )
           Select consulta.precio.precio,
           consulta.Ordene.consecutivo,
           consulta.precio.llave_ruta.ruta,
           consulta.precio.llave_ruta.id_ruta,
           consulta.precio.llave_ruta.redondo,
           consulta.precio.factura_dolares,
consulta2.tipo_cambio,
consulta2.retencion,
consulta.precio.id_moneda).First()

        Dim importe As Decimal
        Dim iva As Decimal
        Dim neto As Decimal
        Dim monto_retencion As Decimal

        Dim ruta_ = monto.id_ruta
        Dim ruta1 = String.Empty
        Dim ruta2 = String.Empty
        Dim es_redondo = monto.redondo
        Dim precio_ = 0

        If monto.id_moneda = 5 And Not monto.factura_dolares Then
            lblAnuncio.Visible = True
            txbTc.Text = monto.tipo_cambio.ToString()

            lblTC.Text = " Precio: " + monto.precio.ToString() + " dlls."
            precio_ = monto.precio * monto.tipo_cambio
        Else
            precio_ = monto.precio
        End If

        If es_redondo Then
            If ruta_ = 252 Then
                ruta1 = "Chihuahua-Cd. Juárez"
                ruta2 = "El Paso,Tx-Chihuahua"
                importe = precio_ / 2
            End If

            If ruta_ = 4 Or ruta_ = 404 Then
                ruta1 = "Chihuahua-El Paso,TX"
                ruta2 = "El Paso,TX-Chihuahua"
                importe = precio_ / 2
            End If
        Else
            ruta1 = monto.ruta
            importe = precio_
        End If




        Dim renglon_viaje = String.Empty
        Dim renglon_descripcion = String.Empty
        Dim renglon_importe = String.Empty


        If IsNumeric(precio_) Then
            importe_total += CDec(precio_)
        End If

        If monto.retencion Then
            monto_retencion = importe_total * 0.04
            iva = importe_total * 0.16
            neto = importe_total + iva - monto_retencion
        Else
            monto_retencion = 0
            iva = importe_total * 0.16
            neto = importe_total + iva - monto_retencion
        End If

        If es_redondo Then
            renglon_viaje = String.Format("V - {0}", monto.consecutivo)
            renglon_descripcion = String.Format(" FLETE {0}", ruta1)

            ctlFormatoFactura1.agregarRenglon(renglon_viaje, renglon_descripcion, importe, importe)
            ctlFormatoFactura1.calcularTotal(importe, monto.retencion, monto.factura_dolares)

            renglon_viaje = String.Format("V - {0}", monto.consecutivo)
            renglon_descripcion = String.Format(" FLETE {0}", ruta2)

            ctlFormatoFactura1.agregarRenglon(renglon_viaje, renglon_descripcion, importe, importe)
            ctlFormatoFactura1.calcularTotal(importe, monto.retencion, monto.factura_dolares)

        Else
            renglon_viaje = String.Format("V - {0}", monto.consecutivo)
            renglon_descripcion = String.Format(" FLETE {0}", ruta1)

            ctlFormatoFactura1.agregarRenglon(renglon_viaje, renglon_descripcion, importe, importe)
            ctlFormatoFactura1.calcularTotal(importe, monto.retencion, monto.factura_dolares)

        End If
    End Sub

    Protected Sub btnImprimir_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnImprimir.Click

        Dim folio = txbFolio.Text
        Dim importe = ctlFormatoFactura1.regresarSubtotal()
        Dim iva = ctlFormatoFactura1.regresarIva()
        Dim retencion = ctlFormatoFactura1.regresarRetencion()
        Dim total = ctlFormatoFactura1.regresarTotal()



        Dim idDatoFacturacion = ddlDatoFacturacion.SelectedValue

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
            lblMensaje.Text = "Ocurrió un problema y no se ha registrado la factura, notifiquelo a sistemas."
        End If
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Response.Redirect("~/login.aspx")
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LinkButton1.Click
        Response.Redirect("~/Recepcion/Catalogos/Clientes.aspx")
    End Sub

    


    Protected Sub lnkCancelarOrden_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkCancelarOrden.Click
        btnImprimir.Enabled = True
        Dim cancelar_orden = (From consulta In db.facturacions
                           Where consulta.id_viaje = txbIdViaje.Text And consulta.factura.Cancelada = False
                           Select consulta).First()
        cancelar_orden.factura.Cancelada = True
        db.SubmitChanges()
        lblMensaje.Text = String.Format("El viaje ya no pertenece a la factura {0}. ", cancelar_orden.factura.folio)
        lnkCancelarOrden.Visible = False
    End Sub


    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button2.Click
        ctlFormatoFactura1.limpiar_formulario()

        For i = 0 To CheckBoxList1.Items.Count - 1
            If CheckBoxList1.Items(i).Selected Then
                CheckBoxList1.Items(i).Selected = False
            End If
        Next
    End Sub


   

    Protected Sub lnkSinFactura_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkSinFactura.Click
        Response.Redirect("~/Contabilidad/SinFactura_detalle.aspx")
    End Sub


    Protected Sub ImageButton1_Click1(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim actualizar_tc = (From consulta In db.datos_facturacions
                          Where consulta.empresa.id_empresa = ddlEmpresa.SelectedValue
                          Select consulta).FirstOrDefault()

        If txbTc.Text <> "" Then
            actualizar_tc.tipo_cambio = txbTc.Text
            db.SubmitChanges()

        End If

        ctlFormatoFactura1.limpiar_formulario()

        Dim id_empresa = ddlEmpresa.SelectedValue
        crear_encabezado(id_empresa)
        importe_total = 0

        For i = 0 To CheckBoxList1.Items.Count - 1
            If CheckBoxList1.Items(i).Selected Then
                Dim id_viaje = CheckBoxList1.Items(i).Value
                crear_factura(id_viaje)
            End If
        Next
    End Sub


    
   
End Class