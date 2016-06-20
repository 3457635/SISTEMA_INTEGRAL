Public Class Facturax1b2A
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
                numeroLinea = 1
            End If

            'Renglon 2
            If entrar Then
                If txbRelacion2.Text = "" Or txbRelacion2.Text = servicio Then
                    entrar = False
                    txbRelacion2.Text = servicio
                    numeroLinea = 2
                End If
            End If

            'Renglon 3
            If entrar Then
                If txbRelacion3.Text = "" Or txbRelacion3.Text = servicio Then
                    entrar = False
                    txbRelacion3.Text = servicio
                    numeroLinea = 3
                End If
            End If

            'Renglon 4
            If entrar Then
                If txbRelacion4.Text = "" Or txbRelacion4.Text = servicio Then
                    entrar = False
                    txbRelacion4.Text = servicio
                    numeroLinea = 4
                End If
            End If

            'Renglon 5
            If entrar Then
                If txbRelacion5.Text = "" Or txbRelacion5.Text = servicio Then
                    entrar = False
                    txbRelacion5.Text = servicio
                    numeroLinea = 5
                End If
            End If

            'Renglon 6
            If entrar Then
                If txbRelacion6.Text = "" Or txbRelacion6.Text = servicio Then
                    entrar = False
                    txbRelacion6.Text = servicio
                    numeroLinea = 6
                End If
            End If

            llenarLinea(numeroLinea, descripcion, precioViaje, True)
        Else
            lblMensaje.Text = "Ocurrió un problema con una de las ordenes de servicio selecionada."
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

    Protected Sub btnImprimir_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnImprimir.Click


        Dim idDatoFacturacion = ddlDatoFacturacion.SelectedValue
        Dim folio = lblFolio.Text

        Dim total = ctlFormatoFacturaAmericana1.obtenertotal()

        Dim idFactura = nuevaFactura(folio, total, idDatoFacturacion, True, iva, retencion, total, True)

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

        Response.Redirect("~/Contabilidad/Facturar/Facturax1b2A.aspx")
    End Sub

    Protected Sub lnkCancelarOrden_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkCancelarOrden.Click
        btnImprimir.Enabled = True
        Dim idViaje = txbIdViaje.Text
        cancelarFactura(idViaje)

        lblMensaje.Text = String.Format("Se canceló la factura anterior. ")
        lnkCancelarOrden.Visible = False

    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button2.Click
        'ctlFormatoFactura1.limpiar_formulario()
        Response.Redirect("~/Contabilidad/Facturar/Facturar1b2A.aspx")
    End Sub

    

    Protected Sub lnkSinFactura_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkSinFactura.Click
        Response.Redirect("~/Contabilidad/SinFactura_detalle.aspx")
    End Sub


    Protected Sub ImageButton1_Click1(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click

        Dim folio = lblFolio.Text

        Dim idDato = ddlDatoFacturacion.SelectedValue

        ctlFormatoFacturaAmericana1.limpiarFormulario()
        limpiar_formulario(form1)
        lblFolio.Text = folio
        crear_encabezado(idDato)

        Me.subtotal = 0
        For i = 0 To CheckBoxList1.Items.Count - 1
            If CheckBoxList1.Items(i).Selected Then
                Dim id_viaje = CheckBoxList1.Items(i).Value

                lblMensaje.Text = ""
                txbIdViaje.Text = id_viaje
                Dim repetida = factura_utilizada_anteriormente(folio, id_viaje)
                If repetida = "1" Then
                    btnImprimir.Enabled = True

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

        Dim neto_string = ctlFormatoFacturaAmericana1.obtenertotal()
        Dim cantidad_letra As String = Letras(String.Format("{0:f2}", CType(neto_string, Decimal)), True)
        ctlFormatoFacturaAmericana1.ponerCantidadConLetra(StrConv(cantidad_letra, VbStrConv.Uppercase))
    End Sub
End Class