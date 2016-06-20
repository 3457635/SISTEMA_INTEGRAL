Public Class cargos
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        If txbIdMovimiento.Text = "" Then
            Dim nuevo_movimiento As New conta_Movimiento With {.cantidad = txbImporte.Text,
                                                               .iva = lblIva.Text,
                                                               .neto = lblTotal.Text,
                                                              .referencia = txbReferencia.Text}
            If txbFechaEjecucion.Text <> "" Then
                Dim aplicar_movimiento As New aplicacion_movimiento With {.fecha_programacion = txbFechaProgramacion.Text,
                                                                          .fecha_ejecucion = txbFechaEjecucion.Text,
                                                                          .id_tipo_movimiento = RadioButtonList1.SelectedValue,
                                                                          .id_cuenta = txbIdcuenta.Text,
                                                                         .conta_Movimiento = nuevo_movimiento,
                                                                          .id_forma_pago = ddlFormaPago.SelectedValue,
                                                                          .descripcion = StrConv(txbDescripcion.Text, VbStrConv.ProperCase)}
                db.aplicacion_movimientos.InsertOnSubmit(aplicar_movimiento)
                db.SubmitChanges()
                lblMensaje.Text = "Se guardó la información."
                GridView1.DataBind()
            Else
                Dim aplicar_movimiento As New aplicacion_movimiento With {.fecha_programacion = txbFechaProgramacion.Text,
                                                                          .id_tipo_movimiento = RadioButtonList1.SelectedValue,
                                                                          .id_cuenta = txbIdcuenta.Text,
                                                                         .conta_Movimiento = nuevo_movimiento,
                                                                          .id_forma_pago = ddlFormaPago.SelectedValue,
                                                                          .descripcion = StrConv(txbDescripcion.Text, VbStrConv.ProperCase)}
                db.aplicacion_movimientos.InsertOnSubmit(aplicar_movimiento)
                db.SubmitChanges()
                lblMensaje.Text = "Se guardó la información."
                GridView1.DataBind()
            End If
        Else
            Dim actualizar_movimiento = (From consulta In db.aplicacion_movimientos
                                      Where consulta.id_movimiento = txbIdMovimiento.Text
                                      Select consulta).First()
            If txbFechaEjecucion.Text <> "" Then
                actualizar_movimiento.fecha_ejecucion = txbFechaEjecucion.Text
            End If
            If txbFechaProgramacion.Text <> "" Then
                actualizar_movimiento.fecha_programacion = txbFechaProgramacion.Text
            End If
            actualizar_movimiento.id_forma_pago = ddlFormaPago.SelectedValue
            actualizar_movimiento.id_cuenta = txbIdcuenta.Text
            actualizar_movimiento.id_tipo_movimiento = RadioButtonList1.SelectedValue
            actualizar_movimiento.conta_Movimiento.cantidad = txbImporte.Text
            actualizar_movimiento.conta_Movimiento.iva = lblIva.Text
            actualizar_movimiento.conta_Movimiento.neto = lblTotal.Text
            actualizar_movimiento.descripcion = txbDescripcion.Text
            db.SubmitChanges()

        End If
    End Sub

    Protected Sub ddlRango1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlRango1.SelectedIndexChanged
        txbIdcuenta.Text = ddlRango1.SelectedValue
        lblCuenta2.Text = ddlRango1.SelectedItem.ToString()
    End Sub

    Protected Sub ddlRango2_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlRango2.SelectedIndexChanged
        txbIdcuenta.Text = ddlRango2.SelectedValue
        lblCuenta2.Text = ddlRango2.SelectedItem.ToString()
    End Sub

    Protected Sub ddlRango3_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlRango3.SelectedIndexChanged
        txbIdcuenta.Text = ddlRango3.SelectedValue
        lblCuenta2.Text = ddlRango3.SelectedItem.ToString()
    End Sub

    Protected Sub ddlIva_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlIva.SelectedIndexChanged
        If txbImporte.Text <> "" Then
            Dim importe = CDec(txbImporte.Text)
            Dim porcentaje_iva = CDec(ddlIva.SelectedValue)
            Dim iva = importe * porcentaje_iva
            lblIva.Text = CStr(iva)
            lblTotal.Text = CStr(iva + importe)
        End If
    End Sub

    Protected Sub DropDownList3_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList3.SelectedIndexChanged

        Dim movimientos = From consulta In db.aplicacion_movimientos
                       Where consulta.id_cuenta = DropDownList3.SelectedValue
                       Select IMPORTE = consulta.conta_Movimiento.cantidad,
                       FECHA_EJECUCION = consulta.fecha_ejecucion,
                       FECHA_PROGRAMACION = consulta.fecha_programacion,
                       MOVIMIENTO = consulta.tipos_movimiento.tipo_movimiento,
                       IVA = consulta.conta_Movimiento.iva,
                       TOTAL = consulta.conta_Movimiento.neto,
                       REFERENCIA = consulta.conta_Movimiento.referencia,
                       FORMA_PAGO = consulta.formas_pago.forma_pago,
                       consulta.id_movimiento,
                       consulta.descripcion
        lblCuenta.Text = DropDownList3.SelectedItem.ToString()
        GridView1.DataSource = movimientos
        GridView1.DataBind()
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        Dim movimientos = From consulta In db.aplicacion_movimientos
                        Where consulta.id_cuenta = DropDownList1.SelectedValue
                        Select IMPORTE = consulta.conta_Movimiento.cantidad,
                        FECHA_EJECUCION = consulta.fecha_ejecucion,
                        FECHA_PROGRAMACION = consulta.fecha_programacion,
                        MOVIMIENTO = consulta.tipos_movimiento.tipo_movimiento,
                        IVA = consulta.conta_Movimiento.iva,
                        TOTAL = consulta.conta_Movimiento.neto,
                        REFERENCIA = consulta.conta_Movimiento.referencia,
                        FORMA_PAGO = consulta.formas_pago.forma_pago,
                        consulta.id_movimiento,
                        consulta.descripcion

        lblCuenta.Text = DropDownList1.SelectedItem.ToString()
        GridView1.DataSource = movimientos
        GridView1.DataBind()
    End Sub
   

    Protected Sub GridView1_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles GridView1.DataBound

    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound


        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim imagen As Image = CType(e.Row.FindControl("Image1"), Image)
            Dim id_movimiento = e.Row.Cells(2).Text

            Dim ejecutado = (From consulta In db.aplicacion_movimientos
                            Where consulta.id_movimiento = id_movimiento
                            Select consulta.fecha_ejecucion).FirstOrDefault()

            If Not ejecutado Is Nothing Then
                imagen.ImageUrl = "~/imagenes/ok.png"
            Else
                imagen.Visible = False
            End If
        End If
    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList2.SelectedIndexChanged

        Dim movimientos = From consulta In db.aplicacion_movimientos
                       Where consulta.id_cuenta = DropDownList2.SelectedValue
                       Select IMPORTE = consulta.conta_Movimiento.cantidad,
                       FECHA_EJECUCION = consulta.fecha_ejecucion,
                       FECHA_PROGRAMACION = consulta.fecha_programacion,
                       MOVIMIENTO = consulta.tipos_movimiento.tipo_movimiento,
                       IVA = consulta.conta_Movimiento.iva,
                       TOTAL = consulta.conta_Movimiento.neto,
                       REFERENCIA = consulta.conta_Movimiento.referencia,
                       FORMA_PAGO = consulta.formas_pago.forma_pago,
                       consulta.id_movimiento,
                       consulta.descripcion
        lblCuenta.Text = DropDownList2.SelectedItem.ToString()
        GridView1.DataSource = movimientos
        GridView1.DataBind()
    End Sub

    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        ModalPopupExtender1.Hide()
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView1.SelectedIndexChanged
        Dim id_movimiento As GridViewRow = GridView1.SelectedRow
        Dim id = id_movimiento.Cells(2).Text
        txbIdMovimiento.Text = id

        Dim movimiento = (From consulta In db.aplicacion_movimientos
                       Where consulta.id_movimiento = id
                       Select consulta).First()

        txbFechaEjecucion.Text = movimiento.fecha_ejecucion.ToString()
        txbFechaProgramacion.Text = movimiento.fecha_programacion
        txbIdcuenta.Text = movimiento.id_cuenta
        txbIdMovimiento.Text = movimiento.id_movimiento
        txbImporte.Text = movimiento.conta_Movimiento.cantidad
        lblIva.Text = movimiento.conta_Movimiento.iva
        lblTotal.Text = movimiento.conta_Movimiento.neto
        txbReferencia.Text = movimiento.conta_Movimiento.referencia
        txbDescripcion.Text = movimiento.descripcion
        ModalPopupExtender1.Show()
        RadioButtonList1.SelectedValue = movimiento.id_tipo_movimiento
        lblCuenta2.Text = lblCuenta.Text
    End Sub
    
    
    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim cell As TableCell
        cell = GridView1.Rows(e.RowIndex).Cells(2)
        Dim id = cell.Text
        Dim eliminar_movimiento = (From consulta In db.aplicacion_movimientos
                                Where consulta.id_movimiento = id
                                Select consulta).First()

        db.aplicacion_movimientos.DeleteOnSubmit(eliminar_movimiento)
        db.SubmitChanges()
        GridView1.DataBind()
    End Sub
End Class