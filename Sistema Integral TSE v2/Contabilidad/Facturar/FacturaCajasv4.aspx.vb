Imports DGMC.TimbraCFDI

Public Class FacturaCajasv4
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim facturadaEnDolares As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim actualias_tc = (From consulta In db.precios_cajas
                           Where consulta.id_cliente = ddlCliente.SelectedValue
                           Select consulta).FirstOrDefault()
        actualias_tc.tipo_cambio = txbTc.Text
        db.SubmitChanges()
        lblMensaje.Text = "Se actualizó el tipo de cambio. Genere nuevamente la factura."
    End Sub

    Public Function crearFactura(ByVal enviarCFDI As Boolean) As Boolean
        ctlCfdiLineas1.limpiar_formulario()
        ctlCfdiLineas1.asignarIvaTraslado(16)
        ctlCfdiLineas1.asignarIvaRetenido(0)
        ctlCfdiLineas1.crearEncabezado(ddlFacturacion.SelectedValue)

        lblMensaje.Text = ""
        Dim exito = False
        lblFactura.Text = obtenerNuevoFolioCFDI()
        Dim folio = lblFactura.Text

        Dim Ultima_factura = (From consulta In db.facturas_cajas
                          Where consulta.id_renta = rbtnOrdenesCajas.SelectedValue And
                          consulta.factura.Cancelada = False
                          Select consulta
                          Order By consulta.id_factura Descending).FirstOrDefault()


        Dim f_inicio As Date
        Dim f_fin As Date
        Dim salir As Boolean = False

        If Not String.IsNullOrEmpty(txbInicio.Text) And Not String.IsNullOrEmpty(txbFin.Text) Then
            f_inicio = txbInicio.Text
            f_fin = txbFin.Text
        Else
            lblMensaje.Text = "Ingrese la fecha."
            salir = True
        End If


        ''Verificamos si ya se facturaron esos dias de renta anteriormente
        If Not Ultima_factura Is Nothing And Not salir Then
            facturadaEnDolares = Ultima_factura.orden_caja.precios_caja.factura_dolares
            If f_inicio.Date <= Ultima_factura.fin And
                lblFactura.Text <> Ultima_factura.factura.folio Then

                lblMensaje.Text = "Hay dias que ya se facturaron anteriormente en la factura " + Ultima_factura.factura.folio.ToString()
                btnTimbrar.Enabled = False

                salir = False

            End If
        End If

        If Not salir Then ''Si no se facturaron esos dias anteriormente

            btnTimbrar.Enabled = True

            Dim aplicaRetencion = False

            Dim datos_caja = (From consulta In db.orden_cajas
                           Where consulta.id_renta = rbtnOrdenesCajas.SelectedValue
                           Select consulta
                           ).FirstOrDefault()

            If Not datos_caja Is Nothing Then

                Dim buscarPrecioCaja = (From consulta In db.orden_cajas
                                     Where consulta.precios_caja.id_precio_caja = datos_caja.id_precio
                                     Select consulta).FirstOrDefault()


                If Not buscarPrecioCaja Is Nothing Then
                    Dim cantidad = 1
                    Dim descripcion = String.Empty
                    Dim precio_unitario As Decimal = 0
                    Dim importe As Decimal = 0
                    Dim precioXmes = ckbPrecioMes.Checked


                    If precioXmes Then
                        lblFrecuencia.Text = "Mes"
                        lblPrecio.Text = String.Format("{0:c2}", buscarPrecioCaja.precios_caja.precioXmes)
                    Else
                        lblFrecuencia.Text = "Día"
                        lblPrecio.Text = String.Format("{0:c2}", buscarPrecioCaja.precios_caja.precioDiario)
                    End If
                    ''Llenamos la descripcion
                    descripcion = String.Format("Almacenaje de Caja No.{0}", datos_caja.equipo_operacion.economico)
                    descripcion += String.Format(" Correspondiente del {0}/{1:MMM}/{2} al {3}/{4:MMM}/{5}", f_inicio.Day, f_inicio, f_inicio.Year, f_fin.Day, f_fin, f_fin.Year)

                    Dim buscar_tipo_moneda = (From consulta In db.precios_cajas
                                      Where consulta.id_cliente = ddlCliente.SelectedValue
                                      Select consulta.id_moneda, consulta.factura_dolares, consulta.tipo_cambio).FirstOrDefault()

                    ''Cantidad de dias a facturar
                    Dim dias = DateDiff(DateInterval.Day, f_inicio, f_fin)
                    lblDias.Text = CStr(dias)

                    '4 Pesos
                    '5 Dolares
                    If Not buscar_tipo_moneda Is Nothing Then

                        'factura en pesos
                        If Not buscar_tipo_moneda.factura_dolares Then
                            'si la moneda son dolares
                            If buscar_tipo_moneda.id_moneda = 5 Then
                                If Not String.IsNullOrEmpty(txbTc.Text) Then

                                    If precioXmes Then
                                        importe = datos_caja.precios_caja.precioXmes * CDec(txbTc.Text) ''Convertimos a pesos
                                    Else
                                        importe = datos_caja.precios_caja.precioDiario * dias * CDec(txbTc.Text) ''Convertimos a pesos
                                    End If
                                    ctlCfdiLineas1.asignarMoneda(4)
                                Else
                                    lblMensaje.Text = "Registre el tipo de cambio."
                                End If
                                'moneda en pesos y factura en pesos
                            Else
                                If precioXmes Then
                                    importe = datos_caja.precios_caja.precioXmes
                                Else
                                    importe = datos_caja.precios_caja.precioDiario * dias
                                End If

                                ctlCfdiLineas1.asignarMoneda(4)

                            End If

                        Else 'factura en dolares y moneda en dolares
                            If buscar_tipo_moneda.id_moneda = 5 Then
                                If precioXmes Then
                                    importe = datos_caja.precios_caja.precioXmes
                                Else
                                    importe = datos_caja.precios_caja.precioDiario * dias
                                End If

                                facturadaEnDolares = True
                                ctlCfdiLineas1.asignarMoneda(5)

                            Else 'factura en dolares y moneda en pesos
                                If Not String.IsNullOrEmpty(txbTc.Text) Then
                                    If precioXmes Then
                                        importe = datos_caja.precios_caja.precioXmes / CDec(txbTc.Text) ''Convertimos a pesos
                                    Else
                                        importe = datos_caja.precios_caja.precioDiario * dias / CDec(txbTc.Text) ''Convertimos a pesos
                                    End If

                                    ctlCfdiLineas1.asignarMoneda(4)
                                Else
                                    lblMensaje.Text = "Registre el tipo de cambio."
                                End If
                            End If

                        End If
                        'lblPrecio.Text = datos_caja.precios.ToString() + " " + datos_caja.moneda.ToString()
                    End If

                    ctlCfdiLineas1.agregarRenglon(cantidad, descripcion, importe)

                    ctlCfdiLineas1.calcularTotal()

                End If
            End If

        End If

        Return exito
    End Function

    Protected Sub ddlCliente_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCliente.SelectedIndexChanged
        Dim buscar_tipo_moneda = (From consulta In db.precios_cajas
                               Where consulta.id_cliente = ddlCliente.SelectedValue
                               Select consulta.id_moneda, consulta.factura_dolares, consulta.tipo_cambio).FirstOrDefault()
        If Not buscar_tipo_moneda Is Nothing Then
            If buscar_tipo_moneda.id_moneda = 5 Then
                If Not buscar_tipo_moneda.factura_dolares Then
                    txbTc.Text = CStr(buscar_tipo_moneda.tipo_cambio)
                Else
                    txbTc.Text = ""
                End If
            End If

        End If


    End Sub

    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles rbtnOrdenesCajas.SelectedIndexChanged
        Dim Ultima_factura = (From consulta In db.facturas_cajas
                           Where consulta.id_renta = rbtnOrdenesCajas.SelectedValue And consulta.factura.Cancelada = 0
                           Select consulta Order By consulta.id_factura Descending).FirstOrDefault()


        If Ultima_factura Is Nothing Then
            lblUltimaFecha.Text = "No hay factura anterior de esta renta."
            Dim fecha_orden = (From consulta In db.orden_cajas
                            Where consulta.id_renta = rbtnOrdenesCajas.SelectedValue
                            Select consulta.Inicio).FirstOrDefault()

            txbInicio.Text = fecha_orden
        Else
            lblUltimaFecha.Text = Ultima_factura.fin
            txbInicio.Text = Ultima_factura.fin.Value.Date.AddDays(1)
            txbFin.Text = Ultima_factura.fin.Value.Date.AddDays(31)
        End If






    End Sub

    Protected Sub btnGenerar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGenerar.Click
        crearFactura(False)
    End Sub

    Protected Sub btnTimbrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnTimbrar.Click

        
        Dim comprobante = ctlCfdiLineas1.generarComprobante(ddlFacturacion.SelectedValue)
        Dim folioUUID = ctlCfdiLineas1.timbrarCFDI(comprobante)
        Dim folio = obtenerNuevoFolioCFDI()

        If Not String.IsNullOrEmpty(folioUUID) Then

            btnCorreo.Enabled = True
            ctlMail1.llenarFormato(String.Format("Envio de factura {0}.", folio),
                                   String.Format("Envio de factura {0}.", folio),
                                   String.Empty,
                                   String.Format("{0}-{1}.xml", comprobante.serie, folio),
                                   String.Format("{0}-{1}.pdf", comprobante.serie, folio),
                                   folioUUID)

            Dim idDato = ddlFacturacion.SelectedValue

            Dim contactos() As String = obtenerContactosFacturacion(idDato)

            ctlMail1.ingresarCorreos(contactos)



            Dim importe = ctlCfdiLineas1.regresarSubtotal
            Dim iva = ctlCfdiLineas1.regresarIva
            Dim retencion = ctlCfdiLineas1.regresarRetencion
            Dim total = ctlCfdiLineas1.regresarTotal
            Dim idDatoFacturacion = ddlFacturacion.SelectedValue
            Dim ano = Now.AddHours(-7).Year()

            Dim idFactura = nuevaFactura(folio, importe, idDatoFacturacion, False, iva, retencion, total, facturadaEnDolares, ano, folioUUID)

            If idFactura <> 0 Then
                Dim caja_facturada As New facturas_caja With {.id_factura = idFactura,
                                                              .inicio = txbInicio.Text,
                                                              .fin = txbFin.Text,
                                                              .id_renta = rbtnOrdenesCajas.SelectedValue
                                                              }

                db.facturas_cajas.InsertOnSubmit(caja_facturada)
                db.SubmitChanges()
            End If

        End If
            



    End Sub


    Protected Sub btnActualizar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnActualizar.Click
        ctlCfdiLineas1.calcularTotal()
    End Sub
End Class