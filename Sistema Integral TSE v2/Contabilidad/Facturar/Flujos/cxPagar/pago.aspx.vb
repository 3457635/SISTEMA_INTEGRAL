Public Class pago
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        Dim id_proveedor = ddlProveedor.SelectedValue
        Dim factura = txbFacturaBuscar.Text

        Dim facturas = From consulta In db.comprobantes_fiscales
                       Where consulta.folio = txbFacturaBuscar.Text
                       Select consulta.gasto.cantidad,
                       consulta.gasto.iva,
                       consulta.folio,
                       consulta.gasto.descripcion,
                       consulta.gasto.id_gasto, consulta.gasto.formas_pago.forma_pago



        ListView1.DataSource = facturas
        ListView1.DataBind()
    End Sub
    Protected Function obtener_proveedor(ByVal id_gasto)

        Dim gasto = id_gasto
        Dim proveedor = (From consulta In db.proveedores_pagos
                         Where consulta.id_gasto = CStr(gasto)
                      Select consulta.empresa.nombre).FirstOrDefault()

        Return proveedor.ToString()
    End Function
    Protected Function programacion_pago(ByVal id_gasto)

        Dim gasto = id_gasto
        Dim fecha = (From consulta In db.proveedores_pagos
                         Where consulta.id_gasto = CStr(gasto)
                      Select consulta.fecha_programacion_pago).FirstOrDefault()

        Return CDate(fecha.ToString()).ToString("dd/MM/yyyy")
    End Function
    Protected Function pago(ByVal id_gasto)

        Dim gasto = id_gasto
        Dim fecha = (From consulta In db.proveedores_pagos
                         Where consulta.id_gasto = CStr(gasto)
                      Select consulta.fecha_pago).FirstOrDefault()
        If Not fecha Is Nothing Then
            Return CDate(fecha.ToString()).ToString("dd/MM/yyyy")
        Else
            Return ""
        End If
    End Function
    Protected Function obtener_neto(ByVal id_gasto)

        Dim gasto = id_gasto
        Dim costo = (From consulta In db.gastos
                         Where consulta.id_gasto = CStr(gasto)
                      Select consulta.cantidad,
                      consulta.iva).FirstOrDefault()

        Dim neto = costo.cantidad
        Return neto

    End Function
    Protected Function obtener_referencia(ByVal id_gasto)

        Dim gasto = id_gasto
        Dim cadena As String
        Dim no_referencia = (From consulta In db.proveedores_pagos
                         Where consulta.id_gasto = CStr(gasto)
                      Select consulta.referencia).FirstOrDefault()
        If Not no_referencia Is Nothing Then
            cadena = no_referencia.ToString
        Else
            cadena = ""
        End If
        Return cadena

    End Function
    Sub Listview1_SelectedIndexChanging(ByVal sender As Object, ByVal e As ListViewSelectEventArgs)
        Dim item As ListViewItem = CType(ListView1.Items(e.NewSelectedIndex), ListViewItem)
        Dim id_gasto As Label = CType(item.FindControl("lblIdGasto"), Label)
        Dim factura As Label = CType(item.FindControl("lblFactura"), Label)
        Dim proveedor As Label = CType(item.FindControl("lblProveedor"), Label)

        Dim referencia As Label = CType(item.FindControl("lblReferencia"), Label)
        Dim importe As Label = CType(item.FindControl("lblImporte"), Label)
        Dim iva As Label = CType(item.FindControl("lblIva"), Label)
        Dim fechaPro As Label = CType(item.FindControl("lblProPago"), Label)
        Dim fechaPago As Label = CType(item.FindControl("lblPago"), Label)


        Dim medio_pago = (From consulta In db.proveedores_pagos
                         Where consulta.id_gasto = id_gasto.Text
                         Select consulta.gasto.id_forma_pago, consulta.id_cuenta).FirstOrDefault()

        If Not medio_pago.id_cuenta Is Nothing And Not medio_pago.id_forma_pago Is Nothing Then
            ddlMedio.SelectedValue = medio_pago.id_forma_pago
            ddlCuenta.SelectedValue = medio_pago.id_cuenta
        End If
        txbIdGasto.Text = id_gasto.Text
        lblProveedor.Text = proveedor.Text
        Dim neto = CDec(importe.Text) + CDec(iva.Text)
        txbProPago.Text = fechaPro.Text
        txbPago.Text = fechaPago.Text
        txbReferencia.Text = referencia.Text
        txbFolio.Text = factura.Text
        txbImporte.Text = importe.Text
        lblIva.Text = iva.Text
        lblTotal.Text = CStr(neto)
        ModalPopupExtender1.Show()
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click

        Dim pago_proveedor = (From consulta In db.proveedores_pagos
                            Where consulta.id_gasto = txbIdGasto.Text
                            Select consulta).First
        pago_proveedor.fecha_pago = txbPago.Text
        pago_proveedor.fecha_programacion_pago = txbProPago.Text
        pago_proveedor.referencia = txbReferencia.Text
        pago_proveedor.id_cuenta = ddlCuenta.SelectedValue
        pago_proveedor.gasto.id_forma_pago = ddlMedio.SelectedValue
        pago_proveedor.gasto.cantidad = txbImporte.Text
        pago_proveedor.gasto.iva = lblIva.Text
        db.SubmitChanges()
        lblMensaje.Text = "Se guardó la información."
    End Sub

    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        ModalPopupExtender1.Hide()
        lblMensaje.Text = ""
    End Sub

    Protected Sub ddlIva_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlIva.SelectedIndexChanged
        If txbImporte.Text <> "" Then
            Dim importe = CDec(txbImporte.Text)
            If IsNumeric(ddlIva.SelectedValue) Then
                Dim iva = CDec(ddlIva.SelectedValue)

                Dim importe_iva = importe * iva

                Dim total = importe + importe_iva

                lblIva.Text = CStr(importe_iva)
                lblTotal.Text = CStr(total)
            End If

        End If
    End Sub

    Protected Sub ddlProveedor_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlProveedor.SelectedIndexChanged
        If String.IsNullOrEmpty(txbFecha1.Text) And String.IsNullOrEmpty(txbFecha2.Text) Then
            Dim facturas = From consulta In db.comprobantes_fiscales, consulta2 In db.gastos, consulta3 In db.proveedores_pagos
                           Where consulta3.id_proveedor = ddlProveedor.SelectedValue And
                           consulta3.fecha_programacion_pago >= txbFecha1.Text And
                           consulta3.fecha_programacion_pago <= txbFecha2.Text And
                           consulta.id_gasto = consulta2.id_gasto And
                           consulta2.id_gasto = consulta3.id_gasto
                           Select consulta.gasto.cantidad,
            consulta.gasto.iva,
            consulta.folio,
            consulta.gasto.descripcion,
            consulta.gasto.id_gasto,
            consulta.gasto.formas_pago.forma_pago



            ListView1.DataSource = facturas
            ListView1.DataBind()
        End If
    End Sub


    Protected Sub ListView1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles ListView1.ItemDataBound
        Dim imgOk As Image = DirectCast(e.Item.FindControl("Image1"), Image)
        Dim id_gasto As Label = DirectCast(e.Item.FindControl("lblIdGasto"), Label)


        Dim fecha = (From consulta In db.proveedores_pagos
                         Where consulta.id_gasto = id_gasto.Text
                      Select consulta.fecha_pago).FirstOrDefault()
        If Not fecha Is Nothing Then
            imgOk.ImageUrl = "~/imagenes/ok.png"
        Else
            imgOk.Visible = False

        End If
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim facturas = From consulta In db.comprobantes_fiscales,
                       consulta2 In db.gastos,
                       consulta3 In db.proveedores_pagos
                      Where
                      consulta3.fecha_programacion_pago >= txbFecha1.Text And
                      consulta3.fecha_programacion_pago <= txbFecha2.Text And
                      consulta.id_gasto = consulta2.id_gasto And
                      consulta2.id_gasto = consulta3.id_gasto
                      Select
                      consulta.gasto.cantidad,
                       consulta.gasto.iva,
                       consulta.folio,
                       consulta.gasto.descripcion,
                       consulta.gasto.id_gasto,
                       consulta.gasto.formas_pago.forma_pago



        ListView1.DataSource = facturas
        ListView1.DataBind()
    End Sub

    Protected Sub ImageButton3_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton3.Click
        Dim facturas = From consulta In db.comprobantes_fiscales,
                       consulta2 In db.gastos,
                       consulta3 In db.proveedores_pagos
                      Where
                      consulta3.empresa.id_empresa = ddlProveedor.SelectedValue And
                      consulta3.fecha_programacion_pago >= txbFecha1.Text And
                      consulta3.fecha_programacion_pago <= txbFecha2.Text And
                    consulta.id_gasto = consulta2.id_gasto And
                    consulta2.id_gasto = consulta3.id_gasto
                    Select consulta.gasto.cantidad,
                       consulta.gasto.iva,
                       consulta.folio,
                       consulta.gasto.descripcion,
                       consulta.gasto.id_gasto,
                       consulta.gasto.formas_pago.forma_pago



        ListView1.DataSource = facturas
        ListView1.DataBind()
    End Sub
End Class