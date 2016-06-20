Imports DGMC.TimbraCFDI

Public Class FacturaCajasv3
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim facturadaEnDolares As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        lnkSinFactura.Text = obtenerViajesSinFactura()
    End Sub


    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim actualias_tc = (From consulta In db.precios_cajas
                           Where consulta.id_cliente = ddlCliente.SelectedValue
                           Select consulta).FirstOrDefault()
        actualias_tc.tipo_cambio = txbTc.Text
        db.SubmitChanges()
        lblMensaje.Text = "Se actualizó el tipo de cambio. Genere nuevamente la factura."
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Response.Redirect("~/login.aspx")
    End Sub



    Protected Sub lnkSinFactura_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkSinFactura.Click
        Response.Redirect("~/Contabilidad/SinFactura_detalle.aspx")
    End Sub

    Public Function crearFactura(ByVal enviarCFDI As Boolean) As Boolean
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

        ctlFormatoCFDI1.limpiar_formulario()

        If Not salir Then ''Si no se facturaron esos dias anteriormente

            btnTimbrar.Enabled = True

            Dim aplicaRetencion = False

            Dim comprobante As New Comprobante()
            comprobante.serie = Now.AddHours(-7).Year()
            comprobante.fecha = DateTime.Now().AddHours(-7)
            comprobante.folio = folio
            comprobante.formaDePago = ddlFormaPago.SelectedValue
            comprobante.metodoDePago = ddlMetodoPago.SelectedValue
            'TIPO DE COMPROBANTE 
            'Ingreso: Factura 1, Rec honorarios 4, rec de arrendamiento 5, Rec donativos 7, Nota de cargo 3
            'Egreso: Nota de credito 2
            'Traslado: Carta porte  6
            comprobante.tipoDeComprobante = ComprobanteTipoDeComprobante.ingreso
            comprobante.LugarExpedicion = "Mexico, Chihuahua, Chih."

            'Llenamos datos del emisor'
            comprobante.Emisor = New ComprobanteEmisor
            'produccion
            comprobante.Emisor.rfc = "CALL630921V68"
            comprobante.Emisor.nombre = "Luis Carlos Chavez Loya"

            'prueba
            'comprobante.Emisor.rfc = "AAA010101AAA"

            'Llenamos domicilio fiscal del emisor'
            comprobante.Emisor.DomicilioFiscal = New t_UbicacionFiscal
            comprobante.Emisor.DomicilioFiscal.calle = "Av. Octavio Paz"
            comprobante.Emisor.DomicilioFiscal.noExterior = "170"
            comprobante.Emisor.DomicilioFiscal.colonia = "Complejo Industrial Chihuahua"
            comprobante.Emisor.DomicilioFiscal.municipio = "Chihuahua"
            comprobante.Emisor.DomicilioFiscal.estado = "Chihuahua"
            comprobante.Emisor.DomicilioFiscal.pais = "Mexico"
            comprobante.Emisor.DomicilioFiscal.codigoPostal = "31109"

            'Llenamos regimen fiscal del emisor'
            Dim regimenFiscal(0) As ComprobanteEmisorRegimenFiscal
            regimenFiscal(0) = New ComprobanteEmisorRegimenFiscal
            regimenFiscal(0).Regimen = "Regimen general de ley personas fisicas."
            comprobante.Emisor.RegimenFiscal = regimenFiscal

            Dim datos = (From consulta In db.datos_facturacions
                                         Where consulta.id_dato = ddlFacturacion.SelectedValue
                                         Select consulta).FirstOrDefault()
            ''Llenamos la informacion de la empresa
            If Not datos Is Nothing Then

                Dim razonSocial = datos.razon_social
                Dim calle = datos.calle
                Dim cp = datos.c_postal
                Dim col = datos.colonia
                Dim estado = datos.estado
                Dim municipio = datos.municipio
                Dim noExterior = datos.noExterior
                Dim pais = datos.pais
                Dim rfc = datos.rfc

                'Llena datos del receptor
                comprobante.Receptor = New ComprobanteReceptor
                comprobante.Receptor.rfc = rfc
                comprobante.Receptor.nombre = razonSocial

                comprobante.Receptor.Domicilio = New t_Ubicacion
                comprobante.Receptor.Domicilio.calle = calle
                comprobante.Receptor.Domicilio.codigoPostal = cp
                comprobante.Receptor.Domicilio.colonia = col
                comprobante.Receptor.Domicilio.estado = estado
                comprobante.Receptor.Domicilio.municipio = municipio
                comprobante.Receptor.Domicilio.noExterior = noExterior
                comprobante.Receptor.Domicilio.pais = pais
                ctlFormatoCFDI1.crearEncabezado(razonSocial, col, estado, cp, municipio, rfc, String.Empty, calle, noExterior)

            End If

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
                    descripcion = String.Format("Renta de Caja No.{0}", buscarPrecioCaja.equipo_operacion.economico)
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
                                    comprobante.Moneda = "Pesos"
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

                                comprobante.Moneda = "Pesos"

                            End If

                        Else 'factura en dolares y moneda en dolares
                            If buscar_tipo_moneda.id_moneda = 5 Then
                                If precioXmes Then
                                    importe = datos_caja.precios_caja.precioXmes
                                Else
                                    importe = datos_caja.precios_caja.precioDiario * dias
                                End If

                                facturadaEnDolares = True
                                comprobante.TipoCambio = "Dolares"

                            Else 'factura en dolares y moneda en pesos
                                If Not String.IsNullOrEmpty(txbTc.Text) Then
                                    If precioXmes Then
                                        importe = datos_caja.precios_caja.precioXmes / CDec(txbTc.Text) ''Convertimos a pesos
                                    Else
                                        importe = datos_caja.precios_caja.precioDiario * dias / CDec(txbTc.Text) ''Convertimos a pesos
                                    End If

                                    comprobante.Moneda = "Dolares"
                                Else
                                    lblMensaje.Text = "Registre el tipo de cambio."
                                End If
                            End If

                        End If
                        'lblPrecio.Text = datos_caja.precios.ToString() + " " + datos_caja.moneda.ToString()
                    End If

                    Dim conceptos(0) As ComprobanteConcepto
                    conceptos(0) = New ComprobanteConcepto
                    conceptos(0).cantidad = cantidad
                    conceptos(0).unidad = "No Aplica"
                    conceptos(0).noIdentificacion = buscarPrecioCaja.equipo_operacion.economico
                    conceptos(0).descripcion = descripcion
                    conceptos(0).valorUnitario = importe
                    conceptos(0).importe = importe * cantidad

                    ctlFormatoCFDI1.agregarRenglon(cantidad, descripcion, importe, importe * cantidad)

                    ctlFormatoCFDI1.calcularTotal(importe, False, facturadaEnDolares)

                    Dim subtotal = ctlFormatoCFDI1.regresarSubtotal
                    Dim iva = ctlFormatoCFDI1.regresarIva
                    Dim retencion = ctlFormatoCFDI1.regresarRetencion
                    Dim total = ctlFormatoCFDI1.regresarTotal

                    comprobante.subTotal = subtotal
                    comprobante.total = total

                    'Llenamos impuestos'
                    Dim impuestosTrasladados(0) As ComprobanteImpuestosTraslado
                    impuestosTrasladados(0) = New ComprobanteImpuestosTraslado
                    impuestosTrasladados(0).importe = iva
                    impuestosTrasladados(0).impuesto = ComprobanteImpuestosTrasladoImpuesto.IVA
                    impuestosTrasladados(0).tasa = 16

                    'Dim impuestosRetenidos(0) As ComprobanteImpuestosRetencion
                    'impuestosRetenidos(0) = New ComprobanteImpuestosRetencion
                    'impuestosRetenidos(0).impuesto = ComprobanteImpuestosRetencionImpuesto.IVA
                    'impuestosRetenidos(0).importe = retencionIva

                    'Agregamos impuestos'
                    comprobante.Impuestos = New ComprobanteImpuestos
                    comprobante.Impuestos.Traslados = impuestosTrasladados
                    'comprobante.Impuestos.Retenciones = impuestosRetenidos
                    'comprobante.Impuestos.totalImpuestosTrasladados = iva - retencionIva
                    comprobante.Impuestos.totalImpuestosTrasladadosSpecified = False
                    comprobante.Impuestos.totalImpuestosRetenidosSpecified = False

                    comprobante.Conceptos = conceptos

                    If enviarCFDI Then
                        Dim resultaTimbrado As TSE.Timbrado.ResultadoTimbre = ctlFormatoCFDI1.generaCFDI(comprobante)
                        If Not resultaTimbrado Is Nothing Then

                            lblFolioFiscal.Text = resultaTimbrado.FolioUUID

                            If ctlFormatoCFDI1.generarPdf(comprobante, resultaTimbrado, facturadaEnDolares, False) Then
                                exito = True
                                btnCorreo.Enabled = True
                                ctlMail1.llenarFormato(String.Format("Envio de factura {0}.", folio),
                                                       String.Format("Envio de factura {0}.", folio),
                                                       String.Empty,
                                                       String.Format("{0}-{1}.xml", comprobante.serie, folio),
                                                       String.Format("{0}-{1}.pdf", comprobante.serie, folio),
                                                       resultaTimbrado.FolioUUID)

                                Dim idDato = ddlFacturacion.SelectedValue

                                Dim contactos() As String = obtenerContactosFacturacion(idDato)

                                ctlMail1.ingresarCorreos(contactos)
                            End If
                        End If
                    End If
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
        If crearFactura(True) Then

            Dim folio = lblFactura.Text


            Dim importe = ctlFormatoCFDI1.regresarSubtotal
            Dim iva = ctlFormatoCFDI1.regresarIva
            Dim retencion = ctlFormatoCFDI1.regresarRetencion
            Dim total = ctlFormatoCFDI1.regresarTotal
            Dim idDatoFacturacion = ddlFacturacion.SelectedValue
            Dim ano = Now.AddHours(-7).Year()
            Dim folioFiscal = lblFolioFiscal.Text

            Dim idFactura = nuevaFactura(folio, importe, idDatoFacturacion, False, iva, retencion, total, facturadaEnDolares, ano, folioFiscal)

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


End Class