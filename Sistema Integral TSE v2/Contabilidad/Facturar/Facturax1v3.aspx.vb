Imports DGMC.TimbraCFDI
Imports System.Xml
Imports System.Xml.XPath
Imports System.IO
Imports System.Web.HttpPostedFile

Public Class Facturax1v3
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim enDolares As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            cancelarCfdiPendiente()
            ddlEmpresa.Focus()
            Page.Form.Attributes.Add("enctype", "multipart/form-data")
        Else
            If ddlEmpresa.SelectedValue = 500 Then
                If Not String.IsNullOrEmpty(ctrlUpLoads.GetXml()) And
                    Not String.IsNullOrEmpty(ctrlUpLoads.GetPdf()) Then
                    lblMensajeUL.Text = "EXITO: Xml y Pdf fueron cargados exitosamente."
                Else
                    lblMensajeUL.Text = "Debe subir el Xml y Pdf, antes de timbrar."
                End If
            End If
        End If
    End Sub


    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click

        Dim idDatoFacturacion = ddlDatoFacturacion.SelectedValue
        Dim idViaje = ddlEmpresa.SelectedValue
        Dim tipoCambio = txbTc.Text
        actualizarTipoCambio(idDatoFacturacion, tipoCambio)
    End Sub


    Protected Function crear_factura(ByVal enviarCfdi As Boolean)
        Dim folio = obtenerNuevoFolioCFDI()
        Dim exito = False

        ctlFormatoCfdiLineas1.limpiar_formulario()
        lblFolio.Text = folio

        Dim idDato = ddlDatoFacturacion.SelectedValue

        Dim aplicaRetencion = False
        lblMensaje.Text = ""

        ctlFormatoCfdiLineas1.crearEncabezado(idDato)
        Dim facturadaEnDolares = False

        Dim subtotal As Decimal = 0D
        Dim contador As Integer = 0

        btnImprimir.Enabled = True

        If ddlEmpresa.SelectedValue = 500 Then
            btnSubir.Enabled = True
        End If

        For i = 0 To ckbOrdenes.Items.Count - 1
            If ckbOrdenes.Items(i).Selected Then

                Dim id_viaje = ckbOrdenes.Items(i).Value
                Dim idDatoFacturacion = ddlDatoFacturacion.SelectedValue

                Dim factura_anterior = orden_facturada_anteriormente(id_viaje, folio, idDatoFacturacion) ''ver MiLibreria.vb

                Dim monto = (From consulta In db.viajes,
            consulta2 In db.datos_facturacions,
            consulta3 In db.equipo_asignados, _
            consulta4 In db.fechas_viajes
            Where (consulta.id_viaje = id_viaje And consulta.precio.empresa.id_empresa = consulta2.id_empresa _
              And consulta.id_viaje = consulta4.id_viaje And consulta4.fecha.tipo_fecha = 1 _
            And consulta.id_viaje = consulta3.ViajeId And consulta3.equipo_operacion.id_tipo_equipo <> 107)
            Select consulta.precio.precio,
            consulta4.fecha.fecha,
            consulta.Ordene.consecutivo,
            consulta.precio.llave_ruta.ruta,
            consulta3.equipo_operacion.tipo_equipo.equipo,
            consulta3.equipo_operacion.economico,
            consulta3.equipo_operacion.id_tipo_equipo,
            consulta.precio.factura_dolares,
            consulta2.tipo_cambio,
            consulta2.retencion,
            consulta.precio.id_moneda).FirstOrDefault()

                ctlFormatoCfdiLineas1.asignarIvaTraslado(16)

                If Not monto Is Nothing Then
                    Dim caja = String.Empty
                    Dim vehiculo = String.Empty
                    Dim anotacion = String.Empty
                    Dim precioViaje As Decimal

                    If monto.retencion Then
                        ctlFormatoCfdiLineas1.asignarIvaRetenido(4)
                    Else
                        ctlFormatoCfdiLineas1.asignarIvaRetenido(0)
                    End If

                    Dim moneda As String = String.Empty

                    ''si el viaje ya se facturo
                    If factura_anterior <> "" Then
                        'lblMensaje.Text = "Este viaje tiene la factura " + factura_anterior
                        lblMensaje.Text = String.Format("El viaje No. {0} ya tiene la factura {1}", monto.consecutivo, factura_anterior)
                        btnImprimir.Enabled = False
                        btnSubir.Enabled = False
                    End If


                    ''Precio Unitario
                    ''Precio en dolares
                    If monto.id_moneda = 5 Then
                        If Not monto.factura_dolares Then
                            ctlFormatoCfdiLineas1.asignarMoneda(4)

                            lblAnuncio.Visible = True
                            txbTc.Text = monto.tipo_cambio
                            anotacion = "Tipo de Cambio " + txbTc.Text
                            lblTC.Text = " Precio: " + monto.precio.ToString() + " dlls."
                            precioViaje = monto.precio * monto.tipo_cambio

                        Else
                            ctlFormatoCfdiLineas1.asignarMoneda(5)
                            precioViaje = monto.precio
                            facturadaEnDolares = True
                        End If

                    Else ''Precio en pesos
                        ctlFormatoCfdiLineas1.asignarMoneda(4)
                        precioViaje = monto.precio

                    End If

                    ''Tipo de Vehiculo
                    If monto.id_tipo_equipo = 102 Then
                        caja = obtenerCajaUtilizada(id_viaje)
                        If Not String.IsNullOrEmpty(caja) Then
                            vehiculo = String.Format("Trailer {0}", caja)
                        End If
                    Else
                        vehiculo = String.Format("{0} {1}", monto.equipo, monto.economico)
                    End If

                    Dim descripcion = String.Format("Orden: {0} / Ruta: {1} / {2} /Fecha: {3:dd/MM/yyyy}", monto.consecutivo, monto.ruta, vehiculo, monto.fecha)

                    ctlFormatoCfdiLineas1.agregarRenglon(1, descripcion, precioViaje)

                End If
            End If
        Next
        aplicaRetencion = True

        ctlFormatoCfdiLineas1.calcularTotal()
        ctlFormatoCfdiLineas1.Focus()
        Return exito

    End Function


    Protected Sub btnImprimir_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnImprimir.Click

        Dim folioUUID = Nothing
        Dim sinTimbrado = False
        Dim mensaje As String = ""
        Dim fuenteXML As String = ""
        Dim fuentePDF As String = ""
        Dim archivoXml As String = ""
        Dim archivoPdf As String = ""

        lblMensajeUL.Text = ""
        Dim viajeSeleccionado As Boolean = False

        For i = 0 To ckbOrdenes.Items.Count - 1
            If ckbOrdenes.Items(i).Selected Then
                viajeSeleccionado = True
            End If
        Next

        If viajeSeleccionado Then
            ctlFormatoCfdiLineas1.calcularTotal()
            'ctlFormatoCfdiLineas1.calcularTotal(ctlFormatoCfdiLineas1.regresarRetencion.ToString().Replace("$", ""))

            Dim comprobante = ctlFormatoCfdiLineas1.generarComprobante(ddlDatoFacturacion.SelectedValue)

            '' facturación para Penske
            If ddlEmpresa.SelectedValue = 500 Then
                sinTimbrado = True
            End If

            If Not sinTimbrado Then
                folioUUID = ctlFormatoCfdiLineas1.timbrarCFDI(comprobante)
            Else
                archivoXml = ctrlUpLoads.GetXml()
                archivoPdf = ctrlUpLoads.GetPdf()
                If Not String.IsNullOrEmpty(archivoXml) And Not String.IsNullOrEmpty(archivoPdf) Then
                    If Not validaXML(folioUUID, mensaje, comprobante, archivoXml) Then
                        lblMensajeUL.Text = mensaje
                        Return
                    Else
                        Try
                            fuenteXML = Server.MapPath(String.Format("~/Contabilidad/Facturar/temp/{0}-{1}.xml", comprobante.serie, comprobante.folio))
                            fuentePDF = Server.MapPath(String.Format("~/Contabilidad/Facturar/temp/{0}-{1}.pdf", comprobante.serie, comprobante.folio))

                            Dim destinoXML As String = Server.MapPath(String.Format("~/Contabilidad/Facturar/xmls/{0}-{1}.xml", comprobante.serie, comprobante.folio))
                            Dim destinoPDF As String = Server.MapPath(String.Format("~/Contabilidad/Facturar/pdfs/{0}-{1}.pdf", comprobante.serie, comprobante.folio))

                            If File.Exists(fuenteXML) Then
                                File.Delete(fuenteXML)
                            End If
                            FileSystem.Rename(archivoXml, fuenteXML)
                            If File.Exists(fuentePDF) Then
                                File.Delete(fuentePDF)
                            End If
                            FileSystem.Rename(archivoPdf, fuentePDF)

                            System.IO.File.Move(fuenteXML, destinoXML)
                            System.IO.File.Move(fuentePDF, destinoPDF)
                        Catch ex As Exception
                            If File.Exists(Server.MapPath("~/Contabilidad/Facturar/temp/*.xml")) Then
                                File.Delete(Server.MapPath("~/Contabilidad/Facturar/temp/*.xml"))
                            End If
                            If File.Exists(Server.MapPath("~/Contabilidad/Facturar/temp/*.pdf")) Then
                                File.Delete(Server.MapPath("~/Contabilidad/Facturar/temp/*.pdf"))
                            End If
                        End Try
                    End If
                Else
                    lblMensajeUL.Text = "Debe subir el Xml y Pdf, antes de timbrar."
                    lblMensajeUL.Focus()
                    Return
                End If
            End If

            If Not String.IsNullOrEmpty(folioUUID) Then

                Dim idDatoFacturacion As Integer = ddlDatoFacturacion.SelectedValue
                Dim folio = obtenerNuevoFolioCFDI()
                Dim importe = ctlFormatoCfdiLineas1.regresarSubtotal()
                Dim iva = ctlFormatoCfdiLineas1.regresarIva()
                Dim retencion = ctlFormatoCfdiLineas1.regresarRetencion()
                Dim total = ctlFormatoCfdiLineas1.regresarTotal()
                Dim ano = Now.AddHours(-7).Year()
                Dim facturadaEnDolares = ctlFormatoCfdiLineas1.facturaEnDolares()

                If Not sinTimbrado Then
                    btnEnviarCFDI.Enabled = True
                    ctlMail1.llenarFormato(String.Format("Envio de factura {0}.", folio),
                                           String.Format("Envio de factura {0}.", folio),
                                           String.Empty,
                                           String.Format("{0}-{1}.xml", comprobante.serie, folio),
                                           String.Format("{0}-{1}.pdf", comprobante.serie, folio),
                                           folioUUID)

                    Dim contactos() As String = obtenerContactosFacturacion(idDatoFacturacion)

                    ctlMail1.ingresarCorreos(contactos)
                End If

                Dim idFactura = nuevaFactura(folio, importe, idDatoFacturacion, False, iva, retencion, total, facturadaEnDolares, ano, folioUUID)
                If idFactura <> 0 Then
                    For i = 0 To ckbOrdenes.Items.Count - 1
                        If ckbOrdenes.Items(i).Selected Then
                            Dim id_viaje = ckbOrdenes.Items(i).Value
                            Dim errorAlRegistrar = registrarViajeFacturacion(id_viaje, idFactura)

                            If Not String.IsNullOrEmpty(errorAlRegistrar) Then
                                lblMensaje.Text = "Ocurrió un problema al guardar: " + errorAlRegistrar
                                lblMensaje.Focus()
                            End If

                        End If
                    Next

                    lblMensaje.Text = String.Format("Se timbró la factura {0} correctamente.", folio)
                    btnSubir.Enabled = False
                    ctrlUpLoads.LimpiaUpload()
                    lblMensaje.Focus()
                Else
                    lblMensaje.Text = "Ocurrió un problema y no se ha registrado la factura, notifiquelo a sistemas."
                    lblMensaje.Focus()
                End If
            End If
        Else
            lblMensaje.Text = "Debe seleccionar el viaje(s) a facturar."
            lblMensaje.Focus()
        End If
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button2.Click
        Dim folio = lblFolio.Text

        limpiar_formulario(ckbOrdenes)

        ctlFormatoCfdiLineas1.limpiar_formulario()
        ctlFormatoCfdiLineas1.asignarIvaTraslado(16)
        ctlFormatoCfdiLineas1.asignarIvaRetenido(4)
        limpiarCheboxList(ckbOrdenes)
        lblMensajeUL.Text = ""
        ctrlUpLoads.LimpiaUpload()
        lblFolio.Text = folio
    End Sub

    Protected Sub btnCrear_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCrear.Click
        crear_factura(False)
    End Sub

    Protected Sub btnActualizar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnActualizar.Click
        ctlFormatoCfdiLineas1.calcularTotal()
    End Sub

    Public Function validaXML(ByRef folioUUID As String, ByRef mensaje As String, ByVal comprobante As Comprobante, ByVal archivo As String) As Boolean
        Dim exito = True
        folioUUID = ""
        Dim uUIDTemp = ""
        mensaje = ""

        Dim xmlDoc As XmlDocument = New XmlDocument

        If Not File.Exists(archivo) Then
            mensaje = "El archivo xml, no se encuentra cargado." + vbCrLf
            Return False
        End If

        xmlDoc.Load(archivo)
        Dim datos As Dictionary(Of String, String) = ObtenerDatos(xmlDoc)

        If datos("rfcEmisor") <> comprobante.Emisor.rfc Then
            mensaje = "El RFC del emisor no concuerda." + vbCrLf
            exito = False
        End If
        If datos("rfcReceptor") <> comprobante.Receptor.rfc Then
            mensaje = mensaje + "El RFC del receptor no concuerda con el cliente seleccionado." + vbCrLf
            exito = False
        End If

        Dim cant As Decimal = Math.Abs(Convert.ToDecimal(datos("total").Replace("$", "")) - comprobante.total)
        If cant < -1 Or cant > 1 Then
            mensaje = mensaje + "El total de la factura no concuerda con la del cliente." + vbCrLf
            exito = False
        End If

        Dim buscarFactura = (From consulta In db.cfdis
                                   Where consulta.folioFiscal = datos("uuid")
                                   Select consulta).Count()

        If buscarFactura > 0 Then
            mensaje = "La factura ya existe cargada y guardada en el sistema." + vbCrLf
            exito = False
        End If

        If exito Then
            If String.IsNullOrEmpty(datos("uuid")) Then
                mensaje = mensaje + "La factura no contiene el UUID." + vbCrLf
                exito = False
            Else
                folioUUID = datos("uuid")
            End If
        End If

        If exito Then
            mensaje = "La factura fué validada exitosamente."
        End If

        Return exito
    End Function

    Private Function ObtenerDatos(ByVal xml As XmlDocument) As Dictionary(Of String, String)

        Dim valor As String = ""
        Dim prefijo As String = "cfdi:"
        Dim valorBuscado As String = ""

        Dim Datos As New Dictionary(Of String, String)


        ''Obtenemos la version para determinar el prefijo de la factura
        Dim version As Double = Convert.ToDouble(xml.DocumentElement.GetAttribute("version"))
        Datos.Add("version", version.ToString())
        Dim nsmFactura As XmlNamespaceManager = New XmlNamespaceManager(xml.NameTable)
        ''agregamos los namespace para poder acceder a los atributos
        Select Case version.ToString()
            Case "2"
            Case "2.2"
                nsmFactura.AddNamespace("cfd", "http://www.sat.gob.mx/cfd/2")
            Case "3"
            Case "3.2"
                nsmFactura.AddNamespace("cfdi", "http://www.sat.gob.mx/cfd/3")
                nsmFactura.AddNamespace("tfd", "http://www.sat.gob.mx/TimbreFiscalDigital")
        End Select

        Dim navEmisor As XPathNavigator = xml.CreateNavigator()

        Try

            valorBuscado = String.Format("/{0}Comprobante/{0}Emisor/@rfc", prefijo)
            valor = navEmisor.SelectSingleNode(valorBuscado, nsmFactura).Value
            Datos.Add("rfcEmisor", valor)

        Catch
            Datos.Add("rfcEmisor", "")
        End Try
        Try
            valorBuscado = String.Format("/{0}Comprobante/{0}Receptor/@rfc", prefijo)
            valor = navEmisor.SelectSingleNode(valorBuscado, nsmFactura).Value
            Datos.Add("rfcReceptor", valor)

        Catch
            Datos.Add("rfcReceptor", "")
        End Try
        Try
            valorBuscado = String.Format("/{0}Comprobante/{0}Complemento/tfd:TimbreFiscalDigital/@UUID", prefijo)
            valor = navEmisor.SelectSingleNode(valorBuscado, nsmFactura).Value
            Datos.Add("uuid", valor)
        Catch
            Datos.Add("uuid", "")
        End Try

        Try
            valorBuscado = String.Format("/{0}Comprobante/@serie", prefijo)
            valor = navEmisor.SelectSingleNode(valorBuscado, nsmFactura).Value
            Datos.Add("serie", valor)
        Catch
            Datos.Add("serie", "N/A")
        End Try

        Try
            valorBuscado = String.Format("/{0}Comprobante/@fecha", prefijo)
            valor = navEmisor.SelectSingleNode(valorBuscado, nsmFactura).Value
            Datos.Add("fecha", valor)

        Catch
            Datos.Add("fecha", "")
        End Try

        Try
            valorBuscado = String.Format("/{0}Comprobante/@folio", prefijo)
            valor = navEmisor.SelectSingleNode(valorBuscado, nsmFactura).Value
            Datos.Add("folio", valor)

        Catch
            Datos.Add("folio", "")
        End Try

        Try
            valorBuscado = String.Format("/{0}Comprobante/@total", prefijo)
            valor = (Convert.ToDouble(navEmisor.SelectSingleNode(valorBuscado, nsmFactura).Value)).ToString("c2").Replace("¤", "$")
            Datos.Add("total", valor)
        Catch
            Datos.Add("total", "")
        End Try

        Try
            valorBuscado = String.Format("/{0}Comprobante/@Moneda", prefijo)
            valor = navEmisor.SelectSingleNode(valorBuscado, nsmFactura).Value
            Datos.Add("moneda", valor)
        Catch
            Datos.Add("moneda", "")
        End Try

        Return Datos
    End Function

    Private Sub Facturax1v3_PreRenderComplete(sender As Object, e As EventArgs) Handles Me.PreRenderComplete
        If ddlEmpresa.SelectedValue = 500 Then
            If Not String.IsNullOrEmpty(ctrlUpLoads.GetXml()) And
                Not String.IsNullOrEmpty(ctrlUpLoads.GetPdf()) Then
                lblMensajeUL.Text = "EXITO: Xml y Pdf fueron cargados exitosamente."
            Else
                lblMensajeUL.Text = "Debe subir el Xml y Pdf, antes de timbrar."
            End If
        End If
    End Sub

    Protected Sub RadioButtonList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles RadioButtonList1.SelectedIndexChanged
        If RadioButtonList1.SelectedIndex = 2 Then

            ckbOrdenes.DataSourceID = "sdsOrdenes2"
        Else
            ckbOrdenes.DataSourceID = "sdsOrdenes"
        End If
    End Sub
End Class