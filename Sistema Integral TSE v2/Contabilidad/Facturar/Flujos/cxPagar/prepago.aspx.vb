Public Class Pagos
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year()
            ddlEmpresa.Items.Insert(0, New ListItem("Todos...", "0"))
        End If

    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlIva.SelectedIndexChanged
       
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim db As New DataClasses1DataContext()
        If IsNumeric(txbImporte.Text) And Not String.IsNullOrEmpty(txbProPago.Text) Then
            Dim _iva = CDec(txbImporte.Text) * ddlIva.SelectedValue
            Dim importe = txbImporte.Text
            Dim total = _iva + importe
            If String.IsNullOrEmpty(txbIdGasto.Text) Then
                Dim Aceptado = 5

                Dim nuevo_pago As New gasto With {.cantidad = txbImporte.Text,
                                                  .iva = _iva,
                                                    .descripcion = txbDescripcion.Text,
                                                  .id_status = Aceptado,
                                                  .total = total
                                                  }

                Dim comprobante As New comprobantes_fiscale With {.folio = txbFactura.Text,
                                                                  .tipo_comprobante = 1,
                                                                  .gasto = nuevo_pago}

                Dim proveedor As New proveedores_pago With {.id_proveedor = ddlProveedor.SelectedValue,
                                                                    .fecha_programacion_pago = txbProPago.Text,
                                                                    .gasto = nuevo_pago}

                db.gastos.InsertOnSubmit(nuevo_pago)
                db.SubmitChanges()
                lblMensaje.Text = "Se guardó la factura " + txbFactura.Text + "."
            Else

                Dim gasto_seleccionado = (From consulta In db.gastos,
                                          consulta2 In db.proveedores_pagos,
                                          consulta3 In db.comprobantes_fiscales
                               Where consulta.id_gasto = txbIdGasto.Text And
                               consulta.id_gasto = consulta2.id_gasto And
                               consulta2.id_gasto = consulta3.id_gasto
                               Select consulta, consulta2, consulta3).FirstOrDefault()

                gasto_seleccionado.consulta.cantidad = txbImporte.Text
                gasto_seleccionado.consulta.descripcion = txbDescripcion.Text
                gasto_seleccionado.consulta2.fecha_programacion_pago = txbProPago.Text
                gasto_seleccionado.consulta3.folio = txbFactura.Text
                gasto_seleccionado.consulta.iva = _iva
                gasto_seleccionado.consulta.total = total
                gasto_seleccionado.consulta2.id_proveedor = ddlProveedor.SelectedValue


                lblMensaje.Text = "La factura " + txbFactura.Text + " fue modificada con exito."
                db.SubmitChanges()
            End If
            Dim fecha_por_pago As Date = txbProPago.Text

            ddlMes.SelectedValue = fecha_por_pago.Month
            txbAno.Text = fecha_por_pago.Year
            ddlEmpresa.SelectedValue = ddlProveedor.SelectedValue
            consulta()
            limpiar_formulario()
        End If

    End Sub
    Protected Sub limpiar_formulario()
        txbDescripcion.Text = String.Empty
        txbProPago.Text = String.Empty
        txbFactura.Text = String.Empty
        txbImporte.Text = String.Empty
        txbIdGasto.Text = String.Empty
    End Sub

    Protected Sub lnkProveedores_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkProveedores.Click
        Response.Redirect("~/contabilidad/facturar/flujos/Catalogo_Proveedores/NuevoProveedor.aspx")
    End Sub

    Protected Sub ddlProveedor_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlProveedor.SelectedIndexChanged
        lblMensaje.Text = ""
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        consulta()

    End Sub

    Protected Sub consulta()
        lblMensaje.Text = ""
        If ddlMes.SelectedValue <> 0 And IsNumeric(txbAno.Text) Then
            If ddlEmpresa.SelectedValue = 0 Then
                Dim egresos = (From consulta In db.gastos, consulta2 In db.proveedores_pagos, consulta3 In db.comprobantes_fiscales
                              Where consulta2.fecha_programacion_pago.Value.Month = ddlMes.SelectedValue And
                              consulta2.fecha_programacion_pago.Value.Year = txbAno.Text And
                              consulta.id_gasto = consulta3.id_gasto And
                consulta.id_gasto = consulta2.id_gasto
                              Select consulta2.empresa.nombre,
                consulta3.folio,
                              consulta.id_gasto,
                              consulta.cantidad,
                              consulta.iva,
                              total = consulta.cantidad + consulta.iva,
                              consulta.descripcion,
                              consulta.id_status,
                              consulta2.fecha_programacion_pago).OrderByDescending(Function(x) x.fecha_programacion_pago)
                GridView1.DataSource = egresos
                GridView1.DataBind()
            Else
                Dim egresos = (From consulta In db.gastos, consulta2 In db.proveedores_pagos, consulta3 In db.comprobantes_fiscales
                              Where consulta2.fecha_programacion_pago.Value.Month = ddlMes.SelectedValue And
                              consulta2.fecha_programacion_pago.Value.Year = txbAno.Text And
                              consulta2.id_proveedor = ddlEmpresa.SelectedValue And
                consulta.id_gasto = consulta3.id_gasto And
                 consulta.id_gasto = consulta2.id_gasto
                              Select consulta2.empresa.nombre,
                              consulta3.folio,
                              consulta.cantidad,
                              consulta.iva,
                              total = consulta.cantidad + consulta.iva,
                              consulta.id_gasto,
                              consulta.descripcion,
                              consulta.id_status,
                              consulta2.fecha_programacion_pago).OrderByDescending(Function(x) x.fecha_programacion_pago)
                GridView1.DataSource = egresos
                GridView1.DataBind()
            End If

        End If
    End Sub

    Protected Sub ImageButton2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton2.Click
        consulta()

    End Sub

    Protected Sub ImageButton3_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)

    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Dim cell As TableCell = GridView1.Rows(e.RowIndex).Cells(10)
        lblMensaje2.Text = ""
        lblMensaje.Text = ""
        Dim borrar_gasto = (From consulta In db.gastos
                         Where consulta.id_gasto = cell.Text
                         Select consulta).First()
        If Not borrar_gasto Is Nothing Then
            db.gastos.DeleteOnSubmit(borrar_gasto)
            db.SubmitChanges()
        Else
            lblMensaje2.Text = "El egreso ya fue verificado y no puede ser eliminado."
        End If
        
        consulta()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim id_gasto = e.Row.Cells(6).Text
            Dim fue_aprovado = (From consulta In db.gastos
                             Where consulta.id_gasto = id_gasto
                             Select consulta.id_status).FirstOrDefault()

            Dim imagen As Image = CType(e.Row.FindControl("imgAprovado"), Image)

            If fue_aprovado = 5 Then
                imagen.ImageUrl = "~/imagenes/ok.png"
            End If
            If fue_aprovado = 6 Then
                imagen.ImageUrl = "~/imagenes/cancel.png"
            End If

            If fue_aprovado = 0 Then
                imagen.ImageUrl = "~/imagenes/pendiente.png"
            End If
        End If
    End Sub

    Protected Sub GridView1_SelectedIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSelectEventArgs) Handles GridView1.SelectedIndexChanging
        lblMensaje.Text = ""
        Dim row As GridViewRow = GridView1.Rows(e.NewSelectedIndex)
        Dim id_gasto = row.Cells(10).Text


        Dim gasto_seleccionado = (From consulta In db.gastos, consulta2 In db.proveedores_pagos, consulta3 In db.comprobantes_fiscales
                               Where consulta.id_gasto = id_gasto And
                               consulta.id_gasto = consulta2.id_gasto And
                               consulta2.id_gasto = consulta3.id_gasto
                               Select consulta.cantidad,
                               consulta2.fecha_programacion_pago,
                               consulta2.id_proveedor,
                               consulta.descripcion,
                               consulta3.folio).FirstOrDefault()
        If Not gasto_seleccionado Is Nothing Then
            ddlProveedor.SelectedValue = gasto_seleccionado.id_proveedor
            txbDescripcion.Text = gasto_seleccionado.descripcion
            txbFactura.Text = gasto_seleccionado.folio
            txbImporte.Text = gasto_seleccionado.cantidad
            txbProPago.Text = gasto_seleccionado.fecha_programacion_pago
            txbIdGasto.Text = id_gasto
        End If



    End Sub
End Class