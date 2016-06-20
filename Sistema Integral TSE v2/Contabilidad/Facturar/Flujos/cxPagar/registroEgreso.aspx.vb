Public Class registroEgreso
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim tot As Decimal
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        Dim tipoConsulta = rbtnOpciones.SelectedValue
        If Not String.IsNullOrEmpty(txbFolio.Text) Then
            tipoConsulta = 5
        End If
        sdsEgresos.SelectParameters(0).DefaultValue = tipoConsulta
        If ddlProveedor.SelectedValue <> 0 Then
            sdsEgresos.SelectParameters(3).DefaultValue = ddlProveedor.SelectedValue
        Else
            sdsEgresos.SelectParameters(3).DefaultValue = Nothing
        End If

    End Sub

    Protected Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs)
        'For i = 0 To grdEgresos.Rows.Count - 1 Step 1

        '    Dim grdFacturas As GridViewRow = grdEgresos.Rows(i)
        '    Dim ckbFactura As CheckBox = grdFacturas.FindControl("ckbFactura")

        '    If ckbFactura.Checked Then
        '        ckbFactura.Checked = False
        '    Else
        '        ckbFactura.Checked = True
        '    End If

        'Next
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        For i = 1 To grdEgresos.Rows.Count Step 1

            Dim fila = i - 1
            Dim grdFacturas As GridViewRow = grdEgresos.Rows(fila)
            Dim ckbEgreso As CheckBox = grdFacturas.FindControl("ckbEgreso")

            Dim seleccionado = CType(grdEgresos.Rows(fila).FindControl("ckbEgreso"), CheckBox).Checked()

            If ckbEgreso.Checked Then
                Dim idPago = grdEgresos.Rows(fila).Cells(0).Text

                If IsNumeric(grdEgresos.Rows(fila).Cells(7).Text) Then
                    tot += grdEgresos.Rows(fila).Cells(7).Text
                End If


                Dim buscarFechaPago = (From consulta In db.proveedores_pagos
                                    Where consulta.id_pago = idPago
                                    Select consulta).FirstOrDefault()


                If Not buscarFechaPago Is Nothing Then
                    buscarFechaPago.fecha_pago = txbFechaPago.Text
                    buscarFechaPago.referencia = txbReferencia.Text
                    buscarFechaPago.gasto.id_forma_pago = ddlMedioPago.SelectedValue
                    buscarFechaPago.id_cuenta = ddlCuentaBancaria.SelectedValue
                    db.SubmitChanges()
                    lblMensaje.Text = "Listo!"

                End If


            End If
        Next
        grdEgresos.DataBind()
    End Sub

    Protected Sub ddlProveedor_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlProveedor.DataBound
        ddlProveedor.Items.Add(Crear_item("Todos...", 0))
    End Sub
End Class