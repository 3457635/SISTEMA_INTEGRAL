Public Class notaDeCredito
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ctlCfdiLineas1.asignarTipoComprobante(1)
        End If
    End Sub

    Protected Sub btnGenerar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGenerar.Click

        ctlCfdiLineas1.crearEncabezado(ddlCliente.SelectedValue)


        Dim descripcion = "Crédito aplicado a las facturas "

        Dim contador = 0
        For i = 0 To ckbFacturas.Items.Count - 1
            If ckbFacturas.Items(i).Selected Then
                contador += 1
                hfldCantidadFacturas.Value = contador
                descripcion += ckbFacturas.Items(i).Text + " / "
            End If
        Next

        ctlCfdiLineas1.agregarRenglon(1, descripcion, 0.0)

    End Sub

    Protected Sub btnActualizarImporte_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnActualizarImporte.Click
        ctlCfdiLineas1.calcularTotal()
    End Sub

    Protected Sub btnTimbrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnTimbrar.Click
        Dim comprobante = ctlCfdiLineas1.generarComprobante(ddlCliente.SelectedValue)
        Dim folioUUID = ctlCfdiLineas1.timbrarCFDI(comprobante)

        Dim folio = obtenerFolioNotaCredito()
        Dim importe = ctlCfdiLineas1.regresarSubtotal()
        Dim iva = ctlCfdiLineas1.regresarIva()
        Dim retencion = ctlCfdiLineas1.regresarRetencion()
        Dim total = ctlCfdiLineas1.regresarTotal()
        Dim facturaEnDolares = ctlCfdiLineas1.facturaEnDolares()
        Dim idFactura = 0

        If Not String.IsNullOrEmpty(folioUUID) Then

            Dim nuevaNotaCredito As New notasCredito With {.cancelada = 0,
                                                           .facturadaDolares = facturaEnDolares,
                                                           .folio = 1,
                                                           .importe = importe,
                                                           .fecha = Now.AddHours(-7),
                                                           .iva = iva,
                                                           .retencion = retencion,
                                                           .total = total,
                                                           .folioFiscal = folioUUID}
            db.notasCreditos.InsertOnSubmit(nuevaNotaCredito)

            Dim totalPorFactura = 1
            If IsNumeric(hfldCantidadFacturas.Value) Then
                totalPorFactura = total / hfldCantidadFacturas.Value
            End If


            For i = 0 To ckbFacturas.Items.Count - 1
                If ckbFacturas.Items(i).Selected Then

                    idFactura = ckbFacturas.SelectedValue
                    Dim nuevoCreditoFactura As New facturasConCredito With {.idFactura = idFactura,
                                                                            .notasCredito = nuevaNotaCredito}
                    Dim buscarSaldoFactura = (From consulta In db.facturas
                                           Where consulta.id_factura = idFactura
                                           Select consulta).FirstOrDefault()

                    If Not buscarSaldoFactura Is Nothing Then
                        buscarSaldoFactura.saldo -= totalPorFactura
                    End If
                End If
            Next


            db.SubmitChanges()

        End If
    End Sub
End Class