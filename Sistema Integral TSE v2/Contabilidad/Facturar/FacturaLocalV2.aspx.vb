Imports DGMC.TimbraCFDI
Public Class FacturaLocalV2
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Function orden_facturada_anteriormente(ByVal id_viaje As Integer, ByVal factura As Integer)
        Dim cancelar As String = ""



        Dim factura_anterior = (From consulta In db.facturacions
                             Where consulta.factura.Cancelada = False And consulta.id_viaje = id_viaje
                             Select consulta).FirstOrDefault()

        If Not factura_anterior Is Nothing Then
            If factura <> factura_anterior.factura.folio Then
                cancelar = factura_anterior.factura.folio
            End If
        End If
        Return cancelar
    End Function

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNueva.Click
        ctlCFDILineas1.limpiar_formulario()
    End Sub



    Protected Sub btnCrear_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCrear.Click

        lblMensaje.Text = ""

        lblFolio.Text = obtenerNuevoFolioCFDI()

        ctlCFDILineas1.crearEncabezado(ddlDatoFacturacion.SelectedValue)
        btnTimbrar.Enabled = True

    End Sub


    Protected Sub btnTimbrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnTimbrar.Click
        ctlCFDILineas1.calcularTotal()

        Dim nuevoComprobante = ctlCFDILineas1.generarComprobante(ddlDatoFacturacion.SelectedValue)
        Dim FolioFiscal = ctlCFDILineas1.timbrarCFDI(nuevoComprobante)

        If Not String.IsNullOrEmpty(FolioFiscal) Then
            Dim idDato = ddlDatoFacturacion.SelectedValue
            Dim folio = obtenerNuevoFolioCFDI()
            Dim importe = ctlCFDILineas1.regresarSubtotal()
            Dim iva = ctlCFDILineas1.regresarIva()
            Dim retencion = ctlCFDILineas1.regresarRetencion()
            Dim total = ctlCFDILineas1.regresarTotal()
            Dim ano = Now.AddHours(-7).Year()
            
            Dim conceptos = ctlCFDILineas1.regresarDescripciones()


            Dim idFactura = nuevaFactura(folio, importe, idDato, False, iva, retencion, total, False, ano, FolioFiscal)

            If idFactura > 0 Then
                For Each c In conceptos

                    Dim nuevoConcepto As New wcfRef1.facturasOtro
                    nuevoConcepto.concepto = c
                    nuevoConcepto.idFactura = idFactura
                    proxy.crearFacturaOtros(nuevoConcepto)

                Next

                lblMensaje.Text = String.Format("Se timbró la factura {0} correctamente.", folio)

                ctlMail1.llenarFormato(String.Format("Envio de factura {0}.", folio),
                                           String.Format("Envio de factura {0}.", folio),
                                           String.Empty,
                                           String.Format("{0}-{1}.xml", nuevoComprobante.serie, folio),
                                           String.Format("{0}-{1}.pdf", nuevoComprobante.serie, folio),
                                           FolioFiscal)

                Dim contactos() As String = obtenerContactosFacturacion(idDato)

                ctlMail1.ingresarCorreos(contactos)
            Else
                lblMensaje.Text = "No se creó la factura correctamente."
            End If
            
            
        End If
    End Sub

   

    Protected Sub btnActualizarImporte_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnActualizarImporte.Click
        ctlCFDILineas1.calcularTotal()
    End Sub
End Class